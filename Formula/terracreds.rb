class Terracreds < Formula
  desc "Credential helper for Terraform Automation and Collaboration Software"
  homepage "https://github.com/tonedefdev/terracreds"
  url "https://github.com/tonedefdev/terracreds/archive/refs/tags/v2.1.4.tar.gz"
  sha256 "5541049f60872751ed87674e9871d5bcfd620d399f435853a0b1041a60b92efb"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    ENV["TC_CONFIG_PATH"] = Dir.home
    system "#{bin}/terracreds", "config", "logging", "-p", Dir.home, "--enabled"
    File.exist?("#{Dir.home}/config.yaml")

    Dir.mkdir("#{Dir.home}/.terraform.d")
    system "#{bin}/terracreds", "generate", "--create-cli-config", "--force"
    File.exist?("#{Dir.home}/.terraform.d/plugins/terraform-credentials-terracreds")
  end
end

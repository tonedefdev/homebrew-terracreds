class Terracreds < Formula
  desc "Credential helper for Terraform Automation and Collaboration Software"
  homepage "https://github.com/tonedefdev/terracreds"
  url "https://github.com/tonedefdev/terracreds/archive/refs/tags/v2.1.3.tar.gz"
  sha256 "84857ff1b3e55107c0553be9d1d716bb2a88211c5dd9f8e0fad8060ca018a431"
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

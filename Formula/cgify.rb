class Cgify < Formula
  desc "dead simple HTTP/FCGI to CGI proxy"
  homepage "https://github.com/rushsteve1/cgify/tree/1"
  url "https://github.com/rushsteve1/cgify/archive/refs/tags/1.tar.gz"
  sha256 "2b54302494dddc215565473971337f156b763c8dfe095fdb16cf5898df00b0ea"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    # We expect running it with no arguments to error
    require "open3"
    _, err, status = Open3.capture3 "#{bin}/cgify"
    assert !status.success?
    assert_match(/CGI directory/, err)
  end
end

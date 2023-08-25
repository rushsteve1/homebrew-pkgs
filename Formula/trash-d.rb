class TrashD < Formula
  desc "Near drop-in replacement for rm that uses the trash bin"
  homepage "https://github.com/rushsteve1/trash-d"
  url "https://github.com/rushsteve1/trash-d/archive/refs/tags/19.tar.gz"
  sha256 "9eae6eb35d86e1b388a4495bd32e21bd257fcd02635430f4bb03a134b85ceeff"
  license "MIT"

  depends_on "dub" => :build
  depends_on "ldc" => :build
  depends_on "ronn" => :build

  def install
    system "dub", "build", "--build=release"
    system "strip", "./build/trash"
    bin.install "./build/trash"

    system "ronn --roff --pipe MANUAL.md > trash.1"
    man.mkpath
    man1.install "trash.1"
  end

  test do
    assert_match(/trash-d version #{version}/, shell_output("#{bin}/trash --version"))
    assert_predicate "#{man1}/trash.1", :exist?
  end
end

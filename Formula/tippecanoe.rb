class Tippecanoe < Formula
  desc "Build vector tilesets from collections of GeoJSON features"
  homepage "https://github.com/mapbox/tippecanoe"
  url "https://github.com/mapbox/tippecanoe/archive/1.16.0.tar.gz"
  sha256 "ad048e684889e1d6ff14b8adc551c9bf5161a48cda42d5cda1d37a0b2c7e5a10"

  bottle do
    cellar :any_skip_relocation
    sha256 "07e42528d03884de3afa3318a6ff3ce0743157aa864674c9d50d371c22c4bec0" => :sierra
    sha256 "dc55c01d782ac02aa23bcd889c52cc01eef6255f5a06e30854542b48dd7755b0" => :el_capitan
    sha256 "03cc11b55214b1bcf0fb07f3ba680e5b90c2aa6f198c0e8b0266ff10f1405639" => :yosemite
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.json").write <<-EOS.undent
      {"type":"Feature","properties":{},"geometry":{"type":"Point","coordinates":[0,0]}}
    EOS
    safe_system "#{bin}/tippecanoe", "-o", "test.mbtiles", "test.json"
    assert File.exist?("#{testpath}/test.mbtiles"), "tippecanoe generated no output!"
  end
end

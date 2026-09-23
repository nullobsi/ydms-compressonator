{
	stdenv,
	cmake,
	ninja,
	pkg-config,

	# Project libraries
	glew,
	glm,
	opencv,
	openssl,
}:

stdenv.mkDerivation {
	pname = "compressonator";
	version = "4.5.0";

	src = ../.;

	nativeBuildInputs = [
		cmake
		ninja
		pkg-config
	];

	buildInputs = [
		glew
		glm
		opencv
		openssl
	];
}

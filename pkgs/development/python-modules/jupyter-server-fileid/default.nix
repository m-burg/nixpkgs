{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, hatchling
, jupyter-events
, jupyter-server
, pytest-jupyter
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "jupyter-server-fileid";
  version = "0.8.0";

  disables = pythonOlder "3.7";

  format = "pyproject";

  src = fetchFromGitHub {
    owner = "jupyter-server";
    repo = "jupyter_server_fileid";
    rev = "refs/tags/v${version}";
    hash = "sha256-gJ+OM2b4JrdBObPnltqCWGK3e5p3K2XcoUohej3nDIM=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    jupyter-events
    jupyter-server
  ];

  pythonImportsCheck = [ "jupyter_server_fileid" ];

  checkInputs = [
    pytest-jupyter
    pytestCheckHook
  ];

  preCheck = ''
    export HOME=$TEMPDIR
  '';

  meta = {
    changelog = "https://github.com/jupyter-server/jupyter_server_fileid/blob/${src.rev}/CHANGELOG.md";
    description = "An extension that maintains file IDs for documents in a running Jupyter Server";
    homepage = "https://github.com/jupyter-server/jupyter_server_fileid";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ dotlambda ];
  };
}

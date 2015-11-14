function initializeOverlay() {
	var pref = Components.classes["@mozilla.org/preferences-service;1"].
				getService(Components.interfaces.nsIPrefBranch);

	try {
		folder = pref.getCharPref("extensions.kwallet5.folder");
	} catch(e) {}

	if (folder == "Unknown" ) {
		var appInfo = Components.classes["@mozilla.org/xre/app-info;1"]
                        .getService(Components.interfaces.nsIXULAppInfo);
		pref.setCharPref("extensions.kwallet5.folder", appInfo.name );
	}
}

window.addEventListener("load", initializeOverlay, false);
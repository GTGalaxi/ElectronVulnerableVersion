# Find Electron Apps Vulnerable to CVE-2023-4863 / CVE-2023-5129

This powershell script downloads [Sysinternals Strings](https://learn.microsoft.com/en-us/sysinternals/downloads/strings) and recursively searches the strings of every `.exe` for the Electron version and compares to known patched versions below to determine if vulnerable to [CVE-2023-4863](https://nvd.nist.gov/vuln/detail/CVE-2023-4863) / [CVE-2023-5129](https://nvd.nist.gov/vuln/detail/CVE-2023-5129).

## Vulnerability patched in Electron Versions

### Stable:
* [26.2.4 - Patch Notes](https://releases.electronjs.org/release/v26.2.4)
* [25.8.4 - Patch Notes](https://releases.electronjs.org/release/v25.8.4)
* [24.8.5 - Patch Notes](https://releases.electronjs.org/release/v24.8.5)
* [22.3.25 - Patch Notes](https://releases.electronjs.org/release/v22.3.25)

### Pre Release:
* [27.0.0-beta.8 - Patch Notes](https://releases.electronjs.org/release/v27.0.0-beta.8)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C419D314BFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhBIJpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBIJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:43:29 -0500
Received: from mail-out-1.itc.rwth-aachen.de (mail-out-1.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCBAC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:42:48 -0800 (PST)
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AZDgAeWCJg/5oagoZiHgEBCxIMg2KBT?=
 =?us-ascii?q?iwsaQKEP5EvLQOaXoERA1QLAQEBAQEBAQEBBAQBJwYCBAEBhAdEAoICAiU4EwI?=
 =?us-ascii?q?QAQEGAQEBAQEGBIZSDYZEAQUjBFIQCw4KFRUCAgJVBg0BBwEBgmwBgncPAQ6ua?=
 =?us-ascii?q?H8zhD8BEwMYJkSDLoE0EAkBgS6BU4tmJoFcP4ERJ4JELj6CXQEBAQECgRQSARE?=
 =?us-ascii?q?CATcnAYJXgl8EgkiBDSoBASI2BHBGH5NKiCudYQeBa4EShGOCaoFpkkUFKYMug?=
 =?us-ascii?q?TSJE4U9j3OfX4oah2wihCMCAgICCQIWgWyBCl0MB00kgzgJRxcCDY4IIxeDToJ?=
 =?us-ascii?q?kgjAuhRhBMQINKAIGCgEBAwl8ixcBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AZDgAeWCJg/5oagoZiHgEBCxIMg2KBTiwsaQKEP5EvLQO?=
 =?us-ascii?q?aXoERA1QLAQEBAQEBAQEBBAQBJwYCBAEBhAdEAoICAiU4EwIQAQEGAQEBAQEGB?=
 =?us-ascii?q?IZSDYZEAQUjBFIQCw4KFRUCAgJVBg0BBwEBgmwBgncPAQ6uaH8zhD8BEwMYJkS?=
 =?us-ascii?q?DLoE0EAkBgS6BU4tmJoFcP4ERJ4JELj6CXQEBAQECgRQSARECATcnAYJXgl8Eg?=
 =?us-ascii?q?kiBDSoBASI2BHBGH5NKiCudYQeBa4EShGOCaoFpkkUFKYMugTSJE4U9j3OfX4o?=
 =?us-ascii?q?ah2wihCMCAgICCQIWgWyBCl0MB00kgzgJRxcCDY4IIxeDToJkgjAuhRhBMQINK?=
 =?us-ascii?q?AIGCgEBAwl8ixcBAQ?=
X-IronPort-AV: E=Sophos;i="5.81,164,1610406000"; 
   d="p7s'?scan'208";a="134986474"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
  by mail-in-1.itc.rwth-aachen.de with ESMTP; 09 Feb 2021 10:42:45 +0100
Received: from [IPv6:2a02:908:1089:e060:f569:a95e:5aa7:4e4]
 (2a02:908:1089:e060:f569:a95e:5aa7:4e4) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2044.4; Tue, 9 Feb
 2021 10:42:45 +0100
Subject: Re: [PATCH v2] Use devicetree to determine present cpus (v2)
To:     Stafford Horne <shorne@gmail.com>
CC:     <geert@linux-m68k.org>, <jonas@southpole.se>,
        <stefan.kristiansson@saunalahti.fi>,
        <openrisc@lists.librecores.org>, <linux-kernel@vger.kernel.org>
References: <9dc6c716-c5da-4214-96d8-e088db29d403@rwthex-s2-a.rwth-ad.de>
 <20210208210835.GO2002709@lianli.shorne-pla.net>
From:   Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Message-ID: <f033a204-a907-71b8-dd32-faad9b2df768@rwth-aachen.de>
Date:   Tue, 9 Feb 2021 10:42:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210208210835.GO2002709@lianli.shorne-pla.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha-256; boundary="------------ms010501080505020500070908"
X-Originating-IP: [2a02:908:1089:e060:f569:a95e:5aa7:4e4]
X-ClientProxiedBy: rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms010501080505020500070908
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Stafford,

thanks for cleaning up the patch and for your feedback! I will surely=20
take it into account in the future.

Gruss
Jan

On 08/02/2021 22:08, Stafford Horne wrote:
> Thanks Jan,
>=20
> I was able to take these 2 mails and merge them together to a single pa=
tch.
>=20
> I will send the result for review in a bit.
>=20
> Next time please learn some git/linux kernel developer basics.  It will=

> help make this more smooth inthe future.  THe code changes you made wer=
e great
> and I hope to see more in the future. :)
>=20
> Some tips:
>    - Use 'git rebase -i', and the fixup/squash command to merge two or =
more
>      commits.  Also, there you should add the summary as you did in you=
r mail
>      in the git commit message.
>    - Use 'git format-patch -o patch-dir -v2 <batch-base-commit-id>' to =
create
>      your patch.
>    - Use './scripts/checkpatch.pl patch-dir/<patch-name>.patch' to chec=
k your
>      patch before you send it.  If any issues use 'git rebase' or 'git =
commit
>     --amend' to fix up the checkpatch issues then test and create a new=
 patch.
>    - Use './scripts/get-maintainers.pl' with 'git send-email' like this=
 below.
>=20
> Some links:
>    - https://www.kernel.org/doc/html/latest/process/submitting-patches.=
html
>    - http://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-f=
irst-patch-to-the-linux-kernel-and-responding-to-feedback/
>      (explains --cc-cmd, you can also add --no-rolestats to .get_mainta=
iner.conf`
>    - https://thoughtbot.com/blog/git-interactive-rebase-squash-amend-re=
writing-history
>      (explain rebase squash fixup)
>=20
>=20
> This is usually what I do after testing.
>=20
>      $ git lo   # my custom alias: lo =3D log --pretty=3Dformat:'%C(yel=
low)%cd %C(green)%h %C(blue)%<(16)%aN%Creset %s %C(auto)%d%Creset' --deco=
rate --date=3Dshort -n10
>      2021-02-09 8f722f67452f Jan Henrik Weinstock openrisc: Use devicet=
ree to determine present cpus  (HEAD -> or1k-5.12-updates)
>      2021-01-25 2261352157a9 Stafford Horne   Merge remote-tracking bra=
nch 'openrisc/or1k-5.11-fixes' into or1k-5.12-updates  (shorne/or1k-5.12-=
updates, shorne/for-next, openrisc/for-next, for-next)
>      2021-01-21 3706f9f76a4f Geert Uytterhoeven drivers/soc/litex: Add =
restart handler
>      2021-01-20 031c7a8cd6fc Geert Uytterhoeven openrisc: io: Add missi=
ng __iomem annotation to iounmap()  (shorne/or1k-5.11-fixes, openrisc/or1=
k-5.11-fixes, or1k-5.11-fixes)
>      2021-01-18 803c72c8547c Masahiro Yamada  openrisc: add arch/openri=
sc/Kbuild
>      2021-01-14 4f70d150294b Gabriel Somlo    drivers/soc/litex: make '=
litex_[set|get]_reg()' methods private
>      2021-01-14 51f109228308 Gabriel Somlo    drivers/soc/litex: suppor=
t 32-bit subregisters, 64-bit CPUs
>      2021-01-14 ffa4ebc48971 Gabriel Somlo    drivers/soc/litex: s/LITE=
X_REG_SIZE/LITEX_SUBREG_ALIGN/g
>      2021-01-14 b5d3061ea2e6 Gabriel Somlo    drivers/soc/litex: separa=
te MMIO from subregister offset calculation
>      2021-01-14 9d93a9e8aab3 Gabriel Somlo    drivers/soc/litex: move g=
eneric accessors to litex.h
>=20
>      $ git format-patch -v3 -o patches/ 2261352157a9
>      patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.=
patch
>=20
>      # Below a warning is printed but I think its OK as we can use NR_C=
PUS in smp.c
>      $ ./scripts/checkpatch.pl patches/v3-0001-openrisc-Use-devicetree-=
to-determine-present-cpus.patch
>      WARNING: usage of NR_CPUS is often wrong - consider using cpu_poss=
ible(), num_possible_cpus(), for_each_possible_cpu(), etc
>      #45: FILE: arch/openrisc/kernel/smp.c:73:
>      +               if (cpu_id < NR_CPUS)
>=20
>      total: 0 errors, 1 warnings, 45 lines checked
>=20
>      NOTE: For some of the reported defects, checkpatch may be able to
> 	  mechanically convert to the typical style using --fix or --fix-inpla=
ce.
>=20
>      patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.=
patch has style problems, please review.
>=20
>      NOTE: If any of the errors are false positives, please report
> 	  them to the maintainer, see CHECKPATCH in MAINTAINERS.
>=20
>      $ git send-email --to linux-kernel --cc-cmd ./scripts/get_maintain=
er.pl patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.p=
atch
>      patches/v3-0001-openrisc-Use-devicetree-to-determine-present-cpus.=
patch
>=20
> -Stafford


--------------ms010501080505020500070908
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EHcwggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWsMIIElKADAgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYD
VQQGEwJERTFFMEMGA1UEChM8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRE
Rk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcN
MzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp1xCeOdfZojDbchwFfylf
S2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6WLkDh0YNMZj0cZGnl
m6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mITQ5HjUhfZZkQ
0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUkP7agCwf9
TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22MZD08
WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAd
BgNVHQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK
4OpL4qIMz+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIu
cGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYB
BQUHAQEEgdAwgc0wMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1T
ZXJ2ZXIvT0NTUDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9j
ZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21
rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCNT1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7L
n8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+lgQCXISoKTlslPwQkgZ7nu7YRrQb
tQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v9NsH1VuEGMGpuEvObJAaguS5
Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7EUkp2KgtdRXYShjqFu9V
NCIaE40GMIIFrTCCBJWgAwIBAgIMIShOA5F6a0vPkJFlMA0GCSqGSIb3DQEBCwUAMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRz
Y2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQD
DBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTE5MDYxODExNTIyNVoXDTIyMDYx
NzExNTIyNVowQjELMAkGA1UEBhMCREUxFDASBgNVBAoMC1JXVEggQWFjaGVuMR0wGwYDVQQD
DBRKYW4gSGVucmlrIFdlaW5zdG9jazCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ALqTMZkiwS7HcKorhnCtWkSdYBssMOoeRrqS/U72ixGRWRduFz9hySdkSdM4tQs5b0ZHWZPR
x4Ts/URAtPrJtcYhdGG2zsknDxlweFxKg2tJW3tVLnZw3Y3517ruQG3f09/uzJ8lobaQp9N5
exa1l1vYZbD6cricWaX4k4J8pyPERZ6Ntt70Mse2g2+fb6y2nvEGVqt088dRRgacmd7zrpug
fWgnPYxM3jGU4pJPQzXzPwNrm5i831dCo1HZNNy+iVNjgpZWd3mPKS6eeaPMKbStXTlvvGuu
8u7FpRSHnAB6NwejMIVl26eqdMyYI6F98jPpH1mOHuxxopnspYor3FkCAwEAAaOCAlUwggJR
MD4GA1UdIAQ3MDUwDwYNKwYBBAGBrSGCLAEBBDAQBg4rBgEEAYGtIYIsAQEEBDAQBg4rBgEE
AYGtIYIsAgEEBDAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwHQYDVR0OBBYEFB/z05wtpKDoxT7kc83Swux9Ked/MB8GA1UdIwQY
MBaAFGs6mIv58lOJ2uCtsjIeCR/oqjt0MCcGA1UdEQQgMB6BHGphbi53ZWluc3RvY2tAcnd0
aC1hYWNoZW4uZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5aHR0cDovL2NkcDEucGNhLmRmbi5k
ZS9kZm4tY2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMD+gPaA7hjlodHRwOi8vY2Rw
Mi5wY2EuZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NybC9jYWNybC5jcmwwgdsGCCsG
AQUFBwEBBIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1At
U2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNh
LWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUHMAKGPWh0dHA6Ly9j
ZHAyLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQw
DQYJKoZIhvcNAQELBQADggEBAGGcNvUO+7oXmyLDG8sYt3zyJTC9xvPyVwvCgEnHjwIvnPB2
hqRMpzRqQ3O8vquhuCLcBD20k8EoPEF1fagZQGzrzMJxgCSUnoJpJtv6M0azpPubHh9I9Geb
h8HBM+8IgDCJjMvWQcl3TLfvzXS9e7W3+lx7+L8sNOlxu+cF/IS7IYrEcMNr/4VOVNemX5E2
12rDntadEl+tVqlh42CEM6bMnaWYV0sjj+e3XLvXajaDSohHUwOFX3KtaRfgMbDY0LkergyG
uVPtU5NAzknRB4fh8/Yo6qNsmyEmZ8DpLFBgUwgEbK3NteTTNWvCnPPIMOoHjDNfDaQ+9rMI
CXtOvVkxggQLMIIEBwIBATCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6
dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQ
MA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBD
QQIMIShOA5F6a0vPkJFlMA0GCWCGSAFlAwQCAQUAoIICPTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTAyMDkwOTQyNDRaMC8GCSqGSIb3DQEJBDEiBCDQ
RyQIaGfxQAv7oXwQOeP6J4dnIPllBPxKcvufJKOuKzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGvBgkrBgEEAYI3EAQxgaEwgZ4w
gY0xCzAJBgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMg
RGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsMB0RGTi1QS0kxJTAj
BgNVBAMMHERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0ECDCEoTgORemtLz5CRZTCBsQYL
KoZIhvcNAQkQAgsxgaGggZ4wgY0xCzAJBgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVy
IEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAO
BgNVBAsMB0RGTi1QS0kxJTAjBgNVBAMMHERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0EC
DCEoTgORemtLz5CRZTANBgkqhkiG9w0BAQEFAASCAQCPzr4s1tsdJRNpC++gC92PRTIhoLZr
c6dfuz9eKW8oPLeWvmlzdk7xVFL6uSEnt1cieXxOadGHv7GaywOlOBEYljsKyHLrrtNvqj6l
LRq8oGmIaQ+1vncRg2C6WLVnpQH23dSdqJJtB97cKWSL2E4gZLJPcaASVR6K7s8uoWLacuAt
VhhbiFae9kW6rQFqr2WRzkLKUV3pWRxs9ic8XUtebd5x55OMQQU3suhKwrXIdD5kP88KayCr
m87tWlv+fYI+WdqqEaN2kJ5SpZp+ZBBcjKC1fKQSNXtgQXOJATeG5u0954U+VD8VnP5yQkRo
wrv5c5UNpRTjhWe+68AA1ChKAAAAAAAA
--------------ms010501080505020500070908--

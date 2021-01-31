Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3F309B26
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 09:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhAaIXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 03:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhAaIXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 03:23:20 -0500
Received: from mail-out-1.itc.rwth-aachen.de (mail-out-1.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B72C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 00:22:33 -0800 (PST)
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AeBgB9ZxZg/5oagoZiHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQGCD4FTgXoshSSRKDCcQwsBAQEBAQEBAQEEBAEtAgQBAYRKAoF4AiU?=
 =?us-ascii?q?4EwIQAQEGAQEBAQEGBIZfhXQBBAEjVgULCw40AgICVQYNAQcBAYMiAYJmEQ8Bt?=
 =?us-ascii?q?BSBMoVZgziBNBAJAYEugVOLayaBXD+BOIJyPoRVgwKCYASCQIExgkGTAqV+B4F?=
 =?us-ascii?q?ogRGEYoJqlCUFKYMdkAiPboYrozuICIQjAgICAgkCFoFtgXpNJIM5TxcCDZxrQ?=
 =?us-ascii?q?WkCBgoBAQMJfIsZAQE?=
X-IPAS-Result: =?us-ascii?q?A2AeBgB9ZxZg/5oagoZiHAEBAQEBAQcBARIBAQQEAQGCD4F?=
 =?us-ascii?q?TgXoshSSRKDCcQwsBAQEBAQEBAQEEBAEtAgQBAYRKAoF4AiU4EwIQAQEGAQEBA?=
 =?us-ascii?q?QEGBIZfhXQBBAEjVgULCw40AgICVQYNAQcBAYMiAYJmEQ8BtBSBMoVZgziBNBA?=
 =?us-ascii?q?JAYEugVOLayaBXD+BOIJyPoRVgwKCYASCQIExgkGTAqV+B4FogRGEYoJqlCUFK?=
 =?us-ascii?q?YMdkAiPboYrozuICIQjAgICAgkCFoFtgXpNJIM5TxcCDZxrQWkCBgoBAQMJfIs?=
 =?us-ascii?q?ZAQE?=
X-IronPort-AV: E=Sophos;i="5.79,390,1602540000"; 
   d="p7s'?scan'208";a="133995421"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
  by mail-in-1.itc.rwth-aachen.de with ESMTP; 31 Jan 2021 09:22:32 +0100
Received: from [IPv6:2a02:908:1089:e060:181:40e2:a3a5:20f9]
 (2a02:908:1089:e060:181:40e2:a3a5:20f9) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2044.4; Sun, 31
 Jan 2021 09:22:31 +0100
Subject: Re: [PATCH] openrisc: use device tree to determine present cpus
To:     Stafford Horne <shorne@gmail.com>
CC:     <geert@linux-m68k.org>, <jonas@southpole.se>,
        <stefan.kristiansson@saunalahti.fi>,
        <openrisc@lists.librecores.org>, <linux-kernel@vger.kernel.org>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net>
From:   Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Message-ID: <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
Date:   Sun, 31 Jan 2021 09:22:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210130230310.GC2002709@lianli.shorne-pla.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha-256; boundary="------------ms070109030207040501030002"
X-Originating-IP: [2a02:908:1089:e060:181:40e2:a3a5:20f9]
X-ClientProxiedBy: rwthex-s1-b.rwth-ad.de (2a00:8a60:1:e500::26:153) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms070109030207040501030002
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31/01/2021 00:03, Stafford Horne wrote:

> This looks good, one small comment below.  Can you send the next patch =
as a v2?
>=20
> Using 'git format-patch -v2 ...'

Sorry, was not aware of that, will do better next time!

> Should we warn on the else case?

I think it is fine for the kernel to have room for more CPUs than are=20
actually present (i.e. NR_CPUs > present_cpus is OK). Other Archs do not =

show a warning in this case either, therefore I also omitted it.

Gruss
Jan


--------------ms070109030207040501030002
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
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTAxMzEwODIyMzFaMC8GCSqGSIb3DQEJBDEiBCDY
2trKUyTj75bEkyElfMuAxxyZyZ6jiS71V7bW5KKLSDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGvBgkrBgEEAYI3EAQxgaEwgZ4w
gY0xCzAJBgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMg
RGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsMB0RGTi1QS0kxJTAj
BgNVBAMMHERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0ECDCEoTgORemtLz5CRZTCBsQYL
KoZIhvcNAQkQAgsxgaGggZ4wgY0xCzAJBgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVy
IEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAO
BgNVBAsMB0RGTi1QS0kxJTAjBgNVBAMMHERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0EC
DCEoTgORemtLz5CRZTANBgkqhkiG9w0BAQEFAASCAQCZHxrjiLqxLfi4EOkT40C58rYsQpdL
O5rDlfoNf5vBjYZYB6W7aY1kLdiVFTzCvlFwN5o51HBse2pqbEaocXHqlgO7rRB5yW4/aRTp
2EcbMGMDGahnad8K9b4UX+tjP7IKlQksgVB0ueGnMaCZcpQ5iENJYII2tt4xwbJgeTROB8YY
A+RWb5IQdO7RacInU5KQoyzrcSMikxx1ynZlNl3lq1Sbu/ngExv/grNRtsm2lTSX3QFAcdMu
AKUhpcDav+cyATkmBQppRAA19qyynD019JWJoQfr01s6i9DEcpKPHZ6JPXsWQnoAnHqM+Qlj
hc4L1xrsi4RxRAUptOOpnFtEAAAAAAAA
--------------ms070109030207040501030002--

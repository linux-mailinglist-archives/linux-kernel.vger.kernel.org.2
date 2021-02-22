Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC480321B70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBVPaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:30:11 -0500
Received: from ganymed.uberspace.de ([185.26.156.242]:57918 "EHLO
        ganymed.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhBVP3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:29:02 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2021 10:28:59 EST
Received: (qmail 7082 invoked from network); 22 Feb 2021 15:21:32 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by ganymed.uberspace.de with SMTP; 22 Feb 2021 15:21:32 -0000
Subject: Re: [PATCH] platform/x86: intel-hid: Support Lenovo ThinkPad X1
 Tablet Gen 2
To:     Alban Bedel <albeu@free.fr>, Alex Hung <alex.hung@canonical.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210222141559.3775-1-albeu@free.fr>
From:   Alexander Kobel <a-kobel@a-kobel.de>
Message-ID: <4a58a45c-d67a-cdec-3858-7b50bdf2d4b7@a-kobel.de>
Date:   Mon, 22 Feb 2021 16:21:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222141559.3775-1-albeu@free.fr>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020104050107080502000903"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020104050107080502000903
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

LGTM. Tested on an affected device (20JCS00C00). Works like a charm.


Thanks,
Alex


On 2/22/21 3:15 PM, Alban Bedel wrote:
> Like a few other system the Lenovo ThinkPad X1 Tablet Gen 2 miss the
> HEBC method, which prevent the power button from working. Add a quirk
> to enable the button array on this system family and fix the power
> button.
>=20
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  drivers/platform/x86/intel-hid.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/in=
tel-hid.c
> index 2f5b8d09143e..57cc92891a57 100644
> --- a/drivers/platform/x86/intel-hid.c
> +++ b/drivers/platform/x86/intel-hid.c
> @@ -90,6 +90,13 @@ static const struct dmi_system_id button_array_table=
[] =3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "HP Spectre x2 Detachable"),
>  		},
>  	},
> +	{
> +		.ident =3D "Lenovo ThinkPad X1 Tablet Gen 2",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Tablet Gen 2"),
> +		},
> +	},
>  	{ }
>  };
> =20
>=20


--------------ms020104050107080502000903
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
Ew0wggY9MIIEJaADAgECAgg3B676YzbKKTANBgkqhkiG9w0BAQsFADBSMQswCQYDVQQGEwJE
RTEXMBUGA1UECgwORnJhdW5ob2ZlciBTSVQxKjAoBgNVBAMMIVZvbGtzdmVyc2NobHVlc3Nl
bHVuZyBSb290IENBIEcwMjAeFw0yMDA1MjYxMzIxNDFaFw0zMDA1MjUxMzIxNDFaMFUxCzAJ
BgNVBAYTAkRFMRcwFQYDVQQKDA5GcmF1bmhvZmVyIFNJVDEtMCsGA1UEAwwkVm9sa3N2ZXJz
Y2hsdWVzc2VsdW5nIFByaXZhdGUgQ0EgRzAyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAzW9OcLabPtfz9rbgtyyuNQCQkmI8cPW39VGsXLX1J9EIcUPvp1ysi6kuqMfw+YOC
LjxopSIhpjhH/p84LzmcBJElRPkzWHJreZry+Lu5SDhOcOH49fNEo7UeYE0wkSJNv+jLMWwU
H93dPaSNeRN/5/Peq6tcKTx0FflS2ZScP9OcPvXgp1c/bXYoRyiOGSVR8/+7qlwNuku2px6f
0c6XOKOwkyTeSghmQ8vdfeqcMd9fNUhn/ijWFHahr0LUGB9We6SoxklOz9gfgSCjhInt+4qy
N6bHl/utH/vj1qnuhkaP25h1eCbz2WKqv0wKWwa/r4F0ItLYYP2YhwICTNLDDT8GmctRdt2S
yLmgXo9Gz0nrwrYuGMWcXNLm682Fgg3wQne0DTszFFUU8PrVOtgzB5Qm6DPrRSUHXQEfT7DY
ZzDA+FmSoTSiCe+aoNPbglta4gDar0B/gni15LtCzW4tNhk3fXkYxEWpbq32vNy3wCDOQazc
vxzko5Ior1iDZJNuzurtp5qRjAnOcUiKhNUJeBnmLDB/Di9XZHIQCD0EjiZzef0OR4+ZbPPM
xl6n9KHdrZ2c8r3yjGJtGkeMc0aMkBpvYNDy/s4fYnE5MRIOWdmMnq23/DvCpsQtF5UWZlF9
MaKVcjXmtGpnhpe0XOkFXvxd9PSM0Oe4uei+buhbF7ECAwEAAaOCARIwggEOMBIGA1UdEwEB
/wQIMAYBAf8CAQAwHwYDVR0jBBgwFoAUPnwBB805qJCxODW0j7v1rBeEocAwTQYIKwYBBQUH
AQEEQTA/MD0GCCsGAQUFBzAChjFodHRwOi8vdm9sa3N2ZXJzY2hsdWVzc2VsdW5nLmRlL2Nh
L3Jvb3RjYV9nMDIuY3J0MBQGA1UdIAQNMAswCQYHKyQPCQMBATBDBgNVHR8EPDA6MDigNqA0
hjJodHRwOi8vdm9sa3N2ZXJzY2hsdWVzc2VsdW5nLmRlL2NybC9yb290Y2FfZzAyLmNybDAd
BgNVHQ4EFgQUBNGCAAc5XwIAgrw4HtCXwN3HOwMwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3
DQEBCwUAA4ICAQAPsI1fETAPUfq7LoI2FxRDylRduC/nVhVca7ORxhZXrFmksT/q1jHU4eXK
IhcVms623/FHhcVHl1qB5G/cgU2OtjEP5/BXIRu4I78EZIhb8U3ZGe9gZql/RSOBD08lhmzv
fRz+nwE2Pl9stzXKohjGRWyfFfuaWKLXUZzCK/wYX6IqhTxjkoEFSgejoO41B886rrm3+aaO
5Db5EBW4gYWF9VCV3bmedmTJzbvOOYDxaVT1+O8E9Ym5BZL+qJNjgdjJXE1TUGyUg6ZweNHT
dse6xTc9KhfnAyppkMUu9AKT6jkloA6l0/T3zEMKhvtf9gLYWJ0zMwm1JfQk5mVMZtQoOPYI
Wj7IVUKPZJMizHoaAAIzi7C0w3XpN3xMDJOs5eRsRPk0qF8UulshIUA/6idOrg7eUY4WZGN1
RZsFYyhBg1sPaeFyFAUs0XJUrWLOKO5f9VZGbmEF6gqbTxdwMCJZzonwpUxVwxKLMa+Z4EMG
QoY1rLNPCRZlzhW+TRBsuy4tGN21PlhvcvEnxs8eHvqlwfM/KwYtXhLG8881KMMSzemRvX/c
pNCU2YlHpAwpdm6cAn60leS0WPfTb6QAqmtQTij6uAfFN46hQDLqpfTWnoPSMvbeyFwqP6Fv
V6RgquAIpe9p5daLY9M+Krkd7mH8QR2PN615TboR0ocoF4REdTCCBlwwggREoAMCAQICCBUM
N0NLozG+MA0GCSqGSIb3DQEBCwUAMFUxCzAJBgNVBAYTAkRFMRcwFQYDVQQKDA5GcmF1bmhv
ZmVyIFNJVDEtMCsGA1UEAwwkVm9sa3N2ZXJzY2hsdWVzc2VsdW5nIFByaXZhdGUgQ0EgRzAy
MB4XDTIwMTAxMTE2NTIzN1oXDTIzMTAxMDE2NTIzN1owgYkxGDAWBgNVBAMMD0FMRVhBTkRF
UiBLT0JFTDEOMAwGA1UEBAwFS09CRUwxEjAQBgNVBCoMCUFMRVhBTkRFUjFJMEcGA1UEBRNA
RDQwMDNFMTc4OTlGMTQzMTI2ODExMzM0OUY1N0M1QzU0NEQ5RjcwNDVCQTkyMEJEMzdDQURB
NTQzOEFGQ0EzODCCAaIwDQYJKoZIhvcNAQEBBQADggGPADCCAYoCggGBAM9yNVKr/cuT0WnJ
PLe7kmfd5Wo7rlb1F+harCy3OLgaTqkMI6j37OTXMAmdkZ0y7zrlhbEGCEpODaDPYwVSEb+s
Cv05n3SAMCdy9kQlnqP9We7C/2mbnuKYhpO5P6mUVdPoM+tfTM22YH7CzO8sa1Tq1s/DrIZs
NhXDRvWZEdDwUCjLPKVXGtTqHbUjs7OufxpbyzA7xHE5N7qRff1WrOuq/RS1OvGZVcUjLAmI
loYCvYm1Q3oBYuSZygOsawjmJQ14fh7dKkOjogx6byElWAVBkUQxud8CtBHW+L4VY35uinRJ
k81mwI8ac0zS5FEbYWoF9Gi5pWbCgoIvGXIMcPEQqu8mVBpN/CAMUOUlIkOPDvFqfiQ9TI2C
xnNih8csWwVInRS7m8itJrnlbVfDwdHMJhPT522gCDOC6lXaRUizwGqRh/26W1dJqA2SYmEn
EMH/TcP3eyiFLN5QDXm2odnh+rbvQbwEtlPxup24HGe8RqWFdiCOW1syM+V74lUn5wIDAQAB
o4IBeTCCAXUwHQYDVR0RBBYwFIESYS1rb2JlbEBhLWtvYmVsLmRlMA4GA1UdDwEB/wQEAwIG
wDATBgNVHSUEDDAKBggrBgEFBQcDBDAMBgNVHRMBAf8EAjAAMB8GA1UdIwQYMBaAFATRggAH
OV8CAIK8OB7Ql8DdxzsDMIGCBggrBgEFBQcBAQR2MHQwQAYIKwYBBQUHMAKGNGh0dHA6Ly92
b2xrc3ZlcnNjaGx1ZXNzZWx1bmcuZGUvY2EvcHJpdmF0ZWNhX2cwMi5jcnQwMAYIKwYBBQUH
MAGGJGh0dHA6Ly9vY3NwLnZvbGtzdmVyc2NobHVlc3NlbHVuZy5kZTAUBgNVHSAEDTALMAkG
ByskDwkDAQEwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL3ZvbGtzdmVyc2NobHVlc3NlbHVu
Zy5kZS9jcmwvcHJpdmF0ZWNhX2cwMi5jcmwwHQYDVR0OBBYEFDadSlBdeaipQdbmS4vn439F
6fkNMA0GCSqGSIb3DQEBCwUAA4ICAQBUhcmTTecspwaSgUUlrG/gUPzDLM/Ty0Jpz4GvRbRn
kJxHlHAopkk8P1SXlnOy2kfC5LgFCRB9tJqSlXmIXwphm90fZKRGZU2dBgxGkDQppXGH6PjJ
P52QAhvpztJDPEqfqkzcpKdkYuFg+KEzqZmsu8Mvy4rqCTRIAtOX5zHVFEIarp7YUMNhzGxg
eQakmDjykC1Xksx/ULsX7r5QW5Fqp1ZL5obNmA2emJgn0VrKRIYY8vqnOwUi13G/lDa+fphz
PMhpIKOKQ9Wy0Wn8mBdSdIqmt2L58Pu14ygwOkK3vnb/QKqayhwme2uf4waXG5or3wZdSr39
SvvGZT8Z6cHw6n7Jw0+gRApkB1cUO7j1T/aHCBcZPJ5i6bBoGrT5E8IHIqj+oZXUCY7jxknL
aHaiOARg8fFkf8lp3uy7ay4WcDIorPa9ugNaCP3SnYvtKvk44ulgMIjhvkG1Mga/70SA9Evq
3cFUle3jaaEYujSxLnN8LVm39dR93QCqcdkIayPA9LT6vizlGoA6BdOMWDzKWWnoelYTb+Ip
iqpafot50MCUqf1e2T0z8Ygki1LLOxlpi/DWQApb/Qq9EomeEYMKm0aJc7166pLiWsk1fWOX
kwBa3phG+CbbUxqotGP++r39Dk8Diny+lYjkRXpoqggzF9g9uxARXBIw0H+G6XbgCzCCBmgw
ggRQoAMCAQICCGRFBiAAmYjgMA0GCSqGSIb3DQEBCwUAMFUxCzAJBgNVBAYTAkRFMRcwFQYD
VQQKDA5GcmF1bmhvZmVyIFNJVDEtMCsGA1UEAwwkVm9sa3N2ZXJzY2hsdWVzc2VsdW5nIFBy
aXZhdGUgQ0EgRzAyMB4XDTIwMTAxMTE2NTIyM1oXDTIzMTAxMDE2NTIyM1owgYkxGDAWBgNV
BAMMD0FMRVhBTkRFUiBLT0JFTDEOMAwGA1UEBAwFS09CRUwxEjAQBgNVBCoMCUFMRVhBTkRF
UjFJMEcGA1UEBRNARDQwMDNFMTc4OTlGMTQzMTI2ODExMzM0OUY1N0M1QzU0NEQ5RjcwNDVC
QTkyMEJEMzdDQURBNTQzOEFGQ0EzODCCAaIwDQYJKoZIhvcNAQEBBQADggGPADCCAYoCggGB
AIHe4er7YlQrv+fgKBYbb2FSJLtzoB9s4ZhYgIfQuR1x9+WJvj9EMne5rsHB+OJ5bwZQ1Fnh
qhJhtepikZhLDRVfRbzRdrOSzxnkePhH/SZ9VhtN6327PuSAwxe/te/DPDo6aWZj3d7RoioE
UgkyF5gNWYu082LeSHbvNpDcHUN2Rs7XgZi5uBUnHR1btXA7BOzUMfPhEIqwuCDKLZAGCc0q
2JKhKeOIOsoZ8lP2/HfW3Az1ij6xztb/HfoZnyZMpQC1ly7VgJU5rTLRJz39kscZSBcnxRqP
8cE9rrlPZOgRPK2NR4x+30Sr9sOtnbRYldKWT4uCtqrPrnxNKiDkv3P2h1yKYbCamlqwaoJW
cjrphzLycSGHitalla/f82xHSN+7gJHGp91WYIn+c6jPLcx0wmKUJBB1TIEaeh4izkqLwB0P
1HUBHo50OdmTnRGdnvNt/+Xsc9KetVnmJM2bqXXDlgYMfsULoe6Y0AVemQFvd1V49GePGpGT
NGMe5jf7NwIDAQABo4IBhTCCAYEwHQYDVR0RBBYwFIESYS1rb2JlbEBhLWtvYmVsLmRlMA4G
A1UdDwEB/wQEAwIEMDAfBgNVHSUEGDAWBgorBgEEAYI3CgMEBggrBgEFBQcDBDAMBgNVHRMB
Af8EAjAAMB8GA1UdIwQYMBaAFATRggAHOV8CAIK8OB7Ql8DdxzsDMIGCBggrBgEFBQcBAQR2
MHQwQAYIKwYBBQUHMAKGNGh0dHA6Ly92b2xrc3ZlcnNjaGx1ZXNzZWx1bmcuZGUvY2EvcHJp
dmF0ZWNhX2cwMi5jcnQwMAYIKwYBBQUHMAGGJGh0dHA6Ly9vY3NwLnZvbGtzdmVyc2NobHVl
c3NlbHVuZy5kZTAUBgNVHSAEDTALMAkGByskDwkDAQEwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0
cDovL3ZvbGtzdmVyc2NobHVlc3NlbHVuZy5kZS9jcmwvcHJpdmF0ZWNhX2cwMi5jcmwwHQYD
VR0OBBYEFJiKTcJJSCtBVQS6oS4OSO8QKEWBMA0GCSqGSIb3DQEBCwUAA4ICAQBfdnVpzlnO
JupsJfdYW9xyt3lSky85oA1qPichmW6UjrnIZdunQPJrCTTM+7wUqeqwlhbRmwUKgAPH/5fc
cOnyMulgbvc50VV+mBK4ph/1/fhom7zJYEfvKEpPWg5tGx3/Mp6YIVvuhRnZ7vmodMGXgj/f
1D7yHFJib/430e6pcD76DPaAFA1cVVp5FUP+b0fBzvgYjsgSwL2GTXXaNGEaLqBuhtmInBh/
y4X2ZEz8kw6B2P0GpQ8jg+5I1tNM6vf/KH2FxDj/ykmSsgtyrQAddEjrNQbaQAzXTtHAPui/
6/wbgYfLp05aH7PsLsKGdDS9yb8UaWfWgwFuFz3dLXSdI3YYhXB2QnASX5RV3ndnu9vwGmns
c6iu4C9+h0hFdcWMIEso5K/mV/kXO31xzw7JLU2y5Nk7XEgrXwqFuX4ZruqCfw3EXP1hYnmt
OtfAaSLzTdBS0GskGGnWAs12dJrL8FysZbtX5cgWMyT1nun8ksvSodVgQ+7BA5YHTwfHussP
nPBDabaHmlOUVBi3IYZvoJ90XwuuMvVqcYeEzvuGDrssZHY2pG9DqTeXfzmUdpTfMy7zwu5K
jBPKilDLTXJkrA5wlQpSihjSQG/UPLP+YDsrEuwwBC1DbcSn5KOyMXFpfxsoSegFzb0lxPRc
6sScLr/v96FwvwWpL54Fp9dr0TGCA80wggPJAgEBMGEwVTELMAkGA1UEBhMCREUxFzAVBgNV
BAoMDkZyYXVuaG9mZXIgU0lUMS0wKwYDVQQDDCRWb2xrc3ZlcnNjaGx1ZXNzZWx1bmcgUHJp
dmF0ZSBDQSBHMDICCBUMN0NLozG+MA0GCWCGSAFlAwQCAQUAoIIBvTAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTAyMjIxNTIxMjlaMC8GCSqGSIb3DQEJ
BDEiBCBRbbYcdPkz7mB+OnL381fSDxLMs72VEKO6taFfpKcviTBsBgkqhkiG9w0BCQ8xXzBd
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMHAGCSsGAQQBgjcQBDFj
MGEwVTELMAkGA1UEBhMCREUxFzAVBgNVBAoMDkZyYXVuaG9mZXIgU0lUMS0wKwYDVQQDDCRW
b2xrc3ZlcnNjaGx1ZXNzZWx1bmcgUHJpdmF0ZSBDQSBHMDICCGRFBiAAmYjgMHIGCyqGSIb3
DQEJEAILMWOgYTBVMQswCQYDVQQGEwJERTEXMBUGA1UECgwORnJhdW5ob2ZlciBTSVQxLTAr
BgNVBAMMJFZvbGtzdmVyc2NobHVlc3NlbHVuZyBQcml2YXRlIENBIEcwMgIIZEUGIACZiOAw
DQYJKoZIhvcNAQEBBQAEggGAcGWnJDbTmjtw8OrG1RDUwC59XHBGZk/BsrgxWUHtvPbR8jy5
Qrvcsc+TiA3yMs9w/jAJgx5DRw09a+Zgamm+tQI5oyAFdPBDeo2ZFzlHacaLyMlWcZ+q/qb0
SAQqCu5u0oILFixOfhSY5xT8JQ8CKHNx1h3EtYtlHD3snyTnZ0t1GUu+A3dfr51N2c3fKS+M
ocIsJInAaXa4qzT0VUpc09zbO3TXPQV7Dfl2htOTVddqF+1TS9lMVT/eHJc3WjDubIzpQjKB
fj1C7NCg9bZWv894g3SYCuDMI3BU1a+uECNAPAsJXCSLG+fzqRNCUbR8xSIVnb8RVDjl76Ng
5TLeBrgUdYCeUd5UqBtrmQhEdeezbZHZ21C1Fvya2a5GgCOZfUKWVxuiGXRD/tS9VoDgDRpG
IgEpi3cHXOei2V1jdTNeYKnfC2orsjk15FdQHm1CSKAqW49J1Q7gqikq+Msu1UjbfyTBgTYh
GREVDmKbI4DAoEhZCmeknE5LRT2Vr9EUAAAAAAAA
--------------ms020104050107080502000903--

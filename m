Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1A308C97
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhA2Sbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhA2SbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:31:21 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Jan 2021 10:30:40 PST
Received: from mail-out-4.itc.rwth-aachen.de (mail-out-4.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6153C061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:30:40 -0800 (PST)
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AyBwDFUhRg/5oagoZiHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQGCD4FTgXosY4RAjz6BapxzCwEBAQEBAQEBAQQEAS0CBAEBhkQCJTg?=
 =?us-ascii?q?TAhABAQYBAQEBAQYEhl+GHQSBLwIEWwEMBgIBAYMiAYJ3DwG0WH8zhVmDN4E0E?=
 =?us-ascii?q?AkBgS6BU4wRgVw/gTiDMIdXgmAEgkctYbtRB4FogRGEYYJplB8FKZMdj2YBhiu?=
 =?us-ascii?q?NfZU6h2OERAICAgIJAhaBbYF6TSRcCYJTUBcCDY4tF41rATtBMjcCBgoBAQMJf?=
 =?us-ascii?q?IsZAQE?=
X-IPAS-Result: =?us-ascii?q?A2AyBwDFUhRg/5oagoZiHAEBAQEBAQcBARIBAQQEAQGCD4F?=
 =?us-ascii?q?TgXosY4RAjz6BapxzCwEBAQEBAQEBAQQEAS0CBAEBhkQCJTgTAhABAQYBAQEBA?=
 =?us-ascii?q?QYEhl+GHQSBLwIEWwEMBgIBAYMiAYJ3DwG0WH8zhVmDN4E0EAkBgS6BU4wRgVw?=
 =?us-ascii?q?/gTiDMIdXgmAEgkctYbtRB4FogRGEYYJplB8FKZMdj2YBhiuNfZU6h2OERAICA?=
 =?us-ascii?q?gIJAhaBbYF6TSRcCYJTUBcCDY4tF41rATtBMjcCBgoBAQMJfIsZAQE?=
X-IronPort-AV: E=Sophos;i="5.79,386,1602540000"; 
   d="p7s'?scan'208";a="97061400"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
  by mail-in-4.itc.rwth-aachen.de with ESMTP; 29 Jan 2021 19:29:31 +0100
Received: from [IPv6:2a02:908:1089:e060:8011:c790:74da:da24]
 (2a02:908:1089:e060:8011:c790:74da:da24) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2044.4; Fri, 29
 Jan 2021 19:29:31 +0100
To:     <jonas@southpole.se>, <stefan.kristiansson@saunalahti.fi>,
        <shorne@gmail.com>, <openrisc@lists.librecores.org>,
        <linux-kernel@vger.kernel.org>
From:   Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Subject: [PATCH] openrisc: use device tree to determine present cpus
Message-ID: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
Date:   Fri, 29 Jan 2021 19:29:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha-256; boundary="------------ms090303020207030201040905"
X-Originating-IP: [2a02:908:1089:e060:8011:c790:74da:da24]
X-ClientProxiedBy: rwthex-w3-a.rwth-ad.de (2a00:8a60:1:e500::26:162) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms090303020207030201040905
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

This patch proposes to use the device tree to determine the present cpus =

instead of assuming all CONFIG_NRCPUS are actually present in the system.=


Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
---
  arch/openrisc/kernel/smp.c | 18 +++++++++++++++---
  1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 29c82ef2e..75be7e34f 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -16,6 +16,7 @@
  #include <linux/sched.h>
  #include <linux/sched/mm.h>
  #include <linux/irq.h>
+#include <linux/of.h>
  #include <asm/cpuinfo.h>
  #include <asm/mmu_context.h>
  #include <asm/tlbflush.h>
@@ -68,14 +69,25 @@ void __init smp_init_cpus(void)

  void __init smp_prepare_cpus(unsigned int max_cpus)
  {
-	int i;
+	u32 cpu_id;
+	struct device_node *cpu, *cpus;

  	/*
  	 * Initialise the present map, which describes the set of CPUs
  	 * actually populated at the present time.
  	 */
-	for (i =3D 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
+	cpus =3D of_find_node_by_path("/cpus");
+	for_each_child_of_node(cpus, cpu) {
+		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
+			pr_warn("%s missing reg property", cpu->full_name);
+			continue;
+		}
+
+		if (cpu_id >=3D max_cpus)
+			continue;
+
+		set_cpu_present(cpu_id, true);
+	}
  }

  void __init smp_cpus_done(unsigned int max_cpus)
--=20
2.17.1


--------------ms090303020207030201040905
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
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTAxMjkxODI5MzFaMC8GCSqGSIb3DQEJBDEiBCCJ
/J+uegC4Fys7GAntm0M5LbpkSFcjzqjoFExoQ/SovzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGvBgkrBgEEAYI3EAQxgaEwgZ4w
gY0xCzAJBgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMg
RGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsMB0RGTi1QS0kxJTAj
BgNVBAMMHERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0ECDCEoTgORemtLz5CRZTCBsQYL
KoZIhvcNAQkQAgsxgaGggZ4wgY0xCzAJBgNVBAYTAkRFMUUwQwYDVQQKDDxWZXJlaW4genVy
IEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAO
BgNVBAsMB0RGTi1QS0kxJTAjBgNVBAMMHERGTi1WZXJlaW4gR2xvYmFsIElzc3VpbmcgQ0EC
DCEoTgORemtLz5CRZTANBgkqhkiG9w0BAQEFAASCAQAYMxtyD5w0jQ3mz177XsA3+G4UQRiI
X/0e+V+MRiefiHEjE8PDkJGyuUlbYWqGcBYeaZ6SG5BicbEqQZ6yfSdqrBxjw32iR17aVcNC
yOHUYv/k8dg7ZmAz10JrxEtx+MbgFcUOd8UGLjw556LI91eH1MQzmPzc78I+fRSBWy0OJnwQ
Ez1wlGtgBz+oQeV0tBDALR9bYPKxJOp6d0Tp0uA7BM++QwHVClVNp1MimJJ2wSuG4koQrOez
T0tx4IZuyOUZuFQSjFXqZvdz5aV9rHx850yFh43yyh7RyLA2ReElNK/xns5jGfhUswBO3qYb
rVXMaV5TDfH9Mu651V+WuB4eAAAAAAAA
--------------ms090303020207030201040905--

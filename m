Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0365F457FBC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 18:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbhKTRGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 12:06:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:39711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237712AbhKTRGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 12:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637427804;
        bh=jqg5KnDbZrhU+wh2iW2KbQSz2qpcxkLYaNMaQYhVGl0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GDQd9BJzlEmiixk25GbUFaHNIuwI0f8UgP8TMxid7t/57i4vpX7LfUG0M3x9TcYXL
         mHfl4E0fb7Y95uXdF2vFEk+cdpwYW+AaGbZUU6ziZmpwPTHAnJwj44URTTDwDaIDKi
         wDmFYMO8M3+VMP40mLkqt7dpxKHkYXZFdRCRaaWI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M6Udt-1mhc8r2flZ-006zdS; Sat, 20 Nov 2021 18:03:24 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (dell-smm) Simplify ioctl handler
Date:   Sat, 20 Nov 2021 18:03:18 +0100
Message-Id: <20211120170319.72369-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211120170319.72369-1-W_Armin@gmx.de>
References: <20211120170319.72369-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9cLnUEH3NfDDMIeHzJ49/OHTyXcgKydI3aE7EzOsqe5PIXongGc
 hu50ukvDmAuYB7I1LRQM6B0mDRa0idvcYW2V5ADjmiOosVFeoB/SYKXY0JSBr5DavB61dXv
 UchKIFP0Gk8Eff6U+9NrCm43zUviP0C+v0RF4u2aYB2+q7e1d3a8MOpO7B3fsSOnkyN5bQH
 sRS99hPKqHJeW1mEwr+Ig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jB4ESiC6iG8=:h+/wUIHs+q2dadH3nk4ifq
 OSyOoYMBw7GyNjNxeglYBPympOVMMArhZQYkvjRw2Qh8SyZob8XFRUTLzb+UKnr11qNmKeFAK
 ucaAawbdmFYY5I2y/zL7hOS0LadFRrYWPPhqQr0Utif17ZdM/nPI5cFe+T8WzoRASWLFbqkxJ
 FYBXopv9yEdgE100k6zE+Vw5vMfj/nhncP0XNYDmpNb61gItoEdOwf38VsPSkaZxSh/ZCuLhe
 YoBnDAFReQAEX6ziIPBHCIyFydvQn/8C0yJN1erKLypypRNGnabLM7dyFfOtZS7u1QxivOJ/w
 fvCbBAFOTso9Amrhg5frUHKLKIdtK4jh8/hnnCA0aa6DifdKpPHdjVWXIGmEvyvYWp8C1d99a
 OxcEqcJVdxTDVXCT6SPSSGdqhO2TBVOEP2vPmuaPikQtJ3CDAnNvyXgArw6QbJnusg2/7PxV4
 R6BaLXJGt04DoviyvvekufK/Aj72NGhwnPWw4hPLtgQQyqKnM71Wu1ZAO/A5cVgbE9JM+pref
 nvv9XLg6xbDgn7l0wwtOVLW5+iK4MYB8qSKx12DT00aKStoe+BCvTES/WndtlVL/UWVPIPdJF
 NiLCW5JeBVuNaZacThVdq7x1/Of0L51zEIqcI89BmRDxrkDtqBPZo+Hjdg6obVKJOqRCPosIw
 nuuC6OOwjKszn5dyFr+fVA3q82zowEZHS96Be9kGp3hVY54zar7mQqSarpGhLxhiZllEI5+mx
 Ff1lpu5pjbVvDDX0inDUZNGHRtSvFwC3Y+0sezzyGuQMet9ox9Y40l40VyG6HaDGizoQ46Vv3
 cssvGai0k+Eu7iOYRXa6uvUYisJ7omQRcwLeV+615D6C84GdfeMrgzGAIkYCYpSQax9aQW+xQ
 sysnL3uzzY5H/1/ZknRDraziBgY6fVGCvc/zJ2PN64oC6oOcS1uhwOyEaDcBMuxzrWTDT/Mw4
 Iaqb4pEuT3IIjJkxGxnv5yRAa0Fn4Gpn5YycVexSk7tGPRTx+/YFegRGup1dWh+RhsIsS0Iec
 EBBfgrt0NTDQEZCYMTnBJiv5pGUevk0Ykv5YqyNp3+I11vq6NpRbpj2h9GDfWo1CelwHxDPfU
 onz60r2yLIfBgw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second switch-case has no real purpose:

- for I8K_BIOS_VERSION, val does not represent a return value,
  making the check for error values unnecessary.
- for I8K_MACHINE_ID, val remains zero, so the error check is
  unnecessary too.

Remove the switch-case and move the calls to copy_to_user()
into the first switch-case for I8K_BIOS_VERSION/_MACHINE_ID.
Omit buff[] since data->machineid already contains the string
with the necessary zero padding.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 5596c211f38d..b5d1703faa62 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -454,7 +454,6 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_da=
ta *data, unsigned int cmd
 {
 	int val =3D 0;
 	int speed, err;
-	unsigned char buff[16];
 	int __user *argp =3D (int __user *)arg;

 	if (!argp)
@@ -468,15 +467,19 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_=
data *data, unsigned int cmd

 		val =3D (data->bios_version[0] << 16) |
 				(data->bios_version[1] << 8) | data->bios_version[2];
-		break;

+		if (copy_to_user(argp, &val, 4))
+			return -EFAULT;
+
+		return 0;
 	case I8K_MACHINE_ID:
 		if (restricted && !capable(CAP_SYS_ADMIN))
 			return -EPERM;

-		strscpy_pad(buff, data->bios_machineid, sizeof(buff));
-		break;
+		if (copy_to_user(argp, data->bios_machineid, 16))
+			return -EFAULT;

+		return 0;
 	case I8K_FN_STATUS:
 		val =3D i8k_get_fn_status();
 		break;
@@ -527,23 +530,8 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_d=
ata *data, unsigned int cmd
 	if (val < 0)
 		return val;

-	switch (cmd) {
-	case I8K_BIOS_VERSION:
-		if (copy_to_user(argp, &val, 4))
-			return -EFAULT;
-
-		break;
-	case I8K_MACHINE_ID:
-		if (copy_to_user(argp, buff, 16))
-			return -EFAULT;
-
-		break;
-	default:
-		if (copy_to_user(argp, &val, sizeof(int)))
-			return -EFAULT;
-
-		break;
-	}
+	if (copy_to_user(argp, &val, sizeof(int)))
+		return -EFAULT;

 	return 0;
 }
=2D-
2.30.2


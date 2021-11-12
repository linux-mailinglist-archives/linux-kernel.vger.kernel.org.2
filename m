Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D872744EBE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbhKLRSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:18:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:44971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232231AbhKLRSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636737301;
        bh=MZ363rMRSqRUdK0/qpqwdKf6bxWGSwN74W9qht5ajv0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=SLVxbFmdEmIDjmzXIRvD9ri1OEHCthsBqJjeV26VJrK/7PQdJr87Navfil79UTfuV
         HAy+HftHu8pRGunoJ8sdgIaKS02mvIvlMrs5Q4Cf+Z6tRHWcKi3XCXXTKNNHyA6PQN
         pCSnxrjhaNINvbT74jsGKsNrasYDAYo0seYyAjro=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N6KUT-1mfBD20SMr-016fZz; Fri, 12 Nov 2021 18:15:01 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Fix warning on /proc/i8k creation error
Date:   Fri, 12 Nov 2021 18:14:40 +0100
Message-Id: <20211112171440.59006-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QgNiOy+2jGMU9r9h4A3/SOjITJzN2C3bPjxgXvqu6p0yvSQeACz
 xzswKTJgSnV0PLNXO+Afnl+H8fOqE+xqWDfu0GiAp7A4d9a3NmfcgweRlGOqRZ97PFJHz4O
 DjUf0mIhp5RZcpfi9bOOZ9U0S1i49J2K/bdStRTbBasvoy/UJDuoixv+O29dSiKVCEVTFnR
 VC2v5cuG9uYLDUdYjZwmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qx5t+mc0wDo=:pkqOcZVCC4X3lAH3cwLX4/
 iR0raD0aXa1IOhvZ4E7Ob0awpb0IpPTPQ03u/fncOt9YutfcA204UayeohGkODWtUkLR2n7YI
 IDokPvDVywXchIalAwCup/x/yjILpSxBBaHsiVD0QMKTtG1lzn6e51/hPHPatsibIn29Aj4eX
 2W+foxpdiQNHZe2d/pupvgWVJKgH6Yuz4HOoNszGFpN7YaaHaTmjGQzBQiPRhOEmkZy/5TbXu
 XR1VKZl+DKCTeyJlrRbTaw/yjjq5WxdqJuikoKQQePUsmeyNcpSVWvZDK6m80jJ6raO8wc9bw
 XKvEuopfRJPpzbnABI6pT9homKWhGQHETEu74t0oyGezbD+ha90+6KyQflvGaJFqlNtpczu4/
 TVJP6Q8E0L00IHMXaoMh7WTJIvzeZpCP0oW/FCUgg9nzmYRJL43Nj2WWuVk/URWxr7P7u7dda
 PrPYR5wTfIImTQIVudC3DNIUncwAxNkJfcMDCBYkB14vl8T4IfbeQDDmP+ho09ISjbAsAoLCY
 wEDb3UjMtcvWQ9nyaFdxDRdPonuWBSdMIXWtP5PfM+pUKCPwLlpHlR3eOz7sycyEvEkUTUJRS
 bYWenMVEISvDhpDRMmMk2Rgn7Q02SF86Bub7fRCZpWGS5NjGhy+UkM7fq7VriKo5+bmGpmKXY
 KIScWAK2x3JSMt3vGceF1O9rXjz6bun2y+7Z4Tzk1TmiViHDKpk+NJL9fph43hVIwcHQmMKec
 GXyNrTtNGK98SO+bU6AIJFo+1ZuvjDqRqmkwTkwUx46b7NL2sLJscbv5xhXA1DO3SlomP4BS9
 fLtGXZkdHshVaxx2wBBj6d7jBLVIBj9ayA/g+DEL3D+70PhiXc/z4759CCNp+2ba3JdycYoH5
 aEQgQpaZMYbGs96peNHgIRb+n1/e1Oel89doufWmbpsghMgS2gmj5atGJE8irAMnxCzSvT9Lw
 25e02UpvEmEC8nu+x1kB4uTYaAZrRw8iZo/txAdpKgOBZwg6y7uouQd21gr3J8H92c/LgWbyb
 nxNzM0Yder7AMBCwtg+LKLy6Sz3kNgDiYFZpiBklaVajYM14p/c+STd7pkh48y+L/0rr4h3iI
 LwkK4FttgDv6WQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removal function is called regardless of whether
/proc/i8k was created successfully or not, the later
causing a WARN() on module removal.
Fix that by only registering the removal function
if /proc/i8k was created successfully.

Tested on a Inspiron 3505.

Fixes: 039ae58503f3 ("hwmon: Allow to compile dell-smm-hwmon driver withou=
t /proc/i8k")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index eaace478f508..5596c211f38d 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -627,10 +627,9 @@ static void __init i8k_init_procfs(struct device *dev=
)
 {
 	struct dell_smm_data *data =3D dev_get_drvdata(dev);

-	/* Register the proc entry */
-	proc_create_data("i8k", 0, NULL, &i8k_proc_ops, data);
-
-	devm_add_action_or_reset(dev, i8k_exit_procfs, NULL);
+	/* Only register exit function if creation was successful */
+	if (proc_create_data("i8k", 0, NULL, &i8k_proc_ops, data))
+		devm_add_action_or_reset(dev, i8k_exit_procfs, NULL);
 }

 #else
=2D-
2.30.2


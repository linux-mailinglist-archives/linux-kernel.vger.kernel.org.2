Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A32A377DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhEJIOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:14:10 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37629 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhEJIOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:14:08 -0400
Received: by mail-lf1-f42.google.com with SMTP id 2so22075269lft.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oWi094l00wHZzcXE8XAoeIkUv25p3UjRAPAyjvkoWcU=;
        b=HlV5n2n+p0nNAhlWzAFKWsADHab2lMG/f1uFGgyvJyZA+9p9FZHkjaRg7vHIpcWKul
         49A3eY+pibaFmXymeNW821ow8yV/f998/8zXsNZmt/mneFQ7oCIH0DKhvD8S+6pPdPjN
         wiaLk3zK4Wm4Mv6ragbOIspLteLkfF5dYcSEZD4u6xelY91ISeImyBuMRlrGVYmZZsxx
         z3bYNJhZYA4RzUb/HiEfHsvrz+QSInbW7wSwh7nUtv2mCaQRz26nnuPpcK47s1TA5tqC
         PoJb5tfwh5278520nir3oeh99RZAVmxPuSchTqbv9MZN/Vc+Jssl2FPmPuNWYmgUfBqR
         m6Cg==
X-Gm-Message-State: AOAM531WPxEHUWMEJ2p90KDkyv9Q369DRqkKwSynQ11UytNI2hM7uFEX
        3m6n+nCZO4Dj8bEHuJa36Js=
X-Google-Smtp-Source: ABdhPJw1P32SmE9X0WS4074LM39xwieu7kEuGJnwpVPGlzIYUyL1uQOkRPRH5NxixAZoHVAZImOSoQ==
X-Received: by 2002:ac2:4211:: with SMTP id y17mr15264745lfh.607.1620634381951;
        Mon, 10 May 2021 01:13:01 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id q2sm3139369ljc.130.2021.05.10.01.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 01:13:01 -0700 (PDT)
Date:   Mon, 10 May 2021 11:12:55 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] extcon: extcon-max8997: Fix IRQ freeing at error path
Message-ID: <9047a741b4c4d97e721ed8b48cc4b434a46acba3.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If reading MAX8997_MUIC_REG_STATUS1 fails at probe the driver exits
without freeing the requested IRQs.

Simplify driver and fix the IRQ problem by switching to use the
resource managed IRQ requesting and resource managed work-queue
initialization.

Fixes: 3e34c8198960 ("extcon: max8997: Avoid forcing UART path on drive pro=
be")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Please note that the change is compile-tested only. All proper testing is
highly appreciated.
---
 drivers/extcon/extcon-max8997.c | 45 +++++++++++----------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max899=
7.c
index e1408075ef7d..bbc592823570 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -5,6 +5,7 @@
 //  Copyright (C) 2012 Samsung Electronics
 //  Donggeun Kim <dg77.kim@samsung.com>
=20
+#include <linux/devm-helpers.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -650,27 +651,30 @@ static int max8997_muic_probe(struct platform_device =
*pdev)
 	mutex_init(&info->mutex);
=20
 	INIT_WORK(&info->irq_work, max8997_muic_irq_work);
+	ret =3D devm_work_autocancel(&pdev->dev, &info->irq_work,
+				   max8997_muic_irq_work);
+	if (ret)
+		return ret;
=20
 	for (i =3D 0; i < ARRAY_SIZE(muic_irqs); i++) {
 		struct max8997_muic_irq *muic_irq =3D &muic_irqs[i];
 		unsigned int virq =3D 0;
=20
 		virq =3D irq_create_mapping(max8997->irq_domain, muic_irq->irq);
-		if (!virq) {
-			ret =3D -EINVAL;
-			goto err_irq;
-		}
+		if (!virq)
+			return -EINVAL;
+
 		muic_irq->virq =3D virq;
=20
-		ret =3D request_threaded_irq(virq, NULL,
-				max8997_muic_irq_handler,
-				IRQF_NO_SUSPEND,
-				muic_irq->name, info);
+		ret =3D devm_request_threaded_irq(&pdev->dev, virq, NULL,
+						max8997_muic_irq_handler,
+						IRQF_NO_SUSPEND,
+						muic_irq->name, info);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"failed: irq request (IRQ: %d, error :%d)\n",
 				muic_irq->irq, ret);
-			goto err_irq;
+			return ret;
 		}
 	}
=20
@@ -678,14 +682,13 @@ static int max8997_muic_probe(struct platform_device =
*pdev)
 	info->edev =3D devm_extcon_dev_allocate(&pdev->dev, max8997_extcon_cable);
 	if (IS_ERR(info->edev)) {
 		dev_err(&pdev->dev, "failed to allocate memory for extcon\n");
-		ret =3D PTR_ERR(info->edev);
-		goto err_irq;
+		return PTR_ERR(info->edev);
 	}
=20
 	ret =3D devm_extcon_dev_register(&pdev->dev, info->edev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register extcon device\n");
-		goto err_irq;
+		return ret;
 	}
=20
 	if (pdata && pdata->muic_pdata) {
@@ -756,23 +759,6 @@ static int max8997_muic_probe(struct platform_device *=
pdev)
 			delay_jiffies);
=20
 	return 0;
-
-err_irq:
-	while (--i >=3D 0)
-		free_irq(muic_irqs[i].virq, info);
-	return ret;
-}
-
-static int max8997_muic_remove(struct platform_device *pdev)
-{
-	struct max8997_muic_info *info =3D platform_get_drvdata(pdev);
-	int i;
-
-	for (i =3D 0; i < ARRAY_SIZE(muic_irqs); i++)
-		free_irq(muic_irqs[i].virq, info);
-	cancel_work_sync(&info->irq_work);
-
-	return 0;
 }
=20
 static struct platform_driver max8997_muic_driver =3D {
@@ -780,7 +766,6 @@ static struct platform_driver max8997_muic_driver =3D {
 		.name	=3D DEV_NAME,
 	},
 	.probe		=3D max8997_muic_probe,
-	.remove		=3D max8997_muic_remove,
 };
=20
 module_platform_driver(max8997_muic_driver);
--=20
2.25.4


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCY6wcACgkQeFA3/03a
ocVJtAf+IWGJ9a3qPjHbA/lLjG8/Pos5wrKEOr3h/JZ3uRzRUytIulxg23RImBVh
k1xhCv/bKQD0dkjmSwxQ/e2lyEC/XsdxF3kV9w/6oGUQrS9YIe6IYqBISwnuyqQn
u0wLYiwLYPE3+vCEWFlajNQ40/wUbrYQSPUWdVWaRFoGmXfmpklHLrahZDKuO1JM
e6FdOqI5hfKngSXiK9QULEl4MFBOrb4rOqdVPOyGMi9+2CGmOwT9+x9oDD/CYkTI
4w2kPEUJSwG+TkS2PZrhZD5yvISeS90gApdtTq6h7VkWXEKB/Y2LrE647SO4MnZr
XECoMLMjhhclzWZXpbSvKriSdqoP5g==
=QIdA
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

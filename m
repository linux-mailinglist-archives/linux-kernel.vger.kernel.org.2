Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEFD3878D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349228AbhERMe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:34:56 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:44712 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349234AbhERMen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:34:43 -0400
Received: by mail-lj1-f171.google.com with SMTP id s25so11318056ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWkTP1cr2Ku8LoWJvIbLMC3oX0w3rZYrMGUH4ZNiEPM=;
        b=NnYRPGu55w8+zJP5ir9Sc+1BrUq03u8MEiE6NTyGhYBlPUuLqVABuR0F0+vdPEIZXy
         z42A+xH0UeKWvNE1RhcecDvQwUT9cRVPKOMFQb9NNsj7MXgYmA2RfgyW/YVNL+frkWqS
         BpXsD1zxphmLKc3wOYxYgw1EsokpehBG0DtcCxBb5vfuI4czw0jY/r+s5vNN8+E77Ey/
         HBPQGYdXOX7eVI8Usj5xslPlxGsxyga/V1WQ36jTxnipS3EU/IEU1RPMfJFHICPhg6uo
         0s/3dQPTveS+kseneba3pqqKmF0BucT3bBby7pRT0n7jF+TJxiGrMVj7Oi9Jg8Uvyjhl
         CGgg==
X-Gm-Message-State: AOAM530b+7e9IGu4iQhTY5NyNQXMq+2YheUNqmM6lo5s7qpFRW8s0b4h
        0bW7caMxUBBtXibkA4zQV2g=
X-Google-Smtp-Source: ABdhPJwjc6cBMKV+vsPam/05B0RTWeEV6jlDLVvfJ5BV+09AxhZxlhRwLdIs+Sn482Xi1KO2Nqu+NA==
X-Received: by 2002:a05:651c:102e:: with SMTP id w14mr4027334ljm.238.1621341204433;
        Tue, 18 May 2021 05:33:24 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::1])
        by smtp.gmail.com with ESMTPSA id o20sm2272621lfu.283.2021.05.18.05.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:33:23 -0700 (PDT)
Date:   Tue, 18 May 2021 15:33:17 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     hanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] extcon: extcon-max8997: Simplify driver using devm
Message-ID: <2bb395c1d6547a6597d72de21dbb9687926de713.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify driver by switching to use the resource managed IRQ
requesting and resource managed work-queue initialization.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Changelog:
 v2:
  - IRQ freeing fix splitted in own patch

Please note that the change is compile-tested only. All proper testing is
highly appreciated.
---
 drivers/extcon/extcon-max8997.c | 47 +++++++++++----------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max899=
7.c
index c15a612067af..bbc592823570 100644
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
@@ -733,7 +736,7 @@ static int max8997_muic_probe(struct platform_device *p=
dev)
 				2, info->status);
 	if (ret) {
 		dev_err(info->dev, "failed to read MUIC register\n");
-		goto err_irq;
+		return ret;
 	}
 	cable_type =3D max8997_muic_get_cable_type(info,
 					   MAX8997_CABLE_GROUP_ADC, &attached);
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

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCjtA0ACgkQeFA3/03a
ocVBpwgAlz3FbUV0q8lDKXuvmXGZULbUBiGzQMxNkTQwMnVZShgDAJrTHDGWsdzx
to2PWFTQkipI6JeaqGILSm+nIQBQlKVKmeLq3XtQiLd0FIPnPMjjDfA62A0b/CJe
/OH9TBzUpvWIV6z2iuLegcwWC4lwrPEYbpvdTkaS+PQXEpiacl6y633sLCB8bpVn
imkz/wvVdYDrncbTQ8IxQEpkxQ5igYhgI6Mf3h6ZE7tn3twI/q6MJoukiF/qPReU
o5evoixidk+IMlUxWbLuiGIuYJopt+xisPzEeLqQkEKiyq8KTt9lT/C7nmduwtPM
lcX1SLM3FXQCu37/TZlBDNSkU1KKyg==
=IvHS
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

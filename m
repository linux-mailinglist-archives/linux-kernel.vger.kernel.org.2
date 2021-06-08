Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A2939F33F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFHKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:13:09 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:43876 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFHKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:13:08 -0400
Received: by mail-lf1-f46.google.com with SMTP id n12so24189477lft.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k2qekH5QTUHRb0WCkg2bw3O8D9nzGSmJhMHj73OkHtI=;
        b=nkreThliFDDX89hzlW5RymM7iqUee6FIMDRnDTcRsOIARz+tEe1ZFk3AiNLsn+ZTHQ
         D4MwwQcc5b53yNKnPYFbQPtQzVxJFYDcGXddq+wKYfSYSBRolypX+1I+L95Q9vOpQ+Vy
         K1wmTfPq5p2AL18IS3OiUZfHRMyJMU0asmTvJchXB4hm6h5k9BrRdQWDlLwwNDaPZMwL
         Gwmls2mqZJ4YQIi0BBFNCtRDRSN4QwchjPA36kxDvGHTAJSt9K2+ea0PCOQankJlPw1C
         y01osXb05ZAZJd7JHRSYpm9DBkNhx6kZucZWuMHupBCP10tEIXxUwuvlzSWCx+Z0n4wl
         Ligw==
X-Gm-Message-State: AOAM533EUdvCTYAiR7J6RaejvScl+EaiipOkXOAHQDa8JSqUF4+STPFh
        1vzBhx/FIEP4Mg+gUM99RZE=
X-Google-Smtp-Source: ABdhPJxcfUBILHI+9NWE25zIcBvd9Bgz13XJbw76JMDot6+IA4VSJa0Mw0uP2jtS6iKZRbOP4BoUcw==
X-Received: by 2002:a05:6512:3483:: with SMTP id v3mr15317442lfr.154.1623147059639;
        Tue, 08 Jun 2021 03:10:59 -0700 (PDT)
Received: from dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id v18sm1002591ljg.114.2021.06.08.03.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:10:59 -0700 (PDT)
Date:   Tue, 8 Jun 2021 13:10:53 +0300
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
Subject: [PATCH RESEND v2 5/5] extcon: extcon-max8997: Simplify driver using
 devm
Message-ID: <61190cc280a63baeb05ec570282bb3677bee8e7b.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simplify driver by switching to use the resource managed IRQ
requesting and resource managed work-queue initialization.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmC/Qi0ACgkQeFA3/03a
ocWI9wf/ZW0SWoI8ANKOCJm+dxWQ7PaDLyL8ZDhpZD3l1yQjg4MzwM1WbsNQC67j
ggY6LPDxyjrN8nYV/zKDJaf+7ECOwIvhuDkcqaug57BnN6wF/QzNewB3PyGXlIXr
iZIUYLMh+zjzX9AWVmrtPC3lH9u7AcO3FtDrbSgH3mkboAD2NTqT3vtQ4pMnx6a0
dMG7Kq3jGBEmR3hjlMZOZEv/67JIuL7mSaUdtndIXcj6/a2q/TU+cEwaIju3l+FW
zmh1RHtZmvjju/xWbGw9A9WEVxAEPSArd33vQNaRY9rfotuFdR4EJ8rPKIhwA4fm
A9vSEGlFQe5AE+vN7WeefgLiowxRDg==
=MRTK
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

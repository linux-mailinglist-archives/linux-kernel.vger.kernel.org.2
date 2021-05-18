Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26FB3878CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349153AbhERMeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:34:17 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:38827 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349157AbhERMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:34:06 -0400
Received: by mail-lj1-f177.google.com with SMTP id v6so11344256ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WwomKCF2ZeZdbaxZEasouyBJ8G0TJ9mMzwRv8xUrT7Q=;
        b=WNWmoFH2P2OOXgzYw8HG90dd9wnQPAAO6oBaR2HPdnPRoEh/PEhy/BvnwniUTigeVK
         YQFRz0ehrnsl3Yz/GJP/ub8uIjl2z7N3R0000+0fcMS/dIjBorTd85aq0XWs478OJ8gQ
         CMIW84Ma9GS5pCu/5WcDRh4uKZnmgksCtXzL74neCtVvTS0qhLrMQzb1Ab1/qcqKEj7P
         TogEY9k/mOidcU6LRMEfmSZK+1WvLmLtGJiaegmvfT4bsp9EgLYGvvI/HUPSE284E4y+
         o8H9lrUCI/ncOL3cKpwMd2GR3ZpKudiHRls0rJto/+Tks+oRSEYv7dhq4r0a5pJls9xt
         J52g==
X-Gm-Message-State: AOAM5332UdVnCMqvEAeFuPfa7X9ULxeQTdANPbwC7Y4SsNhIeSKGFiol
        1tzfQ3LdGNFpLfnenclUrqs=
X-Google-Smtp-Source: ABdhPJwJ7H3J3X0lpM/Ic53CKt1d8aAqov4F7UY858oSysAK9QXW08E5cga56+FQXM/7db9S+54nWQ==
X-Received: by 2002:a05:651c:1a7:: with SMTP id c7mr3839221ljn.77.1621341167873;
        Tue, 18 May 2021 05:32:47 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::1])
        by smtp.gmail.com with ESMTPSA id j1sm2284221lfb.142.2021.05.18.05.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:32:47 -0700 (PDT)
Date:   Tue, 18 May 2021 15:32:41 +0300
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
Subject: [PATCH v2 3/5] extcon: extcon-max77693.c: Fix potential work-queue
 cancellation race
Message-ID: <a3806bcb28f4c913539086d1886386b4babefc38.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The extcon IRQ schedules a work item. IRQ is requested using devm while
WQ is cancelld at remove(). This mixing of devm and manual unwinding has
potential case where the WQ has been emptied (.remove() was ran) but
devm unwinding of IRQ was not yet done. It may be possible the IRQ is
triggered at this point scheduling new work item to the already flushed
queue.

According to the input documentation the input device allocated by
devm_input_allocate_device() does not need to be explicitly unregistered.
Use the new devm_work_autocancel() and remove the remove() to simplify the
code.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---

Please note that the change is compile-tested only. All proper testing is
highly appreciated.
---
 drivers/extcon/extcon-max77693.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77=
693.c
index 92af97e00828..1f1d9ab0c5c7 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2012 Samsung Electrnoics
 // Chanwoo Choi <cw00.choi@samsung.com>
=20
+#include <linux/devm-helpers.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -1127,7 +1128,10 @@ static int max77693_muic_probe(struct platform_devic=
e *pdev)
 	platform_set_drvdata(pdev, info);
 	mutex_init(&info->mutex);
=20
-	INIT_WORK(&info->irq_work, max77693_muic_irq_work);
+	ret =3D devm_work_autocancel(&pdev->dev, &info->irq_work,
+				   max77693_muic_irq_work);
+	if (ret)
+		return ret;
=20
 	/* Support irq domain for MAX77693 MUIC device */
 	for (i =3D 0; i < ARRAY_SIZE(muic_irqs); i++) {
@@ -1254,22 +1258,11 @@ static int max77693_muic_probe(struct platform_devi=
ce *pdev)
 	return ret;
 }
=20
-static int max77693_muic_remove(struct platform_device *pdev)
-{
-	struct max77693_muic_info *info =3D platform_get_drvdata(pdev);
-
-	cancel_work_sync(&info->irq_work);
-	input_unregister_device(info->dock);
-
-	return 0;
-}
-
 static struct platform_driver max77693_muic_driver =3D {
 	.driver		=3D {
 		.name	=3D DEV_NAME,
 	},
 	.probe		=3D max77693_muic_probe,
-	.remove		=3D max77693_muic_remove,
 };
=20
 module_platform_driver(max77693_muic_driver);
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

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCjs+kACgkQeFA3/03a
ocUkEwf+Nrs0FVLWS6Lng7i86iedWDICohisofwn2n7chzo0shpdjt0IZXx28mLA
nbk7AupU8pAkAMEI2b/egfQ1Q55+BkpZcmdTYZLQy7GOM5Ac95/kNby5QslaVEOt
sY0ZBSNZLQc90SWzYioDORvVQNWpKiD17j1ha8z11GjL06Sz3D40wY6vSSjrZzyI
XeIgEs/6lSGVtHq4JG4n3gLR9v2pB0038FHpW1l6wwVYMJwoMjPab1SApU1ddVyS
L5fICzFep2qdjXeD52wZLiGqYTsmfdaJR7rKVIRmupyObc0DodHOsMekC/tT3rOs
uD8HzeA/tpp81xPt7MTCi1A3iTf9Aw==
=CJ+l
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

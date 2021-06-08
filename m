Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B39139F33B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFHKL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:11:56 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:38859 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhFHKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:11:55 -0400
Received: by mail-lj1-f174.google.com with SMTP id s22so5831617ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CYu3AQufKRlOTXLiwA6qsIvmg55rZ/YYav/O+FxGH2o=;
        b=mmqP7sPdRwpDWtROUsnSVKw5qW+0SUKtEqDbU2o6YUA104MWRROZUa78oIZ+3jmXED
         /eGaC65Ceteztepx7A1gQWoDGwGwpqaCqncCV7NU/jjYzhQ4+BKIZTKshthfSdmPCmfr
         lLU3JVfnwYzqG2868Ez+OmD6Lh27HkWpPu/G2ITDGJwRHFPzfepNyWQEoXLdy1InHBUK
         Lt/Li4E9//IQv0l3C8zZ0/uQ2ArfN6HwXQsiyX6/mX1X86oU6qflN5BINqNzHpIgWKhF
         ngxDTSA2iRqBewEuqJUwEmoG9ww+PmXv61mL2g70iCZQRXXiq+2Gsw5S1h5HCS9rvdEV
         m+gw==
X-Gm-Message-State: AOAM5313gP+Mii1S0nztmjtTqrH6a9EK2/8LvSvBPzGMIGwhbq0kDXG4
        qnbew05zwcD7eXmZeqUMCv0=
X-Google-Smtp-Source: ABdhPJy0f155vZTJeNwhgFZuz9Hy4VIzmLQFqPBHpPQ9PA1Q5q5UoIh3fA0yH3XgBal49NRRY/OcOA==
X-Received: by 2002:a2e:9945:: with SMTP id r5mr18057096ljj.324.1623147001691;
        Tue, 08 Jun 2021 03:10:01 -0700 (PDT)
Received: from dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id b10sm1146554ljf.72.2021.06.08.03.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:10:01 -0700 (PDT)
Date:   Tue, 8 Jun 2021 13:09:55 +0300
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
Subject: [PATCH RESEND v2 2/5] extcon: extcon-max14577: Fix potential
 work-queue cancellation race
Message-ID: <ee8545f59ae3a93f0a70f640ecbd7e31cfadbcb9.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The extcon IRQ schedules a work item. IRQ is requested using devm while
WQ is cancelld at remove(). This mixing of devm and manual unwinding has
potential case where the WQ has been emptied (.remove() was ran) but
devm unwinding of IRQ was not yet done. It is possible the IRQ is triggered
at this point scheduling new work item to the already flushed queue.

Use new devm_work_autocancel() to remove the remove() and to kill the bug.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

Please note that the change is compile-tested only. All proper testing is
highly appreciated.
---
 drivers/extcon/extcon-max14577.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14=
577.c
index ace523924e58..5476f48ed74b 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -6,6 +6,7 @@
 // Chanwoo Choi <cw00.choi@samsung.com>
 // Krzysztof Kozlowski <krzk@kernel.org>
=20
+#include <linux/devm-helpers.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -673,7 +674,10 @@ static int max14577_muic_probe(struct platform_device =
*pdev)
 	platform_set_drvdata(pdev, info);
 	mutex_init(&info->mutex);
=20
-	INIT_WORK(&info->irq_work, max14577_muic_irq_work);
+	ret =3D devm_work_autocancel(&pdev->dev, &info->irq_work,
+				   max14577_muic_irq_work);
+	if (ret)
+		return ret;
=20
 	switch (max14577->dev_type) {
 	case MAXIM_DEVICE_TYPE_MAX77836:
@@ -766,15 +770,6 @@ static int max14577_muic_probe(struct platform_device =
*pdev)
 	return ret;
 }
=20
-static int max14577_muic_remove(struct platform_device *pdev)
-{
-	struct max14577_muic_info *info =3D platform_get_drvdata(pdev);
-
-	cancel_work_sync(&info->irq_work);
-
-	return 0;
-}
-
 static const struct platform_device_id max14577_muic_id[] =3D {
 	{ "max14577-muic", MAXIM_DEVICE_TYPE_MAX14577, },
 	{ "max77836-muic", MAXIM_DEVICE_TYPE_MAX77836, },
@@ -797,7 +792,6 @@ static struct platform_driver max14577_muic_driver =3D {
 		.of_match_table =3D of_max14577_muic_dt_match,
 	},
 	.probe		=3D max14577_muic_probe,
-	.remove		=3D max14577_muic_remove,
 	.id_table	=3D max14577_muic_id,
 };
=20
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

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmC/QfMACgkQeFA3/03a
ocXBOAgAru11cm78N6s0m1MOShhE/asUfMyiq2Cxcz2x7fw3OACzwFlfp+R32ar/
fUHwetVFmjogoMhJmQ/jXp1caqcKeje+fsXiIBONwA3BqTuNFWF0+PJQHA83do//
SbGVinvYQBeRatkLky4B6mJVbQH0WxCY2cTuG+CvKqalHEgFsUJb/B/29TAK5udf
vl5LFwgkYTglI2wjp/dKzYcqUQBJo9FBLb92at/gLFbOz0RTkzVI6ZLHG3JVhik1
nAnin1FR9pPZtwdV8QLnJ8N7QbIuN3VD9tpA+/oo7Q51HNeXGA43gU664Qx8MAIU
u91yTAXvYr6vh32ew7OKVdf4nUEHEg==
=3cFl
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

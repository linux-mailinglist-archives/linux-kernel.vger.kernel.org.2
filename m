Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A19C3878C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349151AbhERMd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:33:56 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36767 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbhERMdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:33:47 -0400
Received: by mail-lj1-f174.google.com with SMTP id 131so11337538ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XOtOu3FPLcHWPN33oKp0qzRSpWHZ/w5yi4TJ9Npi3sM=;
        b=PAApWKSX4aEAAJgYe7DANdF4B55TV29zq3gS0Sj9hqBvackp2c9FVpGRuPwKXRbVzS
         uvfhd7U8ZfoItpn8aZMo45E916ZrGb2ByT9Q9me3eGnBgt1cFieQ5PGlpjy+URG3whFO
         1AmrzeIXRvnJKad4/HWW4ByGj6kIiYmBiZUHYMsYZoMZepdwsQS3Did+IrzX//nm8uNC
         atnvdi9x1OLPg90MHYZgy3BF7C+mWQ09PwcV/PC4ZbsKhXfonsAD9xMsxYNGrPsZMzWl
         EP2LgzgNWmHXyZh90MaZczHNrWJJlH3nhF+SyHmPgQohquOttBKYVQ/dgWQjT4Wcc0uS
         rTEw==
X-Gm-Message-State: AOAM530u/Er4ZJ/P284McMXArnIERENPcTXHwYEky0qQH3Rf5jwxfpKS
        cr8FW69lEUvkvz83A++t9kg=
X-Google-Smtp-Source: ABdhPJx6TxLP/XGrUNlJpr/1m0fnq2Fc66pV2Mn+l8ZNr2qM//ePEz1+zHBK8WzCYvH6sFLA0uB/Ow==
X-Received: by 2002:a2e:a373:: with SMTP id i19mr3900750ljn.49.1621341148058;
        Tue, 18 May 2021 05:32:28 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::1])
        by smtp.gmail.com with ESMTPSA id n15sm25646lfq.274.2021.05.18.05.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:32:27 -0700 (PDT)
Date:   Tue, 18 May 2021 15:32:21 +0300
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
Subject: [PATCH v2 2/5] extcon: extcon-max14577: Fix potential work-queue
 cancellation race
Message-ID: <c2c6e166ab0e9c8513f989d79cb9af653cfb43d4.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
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

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCjs9UACgkQeFA3/03a
ocWGcAgApZfH8gjOIYybHYbHh2bcwirM7+ilE5h9mcU08MkaUVc6Wcya+vvauPM0
SP1ARBpFYtTFhxZwQ3JKqwi//Tg11vPg7WQTrHlureH78iLuK+HkmpgRvsHFAvoX
SUb01F9RKQkPDSkRnIZ6qoy7KxQ+AxQ0i6xr9LtqzEHqfXayCYr+DVXdGT4KthKP
ZTTKDSdklEJxIYZd9bPJI9nUXM6MoMSu2qIxLK/9TwkNkKyjP5ThavLozV4b/BoP
OZDiRZJmy49MgV5fUV0V5U8RxJwBOao72ED7EpDfbkmpQayGsrD8pXKYtjPeNVqW
p7AXhOWvCxBgBOkeCeUId2R3YkPwKg==
=FuhJ
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CAD39F33C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFHKMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:12:25 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:40784 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFHKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:12:22 -0400
Received: by mail-lf1-f41.google.com with SMTP id w33so31236250lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3hoHR+UhEtMrfC3BjJLbgNiZoZf2Nt7/nOlO4MDO+jw=;
        b=MPuX/XFK/cLKEB93IuEzMhwqT0HW3VctKThxFWE9JztaBGejpQTkZ6kNpL8iUp3Zra
         35uzuOqchbFXbbnUpOYX2/eVBkKT+0nOmlJK7S2BYYkOsEFyI4152TqjffI4GQ06HkQj
         CQqQUOmcOwC+cXcgWakLnZg7za5hQozK3hRDemFRQ1hNK78dqnCLq/K/3lPnSYyCnMes
         qIqny1YkmTecXO3RRMTXo47kTbJ090ed7lHRtuHQqHJUBuSSkMi8e0DBPe56P1GVz0IE
         aeedQ8iepZECx4lyP3KxcH/ReHJWarmMHgZYXNZ7WpAja4+fjOlB8i4MFCGpZkuIgmS/
         0fZg==
X-Gm-Message-State: AOAM530PjLNC8ARINCNUQQUYKKcZSWP+MlkiRT6JMqnpzbUrYPvggGwI
        jgxu6gcEVfPmc5owwP3AjLk=
X-Google-Smtp-Source: ABdhPJwUphdiPGJfHofVXPCBDR/ydPUplHdOMh7TIN9a2S6CjFgXagaLAGPQEa6WRjhgWmj/R4w0qA==
X-Received: by 2002:a05:6512:2206:: with SMTP id h6mr15695415lfu.345.1623147017115;
        Tue, 08 Jun 2021 03:10:17 -0700 (PDT)
Received: from dc7vkhyh15000m40t6jht-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id g20sm2194965lja.2.2021.06.08.03.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:10:16 -0700 (PDT)
Date:   Tue, 8 Jun 2021 13:10:11 +0300
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
Subject: [PATCH RESEND v2 3/5] extcon: extcon-max77693.c: Fix potential
 work-queue cancellation race
Message-ID: <cbe8205eed8276f6e6db5003cfe51b8b0d4ac966.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmC/QgMACgkQeFA3/03a
ocVPUggAp6CAXVeq4CLAGVDOM9j0FKzm6Skn7r+wwR7h1D8kp/4aSpKwXWBE1RP8
qOmSTB+zEmeRf9Gm/p0GaiAiBKVOU3FPMvXEn3BuWTQuqZ4GHnJCWRfS9Di7cPjM
NH1e4VOeoVc23P+4SxtIvXDdWQRUMitfEQm5k3+ZXh4RAM6XK0f/P4157z6DsDk2
YFlNPfhP7Z5EekhrzbJ/DLVeNWyMWpPcG2VVvDL2nhwhtrg2Pmx//lWsS0O3gJaN
Dk8a9bZUwUbrOxagJysr9hdTexJVEGsm3HNAl59R+iaGh6u1gddLL2ootuR3uqkz
oKbq4TDWrOmoeySi3hHL+K/vofifHQ==
=R8jE
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

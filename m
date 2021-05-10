Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD820377DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhEJINd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:13:33 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:37778 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhEJINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:13:32 -0400
Received: by mail-lj1-f174.google.com with SMTP id b7so19704517ljr.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nnlBuFNxD2pkJZkScxb0omPoXoqwYg+oxLnNQiEHPMg=;
        b=tCmA22EQngZtyr8UBfexsCmQijGxjSN4zOXq4ycu0e7a3G8uzFxak3VeZSko0aHGCQ
         gYpZ928m1NEPy3g76We+sQsQQBJRjlKPx7ENgNzX7OnAQjUBNJQdl8YoGujUROSCtq68
         xW/wBqGxL0CRLv2PA3zquHPJJebgkopMP+2bI6WqwlOpqeNRB+aYRht9gjpgGkoHO8Xr
         NS/B5NplSTl5pzV0vSVox+dCVEmqCG6GWKCnyNojd5QklILA+KxHr+EE9zzWwNyUA22+
         EzIZqjKkFuRwkNjobduZ6g7z01incYrfVTdv+wmbBXi07YKhXXtTpLorph4NI9WfEs8+
         jrhw==
X-Gm-Message-State: AOAM5326RAqMqkRMTeKq3URFNcjrSZ7k/om+Du7JkDXGGNVmlrOoM73q
        ippF3StJZ9ch9MPYyfMEztEwSlNbWa4vrg==
X-Google-Smtp-Source: ABdhPJxzHEO88PVNrKW5BWqH0F8E8xy9yGEtmbUak7+OH5Uu7irJTUKomjPET6+uEo3oIffS9FPvdQ==
X-Received: by 2002:a2e:b605:: with SMTP id r5mr18635695ljn.483.1620634346224;
        Mon, 10 May 2021 01:12:26 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id m13sm3136915ljb.10.2021.05.10.01.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 01:12:25 -0700 (PDT)
Date:   Mon, 10 May 2021 11:12:19 +0300
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
Subject: [PATCH 3/4] extcon: extcon-max77693.c: Fix potential work-queue
 cancellation race
Message-ID: <e83fe8359b6b6dfcb0cbc18e8c3efd653971dd44.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
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

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCY6uMACgkQeFA3/03a
ocXEYAf/SFALXGyMLHS9gnpEVjC2bHDDM2tS0VhZOLPD7Mv8tnenaKJUoYLni14k
36bjBY+MCI4CINem6BwaHDG+phDdosu5OvXXkfWVSdKt533QdWtbXBMC2xR3jF/S
GmUhIsGfC0vbujl7VVwW2hJvp3tw4Z46Kl/RQlyBLHX1JRHDDDVomhbxB3i1+S84
qtuiG9NPebq1Zm2LsdFdcBWJkdRuLQ3t+/4xVMNNrHQKON9gf15jaw5moNo2WRDQ
lW1iG1IsHaKxxOj1qbhSPLe99cM2djiUvmV9pBVg+46fLUB/ovd3ZZyhCF+Ux+D6
pdhK9uecg5JhCPV9VUsJhG/HfX3iRw==
=+K/V
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EEE377DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhEJIMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:12:55 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:33361 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhEJIMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:12:54 -0400
Received: by mail-lf1-f50.google.com with SMTP id h4so22121073lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ftmtXJ1CZHC1crez5pbFG89EIcTSyNrxNTvtKjYzS3M=;
        b=Hsp3VOJcl+Fu2PLzCuDbUUeT9xC/BnD1ds7SHNzRYzr3pOd3d1f0DQzykTmBnXdDtj
         zqTMD9Vm0xD83+9upalRcnQTPM+Eq1H1fLAMRjWmpdKzt1S5Sb0AGNQ3Lq/RQyRtU0vw
         K3zhB4gY9/R7hBfiZ6laNZklmABoWuU4MHYuW8Nz6qf60KpofL40V+1M6YMUZ+T3nSLr
         p9q+hm8EkCS0jXiI/yNC1DQ2fEOtGfcx4AoBbe5+jDBEQFuaZkzhUUn2sVrDLTZ1XR93
         0UCxjgicZKgJE89FKVqJGXyLiWuET5rxN35KqSZjabPmGshG4QsuJTOrjR+2P4YJXH5D
         tsRg==
X-Gm-Message-State: AOAM532I5PcbH/Nw83C6g02UvNitYedVFHPRKn6COkBdlmSqlJo4OD46
        CsdHDBbYvMh6gKEReZsPU24=
X-Google-Smtp-Source: ABdhPJymCuuvW5MtxaoOG7sBk9GKaW020VlLXHsyDGRSNb2fBkTZFjN5kbTqi+jXqDfMTz0TcapJ5g==
X-Received: by 2002:a05:6512:3481:: with SMTP id v1mr1992640lfr.376.1620634309541;
        Mon, 10 May 2021 01:11:49 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id j11sm2156925lfg.299.2021.05.10.01.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 01:11:49 -0700 (PDT)
Date:   Mon, 10 May 2021 11:11:42 +0300
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
Subject: [PATCH 2/4] extcon: extcon-max14577: Fix potential work-queue
 cancellation race
Message-ID: <70dfbe28725bac3383f77d02037f4f7f37839989.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
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

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCY6r4ACgkQeFA3/03a
ocXLigf/eH0DCVDE+Abcwy/Ka42vrNncD+7GZ6KPLf+RQOAN0iaMeuj/Uz2gyy7E
yXah8A9GsYV10ddngGXuW/qf2lIb8W4Xvgq9yB9BfYMJzH60RS3attmCaNcjA5g8
bChbd/9UP6pZ4MLrCbWk6SUssH4chprkNZcxtJmknpppVtpi1Qw2q1Gog6YydlNQ
89iSjswEHr7qmimU9qumQLnxlNPiowsXxcIomPr6WY5kSLL0XNhuV8oguYBT7k7G
W++NOiSEQ1XRTOLwLIZAfp5fiR+gsoOgDDH2USVTVPqt6wbfF1LWp0Gxl69LNmy2
27tFL4eEk/xgmjwfQKXsDX4ibl1GUg==
=NddI
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

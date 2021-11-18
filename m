Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF4455AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 12:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbhKRLwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 06:52:30 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:39574 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344226AbhKRLwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 06:52:17 -0500
Received: by mail-lf1-f51.google.com with SMTP id f18so24719186lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 03:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=In1TgG74ZF4vN4DugRnBaJ8GM3SkTTr3QHddw9dIWNA=;
        b=pnhZfmS9YJyJW+1zYJI88avP08ow7gEM18j3wZ1T3c/NmvUthR01BarwS4/34cpKB7
         XxsAmbLfTBI+jIw1HbB1wjM4dCvruE8slgT/1JZQIUg7Cn1S9X9Vbp4fcNFk+jm/0AZi
         SoKsw5epMT9t3zFOkZoz1ZpI9J9L3kMEE+XEQseqOmzj5OIHmPUzPtHs5hxt9CdlFdCf
         omdEOHumaQFSNOgTfuMBTv0z6b4X60xPIXSgmRP6vRnOQX2Q2u9OVUlFXkgIyPerQP+w
         MjSnDN4io/yedqKwloQSzWz/BiQimRfzBlP/ZvEJtQwgQqnKIXxBpJS77De/0M6qjA6q
         QPhQ==
X-Gm-Message-State: AOAM533qejtYU2MsvMxxodchZ/Svv2rbLyY73JmG4uGO7uCp7czCGg4d
        ZfeVaM0KIMD0WvQRXGs//4U=
X-Google-Smtp-Source: ABdhPJxPRG1wTue+IhdFMNWnioKnWR6dcv02rLjCav+9Nb8jZ6lxVYY4t2YMlQqW/YmNMDxRrQ4fhQ==
X-Received: by 2002:ac2:5bce:: with SMTP id u14mr23137385lfn.467.1637236156016;
        Thu, 18 Nov 2021 03:49:16 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id r3sm284109lfc.131.2021.11.18.03.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:49:15 -0800 (PST)
Date:   Thu, 18 Nov 2021 13:49:08 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] regulator: bd718x7: Use rohm generic restricted voltage
 setting
Message-ID: <5a0ee14852802690241568a29ed19ff9550b0b08.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DpS/+AWKsCVcYkSQ"
Content-Disposition: inline
In-Reply-To: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DpS/+AWKsCVcYkSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use common restricted voltage setting instead of implementing own.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 29 ++++-----------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd71=
8x7-regulator.c
index d60fccedb250..00efb18a836c 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -125,27 +125,6 @@ static int bd71837_get_buck34_enable_hwctrl(struct reg=
ulator_dev *rdev)
=20
 	return !!(BD718XX_BUCK_RUN_ON & val);
 }
-/*
- * On BD71837 (not on BD71847, BD71850, ...)
- * Bucks 1 to 4 support DVS. PWM mode is used when voltage is changed.
- * Bucks 5 to 8 and LDOs can use PFM and must be disabled when voltage
- * is changed. Hence we return -EBUSY for these if voltage is changed
- * when BUCK/LDO is enabled.
- *
- * On BD71847, BD71850, ... The LDO voltage can be changed when LDO is
- * enabled. But if voltage is increased the LDO power-good monitoring
- * must be disabled for the duration of changing + 1mS to ensure voltage
- * has reached the higher level before HW does next under voltage detection
- * cycle.
- */
-static int bd71837_set_voltage_sel_restricted(struct regulator_dev *rdev,
-						    unsigned int sel)
-{
-	if (rdev->desc->ops->is_enabled(rdev))
-		return -EBUSY;
-
-	return regulator_set_voltage_sel_regmap(rdev, sel);
-}
=20
 static void voltage_change_done(struct regulator_dev *rdev, unsigned int s=
el,
 				unsigned int *mask)
@@ -642,22 +621,22 @@ BD718XX_OPS(bd71837_pickable_range_buck_ops,
 	    bd718x7_set_buck_ovp);
=20
 BD718XX_OPS(bd71837_ldo_regulator_ops, regulator_list_voltage_linear_range,
-	    NULL, bd71837_set_voltage_sel_restricted,
+	    NULL, rohm_regulator_set_voltage_sel_restricted,
 	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
 	    NULL);
=20
 BD718XX_OPS(bd71837_ldo_regulator_nolinear_ops, regulator_list_voltage_tab=
le,
-	    NULL, bd71837_set_voltage_sel_restricted,
+	    NULL, rohm_regulator_set_voltage_sel_restricted,
 	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
 	    NULL);
=20
 BD718XX_OPS(bd71837_buck_regulator_ops, regulator_list_voltage_linear_rang=
e,
-	    NULL, bd71837_set_voltage_sel_restricted,
+	    NULL, rohm_regulator_set_voltage_sel_restricted,
 	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
 	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp);
=20
 BD718XX_OPS(bd71837_buck_regulator_nolinear_ops, regulator_list_voltage_ta=
ble,
-	    regulator_map_voltage_ascend, bd71837_set_voltage_sel_restricted,
+	    regulator_map_voltage_ascend, rohm_regulator_set_voltage_sel_restrict=
ed,
 	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
 	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp);
 /*
--=20
2.31.1


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

--DpS/+AWKsCVcYkSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGWPbQACgkQeFA3/03a
ocV8dwgAwl4G4aKbmpAV/JK/5bDLFYmEhTgoZ+j6OQuTS25tPQC8k2oEwxksSDUs
sGbvRIPpQcQt2pcmkmQyxqodWDrpBhw05/ZcmBRTnFvCBa+0cU1b5PG/7pBZMkXp
vvnwVgUjXLTX7tA+k9w2AjXeOlxEHlbqaW/zz9sWWlCZrv19NywiNH05QR5MfjPI
n9CFLWc3yizA0IlY2KnrjMJ3wjyaK71NdH6bn60ekBe+lQe+fWNst9JMVcp8BhCj
vG4lpICN/vgNoGnbZj2QMWOHBbvQaYE7HoA6Ng6EoJEaVoUvFIJEbeBygzaAfsSI
JLSNwOSSUf00xR26T8StcYD0DDI/cA==
=xAaN
-----END PGP SIGNATURE-----

--DpS/+AWKsCVcYkSQ--

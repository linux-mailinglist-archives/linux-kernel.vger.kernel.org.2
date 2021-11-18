Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B645455AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 12:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbhKRLwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 06:52:17 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:38443 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344157AbhKRLwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 06:52:00 -0500
Received: by mail-lf1-f51.google.com with SMTP id bi37so24640155lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 03:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jatb59kfVdHN6eWt15b1MrApzfZf1yR/5GhBccqsDF8=;
        b=3oJtAvs2W+eyFCIfFIOuW9g5msRSqpCTmF4jVUaSZuFEHv5qLnJCTz1zyUxqo7VCFQ
         Y/JJtXeyjGJ6n4+/C2OjU7fqW6i6xFsb5UN5k2LXG9JcAghFlMAR0t8SEHF96E1BDpjJ
         cR5B8e8lOkxoefKvPeTMwzq7h9uStXXHvEZjnyNETtjbxp+hFb4RnfhRc6TbPQKEhvs5
         OY910rNMdNZqbG9ZU29Ix9Cw9eshpqWvDo9to629tuO6+3ncv4KI/aKBL5tKoHBhi694
         +hsGhgEZW3S1+8O2qYzimu4/29mzzhRfAJ9j76YSzHR9LvNQWLvOmTJncxeqxHBnQUru
         z7/g==
X-Gm-Message-State: AOAM530bAcB8P/+TMfOXlTa8FqVmsmt6tMSGkJeDtNC2WBihBruA1i7N
        +qqThmTXF7/i3yL4HKC525WFgajFFm4=
X-Google-Smtp-Source: ABdhPJz+z5fxe0RpytkCXeV37gOgY1kg+MRrFa0Fx/6YWKRoaqNkYY3dVgHrGh0vB0cx/kJ6HhZtRw==
X-Received: by 2002:a2e:a4d1:: with SMTP id p17mr15902042ljm.318.1637236135095;
        Thu, 18 Nov 2021 03:48:55 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id h7sm281310lfu.253.2021.11.18.03.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:48:54 -0800 (PST)
Date:   Thu, 18 Nov 2021 13:48:47 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] regulator: rohm-regulator: add helper for restricted
 voltage setting
Message-ID: <6f51871e9fea611d133b5dd2560f4a7ee1ede9cd.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VdoY8lpoMst1Xhba"
Content-Disposition: inline
In-Reply-To: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VdoY8lpoMst1Xhba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Few ROHM PMICs have regulators where voltage setting can be done only
when regulator is disabled. Add helper for those PMICs.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/rohm-regulator.c | 16 ++++++++++++++++
 include/linux/mfd/rohm-generic.h   |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-re=
gulator.c
index 6e0d9c08ec1c..f97a9a51ee76 100644
--- a/drivers/regulator/rohm-regulator.c
+++ b/drivers/regulator/rohm-regulator.c
@@ -112,6 +112,22 @@ int rohm_regulator_set_dvs_levels(const struct rohm_dv=
s_config *dvs,
 }
 EXPORT_SYMBOL(rohm_regulator_set_dvs_levels);
=20
+/*
+ * Few ROHM PMIC ICs have constrains on voltage changing:
+ * BD71837 - only buck 1-4 voltages can be changed when they are enabled.
+ * Other bucks and all LDOs must be disabled when voltage is changed.
+ * BD96801 - LDO voltage levels can be changed when LDOs are disabled.
+ */
+int rohm_regulator_set_voltage_sel_restricted(struct regulator_dev *rdev,
+					      unsigned int sel)
+{
+	if (rdev->desc->ops->is_enabled(rdev))
+		return -EBUSY;
+
+	return regulator_set_voltage_sel_regmap(rdev, sel);
+}
+EXPORT_SYMBOL_GPL(rohm_regulator_set_voltage_sel_restricted);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("Generic helpers for ROHM PMIC regulator drivers");
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-gene=
ric.h
index 35b392a0d73a..35c5866f48b7 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -80,6 +80,8 @@ int rohm_regulator_set_dvs_levels(const struct rohm_dvs_c=
onfig *dvs,
 				  const struct regulator_desc *desc,
 				  struct regmap *regmap);
=20
+int rohm_regulator_set_voltage_sel_restricted(struct regulator_dev *rdev,
+					      unsigned int sel);
 #else
 static inline int rohm_regulator_set_dvs_levels(const struct rohm_dvs_conf=
ig *dvs,
 						struct device_node *np,
@@ -88,6 +90,11 @@ static inline int rohm_regulator_set_dvs_levels(const st=
ruct rohm_dvs_config *dv
 {
 	return 0;
 }
+static int rohm_regulator_set_voltage_sel_restricted(struct regulator_dev =
*rdev,
+						     unsigned int sel)
+{
+	return 0;
+}
 #endif
=20
 #endif
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

--VdoY8lpoMst1Xhba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGWPZ8ACgkQeFA3/03a
ocVsvwf8CPckIs2AMDMPxYwoQo2RAC5yqld/mftWQrImxe0YlHepA7YSr2F3luoP
qAJ5MQwJELTkP/prst/HhoqL1J4BDX2PTJSlVBj5vSj5aAqpDZ2ZLTbxMdNX6kSw
FuQb3pANk5uoq1nAavG5HzeRhkX3iIPbcBqWNRm7pgzXUcNBwg8LhggtyfhqV3ph
aL0zw/CFWJHDoNK/+WgjclD7wJ0Cn1dm9fiqCLKgAAuUn7NdPYb/ydvQoj/A5VHZ
hBb7GiOxGpCgXS6Hh3HPpGRUiprttkhuYAkHYn+gWDp3aGJwRJ8/oqmJMEh1JpFN
3+9X35W8SG6THAutqMTVsSS/eaI1Sg==
=UZ6A
-----END PGP SIGNATURE-----

--VdoY8lpoMst1Xhba--

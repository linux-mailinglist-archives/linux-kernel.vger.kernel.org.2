Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC53BBB97
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhGEK5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:57:18 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:41505 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhGEK5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:57:17 -0400
Received: by mail-lf1-f52.google.com with SMTP id n14so31767624lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 03:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=gXvCFJPmQeAH4zMYDltqzgg925ckg8LhPaIEitgbYyk=;
        b=jwnqjpqCGNs2yWxpvs+/34OcabeWrMx2VFH0uf99cfXoyxSe0htQDJ3a+XxpoTUpeJ
         7jndZ3miiAtBbjXdKWHnmSf4IuLv6f8cvKw1NRYK8j+pcPziSpi/A0+OiGQfOZDsTyba
         EvW6ykHNyp1y4Mylkx0dRnoQt7cY8akd8pQTXw+1HzJiqqf+UTpDTXXhezQHehhp8Rr/
         2nw0hcEy/E2k1evm2qpG1onxFV/agx+qitYurcvqM0MHZ/LxU3fd/0Fzp2pHmObgSSCy
         vIwCRGFiSS8+h5c+F3zWgj68f595IYghCrpoFLLOUs1D2WmZHobIxCiNIEr1swapA2pW
         btQA==
X-Gm-Message-State: AOAM531W0m8iAg6hXW5R9HD6Q91OBidqt0YpYXReJbyurls80+k09CyK
        8JugszUtPJJ1Q0vdeDag2WY=
X-Google-Smtp-Source: ABdhPJxlBL20Su+4w0+a1AbdLedCxoRmi8FhHEF1u0Wh/5DRS3XQdC8tH9rf/h+tKeCvFEx8lGH9sw==
X-Received: by 2002:ac2:5396:: with SMTP id g22mr9961052lfh.641.1625482479664;
        Mon, 05 Jul 2021 03:54:39 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id p15sm1049262lfr.293.2021.07.05.03.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 03:54:38 -0700 (PDT)
Date:   Mon, 5 Jul 2021 13:54:33 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd718x7: Suopport configuring UVP/OVP state
Message-ID: <20210705105416.GA1189560@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD71837/47/50/78 do support enabling/disabling the under/over
voltage protection. Add support for enabling/disabling the protection
according to the device-tree information.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Please note, this patch was created on regulator/for-next.
I can rebase and resend after rc1 is out if needed.

 drivers/regulator/bd718x7-regulator.c | 369 ++++++++++++++++++--------
 1 file changed, 260 insertions(+), 109 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd71=
8x7-regulator.c
index b1eb46961993..d60fccedb250 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -55,7 +55,8 @@
 #define BD718XX_HWOPNAME(swopname) swopname##_hwcontrol
=20
 #define BD718XX_OPS(name, _list_voltage, _map_voltage, _set_voltage_sel, \
-		   _get_voltage_sel, _set_voltage_time_sel, _set_ramp_delay) \
+		   _get_voltage_sel, _set_voltage_time_sel, _set_ramp_delay, \
+		   _set_uvp, _set_ovp)				\
 static const struct regulator_ops name =3D {			\
 	.enable =3D regulator_enable_regmap,			\
 	.disable =3D regulator_disable_regmap,			\
@@ -66,6 +67,8 @@ static const struct regulator_ops name =3D {			\
 	.get_voltage_sel =3D (_get_voltage_sel),			\
 	.set_voltage_time_sel =3D (_set_voltage_time_sel),	\
 	.set_ramp_delay =3D (_set_ramp_delay),			\
+	.set_under_voltage_protection =3D (_set_uvp),		\
+	.set_over_voltage_protection =3D (_set_ovp),		\
 };								\
 								\
 static const struct regulator_ops BD718XX_HWOPNAME(name) =3D {	\
@@ -76,6 +79,8 @@ static const struct regulator_ops BD718XX_HWOPNAME(name) =
=3D {	\
 	.get_voltage_sel =3D (_get_voltage_sel),			\
 	.set_voltage_time_sel =3D (_set_voltage_time_sel),	\
 	.set_ramp_delay =3D (_set_ramp_delay),			\
+	.set_under_voltage_protection =3D (_set_uvp),		\
+	.set_over_voltage_protection =3D (_set_ovp),		\
 }								\
=20
 /*
@@ -154,17 +159,9 @@ static void voltage_change_done(struct regulator_dev *=
rdev, unsigned int sel,
 		 * exceed it due to the scheduling.
 		 */
 		msleep(1);
-		/*
-		 * Note for next hacker. The PWRGOOD should not be masked on
-		 * BD71847 so we will just unconditionally enable detection
-		 * when voltage is set.
-		 * If someone want's to disable PWRGOOD he must implement
-		 * caching and restoring the old value here. I am not
-		 * aware of such use-cases so for the sake of the simplicity
-		 * we just always enable PWRGOOD here.
-		 */
-		ret =3D regmap_update_bits(rdev->regmap, BD718XX_REG_MVRFLTMASK2,
-					 *mask, 0);
+
+		ret =3D regmap_clear_bits(rdev->regmap, BD718XX_REG_MVRFLTMASK2,
+					 *mask);
 		if (ret)
 			dev_err(&rdev->dev,
 				"Failed to re-enable voltage monitoring (%d)\n",
@@ -208,12 +205,27 @@ static int voltage_change_prepare(struct regulator_de=
v *rdev, unsigned int sel,
 		 * time configurable.
 		 */
 		if (new > now) {
+			int tmp;
+			int prot_bit;
 			int ldo_offset =3D rdev->desc->id - BD718XX_LDO1;
=20
-			*mask =3D BD718XX_LDO1_VRMON80 << ldo_offset;
-			ret =3D regmap_update_bits(rdev->regmap,
-						 BD718XX_REG_MVRFLTMASK2,
-						 *mask, *mask);
+			prot_bit =3D BD718XX_LDO1_VRMON80 << ldo_offset;
+			ret =3D regmap_read(rdev->regmap, BD718XX_REG_MVRFLTMASK2,
+					  &tmp);
+			if (ret) {
+				dev_err(&rdev->dev,
+					"Failed to read voltage monitoring state\n");
+				return ret;
+			}
+
+			if (!(tmp & prot_bit)) {
+				/* We disable protection if it was enabled... */
+				ret =3D regmap_set_bits(rdev->regmap,
+						      BD718XX_REG_MVRFLTMASK2,
+						      prot_bit);
+				/* ...and we also want to re-enable it */
+				*mask =3D prot_bit;
+			}
 			if (ret) {
 				dev_err(&rdev->dev,
 					"Failed to stop voltage monitoring\n");
@@ -266,99 +278,6 @@ static int bd71837_set_voltage_sel_pickable_restricted(
 	return regulator_set_voltage_sel_pickable_regmap(rdev, sel);
 }
=20
-/*
- * OPS common for BD71847 and BD71850
- */
-BD718XX_OPS(bd718xx_pickable_range_ldo_ops,
-	    regulator_list_voltage_pickable_linear_range, NULL,
-	    bd718xx_set_voltage_sel_pickable_restricted,
-	    regulator_get_voltage_sel_pickable_regmap, NULL, NULL);
-
-/* BD71847 and BD71850 LDO 5 is by default OFF at RUN state */
-static const struct regulator_ops bd718xx_ldo5_ops_hwstate =3D {
-	.is_enabled =3D never_enabled_by_hwstate,
-	.list_voltage =3D regulator_list_voltage_pickable_linear_range,
-	.set_voltage_sel =3D bd718xx_set_voltage_sel_pickable_restricted,
-	.get_voltage_sel =3D regulator_get_voltage_sel_pickable_regmap,
-};
-
-BD718XX_OPS(bd718xx_pickable_range_buck_ops,
-	    regulator_list_voltage_pickable_linear_range, NULL,
-	    regulator_set_voltage_sel_pickable_regmap,
-	    regulator_get_voltage_sel_pickable_regmap,
-	    regulator_set_voltage_time_sel, NULL);
-
-BD718XX_OPS(bd718xx_ldo_regulator_ops, regulator_list_voltage_linear_range,
-	    NULL, bd718xx_set_voltage_sel_restricted,
-	    regulator_get_voltage_sel_regmap, NULL, NULL);
-
-BD718XX_OPS(bd718xx_ldo_regulator_nolinear_ops, regulator_list_voltage_tab=
le,
-	    NULL, bd718xx_set_voltage_sel_restricted,
-	    regulator_get_voltage_sel_regmap, NULL, NULL);
-
-BD718XX_OPS(bd718xx_buck_regulator_ops, regulator_list_voltage_linear_rang=
e,
-	    NULL, regulator_set_voltage_sel_regmap,
-	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
-	    NULL);
-
-BD718XX_OPS(bd718xx_buck_regulator_nolinear_ops, regulator_list_voltage_ta=
ble,
-	    regulator_map_voltage_ascend, regulator_set_voltage_sel_regmap,
-	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
-	    NULL);
-
-/*
- * OPS for BD71837
- */
-BD718XX_OPS(bd71837_pickable_range_ldo_ops,
-	    regulator_list_voltage_pickable_linear_range, NULL,
-	    bd71837_set_voltage_sel_pickable_restricted,
-	    regulator_get_voltage_sel_pickable_regmap, NULL, NULL);
-
-BD718XX_OPS(bd71837_pickable_range_buck_ops,
-	    regulator_list_voltage_pickable_linear_range, NULL,
-	    bd71837_set_voltage_sel_pickable_restricted,
-	    regulator_get_voltage_sel_pickable_regmap,
-	    regulator_set_voltage_time_sel, NULL);
-
-BD718XX_OPS(bd71837_ldo_regulator_ops, regulator_list_voltage_linear_range,
-	    NULL, bd71837_set_voltage_sel_restricted,
-	    regulator_get_voltage_sel_regmap, NULL, NULL);
-
-BD718XX_OPS(bd71837_ldo_regulator_nolinear_ops, regulator_list_voltage_tab=
le,
-	    NULL, bd71837_set_voltage_sel_restricted,
-	    regulator_get_voltage_sel_regmap, NULL, NULL);
-
-BD718XX_OPS(bd71837_buck_regulator_ops, regulator_list_voltage_linear_rang=
e,
-	    NULL, bd71837_set_voltage_sel_restricted,
-	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
-	    NULL);
-
-BD718XX_OPS(bd71837_buck_regulator_nolinear_ops, regulator_list_voltage_ta=
ble,
-	    regulator_map_voltage_ascend, bd71837_set_voltage_sel_restricted,
-	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
-	    NULL);
-/*
- * BD71837 bucks 3 and 4 support defining their enable/disable state also
- * when buck enable state is under HW state machine control. In that case =
the
- * bit [2] in CTRL register is used to indicate if regulator should be ON.
- */
-static const struct regulator_ops bd71837_buck34_ops_hwctrl =3D {
-	.is_enabled =3D bd71837_get_buck34_enable_hwctrl,
-	.list_voltage =3D regulator_list_voltage_linear_range,
-	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
-	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
-	.set_voltage_time_sel =3D regulator_set_voltage_time_sel,
-	.set_ramp_delay =3D regulator_set_ramp_delay_regmap,
-};
-
-/*
- * OPS for all of the ICs - BD718(37/47/50)
- */
-BD718XX_OPS(bd718xx_dvs_buck_regulator_ops, regulator_list_voltage_linear_=
range,
-	    NULL, regulator_set_voltage_sel_regmap,
-	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
-	    /* bd718xx_buck1234_set_ramp_delay */ regulator_set_ramp_delay_regmap=
);
-
 /*
  * BD71837 BUCK1/2/3/4
  * BD71847 BUCK1/2
@@ -536,6 +455,238 @@ struct bd718xx_regulator_data {
 	int additional_init_amnt;
 };
=20
+static int bd718x7_xvp_sanity_check(struct regulator_dev *rdev, int lim_uV,
+				    int severity)
+{
+	/*
+	 * BD71837/47/50 ... (ICs supported by this driver) do not provide
+	 * warnings, only protection
+	 */
+	if (severity !=3D REGULATOR_SEVERITY_PROT) {
+		dev_err(&rdev->dev,
+			"Unsupported Under Voltage protection level\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * And protection limit is not changeable. It can only be enabled
+	 * or disabled
+	 */
+	if (lim_uV)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int bd718x7_set_ldo_uvp(struct regulator_dev *rdev, int lim_uV,
+			       int severity, bool enable)
+{
+	int ldo_offset =3D rdev->desc->id - BD718XX_LDO1;
+	int prot_bit, ret;
+
+	ret =3D bd718x7_xvp_sanity_check(rdev, lim_uV, severity);
+	if (ret)
+		return ret;
+
+	prot_bit =3D BD718XX_LDO1_VRMON80 << ldo_offset;
+
+	if (enable)
+		return regmap_clear_bits(rdev->regmap, BD718XX_REG_MVRFLTMASK2,
+					 prot_bit);
+
+	return regmap_set_bits(rdev->regmap, BD718XX_REG_MVRFLTMASK2,
+			       prot_bit);
+}
+
+static int bd718x7_get_buck_prot_reg(int id, int *reg)
+{
+
+	if (id > BD718XX_BUCK8) {
+		WARN_ON(id > BD718XX_BUCK8);
+		return -EINVAL;
+	}
+
+	if (id > BD718XX_BUCK4)
+		*reg =3D BD718XX_REG_MVRFLTMASK0;
+	else
+		*reg =3D BD718XX_REG_MVRFLTMASK1;
+
+	return 0;
+}
+
+static int bd718x7_get_buck_ovp_info(int id, int *reg, int *bit)
+{
+	int ret;
+
+	ret =3D bd718x7_get_buck_prot_reg(id, reg);
+	if (ret)
+		return ret;
+
+	*bit =3D BIT((id % 4) * 2 + 1);
+
+	return 0;
+}
+
+static int bd718x7_get_buck_uvp_info(int id, int *reg, int *bit)
+{
+	int ret;
+
+	ret =3D bd718x7_get_buck_prot_reg(id, reg);
+	if (ret)
+		return ret;
+
+	*bit =3D BIT((id % 4) * 2);
+
+	return 0;
+}
+
+static int bd718x7_set_buck_uvp(struct regulator_dev *rdev, int lim_uV,
+				int severity, bool enable)
+{
+	int bit, reg, ret;
+
+	ret =3D bd718x7_xvp_sanity_check(rdev, lim_uV, severity);
+	if (ret)
+		return ret;
+
+	ret =3D bd718x7_get_buck_uvp_info(rdev->desc->id, &reg, &bit);
+	if (ret)
+		return ret;
+
+	if (enable)
+		return regmap_clear_bits(rdev->regmap, reg, bit);
+
+	return regmap_set_bits(rdev->regmap, reg, bit);
+
+}
+
+static int bd718x7_set_buck_ovp(struct regulator_dev *rdev, int lim_uV,
+				int severity,
+				bool enable)
+{
+	int bit, reg, ret;
+
+	ret =3D bd718x7_xvp_sanity_check(rdev, lim_uV, severity);
+	if (ret)
+		return ret;
+
+	ret =3D bd718x7_get_buck_ovp_info(rdev->desc->id, &reg, &bit);
+	if (ret)
+		return ret;
+
+	if (enable)
+		return regmap_clear_bits(rdev->regmap, reg, bit);
+
+	return regmap_set_bits(rdev->regmap, reg, bit);
+}
+
+/*
+ * OPS common for BD71847 and BD71850
+ */
+BD718XX_OPS(bd718xx_pickable_range_ldo_ops,
+	    regulator_list_voltage_pickable_linear_range, NULL,
+	    bd718xx_set_voltage_sel_pickable_restricted,
+	    regulator_get_voltage_sel_pickable_regmap, NULL, NULL,
+	    bd718x7_set_ldo_uvp, NULL);
+
+/* BD71847 and BD71850 LDO 5 is by default OFF at RUN state */
+static const struct regulator_ops bd718xx_ldo5_ops_hwstate =3D {
+	.is_enabled =3D never_enabled_by_hwstate,
+	.list_voltage =3D regulator_list_voltage_pickable_linear_range,
+	.set_voltage_sel =3D bd718xx_set_voltage_sel_pickable_restricted,
+	.get_voltage_sel =3D regulator_get_voltage_sel_pickable_regmap,
+	.set_under_voltage_protection =3D bd718x7_set_ldo_uvp,
+};
+
+BD718XX_OPS(bd718xx_pickable_range_buck_ops,
+	    regulator_list_voltage_pickable_linear_range, NULL,
+	    regulator_set_voltage_sel_pickable_regmap,
+	    regulator_get_voltage_sel_pickable_regmap,
+	    regulator_set_voltage_time_sel, NULL, bd718x7_set_buck_uvp,
+	    bd718x7_set_buck_ovp);
+
+BD718XX_OPS(bd718xx_ldo_regulator_ops, regulator_list_voltage_linear_range,
+	    NULL, bd718xx_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
+	    NULL);
+
+BD718XX_OPS(bd718xx_ldo_regulator_nolinear_ops, regulator_list_voltage_tab=
le,
+	    NULL, bd718xx_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
+	    NULL);
+
+BD718XX_OPS(bd718xx_buck_regulator_ops, regulator_list_voltage_linear_rang=
e,
+	    NULL, regulator_set_voltage_sel_regmap,
+	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
+	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp);
+
+BD718XX_OPS(bd718xx_buck_regulator_nolinear_ops, regulator_list_voltage_ta=
ble,
+	    regulator_map_voltage_ascend, regulator_set_voltage_sel_regmap,
+	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
+	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp);
+
+/*
+ * OPS for BD71837
+ */
+BD718XX_OPS(bd71837_pickable_range_ldo_ops,
+	    regulator_list_voltage_pickable_linear_range, NULL,
+	    bd71837_set_voltage_sel_pickable_restricted,
+	    regulator_get_voltage_sel_pickable_regmap, NULL, NULL,
+	    bd718x7_set_ldo_uvp, NULL);
+
+BD718XX_OPS(bd71837_pickable_range_buck_ops,
+	    regulator_list_voltage_pickable_linear_range, NULL,
+	    bd71837_set_voltage_sel_pickable_restricted,
+	    regulator_get_voltage_sel_pickable_regmap,
+	    regulator_set_voltage_time_sel, NULL, bd718x7_set_buck_uvp,
+	    bd718x7_set_buck_ovp);
+
+BD718XX_OPS(bd71837_ldo_regulator_ops, regulator_list_voltage_linear_range,
+	    NULL, bd71837_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
+	    NULL);
+
+BD718XX_OPS(bd71837_ldo_regulator_nolinear_ops, regulator_list_voltage_tab=
le,
+	    NULL, bd71837_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, NULL, NULL, bd718x7_set_ldo_uvp,
+	    NULL);
+
+BD718XX_OPS(bd71837_buck_regulator_ops, regulator_list_voltage_linear_rang=
e,
+	    NULL, bd71837_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
+	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp);
+
+BD718XX_OPS(bd71837_buck_regulator_nolinear_ops, regulator_list_voltage_ta=
ble,
+	    regulator_map_voltage_ascend, bd71837_set_voltage_sel_restricted,
+	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
+	    NULL, bd718x7_set_buck_uvp, bd718x7_set_buck_ovp);
+/*
+ * BD71837 bucks 3 and 4 support defining their enable/disable state also
+ * when buck enable state is under HW state machine control. In that case =
the
+ * bit [2] in CTRL register is used to indicate if regulator should be ON.
+ */
+static const struct regulator_ops bd71837_buck34_ops_hwctrl =3D {
+	.is_enabled =3D bd71837_get_buck34_enable_hwctrl,
+	.list_voltage =3D regulator_list_voltage_linear_range,
+	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
+	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel =3D regulator_set_voltage_time_sel,
+	.set_ramp_delay =3D regulator_set_ramp_delay_regmap,
+	.set_under_voltage_protection =3D bd718x7_set_buck_uvp,
+	.set_over_voltage_protection =3D bd718x7_set_buck_ovp,
+};
+
+/*
+ * OPS for all of the ICs - BD718(37/47/50)
+ */
+BD718XX_OPS(bd718xx_dvs_buck_regulator_ops, regulator_list_voltage_linear_=
range,
+	    NULL, regulator_set_voltage_sel_regmap,
+	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
+	    regulator_set_ramp_delay_regmap, bd718x7_set_buck_uvp,
+	    bd718x7_set_buck_ovp);
+
+
+
 /*
  * There is a HW quirk in BD71837. The shutdown sequence timings for
  * bucks/LDOs which are controlled via register interface are changed.

base-commit: bfcce85026918c65441ebd3db4cb0d36c5dcda74
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

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmDi5OkACgkQeFA3/03a
ocUX6Af/fspTfGdk5VqI17yUm67auUF1rsYRS9NA2y006USsijaHi1mnmSxRO8zQ
Gm3VHclrtcYWrefwpf/ykLkzwqReyNzZ+o6Vd+shX9q81aTiCPvpz0hQVIxbXEA1
3Ke2ZxeWJNUwcNP25yyGxBNw365ZP+pILQ/eN+7fYXbP//ZCldsiOtHVGZUs+5Iw
r2N4Ca22Gx+YTgs7vS+OdZ8cacQmozzr6PPL6Me0nTvOFbSD3jt3NYF3NyqS0Rzo
RJUxqQWU4sLpsfQ9o37zdeRi2BXPcjCKa9mRUJvnhhVz5dbRG46eV+6uJZ+Wg26P
mbejR8HbMmgOTrE1luWq4kmUYsYYQw==
=aAWq
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--

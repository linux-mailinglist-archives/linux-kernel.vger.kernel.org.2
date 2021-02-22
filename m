Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E108F3212FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhBVJYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:24:08 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40338 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230125AbhBVJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:23:59 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11M9MAGo023929;
        Mon, 22 Feb 2021 10:23:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=selector1;
 bh=S80jikv95dWkyePNxJCMqVCdNCkmEjOC6tUVNbKerlg=;
 b=o1jGoGrS+AkIdFwIgbSxUCvi1Kjk91pX4+g2uIpIKp9K9aT5y2Na+QhyGOwM9a4bUtDL
 o7GRg9isTwY3FnNsfqz92EB7QKhMq3aME3YMp4ifJAVjTRtKAZg+8U5caKXQtXNv8O/n
 lVKL0XdKyzUUtYptk/XmI2dOY+7KslQpkaGRC1Es4F6kPe4cCgLITY95vkL4LoXToics
 CEhFNgXujgEJOBxNfgvjMfdZ4alaUEhurV+oAKTSc42oRGSbi/dcOSjwoGdHqk/K5Zuz
 JToWs1su4Nk4E+4TvTZhf8SKa1iKZM/owxdrOv23Autdn1LHCa5ee63lTq7b2kEqGOzp Vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36u96ufwtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 10:23:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 33F4910002A;
        Mon, 22 Feb 2021 10:23:03 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2652121F0A8;
        Mon, 22 Feb 2021 10:23:03 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Feb
 2021 10:23:02 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Mon, 22 Feb 2021 10:23:02 +0100
From:   Raphael GALLAIS-POU - foss <raphael.gallais-pou@foss.st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Joe Perches" <joe@perches.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yannick FERTRE - foss <yannick.fertre@foss.st.com>,
        Philippe CORNU - foss <philippe.cornu@foss.st.com>,
        Raphael GALLAIS-POU - foss <raphael.gallais-pou@foss.st.com>,
        Raphael GALLAIS-POU <raphael.gallais-pou@st.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>
Subject: [PATCH 2/2] drm/stm: dsi: Use dev_ based logging
Thread-Topic: [PATCH 2/2] drm/stm: dsi: Use dev_ based logging
Thread-Index: AQHXCPxRmuabm72FykCaBQSzcYydLw==
Date:   Mon, 22 Feb 2021 09:23:02 +0000
Message-ID: <20210222092205.32086-3-raphael.gallais-pou@foss.st.com>
References: <20210222092205.32086-1-raphael.gallais-pou@foss.st.com>
In-Reply-To: <20210222092205.32086-1-raphael.gallais-pou@foss.st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_02:2021-02-18,2021-02-22 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertre <yannick.fertre@st.com>

Standardize on the dev_ based logging.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 49 ++++++++++++++-------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw=
_mipi_dsi-stm.c
index 8399d337589d..a7226bb3d0e8 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -76,6 +76,7 @@ enum dsi_color {
=20
 struct dw_mipi_dsi_stm {
 	void __iomem *base;
+	struct device *dev;
 	struct clk *pllref_clk;
 	struct dw_mipi_dsi *dsi;
 	u32 hw_version;
@@ -110,7 +111,8 @@ static inline void dsi_update_bits(struct dw_mipi_dsi_s=
tm *dsi, u32 reg,
 	dsi_write(dsi, reg, (dsi_read(dsi, reg) & ~mask) | val);
 }
=20
-static enum dsi_color dsi_color_from_mipi(enum mipi_dsi_pixel_format fmt)
+static enum dsi_color dsi_color_from_mipi(struct dw_mipi_dsi_stm *dsi,
+					  enum mipi_dsi_pixel_format fmt)
 {
 	switch (fmt) {
 	case MIPI_DSI_FMT_RGB888:
@@ -122,7 +124,7 @@ static enum dsi_color dsi_color_from_mipi(enum mipi_dsi=
_pixel_format fmt)
 	case MIPI_DSI_FMT_RGB565:
 		return DSI_RGB565_CONF1;
 	default:
-		DRM_DEBUG_DRIVER("MIPI color invalid, so we use rgb888\n");
+		dev_dbg(dsi->dev, "MIPI color invalid, so we use rgb888\n");
 	}
 	return DSI_RGB888;
 }
@@ -205,14 +207,14 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 	ret =3D readl_poll_timeout(dsi->base + DSI_WISR, val, val & WISR_RRS,
 				 SLEEP_US, TIMEOUT_US);
 	if (ret)
-		DRM_DEBUG_DRIVER("!TIMEOUT! waiting REGU, let's continue\n");
+		dev_dbg(dsi->dev, "!TIMEOUT! waiting REGU, let's continue\n");
=20
 	/* Enable the DSI PLL & wait for its lock */
 	dsi_set(dsi, DSI_WRPCR, WRPCR_PLLEN);
 	ret =3D readl_poll_timeout(dsi->base + DSI_WISR, val, val & WISR_PLLLS,
 				 SLEEP_US, TIMEOUT_US);
 	if (ret)
-		DRM_DEBUG_DRIVER("!TIMEOUT! waiting PLL, let's continue\n");
+		dev_dbg(dsi->dev, "!TIMEOUT! waiting PLL, let's continue\n");
=20
 	return 0;
 }
@@ -221,7 +223,7 @@ static void dw_mipi_dsi_phy_power_on(void *priv_data)
 {
 	struct dw_mipi_dsi_stm *dsi =3D priv_data;
=20
-	DRM_DEBUG_DRIVER("\n");
+	dev_dbg(dsi->dev, "\n");
=20
 	/* Enable the DSI wrapper */
 	dsi_set(dsi, DSI_WCR, WCR_DSIEN);
@@ -231,7 +233,7 @@ static void dw_mipi_dsi_phy_power_off(void *priv_data)
 {
 	struct dw_mipi_dsi_stm *dsi =3D priv_data;
=20
-	DRM_DEBUG_DRIVER("\n");
+	dev_dbg(dsi->dev, "\n");
=20
 	/* Disable the DSI wrapper */
 	dsi_clear(dsi, DSI_WCR, WCR_DSIEN);
@@ -267,11 +269,11 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
=20
 	if (pll_out_khz > dsi->lane_max_kbps) {
 		pll_out_khz =3D dsi->lane_max_kbps;
-		DRM_WARN("Warning max phy mbps is used\n");
+		dev_warn(dsi->dev, "Warning max phy mbps is used\n");
 	}
 	if (pll_out_khz < dsi->lane_min_kbps) {
 		pll_out_khz =3D dsi->lane_min_kbps;
-		DRM_WARN("Warning min phy mbps is used\n");
+		dev_warn(dsi->dev, "Warning min phy mbps is used\n");
 	}
=20
 	/* Compute best pll parameters */
@@ -281,7 +283,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct=
 drm_display_mode *mode,
 	ret =3D dsi_pll_get_params(dsi, pll_in_khz, pll_out_khz,
 				 &idf, &ndiv, &odf);
 	if (ret)
-		DRM_WARN("Warning dsi_pll_get_params(): bad params\n");
+		dev_warn(dsi->dev, "Warning dsi_pll_get_params(): bad params\n");
=20
 	/* Get the adjusted pll out value */
 	pll_out_khz =3D dsi_pll_get_clkout_khz(pll_in_khz, idf, ndiv, odf);
@@ -299,13 +301,12 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
=20
 	/* Select the color coding */
 	dsi_update_bits(dsi, DSI_WCFGR, WCFGR_COLMUX,
-			dsi_color_from_mipi(format) << 1);
+			dsi_color_from_mipi(dsi, format) << 1);
=20
 	*lane_mbps =3D pll_out_khz / 1000;
=20
-	DRM_DEBUG_DRIVER("pll_in %ukHz pll_out %ukHz lane_mbps %uMHz\n",
-			 pll_in_khz, pll_out_khz, *lane_mbps);
-
+	dev_dbg(dsi->dev, "pll_in %ukHz pll_out %ukHz lane_mbps %uMHz\n",
+			pll_in_khz, pll_out_khz, *lane_mbps);
 	return 0;
 }
=20
@@ -352,11 +353,13 @@ static int dw_mipi_dsi_stm_probe(struct platform_devi=
ce *pdev)
 	if (!dsi)
 		return -ENOMEM;
=20
+	dsi->dev =3D dev;
+
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dsi->base =3D devm_ioremap_resource(dev, res);
 	if (IS_ERR(dsi->base)) {
 		ret =3D PTR_ERR(dsi->base);
-		DRM_ERROR("Unable to get dsi registers %d\n", ret);
+		dev_err(dev, "Unable to get dsi registers %d\n", ret);
 		return ret;
 	}
=20
@@ -369,7 +372,7 @@ static int dw_mipi_dsi_stm_probe(struct platform_device=
 *pdev)
=20
 	ret =3D regulator_enable(dsi->vdd_supply);
 	if (ret) {
-		DRM_ERROR("Failed to enable regulator: %d\n", ret);
+		dev_err(dev, "Failed to enable regulator: %d\n", ret);
 		return ret;
 	}
=20
@@ -382,20 +385,20 @@ static int dw_mipi_dsi_stm_probe(struct platform_devi=
ce *pdev)
=20
 	ret =3D clk_prepare_enable(dsi->pllref_clk);
 	if (ret) {
-		DRM_ERROR("Failed to enable pllref_clk: %d\n", ret);
+		dev_err(dev, "Failed to enable pllref_clk: %d\n", ret);
 		goto err_clk_get;
 	}
=20
 	pclk =3D devm_clk_get(dev, "pclk");
 	if (IS_ERR(pclk)) {
 		ret =3D PTR_ERR(pclk);
-		DRM_ERROR("Unable to get peripheral clock: %d\n", ret);
+		dev_err(dev, "Unable to get peripheral clock: %d\n", ret);
 		goto err_dsi_probe;
 	}
=20
 	ret =3D clk_prepare_enable(pclk);
 	if (ret) {
-		DRM_ERROR("%s: Failed to enable peripheral clk\n", __func__);
+		dev_err(dev, "%s: Failed to enable peripheral clk\n", __func__);
 		goto err_dsi_probe;
 	}
=20
@@ -404,7 +407,7 @@ static int dw_mipi_dsi_stm_probe(struct platform_device=
 *pdev)
=20
 	if (dsi->hw_version !=3D HWVER_130 && dsi->hw_version !=3D HWVER_131) {
 		ret =3D -ENODEV;
-		DRM_ERROR("bad dsi hardware version\n");
+		dev_err(dev, "bad dsi hardware version\n");
 		goto err_dsi_probe;
 	}
=20
@@ -445,7 +448,7 @@ static int __maybe_unused dw_mipi_dsi_stm_suspend(struc=
t device *dev)
 {
 	struct dw_mipi_dsi_stm *dsi =3D dw_mipi_dsi_stm_plat_data.priv_data;
=20
-	DRM_DEBUG_DRIVER("\n");
+	dev_dbg(dsi->dev, "\n");
=20
 	clk_disable_unprepare(dsi->pllref_clk);
 	regulator_disable(dsi->vdd_supply);
@@ -458,18 +461,18 @@ static int __maybe_unused dw_mipi_dsi_stm_resume(stru=
ct device *dev)
 	struct dw_mipi_dsi_stm *dsi =3D dw_mipi_dsi_stm_plat_data.priv_data;
 	int ret;
=20
-	DRM_DEBUG_DRIVER("\n");
+	dev_dbg(dsi->dev, "\n");
=20
 	ret =3D regulator_enable(dsi->vdd_supply);
 	if (ret) {
-		DRM_ERROR("Failed to enable regulator: %d\n", ret);
+		dev_err(dev, "Failed to enable regulator: %d\n", ret);
 		return ret;
 	}
=20
 	ret =3D clk_prepare_enable(dsi->pllref_clk);
 	if (ret) {
 		regulator_disable(dsi->vdd_supply);
-		DRM_ERROR("Failed to enable pllref_clk: %d\n", ret);
+		dev_err(dev, "Failed to enable pllref_clk: %d\n", ret);
 		return ret;
 	}
=20
--=20
2.17.1

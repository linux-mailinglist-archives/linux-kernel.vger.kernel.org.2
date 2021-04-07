Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA393576B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhDGVWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhDGVVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:21:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E06BC061763;
        Wed,  7 Apr 2021 14:21:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a6so13424904wrw.8;
        Wed, 07 Apr 2021 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LXmODUYJ5jVMVtm5p+B0QGH2Rwv1W+jbpwPjPTOXLtA=;
        b=srlxUl/yqpRC8W+P/vxvbZStdaJ/ip7ir5D7+Qk45ij1lqalIkWv6auJB7HJvoaiRS
         gE/A5Q9HaOhaHrPJ82ac3G5Hh9Fz1ad11iI0txrfgjJnYKc8EhGY5sIlfV5HFl8FA84a
         VgVxapYnAOxz6X6sj5D7lHwnf/uQLIQhDmIgn/hg/3d0X5B2W7w4toqmA8eMA91a/XzQ
         A22YZHwNZadxiWonRDN+ruDWjomhaVziqLvRIwolgpRQWdKuI3c+g7GCLzcjrJiqUQ/h
         3ahuM4X9nhy6KdWDZ1q+cK349yW5wqzxIKAARDafbXEgQvOro8sAmd2owZRj3ZHBFLZI
         eETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LXmODUYJ5jVMVtm5p+B0QGH2Rwv1W+jbpwPjPTOXLtA=;
        b=t/UNmlfknuxv5CMINXBWsh035txkprBm1dAWuvPv2EhvhdbECgK3rYYXQmUzSFRujq
         Zl6sNj3HeW+x6O6dmY58mQp7depD9U9NY03iJyBLZ1y8O5H89eBTDyts6GPr33T30QCY
         HO18aoVyzB6yjVckaCsQ96NqV5c1J0VPUwMVQO1bg9NewaatxquiID8Ih0Dz6TKNIzA+
         a2Y617FIcXbDTj4/yCvvSq7PXXe5xnSlvlZFuLKFA8g219MA+hvz/CdtfCGvsc0BoA3M
         9V6X/C7JE6Qj12aU9tuUUFsftvRS0z7Rg6HJXE+cTffj/sdBE98d/7FKc712dN0xRWAV
         SWug==
X-Gm-Message-State: AOAM530wkVsoffbduhnJJAfpyCdt3iMvK3Z3h936E7oqP72sHk8ZxrZ5
        yNEvwA/ZRdg/kWOwkC9tlMI=
X-Google-Smtp-Source: ABdhPJzX8VS/ZPUnUOkNbPvXBv/HrzJ5cSeCHa2JsriOePZlZXEPvqsFvO7Tt2DQI8H/3pd1P/3NIg==
X-Received: by 2002:adf:e743:: with SMTP id c3mr3707043wrn.408.1617830488994;
        Wed, 07 Apr 2021 14:21:28 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270041a0a0f4308eafc0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:41a0:a0f4:308e:afc0])
        by smtp.gmail.com with ESMTPSA id l14sm17173952wrm.77.2021.04.07.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 14:21:28 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, Anson.Huang@nxp.com, krzk@kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, qiangqing.zhang@nxp.com,
        alice.guo@nxp.com, aford173@gmail.com, agx@sigxcpu.org,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 2/7] soc: imx: gpcv2: Fix power up/down sequence
Date:   Wed,  7 Apr 2021 23:21:17 +0200
Message-Id: <20210407212122.626137-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407212122.626137-1-adrien.grassein@gmail.com>
References: <20210407212122.626137-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power up/down sequence were wrongly scheduled.
The ADB400 were triggered at the bad time.
The Handshake were not checked.

The solution is to:
  - Split power up and power down sequences;
  - Add a register holding the bit to check;

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/soc/imx/gpcv2.c | 235 ++++++++++++++++++++++++++++------------
 1 file changed, 163 insertions(+), 72 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 8ec5b1b817c7..7afb81489f21 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -70,8 +70,11 @@
 #define GPC_PU_PWRHSK			0x1fc
 
 #define IMX8M_GPU_HSK_PWRDNREQN			BIT(6)
+#define IMX8M_GPU_HSK_PWRDNACKN			BIT(26)
 #define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
+#define IMX8M_VPU_HSK_PWRDNACKN			BIT(25)
 #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
+#define IMX8M_DISP_HSK_PWRDNACKN		BIT(24)
 
 /*
  * The PGC offset values in Reference Manual
@@ -102,6 +105,8 @@
 
 #define GPC_CLK_MAX		6
 
+static DEFINE_MUTEX(gpc_pd_mutex);
+
 struct imx_pgc_domain {
 	struct generic_pm_domain genpd;
 	struct regmap *regmap;
@@ -114,7 +119,8 @@ struct imx_pgc_domain {
 	const struct {
 		u32 pxx;
 		u32 map;
-		u32 hsk;
+		u32 hsk_req;
+		u32 hsk_ack;
 	} bits;
 
 	const int voltage;
@@ -127,34 +133,25 @@ struct imx_pgc_domain_data {
 	const struct regmap_access_table *reg_access_table;
 };
 
-static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
-				      bool on)
+static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
 {
 	struct imx_pgc_domain *domain = container_of(genpd,
 						      struct imx_pgc_domain,
 						      genpd);
-	unsigned int offset = on ?
-		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
-	const bool enable_power_control = !on;
-	const bool has_regulator = !IS_ERR(domain->regulator);
 	int i, ret = 0;
-	u32 pxx_req;
+	u32 value;
 
-	ret = regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-				 domain->bits.map, domain->bits.map);
-	if (ret) {
-		dev_err(domain->dev, "failed to map GPC PGC domain\n");
-		return ret;
-	}
-
-	if (has_regulator && on) {
+	/* Enable regulator if needed */
+	if (!IS_ERR(domain->regulator)) {
 		ret = regulator_enable(domain->regulator);
 		if (ret) {
 			dev_err(domain->dev, "failed to enable regulator\n");
-			goto unmap;
+			return ret;
 		}
 	}
 
+	mutex_lock(&gpc_pd_mutex);
+
 	/* Enable reset clocks for all devices in the domain */
 	for (i = 0; i < domain->num_clks; i++) {
 		ret = clk_prepare_enable(domain->clk[i]);
@@ -164,87 +161,178 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 		}
 	}
 
-	if (enable_power_control) {
-		ret = regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-					 GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
+	/* Map the domain to the A53 core */
+	ret = regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				 domain->bits.map, domain->bits.map);
+	if (ret) {
+		dev_err(domain->dev, "failed to map GPC PGC domain\n");
+		goto disable_clocks;
+	}
+
+	/* Request Power Up of the domain */
+	ret = regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
+				 domain->bits.pxx, domain->bits.pxx);
+	if (ret) {
+		dev_err(domain->dev, "failed to command PGC\n");
+		goto unmap;
+	}
+
+	/*
+	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+	 * for PUP_REQ/PDN_REQ bit to be cleared
+	 */
+	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
+				       value,
+				       !(value & domain->bits.pxx),
+				       0, USEC_PER_MSEC);
+	if (ret) {
+		dev_err(domain->dev, "failed to command PGC\n");
+		goto unmap;
+	}
+
+	/* Disable power control */
+	ret = regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+				 GPC_PGC_CTRL_PCR, 0);
+	if (ret) {
+		dev_err(domain->dev, "Failed to disable power control !\n");
+		goto unmap;
+	}
+
+	/* request the ADB400 to power up */
+	if (domain->bits.hsk_req) {
+		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
+				   domain->bits.hsk_req, domain->bits.hsk_req);
+
+		ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
+					       value,
+					       (value & domain->bits.hsk_ack),
+					       0, USEC_PER_MSEC);
+		if (ret)
+			dev_err(domain->dev, "Bad ACK while powering on %s\n",
+				genpd->name);
+	}
+
+	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+			   domain->bits.map, 0);
+
+	/* Disable all clocks */
+	for (i = 0; i < domain->num_clks; i++)
+		clk_disable_unprepare(domain->clk[i]);
+
+	mutex_unlock(&gpc_pd_mutex);
+
+	return 0;
+
+unmap:
+	if (domain->bits.map)
+		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				   domain->bits.map, 0);
+
+disable_clocks:
+	for (i--; i >= 0; i--)
+		clk_disable_unprepare(domain->clk[i]);
+
+	mutex_unlock(&gpc_pd_mutex);
+	return ret;
+}
+
+static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
+{
+	struct imx_pgc_domain *domain = container_of(genpd,
+						      struct imx_pgc_domain,
+						      genpd);
+	int i, ret = 0;
+	u32 value;
+
+	mutex_lock(&gpc_pd_mutex);
+
+	/* Enable reset clocks for all devices in the domain */
+	for (i = 0; i < domain->num_clks; i++) {
+		ret = clk_prepare_enable(domain->clk[i]);
 		if (ret) {
-			dev_err(domain->dev, "failed to enable power control\n");
+			dev_err(domain->dev, "failed to enable clocks\n");
 			goto disable_clocks;
 		}
 	}
 
-	if (domain->bits.hsk) {
-		ret = regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
-					 domain->bits.hsk,
-					 on ? domain->bits.hsk : 0);
-		if (ret) {
-			dev_err(domain->dev, "Failed to initiate handshake\n");
-			goto disable_power_control;
-		}
+	/* Map the domain to the A53 core */
+	ret = regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				 domain->bits.map, domain->bits.map);
+	if (ret) {
+		dev_err(domain->dev, "failed to map GPC PGC domain\n");
+		goto disable_clocks;
+	}
+
+	/* request the ADB400 to power down */
+	if (domain->bits.hsk_req) {
+		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
+				   domain->bits.hsk_req, 0);
+
+		ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
+					       value,
+					       !(value & domain->bits.hsk_ack),
+					       0, USEC_PER_MSEC);
+		if (ret)
+			dev_err(domain->dev, "Bad ACK while powering down %s\n",
+				genpd->name);
+
 	}
 
-	ret = regmap_update_bits(domain->regmap, offset,
+	/* Enable power control */
+	ret = regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+				 GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
+	if (ret) {
+		dev_err(domain->dev, "Failed to enable power control !\n");
+		goto unmap;
+	}
+
+	/* Request Power Down of the domain */
+	ret = regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
 				 domain->bits.pxx, domain->bits.pxx);
 	if (ret) {
 		dev_err(domain->dev, "failed to command PGC\n");
-		goto disable_power_control;
+		goto unmap;
 	}
 
 	/*
 	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
 	 * for PUP_REQ/PDN_REQ bit to be cleared
 	 */
-	ret = regmap_read_poll_timeout(domain->regmap, offset, pxx_req,
-				       !(pxx_req & domain->bits.pxx),
+	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
+				       value,
+				       !(value & domain->bits.pxx),
 				       0, USEC_PER_MSEC);
 	if (ret)
 		dev_err(domain->dev, "failed to command PGC\n");
 
-disable_power_control:
-	if (enable_power_control)
-		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-				   GPC_PGC_CTRL_PCR, 0);
-
-	if (ret) {
-		/*
-		 * If we were in a process of enabling a
-		 * domain and failed we might as well disable
-		 * the regulator we just enabled. And if it
-		 * was the opposite situation and we failed to
-		 * power down -- keep the regulator on
-		 */
-		on = !on;
+	if (!IS_ERR(domain->regulator)) {
+		ret = regulator_disable(domain->regulator);
+		if (ret)
+			dev_err(domain->dev, "failed to disable regulator\n");
 	}
 
-disable_clocks:
-	/* Disable reset clocks for all devices in the domain */
+	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+			   domain->bits.map, 0);
+
+	/* Disable all clocks */
 	for (i = 0; i < domain->num_clks; i++)
 		clk_disable_unprepare(domain->clk[i]);
 
-	if (has_regulator && !on) {
-		int err;
+	mutex_unlock(&gpc_pd_mutex);
+	return 0;
 
-		err = regulator_disable(domain->regulator);
-		if (err)
-			dev_err(domain->dev,
-				"failed to disable regulator: %d\n", err);
-		/* Preserve earlier error code */
-		ret = ret ?: err;
-	}
 unmap:
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, 0);
-	return ret;
-}
+	if (domain->bits.map)
+		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				   domain->bits.map, 0);
 
-static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
-{
-	return imx_gpc_pu_pgc_sw_pxx_req(genpd, true);
-}
+disable_clocks:
+	for (i--; i >= 0; i--)
+		clk_disable_unprepare(domain->clk[i]);
+
+	mutex_unlock(&gpc_pd_mutex);
+	return ret;
 
-static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
-{
-	return imx_gpc_pu_pgc_sw_pxx_req(genpd, false);
 }
 
 static const struct imx_pgc_domain imx7_pgc_domains[] = {
@@ -370,7 +458,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_GPU_SW_Pxx_REQ,
 			.map = IMX8M_GPU_A53_DOMAIN,
-			.hsk = IMX8M_GPU_HSK_PWRDNREQN,
+			.hsk_req = IMX8M_GPU_HSK_PWRDNREQN,
+			.hsk_ack = IMX8M_GPU_HSK_PWRDNACKN
 		},
 		.pgc   = IMX8M_PGC_GPU,
 	},
@@ -382,7 +471,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_VPU_SW_Pxx_REQ,
 			.map = IMX8M_VPU_A53_DOMAIN,
-			.hsk = IMX8M_VPU_HSK_PWRDNREQN,
+			.hsk_req = IMX8M_VPU_HSK_PWRDNREQN,
+			.hsk_ack = IMX8M_VPU_HSK_PWRDNACKN
 		},
 		.pgc   = IMX8M_PGC_VPU,
 	},
@@ -394,7 +484,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_DISP_SW_Pxx_REQ,
 			.map = IMX8M_DISP_A53_DOMAIN,
-			.hsk = IMX8M_DISP_HSK_PWRDNREQN,
+			.hsk_req = IMX8M_DISP_HSK_PWRDNREQN,
+			.hsk_ack = IMX8M_DISP_HSK_PWRDNACKN
 		},
 		.pgc   = IMX8M_PGC_DISP,
 	},
-- 
2.25.1


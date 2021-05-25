Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9AD38F754
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhEYBJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhEYBJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:09:14 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1CEC061574;
        Mon, 24 May 2021 18:07:45 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b25so11437322iot.5;
        Mon, 24 May 2021 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOmSoHd45k/En0UqK1OQagmHQENYt50xkIt6EPZ+HoE=;
        b=kAUyYTePrexTMYHACbI7T2kFKf67e3C0Npj86gAKh871Nt9/jVTFQjg6JtIrtHJgXk
         oE39x+qFBP/D6M5y8cbJ2UcqWzOn8HqvVadn1YeX9DsEwYdHjlEpDwvKxP0ekx8sXA8x
         5QyEcxSVms4dTVehlfGQ80kOyDpf8FzxGBn1bo9WipWP0INBDsX4FIKLt8up9Buo3bit
         77M4h58T1+i0WhmQblpK6xa4qnWGHMVMyv7bjsPA0PJi9JfkqKkz+7+gCEoiwiUbx3Ov
         r8VSqT7bOMz+6DaksnvGRFN6a/TSuvKb+DbgeEn5YK4QKQyjhh8VwciSGAxzb+21Jp4M
         TB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOmSoHd45k/En0UqK1OQagmHQENYt50xkIt6EPZ+HoE=;
        b=TcYz7TKvse/EkgJ8TSyn08iQVfbDJwdMBYPTh0d3C9ER4ZsTPewS8oUg4A4bx6tmGS
         8o0D6+GksH0jDnbNoAcL/RLP6hn19K3aoqfcGWXV7R89wVILU3ZoowuMMGFEsFUu9A/e
         d8sDSPEa/kaoqt8CQ46rhRZXye1SR5RmAhm8HWKBTgpW6LjZgtJR33ZmORvESps42QCE
         Tc6RXqJArt8dyCqadhDiZd2uemartKtkpybzkKicv6gwrKbrAcl5NyFEODqaHuzx5j+d
         veCrpWx7rwVo17LCw+v6YG1J1sNeIzoYfbEo6qbfDGjb9Ucp38GWew8h2KLZDBYrv9r6
         ujHA==
X-Gm-Message-State: AOAM532eK/AZz3XFrN3QovCeJwnG1TBrVUjlkbOhcqu5rmrcwMxgl+99
        6xqnsYea22ycjpkjJkdlnyM=
X-Google-Smtp-Source: ABdhPJyHGifYNR3NE2Uja6AAjEFLyQ2Nn4vdEscwH7jHN7qPfFQizAYFbJwP5gR+Re/XGoNr7gbl/A==
X-Received: by 2002:a5e:a902:: with SMTP id c2mr17710970iod.80.1621904864761;
        Mon, 24 May 2021 18:07:44 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:599b:b8c7:b3a9:9f1d])
        by smtp.gmail.com with ESMTPSA id w20sm12318413ilj.16.2021.05.24.18.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 18:07:44 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] soc: imx: gpcv2: add support for i.MX8MN power domains
Date:   Mon, 24 May 2021 20:07:29 -0500
Message-Id: <20210525010732.115562-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525010732.115562-1-aford173@gmail.com>
References: <20210525010732.115562-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the power domains founds on i.MX8MN. The Nano
has fewer domains than the Mini, and the access to some of these domains
is different than that of the Mini, the Mini power domains cannot be
reused.

Signed-off-by: Adam Ford <aford173@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 35bbb1bc5159..3120718e1dd7 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -20,6 +20,7 @@
 #include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
 #include <dt-bindings/power/imx8mm-power.h>
+#include <dt-bindings/power/imx8mn-power.h>
 
 #define GPC_LPCR_A_CORE_BSC			0x000
 
@@ -58,6 +59,12 @@
 #define IMX8MM_PCIE_A53_DOMAIN			BIT(3)
 #define IMX8MM_MIPI_A53_DOMAIN			BIT(2)
 
+#define IMX8MN_DISPMIX_A53_DOMAIN		BIT(12)
+#define IMX8MN_GPUMIX_A53_DOMAIN		BIT(9)
+#define IMX8MN_DDR1_A53_DOMAIN		BIT(7)
+#define IMX8MN_OTG1_A53_DOMAIN		BIT(4)
+#define IMX8MN_MIPI_A53_DOMAIN		BIT(2)
+
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
 
@@ -94,6 +101,12 @@
 #define IMX8MM_PCIE_SW_Pxx_REQ			BIT(1)
 #define IMX8MM_MIPI_SW_Pxx_REQ			BIT(0)
 
+#define IMX8MN_DISPMIX_SW_Pxx_REQ		BIT(10)
+#define IMX8MN_GPUMIX_SW_Pxx_REQ		BIT(7)
+#define IMX8MN_DDR1_SW_Pxx_REQ		BIT(5)
+#define IMX8MN_OTG1_SW_Pxx_REQ		BIT(2)
+#define IMX8MN_MIPI_SW_Pxx_REQ		BIT(0)
+
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
 #define GPC_PU_PWRHSK			0x1fc
@@ -116,6 +129,14 @@
 #define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
 #define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
 #define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
+
+#define IMX8MN_GPUMIX_HSK_PWRDNACKN		(BIT(29) | BIT(27))
+#define IMX8MN_DISPMIX_HSK_PWRDNACKN		BIT(25)
+#define IMX8MN_HSIO_HSK_PWRDNACKN		BIT(23)
+#define IMX8MN_GPUMIX_HSK_PWRDNREQN		(BIT(11) | BIT(9))
+#define IMX8MN_DISPMIX_HSK_PWRDNREQN		BIT(7)
+#define IMX8MN_HSIO_HSK_PWRDNREQN		BIT(5)
+
 /*
  * The PGC offset values in Reference Manual
  * (Rev. 1, 01/2018 and the older ones) GPC chapter's
@@ -152,6 +173,12 @@
 #define IMX8MM_PGC_VPUG2		28
 #define IMX8MM_PGC_VPUH1		29
 
+#define IMX8MN_PGC_MIPI		16
+#define IMX8MN_PGC_OTG1		18
+#define IMX8MN_PGC_DDR1		21
+#define IMX8MN_PGC_GPUMIX		23
+#define IMX8MN_PGC_DISPMIX		26
+
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
@@ -764,6 +791,71 @@ static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
 	.reg_access_table = &imx8mm_access_table,
 };
 
+static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
+	[IMX8MN_POWER_DOMAIN_HSIOMIX] = {
+		.genpd = {
+			.name = "hsiomix",
+		},
+		.bits  = {
+			.pxx = 0, /* no power sequence control */
+			.map = 0, /* no power sequence control */
+			.hskreq = IMX8MN_HSIO_HSK_PWRDNREQN,
+			.hskack = IMX8MN_HSIO_HSK_PWRDNACKN,
+		},
+	},
+
+	[IMX8MN_POWER_DOMAIN_OTG1] = {
+		.genpd = {
+			.name = "usb-otg1",
+		},
+		.bits  = {
+			.pxx = IMX8MN_OTG1_SW_Pxx_REQ,
+			.map = IMX8MN_OTG1_A53_DOMAIN,
+		},
+		.pgc   = IMX8MN_PGC_OTG1,
+	},
+
+	[IMX8MN_POWER_DOMAIN_GPUMIX] = {
+		.genpd = {
+			.name = "gpumix",
+		},
+		.bits  = {
+			.pxx = IMX8MN_GPUMIX_SW_Pxx_REQ,
+			.map = IMX8MN_GPUMIX_A53_DOMAIN,
+			.hskreq = IMX8MN_GPUMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MN_GPUMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = IMX8MN_PGC_GPUMIX,
+	},
+};
+
+static const struct regmap_range imx8mn_yes_ranges[] = {
+	regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+			 GPC_PU_PWRHSK),
+	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_MIPI),
+			 GPC_PGC_SR(IMX8MN_PGC_MIPI)),
+	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_OTG1),
+			 GPC_PGC_SR(IMX8MN_PGC_OTG1)),
+	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_DDR1),
+			 GPC_PGC_SR(IMX8MN_PGC_DDR1)),
+	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_GPUMIX),
+			 GPC_PGC_SR(IMX8MN_PGC_GPUMIX)),
+	regmap_reg_range(GPC_PGC_CTRL(IMX8MN_PGC_DISPMIX),
+			 GPC_PGC_SR(IMX8MN_PGC_DISPMIX)),
+};
+
+static const struct regmap_access_table imx8mn_access_table = {
+	.yes_ranges	= imx8mn_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(imx8mn_yes_ranges),
+};
+
+static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
+	.domains = imx8mn_pgc_domains,
+	.domains_num = ARRAY_SIZE(imx8mn_pgc_domains),
+	.reg_access_table = &imx8mn_access_table,
+};
+
+
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
@@ -948,6 +1040,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8mm_pgc_domain_data, },
+	{ .compatible = "fsl,imx8mn-gpc", .data = &imx8mn_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
 	{ }
 };
-- 
2.25.1


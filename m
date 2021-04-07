Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C430E3576B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhDGVWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhDGVVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:21:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550D1C061765;
        Wed,  7 Apr 2021 14:21:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x15so10231782wrq.3;
        Wed, 07 Apr 2021 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8ngQ/qQ8Weuy1yqO9HG4J00ciWdsd3MWP0cjimJPkc=;
        b=C3TCxPmUYVy4U/tF+I1Fh1OLG9wqPm7A1ArCrx1ZYzrt5UD5EyH4HBFZYvK7c7ysCI
         WKFvndVJdYI+3cxIq5HCFvSIVYH3n9G1gBoH7NGfICw2EWjKAziVojOGn0XCu8nsAY/I
         OtBCa7LhS7VkGaborgVexzPWO8KHF+3Fkik+JhGhxsFS+rog7BswM87k6Cfskm25qgqJ
         kGGv5lpDzNM4mqs4GwuG0MWkXABAfyd8s7/TC4zpVOQaGMFMRJq5JSjLJQhN6MCdF1P8
         BMbluiGbuWxzX3Zxq5j6vl2IMkfYQZ5g4U9BOcyWa/8B5JPmBYx/Ru72GAQJZg9w4ilX
         IIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8ngQ/qQ8Weuy1yqO9HG4J00ciWdsd3MWP0cjimJPkc=;
        b=g+FgfBFMNvODhnUmTNfXbgvS8yxWn+dfX/ah+Fp3Rmk+HQl5Bq+n4iSs5qh3Xjt48d
         24cnDu9F7r677kR+hna+RbpCXDij3G4GqaCV8aLFLBvP9o/eh7m0hJeWeenPPXNscQFB
         jzOij0iUncjZVz6TI1Qv4BtIozDpl2I4+AqDb/EhrkDRWoB9n5uKeXD03SdP4T9YBH6j
         QlXFwB23M9YwkvGLor1/BIHyHo/EPDqH+12GXc1HXIYQYi0ZEnYxJM0buz7fG4AYzPDo
         MuIlq8X8lJ686q6+OG8GiAT19P34Fp9J6zX6AGWrlJsenZYEuy3bIh3Qg4mC8cbJEU4G
         QZRw==
X-Gm-Message-State: AOAM531n+9TOWYNaBpAdL/ma837QBHRxcP/RlvnBzeYGgKEsPI2gxni3
        SktmM3CQn7Q8XjpyfqeneTrQ5f2Hk1jkdQ==
X-Google-Smtp-Source: ABdhPJwV/H7G5Ylw18MK4ozOBB5I4Gcl1khWcTYtonjBlD7+FhLtLorNaNriv3LLEGhhSbE7PznZMQ==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr6737511wrm.148.1617830489880;
        Wed, 07 Apr 2021 14:21:29 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270041a0a0f4308eafc0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:41a0:a0f4:308e:afc0])
        by smtp.gmail.com with ESMTPSA id l14sm17173952wrm.77.2021.04.07.14.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 14:21:29 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, Anson.Huang@nxp.com, krzk@kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, qiangqing.zhang@nxp.com,
        alice.guo@nxp.com, aford173@gmail.com, agx@sigxcpu.org,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 3/7] soc: imx: gpcv2: allow domains without power sequence control
Date:   Wed,  7 Apr 2021 23:21:18 +0200
Message-Id: <20210407212122.626137-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407212122.626137-1-adrien.grassein@gmail.com>
References: <20210407212122.626137-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On new SOCs, some domains does not have power sequence control
registers.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/soc/imx/gpcv2.c | 134 +++++++++++++++++++++-------------------
 1 file changed, 72 insertions(+), 62 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 7afb81489f21..d97a53502753 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -162,40 +162,44 @@ static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
 	}
 
 	/* Map the domain to the A53 core */
-	ret = regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-				 domain->bits.map, domain->bits.map);
-	if (ret) {
-		dev_err(domain->dev, "failed to map GPC PGC domain\n");
-		goto disable_clocks;
+	if (domain->bits.map) {
+		ret = regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+					 domain->bits.map, domain->bits.map);
+		if (ret) {
+			dev_err(domain->dev, "failed to map GPC PGC domain\n");
+			goto disable_clocks;
+		}
 	}
 
 	/* Request Power Up of the domain */
-	ret = regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
-				 domain->bits.pxx, domain->bits.pxx);
-	if (ret) {
-		dev_err(domain->dev, "failed to command PGC\n");
-		goto unmap;
-	}
+	if (domain->bits.pxx) {
+		ret = regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
+					 domain->bits.pxx, domain->bits.pxx);
+		if (ret) {
+			dev_err(domain->dev, "failed to command PGC\n");
+			goto unmap;
+		}
 
-	/*
-	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
-	 * for PUP_REQ/PDN_REQ bit to be cleared
-	 */
-	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
-				       value,
-				       !(value & domain->bits.pxx),
-				       0, USEC_PER_MSEC);
-	if (ret) {
-		dev_err(domain->dev, "failed to command PGC\n");
-		goto unmap;
-	}
+		/*
+		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+		 * for PUP_REQ/PDN_REQ bit to be cleared
+		 */
+		ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
+					       value,
+					       !(value & domain->bits.pxx),
+					       0, USEC_PER_MSEC);
+		if (ret) {
+			dev_err(domain->dev, "failed to command PGC\n");
+			goto unmap;
+		}
 
-	/* Disable power control */
-	ret = regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-				 GPC_PGC_CTRL_PCR, 0);
-	if (ret) {
-		dev_err(domain->dev, "Failed to disable power control !\n");
-		goto unmap;
+		/* Disable power control */
+		ret = regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+					 GPC_PGC_CTRL_PCR, 0);
+		if (ret) {
+			dev_err(domain->dev, "Failed to disable power control !\n");
+			goto unmap;
+		}
 	}
 
 	/* request the ADB400 to power up */
@@ -212,8 +216,9 @@ static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
 				genpd->name);
 	}
 
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, 0);
+	if (domain->bits.map)
+		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				   domain->bits.map, 0);
 
 	/* Disable all clocks */
 	for (i = 0; i < domain->num_clks; i++)
@@ -256,11 +261,13 @@ static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
 	}
 
 	/* Map the domain to the A53 core */
-	ret = regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-				 domain->bits.map, domain->bits.map);
-	if (ret) {
-		dev_err(domain->dev, "failed to map GPC PGC domain\n");
-		goto disable_clocks;
+	if (domain->bits.map) {
+		ret = regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+					 domain->bits.map, domain->bits.map);
+		if (ret) {
+			dev_err(domain->dev, "failed to map GPC PGC domain\n");
+			goto disable_clocks;
+		}
 	}
 
 	/* request the ADB400 to power down */
@@ -278,32 +285,34 @@ static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
 
 	}
 
-	/* Enable power control */
-	ret = regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-				 GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
-	if (ret) {
-		dev_err(domain->dev, "Failed to enable power control !\n");
-		goto unmap;
-	}
+	if (domain->bits.pxx) {
+		/* Enable power control */
+		ret = regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+					 GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
+		if (ret) {
+			dev_err(domain->dev, "Failed to enable power control !\n");
+			goto unmap;
+		}
 
-	/* Request Power Down of the domain */
-	ret = regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
-				 domain->bits.pxx, domain->bits.pxx);
-	if (ret) {
-		dev_err(domain->dev, "failed to command PGC\n");
-		goto unmap;
-	}
+		/* Request Power Down of the domain */
+		ret = regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
+					 domain->bits.pxx, domain->bits.pxx);
+		if (ret) {
+			dev_err(domain->dev, "failed to command PGC\n");
+			goto unmap;
+		}
 
-	/*
-	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
-	 * for PUP_REQ/PDN_REQ bit to be cleared
-	 */
-	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
-				       value,
-				       !(value & domain->bits.pxx),
-				       0, USEC_PER_MSEC);
-	if (ret)
-		dev_err(domain->dev, "failed to command PGC\n");
+		/*
+		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+		 * for PUP_REQ/PDN_REQ bit to be cleared
+		 */
+		ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
+					       value,
+					       !(value & domain->bits.pxx),
+					       0, USEC_PER_MSEC);
+		if (ret)
+			dev_err(domain->dev, "failed to command PGC\n");
+	}
 
 	if (!IS_ERR(domain->regulator)) {
 		ret = regulator_disable(domain->regulator);
@@ -311,8 +320,9 @@ static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
 			dev_err(domain->dev, "failed to disable regulator\n");
 	}
 
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, 0);
+	if (domain->bits.map)
+		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				   domain->bits.map, 0);
 
 	/* Disable all clocks */
 	for (i = 0; i < domain->num_clks; i++)
-- 
2.25.1


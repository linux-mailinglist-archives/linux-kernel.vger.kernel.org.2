Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB83576AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhDGVWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhDGVVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:21:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17A2C061761;
        Wed,  7 Apr 2021 14:21:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e12so6381043wro.11;
        Wed, 07 Apr 2021 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mP+Vc0+rJsbzL9hsHa8A36fu38vw4kqpWBwZhYOxhTg=;
        b=RexRqRaA26YijY8LmnBbuW7KCplc8yGNRT7Y3PgP+x6oLQr0EX+Pjg/MCDhLTzZPSy
         iq9tPnGleVrYt4i95Bs5pGJa7TU14ZGKZWwcblg/OPOQD6QaWNma/yJfPJUyd46MGR8U
         co6gdszVtlFmY5FKSIiYLRsVkYr0W7RjkG4ja3MjDEtRiKWVAlH41j755PebOTYyGQmP
         mEUD8TEY1JUvX4JksEhTitpYIbp/0jQRus5HbZrEj9u26RsSeoBZQi6rATqrdJdLeAcu
         qLxVW7imUNVhiTzUjovEEmAZltlxrZ0lwsjPsju+t2LZhqTBJsLY0RZ4kLWH4FFa7uCU
         cMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mP+Vc0+rJsbzL9hsHa8A36fu38vw4kqpWBwZhYOxhTg=;
        b=eCuDncVzGZ6YJhklK5o3iALGKCIzrsu+jRxAc9ANmNZVMLZGaNvABbie8wP02bzvop
         k1Oig8ab7AV64Ua2CUVPFth3eh+Jry/4FY1jFBraBQBA//fMaIjs4f1OzeUiXstAmCV5
         l1JZNArwp/42J2Sh2uwPigpLI+FllYlU8tUV7AxZ+fadPn5VMqYLj1tLo+sLTN6D9/B+
         yTy3rjHrouT6Umj7793Am3jCDxfzSGTf2Bbnll5L2HIUtfTEJLKFRIwOzRQdRHzja4iK
         Sd8VNg7+JAOoRE3yyajr7HkIjE4KHEIaf+989cVPT3YVfPhdomVbCJlTUVSXE2BG31UL
         oJ9w==
X-Gm-Message-State: AOAM531KIR963ADgdvyMdAIIAv5irfNx58Fzy9mACb+a41brXJrJvoBW
        hU3RCfvOSrClU2kdis1PGwk=
X-Google-Smtp-Source: ABdhPJzFvCLHif6HdG/+/FbfYRxVTDz6YWqnOsxzb25RExafgzamf7BRMgth1iJaJ/vXDZxny1FTew==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr6771728wrn.6.1617830487708;
        Wed, 07 Apr 2021 14:21:27 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270041a0a0f4308eafc0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:41a0:a0f4:308e:afc0])
        by smtp.gmail.com with ESMTPSA id l14sm17173952wrm.77.2021.04.07.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 14:21:27 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, Anson.Huang@nxp.com, krzk@kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, qiangqing.zhang@nxp.com,
        alice.guo@nxp.com, aford173@gmail.com, agx@sigxcpu.org,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 1/7] soc: imx: gpcv2: check for errors when r/w registers
Date:   Wed,  7 Apr 2021 23:21:16 +0200
Message-Id: <20210407212122.626137-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407212122.626137-1-adrien.grassein@gmail.com>
References: <20210407212122.626137-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errors were not checked after each access to registers
and clocks initialisation.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/soc/imx/gpcv2.c | 62 ++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index db7e7fc321b1..8ec5b1b817c7 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -140,8 +140,12 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	int i, ret = 0;
 	u32 pxx_req;
 
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, domain->bits.map);
+	ret = regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				 domain->bits.map, domain->bits.map);
+	if (ret) {
+		dev_err(domain->dev, "failed to map GPC PGC domain\n");
+		return ret;
+	}
 
 	if (has_regulator && on) {
 		ret = regulator_enable(domain->regulator);
@@ -152,19 +156,39 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	}
 
 	/* Enable reset clocks for all devices in the domain */
-	for (i = 0; i < domain->num_clks; i++)
-		clk_prepare_enable(domain->clk[i]);
+	for (i = 0; i < domain->num_clks; i++) {
+		ret = clk_prepare_enable(domain->clk[i]);
+		if (ret) {
+			dev_err(domain->dev, "failed to enable clocks\n");
+			goto disable_clocks;
+		}
+	}
 
-	if (enable_power_control)
-		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-				   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
+	if (enable_power_control) {
+		ret = regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+					 GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
+		if (ret) {
+			dev_err(domain->dev, "failed to enable power control\n");
+			goto disable_clocks;
+		}
+	}
 
-	if (domain->bits.hsk)
-		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
-				   domain->bits.hsk, on ? domain->bits.hsk : 0);
+	if (domain->bits.hsk) {
+		ret = regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
+					 domain->bits.hsk,
+					 on ? domain->bits.hsk : 0);
+		if (ret) {
+			dev_err(domain->dev, "Failed to initiate handshake\n");
+			goto disable_power_control;
+		}
+	}
 
-	regmap_update_bits(domain->regmap, offset,
-			   domain->bits.pxx, domain->bits.pxx);
+	ret = regmap_update_bits(domain->regmap, offset,
+				 domain->bits.pxx, domain->bits.pxx);
+	if (ret) {
+		dev_err(domain->dev, "failed to command PGC\n");
+		goto disable_power_control;
+	}
 
 	/*
 	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
@@ -173,8 +197,15 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	ret = regmap_read_poll_timeout(domain->regmap, offset, pxx_req,
 				       !(pxx_req & domain->bits.pxx),
 				       0, USEC_PER_MSEC);
-	if (ret) {
+	if (ret)
 		dev_err(domain->dev, "failed to command PGC\n");
+
+disable_power_control:
+	if (enable_power_control)
+		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+				   GPC_PGC_CTRL_PCR, 0);
+
+	if (ret) {
 		/*
 		 * If we were in a process of enabling a
 		 * domain and failed we might as well disable
@@ -185,10 +216,7 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 		on = !on;
 	}
 
-	if (enable_power_control)
-		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-				   GPC_PGC_CTRL_PCR, 0);
-
+disable_clocks:
 	/* Disable reset clocks for all devices in the domain */
 	for (i = 0; i < domain->num_clks; i++)
 		clk_disable_unprepare(domain->clk[i]);
-- 
2.25.1


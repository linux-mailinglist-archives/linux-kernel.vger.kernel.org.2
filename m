Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB443576B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhDGVW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhDGVVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:21:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9575C0613D8;
        Wed,  7 Apr 2021 14:21:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y20-20020a1c4b140000b029011f294095d3so1856107wma.3;
        Wed, 07 Apr 2021 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p1PTOuVujSZNdb+lfDvpozibockRl2kaTT+F2J5Pasw=;
        b=hU+4+AJxEKpFo9IbdYWwYFG4mcGdHdQEpeyEFyR7KnYM+l3iB/6u7xPo6yYaXgJKb+
         620IFEIBHIfhYbX5Bf93myZzGJeAUopB0AlVN12TXv6B0DW0QHexQBfUCOGBMbErKELc
         op20ywP+ZOSEEEdLm+nZwLH3xrnF1ztziA+0m1uIVGZBdkInI1FhjEga+6QKA41YEa4g
         dmImneFwW3s1WCzKJBxal7MRS9X/66EJNy99Jf9TY2uKUrAU9cBIeg7rSPeKLFqqW06L
         3Pkp+TBQDpdEfpdMjotT1M2XKmQgEO2SPwhp0sggPhnEBgOMg+OVKSMYW3VG+hX+YkKs
         r4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p1PTOuVujSZNdb+lfDvpozibockRl2kaTT+F2J5Pasw=;
        b=V92UAJI8N7jegq4StekOEeHYrSqnU47WggdzgV3vyJxeI+/i7DzXSLXG/DzRScf1hL
         sn6vhzPK1jODPhh4xGO6r4m4+b/XxqvC1TwlL3/VWf+Zzn4F1BD8SG+a23jVcE/eUhpb
         Man8Gajak5j1dEI1g2M54yL75VNKB0htXlKC1+32CDAJNCujtOoBKhLjmsijfAyFaXRL
         ar/NNREvwNoUg+6XHL9Upo0O6CU8puFCntVh9jCnEik90vAY43efAtFdtngRpHKVfoph
         90v848c8dgDrSNKXMJNUjorOwG+3OMAm/2u3K3YAs7TaUq7Pw/iKNrRPmkWrHF6yj7Sr
         gtew==
X-Gm-Message-State: AOAM531H0hEaoGuuazd0chNGWXjG0KjxpJqxN5M2f1sf47qMcEOOjeiA
        W3747KhHSOZ+N1DIlDoBsXoYRjmLPx7oiA==
X-Google-Smtp-Source: ABdhPJzx/PC85Ea03U9I6eTPnMVrWh7e0WLzu4mGuTVWxdV4P0bcDt0SF6lSDD1jMlDkZ4kMtB4zsQ==
X-Received: by 2002:a7b:c45a:: with SMTP id l26mr4954756wmi.85.1617830491411;
        Wed, 07 Apr 2021 14:21:31 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270041a0a0f4308eafc0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:41a0:a0f4:308e:afc0])
        by smtp.gmail.com with ESMTPSA id l14sm17173952wrm.77.2021.04.07.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 14:21:31 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, Anson.Huang@nxp.com, krzk@kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, qiangqing.zhang@nxp.com,
        alice.guo@nxp.com, aford173@gmail.com, agx@sigxcpu.org,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 5/7] soc: imx: gpcv2: add HSIOMIX and USB domains for i.MX8MM
Date:   Wed,  7 Apr 2021 23:21:20 +0200
Message-Id: <20210407212122.626137-6-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407212122.626137-1-adrien.grassein@gmail.com>
References: <20210407212122.626137-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for 3 domains of the i.MX8MM:
  - HSIO
  - USB OTG 1
  - USB OTG 2

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/soc/imx/gpcv2.c | 69 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index d97a53502753..571d0381dd87 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -17,6 +17,8 @@
 #include <linux/sizes.h>
 #include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
+#include <dt-bindings/power/imx8mm-power.h>
+
 
 #define GPC_LPCR_A_CORE_BSC			0x000
 
@@ -42,6 +44,9 @@
 #define IMX8M_PCIE1_A53_DOMAIN			BIT(3)
 #define IMX8M_MIPI_A53_DOMAIN			BIT(2)
 
+#define IMX8MM_OTG2_A53_DOMAIN			BIT(5)
+#define IMX8MM_OTG1_A53_DOMAIN			BIT(4)
+
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
 
@@ -65,6 +70,9 @@
 #define IMX8M_PCIE1_SW_Pxx_REQ			BIT(1)
 #define IMX8M_MIPI_SW_Pxx_REQ			BIT(0)
 
+#define IMX8MM_OTG1_SW_Pxx_REQ			BIT(2)
+#define IMX8MM_OTG2_SW_Pxx_REQ			BIT(3)
+
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
 #define GPC_PU_PWRHSK			0x1fc
@@ -76,6 +84,9 @@
 #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
 #define IMX8M_DISP_HSK_PWRDNACKN		BIT(24)
 
+#define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
+#define IMX8MM_HSIO_HSK_PWRDNACKN		(BIT(23) | BIT(24))
+
 /*
  * The PGC offset values in Reference Manual
  * (Rev. 1, 01/2018 and the older ones) GPC chapter's
@@ -98,6 +109,9 @@
 #define IMX8M_PGC_MIPI_CSI2		28
 #define IMX8M_PGC_PCIE2			29
 
+#define IMX8MM_PGC_OTG1			18
+#define IMX8MM_PGC_OTG2			19
+
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
@@ -572,6 +586,60 @@ static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
 	.reg_access_table = &imx8m_access_table,
 };
 
+static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
+	[IMX8MM_POWER_DOMAIN_HSIOMIX] = {
+		.genpd = {
+			.name = "hsiomix",
+		},
+		.bits  = {
+			.hsk_req = IMX8MM_HSIO_HSK_PWRDNREQN,
+			.hsk_ack = IMX8MM_HSIO_HSK_PWRDNACKN,
+		},
+	},
+
+	[IMX8MM_POWER_DOMAIN_USB_OTG1] = {
+		.genpd      = {
+			.name = "usb-otg1",
+		},
+		.bits       = {
+			.pxx = IMX8MM_OTG1_SW_Pxx_REQ,
+			.map = IMX8MM_OTG1_A53_DOMAIN,
+		},
+		.pgc        = IMX8MM_PGC_OTG1,
+	},
+
+	[IMX8MM_POWER_DOMAIN_USB_OTG2] = {
+		.genpd      = {
+			.name = "usb-otg2",
+		},
+		.bits       =  {
+			.pxx = IMX8MM_OTG2_SW_Pxx_REQ,
+			.map = IMX8MM_OTG2_A53_DOMAIN,
+		},
+		.pgc        = IMX8MM_PGC_OTG2,
+	},
+};
+
+static const struct regmap_range imx8mm_yes_ranges[] = {
+		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+				 GPC_PU_PWRHSK),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG1),
+				 GPC_PGC_SR(IMX8MM_PGC_OTG1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG2),
+				 GPC_PGC_SR(IMX8MM_PGC_OTG2)),
+};
+
+static const struct regmap_access_table imx8mm_access_table = {
+	.yes_ranges	= imx8mm_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(imx8mm_yes_ranges),
+};
+
+static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
+	.domains = imx8mm_pgc_domains,
+	.domains_num = ARRAY_SIZE(imx8mm_pgc_domains),
+	.reg_access_table = &imx8mm_access_table,
+};
+
 static int imx_pgc_get_clocks(struct imx_pgc_domain *domain)
 {
 	int i, ret;
@@ -766,6 +834,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
+	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8mm_pgc_domain_data, },
 	{ }
 };
 
-- 
2.25.1


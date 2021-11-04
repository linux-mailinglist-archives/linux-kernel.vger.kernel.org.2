Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A3445717
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhKDQV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhKDQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:15 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6786FC061210;
        Thu,  4 Nov 2021 09:18:37 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id f10so6745530ilu.5;
        Thu, 04 Nov 2021 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V8Fc8ke3iYOumBqOlWNgqlYhlma1UuQm/49sDGNHcnE=;
        b=BU9ivg121YwQ/viUzudfS8N488FYWmgpv4k45+ar6xwhzo1d0vjzRJv9tCAb+4JsTt
         7K5DVTwxJv5137PcMeEyHVkDEEE2OlElJkAB/PRTICIC0lLZNBV8F+FFArezB2iWi8S/
         XWAd8e+v7SEm3naqNdYvWWY9cs4AFIPCTkv/ZV/V4u2FVQqWQkLsyqxJ8GxB9BBj7RAg
         nIQW3VgwW/k2LUHNeA4FEA4D9vjDNjaZW4QWsxzfePbIU+G40RC5bLWtIYEDibhzfcVH
         dFSJSGr7ql+AzDWZdQaIMj7ebg9wL5zttgHA0EjEhtWVG/884wmFcBciMSZJ3NDr0Piy
         Hc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V8Fc8ke3iYOumBqOlWNgqlYhlma1UuQm/49sDGNHcnE=;
        b=I2y+uivo1/q/lNX7mqNL2KT/eT5oAUFE9nKANRtqgaTXbu0R60T47VkUp7ZZ4DZp4V
         nNfpuYgufK7859eMmAPUf0zdONi2xM5zaBMZsU85QIlrhZ4JjBdVwWZ6SHleVwv3IX22
         PXEzQ4EjPI7L7sBMYbdEQaKpZahlQB9A0B/v7KVL2hjOuf5PH913NXuzPqnP3L2Q1OdG
         yn2MOmVWcSK0KBzJmb+TtiLcBU1tgLD0cj6EM+Y2zoqH6hoQhPBulWEDoNverIo2W0BK
         jf7zElTFf64BWrjj3Twq6Gg2Wu2T0SrH3sslwg5qCfv99nyLUf9rLZirv5BEFUO/MDvZ
         XczA==
X-Gm-Message-State: AOAM530Lf4x4I6gOUj2iNdFLH0gd1ANwE8nXtvoc5XLjEVkzSvpIYFhu
        ohFxb12Y5dzU4E6nlKxp5+Q=
X-Google-Smtp-Source: ABdhPJxb3gLA4v3sKw6lJ/XP1t20YrngWSaBe9t0FzVYUDsfncWtAjMnrkXDOK1nt3aMKrzUCStRHA==
X-Received: by 2002:a05:6e02:19c8:: with SMTP id r8mr6214329ill.47.1636042716748;
        Thu, 04 Nov 2021 09:18:36 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e81d:737a:bb84:83ba])
        by smtp.gmail.com with ESMTPSA id e17sm3266326iow.18.2021.11.04.09.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:18:36 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, ariel.dalessandro@collabora.com,
        krzk@kernel.org, tharvey@gateworks.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/9] soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
Date:   Thu,  4 Nov 2021 11:18:00 -0500
Message-Id: <20211104161804.587250-6-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211104161804.587250-1-aford173@gmail.com>
References: <20211104161804.587250-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the description for the i.MX8MN disp blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 519b3651d1d9..6feeff5a3776 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
+#include <dt-bindings/power/imx8mn-power.h>
 
 #define BLK_SFT_RSTN	0x0
 #define BLK_CLK_EN	0x4
@@ -498,6 +499,75 @@ static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
 	.num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
 };
 
+
+static int imx8mn_disp_power_notifier(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+						 power_nb);
+
+	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
+		return NOTIFY_OK;
+
+	/* Enable bus clock and deassert bus reset */
+	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(8));
+	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(8));
+
+	/*
+	 * On power up we have no software backchannel to the GPC to
+	 * wait for the ADB handshake to happen, so we just delay for a
+	 * bit. On power down the GPC driver waits for the handshake.
+	 */
+	if (action == GENPD_NOTIFY_ON)
+		udelay(5);
+
+
+	return NOTIFY_OK;
+}
+
+static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
+	[IMX8MN_DISPBLK_PD_MIPI_DSI] = {
+		.name = "dispblk-mipi-dsi",
+		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
+		.num_clks = 2,
+		.gpc_name = "mipi-dsi",
+		.rst_mask = BIT(0) | BIT(1),
+		.clk_mask = BIT(0) | BIT(1),
+	},
+	[IMX8MN_DISPBLK_PD_MIPI_CSI] = {
+		.name = "dispblk-mipi-csi",
+		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
+		.num_clks = 2,
+		.gpc_name = "mipi-csi",
+		.rst_mask = BIT(2) | BIT(3),
+		.clk_mask = BIT(2) | BIT(3),
+	},
+	[IMX8MN_DISPBLK_PD_LCDIF] = {
+		.name = "dispblk-lcdif",
+		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
+		.num_clks = 3,
+		.gpc_name = "lcdif",
+		.rst_mask = BIT(4) | BIT(5),
+		.clk_mask = BIT(4) | BIT(5),
+	},
+	[IMX8MN_DISPBLK_PD_ISI] = {
+		.name = "dispblk-isi",
+		.clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
+						"disp_apb_root"},
+		.num_clks = 4,
+		.gpc_name = "isi",
+		.rst_mask = BIT(6) | BIT(7),
+		.clk_mask = BIT(6) | BIT(7),
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
+	.max_reg = 0x84,
+	.power_notifier_fn = imx8mn_disp_power_notifier,
+	.domains = imx8mn_disp_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
+};
+
 static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
 	{
 		.compatible = "fsl,imx8mm-vpu-blk-ctrl",
@@ -505,7 +575,10 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
 	}, {
 		.compatible = "fsl,imx8mm-disp-blk-ctrl",
 		.data = &imx8mm_disp_blk_ctl_dev_data
-	} ,{
+	}, {
+		.compatible = "fsl,imx8mn-disp-blk-ctrl",
+		.data = &imx8mn_disp_blk_ctl_dev_data
+	}, {
 		/* Sentinel */
 	}
 };
-- 
2.32.0


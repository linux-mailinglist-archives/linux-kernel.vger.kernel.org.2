Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548A24234C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhJFAH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbhJFAHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:07:14 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADA0C061749;
        Tue,  5 Oct 2021 17:05:23 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id k13so1075076ilo.7;
        Tue, 05 Oct 2021 17:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akNDEe+kJOl28ay+y5Gnkbqr2EBbo/gtcDP1PA6ZmAo=;
        b=dezX+RhlSeS7JzthKehV0pZYqy9zHkI0EbuQRQbHoOKuQ3+JYiPWJVntXtZ1K0ESPT
         FOQMOKPk3aryIvRUHhKQFd2PElQhdmj5rcCRsr23N3NP99+66NIFI0qPbF+cXBhaecwS
         5omRvtmqraYsbGBEo2hGf/ASjHhJ8Xoa1C2SLZSiJhITTSBeUNgjlqdzS4v6jtsWV3dg
         tzLj41VMY1P+Qz8e8einbXLixHG5GjhPfUYFk+pnoy1YGrQq9dL+S7aQUKj5RI01KJgq
         RJG6hKuGLafxjYLSgj6SURNNm4cCu66yb6uGcOaRadjnx0XjmQ0373pcDisQeAVQ/ZKL
         kF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akNDEe+kJOl28ay+y5Gnkbqr2EBbo/gtcDP1PA6ZmAo=;
        b=GAY7NVyBNfOpmUty0yNV97Q4eOIqiV8iv+SsK7jJL28kkNy9ywCl8pXb9812l074SG
         YgcFhaT+qkcyE8PL/PkwlYxP+ws0Wpil//f7UvAhH89nhCLW2Ljkr0u6Rdm7r3MhJ0gE
         dKy2jrq3JVeBGyfNVtgvg1FIhY3VV+9LOdGysWhd1wo/chMHvaC7ONn+aCQ0Zg+dqIv6
         X6MXcFKUrC34Z74Dix34OkZE9LqEfoJAdLUnOEwBRajYV+y8rQemVILY55Q7QgKW57y2
         O41LGBMtU+2RzTubT3loHBj+4pWTro4swJSru9MfJtTINkzFO5DTMaQnUQDwKV3jnxJP
         0SvQ==
X-Gm-Message-State: AOAM533nangntmK8BNRVCGpibalyWeq0gkGI2jnbl/QOl6i9XJvTGhKI
        a1F3ZTDHaZDi3YlSRmR2eRs=
X-Google-Smtp-Source: ABdhPJz9NzE0MxRp7tokSSNfE0HMMX9kyD6FZUznh+ikcZtyTem0x8X1s+RfK19RaVablqOiHuW2zw==
X-Received: by 2002:a05:6e02:893:: with SMTP id z19mr5013863ils.224.1633478722865;
        Tue, 05 Oct 2021 17:05:22 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:94fc:9a4b:2e18:e915])
        by smtp.gmail.com with ESMTPSA id y2sm11338646ioj.12.2021.10.05.17.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 17:05:22 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
Date:   Tue,  5 Oct 2021 19:05:00 -0500
Message-Id: <20211006000505.627334-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006000505.627334-1-aford173@gmail.com>
References: <20211006000505.627334-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the description for the i.MX8MN disp blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index e172d295c441..8fcd5ed62f50 100644
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
+		.num_clks = 2,
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
-- 
2.25.1


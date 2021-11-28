Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AD3460672
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345293AbhK1NYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353041AbhK1NWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:22:44 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEFCC061759;
        Sun, 28 Nov 2021 05:19:25 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e144so17481248iof.3;
        Sun, 28 Nov 2021 05:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdAf9ZB6zSzEhceNqpvmTSzYWMmYY2ll5WtGsCcXMcg=;
        b=hzjfNrqxNOeq0v/oL0+39IH8f9zj+btuHf/SsI2cr+z879KYQFJTRA51i7ejyKfo4F
         GM6x9hfmbQ3k0eqgalAidlwQbAPSocTjYQY1m39+kM+WxZwALVPglnx/OgAMu8xNYOUm
         l6ijcGioF+ZhWMME/8bEkaAzm+Tdr7EujTC4bcNlS0wYTj5Ul/CC3CXpIVNq1OZiJqZp
         WzY/OFMOhfrJuRYOXcXoyQ3+Kti3HanWKvSbfaEBcyeaklk+ZbboECeBtpyDFMcmagru
         9TofPWBPDsTo9cYzDdF6jLzk+35IXNOUyHuKMEf5eXWLE0bsrvifVQ0Y2069wyIfyM2q
         ur9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdAf9ZB6zSzEhceNqpvmTSzYWMmYY2ll5WtGsCcXMcg=;
        b=2/MzGS1w5ztSmjG6ecwaJcvpOH35uEdPvJi+iKRSELTNqaTNs5D/9PpAqR7WhqqiAR
         nCU8bbQp/8bh7+RTnAuonkwAsvQRVCzVnJmJj7Eh2iEymHMfoPNNI1QVRf+dMJVTeAiX
         c4kkAlIg06Y6rU75WVK344objGil7ZnJYP97U6EBpXf8hrjK1I5gSPYfJ6pkSiNZDiH2
         rgCdl55Oh0ljDRhPS8SzX1gBnn6vD8P0ozHHmfuNHnGWU/XWbtjkwH2MdXqxaw+9WCay
         nPQA7wtAifwSXoFWRkYZZOo4C7LUmJ1yA2R8qov+wp3f5w3EVUQyJ3EFTjCIus783Ds0
         +rwA==
X-Gm-Message-State: AOAM533WKo806Y4MJOyqsGM4XEblRd9DZvOn0cB0HU2Myz7DD9lgrKkF
        PnGDM5YLA3uu/F9KqqkxXWY=
X-Google-Smtp-Source: ABdhPJwR66IYRKxMA7e6L83tcP4mPWpEDky5lKphfCV6/DwHbdyPovddPMoWKa0W+3LjkwnBZybONw==
X-Received: by 2002:a5e:840f:: with SMTP id h15mr51226709ioj.48.1638105565065;
        Sun, 28 Nov 2021 05:19:25 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id q12sm6990413ile.77.2021.11.28.05.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:19:24 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 5/9] soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
Date:   Sun, 28 Nov 2021 07:18:48 -0600
Message-Id: <20211128131853.15125-6-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128131853.15125-1-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the description for the i.MX8MN disp blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 77 +++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index c2f076b56e24..511e74f0db8a 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>

 #include <dt-bindings/power/imx8mm-power.h>
+#include <dt-bindings/power/imx8mn-power.h>

 #define BLK_SFT_RSTN	0x0
 #define BLK_CLK_EN	0x4
@@ -517,6 +518,77 @@ static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
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
+		.mipi_phy_rst_mask = BIT(17),
+	},
+	[IMX8MN_DISPBLK_PD_MIPI_CSI] = {
+		.name = "dispblk-mipi-csi",
+		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
+		.num_clks = 2,
+		.gpc_name = "mipi-csi",
+		.rst_mask = BIT(2) | BIT(3),
+		.clk_mask = BIT(2) | BIT(3),
+		.mipi_phy_rst_mask = BIT(16),
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
@@ -524,7 +596,10 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
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


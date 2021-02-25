Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5090A3254D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhBYRwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhBYRu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:50:56 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399A9C061786
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:50:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 644291F463C9
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/4] soc: mediatek: pm-domains: Add a power domain names for mt8183
Date:   Thu, 25 Feb 2021 18:49:58 +0100
Message-Id: <20210225175000.824661-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225175000.824661-1-enric.balletbo@collabora.com>
References: <20210225175000.824661-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power domains names for the mt8183 SoC. This removes the debugfs
errors like the following:

  debugfs: Directory 'power-domain' with parent 'pm_genpd' already present!

Fixes: eb9fa767fbe1 ("soc: mediatek: pm-domains: Add support for mt8183")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mt8183-pm-domains.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/soc/mediatek/mt8183-pm-domains.h
index aa5230e6c12f..98a9940d05fb 100644
--- a/drivers/soc/mediatek/mt8183-pm-domains.h
+++ b/drivers/soc/mediatek/mt8183-pm-domains.h
@@ -12,12 +12,14 @@
 
 static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 	[MT8183_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
 		.sta_mask = PWR_STATUS_AUDIO,
 		.ctl_offs = 0x0314,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 	},
 	[MT8183_POWER_DOMAIN_CONN] = {
+		.name = "conn",
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = 0x032c,
 		.sram_pdn_bits = 0,
@@ -28,12 +30,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		},
 	},
 	[MT8183_POWER_DOMAIN_MFG_ASYNC] = {
+		.name = "mfg_async",
 		.sta_mask = PWR_STATUS_MFG_ASYNC,
 		.ctl_offs = 0x0334,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
 	},
 	[MT8183_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
 		.sta_mask = PWR_STATUS_MFG,
 		.ctl_offs = 0x0338,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -41,18 +45,21 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.caps = MTK_SCPD_DOMAIN_SUPPLY,
 	},
 	[MT8183_POWER_DOMAIN_MFG_CORE0] = {
+		.name = "mfg_core0",
 		.sta_mask = BIT(7),
 		.ctl_offs = 0x034c,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
 	[MT8183_POWER_DOMAIN_MFG_CORE1] = {
+		.name = "mfg_core1",
 		.sta_mask = BIT(20),
 		.ctl_offs = 0x0310,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
 	[MT8183_POWER_DOMAIN_MFG_2D] = {
+		.name = "mfg_2d",
 		.sta_mask = PWR_STATUS_MFG_2D,
 		.ctl_offs = 0x0348,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -65,6 +72,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		},
 	},
 	[MT8183_POWER_DOMAIN_DISP] = {
+		.name = "disp",
 		.sta_mask = PWR_STATUS_DISP,
 		.ctl_offs = 0x030c,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -83,6 +91,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		},
 	},
 	[MT8183_POWER_DOMAIN_CAM] = {
+		.name = "cam",
 		.sta_mask = BIT(25),
 		.ctl_offs = 0x0344,
 		.sram_pdn_bits = GENMASK(9, 8),
@@ -105,6 +114,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		},
 	},
 	[MT8183_POWER_DOMAIN_ISP] = {
+		.name = "isp",
 		.sta_mask = PWR_STATUS_ISP,
 		.ctl_offs = 0x0308,
 		.sram_pdn_bits = GENMASK(9, 8),
@@ -127,6 +137,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		},
 	},
 	[MT8183_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
 		.sta_mask = BIT(31),
 		.ctl_offs = 0x0300,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -139,6 +150,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		},
 	},
 	[MT8183_POWER_DOMAIN_VENC] = {
+		.name = "venc",
 		.sta_mask = PWR_STATUS_VENC,
 		.ctl_offs = 0x0304,
 		.sram_pdn_bits = GENMASK(11, 8),
@@ -151,6 +163,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		},
 	},
 	[MT8183_POWER_DOMAIN_VPU_TOP] = {
+		.name = "vpu_top",
 		.sta_mask = BIT(26),
 		.ctl_offs = 0x0324,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -177,6 +190,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		},
 	},
 	[MT8183_POWER_DOMAIN_VPU_CORE0] = {
+		.name = "vpu_core0",
 		.sta_mask = BIT(27),
 		.ctl_offs = 0x33c,
 		.sram_pdn_bits = GENMASK(11, 8),
@@ -194,6 +208,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.caps = MTK_SCPD_SRAM_ISO,
 	},
 	[MT8183_POWER_DOMAIN_VPU_CORE1] = {
+		.name = "vpu_core1",
 		.sta_mask = BIT(28),
 		.ctl_offs = 0x0340,
 		.sram_pdn_bits = GENMASK(11, 8),
-- 
2.30.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D97B3254D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhBYRvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:51:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45656 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhBYRuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:50:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 409BC1F463CE
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/4] soc: mediatek: pm-domains: Add a power domain names for mt8192
Date:   Thu, 25 Feb 2021 18:49:59 +0100
Message-Id: <20210225175000.824661-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225175000.824661-1-enric.balletbo@collabora.com>
References: <20210225175000.824661-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power domains names for the mt8192 SoC.

Fixes: a49d5e7a89d6 ("soc: mediatek: pm-domains: Add support for mt8192")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mt8192-pm-domains.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/soc/mediatek/mt8192-pm-domains.h
index 0fdf6dc6231f..543dda70de01 100644
--- a/drivers/soc/mediatek/mt8192-pm-domains.h
+++ b/drivers/soc/mediatek/mt8192-pm-domains.h
@@ -12,6 +12,7 @@
 
 static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 	[MT8192_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
 		.sta_mask = BIT(21),
 		.ctl_offs = 0x0354,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -24,6 +25,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		},
 	},
 	[MT8192_POWER_DOMAIN_CONN] = {
+		.name = "conn",
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = 0x0304,
 		.sram_pdn_bits = 0,
@@ -45,12 +47,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
 	[MT8192_POWER_DOMAIN_MFG0] = {
+		.name = "mfg0",
 		.sta_mask = BIT(2),
 		.ctl_offs = 0x0308,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
 	[MT8192_POWER_DOMAIN_MFG1] = {
+		.name = "mfg1",
 		.sta_mask = BIT(3),
 		.ctl_offs = 0x030c,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -75,36 +79,42 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		},
 	},
 	[MT8192_POWER_DOMAIN_MFG2] = {
+		.name = "mfg2",
 		.sta_mask = BIT(4),
 		.ctl_offs = 0x0310,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
 	[MT8192_POWER_DOMAIN_MFG3] = {
+		.name = "mfg3",
 		.sta_mask = BIT(5),
 		.ctl_offs = 0x0314,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
 	[MT8192_POWER_DOMAIN_MFG4] = {
+		.name = "mfg4",
 		.sta_mask = BIT(6),
 		.ctl_offs = 0x0318,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
 	[MT8192_POWER_DOMAIN_MFG5] = {
+		.name = "mfg5",
 		.sta_mask = BIT(7),
 		.ctl_offs = 0x031c,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
 	[MT8192_POWER_DOMAIN_MFG6] = {
+		.name = "mfg6",
 		.sta_mask = BIT(8),
 		.ctl_offs = 0x0320,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
 	[MT8192_POWER_DOMAIN_DISP] = {
+		.name = "disp",
 		.sta_mask = BIT(20),
 		.ctl_offs = 0x0350,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -133,6 +143,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		},
 	},
 	[MT8192_POWER_DOMAIN_IPE] = {
+		.name = "ipe",
 		.sta_mask = BIT(14),
 		.ctl_offs = 0x0338,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -149,6 +160,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		},
 	},
 	[MT8192_POWER_DOMAIN_ISP] = {
+		.name = "isp",
 		.sta_mask = BIT(12),
 		.ctl_offs = 0x0330,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -165,6 +177,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		},
 	},
 	[MT8192_POWER_DOMAIN_ISP2] = {
+		.name = "isp2",
 		.sta_mask = BIT(13),
 		.ctl_offs = 0x0334,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -181,6 +194,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		},
 	},
 	[MT8192_POWER_DOMAIN_MDP] = {
+		.name = "mdp",
 		.sta_mask = BIT(19),
 		.ctl_offs = 0x034c,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -197,6 +211,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		},
 	},
 	[MT8192_POWER_DOMAIN_VENC] = {
+		.name = "venc",
 		.sta_mask = BIT(17),
 		.ctl_offs = 0x0344,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -213,6 +228,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		},
 	},
 	[MT8192_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
 		.sta_mask = BIT(15),
 		.ctl_offs = 0x033c,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -229,12 +245,14 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		},
 	},
 	[MT8192_POWER_DOMAIN_VDEC2] = {
+		.name = "vdec2",
 		.sta_mask = BIT(16),
 		.ctl_offs = 0x0340,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
 	[MT8192_POWER_DOMAIN_CAM] = {
+		.name = "cam",
 		.sta_mask = BIT(23),
 		.ctl_offs = 0x035c,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -263,18 +281,21 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		},
 	},
 	[MT8192_POWER_DOMAIN_CAM_RAWA] = {
+		.name = "cam_rawa",
 		.sta_mask = BIT(24),
 		.ctl_offs = 0x0360,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
 	[MT8192_POWER_DOMAIN_CAM_RAWB] = {
+		.name = "cam_rawb",
 		.sta_mask = BIT(25),
 		.ctl_offs = 0x0364,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
 	[MT8192_POWER_DOMAIN_CAM_RAWC] = {
+		.name = "cam_rawc",
 		.sta_mask = BIT(26),
 		.ctl_offs = 0x0368,
 		.sram_pdn_bits = GENMASK(8, 8),
-- 
2.30.0


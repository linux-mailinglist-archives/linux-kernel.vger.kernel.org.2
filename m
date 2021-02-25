Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EAA3254D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhBYRwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhBYRu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:50:56 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD927C061788
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:50:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1A9571F463CC
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 4/4] soc: mediatek: pm-domains: Add a power domain names for mt8167
Date:   Thu, 25 Feb 2021 18:50:00 +0100
Message-Id: <20210225175000.824661-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225175000.824661-1-enric.balletbo@collabora.com>
References: <20210225175000.824661-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power domains names for the mt8167 SoC.

Fixes: 207f13b419a6 ("soc: mediatek: pm-domains: Add support for mt8167")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mt8167-pm-domains.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/mediatek/mt8167-pm-domains.h b/drivers/soc/mediatek/mt8167-pm-domains.h
index ad0b8dfa0527..15559ddf26e4 100644
--- a/drivers/soc/mediatek/mt8167-pm-domains.h
+++ b/drivers/soc/mediatek/mt8167-pm-domains.h
@@ -15,6 +15,7 @@
 
 static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 	[MT8167_POWER_DOMAIN_MM] = {
+		.name = "mm",
 		.sta_mask = PWR_STATUS_DISP,
 		.ctl_offs = SPM_DIS_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
@@ -26,6 +27,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT8167_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
 		.sta_mask = PWR_STATUS_VDEC,
 		.ctl_offs = SPM_VDE_PWR_CON,
 		.sram_pdn_bits = GENMASK(8, 8),
@@ -33,6 +35,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT8167_POWER_DOMAIN_ISP] = {
+		.name = "isp",
 		.sta_mask = PWR_STATUS_ISP,
 		.ctl_offs = SPM_ISP_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
@@ -40,6 +43,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT8167_POWER_DOMAIN_MFG_ASYNC] = {
+		.name = "mfg_async",
 		.sta_mask = MT8167_PWR_STATUS_MFG_ASYNC,
 		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
 		.sram_pdn_bits = 0,
@@ -50,18 +54,21 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		},
 	},
 	[MT8167_POWER_DOMAIN_MFG_2D] = {
+		.name = "mfg_2d",
 		.sta_mask = MT8167_PWR_STATUS_MFG_2D,
 		.ctl_offs = SPM_MFG_2D_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 	},
 	[MT8167_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
 		.sta_mask = PWR_STATUS_MFG,
 		.ctl_offs = SPM_MFG_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 	},
 	[MT8167_POWER_DOMAIN_CONN] = {
+		.name = "conn",
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = SPM_CONN_PWR_CON,
 		.sram_pdn_bits = GENMASK(8, 8),
-- 
2.30.0


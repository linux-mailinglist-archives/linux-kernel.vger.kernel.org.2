Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D78442838
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhKBHXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:23:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33144 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230281AbhKBHXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:23:52 -0400
X-UUID: 397eba2c52f54dc6b87da86c99d13c6a-20211102
X-UUID: 397eba2c52f54dc6b87da86c99d13c6a-20211102
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1200185247; Tue, 02 Nov 2021 15:21:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 2 Nov 2021 15:21:14 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Nov 2021 15:21:14 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [RFC PATCH] soc: mediatek: Add support always on flag
Date:   Tue, 2 Nov 2021 15:20:58 +0800
Message-ID: <20211102072058.4107-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a t-phy shared by PCIe and USB3 on mt8195, if the t-phy is
used by PCIe, when power off its mtcmos, need software reset it
(workaround way, usually hardware do it, but has an issue on mt8195),
but it has side effect to USB2 phy(works with USB3 phy to support
USB3.2 Gen1), so add support GENPD_FLAG_ALWAYS_ON flag, and make its
power always on;
Another reason is that USB3.2 Gen1/2 need keep power always on when
support runtime-pm due to hardware limitation until now;

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/soc/mediatek/mt8195-pm-domains.h | 2 +-
 drivers/soc/mediatek/mtk-pm-domains.c    | 2 ++
 drivers/soc/mediatek/mtk-pm-domains.h    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mt8195-pm-domains.h b/drivers/soc/mediatek/mt8195-pm-domains.h
index 1379aa39bf16..b6949874c72b 100644
--- a/drivers/soc/mediatek/mt8195-pm-domains.h
+++ b/drivers/soc/mediatek/mt8195-pm-domains.h
@@ -67,7 +67,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.ctl_offs = 0x334,
 		.pwr_sta_offs = 0x174,
 		.pwr_sta2nd_offs = 0x178,
-		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+		.caps = MTK_SCPD_ALWAYS_ON,
 	},
 	[MT8195_POWER_DOMAIN_CSI_RX_TOP] = {
 		.name = "csi_rx_top",
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 61973a306e97..b89e5e3e3363 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -446,6 +446,8 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_ACTIVE_WAKEUP))
 		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_ALWAYS_ON))
+		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
 		pm_genpd_init(&pd->genpd, NULL, true);
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index daa24e890dd4..419d23d5e394 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -8,6 +8,7 @@
 #define MTK_SCPD_SRAM_ISO		BIT(2)
 #define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
 #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
+#define MTK_SCPD_ALWAYS_ON		BIT(5)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.25.1


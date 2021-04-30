Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D5E36F641
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhD3HQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:16:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57383 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230055AbhD3HQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:16:31 -0400
X-UUID: d2409fb0d42f46219e4119bf439b1f23-20210430
X-UUID: d2409fb0d42f46219e4119bf439b1f23-20210430
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1251188204; Fri, 30 Apr 2021 15:15:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Apr 2021 15:15:33 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Apr 2021 15:15:33 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 1/3] usb: xhci-mtk: use bitfield instead of bool
Date:   Fri, 30 Apr 2021 15:15:30 +0800
Message-ID: <20210430071532.51794-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitfield instead of bool in struct

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 2 --
 drivers/usb/host/xhci-mtk.h | 8 ++++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index b2058b3bc834..2548976bcf05 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -495,8 +495,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 			goto put_usb2_hcd;
 		}
 		mtk->has_ippc = true;
-	} else {
-		mtk->has_ippc = false;
 	}
 
 	device_init_wakeup(dev, true);
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index cd3a37bb73e6..94a59b3d178f 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -138,17 +138,17 @@ struct xhci_hcd_mtk {
 	struct mu3h_sch_bw_info *sch_array;
 	struct list_head bw_ep_chk_list;
 	struct mu3c_ippc_regs __iomem *ippc_regs;
-	bool has_ippc;
 	int num_u2_ports;
 	int num_u3_ports;
 	int u3p_dis_msk;
 	struct regulator *vusb33;
 	struct regulator *vbus;
 	struct clk_bulk_data clks[BULK_CLKS_NUM];
-	bool lpm_support;
-	bool u2_lpm_disable;
+	unsigned int has_ippc:1;
+	unsigned int lpm_support:1;
+	unsigned int u2_lpm_disable:1;
 	/* usb remote wakeup */
-	bool uwk_en;
+	unsigned int uwk_en:1;
 	struct regmap *uwk;
 	u32 uwk_reg_base;
 	u32 uwk_vers;
-- 
2.18.0


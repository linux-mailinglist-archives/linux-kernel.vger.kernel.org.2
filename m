Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8B834FB84
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhCaI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:26:24 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:4066 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232476AbhCaIZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:25:56 -0400
X-UUID: 767e8e90e56140f2b36815a3d2f89e80-20210331
X-UUID: 767e8e90e56140f2b36815a3d2f89e80-20210331
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 970412016; Wed, 31 Mar 2021 16:25:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 31 Mar 2021 16:25:45 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 31 Mar 2021 16:25:44 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH next 1/2] usb: xhci-mtk: fix wrong remainder of bandwidth budget
Date:   Wed, 31 Mar 2021 16:25:41 +0800
Message-ID: <1617179142-2681-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3AAD719846C3AAD1837B7AB546F347E2B72316CB87607FDDEA7BCDCF48BAFCB82000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remainder of the last bandwidth bugdget is wrong,
it's the value alloacted in last bugdget, not unused.

Reported-by: Yaqii Wu <Yaqii.Wu@mediatek.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index a59d1f6d4744..7ac76ae28998 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -341,7 +341,6 @@ static void setup_sch_info(struct xhci_ep_ctx *ep_ctx,
 		}
 
 		if (ep_type == ISOC_IN_EP || ep_type == ISOC_OUT_EP) {
-			u32 remainder;
 
 			if (sch_ep->esit == 1)
 				sch_ep->pkts = esit_pkts;
@@ -357,14 +356,12 @@ static void setup_sch_info(struct xhci_ep_ctx *ep_ctx,
 			sch_ep->repeat = !!(sch_ep->num_budget_microframes > 1);
 			sch_ep->bw_cost_per_microframe = maxpkt * sch_ep->pkts;
 
-			remainder = sch_ep->bw_cost_per_microframe;
-			remainder *= sch_ep->num_budget_microframes;
-			remainder -= (maxpkt * esit_pkts);
 			for (i = 0; i < sch_ep->num_budget_microframes - 1; i++)
 				bwb_table[i] = sch_ep->bw_cost_per_microframe;
 
 			/* last one <= bw_cost_per_microframe */
-			bwb_table[i] = remainder;
+			bwb_table[i] = maxpkt * esit_pkts
+				       - i * sch_ep->bw_cost_per_microframe;
 		}
 	} else if (is_fs_or_ls(sch_ep->speed)) {
 		sch_ep->pkts = 1; /* at most one packet for each microframe */
-- 
2.18.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232AD3DB54F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbhG3IvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:51:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35966 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238017AbhG3Iut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:50:49 -0400
X-UUID: 8b07a5fd1a9347cf8ca4fe39069f2f59-20210730
X-UUID: 8b07a5fd1a9347cf8ca4fe39069f2f59-20210730
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1188815040; Fri, 30 Jul 2021 16:50:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Jul 2021 16:50:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Jul 2021 16:50:42 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 08/11] usb: xhci-mtk: update fs bus bandwidth by bw_budget_table
Date:   Fri, 30 Jul 2021 16:49:59 +0800
Message-ID: <1627635002-24521-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use @bw_budget_table[] to update fs bus bandwidth due to
not all microframes consume @bw_cost_per_microframe, see
setup_sch_info().

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 0bb1a6295d64..10c0f0f6461f 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -458,8 +458,8 @@ static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
 		 * Compared with hs bus, no matter what ep type,
 		 * the hub will always delay one uframe to send data
 		 */
-		for (j = 0; j < sch_ep->cs_count; j++) {
-			tmp = tt->fs_bus_bw[base + j] + sch_ep->bw_cost_per_microframe;
+		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
+			tmp = tt->fs_bus_bw[base + j] + sch_ep->bw_budget_table[j];
 			if (tmp > FS_PAYLOAD_MAX)
 				return -ESCH_BW_OVERFLOW;
 		}
@@ -534,21 +534,18 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 {
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 base, num_esit;
-	int bw_updated;
 	int i, j;
 
 	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
 
-	if (used)
-		bw_updated = sch_ep->bw_cost_per_microframe;
-	else
-		bw_updated = -sch_ep->bw_cost_per_microframe;
-
 	for (i = 0; i < num_esit; i++) {
 		base = sch_ep->offset + i * sch_ep->esit;
 
-		for (j = 0; j < sch_ep->cs_count; j++)
-			tt->fs_bus_bw[base + j] += bw_updated;
+		for (j = 0; j < sch_ep->num_budget_microframes; j++)
+			if (used)
+				tt->fs_bus_bw[base + j] += sch_ep->bw_budget_table[j];
+			else
+				tt->fs_bus_bw[base + j] -= sch_ep->bw_budget_table[j];
 	}
 
 	if (used)
-- 
2.18.0


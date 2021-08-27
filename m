Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01A43F92F7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 05:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbhH0DcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 23:32:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45402 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244113AbhH0DcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 23:32:03 -0400
X-UUID: a6a4fe2c41db48988ffccc418319a87f-20210827
X-UUID: a6a4fe2c41db48988ffccc418319a87f-20210827
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1643678091; Fri, 27 Aug 2021 11:31:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Aug 2021 11:31:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 27 Aug 2021 11:31:06 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Aug 2021 11:31:06 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Ikjoon Jang" <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH next v3] usb: xhci-mtk: allow bandwidth table rollover
Date:   Fri, 27 Aug 2021 11:31:05 +0800
Message-ID: <20210827033105.26595-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci-mtk has 64 slots for periodic bandwidth calculations and each
slot represents byte budgets on a microframe. When an endpoint's
allocation sits on the boundary of the table, byte budgets' slot
can be rolled over but the current implementation doesn't.

This patch allows the microframe index rollover and prevent
out-of-bounds array access.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: fix conficts with usb-testing branch
v2: new patch
---
 drivers/usb/host/xhci-mtk-sch.c | 54 ++++++++++-----------------------
 drivers/usb/host/xhci-mtk.h     |  3 +-
 2 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index f0ceede85ea5..134f4789bd89 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -416,15 +416,14 @@ static u32 get_max_bw(struct mu3h_sch_bw_info *sch_bw,
 {
 	u32 max_bw = 0;
 	u32 bw;
-	int i;
-	int j;
+	int i, j, k;
 
 	for (i = 0; i < sch_ep->num_esit; i++) {
 		u32 base = offset + i * sch_ep->esit;
 
 		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
-			bw = sch_bw->bus_bw[base + j] +
-					sch_ep->bw_budget_table[j];
+			k = XHCI_MTK_BW_INDEX(base + j);
+			bw = sch_bw->bus_bw[k] + sch_ep->bw_budget_table[j];
 			if (bw > max_bw)
 				max_bw = bw;
 		}
@@ -436,18 +435,16 @@ static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
 	struct mu3h_sch_ep_info *sch_ep, bool used)
 {
 	u32 base;
-	int i;
-	int j;
+	int i, j, k;
 
 	for (i = 0; i < sch_ep->num_esit; i++) {
 		base = sch_ep->offset + i * sch_ep->esit;
 		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
+			k = XHCI_MTK_BW_INDEX(base + j);
 			if (used)
-				sch_bw->bus_bw[base + j] +=
-					sch_ep->bw_budget_table[j];
+				sch_bw->bus_bw[k] += sch_ep->bw_budget_table[j];
 			else
-				sch_bw->bus_bw[base + j] -=
-					sch_ep->bw_budget_table[j];
+				sch_bw->bus_bw[k] -= sch_ep->bw_budget_table[j];
 		}
 	}
 }
@@ -457,7 +454,7 @@ static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 tmp;
 	int base;
-	int i, j;
+	int i, j, k;
 
 	for (i = 0; i < sch_ep->num_esit; i++) {
 		base = offset + i * sch_ep->esit;
@@ -467,7 +464,8 @@ static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
 		 * the hub will always delay one uframe to send data
 		 */
 		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
-			tmp = tt->fs_bus_bw[base + j] + sch_ep->bw_budget_table[j];
+			k = XHCI_MTK_BW_INDEX(base + j);
+			tmp = tt->fs_bus_bw[k] + sch_ep->bw_budget_table[j];
 			if (tmp > FS_PAYLOAD_MAX)
 				return -ESCH_BW_OVERFLOW;
 		}
@@ -542,16 +540,18 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 {
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 base;
-	int i, j;
+	int i, j, k;
 
 	for (i = 0; i < sch_ep->num_esit; i++) {
 		base = sch_ep->offset + i * sch_ep->esit;
 
-		for (j = 0; j < sch_ep->num_budget_microframes; j++)
+		for (j = 0; j < sch_ep->num_budget_microframes; j++) {
+			k = XHCI_MTK_BW_INDEX(base + j);
 			if (used)
-				tt->fs_bus_bw[base + j] += sch_ep->bw_budget_table[j];
+				tt->fs_bus_bw[k] += sch_ep->bw_budget_table[j];
 			else
-				tt->fs_bus_bw[base + j] -= sch_ep->bw_budget_table[j];
+				tt->fs_bus_bw[k] -= sch_ep->bw_budget_table[j];
+		}
 	}
 
 	if (used)
@@ -573,27 +573,9 @@ static int load_ep_bw(struct mu3h_sch_bw_info *sch_bw,
 	return 0;
 }
 
-static u32 get_esit_boundary(struct mu3h_sch_ep_info *sch_ep)
-{
-	u32 boundary = sch_ep->esit;
-
-	if (sch_ep->sch_tt) { /* LS/FS with TT */
-		/*
-		 * tune for CS, normally esit >= 8 for FS/LS,
-		 * not add one for other types to avoid access array
-		 * out of boundary
-		 */
-		if (sch_ep->ep_type == ISOC_OUT_EP && boundary > 1)
-			boundary--;
-	}
-
-	return boundary;
-}
-
 static int check_sch_bw(struct mu3h_sch_ep_info *sch_ep)
 {
 	struct mu3h_sch_bw_info *sch_bw = sch_ep->bw_info;
-	const u32 esit_boundary = get_esit_boundary(sch_ep);
 	const u32 bw_boundary = get_bw_boundary(sch_ep->speed);
 	u32 offset;
 	u32 worst_bw;
@@ -606,10 +588,6 @@ static int check_sch_bw(struct mu3h_sch_ep_info *sch_ep)
 	 * and find a microframe where its worst bandwidth is minimum.
 	 */
 	for (offset = 0; offset < sch_ep->esit; offset++) {
-
-		if ((offset + sch_ep->num_budget_microframes) > esit_boundary)
-			break;
-
 		ret = check_sch_tt(sch_ep, offset);
 		if (ret)
 			continue;
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 9c54a597e66b..4b1ea89f959a 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -25,7 +25,8 @@
  * round down to the limit value, that means allocating more
  * bandwidth to it.
  */
-#define XHCI_MTK_MAX_ESIT	64
+#define XHCI_MTK_MAX_ESIT	(1 << 6)
+#define XHCI_MTK_BW_INDEX(x)	((x) & (XHCI_MTK_MAX_ESIT - 1))
 
 /**
  * @fs_bus_bw: array to keep track of bandwidth already used for FS
-- 
2.18.0


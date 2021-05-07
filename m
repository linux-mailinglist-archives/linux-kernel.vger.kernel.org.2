Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3F7375EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 04:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhEGCMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 22:12:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59279 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231461AbhEGCMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 22:12:34 -0400
X-UUID: bb1fdf7d140549f5981d9cdb6995589f-20210507
X-UUID: bb1fdf7d140549f5981d9cdb6995589f-20210507
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 728459309; Fri, 07 May 2021 10:11:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 7 May 2021 10:11:29 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 May 2021 10:11:29 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: [PATCH v3 3/4] usb: xhci-mtk: remove unnecessary assignments in periodic TT scheduler
Date:   Fri, 7 May 2021 10:11:26 +0800
Message-ID: <20210507021127.54717-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210507021127.54717-1-chunfeng.yun@mediatek.com>
References: <20210507021127.54717-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ikjoon Jang <ikjn@chromium.org>

Remove unnecessary variables in check_sch_bw().
No functional changes, just for better readability.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~3: no changes
---
 drivers/usb/host/xhci-mtk-sch.c | 37 +++++++++++++--------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 8b90da5a6ed1..9fb75085e40f 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -476,6 +476,9 @@ static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 	u32 start_cs, last_cs;
 	int i;
 
+	if (!sch_ep->sch_tt)
+		return 0;
+
 	start_ss = offset % 8;
 
 	if (sch_ep->ep_type == ISOC_OUT_EP) {
@@ -603,54 +606,42 @@ static u32 get_esit_boundary(struct mu3h_sch_ep_info *sch_ep)
 static int check_sch_bw(struct mu3h_sch_bw_info *sch_bw,
 			struct mu3h_sch_ep_info *sch_ep)
 {
+	const u32 esit_boundary = get_esit_boundary(sch_ep);
+	const u32 bw_boundary = get_bw_boundary(sch_ep->speed);
 	u32 offset;
-	u32 min_bw;
-	u32 min_index;
 	u32 worst_bw;
-	u32 bw_boundary;
-	u32 esit_boundary;
-	u32 min_num_budget;
-	u32 min_cs_count;
+	u32 min_bw = ~0;
+	int min_index = -1;
 	int ret = 0;
 
 	/*
 	 * Search through all possible schedule microframes.
 	 * and find a microframe where its worst bandwidth is minimum.
 	 */
-	min_bw = ~0;
-	min_index = 0;
-	min_cs_count = sch_ep->cs_count;
-	min_num_budget = sch_ep->num_budget_microframes;
-	esit_boundary = get_esit_boundary(sch_ep);
 	for (offset = 0; offset < sch_ep->esit; offset++) {
-		if (sch_ep->sch_tt) {
-			ret = check_sch_tt(sch_ep, offset);
-			if (ret)
-				continue;
-		}
+		ret = check_sch_tt(sch_ep, offset);
+		if (ret)
+			continue;
 
 		if ((offset + sch_ep->num_budget_microframes) > esit_boundary)
 			break;
 
 		worst_bw = get_max_bw(sch_bw, sch_ep, offset);
+		if (worst_bw > bw_boundary)
+			continue;
+
 		if (min_bw > worst_bw) {
 			min_bw = worst_bw;
 			min_index = offset;
-			min_cs_count = sch_ep->cs_count;
-			min_num_budget = sch_ep->num_budget_microframes;
 		}
 		if (min_bw == 0)
 			break;
 	}
 
-	bw_boundary = get_bw_boundary(sch_ep->speed);
-	/* check bandwidth */
-	if (min_bw > bw_boundary)
+	if (min_index < 0)
 		return ret ? ret : -ESCH_BW_OVERFLOW;
 
 	sch_ep->offset = min_index;
-	sch_ep->cs_count = min_cs_count;
-	sch_ep->num_budget_microframes = min_num_budget;
 
 	return load_ep_bw(sch_bw, sch_ep, true);
 }
-- 
2.18.0


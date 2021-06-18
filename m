Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF493AC2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 07:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhFRFsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 01:48:30 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:23494 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229671AbhFRFs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 01:48:29 -0400
X-UUID: d2b6d1d52d5949d7b46b2a66002cf363-20210618
X-UUID: d2b6d1d52d5949d7b46b2a66002cf363-20210618
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1020669437; Fri, 18 Jun 2021 13:46:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 13:46:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 13:46:06 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: [PATCH v2] usb: xhci-mtk: allow multiple Start-Split in a microframe
Date:   Fri, 18 Jun 2021 13:46:05 +0800
Message-ID: <1623995165-25759-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 02BB984D341FF26AAEC4515F05D01F59A1311868CC49A7C74FF13F345B3278832000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to relax bandwidth schedule by allowing multiple
Start-Split in the same microframe.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: fix build warning unused-but-set-variable
---
 drivers/usb/host/xhci-mtk-sch.c | 18 ------------------
 drivers/usb/host/xhci-mtk.h     |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index c07411d9b16f..cffcaf4dfa9f 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -470,11 +470,9 @@ static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
 
 static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 {
-	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 extra_cs_count;
 	u32 start_ss, last_ss;
 	u32 start_cs, last_cs;
-	int i;
 
 	if (!sch_ep->sch_tt)
 		return 0;
@@ -491,10 +489,6 @@ static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 		if (!(start_ss == 7 || last_ss < 6))
 			return -ESCH_SS_Y6;
 
-		for (i = 0; i < sch_ep->cs_count; i++)
-			if (test_bit(offset + i, tt->ss_bit_map))
-				return -ESCH_SS_OVERLAP;
-
 	} else {
 		u32 cs_count = DIV_ROUND_UP(sch_ep->maxpkt, FS_PAYLOAD_MAX);
 
@@ -521,9 +515,6 @@ static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 		if (cs_count > 7)
 			cs_count = 7; /* HW limit */
 
-		if (test_bit(offset, tt->ss_bit_map))
-			return -ESCH_SS_OVERLAP;
-
 		sch_ep->cs_count = cs_count;
 		/* one for ss, the other for idle */
 		sch_ep->num_budget_microframes = cs_count + 2;
@@ -544,11 +535,9 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 base, num_esit;
 	int bw_updated;
-	int bits;
 	int i, j;
 
 	num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
-	bits = (sch_ep->ep_type == ISOC_OUT_EP) ? sch_ep->cs_count : 1;
 
 	if (used)
 		bw_updated = sch_ep->bw_cost_per_microframe;
@@ -558,13 +547,6 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 	for (i = 0; i < num_esit; i++) {
 		base = sch_ep->offset + i * sch_ep->esit;
 
-		for (j = 0; j < bits; j++) {
-			if (used)
-				set_bit(base + j, tt->ss_bit_map);
-			else
-				clear_bit(base + j, tt->ss_bit_map);
-		}
-
 		for (j = 0; j < sch_ep->cs_count; j++)
 			tt->fs_bus_bw[base + j] += bw_updated;
 	}
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index cd3a37bb73e6..390cb5a86082 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -24,12 +24,10 @@
 #define XHCI_MTK_MAX_ESIT	64
 
 /**
- * @ss_bit_map: used to avoid start split microframes overlay
  * @fs_bus_bw: array to keep track of bandwidth already used for FS
  * @ep_list: Endpoints using this TT
  */
 struct mu3h_sch_tt {
-	DECLARE_BITMAP(ss_bit_map, XHCI_MTK_MAX_ESIT);
 	u32 fs_bus_bw[XHCI_MTK_MAX_ESIT];
 	struct list_head ep_list;
 };
-- 
2.18.0


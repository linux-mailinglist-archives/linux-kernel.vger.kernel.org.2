Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C8732E439
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhCEJDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:03:45 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44144 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229723AbhCEJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:03:26 -0500
X-UUID: 6957a129b0464d079f75c935ee46d9b8-20210305
X-UUID: 6957a129b0464d079f75c935ee46d9b8-20210305
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1428301465; Fri, 05 Mar 2021 17:03:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Mar 2021 17:03:18 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Mar 2021 17:03:17 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ikjoon Jang <ikjn@chromium.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 06/17] usb: xhci-mtk: add a function to (un)load bandwidth info
Date:   Fri, 5 Mar 2021 17:02:44 +0800
Message-ID: <1614934975-15188-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract a function to load/unload bandwidth info, and remove
a dummy check of TT offset.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 37 ++++++++++++++-------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 9016188eee97..bef82c1f909d 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -375,7 +375,6 @@ static void update_bus_bw(struct mu3h_sch_bw_info *sch_bw,
 					sch_ep->bw_budget_table[j];
 		}
 	}
-	sch_ep->allocated = used;
 }
 
 static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
@@ -509,6 +508,19 @@ static void update_sch_tt(struct usb_device *udev,
 		list_del(&sch_ep->tt_endpoint);
 }
 
+static int load_ep_bw(struct usb_device *udev, struct mu3h_sch_bw_info *sch_bw,
+		      struct mu3h_sch_ep_info *sch_ep, bool loaded)
+{
+	if (sch_ep->sch_tt)
+		update_sch_tt(udev, sch_ep, loaded);
+
+	/* update bus bandwidth info */
+	update_bus_bw(sch_bw, sch_ep, loaded);
+	sch_ep->allocated = loaded;
+
+	return 0;
+}
+
 static u32 get_esit_boundary(struct mu3h_sch_ep_info *sch_ep)
 {
 	u32 boundary = sch_ep->esit;
@@ -535,7 +547,6 @@ static int check_sch_bw(struct usb_device *udev,
 	u32 esit_boundary;
 	u32 min_num_budget;
 	u32 min_cs_count;
-	bool tt_offset_ok = false;
 	int ret;
 
 	/*
@@ -552,8 +563,6 @@ static int check_sch_bw(struct usb_device *udev,
 			ret = check_sch_tt(udev, sch_ep, offset);
 			if (ret)
 				continue;
-			else
-				tt_offset_ok = true;
 		}
 
 		if ((offset + sch_ep->num_budget_microframes) > esit_boundary)
@@ -585,29 +594,15 @@ static int check_sch_bw(struct usb_device *udev,
 	sch_ep->cs_count = min_cs_count;
 	sch_ep->num_budget_microframes = min_num_budget;
 
-	if (sch_ep->sch_tt) {
-		/* all offset for tt is not ok*/
-		if (!tt_offset_ok)
-			return -ERANGE;
-
-		update_sch_tt(udev, sch_ep, 1);
-	}
-
-	/* update bus bandwidth info */
-	update_bus_bw(sch_bw, sch_ep, 1);
-
-	return 0;
+	return load_ep_bw(udev, sch_bw, sch_ep, true);
 }
 
 static void destroy_sch_ep(struct usb_device *udev,
 	struct mu3h_sch_bw_info *sch_bw, struct mu3h_sch_ep_info *sch_ep)
 {
 	/* only release ep bw check passed by check_sch_bw() */
-	if (sch_ep->allocated) {
-		update_bus_bw(sch_bw, sch_ep, 0);
-		if (sch_ep->sch_tt)
-			update_sch_tt(udev, sch_ep, 0);
-	}
+	if (sch_ep->allocated)
+		load_ep_bw(udev, sch_bw, sch_ep, false);
 
 	if (sch_ep->sch_tt)
 		drop_tt(udev);
-- 
2.18.0


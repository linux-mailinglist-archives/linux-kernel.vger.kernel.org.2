Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781F3330617
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhCHCwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:52:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39691 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232409AbhCHCwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:25 -0500
X-UUID: 2278049148d74e49b7e144d082034741-20210308
X-UUID: 2278049148d74e49b7e144d082034741-20210308
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1637251331; Mon, 08 Mar 2021 10:52:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:52:19 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:52:18 +0800
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
        Eddie Hung <eddie.hung@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2 06/18] usb: xhci-mtk: add a function to (un)load bandwidth info
Date:   Mon, 8 Mar 2021 10:51:55 +0800
Message-ID: <6fbc000756a4a4a7efbce651b785fee7561becb6.1615170625.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
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
v2: no changes
---
 drivers/usb/host/xhci-mtk-sch.c | 37 ++++++++++++++-------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index b1da3cb077c9..9a9685f74940 100644
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


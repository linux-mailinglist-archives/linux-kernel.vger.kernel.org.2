Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA6633061C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhCHCww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:52:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36571 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232412AbhCHCw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:28 -0500
X-UUID: 4142beefb2b141ffb81c845378df4a70-20210308
X-UUID: 4142beefb2b141ffb81c845378df4a70-20210308
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 318312374; Mon, 08 Mar 2021 10:52:23 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:52:22 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:52:21 +0800
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
Subject: [PATCH v2 10/18] usb: xhci-mtk: add a member @speed in mu3h_sch_ep_info struct
Date:   Mon, 8 Mar 2021 10:51:59 +0800
Message-ID: <cda0833e44d6027cc8fdee1e29ce2b5b2a6ac03d.1615170625.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to drop parameter @udev for some functions,
meanwhile remove some unused @udev parameter.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/host/xhci-mtk-sch.c | 37 ++++++++++++++++-----------------
 drivers/usb/host/xhci-mtk.h     |  1 +
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 6fb7a040c73c..3dc727b820aa 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -214,14 +214,15 @@ static struct mu3h_sch_ep_info *create_sch_ep(struct usb_device *udev,
 
 	sch_ep->sch_tt = tt;
 	sch_ep->ep = ep;
+	sch_ep->speed = udev->speed;
 	INIT_LIST_HEAD(&sch_ep->endpoint);
 	INIT_LIST_HEAD(&sch_ep->tt_endpoint);
 
 	return sch_ep;
 }
 
-static void setup_sch_info(struct usb_device *udev,
-		struct xhci_ep_ctx *ep_ctx, struct mu3h_sch_ep_info *sch_ep)
+static void setup_sch_info(struct xhci_ep_ctx *ep_ctx,
+			   struct mu3h_sch_ep_info *sch_ep)
 {
 	u32 ep_type;
 	u32 maxpkt;
@@ -248,7 +249,7 @@ static void setup_sch_info(struct usb_device *udev,
 	sch_ep->burst_mode = 0;
 	sch_ep->repeat = 0;
 
-	if (udev->speed == USB_SPEED_HIGH) {
+	if (sch_ep->speed == USB_SPEED_HIGH) {
 		sch_ep->cs_count = 0;
 
 		/*
@@ -266,7 +267,7 @@ static void setup_sch_info(struct usb_device *udev,
 		sch_ep->pkts = max_burst + 1;
 		sch_ep->bw_cost_per_microframe = maxpkt * sch_ep->pkts;
 		bwb_table[0] = sch_ep->bw_cost_per_microframe;
-	} else if (udev->speed >= USB_SPEED_SUPER) {
+	} else if (sch_ep->speed >= USB_SPEED_SUPER) {
 		/* usb3_r1 spec section4.4.7 & 4.4.8 */
 		sch_ep->cs_count = 0;
 		sch_ep->burst_mode = 1;
@@ -311,7 +312,7 @@ static void setup_sch_info(struct usb_device *udev,
 			/* last one <= bw_cost_per_microframe */
 			bwb_table[i] = remainder;
 		}
-	} else if (is_fs_or_ls(udev->speed)) {
+	} else if (is_fs_or_ls(sch_ep->speed)) {
 		sch_ep->pkts = 1; /* at most one packet for each microframe */
 
 		/*
@@ -416,8 +417,7 @@ static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
 	return 0;
 }
 
-static int check_sch_tt(struct usb_device *udev,
-	struct mu3h_sch_ep_info *sch_ep, u32 offset)
+static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 {
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 extra_cs_count;
@@ -485,8 +485,7 @@ static int check_sch_tt(struct usb_device *udev,
 	return check_fs_bus_bw(sch_ep, offset);
 }
 
-static void update_sch_tt(struct usb_device *udev,
-	struct mu3h_sch_ep_info *sch_ep, bool used)
+static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 {
 	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
 	u32 base, num_esit;
@@ -522,11 +521,11 @@ static void update_sch_tt(struct usb_device *udev,
 		list_del(&sch_ep->tt_endpoint);
 }
 
-static int load_ep_bw(struct usb_device *udev, struct mu3h_sch_bw_info *sch_bw,
+static int load_ep_bw(struct mu3h_sch_bw_info *sch_bw,
 		      struct mu3h_sch_ep_info *sch_ep, bool loaded)
 {
 	if (sch_ep->sch_tt)
-		update_sch_tt(udev, sch_ep, loaded);
+		update_sch_tt(sch_ep, loaded);
 
 	/* update bus bandwidth info */
 	update_bus_bw(sch_bw, sch_ep, loaded);
@@ -550,8 +549,8 @@ static u32 get_esit_boundary(struct mu3h_sch_ep_info *sch_ep)
 	return boundary;
 }
 
-static int check_sch_bw(struct usb_device *udev,
-	struct mu3h_sch_bw_info *sch_bw, struct mu3h_sch_ep_info *sch_ep)
+static int check_sch_bw(struct mu3h_sch_bw_info *sch_bw,
+			struct mu3h_sch_ep_info *sch_ep)
 {
 	u32 offset;
 	u32 min_bw;
@@ -574,7 +573,7 @@ static int check_sch_bw(struct usb_device *udev,
 	esit_boundary = get_esit_boundary(sch_ep);
 	for (offset = 0; offset < sch_ep->esit; offset++) {
 		if (sch_ep->sch_tt) {
-			ret = check_sch_tt(udev, sch_ep, offset);
+			ret = check_sch_tt(sch_ep, offset);
 			if (ret)
 				continue;
 		}
@@ -593,7 +592,7 @@ static int check_sch_bw(struct usb_device *udev,
 			break;
 	}
 
-	bw_boundary = get_bw_boundary(udev->speed);
+	bw_boundary = get_bw_boundary(sch_ep->speed);
 	/* check bandwidth */
 	if (min_bw > bw_boundary)
 		return -ERANGE;
@@ -602,7 +601,7 @@ static int check_sch_bw(struct usb_device *udev,
 	sch_ep->cs_count = min_cs_count;
 	sch_ep->num_budget_microframes = min_num_budget;
 
-	return load_ep_bw(udev, sch_bw, sch_ep, true);
+	return load_ep_bw(sch_bw, sch_ep, true);
 }
 
 static void destroy_sch_ep(struct usb_device *udev,
@@ -610,7 +609,7 @@ static void destroy_sch_ep(struct usb_device *udev,
 {
 	/* only release ep bw check passed by check_sch_bw() */
 	if (sch_ep->allocated)
-		load_ep_bw(udev, sch_bw, sch_ep, false);
+		load_ep_bw(sch_bw, sch_ep, false);
 
 	if (sch_ep->sch_tt)
 		drop_tt(udev);
@@ -711,7 +710,7 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	if (IS_ERR_OR_NULL(sch_ep))
 		return -ENOMEM;
 
-	setup_sch_info(udev, ep_ctx, sch_ep);
+	setup_sch_info(ep_ctx, sch_ep);
 
 	list_add_tail(&sch_ep->endpoint, &mtk->bw_ep_chk_list);
 
@@ -771,7 +770,7 @@ int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 		bw_index = get_bw_index(xhci, udev, sch_ep->ep);
 		sch_bw = &mtk->sch_array[bw_index];
 
-		ret = check_sch_bw(udev, sch_bw, sch_ep);
+		ret = check_sch_bw(sch_bw, sch_ep);
 		if (ret) {
 			xhci_err(xhci, "Not enough bandwidth!\n");
 			return -ENOSPC;
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 076b9bbc89dd..d25bf9e49136 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -85,6 +85,7 @@ struct mu3h_sch_ep_info {
 	u32 ep_type;
 	u32 maxpkt;
 	struct usb_host_endpoint *ep;
+	enum usb_device_speed speed;
 	bool allocated;
 	/*
 	 * mtk xHCI scheduling information put into reserved DWs
-- 
2.18.0


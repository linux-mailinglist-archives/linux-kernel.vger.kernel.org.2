Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5E433061B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhCHCwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:52:51 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39748 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232413AbhCHCw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:28 -0500
X-UUID: 266da1618fa74eda999a27d193b1c2a6-20210308
X-UUID: 266da1618fa74eda999a27d193b1c2a6-20210308
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 152931882; Mon, 08 Mar 2021 10:52:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:52:24 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:52:23 +0800
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
Subject: [PATCH v2 12/18] usb: xhci-mtk: rebuild the way to get bandwidth domain
Date:   Mon, 8 Mar 2021 10:52:01 +0800
Message-ID: <de618970301702c57bd352bf87df48bc17c699dd.1615170625.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rebuild the function get_bw_index(), get the bandwidth domain
directly instead its index of domain array.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/host/xhci-mtk-sch.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index bad99580fb68..9e77bbd8e7f7 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -57,7 +57,7 @@ static u32 get_bw_boundary(enum usb_device_speed speed)
 }
 
 /*
-* get the index of bandwidth domains array which @ep belongs to.
+* get the bandwidth domain which @ep belongs to.
 *
 * the bandwidth domain array is saved to @sch_array of struct xhci_hcd_mtk,
 * each HS root port is treated as a single bandwidth domain,
@@ -68,9 +68,11 @@ static u32 get_bw_boundary(enum usb_device_speed speed)
 * so the bandwidth domain array is organized as follow for simplification:
 * SSport0-OUT, SSport0-IN, ..., SSportX-OUT, SSportX-IN, HSport0, ..., HSportY
 */
-static int get_bw_index(struct xhci_hcd *xhci, struct usb_device *udev,
-	struct usb_host_endpoint *ep)
+static struct mu3h_sch_bw_info *
+get_bw_info(struct xhci_hcd_mtk *mtk, struct usb_device *udev,
+	    struct usb_host_endpoint *ep)
 {
+	struct xhci_hcd *xhci = hcd_to_xhci(mtk->hcd);
 	struct xhci_virt_device *virt_dev;
 	int bw_index;
 
@@ -86,7 +88,7 @@ static int get_bw_index(struct xhci_hcd *xhci, struct usb_device *udev,
 		bw_index = virt_dev->real_port + xhci->usb3_rhub.num_ports - 1;
 	}
 
-	return bw_index;
+	return &mtk->sch_array[bw_index];
 }
 
 static u32 get_esit(struct xhci_ep_ctx *ep_ctx)
@@ -722,14 +724,11 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	struct xhci_hcd *xhci;
 	struct xhci_virt_device *virt_dev;
-	struct mu3h_sch_bw_info *sch_array;
 	struct mu3h_sch_bw_info *sch_bw;
 	struct mu3h_sch_ep_info *sch_ep, *tmp;
-	int bw_index;
 
 	xhci = hcd_to_xhci(hcd);
 	virt_dev = xhci->devs[udev->slot_id];
-	sch_array = mtk->sch_array;
 
 	xhci_dbg(xhci, "%s() type:%d, speed:%d, mpks:%d, dir:%d, ep:%p\n",
 		__func__, usb_endpoint_type(&ep->desc), udev->speed,
@@ -739,8 +738,7 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	if (!need_bw_sch(ep, udev->speed, !!virt_dev->tt_info))
 		return;
 
-	bw_index = get_bw_index(xhci, udev, ep);
-	sch_bw = &sch_array[bw_index];
+	sch_bw = get_bw_info(mtk, udev, ep);
 
 	list_for_each_entry_safe(sch_ep, tmp, &sch_bw->bw_ep_list, endpoint) {
 		if (sch_ep->ep == ep) {
@@ -758,13 +756,12 @@ int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 	struct xhci_virt_device *virt_dev = xhci->devs[udev->slot_id];
 	struct mu3h_sch_bw_info *sch_bw;
 	struct mu3h_sch_ep_info *sch_ep, *tmp;
-	int bw_index, ret;
+	int ret;
 
 	xhci_dbg(xhci, "%s() udev %s\n", __func__, dev_name(&udev->dev));
 
 	list_for_each_entry(sch_ep, &mtk->bw_ep_chk_list, endpoint) {
-		bw_index = get_bw_index(xhci, udev, sch_ep->ep);
-		sch_bw = &mtk->sch_array[bw_index];
+		sch_bw = get_bw_info(mtk, udev, sch_ep->ep);
 
 		ret = check_sch_bw(sch_bw, sch_ep);
 		if (ret) {
@@ -778,9 +775,7 @@ int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 		struct usb_host_endpoint *ep = sch_ep->ep;
 		unsigned int ep_index = xhci_get_endpoint_index(&ep->desc);
 
-		bw_index = get_bw_index(xhci, udev, ep);
-		sch_bw = &mtk->sch_array[bw_index];
-
+		sch_bw = get_bw_info(mtk, udev, ep);
 		list_move_tail(&sch_ep->endpoint, &sch_bw->bw_ep_list);
 
 		ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
@@ -805,13 +800,11 @@ void xhci_mtk_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct mu3h_sch_bw_info *sch_bw;
 	struct mu3h_sch_ep_info *sch_ep, *tmp;
-	int bw_index;
 
 	xhci_dbg(xhci, "%s() udev %s\n", __func__, dev_name(&udev->dev));
 
 	list_for_each_entry_safe(sch_ep, tmp, &mtk->bw_ep_chk_list, endpoint) {
-		bw_index = get_bw_index(xhci, udev, sch_ep->ep);
-		sch_bw = &mtk->sch_array[bw_index];
+		sch_bw = get_bw_info(mtk, udev, sch_ep->ep);
 		destroy_sch_ep(udev, sch_bw, sch_ep);
 	}
 
-- 
2.18.0


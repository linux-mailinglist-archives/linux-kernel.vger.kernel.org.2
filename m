Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94A1330618
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhCHCws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:52:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39748 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232411AbhCHCw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:27 -0500
X-UUID: 051fed69a5a346489ae93c07e0aa2939-20210308
X-UUID: 051fed69a5a346489ae93c07e0aa2939-20210308
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 73613928; Mon, 08 Mar 2021 10:52:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:52:23 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:52:22 +0800
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
Subject: [PATCH v2 11/18] usb: xhci-mtk: use @tt_info to check the FS/LS device is under a HS hub
Date:   Mon, 8 Mar 2021 10:52:00 +0800
Message-ID: <8117df52f16bd03087e486d7d740a183b6dd634a.1615170625.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0F8DD7188C0E7076C65A018EB3856890FDB491C419BF02E25A4CF4F316D690C12000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the LS/FS device is connected to an external HS hub, the member
@tt_info in xhci_virt_device struct in not NULL, use it to check
whether a LS/FS device is under an exernal HS hub, then no need get
the slot context of this device.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/host/xhci-mtk-sch.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 3dc727b820aa..bad99580fb68 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -678,7 +678,6 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	struct xhci_hcd *xhci;
 	struct xhci_ep_ctx *ep_ctx;
-	struct xhci_slot_ctx *slot_ctx;
 	struct xhci_virt_device *virt_dev;
 	struct mu3h_sch_ep_info *sch_ep;
 	unsigned int ep_index;
@@ -686,7 +685,6 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	xhci = hcd_to_xhci(hcd);
 	virt_dev = xhci->devs[udev->slot_id];
 	ep_index = xhci_get_endpoint_index(&ep->desc);
-	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
 	ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
 
 	xhci_dbg(xhci, "%s() type:%d, speed:%d, mpkt:%d, dir:%d, ep:%p\n",
@@ -694,7 +692,7 @@ int xhci_mtk_add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		usb_endpoint_maxp(&ep->desc),
 		usb_endpoint_dir_in(&ep->desc), ep);
 
-	if (!need_bw_sch(ep, udev->speed, slot_ctx->tt_info & TT_SLOT)) {
+	if (!need_bw_sch(ep, udev->speed, !!virt_dev->tt_info)) {
 		/*
 		 * set @bpkts to 1 if it is LS or FS periodic endpoint, and its
 		 * device does not connected through an external HS hub
@@ -723,7 +721,6 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 {
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	struct xhci_hcd *xhci;
-	struct xhci_slot_ctx *slot_ctx;
 	struct xhci_virt_device *virt_dev;
 	struct mu3h_sch_bw_info *sch_array;
 	struct mu3h_sch_bw_info *sch_bw;
@@ -732,7 +729,6 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 
 	xhci = hcd_to_xhci(hcd);
 	virt_dev = xhci->devs[udev->slot_id];
-	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
 	sch_array = mtk->sch_array;
 
 	xhci_dbg(xhci, "%s() type:%d, speed:%d, mpks:%d, dir:%d, ep:%p\n",
@@ -740,7 +736,7 @@ void xhci_mtk_drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 		usb_endpoint_maxp(&ep->desc),
 		usb_endpoint_dir_in(&ep->desc), ep);
 
-	if (!need_bw_sch(ep, udev->speed, slot_ctx->tt_info & TT_SLOT))
+	if (!need_bw_sch(ep, udev->speed, !!virt_dev->tt_info))
 		return;
 
 	bw_index = get_bw_index(xhci, udev, ep);
-- 
2.18.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AF8330627
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhCHCx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:53:26 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39839 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233678AbhCHCwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:33 -0500
X-UUID: 7ce98ea4f15c4597b6899fccc2fd0a4c-20210308
X-UUID: 7ce98ea4f15c4597b6899fccc2fd0a4c-20210308
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1620518821; Mon, 08 Mar 2021 10:52:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:52:28 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:52:27 +0800
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
Subject: [PATCH v2 17/18] usb: xhci-mtk: print debug info of endpoint interval
Date:   Mon, 8 Mar 2021 10:52:06 +0800
Message-ID: <f7a9fa7a812296fcd6c603bfa9853076144018d6.1615170625.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print bInterval and convert it into the time expressed in
us or ms unit, this is the key info when allocate bandwidth
failed.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/host/xhci-mtk-sch.c | 37 ++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 046b7f1ebf94..a59d1f6d4744 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -25,6 +25,8 @@
  */
 #define TT_MICROFRAMES_MAX 9
 
+#define DBG_BUF_EN	64
+
 /* schedule error type */
 #define ESCH_SS_Y6		1001
 #define ESCH_SS_OVERLAP		1002
@@ -62,6 +64,31 @@ static int is_fs_or_ls(enum usb_device_speed speed)
 	return speed == USB_SPEED_FULL || speed == USB_SPEED_LOW;
 }
 
+static const char *
+decode_ep(struct usb_host_endpoint *ep, enum usb_device_speed speed)
+{
+	static char buf[DBG_BUF_EN];
+	struct usb_endpoint_descriptor *epd = &ep->desc;
+	unsigned int interval;
+	const char *unit;
+
+	interval = usb_decode_interval(epd, speed);
+	if (interval % 1000) {
+		unit = "us";
+	} else {
+		unit = "ms";
+		interval /= 1000;
+	}
+
+	snprintf(buf, DBG_BUF_EN, "%s ep%d%s %s, mpkt:%d, interval:%d/%d%s\n",
+		 usb_speed_string(speed), usb_endpoint_num(epd),
+		 usb_endpoint_dir_in(epd) ? "in" : "out",
+		 usb_ep_type_string(usb_endpoint_type(epd)),
+		 usb_endpoint_maxp(epd), epd->bInterval, interval, unit);
+
+	return buf;
+}
+
 static u32 get_bw_boundary(enum usb_device_speed speed)
 {
 	u32 boundary;
@@ -711,10 +738,7 @@ static int add_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 	ep_index = xhci_get_endpoint_index(&ep->desc);
 	ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
 
-	xhci_dbg(xhci, "%s() type:%d, speed:%d, mpkt:%d, dir:%d, ep:%p\n",
-		__func__, usb_endpoint_type(&ep->desc), udev->speed,
-		usb_endpoint_maxp(&ep->desc),
-		usb_endpoint_dir_in(&ep->desc), ep);
+	xhci_dbg(xhci, "%s %s\n", __func__, decode_ep(ep, udev->speed));
 
 	if (!need_bw_sch(ep, udev->speed, !!virt_dev->tt_info)) {
 		/*
@@ -750,10 +774,7 @@ static void drop_ep_quirk(struct usb_hcd *hcd, struct usb_device *udev,
 
 	virt_dev = xhci->devs[udev->slot_id];
 
-	xhci_dbg(xhci, "%s() type:%d, speed:%d, mpks:%d, dir:%d, ep:%p\n",
-		__func__, usb_endpoint_type(&ep->desc), udev->speed,
-		usb_endpoint_maxp(&ep->desc),
-		usb_endpoint_dir_in(&ep->desc), ep);
+	xhci_dbg(xhci, "%s %s\n", __func__, decode_ep(ep, udev->speed));
 
 	if (!need_bw_sch(ep, udev->speed, !!virt_dev->tt_info))
 		return;
-- 
2.18.0


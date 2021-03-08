Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8843F330626
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhCHCxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:53:24 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36638 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232433AbhCHCwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:31 -0500
X-UUID: 523272512cec4d37bda901bb7867a839-20210308
X-UUID: 523272512cec4d37bda901bb7867a839-20210308
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1423636283; Mon, 08 Mar 2021 10:52:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:52:27 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:52:26 +0800
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
Subject: [PATCH v2 16/18] usb: common: add function to get interval expressed in us unit
Date:   Mon, 8 Mar 2021 10:52:05 +0800
Message-ID: <25c8a09b055f716c1e5bf11fea72c3418f844482.1615170625.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function to convert bInterval into the time expressed
in 1us unit.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: move kerneldoc next to function's definition suggested by Alan
---
 drivers/usb/common/common.c | 41 +++++++++++++++++++++++++++++++++++++
 drivers/usb/core/devices.c  | 21 ++++---------------
 drivers/usb/core/endpoint.c | 35 ++++---------------------------
 include/linux/usb/ch9.h     |  3 +++
 4 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index fc21cf2d36f6..675e8a4e683a 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -165,6 +165,47 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_get_dr_mode);
 
+/**
+ * usb_decode_interval - Decode bInterval into the time expressed in 1us unit
+ * @epd: The descriptor of the endpoint
+ * @speed: The speed that the endpoint works as
+ *
+ * Function returns the interval expressed in 1us unit for servicing
+ * endpoint for data transfers.
+ */
+unsigned int usb_decode_interval(const struct usb_endpoint_descriptor *epd,
+				 enum usb_device_speed speed)
+{
+	unsigned int interval = 0;
+
+	switch (usb_endpoint_type(epd)) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		/* uframes per NAK */
+		if (speed == USB_SPEED_HIGH)
+			interval = epd->bInterval;
+		break;
+	case USB_ENDPOINT_XFER_ISOC:
+		interval = 1 << (epd->bInterval - 1);
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		/* uframes per NAK */
+		if (speed == USB_SPEED_HIGH && usb_endpoint_dir_out(epd))
+			interval = epd->bInterval;
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		if (speed >= USB_SPEED_HIGH)
+			interval = 1 << (epd->bInterval - 1);
+		else
+			interval = epd->bInterval;
+		break;
+	}
+
+	interval *= (speed >= USB_SPEED_HIGH) ? 125 : 1000;
+
+	return interval;
+}
+EXPORT_SYMBOL_GPL(usb_decode_interval);
+
 #ifdef CONFIG_OF
 /**
  * of_usb_get_dr_mode_by_phy - Get dual role mode for the controller device
diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
index 1ef2de6e375a..d8b0041de612 100644
--- a/drivers/usb/core/devices.c
+++ b/drivers/usb/core/devices.c
@@ -157,38 +157,25 @@ static char *usb_dump_endpoint_descriptor(int speed, char *start, char *end,
 	switch (usb_endpoint_type(desc)) {
 	case USB_ENDPOINT_XFER_CONTROL:
 		type = "Ctrl";
-		if (speed == USB_SPEED_HIGH)	/* uframes per NAK */
-			interval = desc->bInterval;
-		else
-			interval = 0;
 		dir = 'B';			/* ctrl is bidirectional */
 		break;
 	case USB_ENDPOINT_XFER_ISOC:
 		type = "Isoc";
-		interval = 1 << (desc->bInterval - 1);
 		break;
 	case USB_ENDPOINT_XFER_BULK:
 		type = "Bulk";
-		if (speed == USB_SPEED_HIGH && dir == 'O') /* uframes per NAK */
-			interval = desc->bInterval;
-		else
-			interval = 0;
 		break;
 	case USB_ENDPOINT_XFER_INT:
 		type = "Int.";
-		if (speed == USB_SPEED_HIGH || speed >= USB_SPEED_SUPER)
-			interval = 1 << (desc->bInterval - 1);
-		else
-			interval = desc->bInterval;
 		break;
 	default:	/* "can't happen" */
 		return start;
 	}
-	interval *= (speed == USB_SPEED_HIGH ||
-		     speed >= USB_SPEED_SUPER) ? 125 : 1000;
-	if (interval % 1000)
+
+	interval = usb_decode_interval(desc, speed);
+	if (interval % 1000) {
 		unit = 'u';
-	else {
+	} else {
 		unit = 'm';
 		interval /= 1000;
 	}
diff --git a/drivers/usb/core/endpoint.c b/drivers/usb/core/endpoint.c
index 903426b6d305..a2530811cf7d 100644
--- a/drivers/usb/core/endpoint.c
+++ b/drivers/usb/core/endpoint.c
@@ -84,40 +84,13 @@ static ssize_t interval_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct ep_device *ep = to_ep_device(dev);
+	unsigned int interval;
 	char unit;
-	unsigned interval = 0;
-	unsigned in;
 
-	in = (ep->desc->bEndpointAddress & USB_DIR_IN);
-
-	switch (usb_endpoint_type(ep->desc)) {
-	case USB_ENDPOINT_XFER_CONTROL:
-		if (ep->udev->speed == USB_SPEED_HIGH)
-			/* uframes per NAK */
-			interval = ep->desc->bInterval;
-		break;
-
-	case USB_ENDPOINT_XFER_ISOC:
-		interval = 1 << (ep->desc->bInterval - 1);
-		break;
-
-	case USB_ENDPOINT_XFER_BULK:
-		if (ep->udev->speed == USB_SPEED_HIGH && !in)
-			/* uframes per NAK */
-			interval = ep->desc->bInterval;
-		break;
-
-	case USB_ENDPOINT_XFER_INT:
-		if (ep->udev->speed == USB_SPEED_HIGH)
-			interval = 1 << (ep->desc->bInterval - 1);
-		else
-			interval = ep->desc->bInterval;
-		break;
-	}
-	interval *= (ep->udev->speed == USB_SPEED_HIGH) ? 125 : 1000;
-	if (interval % 1000)
+	interval = usb_decode_interval(ep->desc, ep->udev->speed);
+	if (interval % 1000) {
 		unit = 'u';
-	else {
+	} else {
 		unit = 'm';
 		interval /= 1000;
 	}
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index abdd310c77f0..74debc824645 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -90,6 +90,9 @@ extern enum usb_ssp_rate usb_get_maximum_ssp_rate(struct device *dev);
  */
 extern const char *usb_state_string(enum usb_device_state state);
 
+unsigned int usb_decode_interval(const struct usb_endpoint_descriptor *epd,
+				 enum usb_device_speed speed);
+
 #ifdef CONFIG_TRACING
 /**
  * usb_decode_ctrl - Returns human readable representation of control request.
-- 
2.18.0


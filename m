Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA7330628
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhCHCx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:53:27 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39854 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233690AbhCHCwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:35 -0500
X-UUID: 873e6e4de9d148aa9bc4cf378213ea7a-20210308
X-UUID: 873e6e4de9d148aa9bc4cf378213ea7a-20210308
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 449079268; Mon, 08 Mar 2021 10:52:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 10:52:29 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 10:52:28 +0800
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
Subject: [PATCH v2 18/18] usb: common: move function's kerneldoc next to its definition
Date:   Mon, 8 Mar 2021 10:52:07 +0800
Message-ID: <c4d2e010ae2bf67cdfa0b55e6d1deb9339d9d3dc.1615170625.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 295B076C86783B6D5C9C099F862ED377CF98F0332CAA103A0B377829A1BD079C2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following a general rule, add the kerneldoc for a function next
to it's definition, but not next to its declaration in a header
file.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: new patch
---
 drivers/usb/common/common.c | 35 +++++++++++++++++++++
 drivers/usb/common/debug.c  | 22 +++++++++++--
 include/linux/usb/ch9.h     | 61 -------------------------------------
 3 files changed, 55 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 675e8a4e683a..347fb3d3894a 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -25,6 +25,12 @@ static const char *const ep_type_names[] = {
 	[USB_ENDPOINT_XFER_INT] = "intr",
 };
 
+/**
+ * usb_ep_type_string() - Returns human readable-name of the endpoint type.
+ * @ep_type: The endpoint type to return human-readable name for.  If it's not
+ *   any of the types: USB_ENDPOINT_XFER_{CONTROL, ISOC, BULK, INT},
+ *   usually got by usb_endpoint_type(), the string 'unknown' will be returned.
+ */
 const char *usb_ep_type_string(int ep_type)
 {
 	if (ep_type < 0 || ep_type >= ARRAY_SIZE(ep_type_names))
@@ -76,6 +82,12 @@ static const char *const ssp_rate[] = {
 	[USB_SSP_GEN_2x2] = "super-speed-plus-gen2x2",
 };
 
+/**
+ * usb_speed_string() - Returns human readable-name of the speed.
+ * @speed: The speed to return human-readable name for.  If it's not
+ *   any of the speeds defined in usb_device_speed enum, string for
+ *   USB_SPEED_UNKNOWN will be returned.
+ */
 const char *usb_speed_string(enum usb_device_speed speed)
 {
 	if (speed < 0 || speed >= ARRAY_SIZE(speed_names))
@@ -84,6 +96,14 @@ const char *usb_speed_string(enum usb_device_speed speed)
 }
 EXPORT_SYMBOL_GPL(usb_speed_string);
 
+/**
+ * usb_get_maximum_speed - Get maximum requested speed for a given USB
+ * controller.
+ * @dev: Pointer to the given USB controller device
+ *
+ * The function gets the maximum speed string from property "maximum-speed",
+ * and returns the corresponding enum usb_device_speed.
+ */
 enum usb_device_speed usb_get_maximum_speed(struct device *dev)
 {
 	const char *maximum_speed;
@@ -102,6 +122,15 @@ enum usb_device_speed usb_get_maximum_speed(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_get_maximum_speed);
 
+/**
+ * usb_get_maximum_ssp_rate - Get the signaling rate generation and lane count
+ *	of a SuperSpeed Plus capable device.
+ * @dev: Pointer to the given USB controller device
+ *
+ * If the string from "maximum-speed" property is super-speed-plus-genXxY where
+ * 'X' is the generation number and 'Y' is the number of lanes, then this
+ * function returns the corresponding enum usb_ssp_rate.
+ */
 enum usb_ssp_rate usb_get_maximum_ssp_rate(struct device *dev)
 {
 	const char *maximum_speed;
@@ -116,6 +145,12 @@ enum usb_ssp_rate usb_get_maximum_ssp_rate(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_get_maximum_ssp_rate);
 
+/**
+ * usb_state_string - Returns human readable name for the state.
+ * @state: The state to return a human-readable name for. If it's not
+ *	any of the states devices in usb_device_state_string enum,
+ *	the string UNKNOWN will be returned.
+ */
 const char *usb_state_string(enum usb_device_state state)
 {
 	static const char *const names[] = {
diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
index ba849c7bc5c7..a76a086b9c54 100644
--- a/drivers/usb/common/debug.c
+++ b/drivers/usb/common/debug.c
@@ -207,8 +207,26 @@ static void usb_decode_set_isoch_delay(__u8 wValue, char *str, size_t size)
 	snprintf(str, size, "Set Isochronous Delay(Delay = %d ns)", wValue);
 }
 
-/*
- * usb_decode_ctrl - returns a string representation of ctrl request
+/**
+ * usb_decode_ctrl - Returns human readable representation of control request.
+ * @str: buffer to return a human-readable representation of control request.
+ *       This buffer should have about 200 bytes.
+ * @size: size of str buffer.
+ * @bRequestType: matches the USB bmRequestType field
+ * @bRequest: matches the USB bRequest field
+ * @wValue: matches the USB wValue field (CPU byte order)
+ * @wIndex: matches the USB wIndex field (CPU byte order)
+ * @wLength: matches the USB wLength field (CPU byte order)
+ *
+ * Function returns decoded, formatted and human-readable description of
+ * control request packet.
+ *
+ * The usage scenario for this is for tracepoints, so function as a return
+ * use the same value as in parameters. This approach allows to use this
+ * function in TP_printk
+ *
+ * Important: wValue, wIndex, wLength parameters before invoking this function
+ * should be processed by le16_to_cpu macro.
  */
 const char *usb_decode_ctrl(char *str, size_t size, __u8 bRequestType,
 			    __u8 bRequest, __u16 wValue, __u16 wIndex,
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index 74debc824645..1cffa34740b0 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -45,76 +45,15 @@ enum usb_ssp_rate {
 	USB_SSP_GEN_2x2,
 };
 
-/**
- * usb_ep_type_string() - Returns human readable-name of the endpoint type.
- * @ep_type: The endpoint type to return human-readable name for.  If it's not
- *   any of the types: USB_ENDPOINT_XFER_{CONTROL, ISOC, BULK, INT},
- *   usually got by usb_endpoint_type(), the string 'unknown' will be returned.
- */
 extern const char *usb_ep_type_string(int ep_type);
-
-/**
- * usb_speed_string() - Returns human readable-name of the speed.
- * @speed: The speed to return human-readable name for.  If it's not
- *   any of the speeds defined in usb_device_speed enum, string for
- *   USB_SPEED_UNKNOWN will be returned.
- */
 extern const char *usb_speed_string(enum usb_device_speed speed);
-
-/**
- * usb_get_maximum_speed - Get maximum requested speed for a given USB
- * controller.
- * @dev: Pointer to the given USB controller device
- *
- * The function gets the maximum speed string from property "maximum-speed",
- * and returns the corresponding enum usb_device_speed.
- */
 extern enum usb_device_speed usb_get_maximum_speed(struct device *dev);
-
-/**
- * usb_get_maximum_ssp_rate - Get the signaling rate generation and lane count
- *	of a SuperSpeed Plus capable device.
- * @dev: Pointer to the given USB controller device
- *
- * If the string from "maximum-speed" property is super-speed-plus-genXxY where
- * 'X' is the generation number and 'Y' is the number of lanes, then this
- * function returns the corresponding enum usb_ssp_rate.
- */
 extern enum usb_ssp_rate usb_get_maximum_ssp_rate(struct device *dev);
-
-/**
- * usb_state_string - Returns human readable name for the state.
- * @state: The state to return a human-readable name for. If it's not
- *	any of the states devices in usb_device_state_string enum,
- *	the string UNKNOWN will be returned.
- */
 extern const char *usb_state_string(enum usb_device_state state);
-
 unsigned int usb_decode_interval(const struct usb_endpoint_descriptor *epd,
 				 enum usb_device_speed speed);
 
 #ifdef CONFIG_TRACING
-/**
- * usb_decode_ctrl - Returns human readable representation of control request.
- * @str: buffer to return a human-readable representation of control request.
- *       This buffer should have about 200 bytes.
- * @size: size of str buffer.
- * @bRequestType: matches the USB bmRequestType field
- * @bRequest: matches the USB bRequest field
- * @wValue: matches the USB wValue field (CPU byte order)
- * @wIndex: matches the USB wIndex field (CPU byte order)
- * @wLength: matches the USB wLength field (CPU byte order)
- *
- * Function returns decoded, formatted and human-readable description of
- * control request packet.
- *
- * The usage scenario for this is for tracepoints, so function as a return
- * use the same value as in parameters. This approach allows to use this
- * function in TP_printk
- *
- * Important: wValue, wIndex, wLength parameters before invoking this function
- * should be processed by le16_to_cpu macro.
- */
 extern const char *usb_decode_ctrl(char *str, size_t size, __u8 bRequestType,
 				   __u8 bRequest, __u16 wValue, __u16 wIndex,
 				   __u16 wLength);
-- 
2.18.0


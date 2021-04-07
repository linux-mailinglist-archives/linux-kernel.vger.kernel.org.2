Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A709C3572AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354560AbhDGRGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354550AbhDGRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:06:11 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638FBC06175F;
        Wed,  7 Apr 2021 10:06:01 -0700 (PDT)
Received: from ipservice-092-217-079-185.092.217.pools.vodafone-ip.de ([92.217.79.185] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUBcp-0001Q6-Ln; Wed, 07 Apr 2021 19:05:55 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/10] staging: rtl8188eu: move defines into the .c file
Date:   Wed,  7 Apr 2021 19:05:25 +0200
Message-Id: <20210407170531.29356-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407170531.29356-1-martin@kaiser.cx>
References: <20210407170531.29356-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the defines from usb_ops_linux.h are used only inside
usb_ops_linux.c. Move them to the .c file.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/include/usb_ops_linux.h | 8 --------
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c  | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/usb_ops_linux.h b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
index 36a53239d5df..2f4976d251a1 100644
--- a/drivers/staging/rtl8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
@@ -7,14 +7,6 @@
 #ifndef __USB_OPS_LINUX_H__
 #define __USB_OPS_LINUX_H__
 
-#define RTW_USB_CONTROL_MSG_TIMEOUT	500/* ms */
-
-#define MAX_USBCTRL_VENDORREQ_TIMES	10
-
-#define ALIGNMENT_UNIT			16
-#define MAX_VENDOR_REQ_CMD_SIZE	254	/* 8188cu SIE Support */
-#define MAX_USB_IO_CTL_SIZE	(MAX_VENDOR_REQ_CMD_SIZE + ALIGNMENT_UNIT)
-
 #define USB_HIGH_SPEED_BULK_SIZE	512
 #define USB_FULL_SPEED_BULK_SIZE	64
 
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index 74f34440fc8c..13d2733b2b1b 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -10,6 +10,14 @@
 #include <recv_osdep.h>
 #include <rtw_sreset.h>
 
+#define RTW_USB_CONTROL_MSG_TIMEOUT	500 /* ms */
+
+#define MAX_USBCTRL_VENDORREQ_TIMES	10
+
+#define ALIGNMENT_UNIT			16
+#define MAX_VENDOR_REQ_CMD_SIZE	254
+#define MAX_USB_IO_CTL_SIZE	(MAX_VENDOR_REQ_CMD_SIZE + ALIGNMENT_UNIT)
+
 #define REALTEK_USB_VENQT_READ	(USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
 #define REALTEK_USB_VENQT_WRITE	(USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
 
-- 
2.20.1


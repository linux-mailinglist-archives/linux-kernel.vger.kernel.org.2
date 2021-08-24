Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9473F5C75
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbhHXKyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:54:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43920 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbhHXKyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:54:00 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17OArCqn115512;
        Tue, 24 Aug 2021 05:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629802392;
        bh=tLtBHAGWvxZ3XAUy2MPek7fmn41zSHEmJFrc52bJeqc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hRqSxxUB9NeMqfQVvSwLC2hfUStQFJ0JCiQiNmbRdYJ5de3J02rnkneYHlSEuC2ez
         XwuTpkt8ZfMJvmQ89AsVU6sgE+KKg/t4KRGeNCPo6CCfaOB60oAYAk5ncea3/2sOIJ
         z4OkDOnIcUv18NCU8crZTcnZuYLrnQc5ztJpk9o0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17OArC5D016236
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Aug 2021 05:53:12 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 24
 Aug 2021 05:53:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 24 Aug 2021 05:53:12 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17OAr3De129176;
        Tue, 24 Aug 2021 05:53:09 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>
Subject: [RFC PATCH 2/5] usb: core: hcd: Let usb_add_hcd() indicate if roothub has to be registered
Date:   Tue, 24 Aug 2021 16:22:59 +0530
Message-ID: <20210824105302.25382-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824105302.25382-1-kishon@ti.com>
References: <20210824105302.25382-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Add __usb_add_hcd() which takes "register_hub"
flag that indicates if roothub has to be registered or not. This is in
preparation for allowing xhci to register roothub after the shared hcd
is created. The interface for usb_add_hcd() is not modified to make sure
there is no USB subsystem wide changes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/core/hcd.c  | 20 +++++++++++---------
 include/linux/usb/hcd.h |  8 ++++++--
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index c036ba5311b3..4d7a9f0e2caa 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2788,13 +2788,14 @@ static void usb_stop_hcd(struct usb_hcd *hcd)
  * @hcd: the usb_hcd structure to initialize
  * @irqnum: Interrupt line to allocate
  * @irqflags: Interrupt type flags
+ * @register_hub: Flag to indicate if roothub has to be registered.
  *
  * Finish the remaining parts of generic HCD initialization: allocate the
  * buffers of consistent memory, register the bus, request the IRQ line,
  * and call the driver's reset() and start() routines.
  */
-int usb_add_hcd(struct usb_hcd *hcd,
-		unsigned int irqnum, unsigned long irqflags)
+int __usb_add_hcd(struct usb_hcd *hcd, unsigned int irqnum, unsigned long irqflags,
+		  bool register_hub)
 {
 	int retval;
 	struct usb_device *rhdev;
@@ -2959,12 +2960,13 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	}
 
 	/* starting here, usbcore will pay attention to this root hub */
-	retval = register_root_hub(hcd);
-	if (retval != 0)
-		goto err_register_root_hub;
-
-	if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
-		usb_hcd_poll_rh_status(hcd);
+	if (register_hub) {
+		retval = register_root_hub(hcd);
+		if (retval != 0)
+			goto err_register_root_hub;
+		if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
+			usb_hcd_poll_rh_status(hcd);
+	}
 
 	return retval;
 
@@ -2988,7 +2990,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(usb_add_hcd);
+EXPORT_SYMBOL_GPL(__usb_add_hcd);
 
 /**
  * usb_remove_hcd - shutdown processing for generic HCDs
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 548a028f2dab..2c99cfe20531 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -468,8 +468,8 @@ extern struct usb_hcd *usb_create_shared_hcd(const struct hc_driver *driver,
 extern struct usb_hcd *usb_get_hcd(struct usb_hcd *hcd);
 extern void usb_put_hcd(struct usb_hcd *hcd);
 extern int usb_hcd_is_primary_hcd(struct usb_hcd *hcd);
-extern int usb_add_hcd(struct usb_hcd *hcd,
-		unsigned int irqnum, unsigned long irqflags);
+extern int __usb_add_hcd(struct usb_hcd *hcd, unsigned int irqnum, unsigned long irqflags,
+			 bool register_hub);
 extern void usb_remove_hcd(struct usb_hcd *hcd);
 extern int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1);
 int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
@@ -477,6 +477,10 @@ int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
 
 struct platform_device;
 extern void usb_hcd_platform_shutdown(struct platform_device *dev);
+
+#define usb_add_hcd(hcd, irqnum, irqflags) \
+	__usb_add_hcd(hcd, irqnum, irqflags, true)
+
 #ifdef CONFIG_USB_HCD_TEST_MODE
 extern int ehset_single_step_set_feature(struct usb_hcd *hcd, int port);
 #else
-- 
2.17.1


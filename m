Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903E63F73B0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbhHYKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:52:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35376 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbhHYKwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:52:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17PApitM086825;
        Wed, 25 Aug 2021 05:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629888704;
        bh=XLx2EJojkFsz9gShoO/9l3+gKMAZdSRVesu06aYAREc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a1W2KDVVk//uCcok7YflfDcTPGO5NxhosC4FotxyuegkREKXDT2tkXMXWGEuFBNuS
         3oMcaLfS7R4DUMJJ94YF4lLgFp+SNe98HzOcxeAbSto2ZT6hthC/3jiZ+iOiOsqF/U
         Y5X2om31jwq+MmTyvY351R9EeFa6tYfYFzL8ZFaQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17PApi3Q070999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Aug 2021 05:51:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 25
 Aug 2021 05:51:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 25 Aug 2021 05:51:44 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17PApW87129194;
        Wed, 25 Aug 2021 05:51:41 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 2/3] usb: core: hcd: Add support for deferring roothub registration
Date:   Wed, 25 Aug 2021 16:21:31 +0530
Message-ID: <20210825105132.10420-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825105132.10420-1-kishon@ti.com>
References: <20210825105132.10420-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been observed with certain PCIe USB cards (like Inateck connected
to AM64 EVM or J7200 EVM) that as soon as the primary roothub is
registered, port status change is handled even before xHC is running
leading to cold plug USB devices not detected. For such cases, registering
both the root hubs along with the second HCD is required. Add support for
deferring roothub registration in usb_add_hcd(), so that both primary and
secondary roothubs are registered along with the second HCD.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/core/hcd.c  | 28 +++++++++++++++++++++++-----
 include/linux/usb/hcd.h |  2 ++
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 775f0456f0ad..ba0493d22d13 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2795,6 +2795,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 {
 	int retval;
 	struct usb_device *rhdev;
+	struct usb_hcd *shared_hcd;
 
 	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
 		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
@@ -2956,17 +2957,34 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	}
 
 	/* starting here, usbcore will pay attention to this root hub */
-	retval = register_root_hub(hcd);
-	if (retval != 0)
-		goto err_register_root_hub;
+	shared_hcd = hcd->shared_hcd;
+	if (!usb_hcd_is_primary_hcd(hcd) && shared_hcd &&
+	    HCD_DEFER_RH_REGISTER(shared_hcd)) {
+		retval = register_root_hub(shared_hcd);
+		if (retval != 0)
+			goto err_register_shared_root_hub;
 
-	if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
-		usb_hcd_poll_rh_status(hcd);
+		if (shared_hcd->uses_new_polling && HCD_POLL_RH(shared_hcd))
+			usb_hcd_poll_rh_status(shared_hcd);
+	}
+
+	if (!HCD_DEFER_RH_REGISTER(hcd)) {
+		retval = register_root_hub(hcd);
+		if (retval != 0)
+			goto err_register_root_hub;
+
+		if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
+			usb_hcd_poll_rh_status(hcd);
+	}
 
 	return retval;
 
 err_register_root_hub:
 	usb_stop_hcd(hcd);
+err_register_shared_root_hub:
+	if (!usb_hcd_is_primary_hcd(hcd) && shared_hcd &&
+	    shared_hcd->flags & HCD_FLAG_DEFER_PRI_RH_REGISTER)
+		usb_stop_hcd(shared_hcd);
 err_hcd_driver_start:
 	if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
 		free_irq(irqnum, hcd);
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 548a028f2dab..6a357ba72f5d 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -124,6 +124,7 @@ struct usb_hcd {
 #define HCD_FLAG_RH_RUNNING		5	/* root hub is running? */
 #define HCD_FLAG_DEAD			6	/* controller has died? */
 #define HCD_FLAG_INTF_AUTHORIZED	7	/* authorize interfaces? */
+#define HCD_FLAG_DEFER_PRI_RH_REGISTER	8	/* Defer roothub registration */
 
 	/* The flags can be tested using these macros; they are likely to
 	 * be slightly faster than test_bit().
@@ -134,6 +135,7 @@ struct usb_hcd {
 #define HCD_WAKEUP_PENDING(hcd)	((hcd)->flags & (1U << HCD_FLAG_WAKEUP_PENDING))
 #define HCD_RH_RUNNING(hcd)	((hcd)->flags & (1U << HCD_FLAG_RH_RUNNING))
 #define HCD_DEAD(hcd)		((hcd)->flags & (1U << HCD_FLAG_DEAD))
+#define HCD_DEFER_RH_REGISTER(hcd) ((hcd)->flags & (1U << HCD_FLAG_DEFER_PRI_RH_REGISTER))
 
 	/*
 	 * Specifies if interfaces are authorized by default
-- 
2.17.1


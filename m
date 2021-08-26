Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A4E3F8635
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbhHZLPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:15:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57242 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242057AbhHZLPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:15:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17QBEdkL110765;
        Thu, 26 Aug 2021 06:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629976479;
        bh=PWPMK6PRH2VG44GYZyD77aTeq0zlGvqq3V/cRCNlwg4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=p+1Y/a0B0q0qDbv4kGS9bcXFreEstXg9M7C/F4NEmp+fP2zyAEgBpeKoEIJQ2PoLQ
         1laGTOHQG4Id6AaF3NgH6RLjaaXJK1yq4BtvUTel/NqbCxPAAYTaR+syHQL+ygl4/3
         Z0B/nDkBl+bakntWN9qZIU6NsXTc0fEuOxXWH3qQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17QBEdCc129214
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Aug 2021 06:14:39 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 26
 Aug 2021 06:14:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 26 Aug 2021 06:14:39 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17QBERXh053369;
        Thu, 26 Aug 2021 06:14:36 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH v2 2/3] usb: core: hcd: Add support for deferring roothub registration
Date:   Thu, 26 Aug 2021 16:44:25 +0530
Message-ID: <20210826111426.751-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210826111426.751-1-kishon@ti.com>
References: <20210826111426.751-1-kishon@ti.com>
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
Tested-by: Chris Chiu <chris.chiu@canonical.com>
---
 drivers/usb/core/hcd.c  | 27 ++++++++++++++++++++++-----
 include/linux/usb/hcd.h |  2 ++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 00d35fe1fef0..64fdfc6692c2 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2795,6 +2795,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 {
 	int retval;
 	struct usb_device *rhdev;
+	struct usb_hcd *shared_hcd;
 
 	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
 		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
@@ -2955,18 +2956,34 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		goto err_hcd_driver_start;
 	}
 
+	/* starting here, usbcore will pay attention to the shared HCD roothub */
+	shared_hcd = hcd->shared_hcd;
+	if (!usb_hcd_is_primary_hcd(hcd) && shared_hcd && HCD_DEFER_RH_REGISTER(shared_hcd)) {
+		retval = register_root_hub(shared_hcd);
+		if (retval != 0)
+			goto err_register_shared_root_hub;
+
+		if (shared_hcd->uses_new_polling && HCD_POLL_RH(shared_hcd))
+			usb_hcd_poll_rh_status(shared_hcd);
+	}
+
 	/* starting here, usbcore will pay attention to this root hub */
-	retval = register_root_hub(hcd);
-	if (retval != 0)
-		goto err_register_root_hub;
+	if (!HCD_DEFER_RH_REGISTER(hcd)) {
+		retval = register_root_hub(hcd);
+		if (retval != 0)
+			goto err_register_root_hub;
 
-	if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
-		usb_hcd_poll_rh_status(hcd);
+		if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
+			usb_hcd_poll_rh_status(hcd);
+	}
 
 	return retval;
 
 err_register_root_hub:
 	usb_stop_hcd(hcd);
+err_register_shared_root_hub:
+	if (!usb_hcd_is_primary_hcd(hcd) && shared_hcd && HCD_DEFER_RH_REGISTER(shared_hcd))
+		usb_stop_hcd(shared_hcd);
 err_hcd_driver_start:
 	if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
 		free_irq(irqnum, hcd);
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 548a028f2dab..2c1fc9212cf2 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -124,6 +124,7 @@ struct usb_hcd {
 #define HCD_FLAG_RH_RUNNING		5	/* root hub is running? */
 #define HCD_FLAG_DEAD			6	/* controller has died? */
 #define HCD_FLAG_INTF_AUTHORIZED	7	/* authorize interfaces? */
+#define HCD_FLAG_DEFER_RH_REGISTER	8	/* Defer roothub registration */
 
 	/* The flags can be tested using these macros; they are likely to
 	 * be slightly faster than test_bit().
@@ -134,6 +135,7 @@ struct usb_hcd {
 #define HCD_WAKEUP_PENDING(hcd)	((hcd)->flags & (1U << HCD_FLAG_WAKEUP_PENDING))
 #define HCD_RH_RUNNING(hcd)	((hcd)->flags & (1U << HCD_FLAG_RH_RUNNING))
 #define HCD_DEAD(hcd)		((hcd)->flags & (1U << HCD_FLAG_DEAD))
+#define HCD_DEFER_RH_REGISTER(hcd) ((hcd)->flags & (1U << HCD_FLAG_DEFER_RH_REGISTER))
 
 	/*
 	 * Specifies if interfaces are authorized by default
-- 
2.17.1


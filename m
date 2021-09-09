Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B093F4045BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350777AbhIIGnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:43:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37366 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350854AbhIIGn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:43:28 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1896gFWC057035;
        Thu, 9 Sep 2021 01:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631169735;
        bh=wLtrwmO0KBTWvlGY6UVPf2jvdy+hEiVk6Rtto3aVzfU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DWrGqNCi+X/qlxOjfC+pw16TZ4HdikDxqjN1y82Mmcq5cRfrhWnFVZzVBn/s1nvV/
         qDnDynupjjKGXo6r6JZTaUBiN+mtV24Q2NFxTH9CHsZZeZA96ikqsU3m7VavDFYKWB
         s8Rb5069VtVBS5ZssiP16Em9lBFuzc/lWmHYMD+w=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1896gFgr029618
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Sep 2021 01:42:15 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 9
 Sep 2021 01:42:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 9 Sep 2021 01:42:15 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1896g04S062945;
        Thu, 9 Sep 2021 01:42:12 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH v4 3/3] usb: core: hcd: Modularize HCD stop configuration in usb_stop_hcd()
Date:   Thu, 9 Sep 2021 12:12:00 +0530
Message-ID: <20210909064200.16216-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210909064200.16216-1-kishon@ti.com>
References: <20210909064200.16216-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Since configuration to stop HCD is invoked from
multiple places, group all of them in usb_stop_hcd().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Tested-by: Chris Chiu <chris.chiu@canonical.com>
---
 drivers/usb/core/hcd.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 99ff2d23be05..7ee6e4cc0d89 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2760,6 +2760,26 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
 	usb_put_dev(rhdev);
 }
 
+/**
+ * usb_stop_hcd - Halt the HCD
+ * @hcd: the usb_hcd that has to be halted
+ *
+ * Stop the root-hub polling timer and invoke the HCD's ->stop callback.
+ */
+static void usb_stop_hcd(struct usb_hcd *hcd)
+{
+	hcd->rh_pollable = 0;
+	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
+	del_timer_sync(&hcd->rh_timer);
+
+	hcd->driver->stop(hcd);
+	hcd->state = HC_STATE_HALT;
+
+	/* In case the HCD restarted the timer, stop it again. */
+	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
+	del_timer_sync(&hcd->rh_timer);
+}
+
 /**
  * usb_add_hcd - finish generic HCD structure initialization and register
  * @hcd: the usb_hcd structure to initialize
@@ -2960,13 +2980,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	return retval;
 
 err_register_root_hub:
-	hcd->rh_pollable = 0;
-	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	del_timer_sync(&hcd->rh_timer);
-	hcd->driver->stop(hcd);
-	hcd->state = HC_STATE_HALT;
-	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	del_timer_sync(&hcd->rh_timer);
+	usb_stop_hcd(hcd);
 err_hcd_driver_start:
 	if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
 		free_irq(irqnum, hcd);
@@ -3039,16 +3053,7 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 	 * interrupt occurs), but usb_hcd_poll_rh_status() won't invoke
 	 * the hub_status_data() callback.
 	 */
-	hcd->rh_pollable = 0;
-	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	del_timer_sync(&hcd->rh_timer);
-
-	hcd->driver->stop(hcd);
-	hcd->state = HC_STATE_HALT;
-
-	/* In case the HCD restarted the timer, stop it again. */
-	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	del_timer_sync(&hcd->rh_timer);
+	usb_stop_hcd(hcd);
 
 	if (usb_hcd_is_primary_hcd(hcd)) {
 		if (hcd->irq > 0)
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B3C3F8633
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbhHZLP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:15:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34896 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhHZLP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:15:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17QBEZSq023479;
        Thu, 26 Aug 2021 06:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629976475;
        bh=GpskVKV8g1s7JVyepAe87qFxsXLMnmmzOTAMJFXkph8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IJdoEZWyYeNuqh7ilVYuYEu05tiIKPPLAbIXwacyqIeABshi3hehzqzfJeE0mbaSn
         xbD64dUCbu6Z3fMxtx4N8KnW/y0E3YSXSe87VfLtIaGNE4T45TYO4NEFeIlA8dDajB
         wvmXcoiVRRhL249hRZl+FdahIeZcSi8NxLGLH3bk=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17QBEZjX002737
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Aug 2021 06:14:35 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 26
 Aug 2021 06:14:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 26 Aug 2021 06:14:35 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17QBERXg053369;
        Thu, 26 Aug 2021 06:14:32 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH v2 1/3] usb: core: hcd: Modularize HCD stop configuration in usb_stop_hcd()
Date:   Thu, 26 Aug 2021 16:44:24 +0530
Message-ID: <20210826111426.751-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210826111426.751-1-kishon@ti.com>
References: <20210826111426.751-1-kishon@ti.com>
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
index 0f8b7c93310e..00d35fe1fef0 100644
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
@@ -2946,13 +2966,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
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
@@ -3022,16 +3036,7 @@ void usb_remove_hcd(struct usb_hcd *hcd)
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


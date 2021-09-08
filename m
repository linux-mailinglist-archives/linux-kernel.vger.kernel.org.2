Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E7403754
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351407AbhIHJym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:54:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57490 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351393AbhIHJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:54:39 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1889rR6O001016;
        Wed, 8 Sep 2021 04:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631094807;
        bh=UPLBJBjpDV9YcG77Py1APlFvPEf164At/6lGLF5HjU8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZfWH1yNJMNit3shcTvDmJrurLjXne62eOSjyWJONbkkgertbDVf1bP3MHNfu6Yo7J
         kwAe5TnITmSwrSq4aRwFW1TgMY6cm60F9Szn60faaWTzK5HvTErG/ZoFG8GaXw08jQ
         RHV9bLsrrQhzOXHFLo29ND0itst9hC401F7qTEvM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1889rR8c030298
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Sep 2021 04:53:27 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Sep 2021 04:53:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Sep 2021 04:53:27 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1889rC4E019690;
        Wed, 8 Sep 2021 04:53:24 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH v3 3/3] usb: core: hcd: Modularize HCD stop configuration in usb_stop_hcd()
Date:   Wed, 8 Sep 2021 15:23:12 +0530
Message-ID: <20210908095312.985-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908095312.985-1-kishon@ti.com>
References: <20210908095312.985-1-kishon@ti.com>
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
index 30bbf4ac4284..6f72da245f69 100644
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
@@ -3040,16 +3054,7 @@ void usb_remove_hcd(struct usb_hcd *hcd)
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


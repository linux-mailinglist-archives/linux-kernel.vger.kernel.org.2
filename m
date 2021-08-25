Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDC3F73AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbhHYKwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:52:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45288 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhHYKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:52:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17PApfWn003141;
        Wed, 25 Aug 2021 05:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629888701;
        bh=ryQV4OtgpjUer2JjK/Hy7MnRhygrr4yUFCxHpTqta4U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Y0p3QrHOpw68TtqYLarmehgmne8Io5Jm//jwFsyBZeC26+UxFJ13PhFUyq4egn3qV
         V20fe8tTJ2gD18TxFqD0iM475Es3mIq4SIGIMUr/REvW8LqPu35d191Cp2b1LgaCGh
         mluKUvCGezixeiLrImAItl5v/87sgxhtboNJPDbc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17PApfEH070934
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Aug 2021 05:51:41 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 25
 Aug 2021 05:51:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 25 Aug 2021 05:51:40 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17PApW86129194;
        Wed, 25 Aug 2021 05:51:37 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 1/3] usb: core: hcd: Modularize HCD stop configuration in usb_stop_hcd()
Date:   Wed, 25 Aug 2021 16:21:30 +0530
Message-ID: <20210825105132.10420-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825105132.10420-1-kishon@ti.com>
References: <20210825105132.10420-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Since configuration to stop HCD is invoked from
multiple places, group all of them in usb_stop_hcd().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/core/hcd.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 0f8b7c93310e..775f0456f0ad 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2760,6 +2760,26 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
 	usb_put_dev(rhdev);
 }
 
+/**
+ * usb_stop_hcd - Halt the HCD
+ * @hcd: the usb_hcd that has to be halted
+ *
+ * Stop the timer and invoke ->stop() callback on the HCD
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


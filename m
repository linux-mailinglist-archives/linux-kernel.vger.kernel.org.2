Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38223F5C77
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhHXKyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:54:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43928 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbhHXKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:54:02 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17OArFNe115522;
        Tue, 24 Aug 2021 05:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629802395;
        bh=H1g1X9IA47qU7hRXNqLolqlyxE7PPZmGK5nBlX+YghY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Hqcns6OxLNjujzMUF3MABlzg86LQdamIxPf3b7VshUnvadFt6ANBRAzG/JM7mQbcE
         l+ZZFr6ihPvd5b90lPdceoBgRqf/n2qQMtgpMk9vNFQrtAI8NwYbfWbs/tuNJ0stq/
         WgCG+ATghT2CpUqbLAsQ24+YF3zuhw+eo+TSHSgA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17OArEec016279
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Aug 2021 05:53:15 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 24
 Aug 2021 05:53:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 24 Aug 2021 05:53:14 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17OAr3Df129176;
        Tue, 24 Aug 2021 05:53:12 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>
Subject: [RFC PATCH 3/5] usb: core: hcd: Add support for registering secondary RH along with primary HCD
Date:   Tue, 24 Aug 2021 16:23:00 +0530
Message-ID: <20210824105302.25382-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824105302.25382-1-kishon@ti.com>
References: <20210824105302.25382-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for registering secondary roothub (RH) along with primary HCD.
It has been observed with certain PCIe USB cards that as soon as the
primary HCD is registered, port status change is handled leading to cold
plug devices getting not detected. For such cases, registering both the
root hubs along with the second HCD is useful.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/core/hcd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 4d7a9f0e2caa..9c8df22a7d9a 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2799,6 +2799,7 @@ int __usb_add_hcd(struct usb_hcd *hcd, unsigned int irqnum, unsigned long irqfla
 {
 	int retval;
 	struct usb_device *rhdev;
+	struct usb_hcd *shared_hcd = NULL;
 
 	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
 		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
@@ -2961,6 +2962,15 @@ int __usb_add_hcd(struct usb_hcd *hcd, unsigned int irqnum, unsigned long irqfla
 
 	/* starting here, usbcore will pay attention to this root hub */
 	if (register_hub) {
+		shared_hcd = hcd->shared_hcd;
+		if (shared_hcd) {
+			retval = register_root_hub(shared_hcd);
+			if (retval != 0)
+				goto err_register_shared_root_hub;
+			if (shared_hcd->uses_new_polling && HCD_POLL_RH(shared_hcd))
+				usb_hcd_poll_rh_status(shared_hcd);
+		}
+
 		retval = register_root_hub(hcd);
 		if (retval != 0)
 			goto err_register_root_hub;
@@ -2972,6 +2982,8 @@ int __usb_add_hcd(struct usb_hcd *hcd, unsigned int irqnum, unsigned long irqfla
 
 err_register_root_hub:
 	usb_stop_hcd(hcd);
+err_register_shared_root_hub:
+	usb_stop_hcd(shared_hcd);
 err_hcd_driver_start:
 	if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
 		free_irq(irqnum, hcd);
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4473F73B2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbhHYKwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:52:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35388 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbhHYKwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:52:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17PApm3q086839;
        Wed, 25 Aug 2021 05:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629888708;
        bh=GaS42XPzy+IzWgDptEm7iQbdbNddfetdjBkNUeG0FgQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jX0VIQNBQ7cvWmNB/3lxltuFoJ1VJ3cEEK4CXO4prHwLPhFmkevkh6wdQ13YASseY
         VNHW1k6LIScoAwz9MPAI+5cDZMlvYBMYdqHEwbTqYrM/otXqWPv81FW0K2SaJn3Gzr
         TF0LMgPGKv78qiqOZNXYUYYDrb7hxzzBka2o2aII=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17PApmef010231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Aug 2021 05:51:48 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 25
 Aug 2021 05:51:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 25 Aug 2021 05:51:48 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17PApW88129194;
        Wed, 25 Aug 2021 05:51:45 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 3/3] xhci: Set HCD flag to defer primary roothub registration
Date:   Wed, 25 Aug 2021 16:21:32 +0530
Message-ID: <20210825105132.10420-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825105132.10420-1-kishon@ti.com>
References: <20210825105132.10420-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set "HCD_FLAG_DEFER_PRI_RH_REGISTER" to hcd->flags in xhci_run() to defer
registering primary roothub in usb_add_hcd(). This will make sure both
primary roothub and secondary roothub will be registered along with the
second HCD. This is required for cold plugged USB devices to be detected
in certain PCIe USB cards (like Inateck USB card connected to AM64 EVM
or J7200 EVM).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3618070eba78..9b7d968022c8 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -644,7 +644,6 @@ int xhci_run(struct usb_hcd *hcd)
 	/* Start the xHCI host controller running only after the USB 2.0 roothub
 	 * is setup.
 	 */
-
 	hcd->uses_new_polling = 1;
 	if (!usb_hcd_is_primary_hcd(hcd))
 		return xhci_run_finished(xhci);
@@ -692,6 +691,7 @@ int xhci_run(struct usb_hcd *hcd)
 		if (ret)
 			xhci_free_command(xhci, command);
 	}
+	set_bit(HCD_FLAG_DEFER_PRI_RH_REGISTER, &hcd->flags);
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Finished xhci_run for USB2 roothub");
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA39B325EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhBZIYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:24:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13003 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhBZIYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:24:42 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dn2hG3gXmzjSbW;
        Fri, 26 Feb 2021 16:22:22 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Feb 2021
 16:23:49 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <yisen.zhuang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] USB:XHCI:Modify XHCI driver for USB2.0 controller
Date:   Fri, 26 Feb 2021 16:21:37 +0800
Message-ID: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our current XHCI hardware controller has been customized to only
support USB 2.0 ports. When using the current xhci driver, an xhci
controller device and an ehci controller device will be created
automatically. We want the driver to create only one ehci controller.
After modifying the driver as follows, an error will occur.
Is there any other modification method?

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/usb/host/xhci-pci.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index ef513c2..7296aad 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -364,26 +364,15 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	/* USB 2.0 roothub is stored in the PCI device now. */
 	hcd = dev_get_drvdata(&dev->dev);
 	xhci = hcd_to_xhci(hcd);
-	xhci->shared_hcd = usb_create_shared_hcd(&xhci_pci_hc_driver, &dev->dev,
-						 pci_name(dev), hcd);
-	if (!xhci->shared_hcd) {
-		retval = -ENOMEM;
-		goto dealloc_usb2_hcd;
-	}
-
+	xhci->shared_hcd = NULL;
 	retval = xhci_ext_cap_init(xhci);
 	if (retval)
 		goto put_usb3_hcd;
 
-	retval = usb_add_hcd(xhci->shared_hcd, dev->irq,
+	retval = usb_add_hcd(xhci->main_hcd, dev->irq,
 			IRQF_SHARED);
 	if (retval)
 		goto put_usb3_hcd;
-	/* Roothub already marked as USB 3.0 speed */
-
-	if (!(xhci->quirks & XHCI_BROKEN_STREAMS) &&
-			HCC_MAX_PSA(xhci->hcc_params) >= 4)
-		xhci->shared_hcd->can_do_streams = 1;
 
 	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
 	pm_runtime_put_noidle(&dev->dev);
-- 
2.8.1


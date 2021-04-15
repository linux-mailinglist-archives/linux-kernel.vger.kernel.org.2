Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE75C360944
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhDOMZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:25:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16124 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhDOMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:25:54 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FLdlC5ynrzpY88;
        Thu, 15 Apr 2021 20:22:31 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Thu, 15 Apr 2021
 20:25:15 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <liudongdong3@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>, <kong.kongxinwei@hisilicon.com>,
        <yisen.zhuang@huawei.com>
Subject: [RFC PATCH] USB:XHCI:skip hub registration
Date:   Thu, 15 Apr 2021 20:22:38 +0800
Message-ID: <1618489358-42283-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the number of ports on the USB hub is 0, skip the registration
operation of the USB hub.

The current Kunpeng930's XHCI hardware controller is defective. The number
of ports on its USB3.0 bus controller is 0, and the number of ports on
the USB2.0 bus controller is 1.

In order to solve this problem that the USB3.0 controller does not have
a port which causes the registration of the hub to fail, this patch passes
the defect information by adding flags in the quirks of xhci and usb_hcd,
and finally skips the registration process of the hub directly according
to the results of these flags when the hub is initialized.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/usb/core/hub.c      | 6 ++++++
 drivers/usb/host/xhci-pci.c | 4 ++++
 drivers/usb/host/xhci.c     | 5 +++++
 drivers/usb/host/xhci.h     | 1 +
 include/linux/usb/hcd.h     | 1 +
 5 files changed, 17 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b1e14be..2d6869d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1769,9 +1769,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_host_interface *desc;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	struct usb_hcd *hcd;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
+	hcd = bus_to_hcd(hdev->bus);
+	if (hcd->usb3_no_port) {
+		dev_warn(&intf->dev, "USB hub has no port\n");
+		return -ENODEV;
+	}
 
 	/*
 	 * Set default autosuspend delay as 0 to speedup bus suspend,
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index ef513c2..63b89a4 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -281,6 +281,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
 				"QUIRK: Resetting on resume");
+
+	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
+	    pdev->device == 0xa23c)
+		xhci->quirks |= XHCI_USB3_NOPORT;
 }
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index bee5dec..e3e3573 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5184,6 +5184,11 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 		/* xHCI private pointer was set in xhci_pci_probe for the second
 		 * registered roothub.
 		 */
+		if (xhci->quirks & XHCI_USB3_NOPORT) {
+			xhci_info(xhci, "xHCI host has no port\n");
+			hcd->usb3_no_port = 1;
+		}
+
 		return 0;
 	}
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 2c6c4f8..d3c658f 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1874,6 +1874,7 @@ struct xhci_hcd {
 #define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
 #define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
 #define XHCI_RENESAS_FW_QUIRK	BIT_ULL(36)
+#define XHCI_USB3_NOPORT	BIT_ULL(37)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 3dbb42c..7df23a0f 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -172,6 +172,7 @@ struct usb_hcd {
 	unsigned		tpl_support:1; /* OTG & EH TPL support */
 	unsigned		cant_recv_wakeups:1;
 			/* wakeup requests from downstream aren't received */
+	unsigned		usb3_no_port:1; /* xHCI main_hcd has no port */
 
 	unsigned int		irq;		/* irq allocated */
 	void __iomem		*regs;		/* device memory/io */
-- 
2.8.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3A3F5C79
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhHXKyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:54:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59772 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbhHXKyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:54:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17OArIAI066452;
        Tue, 24 Aug 2021 05:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629802398;
        bh=3rJTEfJn/oAUbfpfHmC7ElWuOC9zGfOzG9ekrqMw+ac=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oHVgNdzPEHtl128Xqs6hsj3PAAVYXxdKqfvEUuAuGXSWTPtP9+rHQ+7bbkVRa5A5b
         vl4TLSsQkKTJDmcjkzDgAPY1O+C4cHQL0of2nJZRkUDGkYC9Uac74DUbnx8KcKZSUt
         x1jdO17xeYfgoJDeZNPgnNesPTvNvbUWao8qMSjE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17OArH1f016349
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Aug 2021 05:53:17 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 24
 Aug 2021 05:53:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 24 Aug 2021 05:53:17 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17OAr3Dg129176;
        Tue, 24 Aug 2021 05:53:15 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>
Subject: [RFC PATCH 4/5] usb: core: hcd-pci: Let usb_hcd_pci_probe() indicate if RH has to be registered
Date:   Tue, 24 Aug 2021 16:23:01 +0530
Message-ID: <20210824105302.25382-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824105302.25382-1-kishon@ti.com>
References: <20210824105302.25382-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Add __usb_hcd_pci_probe() which takes "register_hub"
flag that indicates if roothub (RH) has to be registered or not. This is in
preparation for allowing xhci-pci to register roothub after the shared hcd
is created. The interface for usb_hcd_pci_probe() is not modified to make
sure there are minimal code changes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/core/hcd-pci.c | 11 ++++++-----
 include/linux/usb/hcd.h    |  8 +++++---
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index d630cccd2e6e..65c1f9aee4d1 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -160,6 +160,7 @@ static void ehci_wait_for_companions(struct pci_dev *pdev, struct usb_hcd *hcd,
  * @dev: USB Host Controller being probed
  * @id: pci hotplug id connecting controller to HCD framework
  * @driver: USB HC driver handle
+ * @register_hub: Flag to indicate of roothub has to be registered or not
  *
  * Context: task context, might sleep
  *
@@ -171,8 +172,8 @@ static void ehci_wait_for_companions(struct pci_dev *pdev, struct usb_hcd *hcd,
  *
  * Return: 0 if successful.
  */
-int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id,
-		      const struct hc_driver *driver)
+int __usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id,
+			const struct hc_driver *driver, bool register_hub)
 {
 	struct usb_hcd		*hcd;
 	int			retval;
@@ -262,7 +263,7 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id,
 		down_write(&companions_rwsem);
 		dev_set_drvdata(&dev->dev, hcd);
 		for_each_companion(dev, hcd, ehci_pre_add);
-		retval = usb_add_hcd(hcd, hcd_irq, IRQF_SHARED);
+		retval = __usb_add_hcd(hcd, hcd_irq, IRQF_SHARED, register_hub);
 		if (retval != 0)
 			dev_set_drvdata(&dev->dev, NULL);
 		for_each_companion(dev, hcd, ehci_post_add);
@@ -270,7 +271,7 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id,
 	} else {
 		down_read(&companions_rwsem);
 		dev_set_drvdata(&dev->dev, hcd);
-		retval = usb_add_hcd(hcd, hcd_irq, IRQF_SHARED);
+		retval = __usb_add_hcd(hcd, hcd_irq, IRQF_SHARED, register_hub);
 		if (retval != 0)
 			dev_set_drvdata(&dev->dev, NULL);
 		else
@@ -296,7 +297,7 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id,
 	dev_err(&dev->dev, "init %s fail, %d\n", pci_name(dev), retval);
 	return retval;
 }
-EXPORT_SYMBOL_GPL(usb_hcd_pci_probe);
+EXPORT_SYMBOL_GPL(__usb_hcd_pci_probe);
 
 
 /* may be called without controller electrically present */
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 2c99cfe20531..49c1a8d56b2c 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -493,14 +493,16 @@ static inline int ehset_single_step_set_feature(struct usb_hcd *hcd, int port)
 #ifdef CONFIG_USB_PCI
 struct pci_dev;
 struct pci_device_id;
-extern int usb_hcd_pci_probe(struct pci_dev *dev,
-			     const struct pci_device_id *id,
-			     const struct hc_driver *driver);
+extern int __usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id,
+			       const struct hc_driver *driver, bool register_hub);
 extern void usb_hcd_pci_remove(struct pci_dev *dev);
 extern void usb_hcd_pci_shutdown(struct pci_dev *dev);
 
 extern int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *dev);
 
+#define usb_hcd_pci_probe(dev, id, driver) \
+	__usb_hcd_pci_probe(dev, id, driver, true)
+
 #ifdef CONFIG_PM
 extern const struct dev_pm_ops usb_hcd_pci_pm_ops;
 #endif
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFEE357ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhDHJMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:12:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16085 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhDHJMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:12:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGFpc6fQ2z1BFyw;
        Thu,  8 Apr 2021 17:10:16 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 17:12:21 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <liudongdong3@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>, <kong.kongxinwei@hisilicon.com>,
        <yisen.zhuang@huawei.com>
Subject: [PATCH] USB:ehci:fix ehci hardware problem
Date:   Thu, 8 Apr 2021 17:09:45 +0800
Message-ID: <1617872985-42735-4-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617872985-42735-1-git-send-email-liulongfang@huawei.com>
References: <1617872985-42735-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rebooting the EHCI driver, ehci_shutdown() will be called.
if the sbrn flag is 0, ehci_shutdown() will return directly.

Kunpeng920's EHCI hardware does not define the SBRN register, which cause
its value to default to 0. The sbrn flag being 0 will cause the
EHCI interrupt signal to not be turned off after reboot. An interrupt
that is not closed will cause an exception to the device sharing
the interrupt.

Currently, Kunpeng920's EHCI hardware has this problem. We hope to
solve this problem by skipping reading the sbrn register value.
On the EHCI hardware of the next-generation Kunpeng930, we will define
this SBRN register in accordance with the controller standard.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/usb/host/ehci-pci.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 3c3820a..738d773 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -47,6 +47,31 @@ static inline bool is_bypassed_id(struct pci_dev *pdev)
 	return !!pci_match_id(bypass_pci_id_table, pdev);
 }
 
+static const struct usb_sbrn_whitelist_entry {
+	unsigned short vendor;
+	unsigned short device;
+} usb_sbrn_whitelist[] = {
+	/* STMICRO ConneXT has no sbrn register */
+	{PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_USB_HOST},
+	/* HUAWEI sbrn register is undefined */
+	{PCI_VENDOR_ID_HUAWEI, 0xa239},
+	{}
+};
+
+static bool usb_sbrn_whitelist_check(struct pci_dev *pdev)
+{
+	const struct usb_sbrn_whitelist_entry *entry;
+	unsigned short vendor = pdev->vendor;
+	unsigned short device = pdev->device;
+
+	for (entry = usb_sbrn_whitelist; entry->vendor; entry++) {
+		if (vendor == entry->vendor && device == entry->device)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * 0x84 is the offset of in/out threshold register,
  * and it is the same offset as the register of 'hostpc'.
@@ -288,10 +313,7 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
 	}
 
 	/* Serial Bus Release Number is at PCI 0x60 offset */
-	if (pdev->vendor == PCI_VENDOR_ID_STMICRO
-	    && pdev->device == PCI_DEVICE_ID_STMICRO_USB_HOST)
-		;	/* ConneXT has no sbrn register */
-	else
+	if (!usb_sbrn_whitelist_check(pdev))
 		pci_read_config_byte(pdev, 0x60, &ehci->sbrn);
 
 	/* Keep this around for a while just in case some EHCI
-- 
2.8.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7B35854B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhDHNwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:52:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15631 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhDHNwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:52:15 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGN0T5t8qzpWdy;
        Thu,  8 Apr 2021 21:49:13 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 21:51:54 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <liudongdong3@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>, <kong.kongxinwei@hisilicon.com>,
        <yisen.zhuang@huawei.com>
Subject: [PATCH v2 1/2] USB:ehci:Add a whitelist for EHCI controllers
Date:   Thu, 8 Apr 2021 21:49:19 +0800
Message-ID: <1617889760-17733-2-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617889760-17733-1-git-send-email-liulongfang@huawei.com>
References: <1617889760-17733-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some types of EHCI controllers do not have SBRN registers.
By comparing the white list, the operation of reading the SBRN
registers is skipped.

Subsequent EHCI controller types without SBRN registers can be
directly added to the white list.

The current patch does not affect the drive function.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/usb/host/ehci-pci.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 3c3820a..534e906 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -47,6 +47,29 @@ static inline bool is_bypassed_id(struct pci_dev *pdev)
 	return !!pci_match_id(bypass_pci_id_table, pdev);
 }
 
+static const struct usb_nosbrn_whitelist_entry {
+	u16 vendor;
+	u16 device;
+} usb_nosbrn_whitelist[] = {
+	/* STMICRO ConneXT has no sbrn register */
+	{PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_USB_HOST},
+	/* End of list */
+	{NULL, NULL}
+};
+
+static bool usb_forbid_sbrn_read(struct pci_dev *pdev)
+{
+	const struct usb_nosbrn_whitelist_entry *entry;
+
+	for (entry = usb_nosbrn_whitelist; entry->vendor; entry++) {
+		if (pdev->vendor == entry->vendor &&
+		    pdev->device == entry->device)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * 0x84 is the offset of in/out threshold register,
  * and it is the same offset as the register of 'hostpc'.
@@ -288,10 +311,7 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
 	}
 
 	/* Serial Bus Release Number is at PCI 0x60 offset */
-	if (pdev->vendor == PCI_VENDOR_ID_STMICRO
-	    && pdev->device == PCI_DEVICE_ID_STMICRO_USB_HOST)
-		;	/* ConneXT has no sbrn register */
-	else
+	if (!usb_forbid_sbrn_read(pdev))
 		pci_read_config_byte(pdev, 0x60, &ehci->sbrn);
 
 	/* Keep this around for a while just in case some EHCI
-- 
2.8.1


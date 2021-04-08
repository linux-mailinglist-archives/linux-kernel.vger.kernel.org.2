Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1C357EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhDHJOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:14:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16830 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhDHJOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:14:06 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGFrG3mDsz93fs;
        Thu,  8 Apr 2021 17:11:42 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 17:13:46 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <liudongdong3@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>, <kong.kongxinwei@hisilicon.com>,
        <yisen.zhuang@huawei.com>
Subject: [PATCH 1/2] USB:ehci:Add a whitelist for EHCI controllers
Date:   Thu, 8 Apr 2021 17:11:12 +0800
Message-ID: <1617873073-37371-2-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617873073-37371-1-git-send-email-liulongfang@huawei.com>
References: <1617873073-37371-1-git-send-email-liulongfang@huawei.com>
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
 drivers/usb/host/ehci-pci.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 3c3820a..6a30afa 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -47,6 +47,28 @@ static inline bool is_bypassed_id(struct pci_dev *pdev)
 	return !!pci_match_id(bypass_pci_id_table, pdev);
 }
 
+static const struct usb_nosbrn_whitelist_entry {
+	unsigned short vendor;
+	unsigned short device;
+} usb_nosbrn_whitelist[] = {
+	/* STMICRO ConneXT has no sbrn register */
+	{PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_USB_HOST},
+	{}
+};
+
+static bool usb_nosbrn_whitelist_check(struct pci_dev *pdev)
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
@@ -288,10 +310,7 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
 	}
 
 	/* Serial Bus Release Number is at PCI 0x60 offset */
-	if (pdev->vendor == PCI_VENDOR_ID_STMICRO
-	    && pdev->device == PCI_DEVICE_ID_STMICRO_USB_HOST)
-		;	/* ConneXT has no sbrn register */
-	else
+	if (!usb_nosbrn_whitelist_check(pdev))
 		pci_read_config_byte(pdev, 0x60, &ehci->sbrn);
 
 	/* Keep this around for a while just in case some EHCI
-- 
2.8.1


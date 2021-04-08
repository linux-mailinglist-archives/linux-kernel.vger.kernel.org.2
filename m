Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E721357CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhDHHGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:06:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16824 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhDHHGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:06:38 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGC1B3Mvyz93XJ;
        Thu,  8 Apr 2021 15:04:14 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 15:06:19 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <liudongdong3@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>, <kong.kongxinwei@hisilicon.com>,
        <yisen.zhuang@huawei.com>
Subject: [PATCH] USB:ehci:fix ehci hardware problem
Date:   Thu, 8 Apr 2021 15:03:45 +0800
Message-ID: <1617865425-28782-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rebooting the EHCI driver, ehci_shutdown() will be called.
if the sbrn flag is 0, ehci_shutdown() will return directly.

Our EHCI hardware does not define the SBRN register, which cause
its value to default to 0. The sbrn flag being 0 will cause the
EHCI interrupt signal to not be turned off after reboot. An interrupt
that is not closed will cause an exception to the device sharing
the interrupt.

Currently, our hardware has this problem. We hope to solve this
problem by skipping reading the sbrn register value. On the next
generation of hardware, we will define this SBRN register in accordance
with the controller standard.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/usb/host/ehci-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 3c3820a..5dc6821 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -291,6 +291,8 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
 	if (pdev->vendor == PCI_VENDOR_ID_STMICRO
 	    && pdev->device == PCI_DEVICE_ID_STMICRO_USB_HOST)
 		;	/* ConneXT has no sbrn register */
+	else if (pdev->vendor == PCI_VENDOR_ID_HUAWEI)
+		;	/* sbrn register is undefined */
 	else
 		pci_read_config_byte(pdev, 0x60, &ehci->sbrn);
 
-- 
2.8.1


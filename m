Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AD735854C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhDHNwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:52:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15630 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhDHNwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:52:15 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGN0T5dhfzpWdv;
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
Subject: [PATCH v2 2/2] USB:ehci:fix Kunpeng920 ehci hardware problem
Date:   Thu, 8 Apr 2021 21:49:20 +0800
Message-ID: <1617889760-17733-3-git-send-email-liulongfang@huawei.com>
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

Kunpeng920's EHCI controller does not have SBRN register.
Reading the SBRN register when the controller driver is
initialized will get 0.

When rebooting the EHCI driver, ehci_shutdown() will be called.
if the sbrn flag is 0, ehci_shutdown() will return directly.
The sbrn flag being 0 will cause the EHCI interrupt signal to
not be turned off after reboot. this interrupt that is not closed
will cause an exception to the device sharing the interrupt.

Therefore, the EHCI controller of kunpeng920 needs to be added
to the whitelist without SBRN register.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/usb/host/ehci-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 534e906..7bd075c 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -53,6 +53,8 @@ static const struct usb_nosbrn_whitelist_entry {
 } usb_nosbrn_whitelist[] = {
 	/* STMICRO ConneXT has no sbrn register */
 	{PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_USB_HOST},
+	/* HUAWEI Kunpeng920 HiSilicon USB EHCI has no sbrn register */
+	{PCI_VENDOR_ID_HUAWEI, 0xa239},
 	/* End of list */
 	{NULL, NULL}
 };
-- 
2.8.1


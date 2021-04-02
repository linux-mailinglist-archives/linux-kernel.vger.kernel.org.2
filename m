Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EDB352853
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhDBJNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:13:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15468 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbhDBJNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:13:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FBZ6n5wwXzyNNs;
        Fri,  2 Apr 2021 17:11:29 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 17:13:30 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>, <kong.kongxinwei@hisilicon.com>,
        <yisen.zhuang@huawei.com>
Subject: [PATCH] USB:ohci:fix ohci interruption problem
Date:   Fri, 2 Apr 2021 17:11:00 +0800
Message-ID: <1617354660-43964-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The operating method of the system entering S4 sleep mode:
echo disk > /sys/power/state

When OHCI enters the S4 sleep state, the USB sleep process will call
check_root_hub_suspend() and ohci_bus_suspend() instead of
ohci_suspend() and ohci_bus_suspend(), this causes the OHCI interrupt
to not be closed.

At this time, if just one device interrupt is reported. Since rh_state
has been changed to OHCI_RH_SUSPENDED after ohci_bus_suspend(), the
driver will not process and close this device interrupt. It will cause
the entire system to be stuck during sleep, causing the device to
fail to respond.

When the abnormal interruption reaches 100,000 times, the system will
forcibly close the interruption and make the device unusable.

Because the root cause of the problem is that ohci_suspend is not
called to perform normal interrupt shutdown operations when the system
enters S4 sleep mode.

Therefore, our solution is to specify freeze interface in this mode to
perform normal suspend_common() operations, and call ohci_suspend()
after check_root_hub_suspend() is executed through the suspend_common()
operation.
After using this solution, it is verified by the stress test of sleep
wake up in S4 mode for a long time that this problem no longer occurs.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/usb/core/hcd-pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 1547aa6..78a56cd 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -509,6 +509,11 @@ static int resume_common(struct device *dev, int event)
 
 #ifdef	CONFIG_PM_SLEEP
 
+static int hcd_pci_freeze(struct device *dev)
+{
+	return suspend_common(dev, device_may_wakeup(dev));
+}
+
 static int hcd_pci_suspend(struct device *dev)
 {
 	return suspend_common(dev, device_may_wakeup(dev));
@@ -605,8 +610,8 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
 	.suspend_noirq	= hcd_pci_suspend_noirq,
 	.resume_noirq	= hcd_pci_resume_noirq,
 	.resume		= hcd_pci_resume,
-	.freeze		= check_root_hub_suspended,
-	.freeze_noirq	= check_root_hub_suspended,
+	.freeze		= hcd_pci_freeze,
+	.freeze_noirq	= hcd_pci_freeze,
 	.thaw_noirq	= NULL,
 	.thaw		= NULL,
 	.poweroff	= hcd_pci_suspend,
-- 
2.8.1


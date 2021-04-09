Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD933596BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhDIHuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:50:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15644 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhDIHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:50:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGqw31WDqzpW8c;
        Fri,  9 Apr 2021 15:46:59 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 15:49:36 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <liudongdong3@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>, <kong.kongxinwei@hisilicon.com>,
        <yisen.zhuang@huawei.com>
Subject: [PATCH v2] USB:ohci:fix ohci interruption problem
Date:   Fri, 9 Apr 2021 15:47:02 +0800
Message-ID: <1617954422-36617-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The operating method of the system entering S4 sleep mode:
echo reboot > /sys/power/disk
echo disk > /sys/power/state

When OHCI enters the S4 sleep state, check the log and find that
the USB sleep process will call check_root_hub_suspend() and
ohci_bus_suspend() instead ohci_suspend() and ohci_bus_suspend(),
which will cause the OHCI interrupt to not be closed.

At this time, if just one device interrupt is reported. the
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

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---

Changes in V2:
	- Modify comment and patch version information.

Changes in V1:
	- Call suspend_common by adding the hcd_pci_freeze function turn off
	the interrupt instead of adding a shutdown operation in ohci_bus_suspend
	to turn off the interrupt.

 drivers/usb/core/hcd-pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 1547aa6..c5844a3 100644
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
@@ -605,7 +610,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
 	.suspend_noirq	= hcd_pci_suspend_noirq,
 	.resume_noirq	= hcd_pci_resume_noirq,
 	.resume		= hcd_pci_resume,
-	.freeze		= check_root_hub_suspended,
+	.freeze		= hcd_pci_freeze,
 	.freeze_noirq	= check_root_hub_suspended,
 	.thaw_noirq	= NULL,
 	.thaw		= NULL,
-- 
2.8.1


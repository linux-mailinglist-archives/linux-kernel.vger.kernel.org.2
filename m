Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF46234A37A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCZI6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:58:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14490 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCZI5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:57:45 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6G5c3HSJzrbDW;
        Fri, 26 Mar 2021 16:55:32 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Mar 2021
 16:57:22 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <yisen.zhuang@huawei.com>,
        <tanxiaofei@huawei.com>, <liudongdong3@huawei.com>,
        <liulongfang@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] USB:ohci:fix ohci interruption problem
Date:   Fri, 26 Mar 2021 16:54:56 +0800
Message-ID: <1616748896-9415-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Since the problem is that the interrupt is not closed, we copied the
interrupt shutdown operation of ohci_suspend() into ohci_bus_suspend()
during the S4 sleep period. We found that this method can solve this
problem.

At present, we hope to be able to call ohci_suspend() directly during
the sleep process of S4. Do you have any suggestions for this
modification?

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/usb/host/ohci-hub.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index 634f3c7..d468cef 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -315,6 +315,14 @@ static int ohci_bus_suspend (struct usb_hcd *hcd)
 		del_timer_sync(&ohci->io_watchdog);
 		ohci->prev_frame_no = IO_WATCHDOG_OFF;
 	}
+
+	spin_lock_irqsave(&ohci->lock, flags);
+	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
+	(void)ohci_readl(ohci, &ohci->regs->intrdisable);
+
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	spin_unlock_irqrestore(&ohci->lock, flags);
+
 	return rc;
 }
 
@@ -326,7 +334,10 @@ static int ohci_bus_resume (struct usb_hcd *hcd)
 	if (time_before (jiffies, ohci->next_statechange))
 		msleep(5);
 
-	spin_lock_irq (&ohci->lock);
+	spin_lock_irq(&ohci->lock);
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrenable);
+	ohci_readl(ohci, &ohci->regs->intrenable);
 
 	if (unlikely(!HCD_HW_ACCESSIBLE(hcd)))
 		rc = -ESHUTDOWN;
-- 
2.8.1


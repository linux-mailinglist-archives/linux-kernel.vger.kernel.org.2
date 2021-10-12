Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526B3429FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhJLIdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:33:10 -0400
Received: from mail.loongson.cn ([114.242.206.163]:32894 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234745AbhJLIdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:33:05 -0400
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL2q7R2VhdJkYAA--.23631S2;
        Tue, 12 Oct 2021 16:30:55 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Cc:     zhuyinbo@loongson.cn
Subject: [PATCH v5] usb: ohci: disable start-of-frame interrupt in ohci_rh_suspend
Date:   Tue, 12 Oct 2021 16:30:50 +0800
Message-Id: <1634027450-3358-1-git-send-email-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9DxL2q7R2VhdJkYAA--.23631S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWxCFWrGF1kAF1UCw1Dtrb_yoW8Gw17pF
        4a9r43tw43ta1jvF1UGFs7CayrK3Z8KrW7tasFk3yUA39xtw1F9r9rKFW5tFn3WrWfKw1a
        vFsYv345Wa18uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb states of ohci controller include UsbOperational, UsbReset,
UsbSuspend and UsbResume. Among them, only the UsbOperational state
supports launching the start-of-frame for host controller according
the ohci protocol spec, but in S3 and S4 (suspend to memory/suspend
to disk) press test procedure, it may happen that the start-of-
frame was launched in UsbSuspend status and cause ohci works failed
that the phenomenon was hc will allways reproduce the SoF interrupt
and consider that hc doesn't deal with the ed/td/done list in non-
UsbOperational, and this patch was to disable SoF interrupt in ohci
_rh_suspend so that it can fix ohci SoF abnormally interrupt issue.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v5:
		Move the key code change into ohci_rh_suspend.
		Rework the commit log information.


 drivers/usb/host/ohci-hub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index f474f2f..80a0094 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -88,6 +88,8 @@ static int ohci_rh_suspend (struct ohci_hcd *ohci, int autostop)
 		msleep (8);
 		spin_lock_irq (&ohci->lock);
 	}
+	/* All ED unlinks should be finished, no need for SOF interrupts */
+	ohci_writel(ohci, OHCI_INTR_SF, &ohci->regs->intrdisable);
 	update_done_list(ohci);
 	ohci_work(ohci);
 
-- 
1.8.3.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153A442B3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbhJMDe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:34:27 -0400
Received: from mail.loongson.cn ([114.242.206.163]:37160 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234170AbhJMDe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:34:26 -0400
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxD2s6U2Zhew0ZAA--.23799S2;
        Wed, 13 Oct 2021 11:32:14 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Cc:     zhuyinbo@loongson.cn
Subject: [PATCH v6] usb: ohci: disable start-of-frame interrupt in ohci_rh_suspend
Date:   Wed, 13 Oct 2021 11:32:08 +0800
Message-Id: <1634095928-29639-1-git-send-email-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9DxD2s6U2Zhew0ZAA--.23799S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4DXrykKFWDZrWfGryUJrb_yoW8GFWfpF
        W5Ar42yrs8Ka1Yv3WUKF4xuw4Fkwn8GrW7Ca97Kw1UW39Iqw1rXry7tFW5KF9rWryfKw4j
        qF4Fka45Wa4UCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While going into S3 or S4 suspend, an OHCI host controller can
generate interrupt requests if the INTR_SF enable flag is set.  The
interrupt handler routine isn't prepared for this and it doesn't turn
off the flag, causing an interrupt storm.

To fix this problem, make ohci_rh_suspend() always disable INTR_SF
interrupts after processing the done list and the ED unlinks but
before the controller goes into the suspended (non-UsbOperational)
state.  There's no reason to leave the flag enabled, since a
suspended controller doesn't generate Start-of-Frame packets.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v6:
		1. Rework the commit log information.
		2. Move the key change code after ohci_work in 
		   ohci_rh_suspend.


 drivers/usb/host/ohci-hub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index f474f2f..90cee19 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -91,6 +91,9 @@ static int ohci_rh_suspend (struct ohci_hcd *ohci, int autostop)
 	update_done_list(ohci);
 	ohci_work(ohci);
 
+	/* All ED unlinks should be finished, no need for SOF interrupts */
+	ohci_writel(ohci, OHCI_INTR_SF, &ohci->regs->intrdisable);
+
 	/*
 	 * Some controllers don't handle "global" suspend properly if
 	 * there are unsuspended ports.  For these controllers, put all
-- 
1.8.3.1


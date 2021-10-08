Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF292426536
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhJHH2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:28:22 -0400
Received: from mail.loongson.cn ([114.242.206.163]:34422 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232645AbhJHH2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:28:20 -0400
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx72mV8l9h8nEWAA--.20277S2;
        Fri, 08 Oct 2021 15:26:19 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Cc:     zhuyinbo@loongson.cn
Subject: [PATCH v3] usb: ohci: add check for host controller functional states
Date:   Fri,  8 Oct 2021 15:26:10 +0800
Message-Id: <1633677970-10619-1-git-send-email-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9Dx72mV8l9h8nEWAA--.20277S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWxCFWrGF4fWrWrZF45Awb_yoW8ur43pF
        4avw1Yyr98Jw40qry7Jrs7Ja4rKan7trW7W3s2k343Xrsxtw1DKFyvkFWFq3Z5XrW2qw42
        9F18tryUWa17CaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
        CI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb states of ohci controller include UsbOperational, UsbReset,
UsbSuspend and UsbResume. Among them, only the UsbOperational state
supports launching the start of frame for host controller according
the ohci protocol spec, but in S3/S4 press test procedure, it may
happen that the start of frame was launched in other usb states and
cause ohci works abnormally then kernel will allways report rcu
call trace. This patch was to add check for host controller
functional states and if it is not UsbOperational state that need
set INTR_SF in intrdisable register to ensure SOF Token generation
was been disabled.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v3:
		Rework the commit information.
		Move the patch code change to lower down position in ohci_irq.


 drivers/usb/host/ohci-hcd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 1f5e693..87aa9bb 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -879,7 +879,8 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 	struct ohci_regs __iomem *regs = ohci->regs;
-	int			ints;
+	int			ints, ctl;
+
 
 	/* Read interrupt status (and flush pending writes).  We ignore the
 	 * optimization of checking the LSB of hcca->done_head; it doesn't
@@ -969,9 +970,15 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	 * when there's still unlinking to be done (next frame).
 	 */
 	ohci_work(ohci);
-	if ((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
-			&& ohci->rh_state == OHCI_RH_RUNNING)
+
+	ctl = ohci_readl(ohci, &regs->control);
+
+	if (((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
+			&& ohci->rh_state == OHCI_RH_RUNNING) ||
+			((ctl & OHCI_CTRL_HCFS) != OHCI_USB_OPER)) {
 		ohci_writel (ohci, OHCI_INTR_SF, &regs->intrdisable);
+		(void)ohci_readl(ohci, &regs->intrdisable);
+	}
 
 	if (ohci->rh_state == OHCI_RH_RUNNING) {
 		ohci_writel (ohci, ints, &regs->intrstatus);
-- 
1.8.3.1


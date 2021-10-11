Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6919B428D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhJKNFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:05:19 -0400
Received: from mail.loongson.cn ([114.242.206.163]:60866 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232277AbhJKNFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:05:16 -0400
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj2oENmRh6SAYAA--.22131S2;
        Mon, 11 Oct 2021 21:03:05 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Cc:     zhuyinbo@loongson.cn
Subject: [PATCH v4] usb: ohci: add check for host controller functional states
Date:   Mon, 11 Oct 2021 21:02:58 +0800
Message-Id: <1633957378-39631-1-git-send-email-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9Dxj2oENmRh6SAYAA--.22131S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWxCFWrGF4fWryxtw1UWrg_yoW8tF4fpF
        4akw1YkrnxJr40vryUGrs7Ja4rKw4xtFW7Was2k3y7Zrsxtw1kKFyIkFWFqFn5XrZFq3W2
        vF18trW5Wa1fCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb states of ohci controller include UsbOperational, UsbReset,
UsbSuspend and UsbResume. Among them, only the UsbOperational state
supports launching the start of frame for host controller according
the ohci protocol spec, but in S3 and S4 (suspend to memory/suspend
to disk) press test procedure, it may happen that the start of
frame was launched in other usb states and cause ohci works failed,
that the phenomenon was hc will allways reproduce the SoF interrupt
and consider that hc doesn't deal with the ed/td/done list in non-
UsbOperational, and this patch was to add check for host controller
functional states and if it is not UsbOperational state that need
set INTR_SF in intrdisable register to ensure SOF Token generation
was been disabled so that it can fix ohci SoF abnormally interrupt.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v4:
		Rework the commit log information.
		Remove the extra unnecessary blank line. 


 drivers/usb/host/ohci-hcd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 1f5e693..4fd59fa 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -879,7 +879,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 	struct ohci_regs __iomem *regs = ohci->regs;
-	int			ints;
+	int			ints, ctl;
 
 	/* Read interrupt status (and flush pending writes).  We ignore the
 	 * optimization of checking the LSB of hcca->done_head; it doesn't
@@ -969,9 +969,14 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	 * when there's still unlinking to be done (next frame).
 	 */
 	ohci_work(ohci);
-	if ((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
-			&& ohci->rh_state == OHCI_RH_RUNNING)
+
+	ctl = ohci_readl(ohci, &regs->control);
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


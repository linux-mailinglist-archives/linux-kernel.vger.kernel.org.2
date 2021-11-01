Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8844140F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 08:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhKAHT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 03:19:58 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57112 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229622AbhKAHT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 03:19:57 -0400
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX2pzlH9hp4QjAA--.39563S2;
        Mon, 01 Nov 2021 15:17:12 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhuyinbo@loongson.cn
Subject: [PATCH v1] usb: xhci: add LPM quirk for ensuring uPD720201 into D3 state after S5
Date:   Mon,  1 Nov 2021 15:17:05 +0800
Message-Id: <1635751025-25906-1-git-send-email-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9DxX2pzlH9hp4QjAA--.39563S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1fuF15Cw4UtFyUGF17ZFb_yoW8Zr15pF
        4rWayUurs5Kr4IqryDAF1v9as5G3ZFkFyUKry7C3yqgrZ8trZ5GFyUGFW3GrZ3W395Jw1a
        qF1kW3y5WFW7GaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUozVbDUUUU
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After S5, any pci device should into D3 state that if supported, but the
uPD720201 was not and it may be the cause of xhci firmware and cause
OSPM power consumption is more higher that S5 than S4. I think xhci HCD
can add a quirk ensure it into D3 state after S5 that is appropriate
and this patch was to add LPM quirk and set PCI_D3hot to uPD720201 pmsc
register in xhci_pci_shutdown to fix xhci power consumption issue.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 drivers/usb/host/xhci.h     | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2c9f25c..f97bb64 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -265,6 +265,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	    pdev->device == 0x0014) {
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 		xhci->quirks |= XHCI_ZERO_64B_REGS;
+		xhci->quirks |= XHCI_LPM_QUIRK;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0015) {
@@ -608,7 +609,8 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
 	xhci_shutdown(hcd);
 
 	/* Yet another workaround for spurious wakeups at shutdown with HSW */
-	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
+	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP ||
+			xhci->quirks & XHCI_LPM_QUIRK)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
 #endif /* CONFIG_PM */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index dca6181..5f790202 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1899,6 +1899,7 @@ struct xhci_hcd {
 #define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
 #define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
 #define XHCI_BROKEN_D3COLD	BIT_ULL(41)
+#define XHCI_LPM_QUIRK		BIT_ULL(42)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
1.8.3.1


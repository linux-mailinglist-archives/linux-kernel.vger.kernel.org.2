Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7DF443DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhKCH7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:59:14 -0400
Received: from mail.loongson.cn ([114.242.206.163]:50384 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229504AbhKCH7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:59:12 -0400
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj2qsQIJhzaMkAA--.40857S2;
        Wed, 03 Nov 2021 15:56:33 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhuyinbo@loongson.cn
Subject: [PATCH v2] usb: xhci: add LWP quirk for ensuring uPD720201 into D3 state after S5
Date:   Wed,  3 Nov 2021 15:56:26 +0800
Message-Id: <1635926186-17743-1-git-send-email-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9Dxj2qsQIJhzaMkAA--.40857S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1kJw4kGF4DKr1UCrWruFg_yoW8tr4DpF
        s8Wa4a9rZ8Kr4Iqr98Ar1I9as3G3ZrCFyUKry7C3yqgrZ8trWrGa4UGFW3CrZ3W395J3Wa
        gF4vg345WFW7XaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After S5, any pci device should into D3 state that if supported, but the
uPD720201 was not and cause OSPM power consumption is more higher that
S5 than S4. Due to that uPD720201 firmware behavior was unknown and the
_PS3 method wasn't implemented in ACPI table which can make device into
D3, I think xhci HCD can add a quirk ensure it into D3 state after S5
that is appropriate and this patch was to add the XHCI_LWP_QURIK and set
PCI_D3hot to uPD720201 pmsc register in xhci_pci_shutdown to fix xhci
power consumption issue.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v2:
		1. Rework the commit information to explain the issue 
		   reason.
		2. Change the qurik name that replace XHCI_LPM_QUIRK 
		   with XHCI_LWP_QUIRK.


 drivers/usb/host/xhci-pci.c | 4 +++-
 drivers/usb/host/xhci.h     | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2c9f25c..9f3f7f9 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -265,6 +265,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	    pdev->device == 0x0014) {
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 		xhci->quirks |= XHCI_ZERO_64B_REGS;
+		xhci->quirks |= XHCI_LWP_QUIRK;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0015) {
@@ -608,7 +609,8 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
 	xhci_shutdown(hcd);
 
 	/* Yet another workaround for spurious wakeups at shutdown with HSW */
-	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
+	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP ||
+			xhci->quirks & XHCI_LWP_QUIRK)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
 #endif /* CONFIG_PM */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index dca6181..bcd70d1 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1899,6 +1899,7 @@ struct xhci_hcd {
 #define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
 #define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
 #define XHCI_BROKEN_D3COLD	BIT_ULL(41)
+#define XHCI_LWP_QUIRK		BIT_ULL(42)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
1.8.3.1


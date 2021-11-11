Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5B244D1F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 07:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhKKGbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 01:31:44 -0500
Received: from mail.loongson.cn ([114.242.206.163]:36286 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229533AbhKKGbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 01:31:42 -0500
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxidEauIxh2SgCAA--.5061S2;
        Thu, 11 Nov 2021 14:28:48 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhuyinbo@loongson.cn
Subject: [PATCH v3] usb: xhci: add LWP quirk for ensuring uPD720201 into D3 state after S5
Date:   Thu, 11 Nov 2021 14:28:38 +0800
Message-Id: <1636612118-32481-1-git-send-email-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9CxidEauIxh2SgCAA--.5061S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1kJw4kGF4DKr1UCrWruFg_yoW5JrWfpF
        s8Xaya9rs5Kr4Iqr93Ar18Zas5G3ZrZryUKryIk3yqgrWjyrs5KFyUGFW3Ar9xWaykJr1a
        9F1vgw15WFW7GaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
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
PCI_D3hot to uPD720201 pmsc register in xhci_pci_shutdown and
xhci_pci_remove to fix xhci power consumption issue.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v3:
		Add D3 set in xhci_pci_remove function.

 drivers/usb/host/xhci-pci.c | 9 +++++++++
 drivers/usb/host/xhci.h     | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2c9f25c..6258a5a 100644
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
@@ -466,6 +467,10 @@ static void xhci_pci_remove(struct pci_dev *dev)
 		pci_set_power_state(dev, PCI_D3hot);
 
 	usb_hcd_pci_remove(dev);
+
+	/* Workaround for decreasing power consumption after S5 */
+	if (xhci->quirks & XHCI_LWP_QUIRK)
+		pci_set_power_state(dev, PCI_D3hot);
 }
 
 #ifdef CONFIG_PM
@@ -610,6 +615,10 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
 	/* Yet another workaround for spurious wakeups at shutdown with HSW */
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
 		pci_set_power_state(pdev, PCI_D3hot);
+
+	/* Workaround for decreasing power consumption after S5 */
+	if (xhci->quirks & XHCI_LWP_QUIRK)
+		pci_set_power_state(pdev, PCI_D3hot);
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


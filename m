Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C79730EBCA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 06:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhBDFTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 00:19:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35631 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhBDFTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 00:19:50 -0500
Received: from [222.129.39.10] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <aaron.ma@canonical.com>)
        id 1l7X2k-0005uP-ES; Thu, 04 Feb 2021 05:19:03 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     aaron.ma@canonical.com, gregkh@linuxfoundation.org,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        lee.jones@linaro.org, peter.chen@nxp.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xhci-pci: Set AMD Renoir USB controller to D3 when shutdown
Date:   Thu,  4 Feb 2021 13:18:50 +0800
Message-Id: <20210204051850.64857-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD Renoir/Cezanne platforms, when set "Always on USB" to "On" in BIOS,
USB controller will consume more power than 0.03w.

Set it to D3cold when shutdown, S5 power consumption will be 0.03w lower.
The USB can charge other devices as before.
USB controller works fine after power on and reboot.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/usb/host/xhci-pci.c | 8 ++++++++
 drivers/usb/host/xhci.h     | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 84da8406d5b4..a31be1ba927f 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -62,6 +62,7 @@
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
+#define PCI_DEVICE_ID_AMD_RENOIR_USB31			0x1639
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
 #define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
@@ -171,6 +172,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+		pdev->device == PCI_DEVICE_ID_AMD_RENOIR_USB31)
+		xhci->quirks |= XHCI_SHUTDOWN_D3COLD;
+
 	if ((pdev->vendor == PCI_VENDOR_ID_AMD) &&
 		((pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4) ||
 		(pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_3) ||
@@ -594,6 +599,9 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
 	/* Yet another workaround for spurious wakeups at shutdown with HSW */
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
 		pci_set_power_state(pdev, PCI_D3hot);
+
+	if (xhci->quirks & XHCI_SHUTDOWN_D3COLD)
+		pci_set_power_state(pdev, PCI_D3cold);
 }
 #endif /* CONFIG_PM */
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 25e57bc9c3cc..0684193da4bd 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1883,6 +1883,7 @@ struct xhci_hcd {
 #define XHCI_SKIP_PHY_INIT	BIT_ULL(37)
 #define XHCI_DISABLE_SPARSE	BIT_ULL(38)
 #define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
+#define XHCI_SHUTDOWN_D3COLD	BIT_ULL(40)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.30.0


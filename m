Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57267355F84
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 01:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbhDFXeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 19:34:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:26459 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242772AbhDFXeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:34:08 -0400
IronPort-SDR: 64fO8ytzpSSGaVqbH1j7ZxWNqdgLkjoK3JHnBTf4BoKEg9j2XKhpV7VjwcEj8UjEvuQzpWu5vu
 Y4PHO6gAUx8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="257165710"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="257165710"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 16:33:58 -0700
IronPort-SDR: LXdnP9Ad+a9N8igloQZedJYsH3ZPLwv7yTfnojdMgV5ldRDhgH8X63cgB/mx8fF/3cy0wja1tW
 ahLt7Z+m4t6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="598129921"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2021 16:33:58 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     mathias.nyman@linux.intel.com, gregkh@linuxfoundation.org,
        p.zabel@pengutronix.de, linux-usb@vger.kernel.org
Cc:     mika.westerberg@linux.intel.com, abhijeet.rao@intel.com,
        nikunj.dadhania@intel.com, linux-kernel@vger.kernel.org,
        azhar.shaikh@intel.com
Subject: [PATCH] xhci-pci: Allow host runtime PM as default for Intel Alder Lake xHCI
Date:   Tue,  6 Apr 2021 16:35:29 -0700
Message-Id: <20210406233529.19543-1-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhijeet Rao <abhijeet.rao@intel.com>

In the same way as Intel Tiger Lake TCSS (Type-C Subsystem) the Alder Lake
TCSS xHCI needs to be runtime suspended whenever possible to allow the
TCSS hardware block to enter D3cold and thus save energy.

Signed-off-by: Abhijeet Rao <abhijeet.rao@intel.com>
Signed-off-by: Nikunj A. Dadhania <nikunj.dadhania@intel.com>
Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 5bbccc9a0179..a858add8436c 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -57,6 +57,7 @@
 #define PCI_DEVICE_ID_INTEL_CML_XHCI			0xa3af
 #define PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI		0x9a13
 #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
+#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI		0x461e
 
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
@@ -243,7 +244,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_TIGER_LAKE_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI))
+	     pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-- 
2.17.1


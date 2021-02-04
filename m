Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE49E30F510
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhBDOeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:34:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:58197 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236503AbhBDOTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:19:05 -0500
IronPort-SDR: hUpb46HXQQ8Gk+FlZO7PhCMVG/P1vJCe6NubodeqxTZGFyvFlgPJT/TuF6zakesP9uQb3B4f+s
 ZfdGgf6hoCOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160410025"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="160410025"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 06:17:18 -0800
IronPort-SDR: 6b6M6f2dibT7wAlXrbOBoJ5nyiOv6umLWdcRaoKfVZXMvdIe4Tjkwr9Hlenka1B+ycaEj9dEnf
 VVUKxdZ5eQEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="483254618"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2021 06:17:16 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Minas Harutyunyan <hminas@synopsys.com>
Subject: [PATCH v2 2/6] usb: dwc2: pci: Drop the empty quirk function
Date:   Thu,  4 Feb 2021 17:17:07 +0300
Message-Id: <20210204141711.53775-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
References: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dwc2_pci_quirks() does nothing. Removing.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Minas Harutyunyan <hminas@synopsys.com>
---
 drivers/usb/dwc2/pci.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/usb/dwc2/pci.c b/drivers/usb/dwc2/pci.c
index 7afc10872f1f0..0000151e3ca96 100644
--- a/drivers/usb/dwc2/pci.c
+++ b/drivers/usb/dwc2/pci.c
@@ -63,20 +63,6 @@ struct dwc2_pci_glue {
 	struct platform_device *phy;
 };
 
-static int dwc2_pci_quirks(struct pci_dev *pdev, struct platform_device *dwc2)
-{
-	if (pdev->vendor == PCI_VENDOR_ID_SYNOPSYS &&
-	    pdev->device == PCI_PRODUCT_ID_HAPS_HSOTG) {
-		struct property_entry properties[] = {
-			{ },
-		};
-
-		return platform_device_add_properties(dwc2, properties);
-	}
-
-	return 0;
-}
-
 /**
  * dwc2_pci_probe() - Provides the cleanup entry points for the DWC_otg PCI
  * driver
@@ -143,10 +129,6 @@ static int dwc2_pci_probe(struct pci_dev *pci,
 
 	dwc2->dev.parent = dev;
 
-	ret = dwc2_pci_quirks(pci, dwc2);
-	if (ret)
-		goto err;
-
 	glue = devm_kzalloc(dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
 		ret = -ENOMEM;
-- 
2.30.0


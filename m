Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36730BECC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhBBMwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:52:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:18029 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231871AbhBBMw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:52:28 -0500
IronPort-SDR: /wswufZ2c1E86tjlDoaYKyr86mf10L/1VVlD9oKDGqZeKgfSJuWqmQp8qVukF1EWYFjpKM5s42
 SrubWY/dg6mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180070661"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="180070661"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 04:50:40 -0800
IronPort-SDR: agwwjJf6t0BxqDb2VbgzURav+FfrROhLcSIy6nswAi2QwtP62RqJIhnV0uIzHw50ruplkL2Wew
 y3XByFX9NYDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="479741030"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2021 04:50:37 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Minas Harutyunyan <hminas@synopsys.com>
Subject: [PATCH 2/6] usb: dwc2: pci: Drop the empty quirk function
Date:   Tue,  2 Feb 2021 15:50:28 +0300
Message-Id: <20210202125032.64982-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
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


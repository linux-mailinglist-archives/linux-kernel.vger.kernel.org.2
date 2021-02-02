Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697F830BED1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhBBMxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:53:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:18020 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhBBMxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:53:42 -0500
IronPort-SDR: XSPcDy+VFKmjoVfF4hmNjDn8Q1ZyUXwHKqGcw+pPq1xAm2jMnGW6WvFl1dmeDFllDzNdbk0FE0
 3m8aI9aOk6UQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180070665"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="180070665"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 04:50:42 -0800
IronPort-SDR: 4C25tBqAZLmxJskvaOnYxprVRBMu06DXhiX1RIG9KjYQXMWYvz/uah29/LE84XffqDjQf8jJ8v
 ow/G/KYLR0iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="479741040"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2021 04:50:40 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 3/6] usb: dwc3: haps: Constify the software node
Date:   Tue,  2 Feb 2021 15:50:29 +0300
Message-Id: <20210202125032.64982-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What platform_device_add_properties() does is it allocates
dynamically a software node that will contain the device
properties supplied to it, and then couples that node with
the device. Since that node is always created, it might as
well be constant.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-haps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-haps.c b/drivers/usb/dwc3/dwc3-haps.c
index 55b4a901168e8..a0f046855a233 100644
--- a/drivers/usb/dwc3/dwc3-haps.c
+++ b/drivers/usb/dwc3/dwc3-haps.c
@@ -33,6 +33,10 @@ static const struct property_entry initial_properties[] = {
 	{ },
 };
 
+static const struct software_node dwc3_haps_swnode = {
+	.properties = initial_properties,
+};
+
 static int dwc3_haps_probe(struct pci_dev *pci,
 			   const struct pci_device_id *id)
 {
@@ -77,7 +81,7 @@ static int dwc3_haps_probe(struct pci_dev *pci,
 	dwc->pci = pci;
 	dwc->dwc3->dev.parent = dev;
 
-	ret = platform_device_add_properties(dwc->dwc3, initial_properties);
+	ret = device_add_software_node(&dwc->dwc3->dev, dwc3_haps_swnode);
 	if (ret)
 		goto err;
 
@@ -91,6 +95,7 @@ static int dwc3_haps_probe(struct pci_dev *pci,
 
 	return 0;
 err:
+	device_remove_software_node(&dwc->dwc3->dev);
 	platform_device_put(dwc->dwc3);
 	return ret;
 }
@@ -99,6 +104,7 @@ static void dwc3_haps_remove(struct pci_dev *pci)
 {
 	struct dwc3_haps *dwc = pci_get_drvdata(pci);
 
+	device_remove_software_node(&dwc->dwc3->dev);
 	platform_device_unregister(dwc->dwc3);
 }
 
-- 
2.30.0


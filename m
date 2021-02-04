Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C9230F4D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhBDOVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:21:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:58183 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236541AbhBDOUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:20:36 -0500
IronPort-SDR: WUA5WBzdYJDNJFKV02UR2m6s8b6hvjbVjw9iIYjaX0/Jewsa4CJ5GItw951qYCxugH2ll6VDKP
 Efc+HWJfx+VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160410033"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="160410033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 06:17:21 -0800
IronPort-SDR: 20PnZ1QU9rRWt9o6zjlZPxy3eeKvzTTwj60c1HUnIINbmtRAre1cshHfUOTQU/U2WU2vxiLOQG
 L+IBIYzZW+Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="483254624"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2021 06:17:18 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 3/6] usb: dwc3: haps: Constify the software node
Date:   Thu,  4 Feb 2021 17:17:08 +0300
Message-Id: <20210204141711.53775-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
References: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
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
index 55b4a901168e8..f6e3817fa7af0 100644
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
+	ret = device_add_software_node(&dwc->dwc3->dev, &dwc3_haps_swnode);
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


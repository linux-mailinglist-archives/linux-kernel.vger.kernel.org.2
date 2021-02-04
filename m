Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CCE30F4DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhBDOXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:23:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:58183 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236678AbhBDOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:22:00 -0500
IronPort-SDR: ROWpQx2NDfP1pKgf4WBxwXEdyXCr/URNQ+Z992m6vzplAREUrTC1KRlvotu4A7MUduzLnbyqoC
 AAO/MzNeW6hA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160410070"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="160410070"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 06:17:27 -0800
IronPort-SDR: wbn8oW9ljhi3GNHscqDpHK/2X4DTPFc3AhM9TopNZT0zlR7XleMXKcYF83OnRKSPXkYDZbH+14
 XY3EYnowlEjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="483254647"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2021 06:17:25 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 6/6] xhci: ext-caps: Use software node API with the properties
Date:   Thu,  4 Feb 2021 17:17:11 +0300
Message-Id: <20210204141711.53775-7-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
References: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces the platform_device_add_properties() call with
the safer device_create_managed_software_node() that does
exactly the same, but can also guarantee that the lifetime
of the node that is created for the device is tied to the
lifetime of device itself.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/host/xhci-ext-caps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ext-caps.c b/drivers/usb/host/xhci-ext-caps.c
index 3351d07c431f1..7a4c2c4ad50e8 100644
--- a/drivers/usb/host/xhci-ext-caps.c
+++ b/drivers/usb/host/xhci-ext-caps.c
@@ -54,7 +54,8 @@ static int xhci_create_intel_xhci_sw_pdev(struct xhci_hcd *xhci, u32 cap_offset)
 	}
 
 	if (pci->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI) {
-		ret = platform_device_add_properties(pdev, role_switch_props);
+		ret = device_create_managed_software_node(&pdev->dev, role_switch_props,
+							  NULL);
 		if (ret) {
 			dev_err(dev, "failed to register device properties\n");
 			platform_device_put(pdev);
-- 
2.30.0


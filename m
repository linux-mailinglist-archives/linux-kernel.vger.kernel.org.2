Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF61830BED8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhBBMzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:55:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:18020 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhBBMzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:55:04 -0500
IronPort-SDR: SmiV3Ato3TEnSWhLuFBrbIo3ihCta/3CsGHmJIRH7fQVhsZrzDCuNuE67TESwzjPWiDN/5fOlW
 E/WVzD8U0cXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180070681"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="180070681"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 04:50:49 -0800
IronPort-SDR: mGQ99TRADPBJKpiD16D4D0VC5YbOwjnlFe1yUNcWUTJGmLb0Wg+P/8QezN5fD5k+5CU0Tm+s3Z
 7D08CJ86D3fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="479741082"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2021 04:50:47 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6/6] xhci: ext-caps: Use software node API with the properties
Date:   Tue,  2 Feb 2021 15:50:32 +0300
Message-Id: <20210202125032.64982-7-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
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
Cc: Hans de Goede <hdegoede@redhat.com>
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


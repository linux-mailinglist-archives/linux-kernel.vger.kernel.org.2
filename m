Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7403530F4D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhBDOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:21:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:58197 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236545AbhBDOUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:20:38 -0500
IronPort-SDR: oMr2BQ4GiffFp3tD82B8MF2LThK7gZ29p28w1K9XKwCGXpWXXyiJn9psQgjzekFDD2Rq1Zg60r
 lJlawmuwQ6NA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160410051"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="160410051"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 06:17:25 -0800
IronPort-SDR: 1oU18j337v1WVmIOAE2WNvfzpIT/G4aftdmIpYAds+5OUcbs7B8mE5iA+Hg2k7L5SJg7xUXX0F
 Gn5qESGBYbdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="483254639"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2021 06:17:23 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 5/6] usb: dwc3: host: Use software node API with the properties
Date:   Thu,  4 Feb 2021 17:17:10 +0300
Message-Id: <20210204141711.53775-6-heikki.krogerus@linux.intel.com>
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
---
 drivers/usb/dwc3/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index e195176580de1..f29a264635aa1 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -108,7 +108,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 		props[prop_idx++] = PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");
 
 	if (prop_idx) {
-		ret = platform_device_add_properties(xhci, props);
+		ret = device_create_managed_software_node(&xhci->dev, props, NULL);
 		if (ret) {
 			dev_err(dwc->dev, "failed to add properties to xHCI\n");
 			goto err;
-- 
2.30.0


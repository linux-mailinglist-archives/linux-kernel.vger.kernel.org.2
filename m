Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A06330F4D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbhBDOW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:22:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:58192 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236527AbhBDOUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:20:36 -0500
IronPort-SDR: CpAWxiDkv7AsBmkKjXLEt/8LsUErvqQE7FTbt5N03GEgvOilg/D+cDjneCAMV3w01uJpdDU8+r
 8G9b/3u2XvjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160410042"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="160410042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 06:17:23 -0800
IronPort-SDR: LR+cMIbx3SmKhSOf4nSNDThOetdVRbcRxUutbrGUBal39uMrfSyJsn4FYd4Bq6Lc8/BvIgFrm4
 dCdJvjAso7XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="483254635"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2021 06:17:21 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 4/6] usb: dwc3: qcom: Constify the software node
Date:   Thu,  4 Feb 2021 17:17:09 +0300
Message-Id: <20210204141711.53775-5-heikki.krogerus@linux.intel.com>
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
the device. If the properties are constant, the node can be
constant as well.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index d803ee98c628e..846a47be6df7f 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -567,6 +567,10 @@ static const struct property_entry dwc3_qcom_acpi_properties[] = {
 	{}
 };
 
+static const struct software_node dwc3_qcom_swnode = {
+	.properties = dwc3_qcom_acpi_properties,
+};
+
 static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 {
 	struct dwc3_qcom	*qcom = platform_get_drvdata(pdev);
@@ -613,16 +617,17 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 		goto out;
 	}
 
-	ret = platform_device_add_properties(qcom->dwc3,
-					     dwc3_qcom_acpi_properties);
+	ret = device_add_software_node(&qcom->dwc3->dev, &dwc3_qcom_swnode);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add properties\n");
 		goto out;
 	}
 
 	ret = platform_device_add(qcom->dwc3);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "failed to add device\n");
+		device_remove_software_node(&qcom->dwc3->dev);
+	}
 
 out:
 	kfree(child_res);
@@ -837,6 +842,7 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i;
 
+	device_remove_software_node(&qcom->dwc3->dev);
 	of_platform_depopulate(dev);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
-- 
2.30.0


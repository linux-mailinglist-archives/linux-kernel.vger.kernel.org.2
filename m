Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF530BED4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhBBMyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:54:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:18026 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231837AbhBBMxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:53:48 -0500
IronPort-SDR: 3BNRDMbW8RAdWlqEpL40uy5BgycRDlMxbhtFCinkUgZj/oqJia5uOSmlz/n3+S8u+CXKKoypah
 CbOc8c8B9gRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180070672"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="180070672"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 04:50:44 -0800
IronPort-SDR: mZQQ5GpJPX1pPXqnd9J1UPb4fM5//lPFCsG8eKuJ0SMvnsn9Cgf8jQ7KQ2BYD+LEPPEcBl14aP
 yXWrfTKd64yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="479741051"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2021 04:50:42 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 4/6] usb: dwc3: qcom: Constify the software node
Date:   Tue,  2 Feb 2021 15:50:30 +0300
Message-Id: <20210202125032.64982-5-heikki.krogerus@linux.intel.com>
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
the device. If the properties are constant, the node can be
constant as well.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index d803ee98c628e..d857d6c160a66 100644
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
+	ret = device_add_software_node(&qcom->dwc3->dev, dwc3_qcom_swnode);
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


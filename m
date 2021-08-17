Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77B3EEAED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbhHQKZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:25:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:56026 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239342AbhHQKZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:25:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="195621140"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="195621140"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 03:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="593304576"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2021 03:24:53 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/2] driver core: platform: Remove platform_device_add_properties()
Date:   Tue, 17 Aug 2021 13:24:49 +0300
Message-Id: <20210817102449.39994-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817102449.39994-1-heikki.krogerus@linux.intel.com>
References: <20210817102449.39994-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more users for it. The last place where it's
called is in platform_device_register_full(). Replacing that
call with device_create_managed_software_node() and
removing the function.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/platform.c         | 20 ++------------------
 include/linux/platform_device.h |  2 --
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index a94b7f4548814..652531f67135a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -641,22 +641,6 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
 }
 EXPORT_SYMBOL_GPL(platform_device_add_data);
 
-/**
- * platform_device_add_properties - add built-in properties to a platform device
- * @pdev: platform device to add properties to
- * @properties: null terminated array of properties to add
- *
- * The function will take deep copy of @properties and attach the copy to the
- * platform device. The memory associated with properties will be freed when the
- * platform device is released.
- */
-int platform_device_add_properties(struct platform_device *pdev,
-				   const struct property_entry *properties)
-{
-	return device_add_properties(&pdev->dev, properties);
-}
-EXPORT_SYMBOL_GPL(platform_device_add_properties);
-
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
@@ -842,8 +826,8 @@ struct platform_device *platform_device_register_full(
 		goto err;
 
 	if (pdevinfo->properties) {
-		ret = platform_device_add_properties(pdev,
-						     pdevinfo->properties);
+		ret = device_create_managed_software_node(&pdev->dev,
+							  pdevinfo->properties, NULL);
 		if (ret)
 			goto err;
 	}
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index ed42ea9f60ba0..7c96f169d2740 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -197,8 +197,6 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 					 unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
-extern int platform_device_add_properties(struct platform_device *pdev,
-				const struct property_entry *properties);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
-- 
2.30.2


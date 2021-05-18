Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E91338741E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347531AbhERIcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:32:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:41124 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241148AbhERIbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:31:49 -0400
IronPort-SDR: aDagRpaple8beuHbxUGZIyvY5I7oSaMcpZOZbs5Cy+S2D5+Sqa9zMlWFusnNn/ssCEmhOF2BFB
 VZ9x6X8eDOLQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221708585"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="221708585"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 01:30:31 -0700
IronPort-SDR: 6piu/YjU7f6RxMGkdWgWGtS/1nxLfhC/g2b6815UPDFp8rqeihhtLRZZxe5LJlMCh68l8xMaKC
 rwcrnNBpu8RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="541658168"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2021 01:30:29 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] driver core: platform: Remove platform_device_add_properties()
Date:   Tue, 18 May 2021 11:30:46 +0300
Message-Id: <20210518083046.23302-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
References: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more users for it. The last place where it's
called is in platform_device_register_full(). Replacing that
call with device_create_managed_software_node() and
removing the function.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/platform.c         | 20 ++------------------
 include/linux/platform_device.h |  2 --
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9cd34def2237b..0299b03e64d40 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -661,22 +661,6 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
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
@@ -862,8 +846,8 @@ struct platform_device *platform_device_register_full(
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
index cd81e060863c9..a05eb819f306a 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -200,8 +200,6 @@ extern int platform_device_add_resources(struct platform_device *pdev,
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


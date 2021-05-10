Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73483790C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbhEJO3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:29:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:20519 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236685AbhEJOYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:24:31 -0400
IronPort-SDR: afb4dz/cdVYJvnhVawPvzTniUtC7lB1o0jwyGupOW3RGH7o3roXtNkOsQTnjgcsWRLVZ+Saf48
 2TSOE9Zxt9QQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="197220479"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="197220479"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 07:15:49 -0700
IronPort-SDR: y0gnlzvLkU2Sn09RuC7N8tK0jLx2ySoYxENWfU+j+IvYGJPkHPISQBiWhgqnYIkqVO7NSy3V9k
 1iClotUxU11Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="541231883"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 May 2021 07:15:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BD10F142; Mon, 10 May 2021 17:16:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mfd: Remove software node conditionally and locate at right place
Date:   Mon, 10 May 2021 17:15:52 +0300
Message-Id: <20210510141552.57045-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the software node is removed in error case and at ->remove()
stage unconditionally, that ruins the symmetry. Besides, in some cases,
when mfd_add_device() fails, the device_remove_software_node() call
may lead to NULL pointer dereference:

  BUG: kernel NULL pointer dereference, address: 00000000
  ...
  EIP: strlen+0x12/0x20
  ...
  kernfs_name_hash+0x13/0x70
  kernfs_find_ns+0x32/0xc0
  kernfs_remove_by_name_ns+0x2a/0x90
  sysfs_remove_link+0x16/0x30
  software_node_notify.cold+0x34/0x6b
  device_remove_software_node+0x5a/0x90
  mfd_add_device.cold+0x30a/0x427

Fix all these by guarding device_remove_software_node() with a conditional
and locating it at the right place.

Fixes: 42e59982917a ("mfd: core: Add support for software nodes")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/mfd-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6f02b8022c6d..79f5c6a18815 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -266,18 +266,18 @@ static int mfd_add_device(struct device *parent, int id,
 			if (has_acpi_companion(&pdev->dev)) {
 				ret = acpi_check_resource_conflict(&res[r]);
 				if (ret)
-					goto fail_of_entry;
+					goto fail_res_conflict;
 			}
 		}
 	}
 
 	ret = platform_device_add_resources(pdev, res, cell->num_resources);
 	if (ret)
-		goto fail_of_entry;
+		goto fail_res_conflict;
 
 	ret = platform_device_add(pdev);
 	if (ret)
-		goto fail_of_entry;
+		goto fail_res_conflict;
 
 	if (cell->pm_runtime_no_callbacks)
 		pm_runtime_no_callbacks(&pdev->dev);
@@ -286,13 +286,15 @@ static int mfd_add_device(struct device *parent, int id,
 
 	return 0;
 
+fail_res_conflict:
+	if (cell->swnode)
+		device_remove_software_node(&pdev->dev);
 fail_of_entry:
 	list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
 		if (of_entry->dev == &pdev->dev) {
 			list_del(&of_entry->list);
 			kfree(of_entry);
 		}
-	device_remove_software_node(&pdev->dev);
 fail_alias:
 	regulator_bulk_unregister_supply_alias(&pdev->dev,
 					       cell->parent_supplies,
@@ -358,11 +360,12 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	if (level && cell->level > *level)
 		return 0;
 
+	if (cell->swnode)
+		device_remove_software_node(&pdev->dev);
+
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
-	device_remove_software_node(&pdev->dev);
-
 	platform_device_unregister(pdev);
 	return 0;
 }
-- 
2.30.2


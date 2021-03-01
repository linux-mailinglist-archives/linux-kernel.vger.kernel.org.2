Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447563280F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhCAOdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:33:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:37764 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234920AbhCAOde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:33:34 -0500
IronPort-SDR: WUqmjz2+7cmm8knymlwuk4Deq0YoC/9orH+2fvmMK6APDGBGWWMcSSk9hIrZAhMzLzOQ5b4CY7
 OUUw2Qf7ddvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="186593244"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="186593244"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 06:30:21 -0800
IronPort-SDR: +jUor3uHIrOHu7cNuKdrJNca23GWGp6ppK/BhRFVTpDQAkN4R4zCKOgK34mdWAgCaP7jB7iKE9
 UPjaSvC57ESQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="505086260"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2021 06:30:18 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] software node: Fix device_add_software_node()
Date:   Mon,  1 Mar 2021 17:30:12 +0300
Message-Id: <20210301143012.55118-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301143012.55118-1-heikki.krogerus@linux.intel.com>
References: <20210301143012.55118-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function device_add_software_node() was meant to
register the node supplied to it, but only if that node
wasn't already registered. Right now the function attempts
to always register the node. That will cause a failure with
nodes that are already registered.

Fixing that by incrementing the reference count of the nodes
that have already been registered, and only registering the
new nodes. Also, clarifying the behaviour in the function
documentation.

Fixes: e68d0119e328 ("software node: Introduce device_add_software_node()")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c    | 26 +++++++++++++++++---------
 include/linux/property.h |  2 +-
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 74db8c971db74..fa3719ef80e4d 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1005,25 +1005,33 @@ EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
 /**
  * device_add_software_node - Assign software node to a device
  * @dev: The device the software node is meant for.
- * @swnode: The software node.
+ * @node: The software node.
  *
- * This function will register @swnode and make it the secondary firmware node
- * pointer of @dev. If @dev has no primary node, then @swnode will become the primary
- * node.
+ * This function will make @node the secondary firmware node pointer of @dev. If
+ * @dev has no primary node, then @node will become the primary node. The
+ * function will register @node automatically if it wasn't already registered.
  */
-int device_add_software_node(struct device *dev, const struct software_node *swnode)
+int device_add_software_node(struct device *dev, const struct software_node *node)
 {
+	struct swnode *swnode;
 	int ret;
 
 	/* Only one software node per device. */
 	if (dev_to_swnode(dev))
 		return -EBUSY;
 
-	ret = software_node_register(swnode);
-	if (ret)
-		return ret;
+	swnode = software_node_to_swnode(node);
+	if (swnode) {
+		kobject_get(&swnode->kobj);
+	} else {
+		ret = software_node_register(node);
+		if (ret)
+			return ret;
+
+		swnode = software_node_to_swnode(node);
+	}
 
-	set_secondary_fwnode(dev, software_node_fwnode(swnode));
+	set_secondary_fwnode(dev, &swnode->fwnode);
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index dafccfce02624..dd4687b562393 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -488,7 +488,7 @@ fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent);
 void fwnode_remove_software_node(struct fwnode_handle *fwnode);
 
-int device_add_software_node(struct device *dev, const struct software_node *swnode);
+int device_add_software_node(struct device *dev, const struct software_node *node);
 void device_remove_software_node(struct device *dev);
 
 int device_create_managed_software_node(struct device *dev,
-- 
2.30.1


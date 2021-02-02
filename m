Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC530BEC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhBBMwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:52:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:18026 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232133AbhBBMwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:52:25 -0500
IronPort-SDR: QPhL7bdh7xTS6EpN2Eee8a8LK9mi0z2MuqLGyr3qA1AjDGXtvvZJ7CwpLMziy8Ap63Pm6tJrC6
 V+XLNuyDCk1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180070656"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="180070656"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 04:50:37 -0800
IronPort-SDR: mT6eI8bgTqiEvwycKBdfQdtywqNAynLF8MMx1xmJt++Di4/U3y1pQH3yl5eV1LbsxD2n8YW48R
 /uVwKnQBPwsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="479741013"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2021 04:50:35 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 1/6] software node: Provide replacement for device_add_properties()
Date:   Tue,  2 Feb 2021 15:50:27 +0300
Message-Id: <20210202125032.64982-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding function device_create_managed_software_node() that
is designed to work as a drop-in replacement for
device_add_properties(). The function has one additional
feature compared to device_add_properties(). It takes also
an optional parent node as parameter, and that way allow the
nodes created with it to be part of a node hierarchy.

The lifetime of the software nodes created with this
function will be tied to the device they are assigned to.
The function will therefore behave exactly the same way as
device_add_properties() is expected to behave, except that
it does not simply assume that the nodes attached to the
device are always destroyed in device_del() unconditionally.

The nodes created with this function are guaranteed to be
removed when the device is removed even after device_del()
stops calling device_remove_properties() unconditionally.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c    | 43 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  4 ++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 20faa9f4f5ed2..37179a8b1ceba 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -24,6 +24,7 @@ struct swnode {
 	struct swnode *parent;
 
 	unsigned int allocated:1;
+	unsigned int managed:1;
 };
 
 static DEFINE_IDA(swnode_root_ids);
@@ -1045,6 +1046,43 @@ void device_remove_software_node(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_remove_software_node);
 
+/**
+ * device_create_managed_software_node - Create a software node for a device
+ * @dev: The device the software node is assigned to.
+ * @properties: Device properties for the software node.
+ * @parent: Parent of the software node.
+ *
+ * Creates a software node as a managed resource for @dev, which means the
+ * lifetime of the newly created software node is tied to the lifetime of @dev.
+ * Software nodes created with this function should not be reused or shared
+ * because of that. The function takes a deep copy of @properties for the
+ * software node.
+ *
+ * Since the new software node is assigned directly to @dev, and since it should
+ * not be shared, it is not returned to the caller. The function returns 0 on
+ * success, and errno in case of an error.
+ */
+int device_create_managed_software_node(struct device *dev,
+					const struct property_entry *properties,
+					const struct software_node *parent)
+{
+	struct fwnode_handle *p = software_node_fwnode(parent);
+	struct fwnode_handle *fwnode;
+
+	if (parent && !p)
+		return -EINVAL;
+
+	fwnode = fwnode_create_software_node(properties, p);
+	if (IS_ERR(fwnode))
+		return PTR_ERR(fwnode);
+
+	to_swnode(fwnode)->managed = true;
+	set_secondary_fwnode(dev, fwnode);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_create_managed_software_node);
+
 int software_node_notify(struct device *dev, unsigned long action)
 {
 	struct swnode *swnode;
@@ -1073,6 +1111,11 @@ int software_node_notify(struct device *dev, unsigned long action)
 		sysfs_remove_link(&swnode->kobj, dev_name(dev));
 		sysfs_remove_link(&dev->kobj, "software_node");
 		kobject_put(&swnode->kobj);
+
+		if (swnode->managed) {
+			set_secondary_fwnode(dev, NULL);
+			kobject_put(&swnode->kobj);
+		}
 		break;
 	default:
 		break;
diff --git a/include/linux/property.h b/include/linux/property.h
index b0e413dc59271..dafccfce02624 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -491,4 +491,8 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode);
 int device_add_software_node(struct device *dev, const struct software_node *swnode);
 void device_remove_software_node(struct device *dev);
 
+int device_create_managed_software_node(struct device *dev,
+					const struct property_entry *properties,
+					const struct software_node *parent);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.30.0


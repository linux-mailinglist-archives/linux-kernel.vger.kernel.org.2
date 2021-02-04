Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3430F51C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhBDOfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:35:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:58192 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236325AbhBDOTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:19:03 -0500
IronPort-SDR: cfwwAo2DB4TAIOk7dlxkHe2bUND38S+alK4PFmJfLZTyYKapoql0lHK9bY57DrFTu9+UBiM0ij
 PV8O6uCqeYLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160410019"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="160410019"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 06:17:16 -0800
IronPort-SDR: FBT2e1cjyNUYtzsMdvbXqjXXDbVdJwDTEYfDHzvFnIpLlMsSKEGXf3oPffZRPGNRUb92y755oJ
 Eds9lUBiK60Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="483254611"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2021 06:17:14 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 1/6] software node: Provide replacement for device_add_properties()
Date:   Thu,  4 Feb 2021 17:17:06 +0300
Message-Id: <20210204141711.53775-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
References: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment the function device_del() is calling
device_remove_properties() unconditionally. That will result into the
reference count of the software node attached to the device being
decremented, and in most cases it will hit 0 at that point. So in
practice device_del() will unregister the software node attached to
the device, even if that was not the intention of the caller. Right
now software nodes can not be reused or shared because of that.

So device_del() can not unregister the software nodes unconditionally
like that. Unfortunately some of the users of device_add_properties()
are now relying on this behaviour. Because of that, and also in
general, we do need a function that can offer similar behaviour where
the lifetime of the software node is bound to the lifetime of the
device. But it just has to be a separate function so the behaviour is
optional. We can not remove the device_remove_properties() call from
device_del() before we have that new function, and before we have
replaced device_add_properties() calls with it in all the places that
require that behaviour.

This adds function device_create_managed_software_node() that can be
used for exactly that purpose. Software nodes created with it are
declared "managed", and separate handling for those nodes is added to
the software node code. The reference count of the "managed" nodes is
decremented when the device they are attached to is removed. This will
not affect the other nodes that are not declared "managed".

The function device_create_managed_software_node() has also one
additional feature that device_add_properties() does not have. It
allows the software nodes created with it to be part of a node
hierarchy by taking also an optional parent node as parameter.

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


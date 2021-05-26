Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99AD391C21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhEZPhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:37:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:51469 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234852AbhEZPhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:37:01 -0400
IronPort-SDR: HJKl7PoR5y7qOJytdMdlYqnrck0s75meipeoQAEV/eLxju8Wfawnl3ad3WLbCM6Nrp7IQ9qeMR
 2MugW8Td8xew==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202529815"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="202529815"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 08:35:30 -0700
IronPort-SDR: oO2GQ9yPctkIvvif0jZXdw3qSDJf4iBqKYNCQlcPC59U+0TXWf1bFe7XPsasjVHR+AsGD8bmix
 a6xV2sNeU46A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="547236498"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2021 08:35:28 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: typec: mux: Use device type instead of device name for matching
Date:   Wed, 26 May 2021 18:35:47 +0300
Message-Id: <20210526153548.61276-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
References: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the USB Type-C switch and mux have already a device
type defined for them. We can use those types instead of the
device name to differentiate the two.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux.c | 26 ++++++++++----------------
 drivers/usb/typec/mux.h |  6 ++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 8514bec7e1b89..e40a555724fb6 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -17,21 +17,12 @@
 #include "class.h"
 #include "mux.h"
 
-static bool dev_name_ends_with(struct device *dev, const char *suffix)
-{
-	const char *name = dev_name(dev);
-	const int name_len = strlen(name);
-	const int suffix_len = strlen(suffix);
-
-	if (suffix_len > name_len)
-		return false;
-
-	return strcmp(name + (name_len - suffix_len), suffix) == 0;
-}
-
 static int switch_fwnode_match(struct device *dev, const void *fwnode)
 {
-	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-switch");
+	if (!is_typec_switch(dev))
+		return 0;
+
+	return dev_fwnode(dev) == fwnode;
 }
 
 static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
@@ -90,7 +81,7 @@ static void typec_switch_release(struct device *dev)
 	kfree(to_typec_switch(dev));
 }
 
-static const struct device_type typec_switch_dev_type = {
+const struct device_type typec_switch_dev_type = {
 	.name = "orientation_switch",
 	.release = typec_switch_release,
 };
@@ -180,7 +171,10 @@ EXPORT_SYMBOL_GPL(typec_switch_get_drvdata);
 
 static int mux_fwnode_match(struct device *dev, const void *fwnode)
 {
-	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-mux");
+	if (!is_typec_mux(dev))
+		return 0;
+
+	return dev_fwnode(dev) == fwnode;
 }
 
 static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
@@ -295,7 +289,7 @@ static void typec_mux_release(struct device *dev)
 	kfree(to_typec_mux(dev));
 }
 
-static const struct device_type typec_mux_dev_type = {
+const struct device_type typec_mux_dev_type = {
 	.name = "mode_switch",
 	.release = typec_mux_release,
 };
diff --git a/drivers/usb/typec/mux.h b/drivers/usb/typec/mux.h
index 4fd9426ee44f6..b1d6e837cb747 100644
--- a/drivers/usb/typec/mux.h
+++ b/drivers/usb/typec/mux.h
@@ -18,4 +18,10 @@ struct typec_mux {
 #define to_typec_switch(_dev_) container_of(_dev_, struct typec_switch, dev)
 #define to_typec_mux(_dev_) container_of(_dev_, struct typec_mux, dev)
 
+extern const struct device_type typec_switch_dev_type;
+extern const struct device_type typec_mux_dev_type;
+
+#define is_typec_switch(dev) ((dev)->type == &typec_switch_dev_type)
+#define is_typec_mux(dev) ((dev)->type == &typec_mux_dev_type)
+
 #endif /* __USB_TYPEC_MUX__ */
-- 
2.30.2


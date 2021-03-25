Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C9B3491FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCYM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:29:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:31183 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhCYM3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:29:17 -0400
IronPort-SDR: Dh9KTA/JiU/1Ho2Hab2jMFY0wK2bM3QA9NkgXEYo+jnbmYVe5rAU2LLzrnM2F5rYkdGdAkOQky
 AMprIb1hJqCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170895469"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="170895469"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 05:29:16 -0700
IronPort-SDR: 6OI+OvfHk7PfST6ox6yNcRi865BX+HB5Thipi3E44tfKTp9tM0W+KRHZWBjHkkEQ757jz11d3/
 mKqQywrrW1Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="514623128"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2021 05:29:14 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] usb: Iterator for ports
Date:   Thu, 25 Mar 2021 15:29:21 +0300
Message-Id: <20210325122926.58392-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325122926.58392-1-heikki.krogerus@linux.intel.com>
References: <20210325122926.58392-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing usb_for_each_port(). It works the same way as
usb_for_each_dev(), but instead of going through every USB
device in the system, it walks through the USB ports in the
system.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/core/usb.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h    |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 2ce3667ec6fae..6d49db9a1b208 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -398,6 +398,49 @@ int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *))
 }
 EXPORT_SYMBOL_GPL(usb_for_each_dev);
 
+struct each_hub_arg {
+	void *data;
+	int (*fn)(struct device *, void *);
+};
+
+static int __each_hub(struct device *dev, void *data)
+{
+	struct each_hub_arg *arg = (struct each_hub_arg *)data;
+	struct usb_device *hdev = to_usb_device(dev);
+	struct usb_hub *hub;
+	int ret;
+	int i;
+
+	hub = usb_hub_to_struct_hub(hdev);
+	if (!hub)
+		return 0;
+
+	for (i = 0; i < hdev->maxchild; i++) {
+		ret = arg->fn(&hub->ports[i]->dev, arg->data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * usb_for_each_port - interate over all USB ports in the system
+ * @data: data pointer that will be handed to the callback function
+ * @fn: callback function to be called for each USB port
+ *
+ * Iterate over all USB ports and call @fn for each, passing it @data. If it
+ * returns anything other than 0, we break the iteration prematurely and return
+ * that value.
+ */
+int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
+{
+	struct each_hub_arg arg = {data, fn};
+
+	return bus_for_each_dev(&usb_bus_type, NULL, &arg, __each_hub);
+}
+EXPORT_SYMBOL_GPL(usb_for_each_port);
+
 /**
  * usb_release_dev - free a usb device structure when all users of it are finished.
  * @dev: device that's been disconnected
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 57c1e0ce5eba4..06ed5779fb4d8 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -869,6 +869,7 @@ extern int usb_match_one_id(struct usb_interface *interface,
 			    const struct usb_device_id *id);
 
 extern int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *));
+int usb_for_each_port(void *data, int (*fn)(struct device *, void *));
 extern struct usb_interface *usb_find_interface(struct usb_driver *drv,
 		int minor);
 extern struct usb_interface *usb_ifnum_to_if(const struct usb_device *dev,
-- 
2.30.2


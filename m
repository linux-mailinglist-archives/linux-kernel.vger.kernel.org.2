Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32135649B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349280AbhDGG4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:56:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:62003 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349256AbhDGGz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:55:56 -0400
IronPort-SDR: BXWKzLi6wVPuODPHAmK8DmlzrjSv+/9PWD+MuxQtlV3Lnk1UHPKSRQcji3NCSh24aIcbKy7HdR
 sHEAH9paki9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="180372039"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="180372039"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 23:55:47 -0700
IronPort-SDR: RthEMaSCYVrdGbfcWgaYJAXGaRgK5GjkE4nWwI7uOdDA1u2UFAAxHESQOxQt4fLm1dCBMvHAwE
 Ws3noakH186Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="519326279"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2021 23:55:45 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] usb: Iterator for ports
Date:   Wed,  7 Apr 2021 09:55:54 +0300
Message-Id: <20210407065555.88110-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407065555.88110-1-heikki.krogerus@linux.intel.com>
References: <20210407065555.88110-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing usb_for_each_port(). It works the same way as
usb_for_each_dev(), but instead of going through every USB
device in the system, it walks through the USB ports in the
system.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/core/usb.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h    |  9 +++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 2ce3667ec6fae..62368c4ed37af 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -398,6 +398,52 @@ int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *))
 }
 EXPORT_SYMBOL_GPL(usb_for_each_dev);
 
+struct each_hub_arg {
+	void *data;
+	int (*fn)(struct device *, void *);
+};
+
+static int __each_hub(struct usb_device *hdev, void *data)
+{
+	struct each_hub_arg *arg = (struct each_hub_arg *)data;
+	struct usb_hub *hub;
+	int ret = 0;
+	int i;
+
+	hub = usb_hub_to_struct_hub(hdev);
+	if (!hub)
+		return 0;
+
+	mutex_lock(&usb_port_peer_mutex);
+
+	for (i = 0; i < hdev->maxchild; i++) {
+		ret = arg->fn(&hub->ports[i]->dev, arg->data);
+		if (ret)
+			break;
+	}
+
+	mutex_unlock(&usb_port_peer_mutex);
+
+	return ret;
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
+	return usb_for_each_dev(&arg, __each_hub);
+}
+EXPORT_SYMBOL_GPL(usb_for_each_port);
+
 /**
  * usb_release_dev - free a usb device structure when all users of it are finished.
  * @dev: device that's been disconnected
diff --git a/include/linux/usb.h b/include/linux/usb.h
index ddd2f5b2a2827..eaae24217e8a2 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -882,6 +882,15 @@ extern struct usb_host_interface *usb_find_alt_setting(
 		unsigned int iface_num,
 		unsigned int alt_num);
 
+#if IS_REACHABLE(CONFIG_USB)
+int usb_for_each_port(void *data, int (*fn)(struct device *, void *));
+#else
+static inline int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
+{
+	return 0;
+}
+#endif
+
 /* port claiming functions */
 int usb_hub_claim_port(struct usb_device *hdev, unsigned port1,
 		struct usb_dev_state *owner);
-- 
2.30.2


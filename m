Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95DC34CCA8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhC2JFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:05:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:14122 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235107AbhC2Ioy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:44:54 -0400
IronPort-SDR: oVTMbVX/wJjjri8E5cCXGuCcH29tTyqExZLL9yy5Oh1RmgF9q9X1i559nL+FpEAUQPPgiuvyDv
 QJC0GBRkhMXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="252854860"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="252854860"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 01:44:27 -0700
IronPort-SDR: lKTOMNYnPjyWAefInZ4uNS4u7/4Lj/4XCl8WUwNytlsaGMCDAWrBq8y+Z3+Vl2EBMgPpLbJX2y
 T3pHBgsRl6ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="515918744"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2021 01:44:25 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] usb: Iterator for ports
Date:   Mon, 29 Mar 2021 11:44:25 +0300
Message-Id: <20210329084426.78138-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210329084426.78138-1-heikki.krogerus@linux.intel.com>
References: <20210329084426.78138-1-heikki.krogerus@linux.intel.com>
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
 drivers/usb/core/usb.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h    |  1 +
 2 files changed, 47 insertions(+)

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
index ddd2f5b2a2827..e4d2eb703cf89 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -871,6 +871,7 @@ extern int usb_match_one_id(struct usb_interface *interface,
 			    const struct usb_device_id *id);
 
 extern int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *));
+int usb_for_each_port(void *data, int (*fn)(struct device *, void *));
 extern struct usb_interface *usb_find_interface(struct usb_driver *drv,
 		int minor);
 extern struct usb_interface *usb_ifnum_to_if(const struct usb_device *dev,
-- 
2.30.2


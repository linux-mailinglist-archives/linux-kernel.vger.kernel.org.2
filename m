Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4535649C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349285AbhDGG4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:56:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:62003 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349235AbhDGGz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:55:58 -0400
IronPort-SDR: H5TtZ0hRCx2aklzeZ83miQR2vXuTqAAVGQdOOYPeQrjgmQuI3ou1A0+bJq1srLxPTgMo+5uiAQ
 ZMonmdvkejfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="180372050"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="180372050"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 23:55:49 -0700
IronPort-SDR: Lb4njW5mZfdxwJqJITaT9NBKECGI458dmiuiFOOpMzdGnUcknGJQ+1zh5PZ9J6+8OUqdZ5tIZn
 73cXyW92vr2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="519326286"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2021 23:55:47 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] usb: typec: Link all ports during connector registration
Date:   Wed,  7 Apr 2021 09:55:55 +0300
Message-Id: <20210407065555.88110-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407065555.88110-1-heikki.krogerus@linux.intel.com>
References: <20210407065555.88110-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The connectors may be registered after the ports, so the
"connector" links need to be created for the ports also when
ever a new connector gets registered.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c       |  9 +++--
 drivers/usb/typec/class.h       |  4 +--
 drivers/usb/typec/port-mapper.c | 62 +++++++++++++++++++++++++++++++--
 3 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index ff199e2d26c7b..f1c2d823c6509 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1601,7 +1601,6 @@ static void typec_release(struct device *dev)
 	ida_destroy(&port->mode_ids);
 	typec_switch_put(port->sw);
 	typec_mux_put(port->mux);
-	free_pld(port->pld);
 	kfree(port->cap);
 	kfree(port);
 }
@@ -2027,7 +2026,9 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
-	port->pld = get_pld(&port->dev);
+	ret = typec_link_ports(port);
+	if (ret)
+		dev_warn(&port->dev, "failed to create symlinks (%d)\n", ret);
 
 	return port;
 }
@@ -2041,8 +2042,10 @@ EXPORT_SYMBOL_GPL(typec_register_port);
  */
 void typec_unregister_port(struct typec_port *port)
 {
-	if (!IS_ERR_OR_NULL(port))
+	if (!IS_ERR_OR_NULL(port)) {
+		typec_unlink_ports(port);
 		device_unregister(&port->dev);
+	}
 }
 EXPORT_SYMBOL_GPL(typec_unregister_port);
 
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index 52294f7020a8b..aef03eb7e1523 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -79,7 +79,7 @@ extern const struct device_type typec_port_dev_type;
 extern struct class typec_mux_class;
 extern struct class typec_class;
 
-void *get_pld(struct device *dev);
-void free_pld(void *pld);
+int typec_link_ports(struct typec_port *connector);
+void typec_unlink_ports(struct typec_port *connector);
 
 #endif /* __USB_TYPEC_CLASS__ */
diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
index 5bee7a97242fe..fae736eb0601e 100644
--- a/drivers/usb/typec/port-mapper.c
+++ b/drivers/usb/typec/port-mapper.c
@@ -34,7 +34,7 @@ static int acpi_pld_match(const struct acpi_pld_info *pld1,
 	return 0;
 }
 
-void *get_pld(struct device *dev)
+static void *get_pld(struct device *dev)
 {
 #ifdef CONFIG_ACPI
 	struct acpi_pld_info *pld;
@@ -53,7 +53,7 @@ void *get_pld(struct device *dev)
 #endif
 }
 
-void free_pld(void *pld)
+static void free_pld(void *pld)
 {
 #ifdef CONFIG_ACPI
 	ACPI_FREE(pld);
@@ -217,3 +217,61 @@ void typec_unlink_port(struct device *port)
 	class_for_each_device(&typec_class, NULL, port, port_match_and_unlink);
 }
 EXPORT_SYMBOL_GPL(typec_unlink_port);
+
+static int each_port(struct device *port, void *connector)
+{
+	struct port_node *node;
+	int ret;
+
+	node = create_port_node(port);
+	if (IS_ERR(node))
+		return PTR_ERR(node);
+
+	if (!connector_match(connector, node)) {
+		remove_port_node(node);
+		return 0;
+	}
+
+	ret = link_port(to_typec_port(connector), node);
+	if (ret) {
+		remove_port_node(node->pld);
+		return ret;
+	}
+
+	get_device(connector);
+
+	return 0;
+}
+
+int typec_link_ports(struct typec_port *con)
+{
+	int ret = 0;
+
+	con->pld = get_pld(&con->dev);
+	if (!con->pld)
+		return 0;
+
+	ret = usb_for_each_port(&con->dev, each_port);
+	if (ret)
+		typec_unlink_ports(con);
+
+	return ret;
+}
+
+void typec_unlink_ports(struct typec_port *con)
+{
+	struct port_node *node;
+	struct port_node *tmp;
+
+	mutex_lock(&con->port_list_lock);
+
+	list_for_each_entry_safe(node, tmp, &con->port_list, list) {
+		__unlink_port(con, node);
+		remove_port_node(node);
+		put_device(&con->dev);
+	}
+
+	mutex_unlock(&con->port_list_lock);
+
+	free_pld(con->pld);
+}
-- 
2.30.2


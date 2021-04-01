Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC22350F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhDAGyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:54:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:28103 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233528AbhDAGxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:53:40 -0400
IronPort-SDR: z6Z7bYxtxnMya42adr7/FUGAGSeZGZAwGs/NCY/6upNcQe3SMWZvfWblTLUxo4Uy3GA6D5gvSw
 cb0szFVCIrRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="188910803"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="188910803"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 23:53:40 -0700
IronPort-SDR: /v4L83PC5PEmD+Z3jiNMaQGs1MLCfF5kWZHXciAaEkuSOe8Rcq5eJqKxCY/i2bDuAMeevik17p
 AJlB2b0Cxlww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517218665"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2021 23:53:38 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] usb: typec: Declare the typec_class static
Date:   Thu,  1 Apr 2021 09:53:43 +0300
Message-Id: <20210401065347.4010-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401065347.4010-1-heikki.krogerus@linux.intel.com>
References: <20210401065347.4010-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is only to make the handling of the class consistent
with the two other susbsystems - the alt mode bus and the
mux class.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 5fa279a96b6ef..d3e1002386357 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -17,7 +17,11 @@
 #include "class.h"
 
 static DEFINE_IDA(typec_index_ida);
-static struct class *typec_class;
+
+static struct class typec_class = {
+	.name = "typec",
+	.owner = THIS_MODULE,
+};
 
 /* ------------------------------------------------------------------------- */
 /* Common attributes */
@@ -551,7 +555,7 @@ typec_register_altmode(struct device *parent,
 
 	/* Plug alt modes need a class to generate udev events. */
 	if (is_typec_plug(parent))
-		alt->adev.dev.class = typec_class;
+		alt->adev.dev.class = &typec_class;
 
 	ret = device_register(&alt->adev.dev);
 	if (ret) {
@@ -815,7 +819,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 		partner->identity = desc->identity;
 	}
 
-	partner->dev.class = typec_class;
+	partner->dev.class = &typec_class;
 	partner->dev.parent = &port->dev;
 	partner->dev.type = &typec_partner_dev_type;
 	dev_set_name(&partner->dev, "%s-partner", dev_name(&port->dev));
@@ -967,7 +971,7 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
 	ida_init(&plug->mode_ids);
 	plug->num_altmodes = -1;
 	plug->index = desc->index;
-	plug->dev.class = typec_class;
+	plug->dev.class = &typec_class;
 	plug->dev.parent = &cable->dev;
 	plug->dev.type = &typec_plug_dev_type;
 	dev_set_name(&plug->dev, "%s-%s", dev_name(cable->dev.parent), name);
@@ -1132,7 +1136,7 @@ struct typec_cable *typec_register_cable(struct typec_port *port,
 		cable->identity = desc->identity;
 	}
 
-	cable->dev.class = typec_class;
+	cable->dev.class = &typec_class;
 	cable->dev.parent = &port->dev;
 	cable->dev.type = &typec_cable_dev_type;
 	dev_set_name(&cable->dev, "%s-cable", dev_name(&port->dev));
@@ -1986,7 +1990,7 @@ struct typec_port *typec_register_port(struct device *parent,
 	port->prefer_role = cap->prefer_role;
 
 	device_initialize(&port->dev);
-	port->dev.class = typec_class;
+	port->dev.class = &typec_class;
 	port->dev.parent = parent;
 	port->dev.fwnode = cap->fwnode;
 	port->dev.type = &typec_port_dev_type;
@@ -2049,11 +2053,9 @@ static int __init typec_init(void)
 	if (ret)
 		goto err_unregister_bus;
 
-	typec_class = class_create(THIS_MODULE, "typec");
-	if (IS_ERR(typec_class)) {
-		ret = PTR_ERR(typec_class);
+	ret = class_register(&typec_class);
+	if (ret)
 		goto err_unregister_mux_class;
-	}
 
 	return 0;
 
@@ -2069,7 +2071,7 @@ subsys_initcall(typec_init);
 
 static void __exit typec_exit(void)
 {
-	class_destroy(typec_class);
+	class_unregister(&typec_class);
 	ida_destroy(&typec_index_ida);
 	bus_unregister(&typec_bus);
 	class_unregister(&typec_mux_class);
-- 
2.30.2


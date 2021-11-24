Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7245D0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 00:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbhKXXQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 18:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345735AbhKXXQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:16:12 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC51C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:13:02 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y8so3107190plg.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9YGerqoefD7Kts4SrR1JKCEyJYREPcX0RCli6jZVLo=;
        b=P+HEnFYFrSgu9DmzxwoNZej8aaK4wtElTc2pfAd9getl1nTeIDH7k6Ujnf4Qe/lvtB
         3VWvSdLA20BLQFeEWByMUDt7OnfYIvwe7dAf2KIIOzns9utPUOUnoI1JIdJ8WjYqs7aL
         YhgftWcSZG028MVbmLvi98CcwXsDW981ndGJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9YGerqoefD7Kts4SrR1JKCEyJYREPcX0RCli6jZVLo=;
        b=kCLv4wV9YvuxgeoyMRdXUR4J6Erf1PxaeGBNoSRyHBtY/UdR5HB7vEPhMVc2G53/Ea
         GIdQqo2W2bH18yblOdxrBmCExIiuOBgNKwVhMskSMqjhfKvck/HwyrG/2jB7OSaKmZyS
         aMa/7gAHDFjSOocm7G83XDFo2osRaIN+jhdb8w5XCDhdhg4f2wE2kLrusNKBUxfe7gvq
         DUyfzqY3VXDGxXE+HCbWseOcLNRr1js93s93h235+lLNcilmJyzV2xvBw4qxniwvho/+
         i/r2BnMFQn76BzJrDmcV3jjeRd8PJS13FwQMk5efIzH/oA0nKTFDz10cu5+Law8RK//p
         loSA==
X-Gm-Message-State: AOAM531bSIeFTceyan2z46LCwv6TQLy3Vor26K320vdTF/x0dhvJaQ1F
        fmTCoY/kCAUKq/NgweqhY6eJatsB6S1HTw==
X-Google-Smtp-Source: ABdhPJzFiur+ikn5j3/xC2xNZcWgPnyRI4rHIn/Hp8HKsDF39OSVH7tnd5yZ91o7i2fK+BCHn+VC/Q==
X-Received: by 2002:a17:902:d4c2:b0:142:2039:e8e5 with SMTP id o2-20020a170902d4c200b001422039e8e5mr24031027plg.18.1637795581629;
        Wed, 24 Nov 2021 15:13:01 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:6bc9:896a:9df2:5d61])
        by smtp.gmail.com with ESMTPSA id nn15sm5783296pjb.11.2021.11.24.15.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 15:13:01 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     wonchung@google.com, bleung@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/4] usb: Use notifier to link Type C ports
Date:   Wed, 24 Nov 2021 15:10:10 -0800
Message-Id: <20211124231028.696982-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211124231028.696982-1-pmalani@chromium.org>
References: <20211124231028.696982-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a helper function to register pre-existing USB ports to
a new type C port, have each port register a notifier with the Type C
connector class, and use that to perform the linking when a new Type C
port is registered.

This avoid a cyclic dependency from a later change which is needed to
link a new USB port to a pre-existing Type C port. Some context on this
is in here [1]; in summary, typec_link_ports() introduces a dependency
from typec -> usbcore. However, commit 63cd78617350 ("usb: Link the
ports to the connectors they are attached to") then introduces a
dependency from usbcore -> typec. In order to allow that commit without
creating the cyclic dependency, we use a notifier here instead of
typec_link_ports().

Since we don't need the helper typec_link_ports() function anymore,
remove it and its related functions from port-mapper code.

[1]:
https://lore.kernel.org/all/20210412213655.3776e15e@canb.auug.org.au/

Cc: Benson Leung <bleung@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/usb/core/hub.h          |  3 +++
 drivers/usb/core/port.c         | 18 +++++++++++++++
 drivers/usb/typec/class.c       |  5 +---
 drivers/usb/typec/class.h       |  1 -
 drivers/usb/typec/port-mapper.c | 41 ---------------------------------
 5 files changed, 22 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 22ea1f4f2d66..d09a8c9c1b4e 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -11,6 +11,7 @@
  *  move struct usb_hub to this file.
  */
 
+#include <linux/notifier.h>
 #include <linux/usb.h>
 #include <linux/usb/ch11.h>
 #include <linux/usb/hcd.h>
@@ -89,6 +90,7 @@ struct usb_hub {
  * @is_superspeed cache super-speed status
  * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
  * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
+ * @typec_nb: notifier called when a Type C port is registered.
  */
 struct usb_port {
 	struct usb_device *child;
@@ -105,6 +107,7 @@ struct usb_port {
 	unsigned int is_superspeed:1;
 	unsigned int usb3_lpm_u1_permit:1;
 	unsigned int usb3_lpm_u2_permit:1;
+	struct notifier_block typec_nb;
 };
 
 #define to_usb_port(_dev) \
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index dfcca9c876c7..53a64ce76183 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -9,6 +9,7 @@
 
 #include <linux/slab.h>
 #include <linux/pm_qos.h>
+#include <linux/usb/typec.h>
 
 #include "hub.h"
 
@@ -528,6 +529,14 @@ static void find_and_link_peer(struct usb_hub *hub, int port1)
 		link_peers_report(port_dev, peer);
 }
 
+static int usb_port_link_typec_port(struct notifier_block *nb, unsigned long event, void *ptr)
+{
+	struct usb_port *port_dev = container_of(nb, struct usb_port, typec_nb);
+
+	typec_link_port(&port_dev->dev);
+	return NOTIFY_OK;
+}
+
 int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 {
 	struct usb_port *port_dev;
@@ -577,6 +586,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 
 	find_and_link_peer(hub, port1);
 
+	/*
+	 * In some cases, the Type C port gets registered later, so
+	 * register a Type C notifier so that we can link the ports
+	 * later too.
+	 */
+	port_dev->typec_nb.notifier_call = usb_port_link_typec_port;
+	typec_port_registration_register_notify(&port_dev->typec_nb);
+
 	/*
 	 * Enable runtime pm and hold a refernce that hub_configure()
 	 * will drop once the PM_QOS_NO_POWER_OFF flag state has been set
@@ -616,6 +633,7 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	struct usb_port *port_dev = hub->ports[port1 - 1];
 	struct usb_port *peer;
 
+	typec_port_registration_unregister_notify(&port_dev->typec_nb);
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 14b82109b0f5..92d03eb65f12 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2110,10 +2110,7 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
-	ret = typec_link_ports(port);
-	if (ret)
-		dev_warn(&port->dev, "failed to create symlinks (%d)\n", ret);
-
+	/* Used to allow USB ports to register to this Type C port */
 	blocking_notifier_call_chain(&typec_port_registration_notifier, 0, port);
 
 	return port;
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index aef03eb7e152..517236935a55 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -79,7 +79,6 @@ extern const struct device_type typec_port_dev_type;
 extern struct class typec_mux_class;
 extern struct class typec_class;
 
-int typec_link_ports(struct typec_port *connector);
 void typec_unlink_ports(struct typec_port *connector);
 
 #endif /* __USB_TYPEC_CLASS__ */
diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
index 9b0991bdf391..5597291bd769 100644
--- a/drivers/usb/typec/port-mapper.c
+++ b/drivers/usb/typec/port-mapper.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/usb.h>
 #include <linux/usb/typec.h>
 
 #include "class.h"
@@ -220,46 +219,6 @@ void typec_unlink_port(struct device *port)
 }
 EXPORT_SYMBOL_GPL(typec_unlink_port);
 
-static int each_port(struct device *port, void *connector)
-{
-	struct port_node *node;
-	int ret;
-
-	node = create_port_node(port);
-	if (IS_ERR(node))
-		return PTR_ERR(node);
-
-	if (!connector_match(connector, node)) {
-		remove_port_node(node);
-		return 0;
-	}
-
-	ret = link_port(to_typec_port(connector), node);
-	if (ret) {
-		remove_port_node(node->pld);
-		return ret;
-	}
-
-	get_device(connector);
-
-	return 0;
-}
-
-int typec_link_ports(struct typec_port *con)
-{
-	int ret = 0;
-
-	con->pld = get_pld(&con->dev);
-	if (!con->pld)
-		return 0;
-
-	ret = usb_for_each_port(&con->dev, each_port);
-	if (ret)
-		typec_unlink_ports(con);
-
-	return ret;
-}
-
 void typec_unlink_ports(struct typec_port *con)
 {
 	struct port_node *node;
-- 
2.34.0.rc2.393.gf8c9666880-goog


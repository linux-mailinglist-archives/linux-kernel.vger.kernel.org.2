Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D296E350F90
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhDAGyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:54:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:28103 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233536AbhDAGxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:53:44 -0400
IronPort-SDR: yA/QIHuqOkQ9jUz/cuZphJLyYqoOhXIgpCoEhh7oNZ2ivc1VxJ26eSybxUhfJMfEKvDaI8R/hT
 8ed6P9QwNwEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="188910822"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="188910822"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 23:53:44 -0700
IronPort-SDR: zxPWcKo3AVdkwTdvgb7AYEcn73XNc/f2zfk5ClY61Gx5AC0yvWkspyUCSnrsrUh/Yi4gRc55do
 xGwtdZuplNJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517218691"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2021 23:53:42 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] usb: Link the ports to the connectors they are attached to
Date:   Thu,  1 Apr 2021 09:53:45 +0300
Message-Id: <20210401065347.4010-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401065347.4010-1-heikki.krogerus@linux.intel.com>
References: <20210401065347.4010-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating link to the USB Type-C connector for every new port
that is added when possible.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-usb | 9 +++++++++
 drivers/usb/core/port.c                 | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index bf2c1968525f0..8b4303a0ff51d 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -255,6 +255,15 @@ Description:
 		is permitted, "u2" if only u2 is permitted, "u1_u2" if both u1 and
 		u2 are permitted.
 
+What:		/sys/bus/usb/devices/.../(hub interface)/portX/connector
+Date:		April 2021
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Link to the USB Type-C connector when available. This link is
+		only created when USB Type-C Connector Class is enabled, and
+		only if the system firmware is capable of describing the
+		connection between a port and its connector.
+
 What:		/sys/bus/usb/devices/.../power/usb2_lpm_l1_timeout
 Date:		May 2013
 Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index dfcca9c876c73..3c382a4b648ec 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -9,6 +9,7 @@
 
 #include <linux/slab.h>
 #include <linux/pm_qos.h>
+#include <linux/usb/typec.h>
 
 #include "hub.h"
 
@@ -576,6 +577,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	}
 
 	find_and_link_peer(hub, port1);
+	typec_link_port(&port_dev->dev);
 
 	/*
 	 * Enable runtime pm and hold a refernce that hub_configure()
@@ -619,5 +621,6 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
+	typec_unlink_port(&port_dev->dev);
 	device_unregister(&port_dev->dev);
 }
-- 
2.30.2


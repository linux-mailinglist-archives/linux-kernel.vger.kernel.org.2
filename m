Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C28311DE3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 15:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhBFOoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 09:44:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:38616 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230055AbhBFOoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:44:21 -0500
IronPort-SDR: RLFBkWLYOyyjj2j09f+W95lUoHI+f4srOwCAqnruZj2zZaAWNrwUUXhAvIAEEqKL2VHPrXxq8T
 z4oCIL9Cip7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200566034"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="200566034"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:40 -0800
IronPort-SDR: OmgNEOnVa9a8s3GVbWo6iwle/t/upJuhle324zvxYqpU5WyvNkY9Kyi9gwdV5t5r4Kxrn6wLu/
 5kjRo753tNLA==
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="394360214"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:39 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/6] mei: allow clients on bus to communicate in remove callback
Date:   Sat,  6 Feb 2021 16:43:21 +0200
Message-Id: <20210206144325.25682-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206144325.25682-1-tomas.winkler@intel.com>
References: <20210206144325.25682-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Introduce new intermediate state to allow the clients on the bus
to communicate with the firmware from the remove handler.
This is to enable to perform a clean shutdown.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c     | 6 ++++--
 drivers/misc/mei/client.c  | 3 ++-
 drivers/misc/mei/init.c    | 5 ++++-
 drivers/misc/mei/mei_dev.h | 1 +
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 2907db260fba..34fb5e541fe5 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -44,7 +44,8 @@ ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length, u8 vtag,
 	bus = cl->dev;
 
 	mutex_lock(&bus->device_lock);
-	if (bus->dev_state != MEI_DEV_ENABLED) {
+	if (bus->dev_state != MEI_DEV_ENABLED &&
+	    bus->dev_state != MEI_DEV_POWERING_DOWN) {
 		rets = -ENODEV;
 		goto out;
 	}
@@ -128,7 +129,8 @@ ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length, u8 *vtag,
 	bus = cl->dev;
 
 	mutex_lock(&bus->device_lock);
-	if (bus->dev_state != MEI_DEV_ENABLED) {
+	if (bus->dev_state != MEI_DEV_ENABLED &&
+	    bus->dev_state != MEI_DEV_POWERING_DOWN) {
 		rets = -ENODEV;
 		goto out;
 	}
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index beb6cdff20fb..d3f060dce4a6 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -990,7 +990,8 @@ int mei_cl_disconnect(struct mei_cl *cl)
 		return 0;
 	}
 
-	if (dev->dev_state == MEI_DEV_POWER_DOWN) {
+	if (dev->dev_state == MEI_DEV_POWERING_DOWN ||
+	    dev->dev_state == MEI_DEV_POWER_DOWN) {
 		cl_dbg(dev, cl, "Device is powering down, don't bother with disconnection\n");
 		mei_cl_set_disconnected(cl);
 		return 0;
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index bcee77768b91..5c8cb679b997 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -303,9 +303,12 @@ void mei_stop(struct mei_device *dev)
 	dev_dbg(dev->dev, "stopping the device.\n");
 
 	mutex_lock(&dev->device_lock);
-	mei_set_devstate(dev, MEI_DEV_POWER_DOWN);
+	mei_set_devstate(dev, MEI_DEV_POWERING_DOWN);
 	mutex_unlock(&dev->device_lock);
 	mei_cl_bus_remove_devices(dev);
+	mutex_lock(&dev->device_lock);
+	mei_set_devstate(dev, MEI_DEV_POWER_DOWN);
+	mutex_unlock(&dev->device_lock);
 
 	mei_cancel_work(dev);
 
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 8c395bfdf6f3..585a6f615bf8 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -57,6 +57,7 @@ enum mei_dev_state {
 	MEI_DEV_ENABLED,
 	MEI_DEV_RESETTING,
 	MEI_DEV_DISABLED,
+	MEI_DEV_POWERING_DOWN,
 	MEI_DEV_POWER_DOWN,
 	MEI_DEV_POWER_UP
 };
-- 
2.26.2


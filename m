Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54A3307266
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhA1JOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:14:20 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59289 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhA1JLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:11:34 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l53KF-0006C2-KP; Thu, 28 Jan 2021 10:10:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l53KF-00071V-BB; Thu, 28 Jan 2021 10:10:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de
Subject: [PATCH 1/2] i3c: Handle drivers without probe or remove callback
Date:   Thu, 28 Jan 2021 10:10:47 +0100
Message-Id: <20210128091048.17006-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A registered driver without a probe callback doesn't make sense, so
refuse to register such a driver. (Otherwise i3c_device_probe() yields a
NULL pointer exception.)

A driver without remove is possible, e.g. when all resources are freed
using devm callbacks. So guard the call to driver->remove by a check
for being non-NULL.

Note that the only in-tree i3c driver
(drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c) doesn't have a remove
callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/i3c/device.c |  5 +++++
 drivers/i3c/master.c | 10 ++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index bb8e60dff988..e92d3e9a52bd 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -262,6 +262,11 @@ int i3c_driver_register_with_owner(struct i3c_driver *drv, struct module *owner)
 	drv->driver.owner = owner;
 	drv->driver.bus = &i3c_bus_type;
 
+	if (!drv->probe) {
+		pr_err("Trying to register an i3c driver without probe callback\n");
+		return -EINVAL;
+	}
+
 	return driver_register(&drv->driver);
 }
 EXPORT_SYMBOL_GPL(i3c_driver_register_with_owner);
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index b61bf53ec07a..57a4f699eb8d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -326,11 +326,13 @@ static int i3c_device_remove(struct device *dev)
 {
 	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
 	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
-	int ret;
+	int ret = 0;
 
-	ret = driver->remove(i3cdev);
-	if (ret)
-		return ret;
+	if (driver->remove) {
+		ret = driver->remove(i3cdev);
+		if (ret)
+			return ret;
+	}
 
 	i3c_device_free_ibi(i3cdev);
 
-- 
2.29.2


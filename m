Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E8F307265
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhA1JOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:14:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57041 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhA1JLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:11:36 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l53KI-0006EQ-4a; Thu, 28 Jan 2021 10:10:54 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l53KH-00071Y-Rq; Thu, 28 Jan 2021 10:10:53 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de
Subject: [PATCH 2/2] i3c: Make remove callback return void
Date:   Thu, 28 Jan 2021 10:10:48 +0100
Message-Id: <20210128091048.17006-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128091048.17006-1-u.kleine-koenig@pengutronix.de>
References: <20210128091048.17006-1-u.kleine-koenig@pengutronix.de>
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

The driver core ignores the return value of struct bus_type::remove()
because there is only little that can be done. To simplify the quest to
make this function return void, let struct i3c_driver::remove() return
void, too. This makes it obvious that returning an error code is
a bad idea and future driver authors cannot get that wrong.

Up to now there are no drivers with a remove callback, so there is no
need to adapt drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/i3c/master.c       | 10 +++-------
 include/linux/i3c/device.h |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 57a4f699eb8d..f8e9b7305c13 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -326,17 +326,13 @@ static int i3c_device_remove(struct device *dev)
 {
 	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
 	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
-	int ret = 0;
 
-	if (driver->remove) {
-		ret = driver->remove(i3cdev);
-		if (ret)
-			return ret;
-	}
+	if (driver->remove)
+		driver->remove(i3cdev);
 
 	i3c_device_free_ibi(i3cdev);
 
-	return ret;
+	return 0;
 }
 
 struct bus_type i3c_bus_type = {
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index de102e4418ab..8242e13e7b0b 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -176,7 +176,7 @@ struct i3c_device;
 struct i3c_driver {
 	struct device_driver driver;
 	int (*probe)(struct i3c_device *dev);
-	int (*remove)(struct i3c_device *dev);
+	void (*remove)(struct i3c_device *dev);
 	const struct i3c_device_id *id_table;
 };
 
-- 
2.29.2


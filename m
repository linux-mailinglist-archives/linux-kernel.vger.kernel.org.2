Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EF53065F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbhA0VZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbhA0VYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:24:13 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31662C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:23:33 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 78AFCAE0B56; Wed, 27 Jan 2021 22:23:30 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vme: make remove callback return void
Date:   Wed, 27 Jan 2021 22:23:29 +0100
Message-Id: <20210127212329.98517-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core ignores the return value of struct bus_type::remove()
because there is only little that can be done. To simplify the quest to
make this function return void, let struct vme_driver::remove return void,
too. There is only a single vme driver and it already returns 0
unconditionally in .remove().

Also fix the bus remove function to always return 0.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/staging/vme/devices/vme_user.c | 4 +---
 drivers/vme/vme.c                      | 4 ++--
 include/linux/vme.h                    | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vme/devices/vme_user.c b/drivers/staging/vme/devices/vme_user.c
index fd0ea4dbcb91..35d7260e2271 100644
--- a/drivers/staging/vme/devices/vme_user.c
+++ b/drivers/staging/vme/devices/vme_user.c
@@ -689,7 +689,7 @@ static int vme_user_probe(struct vme_dev *vdev)
 	return err;
 }
 
-static int vme_user_remove(struct vme_dev *dev)
+static void vme_user_remove(struct vme_dev *dev)
 {
 	int i;
 
@@ -717,8 +717,6 @@ static int vme_user_remove(struct vme_dev *dev)
 
 	/* Unregister the major and minor device numbers */
 	unregister_chrdev_region(MKDEV(VME_MAJOR, 0), VME_DEVS);
-
-	return 0;
 }
 
 static struct vme_driver vme_user_driver = {
diff --git a/drivers/vme/vme.c b/drivers/vme/vme.c
index 54d7963c1078..1b15afea28ee 100644
--- a/drivers/vme/vme.c
+++ b/drivers/vme/vme.c
@@ -1997,9 +1997,9 @@ static int vme_bus_remove(struct device *dev)
 
 	driver = dev->platform_data;
 	if (driver->remove)
-		return driver->remove(vdev);
+		driver->remove(vdev);
 
-	return -ENODEV;
+	return 0;
 }
 
 struct bus_type vme_bus_type = {
diff --git a/include/linux/vme.h b/include/linux/vme.h
index 7e82bf500f01..b204a9b4be1b 100644
--- a/include/linux/vme.h
+++ b/include/linux/vme.h
@@ -122,7 +122,7 @@ struct vme_driver {
 	const char *name;
 	int (*match)(struct vme_dev *);
 	int (*probe)(struct vme_dev *);
-	int (*remove)(struct vme_dev *);
+	void (*remove)(struct vme_dev *);
 	struct device_driver driver;
 	struct list_head devices;
 };
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B11311AC6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBFESv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhBFCpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:45:38 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED3DC08EC49
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:29:05 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 00403AEDF01; Fri,  5 Feb 2021 23:29:03 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 5/5] dax-device: Make remove callback return void
Date:   Fri,  5 Feb 2021 23:28:42 +0100
Message-Id: <20210205222842.34896-6-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205222842.34896-1-uwe@kleine-koenig.org>
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core ignores the return value of struct bus_type::remove()
because there is only little that can be done. To simplify the quest to
make this function return void, let struct dax_device_driver::remove()
return void, too. All users already unconditionally return 0, this commit
makes it obvious that returning an error code isn't intended.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/dax/bus.c  | 5 ++---
 drivers/dax/bus.h  | 2 +-
 drivers/dax/kmem.c | 7 ++-----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index bc425f1c52bd..0a939e28d048 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -178,12 +178,11 @@ static int dax_bus_remove(struct device *dev)
 {
 	struct dax_device_driver *dax_drv = to_dax_drv(dev->driver);
 	struct dev_dax *dev_dax = to_dev_dax(dev);
-	int ret = 0;
 
 	if (dax_drv->remove)
-		ret = dax_drv->remove(dev_dax);
+		dax_drv->remove(dev_dax);
 
-	return ret;
+	return 0;
 }
 
 static struct bus_type dax_bus_type = {
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 72b92f95509f..1e946ad7780a 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -39,7 +39,7 @@ struct dax_device_driver {
 	struct list_head ids;
 	int match_always;
 	int (*probe)(struct dev_dax *dev);
-	int (*remove)(struct dev_dax *dev);
+	void (*remove)(struct dev_dax *dev);
 };
 
 int __dax_driver_register(struct dax_device_driver *dax_drv,
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 403ec42472d1..ac231cc36359 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -136,7 +136,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
+static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
 	int i, success = 0;
 	struct device *dev = &dev_dax->dev;
@@ -176,11 +176,9 @@ static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
 		kfree(data);
 		dev_set_drvdata(dev, NULL);
 	}
-
-	return 0;
 }
 #else
-static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
+static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
 	/*
 	 * Without hotremove purposely leak the request_mem_region() for the
@@ -190,7 +188,6 @@ static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
 	 * request_mem_region().
 	 */
 	any_hotremove_failed = true;
-	return 0;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-- 
2.29.2


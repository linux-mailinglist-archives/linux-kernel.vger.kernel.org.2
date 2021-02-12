Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453D131A359
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhBLRLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBLRLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:11:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0902C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:11:00 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lAbxy-0005xW-5E; Fri, 12 Feb 2021 18:10:50 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lAbxx-0000X0-Qc; Fri, 12 Feb 2021 18:10:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] libnvdimm: Make remove callback return void
Date:   Fri, 12 Feb 2021 18:10:43 +0100
Message-Id: <20210212171043.2136580-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210212171043.2136580-1-u.kleine-koenig@pengutronix.de>
References: <20210212171043.2136580-1-u.kleine-koenig@pengutronix.de>
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

All drivers return 0 in their remove callback and the driver core ignores
the return value of nvdimm_bus_remove() anyhow. So simplify by changing
the driver remove callback to return void and return 0 unconditionally
to the upper layer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/dax/pmem/compat.c |  3 +--
 drivers/nvdimm/blk.c      |  3 +--
 drivers/nvdimm/bus.c      | 13 +++++--------
 drivers/nvdimm/dimm.c     |  4 +---
 drivers/nvdimm/pmem.c     |  4 +---
 drivers/nvdimm/region.c   |  4 +---
 include/linux/nd.h        |  2 +-
 7 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/dax/pmem/compat.c b/drivers/dax/pmem/compat.c
index 863c114fd88c..d81dc35fd65d 100644
--- a/drivers/dax/pmem/compat.c
+++ b/drivers/dax/pmem/compat.c
@@ -41,10 +41,9 @@ static int dax_pmem_compat_release(struct device *dev, void *data)
 	return 0;
 }
 
-static int dax_pmem_compat_remove(struct device *dev)
+static void dax_pmem_compat_remove(struct device *dev)
 {
 	device_for_each_child(dev, NULL, dax_pmem_compat_release);
-	return 0;
 }
 
 static struct nd_device_driver dax_pmem_compat_driver = {
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 22e5617b2cea..8a53728e13e6 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -310,11 +310,10 @@ static int nd_blk_probe(struct device *dev)
 		return nsblk_attach_disk(nsblk);
 }
 
-static int nd_blk_remove(struct device *dev)
+static void nd_blk_remove(struct device *dev)
 {
 	if (is_nd_btt(dev))
 		nvdimm_namespace_detach_btt(to_nd_btt(dev));
-	return 0;
 }
 
 static struct nd_device_driver nd_blk_driver = {
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 2304c6183822..48f0985ca8a0 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -113,18 +113,17 @@ static int nvdimm_bus_remove(struct device *dev)
 	struct nd_device_driver *nd_drv = to_nd_device_driver(dev->driver);
 	struct module *provider = to_bus_provider(dev);
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
-	int rc = 0;
 
 	if (nd_drv->remove) {
 		debug_nvdimm_lock(dev);
-		rc = nd_drv->remove(dev);
+		nd_drv->remove(dev);
 		debug_nvdimm_unlock(dev);
 	}
 
-	dev_dbg(&nvdimm_bus->dev, "%s.remove(%s) = %d\n", dev->driver->name,
-			dev_name(dev), rc);
+	dev_dbg(&nvdimm_bus->dev, "%s.remove(%s)\n", dev->driver->name,
+			dev_name(dev));
 	module_put(provider);
-	return rc;
+	return 0;
 }
 
 static void nvdimm_bus_shutdown(struct device *dev)
@@ -427,7 +426,7 @@ static void free_badrange_list(struct list_head *badrange_list)
 	list_del_init(badrange_list);
 }
 
-static int nd_bus_remove(struct device *dev)
+static void nd_bus_remove(struct device *dev)
 {
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
 
@@ -446,8 +445,6 @@ static int nd_bus_remove(struct device *dev)
 	spin_unlock(&nvdimm_bus->badrange.lock);
 
 	nvdimm_bus_destroy_ndctl(nvdimm_bus);
-
-	return 0;
 }
 
 static int nd_bus_probe(struct device *dev)
diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
index 94be3ae1d29f..91d9163ee303 100644
--- a/drivers/nvdimm/dimm.c
+++ b/drivers/nvdimm/dimm.c
@@ -113,7 +113,7 @@ static int nvdimm_probe(struct device *dev)
 	return rc;
 }
 
-static int nvdimm_remove(struct device *dev)
+static void nvdimm_remove(struct device *dev)
 {
 	struct nvdimm_drvdata *ndd = dev_get_drvdata(dev);
 
@@ -121,8 +121,6 @@ static int nvdimm_remove(struct device *dev)
 	dev_set_drvdata(dev, NULL);
 	nvdimm_bus_unlock(dev);
 	put_ndd(ndd);
-
-	return 0;
 }
 
 static struct nd_device_driver nvdimm_driver = {
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 875076b0ea6c..062f0f22bac9 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -564,7 +564,7 @@ static int nd_pmem_probe(struct device *dev)
 	return pmem_attach_disk(dev, ndns);
 }
 
-static int nd_pmem_remove(struct device *dev)
+static void nd_pmem_remove(struct device *dev)
 {
 	struct pmem_device *pmem = dev_get_drvdata(dev);
 
@@ -579,8 +579,6 @@ static int nd_pmem_remove(struct device *dev)
 		pmem->bb_state = NULL;
 	}
 	nvdimm_flush(to_nd_region(dev->parent), NULL);
-
-	return 0;
 }
 
 static void nd_pmem_shutdown(struct device *dev)
diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index bfce87ed72ab..e0c34120df37 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -87,7 +87,7 @@ static int child_unregister(struct device *dev, void *data)
 	return 0;
 }
 
-static int nd_region_remove(struct device *dev)
+static void nd_region_remove(struct device *dev)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 
@@ -108,8 +108,6 @@ static int nd_region_remove(struct device *dev)
 	 */
 	sysfs_put(nd_region->bb_state);
 	nd_region->bb_state = NULL;
-
-	return 0;
 }
 
 static int child_notify(struct device *dev, void *data)
diff --git a/include/linux/nd.h b/include/linux/nd.h
index 55c735997805..cec526c8043d 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -26,7 +26,7 @@ struct nd_device_driver {
 	struct device_driver drv;
 	unsigned long type;
 	int (*probe)(struct device *dev);
-	int (*remove)(struct device *dev);
+	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
 	void (*notify)(struct device *dev, enum nvdimm_event event);
 };
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD33064BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhA0UFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:05:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:27801 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232392AbhA0UEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:04:35 -0500
IronPort-SDR: cdNuJVkOPnE0K81Lq7lLOVOqDa+Aub4/QqFE+qaxwD7d/BYsIqhABeQ/+mg+yx5ReOGRnECx5F
 R2UiT7sQELfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="167800157"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="167800157"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 12:03:43 -0800
IronPort-SDR: iB3rtpLgJa2w73OUePKEhX1ZANCkIn0uIe1Qn5RC0jw4DptpD/OzzQSDLgFjy55MyMJHkoDKPa
 3E+QiP5pLkZw==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="388450099"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 12:03:41 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH] mtd: use refcount to prevent corruption
Date:   Wed, 27 Jan 2021 22:03:19 +0200
Message-Id: <20210127200319.662842-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When underlying device is removed mtd core will crash
in case user space is still holding an open handle to a mtd device node.
A proper refcounting is needed so device is release only when a
partition has no active users. The current simple counter is not
sufficient.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/mtd/mtdcore.c   | 55 ++++++++++++++++++++++-------------------
 drivers/mtd/mtdcore.h   |  1 +
 drivers/mtd/mtdpart.c   | 12 ++++-----
 include/linux/mtd/mtd.h |  2 +-
 4 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2d6423d89a17..db5167eacaa4 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -93,9 +93,29 @@ static void mtd_release(struct device *dev)
 	dev_t index = MTD_DEVT(mtd->index);
 
 	/* remove /dev/mtdXro node */
+	if (mtd_is_partition(mtd))
+		release_mtd_partition(mtd);
+
 	device_destroy(&mtd_class, index + 1);
 }
 
+static void mtd_device_release(struct kref *kref)
+{
+	struct mtd_info *mtd = container_of(kref, struct mtd_info, refcnt);
+
+	if (mtd->nvmem) {
+		nvmem_unregister(mtd->nvmem);
+		mtd->nvmem = NULL;
+	}
+
+	idr_remove(&mtd_idr, mtd->index);
+	of_node_put(mtd_get_of_node(mtd));
+
+	device_unregister(&mtd->dev);
+
+	module_put(THIS_MODULE);
+}
+
 static ssize_t mtd_type_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -619,7 +639,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	}
 
 	mtd->index = i;
-	mtd->usecount = 0;
+	kref_init(&mtd->refcnt);
 
 	/* default value if not set by driver */
 	if (mtd->bitflip_threshold == 0)
@@ -733,23 +753,8 @@ int del_mtd_device(struct mtd_info *mtd)
 	list_for_each_entry(not, &mtd_notifiers, list)
 		not->remove(mtd);
 
-	if (mtd->usecount) {
-		printk(KERN_NOTICE "Removing MTD device #%d (%s) with use count %d\n",
-		       mtd->index, mtd->name, mtd->usecount);
-		ret = -EBUSY;
-	} else {
-		/* Try to remove the NVMEM provider */
-		if (mtd->nvmem)
-			nvmem_unregister(mtd->nvmem);
-
-		device_unregister(&mtd->dev);
-
-		idr_remove(&mtd_idr, mtd->index);
-		of_node_put(mtd_get_of_node(mtd));
-
-		module_put(THIS_MODULE);
-		ret = 0;
-	}
+	kref_put(&mtd->refcnt, mtd_device_release);
+	ret = 0;
 
 out_error:
 	mutex_unlock(&mtd_table_mutex);
@@ -984,20 +989,21 @@ int __get_mtd_device(struct mtd_info *mtd)
 	if (!try_module_get(master->owner))
 		return -ENODEV;
 
+	kref_get(&mtd->refcnt);
+
 	if (master->_get_device) {
 		err = master->_get_device(mtd);
 
 		if (err) {
+			kref_put(&mtd->refcnt, mtd_device_release);
 			module_put(master->owner);
 			return err;
 		}
 	}
 
-	master->usecount++;
-
 	while (mtd->parent) {
-		mtd->usecount++;
 		mtd = mtd->parent;
+		kref_get(&mtd->refcnt);
 	}
 
 	return 0;
@@ -1055,14 +1061,13 @@ void __put_mtd_device(struct mtd_info *mtd)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 
+	kref_put(&mtd->refcnt, mtd_device_release);
+
 	while (mtd->parent) {
-		--mtd->usecount;
-		BUG_ON(mtd->usecount < 0);
 		mtd = mtd->parent;
+		kref_put(&mtd->refcnt, mtd_device_release);
 	}
 
-	master->usecount--;
-
 	if (master->_put_device)
 		master->_put_device(master);
 
diff --git a/drivers/mtd/mtdcore.h b/drivers/mtd/mtdcore.h
index b5eefeabf310..b014861a06a6 100644
--- a/drivers/mtd/mtdcore.h
+++ b/drivers/mtd/mtdcore.h
@@ -12,6 +12,7 @@ int __must_check add_mtd_device(struct mtd_info *mtd);
 int del_mtd_device(struct mtd_info *mtd);
 int add_mtd_partitions(struct mtd_info *, const struct mtd_partition *, int);
 int del_mtd_partitions(struct mtd_info *);
+void release_mtd_partition(struct mtd_info *mtd);
 
 struct mtd_partitions;
 
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 12ca4f19cb14..8175f6d9c790 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -31,6 +31,12 @@ static inline void free_partition(struct mtd_info *mtd)
 	kfree(mtd);
 }
 
+void release_mtd_partition(struct mtd_info *mtd)
+{
+	list_del_init(&mtd->part.node);
+	free_partition(mtd);
+}
+
 static struct mtd_info *allocate_partition(struct mtd_info *parent,
 					   const struct mtd_partition *part,
 					   int partno, uint64_t cur_offset)
@@ -313,9 +319,6 @@ static int __mtd_del_partition(struct mtd_info *mtd)
 	if (err)
 		return err;
 
-	list_del(&child->part.node);
-	free_partition(mtd);
-
 	return 0;
 }
 
@@ -341,9 +344,6 @@ static int __del_mtd_partitions(struct mtd_info *mtd)
 			err = ret;
 			continue;
 		}
-
-		list_del(&child->part.node);
-		free_partition(child);
 	}
 
 	return err;
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 157357ec1441..1217c9d8d69d 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -373,7 +373,7 @@ struct mtd_info {
 
 	struct module *owner;
 	struct device dev;
-	int usecount;
+	struct kref refcnt;
 	struct mtd_debug_info dbg;
 	struct nvmem_device *nvmem;
 
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9153237F653
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhEMLFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:05:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:45141 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233068AbhEMLEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:04:45 -0400
IronPort-SDR: s5fT3wvgdEpf/ZsXn1mywF+4tebfkvfsc7EpJVM5iYla9nwGDPlETu6J6dRYU/L8ivB/FTjYTm
 hX94UVJrXYXg==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048380"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048380"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:28 -0700
IronPort-SDR: 30A08SwyGwH2qsKFsEzqlO/1xdXSqK2UQb8WASWwa7ZODOACTAv/diCahu4kQZ0/he1qV1pgPj
 gqDkkQQ0EcRg==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625984299"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:26 -0700
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v3 13/14] intel_gna: add file operations to a 'misc' device
Date:   Thu, 13 May 2021 13:00:39 +0200
Message-Id: <20210513110040.2268-14-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/device.c | 60 +++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
index 1e6345a8325b..c882055de8cf 100644
--- a/drivers/misc/intel/gna/device.c
+++ b/drivers/misc/intel/gna/device.c
@@ -4,7 +4,9 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 #include <uapi/misc/intel/gna.h>
 
@@ -20,16 +22,68 @@ module_param(recovery_timeout, int, 0644);
 MODULE_PARM_DESC(recovery_timeout, "Recovery timeout in seconds");
 #endif
 
-struct file;
-
 static int gna_open(struct inode *inode, struct file *f)
 {
-	return -EPERM;
+	struct gna_file_private *file_priv;
+	struct gna_private *gna_priv;
+
+	gna_priv = container_of(f->private_data, struct gna_private, misc);
+
+	file_priv = kzalloc(sizeof(*file_priv), GFP_KERNEL);
+	if (!file_priv)
+		return -ENOMEM;
+
+	file_priv->fd = f;
+	file_priv->gna_priv = gna_priv;
+
+	mutex_init(&file_priv->memlist_lock);
+	INIT_LIST_HEAD(&file_priv->memory_list);
+
+	INIT_LIST_HEAD(&file_priv->flist);
+
+	mutex_lock(&gna_priv->flist_lock);
+	list_add_tail(&file_priv->flist, &gna_priv->file_list);
+	mutex_unlock(&gna_priv->flist_lock);
+
+	f->private_data = file_priv;
+
+	return 0;
+}
+
+static int gna_release(struct inode *inode, struct file *f)
+{
+	struct gna_memory_object *iter_mo, *temp_mo;
+	struct gna_file_private *file_priv;
+	struct gna_private *gna_priv;
+
+	/* free all memory objects created by that file */
+	file_priv = (struct gna_file_private *)f->private_data;
+	gna_priv = file_priv->gna_priv;
+
+	mutex_lock(&file_priv->memlist_lock);
+	list_for_each_entry_safe(iter_mo, temp_mo, &file_priv->memory_list, file_mem_list) {
+		queue_work(gna_priv->request_wq, &iter_mo->work);
+		wait_event(iter_mo->waitq, true);
+		gna_memory_free(gna_priv, iter_mo);
+	}
+	mutex_unlock(&file_priv->memlist_lock);
+
+	gna_delete_file_requests(f, gna_priv);
+
+	mutex_lock(&gna_priv->flist_lock);
+	list_del_init(&file_priv->flist);
+	mutex_unlock(&gna_priv->flist_lock);
+	kfree(file_priv);
+	f->private_data = NULL;
+
+	return 0;
 }
 
 static const struct file_operations gna_file_ops = {
 	.owner		=	THIS_MODULE,
 	.open		=	gna_open,
+	.release	=	gna_release,
+	.unlocked_ioctl =	gna_ioctl,
 };
 
 static void gna_devm_idr_destroy(void *data)
-- 
2.28.0


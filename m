Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536B53480CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhCXSjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:39:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:17741 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237691AbhCXSiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:52 -0400
IronPort-SDR: Vry9XIMZyM3cYzJNDxsKdJxFQ1g7kQ1vUas7jclMGzpNDb7d3HrwMSaxuPJyw9UplxgA7ba9cB
 HyRX4x0UrR1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190859585"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190859585"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:52 -0700
IronPort-SDR: Ck0UDrK3J/KzAcuje5/Avfx+nteDZ2PA5dQgq2nPVJ2x97zXIVlBYd4rAaR5tkfU+4UvPbU25V
 m9Mxy25UQYuw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608203941"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:49 -0700
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
Subject: [PATCH v2 13/13] intel_gna: add file operations to a 'misc' device
Date:   Wed, 24 Mar 2021 19:36:10 +0100
Message-Id: <20210324183610.4574-14-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
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
 drivers/misc/intel/gna/gna_device.c | 60 ++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/intel/gna/gna_device.c b/drivers/misc/intel/gna/gna_device.c
index 3f7f4c07d1a1..3f74a0a3bd30 100644
--- a/drivers/misc/intel/gna/gna_device.c
+++ b/drivers/misc/intel/gna/gna_device.c
@@ -93,12 +93,70 @@ MODULE_DEVICE_TABLE(pci, gna_pci_ids);
 
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
+	struct gna_file_private *iter_file, *temp_file;
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
+	list_for_each_entry_safe(iter_file, temp_file, &gna_priv->file_list, flist) {
+		if (iter_file->fd == f) {
+			list_del(&iter_file->flist);
+			f->private_data = NULL;
+			kfree(iter_file);
+			break;
+		}
+	}
+	mutex_unlock(&gna_priv->flist_lock);
+
+	return 0;
 }
 
 static const struct file_operations gna_file_ops = {
 	.owner		=	THIS_MODULE,
 	.open		=	gna_open,
+	.release	=	gna_release,
+	.unlocked_ioctl =	gna_ioctl,
 };
 
 static void gna_dev_release(struct gna_private *gna_priv)
-- 
2.28.0


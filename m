Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0088B36C6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbhD0N0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbhD0N0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:26:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F21C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:25:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r12so89485270ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ox97eQahZzXAKhDhV83RnJG9UlXriZW0N3GFvMTDDRY=;
        b=PqcDQe91kPsyWJo6gdTIZKgJ+AiBJb8Y0Ch1VIpEO/XL6a+vuMJHPTtGV03zmbqY3y
         leYaYqT2SGzNBk8HwkZHoPuPSOyKixM96fZ7JBZG9ATjOr4ey+aw+t9AroEkWsDkh8RC
         +jYebJzXlNUnqvsSp5Fw9kQ15YYj4xBoQ/9dK7qiv49NSOIoPazp7Vek3mp+CIYFo1wl
         jof7l/Y0RN4zJ7hFXjuXM5O+kHKZGEuCk2g1wCSeyWuR2VFatJpvzUS0hwlov5MNMHcM
         EzQNcuAerxbtpG2NuxGfxC+Oxlo5skm/WXmCXI6015WZ0sba+GLCi1NBsTGfbQUcr4tQ
         UC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ox97eQahZzXAKhDhV83RnJG9UlXriZW0N3GFvMTDDRY=;
        b=X/VoyjfY9ZYrp+EAa6vrGUbc8D7FHfq5Z/anbb4YVrLA96cQaxNFavUhDCNdF29KGY
         V9LW9D6PjheUF9T72a0XRZJ5mJc3qUPUPPUfKBXbSnmtzMOQyHA5Ew/y2Jr+rAps5LBw
         WDE+Ys5T+uTSGWypPoFdhv9kz9t6PYlf9mXeZRR2dmhMcGFUkwUsqYFPpslPfD2HszaK
         kF52r3G0f1/pd1gEy+pxIGhkp2zlysOgADBMZplGcVpfLQu4WC3I7LM3jd0umVhymlEP
         RgrJAYTkizqfxoN0oDBzNk8h5qVCInsPrfIaL/EmTyvHKhHffKze/3ruFC5+PkTTe0Zv
         vA0A==
X-Gm-Message-State: AOAM531zKHMOcIjutmuXNv39Xb9MTOsRiYzbVc9Jq1LJE1K+4kVBfWec
        bzET1A1SX8hbr8ZEXpcihLl4PRbilsAfgeBr
X-Google-Smtp-Source: ABdhPJzX5KtPak9gY3SoeqiwP3LhEduHcYS5J9dRaGYeTWmlSCj+y7HX+4QX0LNcTxzIvX2lPruYjw==
X-Received: by 2002:a17:906:2c55:: with SMTP id f21mr10774146ejh.41.1619529927216;
        Tue, 27 Apr 2021 06:25:27 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id r5sm2414458eds.44.2021.04.27.06.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 06:25:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v4] staging: unisys: visorhba: Convert module from IDR to XArray
Date:   Tue, 27 Apr 2021 15:25:22 +0200
Message-Id: <20210427132522.14547-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converted visorhba from IDR to XArray. The abstract data type XArray is
more memory-efficient, parallelisable and cache friendly. It takes
advantage of RCU to perform lookups without locking.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v3: Matthew Wilcox found that the XArray was not
initialized: now it is. Changed types handles from u64 to u32 because
they can't work as arguments of xa_alloc_irq() and u32 is enough large
for storing XArray indexes.
Changes from v2: Some residual errors from v1 were not fixed in v2. Now
they have been removed.
Changes from v1: After a first review by Matthew Wilcox, who found a
series of errors and gave suggestions on how to fix them, I rewrote a
larger part of the patch.

 drivers/staging/unisys/include/iochannel.h    |  4 +-
 .../staging/unisys/visorhba/visorhba_main.c   | 89 ++++++-------------
 2 files changed, 28 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/unisys/include/iochannel.h b/drivers/staging/unisys/include/iochannel.h
index 9ef812c0bc42..fac89eac148b 100644
--- a/drivers/staging/unisys/include/iochannel.h
+++ b/drivers/staging/unisys/include/iochannel.h
@@ -474,8 +474,8 @@ struct uiscmdrsp_scsitaskmgmt {
 	enum task_mgmt_types tasktype;
 	struct uisscsi_dest vdest;
 	u64 handle;
-	u64 notify_handle;
-	u64 notifyresult_handle;
+	u32 notify_handle;
+	u32 notifyresult_handle;
 	char result;
 
 #define TASK_MGMT_FAILED 0
diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 4455d26f7c96..2b6cde254f17 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -6,10 +6,10 @@
 
 #include <linux/debugfs.h>
 #include <linux/kthread.h>
-#include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/visorbus.h>
+#include <linux/xarray.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
@@ -82,7 +82,7 @@ struct visorhba_devdata {
 	 * allows us to pass int handles back-and-forth between us and
 	 * iovm, instead of raw pointers
 	 */
-	struct idr idr;
+	struct xarray xa;
 
 	struct dentry *debugfs_dir;
 	struct dentry *debugfs_info;
@@ -182,71 +182,40 @@ static struct uiscmdrsp *get_scsipending_cmdrsp(struct visorhba_devdata *ddata,
 	return NULL;
 }
 
-/*
- * simple_idr_get - Associate a provided pointer with an int value
- *		    1 <= value <= INT_MAX, and return this int value;
- *		    the pointer value can be obtained later by passing
- *		    this int value to idr_find()
- * @idrtable: The data object maintaining the pointer<-->int mappings
- * @p:	      The pointer value to be remembered
- * @lock:     A spinlock used when exclusive access to idrtable is needed
- *
- * Return: The id number mapped to pointer 'p', 0 on failure
- */
-static unsigned int simple_idr_get(struct idr *idrtable, void *p,
-				   spinlock_t *lock)
-{
-	int id;
-	unsigned long flags;
-
-	idr_preload(GFP_KERNEL);
-	spin_lock_irqsave(lock, flags);
-	id = idr_alloc(idrtable, p, 1, INT_MAX, GFP_NOWAIT);
-	spin_unlock_irqrestore(lock, flags);
-	idr_preload_end();
-	/* failure */
-	if (id < 0)
-		return 0;
-	/* idr_alloc() guarantees > 0 */
-	return (unsigned int)(id);
-}
-
 /*
  * setup_scsitaskmgmt_handles - Stash the necessary handles so that the
  *				completion processing logic for a taskmgmt
  *				cmd will be able to find who to wake up
  *				and where to stash the result
- * @idrtable: The data object maintaining the pointer<-->int mappings
- * @lock:     A spinlock used when exclusive access to idrtable is needed
+ * @xa:       The data object maintaining the pointer<-->int mappings
  * @cmdrsp:   Response from the IOVM
  * @event:    The event handle to associate with an id
  * @result:   The location to place the result of the event handle into
  */
-static void setup_scsitaskmgmt_handles(struct idr *idrtable, spinlock_t *lock,
-				       struct uiscmdrsp *cmdrsp,
+static void setup_scsitaskmgmt_handles(struct xarray *xa, struct uiscmdrsp *cmdrsp,
 				       wait_queue_head_t *event, int *result)
 {
-	/* specify the event that has to be triggered when this */
-	/* cmd is complete */
-	cmdrsp->scsitaskmgmt.notify_handle =
-		simple_idr_get(idrtable, event, lock);
-	cmdrsp->scsitaskmgmt.notifyresult_handle =
-		simple_idr_get(idrtable, result, lock);
+	int ret;
+	u32 *id;
+
+	/* specify the event that has to be triggered when this cmd is complete */
+	id = &cmdrsp->scsitaskmgmt.notify_handle;
+	ret = xa_alloc_irq(xa, id, event, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
+	id = &cmdrsp->scsitaskmgmt.notifyresult_handle;
+	ret = xa_alloc_irq(xa, id, result, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
 }
 
 /*
  * cleanup_scsitaskmgmt_handles - Forget handles created by
  *				  setup_scsitaskmgmt_handles()
- * @idrtable: The data object maintaining the pointer<-->int mappings
+ * @xa: The data object maintaining the pointer<-->int mappings
  * @cmdrsp:   Response from the IOVM
  */
-static void cleanup_scsitaskmgmt_handles(struct idr *idrtable,
+static void cleanup_scsitaskmgmt_handles(struct xarray *xa,
 					 struct uiscmdrsp *cmdrsp)
 {
-	if (cmdrsp->scsitaskmgmt.notify_handle)
-		idr_remove(idrtable, cmdrsp->scsitaskmgmt.notify_handle);
-	if (cmdrsp->scsitaskmgmt.notifyresult_handle)
-		idr_remove(idrtable, cmdrsp->scsitaskmgmt.notifyresult_handle);
+	xa_erase(xa, cmdrsp->scsitaskmgmt.notify_handle);
+	xa_erase(xa, cmdrsp->scsitaskmgmt.notifyresult_handle);
 }
 
 /*
@@ -273,8 +242,7 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
 	if (devdata->serverdown || devdata->serverchangingstate)
 		return FAILED;
 
-	scsicmd_id = add_scsipending_entry(devdata, CMD_SCSITASKMGMT_TYPE,
-					   NULL);
+	scsicmd_id = add_scsipending_entry(devdata, CMD_SCSITASKMGMT_TYPE, NULL);
 	if (scsicmd_id < 0)
 		return FAILED;
 
@@ -284,8 +252,7 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
 
 	/* issue TASK_MGMT_ABORT_TASK */
 	cmdrsp->cmdtype = CMD_SCSITASKMGMT_TYPE;
-	setup_scsitaskmgmt_handles(&devdata->idr, &devdata->privlock, cmdrsp,
-				   &notifyevent, &notifyresult);
+	setup_scsitaskmgmt_handles(&devdata->xa, cmdrsp, &notifyevent, &notifyresult);
 
 	/* save destination */
 	cmdrsp->scsitaskmgmt.tasktype = tasktype;
@@ -311,14 +278,14 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
 	dev_dbg(&scsidev->sdev_gendev,
 		"visorhba: taskmgmt type=%d success; result=0x%x\n",
 		 tasktype, notifyresult);
-	cleanup_scsitaskmgmt_handles(&devdata->idr, cmdrsp);
+	cleanup_scsitaskmgmt_handles(&devdata->xa, cmdrsp);
 	return SUCCESS;
 
 err_del_scsipending_ent:
 	dev_dbg(&scsidev->sdev_gendev,
 		"visorhba: taskmgmt type=%d not executed\n", tasktype);
 	del_scsipending_ent(devdata, scsicmd_id);
-	cleanup_scsitaskmgmt_handles(&devdata->idr, cmdrsp);
+	cleanup_scsitaskmgmt_handles(&devdata->xa, cmdrsp);
 	return FAILED;
 }
 
@@ -654,13 +621,12 @@ DEFINE_SHOW_ATTRIBUTE(info_debugfs);
  * Service Partition returned the result of the task management
  * command. Wake up anyone waiting for it.
  */
-static void complete_taskmgmt_command(struct idr *idrtable,
-				      struct uiscmdrsp *cmdrsp, int result)
+static void complete_taskmgmt_command(struct xarray *xa, struct uiscmdrsp *cmdrsp, int result)
 {
 	wait_queue_head_t *wq =
-		idr_find(idrtable, cmdrsp->scsitaskmgmt.notify_handle);
+		xa_load(xa, cmdrsp->scsitaskmgmt.notify_handle);
 	int *scsi_result_ptr =
-		idr_find(idrtable, cmdrsp->scsitaskmgmt.notifyresult_handle);
+		xa_load(xa, cmdrsp->scsitaskmgmt.notifyresult_handle);
 	if (unlikely(!(wq && scsi_result_ptr))) {
 		pr_err("visorhba: no completion context; cmd will time out\n");
 		return;
@@ -708,8 +674,7 @@ static void visorhba_serverdown_complete(struct visorhba_devdata *devdata)
 			break;
 		case CMD_SCSITASKMGMT_TYPE:
 			cmdrsp = pendingdel->sent;
-			complete_taskmgmt_command(&devdata->idr, cmdrsp,
-						  TASK_MGMT_FAILED);
+			complete_taskmgmt_command(&devdata->xa, cmdrsp, TASK_MGMT_FAILED);
 			break;
 		default:
 			break;
@@ -905,7 +870,7 @@ static void drain_queue(struct uiscmdrsp *cmdrsp,
 			if (!del_scsipending_ent(devdata,
 						 cmdrsp->scsitaskmgmt.handle))
 				break;
-			complete_taskmgmt_command(&devdata->idr, cmdrsp,
+			complete_taskmgmt_command(&devdata->xa, cmdrsp,
 						  cmdrsp->scsitaskmgmt.result);
 		} else if (cmdrsp->cmdtype == CMD_NOTIFYGUEST_TYPE)
 			dev_err_once(&devdata->dev->device,
@@ -1053,7 +1018,7 @@ static int visorhba_probe(struct visor_device *dev)
 	if (err)
 		goto err_debugfs_info;
 
-	idr_init(&devdata->idr);
+	xa_init(&devdata->xa);
 
 	devdata->cmdrsp = kmalloc(sizeof(*devdata->cmdrsp), GFP_ATOMIC);
 	visorbus_enable_channel_interrupts(dev);
@@ -1096,8 +1061,6 @@ static void visorhba_remove(struct visor_device *dev)
 	scsi_remove_host(scsihost);
 	scsi_host_put(scsihost);
 
-	idr_destroy(&devdata->idr);
-
 	dev_set_drvdata(&dev->device, NULL);
 	debugfs_remove(devdata->debugfs_info);
 	debugfs_remove_recursive(devdata->debugfs_dir);
-- 
2.31.1


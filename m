Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E536136B93E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhDZSnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbhDZSnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1450C061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:42:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n2so85927835ejy.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/oHzY7EFmjXmbACcqlKjXXYBIu0vYraMFUksRGGqX5E=;
        b=o7dc2KZctRLIt6MSgzsov3bvXxNCEw9okaGaWSiX1juvDf0KRbwD6SKGy/NjBbNWhD
         oKUfynXkYHC0+tU4Ti4+OtWg85aiI9hQy5hm+lupD93K96MHfOzr3g8//Bzv1AwtsRxf
         MK5IgFjT8VDunSN94j4bdZvZHQ/JDd3pvDy1D3cWxAAZKVfe1I2EopEbRkmMEDMyiwGf
         1o93sVlVbYNeR6BmpMxrR9GeGl6mHnO2boSDmwPqeJmebhFJfeT24PNGjqFPPiwRCpSh
         uAjNFfqXVfSI5tlClZ2SjJOtT/p3Vtk9ooiMWdjocm4Y+R2kMwFVFeqRd6RIjGAri7en
         juKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/oHzY7EFmjXmbACcqlKjXXYBIu0vYraMFUksRGGqX5E=;
        b=QQp4buS3qxX/bujs7rEwm7zyCKd8NdT/l+6wk7XbIDQbkToHb+d/BdS+6h+e7F+vbj
         S+HJidoyWXWu3sMX9JA4wBhxJY7Oq0q3qqk1R6hztjU0ysEYX5eRjQCvbeRkd1Qq+bSk
         Hgucpgiv+YH/JtIhzSUoCuiUGVnk0oEMWg+fe2F/qeb6stJjwP+j0zO8t4CIVfcG4f0s
         1tWP4Rg1Djg3Z9Aj+43B8dmJmtBmatyCMlMiLAEh1BRxXrjA3IklmwO0dB1S0eFaA/We
         vqMbqJ5sOS44OQ6PpMMV5iwEvlrqVgMij+qHFF8Y7QpgtOUAE5erx3WgAKOYcxOHohk5
         nhyQ==
X-Gm-Message-State: AOAM531kIISBAWCVFkgXnYMctNV9f8KfpvRH7jQU59+O9jQRL+X/qZDa
        5mksLWytS5ZOo7DmoJLTcrY=
X-Google-Smtp-Source: ABdhPJwsTbNTz8PNm+qJY1E7LQZUWJpgqKAJZpykcDUcH7PRF0lia3p4nUhaej0CaLLVK1x10UIt1g==
X-Received: by 2002:a17:906:37c9:: with SMTP id o9mr19716700ejc.285.1619462569599;
        Mon, 26 Apr 2021 11:42:49 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id l15sm417273edb.48.2021.04.26.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:42:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v3] staging: unisys: visorhba: Convert module from IDR to XArray
Date:   Mon, 26 Apr 2021 20:42:45 +0200
Message-Id: <20210426184245.12269-1-fmdefrancesco@gmail.com>
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

Changes from v2: Some residual errors from v1 were not fixed in v2. Now
they have been removed.
Changes from v1: After a first review by Matthew Wilcox, who found a
series of errors and gave suggestions on how to fix them, I rewrote a
larger part of the patch.

 .../staging/unisys/visorhba/visorhba_main.c   | 89 ++++++-------------
 1 file changed, 25 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 4455d26f7c96..938a5081b835 100644
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
+	u32 id;
+	int ret;
+
+	/* specify the event that has to be triggered when this cmd is complete */
+	id = (u32)cmdrsp->scsitaskmgmt.notify_handle;
+	ret = xa_alloc_irq(xa, &id, event, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
+	id = (u32)cmdrsp->scsitaskmgmt.notifyresult_handle;
+	ret = xa_alloc_irq(xa, &id, result, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
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
@@ -1053,8 +1018,6 @@ static int visorhba_probe(struct visor_device *dev)
 	if (err)
 		goto err_debugfs_info;
 
-	idr_init(&devdata->idr);
-
 	devdata->cmdrsp = kmalloc(sizeof(*devdata->cmdrsp), GFP_ATOMIC);
 	visorbus_enable_channel_interrupts(dev);
 
@@ -1096,8 +1059,6 @@ static void visorhba_remove(struct visor_device *dev)
 	scsi_remove_host(scsihost);
 	scsi_host_put(scsihost);
 
-	idr_destroy(&devdata->idr);
-
 	dev_set_drvdata(&dev->device, NULL);
 	debugfs_remove(devdata->debugfs_info);
 	debugfs_remove_recursive(devdata->debugfs_dir);
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC48B372B1A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhEDNd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhEDNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:33:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEA9C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 06:32:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j28so10418426edy.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRyId4VgDqthd+b4OLsO7RNwvt7TF0PANqkiy/Ygc58=;
        b=svUhGK1SE+xSvGmtwvlThhZm4PovQUlxvMPqdClC24upyZNj7CdsaDlp+pmm3EfQzt
         AN5mkhsnZddllk/1gC+RcK1ZkJHNHr80/yJAQ9i+r2EOlbv0lVTmTwIDVIQwjT8YBAkd
         XdYwrYD3PzmBd59zqKz5O4LKNSFIbp6uP2SZuZmbkTBBakH9YGfZLOqpiV53eWwTG7DW
         OVNomcSAr/Lp5zNOnNTfEqMHrEm6zncffXDCK5B9EpDITXMs5jBe7YxSbcs8ZT8LTJ7l
         y23dw/14UVi/KYlwhcz9uU+fq4p9N+TT1YR7rB/498gRg9dkaiO841GKx2biK8VZopTv
         8bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRyId4VgDqthd+b4OLsO7RNwvt7TF0PANqkiy/Ygc58=;
        b=Dt0UZ9CdwxSY/nSymD4czlbfYXXCtmi3URly9sCPnzXqW9rfP9E40gS3Jg9gPNDO0r
         EZkfr5hnPk/6tLBtcxGZnTg5427rjfzPVZhqb4OxBq9cck2I4fcZ1tGtBVZYi5+QHTbT
         FIvR50kN+jv16RkhD46Xuh142l/Bqb4si0ovQJ/ZpkJHnM9yAY7MyPUpqfgXLW3U9aTq
         8qtE8QT5IDh6Kw+wgXIFMgCwK6RW5ICjMRnMVw4LGzlBve/Uyfr9JO5uj8Gwsb6WdC0b
         bYupl5TT0EYaQ7YXFL3jr+FXmvsjKqBolYjvW88qCRhSIPGpS0+eiTFh5XdHRLXGl1iI
         S4gg==
X-Gm-Message-State: AOAM533pcw+xIpMF3AZGVrv+22+MeF8fKVCRpYNZBpuCQuTcZJ6N+6DP
        J9nKBKz8IIhX7SwTXRnml+0=
X-Google-Smtp-Source: ABdhPJxmjiyqkFXyn3aCBXtzW2v6iGqHaLTo3c9/jzq4soDJbiNjuoopQwpWVG0btbQk2F5Xl9X+bA==
X-Received: by 2002:aa7:cd90:: with SMTP id x16mr25657083edv.182.1620135178245;
        Tue, 04 May 2021 06:32:58 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id z11sm1404698ejc.122.2021.05.04.06.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 06:32:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7] staging: unisys: visorhba: Convert module from IDR to XArray
Date:   Tue,  4 May 2021 15:32:53 +0200
Message-Id: <20210504133253.32269-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converted visorhba from IDR to XArray. The abstract data type XArray is
more memory-efficient, parallelizable and cache friendly. It takes
advantage of RCU to perform lookups without locking. Furthermore, IDR is
deprecated because XArray has a better (cleaner and more consistent)
API.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v6; Added a call to xa_destroy() that I had forgotten.
Fixed taking locks with interrupts disabled (use xa_erase_irq()). 
Replaced checking for success with checking for failure. Issues detected 
by Dan Carpenter and Matthew Wilcox.
Changes from v5: As suggested by Matthew Wilcox, reworded the commit
message, modified setup_scsitaskmgmt_handles() to manage and return errors,
used 'xa_limit_32b' as the range of indexes (because there is no need to
use 0 as a marker of no allocation).
Changes from v4: Fixed some issues detected by Matthew Wilcox and Fabio
Aiuto.
Changes from v3: Matthew Wilcox found that the XArray was not
initialized: now it is. Changed types handles from u64 to u32 because
they can't work as arguments of xa_alloc_irq() and u32 is enough large
for storing XArray indexes.
Changes from v2: Some residual errors from v1 were not fixed in v2. Now
they have been removed.
Changes from v1: After a first review by Matthew Wilcox, who found a
series of errors and gave suggestions on how to fix them, I rewrote a
larger part of the patch.

 .../staging/unisys/visorhba/visorhba_main.c   | 102 ++++++++----------
 1 file changed, 43 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 4455d26f7c96..61b2b133ec33 100644
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
@@ -82,8 +82,7 @@ struct visorhba_devdata {
 	 * allows us to pass int handles back-and-forth between us and
 	 * iovm, instead of raw pointers
 	 */
-	struct idr idr;
-
+	struct xarray xa;
 	struct dentry *debugfs_dir;
 	struct dentry *debugfs_info;
 };
@@ -182,71 +181,49 @@ static struct uiscmdrsp *get_scsipending_cmdrsp(struct visorhba_devdata *ddata,
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
+static int setup_scsitaskmgmt_handles(struct xarray *xa, struct uiscmdrsp *cmdrsp,
 				       wait_queue_head_t *event, int *result)
 {
-	/* specify the event that has to be triggered when this */
-	/* cmd is complete */
-	cmdrsp->scsitaskmgmt.notify_handle =
-		simple_idr_get(idrtable, event, lock);
-	cmdrsp->scsitaskmgmt.notifyresult_handle =
-		simple_idr_get(idrtable, result, lock);
+	int ret;
+	u32 id;
+
+	/* specify the event that has to be triggered when this cmd is complete */
+	ret = xa_alloc_irq(xa, &id, event, xa_limit_32b, GFP_KERNEL);
+	if (ret) 
+		return ret;
+	else
+		cmdrsp->scsitaskmgmt.notify_handle = id;
+	ret = xa_alloc_irq(xa, &id, result, xa_limit_32b, GFP_KERNEL);
+	if (ret) {
+		xa_erase_irq(xa, cmdrsp->scsitaskmgmt.notify_handle);
+		return ret;
+	} else
+		cmdrsp->scsitaskmgmt.notifyresult_handle = id;
+
+	return 0;
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
+	xa_erase_irq(xa, cmdrsp->scsitaskmgmt.notify_handle);
+	xa_erase_irq(xa, cmdrsp->scsitaskmgmt.notifyresult_handle);
 }
 
 /*
@@ -269,6 +246,7 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
 	int notifyresult = 0xffff;
 	wait_queue_head_t notifyevent;
 	int scsicmd_id;
+	int ret;
 
 	if (devdata->serverdown || devdata->serverchangingstate)
 		return FAILED;
@@ -284,8 +262,14 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
 
 	/* issue TASK_MGMT_ABORT_TASK */
 	cmdrsp->cmdtype = CMD_SCSITASKMGMT_TYPE;
-	setup_scsitaskmgmt_handles(&devdata->idr, &devdata->privlock, cmdrsp,
-				   &notifyevent, &notifyresult);
+
+	ret = setup_scsitaskmgmt_handles(&devdata->xa, cmdrsp,
+					 &notifyevent, &notifyresult);
+	if (ret) {
+		dev_dbg(&scsidev->sdev_gendev,
+		        "visorhba: setup_scsitaskmgmt_handles returned %d\n", ret);
+		return FAILED;
+	}
 
 	/* save destination */
 	cmdrsp->scsitaskmgmt.tasktype = tasktype;
@@ -311,14 +295,14 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
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
 
@@ -654,13 +638,13 @@ DEFINE_SHOW_ATTRIBUTE(info_debugfs);
  * Service Partition returned the result of the task management
  * command. Wake up anyone waiting for it.
  */
-static void complete_taskmgmt_command(struct idr *idrtable,
+static void complete_taskmgmt_command(struct xarray *xa,
 				      struct uiscmdrsp *cmdrsp, int result)
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
@@ -708,7 +692,7 @@ static void visorhba_serverdown_complete(struct visorhba_devdata *devdata)
 			break;
 		case CMD_SCSITASKMGMT_TYPE:
 			cmdrsp = pendingdel->sent;
-			complete_taskmgmt_command(&devdata->idr, cmdrsp,
+			complete_taskmgmt_command(&devdata->xa, cmdrsp,
 						  TASK_MGMT_FAILED);
 			break;
 		default:
@@ -905,7 +889,7 @@ static void drain_queue(struct uiscmdrsp *cmdrsp,
 			if (!del_scsipending_ent(devdata,
 						 cmdrsp->scsitaskmgmt.handle))
 				break;
-			complete_taskmgmt_command(&devdata->idr, cmdrsp,
+			complete_taskmgmt_command(&devdata->xa, cmdrsp,
 						  cmdrsp->scsitaskmgmt.result);
 		} else if (cmdrsp->cmdtype == CMD_NOTIFYGUEST_TYPE)
 			dev_err_once(&devdata->dev->device,
@@ -1053,7 +1037,7 @@ static int visorhba_probe(struct visor_device *dev)
 	if (err)
 		goto err_debugfs_info;
 
-	idr_init(&devdata->idr);
+	xa_init(&devdata->xa);
 
 	devdata->cmdrsp = kmalloc(sizeof(*devdata->cmdrsp), GFP_ATOMIC);
 	visorbus_enable_channel_interrupts(dev);
@@ -1096,7 +1080,7 @@ static void visorhba_remove(struct visor_device *dev)
 	scsi_remove_host(scsihost);
 	scsi_host_put(scsihost);
 
-	idr_destroy(&devdata->idr);
+	xa_destroy(&devdata->xa);
 
 	dev_set_drvdata(&dev->device, NULL);
 	debugfs_remove(devdata->debugfs_info);
-- 
2.31.1


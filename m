Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D267B36B10A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhDZJvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhDZJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:51:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A195C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:50:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id t4so199031ejo.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShMo62waoXdZPA8Pjv746uYpSuq7bJJgFSuovFSewxU=;
        b=flm3mKB/uF+WoPuFwxRs3v9CquC6FJr/cB7imk2AZkiyc3PO5quJP1/ojpF16RKFig
         p8DP7Gmvc6eAmK+gd/FxZpHtyIQZn+nN+dqbe2ceq6ISC9blBSZqWr6dysGljEbHNI4M
         2RXqsV1bkKoI4jcE7Hx0RQfItyQf2DsAO2JGXy5BkMHFeqwTdQmtRC6flMot2/xN7XpP
         370VdV3UnXBiRI1+EPtATsJE4akgRRGZfFYG9CoO2r6GFnFlNSZ6yOokYSgMWs7JtwKd
         AwqycfHY5pL2rJOWqaPz/11ByAOi5TWAcu2mVKpb2F/dc21+afhSf8iA7cp/SOinfaNH
         32Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShMo62waoXdZPA8Pjv746uYpSuq7bJJgFSuovFSewxU=;
        b=p5t5KR9Tgtjt/gx+zDrwoyy6wAINsmBKV9Ol33OOnb7niqQVb3aueYd0mXRRCtiewy
         ZpPX61IFthjspD458REHDCUnXVpol9OmkYjQdsPjCwvu0f5j5nNoWD1GMaFBLzgkyK4A
         XVBscIudjXhtsAuzJ2XEGCW8ZXt1AkvrdgU4z+92RI5T/XpfR2hPlD1AT0mDhkGcZb2D
         l906HsoWX+/zbZmC4MD+LJKVkje31t60MfNxs8rWSBCh2skHAZxZU/fAEq3M2Y7b7yaC
         kVD2bRyCZ7zoE7X2UbAqzP2aVmmYJl3MUSib61JL4BtS9BoMDBt4X90Hl6PEn+KMZKXc
         H4Kg==
X-Gm-Message-State: AOAM533pMt9B8FeAvCBKSs+XXxEj6TDZCwG/UsSD3WwICzMfINem6or8
        j8+AAFdZ/AnwjFJpRUGtmkoJv9OtBr1lnw==
X-Google-Smtp-Source: ABdhPJyRP058z246jmUNjWq8wucx1uHsZYLfjJdekeAElr2pD5A1klCMMH2YqAXgzV/brtKz+jwF4A==
X-Received: by 2002:a17:906:5949:: with SMTP id g9mr17773082ejr.356.1619430619985;
        Mon, 26 Apr 2021 02:50:19 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id g11sm776817eje.7.2021.04.26.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 02:50:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [RFC PATCH] staging: unisys: visorhba: Convert module from IDR to XArray
Date:   Mon, 26 Apr 2021 11:50:15 +0200
Message-Id: <20210426095015.18556-1-fmdefrancesco@gmail.com>
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
 .../staging/unisys/visorhba/visorhba_main.c   | 107 +++++++-----------
 1 file changed, 44 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 4455d26f7c96..851e60ab0c46 100644
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
@@ -23,6 +23,8 @@
 #define MAX_PENDING_REQUESTS (MIN_NUMSIGNALS * 2)
 #define VISORHBA_ERROR_COUNT 30
 
+static DEFINE_XARRAY_ALLOC(xa_dtstr);
+
 static struct dentry *visorhba_debugfs_dir;
 
 /* GUIDS for HBA channel type supported by this driver */
@@ -78,12 +80,6 @@ struct visorhba_devdata {
 	unsigned int max_buff_len;
 	int devnum;
 	struct uiscmdrsp *cmdrsp;
-	/*
-	 * allows us to pass int handles back-and-forth between us and
-	 * iovm, instead of raw pointers
-	 */
-	struct idr idr;
-
 	struct dentry *debugfs_dir;
 	struct dentry *debugfs_info;
 };
@@ -183,32 +179,16 @@ static struct uiscmdrsp *get_scsipending_cmdrsp(struct visorhba_devdata *ddata,
 }
 
 /*
- * simple_idr_get - Associate a provided pointer with an int value
- *		    1 <= value <= INT_MAX, and return this int value;
- *		    the pointer value can be obtained later by passing
- *		    this int value to idr_find()
- * @idrtable: The data object maintaining the pointer<-->int mappings
- * @p:	      The pointer value to be remembered
- * @lock:     A spinlock used when exclusive access to idrtable is needed
- *
- * Return: The id number mapped to pointer 'p', 0 on failure
+ * simple_xa_dtstr_get - Store a pointer to xa_dtstr xarray
+ * @id: Pointer to ID
+ * @entry: New entry
  */
-static unsigned int simple_idr_get(struct idr *idrtable, void *p,
-				   spinlock_t *lock)
+static int simple_xa_dtstr_get(u32 *id, void *entry)
 {
-	int id;
-	unsigned long flags;
+	int ret = xa_alloc_irq(&xa_dtstr, id, entry, xa_limit_32b, GFP_NOWAIT);
+	/* TODO: check for and manage errors */
 
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
+	return ret;
 }
 
 /*
@@ -216,22 +196,25 @@ static unsigned int simple_idr_get(struct idr *idrtable, void *p,
  *				completion processing logic for a taskmgmt
  *				cmd will be able to find who to wake up
  *				and where to stash the result
- * @idrtable: The data object maintaining the pointer<-->int mappings
- * @lock:     A spinlock used when exclusive access to idrtable is needed
+ * @xa_dtstr: The data object maintaining the pointer<-->int mappings
  * @cmdrsp:   Response from the IOVM
  * @event:    The event handle to associate with an id
  * @result:   The location to place the result of the event handle into
  */
-static void setup_scsitaskmgmt_handles(struct idr *idrtable, spinlock_t *lock,
-				       struct uiscmdrsp *cmdrsp,
-				       wait_queue_head_t *event, int *result)
+static void setup_scsitaskmgmt_handles(struct uiscmdrsp *cmdrsp,
+				       wait_queue_head_t *event, u32 *result)
 {
-	/* specify the event that has to be triggered when this */
-	/* cmd is complete */
-	cmdrsp->scsitaskmgmt.notify_handle =
-		simple_idr_get(idrtable, event, lock);
-	cmdrsp->scsitaskmgmt.notifyresult_handle =
-		simple_idr_get(idrtable, result, lock);
+	void *entry;
+	int ret;
+
+	/* specify the event that has to be triggered when this cmd is complete */
+	entry = &cmdrsp->scsitaskmgmt.notify_handle;
+	ret = simple_xa_dtstr_get(result, entry);
+	/* TODO: Check for and manage errors */
+
+	entry = &cmdrsp->scsitaskmgmt.notifyresult_handle;
+	ret = simple_xa_dtstr_get(result, entry);
+	/* TODO: Check for and manage errors */
 }
 
 /*
@@ -240,13 +223,17 @@ static void setup_scsitaskmgmt_handles(struct idr *idrtable, spinlock_t *lock,
  * @idrtable: The data object maintaining the pointer<-->int mappings
  * @cmdrsp:   Response from the IOVM
  */
-static void cleanup_scsitaskmgmt_handles(struct idr *idrtable,
-					 struct uiscmdrsp *cmdrsp)
+static void cleanup_scsitaskmgmt_handles(struct uiscmdrsp_scsitaskmgmt *scsitaskmgmt)
 {
-	if (cmdrsp->scsitaskmgmt.notify_handle)
-		idr_remove(idrtable, cmdrsp->scsitaskmgmt.notify_handle);
-	if (cmdrsp->scsitaskmgmt.notifyresult_handle)
-		idr_remove(idrtable, cmdrsp->scsitaskmgmt.notifyresult_handle);
+	struct uiscmdrsp *cmdrsp;
+	unsigned long index;
+
+	xa_for_each(&xa_dtstr, index, cmdrsp) {
+		if (&cmdrsp->scsitaskmgmt != scsitaskmgmt)
+			continue;
+		xa_erase(&xa_dtstr, index);
+		kfree(cmdrsp);
+	}
 }
 
 /*
@@ -273,8 +260,7 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
 	if (devdata->serverdown || devdata->serverchangingstate)
 		return FAILED;
 
-	scsicmd_id = add_scsipending_entry(devdata, CMD_SCSITASKMGMT_TYPE,
-					   NULL);
+	scsicmd_id = add_scsipending_entry(devdata, CMD_SCSITASKMGMT_TYPE, NULL);
 	if (scsicmd_id < 0)
 		return FAILED;
 
@@ -284,8 +270,7 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
 
 	/* issue TASK_MGMT_ABORT_TASK */
 	cmdrsp->cmdtype = CMD_SCSITASKMGMT_TYPE;
-	setup_scsitaskmgmt_handles(&devdata->idr, &devdata->privlock, cmdrsp,
-				   &notifyevent, &notifyresult);
+	setup_scsitaskmgmt_handles(cmdrsp, &notifyevent, &notifyresult);
 
 	/* save destination */
 	cmdrsp->scsitaskmgmt.tasktype = tasktype;
@@ -311,14 +296,14 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
 	dev_dbg(&scsidev->sdev_gendev,
 		"visorhba: taskmgmt type=%d success; result=0x%x\n",
 		 tasktype, notifyresult);
-	cleanup_scsitaskmgmt_handles(&devdata->idr, cmdrsp);
+	cleanup_scsitaskmgmt_handles(&cmdrsp->scsitaskmgmt);
 	return SUCCESS;
 
 err_del_scsipending_ent:
 	dev_dbg(&scsidev->sdev_gendev,
 		"visorhba: taskmgmt type=%d not executed\n", tasktype);
 	del_scsipending_ent(devdata, scsicmd_id);
-	cleanup_scsitaskmgmt_handles(&devdata->idr, cmdrsp);
+	cleanup_scsitaskmgmt_handles(&cmdrsp->scsitaskmgmt);
 	return FAILED;
 }
 
@@ -654,13 +639,12 @@ DEFINE_SHOW_ATTRIBUTE(info_debugfs);
  * Service Partition returned the result of the task management
  * command. Wake up anyone waiting for it.
  */
-static void complete_taskmgmt_command(struct idr *idrtable,
-				      struct uiscmdrsp *cmdrsp, int result)
+static void complete_taskmgmt_command(struct uiscmdrsp *cmdrsp, int result)
 {
 	wait_queue_head_t *wq =
-		idr_find(idrtable, cmdrsp->scsitaskmgmt.notify_handle);
+		xa_load(&xa_dtstr, cmdrsp->scsitaskmgmt.notify_handle);
 	int *scsi_result_ptr =
-		idr_find(idrtable, cmdrsp->scsitaskmgmt.notifyresult_handle);
+		xa_load(&xa_dtstr, cmdrsp->scsitaskmgmt.notifyresult_handle);
 	if (unlikely(!(wq && scsi_result_ptr))) {
 		pr_err("visorhba: no completion context; cmd will time out\n");
 		return;
@@ -708,8 +692,7 @@ static void visorhba_serverdown_complete(struct visorhba_devdata *devdata)
 			break;
 		case CMD_SCSITASKMGMT_TYPE:
 			cmdrsp = pendingdel->sent;
-			complete_taskmgmt_command(&devdata->idr, cmdrsp,
-						  TASK_MGMT_FAILED);
+			complete_taskmgmt_command(cmdrsp, TASK_MGMT_FAILED);
 			break;
 		default:
 			break;
@@ -905,7 +888,7 @@ static void drain_queue(struct uiscmdrsp *cmdrsp,
 			if (!del_scsipending_ent(devdata,
 						 cmdrsp->scsitaskmgmt.handle))
 				break;
-			complete_taskmgmt_command(&devdata->idr, cmdrsp,
+			complete_taskmgmt_command(cmdrsp,
 						  cmdrsp->scsitaskmgmt.result);
 		} else if (cmdrsp->cmdtype == CMD_NOTIFYGUEST_TYPE)
 			dev_err_once(&devdata->dev->device,
@@ -1053,8 +1036,6 @@ static int visorhba_probe(struct visor_device *dev)
 	if (err)
 		goto err_debugfs_info;
 
-	idr_init(&devdata->idr);
-
 	devdata->cmdrsp = kmalloc(sizeof(*devdata->cmdrsp), GFP_ATOMIC);
 	visorbus_enable_channel_interrupts(dev);
 
@@ -1096,7 +1077,7 @@ static void visorhba_remove(struct visor_device *dev)
 	scsi_remove_host(scsihost);
 	scsi_host_put(scsihost);
 
-	idr_destroy(&devdata->idr);
+	xa_destroy(&xa_dtstr);
 
 	dev_set_drvdata(&dev->device, NULL);
 	debugfs_remove(devdata->debugfs_info);
-- 
2.31.1


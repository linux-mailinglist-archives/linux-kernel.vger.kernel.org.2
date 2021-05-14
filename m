Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C183804E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhENIMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhENIMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:12:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A92C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:11:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lz27so2152311ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9dPAZszkegBNtMrucOn7e9KAxc/KRgb2m7e/2kEebU=;
        b=qzWLLZ6WaIN0ez5xy543Ee7NOIw40rPMZzmDtK21IkEMrAHsHNTeK21R0JJnvGiu4q
         i0snH6IzTVqmawyBofBFaHC47oUyEU3dhQw1oeZA8ysMg5blN8EwK2nsT9WhzzVtyS94
         ypgfDaLA0+ThKWXd/0T3P1DiBeWhwz3tLWgbuudmU3xMCu49nQidVbA7i8Go5wh/8knB
         HndW6JzhXKVvxZbg5O95253sWVj9/e6lXua2dj5qedFmvnGVQKLRYPNkwmvKUstyLFvQ
         5Az7HezAg6GUTIiCHxn7ZlcFehvZbrHUdpnOTDOrBDkHjd84OT0rRIdQy57x1/w+l3hB
         eLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9dPAZszkegBNtMrucOn7e9KAxc/KRgb2m7e/2kEebU=;
        b=Vi/73Uo29A0zK5jcL2VYdDbkX2Q8kmYgWNemS8Dz0E+saMhH3TuLzx3PxxSImffdKq
         a7Pzn5zS9Z1uyYQJIFVQ69nbnQv+qM6xJifZg3CKZCMkhH0st680H4gBAgiikYlWc1e6
         QEyNGRBrxDGyXcA1zqss0ijvnmsoaEu57zrqs33bfTSvzkxxWFcYe378XmfTbpCfkZCQ
         xaWP7+bv8srkrYSN2boGRZP5FS8ZWvS3pYNrOPW/vkYGmh4viyBj8QXXzY7dlT6bgEA/
         LLIV+BlXXTr6RvZLRM0t55OjgCTdGEQXfsXoQ1Tdx1VqoDW/W+21CGxZ0+bob88z5qUC
         RdoA==
X-Gm-Message-State: AOAM530rtenuKCD2ug8qk/zqcCns3Xzmcb5fnM8NLTQnLSyni2nPdXq5
        6flohXfuplh9QopNKpstBs4=
X-Google-Smtp-Source: ABdhPJz+Z0qHoT/ibzlVolGTOobeuEwhcO3EfRxH7F3wjjTmm68/IDxVZR8eVkQfqxAMGcPfOeqVvQ==
X-Received: by 2002:a17:906:6ace:: with SMTP id q14mr49241033ejs.79.1620979876601;
        Fri, 14 May 2021 01:11:16 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id g16sm3233091ejw.42.2021.05.14.01.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 01:11:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v8 RESEND] staging: unisys: visorhba: Convert module from IDR to XArray
Date:   Fri, 14 May 2021 10:11:11 +0200
Message-Id: <20210514081112.19542-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converted visorhba from IDR to XArray. The abstract data type XArray is
more memory-efficient, parallelizable, and cache friendly. It takes
advantage of RCU to perform lookups without locking. Furthermore, IDR is
deprecated because XArray has a better (cleaner and more consistent)
API.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---

Resubmitting the patch with the addition of "Reviewed-by: 
Dan Carpenter" (thanks, Dan) and because I suspect the S-PAR 
maintainers missed this in the noise. 
I'd appreciate a review by Unisys engineers on this patch. 
Also, I'd appreciate a Matthew Wilcox review as the XArray 
maintainer.

Changes from v7: Removed xa_destroy, since its insertion was due to the
misunderstanding of the reviews on v5. Removed unnecessary 'else'
clauses.
Changes from v6: Added a call to xa_destroy() that I had forgotten.
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

 .../staging/unisys/visorhba/visorhba_main.c   | 101 +++++++-----------
 1 file changed, 41 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 4455d26f7c96..41f8a72a2a95 100644
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
@@ -182,71 +181,48 @@ static struct uiscmdrsp *get_scsipending_cmdrsp(struct visorhba_devdata *ddata,
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
+	cmdrsp->scsitaskmgmt.notify_handle = id;
+	ret = xa_alloc_irq(xa, &id, result, xa_limit_32b, GFP_KERNEL);
+	if (ret) {
+		xa_erase_irq(xa, cmdrsp->scsitaskmgmt.notify_handle);
+		return ret;
+	}
+	cmdrsp->scsitaskmgmt.notifyresult_handle = id;
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
@@ -269,6 +245,7 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
 	int notifyresult = 0xffff;
 	wait_queue_head_t notifyevent;
 	int scsicmd_id;
+	int ret;
 
 	if (devdata->serverdown || devdata->serverchangingstate)
 		return FAILED;
@@ -284,8 +261,14 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
 
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
@@ -311,14 +294,14 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
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
 
@@ -654,13 +637,13 @@ DEFINE_SHOW_ATTRIBUTE(info_debugfs);
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
@@ -708,7 +691,7 @@ static void visorhba_serverdown_complete(struct visorhba_devdata *devdata)
 			break;
 		case CMD_SCSITASKMGMT_TYPE:
 			cmdrsp = pendingdel->sent;
-			complete_taskmgmt_command(&devdata->idr, cmdrsp,
+			complete_taskmgmt_command(&devdata->xa, cmdrsp,
 						  TASK_MGMT_FAILED);
 			break;
 		default:
@@ -905,7 +888,7 @@ static void drain_queue(struct uiscmdrsp *cmdrsp,
 			if (!del_scsipending_ent(devdata,
 						 cmdrsp->scsitaskmgmt.handle))
 				break;
-			complete_taskmgmt_command(&devdata->idr, cmdrsp,
+			complete_taskmgmt_command(&devdata->xa, cmdrsp,
 						  cmdrsp->scsitaskmgmt.result);
 		} else if (cmdrsp->cmdtype == CMD_NOTIFYGUEST_TYPE)
 			dev_err_once(&devdata->dev->device,
@@ -1053,7 +1036,7 @@ static int visorhba_probe(struct visor_device *dev)
 	if (err)
 		goto err_debugfs_info;
 
-	idr_init(&devdata->idr);
+	xa_init(&devdata->xa);
 
 	devdata->cmdrsp = kmalloc(sizeof(*devdata->cmdrsp), GFP_ATOMIC);
 	visorbus_enable_channel_interrupts(dev);
@@ -1096,8 +1079,6 @@ static void visorhba_remove(struct visor_device *dev)
 	scsi_remove_host(scsihost);
 	scsi_host_put(scsihost);
 
-	idr_destroy(&devdata->idr);
-
 	dev_set_drvdata(&dev->device, NULL);
 	debugfs_remove(devdata->debugfs_info);
 	debugfs_remove_recursive(devdata->debugfs_dir);
-- 
2.31.1


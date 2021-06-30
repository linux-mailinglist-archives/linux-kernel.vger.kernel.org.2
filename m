Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA13B8A4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 00:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhF3WDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 18:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhF3WDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:03:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F70C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:00:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t17so7985494lfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=rLExLdIz+idyut4neFBwQhY2RXoZ3u7nwVGRjI72EeM=;
        b=p1RkDoamZTami3o0Jcdt/Wdlnftmy4lOr2CYQGJicjRwkXh3yLB+QZdfWPmOQy+BWa
         xaVf54Rv3CAJgT3rZMfPqwz7yQr/2ocdIG4nIH6RajfjQxkBqgvhVFrsIyicFoRLz7td
         6dYtsnsburISb7ZbvN+q/Ktb0lqa8ViDMyz2Do3RMWf5vRS75csFdWc9EH0N9TCd4uSY
         vp/LeYlvGv1vVZ5rMQrrjeN5MhNQKcSO3/IhQV52lnNjvebPq1ZHabCK8p0adp3PRoKf
         65/DK6N05rlwJDeUmoyNFUv4ND08VWLZUV01KswK9+cQz55uOQJnApSsUUtBrcXN4+3/
         +Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=rLExLdIz+idyut4neFBwQhY2RXoZ3u7nwVGRjI72EeM=;
        b=A9I3Mv6AfvwmFXlmRMEOFXn0lvUfuoUJGbT3e2X0B+dmEbsVZiAa9H+W504ns9gNNn
         /9pk7f0/R9PEsutyme5+MhFSjUkia/XTOZAR/pHGCFrnT0XHQ0zUJmMmhOR5kSU6XfaB
         FQL2slarOSJVgoIiOkMzRXajAhJkoUD0vliCGN3gR27Ruj2+gOOb7mRUcX1foiWwNE8l
         g7Jwx9hltn2sPD5ZXkAV3n1DFqVjzdaZqxq42wI3f7S7xZh55Kx1MLPf05+X+fBD8sXi
         9ufYv94/CvaNE/x5abOPg5RVmpOj7jcLlw7FoRbvhc5k2+wdMwUml6s3F28UkBc8Yr77
         oM/w==
X-Gm-Message-State: AOAM532Ak7nD/VPmzgCR/EO81XACpESa8LP4FmLg/GMN+uQ258HYAhV8
        P5Tmi0PxR9jbiQYM7P4567A=
X-Google-Smtp-Source: ABdhPJw8v7FZt1tjn7C0knDDy5LrvNYrZX8GiTj/q66YFQ8DT9WaKMvl7KxpV5LqJeYQkr5cPycWTg==
X-Received: by 2002:ac2:4288:: with SMTP id m8mr10106090lfh.461.1625090435552;
        Wed, 30 Jun 2021 15:00:35 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.155])
        by smtp.gmail.com with ESMTPSA id r15sm2350773ljh.39.2021.06.30.15.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 15:00:35 -0700 (PDT)
Date:   Thu, 1 Jul 2021 01:00:32 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com>
Cc:     alex.dewar90@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        hdanton@sina.com, jhansen@vmware.com, linux-kernel@vger.kernel.org,
        snovitoll@gmail.com, syzkaller-bugs@googlegroups.com,
        vdasa@vmware.com
Subject: Re: [syzbot] possible deadlock in vmci_qp_broker_detach
Message-ID: <20210701010032.4046a863@gmail.com>
In-Reply-To: <00000000000017d93605c602cafd@google.com>
References: <20210701003616.7c4c7c9c@gmail.com>
        <00000000000017d93605c602cafd@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/Lh44SGh/UM9vh2l2eij6heF"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/Lh44SGh/UM9vh2l2eij6heF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 30 Jun 2021 14:56:06 -0700
syzbot <syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still
> triggering an issue: INFO: task hung in vmci_ctx_destroy
> 
> INFO: task syz-executor.4:4967 blocked for more than 143 seconds.
>       Tainted: G        W         5.13.0-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message. task:syz-executor.4  state:D stack:29136 pid: 4967 ppid:
> 8823 flags:0x00004004 Call Trace:

Hmm, I forgot to change old vmci_ctx_put() in
vmci_ctx_enqueue_datagram()...


#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


With regards,
Pavel Skripkin

--MP_/Lh44SGh/UM9vh2l2eij6heF
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-misc-vmv_vmci-fix-deadlock.patch

From 098680ce114e3f0aabdda0b87e8a0a52c9ebb7cc Mon Sep 17 00:00:00 2001
From: Pavel Skripkin <paskripkin@gmail.com>
Date: Thu, 1 Jul 2021 00:30:29 +0300
Subject: [PATCH] misc: vmv_vmci: fix deadlock

Ugly patch just to test general idea...

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_context.c | 39 +++++++++++++++++++++++++---
 drivers/misc/vmw_vmci/vmci_context.h |  4 +++
 drivers/misc/vmw_vmci/vmci_host.c    |  2 +-
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index 26ff49fdf0f7..8cbb2eae01d3 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -113,6 +113,8 @@ struct vmci_ctx *vmci_ctx_create(u32 cid, u32 priv_flags,
 
 	kref_init(&context->kref);
 	spin_lock_init(&context->lock);
+	atomic_set(&context->no_destroy, 0);
+	init_waitqueue_head(&context->destroy_wait);
 	INIT_LIST_HEAD(&context->list_item);
 	INIT_LIST_HEAD(&context->datagram_queue);
 	INIT_LIST_HEAD(&context->notifier_list);
@@ -192,6 +194,7 @@ void vmci_ctx_destroy(struct vmci_ctx *context)
 	spin_unlock(&ctx_list.lock);
 	synchronize_rcu();
 
+	wait_event(context->destroy_wait, !atomic_read(&context->no_destroy));
 	vmci_ctx_put(context);
 }
 
@@ -307,7 +310,7 @@ int vmci_ctx_enqueue_datagram(u32 cid, struct vmci_datagram *dg)
 	}
 
 	/* Get the target VM's VMCI context. */
-	context = vmci_ctx_get(cid);
+	context = vmci_ctx_get_no_destroy(cid);
 	if (!context) {
 		pr_devel("Invalid context (ID=0x%x)\n", cid);
 		return VMCI_ERROR_INVALID_ARGS;
@@ -345,7 +348,7 @@ int vmci_ctx_enqueue_datagram(u32 cid, struct vmci_datagram *dg)
 	     context->datagram_queue_size + vmci_dg_size >=
 	     VMCI_MAX_DATAGRAM_AND_EVENT_QUEUE_SIZE)) {
 		spin_unlock(&context->lock);
-		vmci_ctx_put(context);
+		vmci_ctx_put_allow_destroy(context);
 		kfree(dq_entry);
 		pr_devel("Context (ID=0x%x) receive queue is full\n", cid);
 		return VMCI_ERROR_NO_RESOURCES;
@@ -357,7 +360,7 @@ int vmci_ctx_enqueue_datagram(u32 cid, struct vmci_datagram *dg)
 	ctx_signal_notify(context);
 	wake_up(&context->host_context.wait_queue);
 	spin_unlock(&context->lock);
-	vmci_ctx_put(context);
+	vmci_ctx_put_allow_destroy(context);
 
 	return vmci_dg_size;
 }
@@ -416,6 +419,30 @@ struct vmci_ctx *vmci_ctx_get(u32 cid)
 	return context;
 }
 
+/*
+ * Retrieves VMCI context corresponding to the given cid.
+ */
+struct vmci_ctx *vmci_ctx_get_no_destroy(u32 cid)
+{
+	struct vmci_ctx *c, *context = NULL;
+
+	if (cid == VMCI_INVALID_ID)
+		return NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(c, &ctx_list.head, list_item) {
+		if (c->cid == cid) {
+			context = c;
+			atomic_set(&context->no_destroy, 1);
+			kref_get(&context->kref);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return context;
+}
+
 /*
  * Deallocates all parts of a context data structure. This
  * function doesn't lock the context, because it assumes that
@@ -497,6 +524,12 @@ void vmci_ctx_put(struct vmci_ctx *context)
 	kref_put(&context->kref, ctx_free_ctx);
 }
 
+void vmci_ctx_put_allow_destroy(struct vmci_ctx *context)
+{
+	kref_put(&context->kref, ctx_free_ctx);
+	atomic_set(&context->no_destroy, 0);
+}
+
 /*
  * Dequeues the next datagram and returns it to caller.
  * The caller passes in a pointer to the max size datagram
diff --git a/drivers/misc/vmw_vmci/vmci_context.h b/drivers/misc/vmw_vmci/vmci_context.h
index 4db8701c9781..a3d711e11581 100644
--- a/drivers/misc/vmw_vmci/vmci_context.h
+++ b/drivers/misc/vmw_vmci/vmci_context.h
@@ -51,6 +51,8 @@ struct vmci_ctx {
 	 */
 	int user_version;
 	spinlock_t lock;  /* Locks callQueue and handle_arrays. */
+	atomic_t no_destroy;  /* Locks callQueue and handle_arrays. */
+	wait_queue_head_t destroy_wait;
 
 	/*
 	 * queue_pairs attached to.  The array of
@@ -134,7 +136,9 @@ int vmci_ctx_dequeue_datagram(struct vmci_ctx *context,
 			      size_t *max_size, struct vmci_datagram **dg);
 int vmci_ctx_pending_datagrams(u32 cid, u32 *pending);
 struct vmci_ctx *vmci_ctx_get(u32 cid);
+struct vmci_ctx *vmci_ctx_get_no_destroy(u32 cid);
 void vmci_ctx_put(struct vmci_ctx *context);
+void vmci_ctx_put_allow_destroy(struct vmci_ctx *context);
 bool vmci_ctx_exists(u32 cid);
 
 int vmci_ctx_add_notification(u32 context_id, u32 remote_cid);
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index da1e2a773823..eedbe042a9ca 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -139,6 +139,7 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
 {
 	struct vmci_host_dev *vmci_host_dev = filp->private_data;
 
+	filp->private_data = NULL;
 	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
 		vmci_ctx_destroy(vmci_host_dev->context);
 		vmci_host_dev->context = NULL;
@@ -154,7 +155,6 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
 	vmci_host_dev->ct_type = VMCIOBJ_NOT_SET;
 
 	kfree(vmci_host_dev);
-	filp->private_data = NULL;
 	return 0;
 }
 
-- 
2.32.0


--MP_/Lh44SGh/UM9vh2l2eij6heF--

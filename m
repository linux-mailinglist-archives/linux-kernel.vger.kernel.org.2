Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B023E3B8A22
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 23:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhF3Vix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 17:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhF3Viw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 17:38:52 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04122C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 14:36:21 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id k8so5321514lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=YJ4Yxvy7JuX+eNWPkLZaSJ32fNjn5lHKD8YdXLd4aYY=;
        b=dRJlEZymEqgXQLPYgXPW23bA2ZczanFx4RMl1i927pGppxIoJ723kgC+/d1KBCOMes
         70x8RgkRTXrFpB+xrxEr4a9ffdSIPSu2a2WIA4xntP0Eh2l5QkznV5Mw0u8xUzZGIUby
         Av72yrRTp++Pnu05g8FUpHXewZmzDlsnMHCReaOhIl3fUyABZYHcWwSj5DUx+WcR0pnG
         To3SR8GyYX0XiKb6H7NRQT+5XEhHw86TSvIFxfgaV7zblrnIEp8TFIwC2gFa+1ff09+0
         cq72V0Li1Z/0yS9M8BGaGeWLUFPZVv72wWStrrW5itt1G9fddIl+FEfBN+89BSllyAJo
         PtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=YJ4Yxvy7JuX+eNWPkLZaSJ32fNjn5lHKD8YdXLd4aYY=;
        b=qDd3y/uq4rtysisJoezMkC2Bd3UhepB3ZQsj4DN7vrLbQ4+ceslWEi7VhMx/cogKC6
         HvMBo6i5ipupdjT/J6ERskxpkfj2qo2Mqfwbu461xBfqE5gF8OD6HCDSRV3QfGrGaQYZ
         Ii1YPySSnIAgBIfMsQ8Y6oVh77uMkYIOTjGqoXHq6+NSghTmO6RwkyWTUn2wdN7g2Trh
         V6YhutgxtV7huubfWzXw1qUYtDUwS0t85HwxMzSJe2jljhsZZwmzz1qIy0S/Y/wgUxfQ
         rCMsPBU3LmUzr1tZPcGzp57MbfVmQJQ30pgFh/oVT5is47a6NTm8DMOKBPAygufwyd9J
         EHdA==
X-Gm-Message-State: AOAM532AdIhVGG/uDrKvSh61KE92svITAd2SnW1smArJhLDEdaoeADCK
        U12TtO2Yyi3KSylqNzoH5/A=
X-Google-Smtp-Source: ABdhPJwXMPN3Z5vCzlV/jrkko9QlPoz3fhqU44MMhWdQvceFEEdkTpVWU2K+TPBk1F+UdCXEj6d+TQ==
X-Received: by 2002:a2e:380b:: with SMTP id f11mr9582343lja.358.1625088980268;
        Wed, 30 Jun 2021 14:36:20 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.155])
        by smtp.gmail.com with ESMTPSA id q4sm2350183ljh.13.2021.06.30.14.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 14:36:19 -0700 (PDT)
Date:   Thu, 1 Jul 2021 00:36:16 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com>
Cc:     alex.dewar90@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        hdanton@sina.com, jhansen@vmware.com, linux-kernel@vger.kernel.org,
        snovitoll@gmail.com, syzkaller-bugs@googlegroups.com,
        vdasa@vmware.com
Subject: Re: [syzbot] possible deadlock in vmci_qp_broker_detach
Message-ID: <20210701003616.7c4c7c9c@gmail.com>
In-Reply-To: <000000000000d05b3805c5fef3ca@google.com>
References: <00000000000002b41905be665238@google.com>
        <000000000000d05b3805c5fef3ca@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/yM9HHUDJYC_j+z4St+rdJBN"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/yM9HHUDJYC_j+z4St+rdJBN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 30 Jun 2021 10:21:26 -0700
syzbot <syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    a1f92694 Add linux-next specific files for 20210518
> git tree:       linux-next
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=14cf5118300000 kernel
> config:  https://syzkaller.appspot.com/x/.config?x=d612e75ffd53a6d3
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=44e40ac2cfe68e8ce207 syz
> repro:
> https://syzkaller.appspot.com/x/repro.syz?x=15dae18c300000 C
> reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c680e2300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit: Reported-by:
> syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com
> 
> ============================================
> WARNING: possible recursive locking detected
> 5.13.0-rc2-next-20210518-syzkaller #0 Not tainted
> --------------------------------------------
> syz-executor723/9333 is trying to acquire lock:
> ffffffff8cc8b5f8 (qp_broker_list.mutex){+.+.}-{3:3}, at:
> vmci_qp_broker_detach+0x147/0x11b0
> drivers/misc/vmw_vmci/vmci_queue_pair.c:2093
> 
> but task is already holding lock:
> ffffffff8cc8b5f8 (qp_broker_list.mutex){+.+.}-{3:3}, at:
> vmci_qp_broker_detach+0x147/0x11b0
> drivers/misc/vmw_vmci/vmci_queue_pair.c:2093
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(qp_broker_list.mutex);
>   lock(qp_broker_list.mutex);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 1 lock held by syz-executor723/9333:
>  #0: ffffffff8cc8b5f8 (qp_broker_list.mutex){+.+.}-{3:3}, at:
> vmci_qp_broker_detach+0x147/0x11b0
> drivers/misc/vmw_vmci/vmci_queue_pair.c:2093


Very ugly patch just to test the idea:

vmci_ctx_put() in vmci_ctx_enqueue_datagram() should not be the last 
vmci_ctx_put() in context life, so we need to block vmci_ctx_destroy() until
vmci_ctx_enqueue_datagram() is done.

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master



With regards,
Pavel Skripkin

--MP_/yM9HHUDJYC_j+z4St+rdJBN
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-misc-vmv_vmci-fix-deadlock.patch

From f333b8eb156e1d499ff68463c20eae72bbf90e4f Mon Sep 17 00:00:00 2001
From: Pavel Skripkin <paskripkin@gmail.com>
Date: Thu, 1 Jul 2021 00:30:29 +0300
Subject: [PATCH] misc: vmv_vmci: fix deadlock

Ugly patch just to test general idea...

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_context.c | 37 ++++++++++++++++++++++++++--
 drivers/misc/vmw_vmci/vmci_context.h |  4 +++
 drivers/misc/vmw_vmci/vmci_host.c    |  2 +-
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index 26ff49fdf0f7..e17ef7335112 100644
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


--MP_/yM9HHUDJYC_j+z4St+rdJBN--

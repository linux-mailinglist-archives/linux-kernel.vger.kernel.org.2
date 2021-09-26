Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE3418D50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 02:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhI0AjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 20:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhI0AjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 20:39:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3416C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 17:37:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r7so10625526pjo.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 17:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZA8HS1ivZg91Ke/y1Kgrf08VWpYbEytVu6rjydTPJL8=;
        b=KkRXvfr5yUVD7EXZ1b8SudB7kjuBVYemqMEsFXA6Xu4K2gvSmOnJYzi64fbEe/4BKD
         amkcSM/XUjEkDPjr9RdpAB4MVUEIITrA+d8Y9rgpSADvqSmt8wWxG1gfBSUiURrvtcWL
         cJ/3lRzcZ/S9cnrZMQiDXguDeZyI0GIHwh2b7p4A+2cE6cGPFuVD7hw7+JeCfliKrs+O
         ssLdCXKBcvk7zbLaW8jhv39Ez5rRHiWOb31TjTjEhcQSJR+GZwWgy5CfyEc5ZBPHnsMc
         6v//1Ld+59hh2xQngljolo5ovJFLGPc/FqnkdDI4/BwZFMnYk+LMgbwIYuPHKQRQSrNl
         rQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZA8HS1ivZg91Ke/y1Kgrf08VWpYbEytVu6rjydTPJL8=;
        b=ZWwuYSCcyiihLtVlAuLDQtVVnaDoutMVxHz0fcGnLpkZec3uyLQ8QbyqNJppRnfit+
         tNkRwZsHmyl51QgdyGb9zRZ4bMDbx9z38EXf7EO5IpyUdP8Bb8zjQebJPLThVjYz43a/
         gwQx7KgP8Ks/WiOGG3Eoa3wMnrjmJhMtGaR4YA1+SIjkOO9wAwubQUiaO/PElsCpCJx+
         tq4xvjtG/nzuHmYyL4VN95MVUGNIg8Wr0DciEMmrT3BcdkfwYdYsSF3ofk16n0KICy3e
         HJAHm0zfrJYzUsXUBc6e3XLwqhVenpqybf6OQRDLPbF/GSLGQs9ieEAu+4x2xNA8Z9F0
         Gjfg==
X-Gm-Message-State: AOAM531ptrr/f5E1fRL+t041PaVobuIT7u9eMbWftvHkaE+OCnWUug0x
        PRZfVykdJB8etYer2Owcqr0vHD5mp7o=
X-Google-Smtp-Source: ABdhPJzvkzM/By793UAtTLXntevGRAwBN2++gpIagGa2o4rNumDxFnwr2T6EBQxFv3+CbRgOkpT9PQ==
X-Received: by 2002:a17:90a:c982:: with SMTP id w2mr16299956pjt.30.1632703059970;
        Sun, 26 Sep 2021 17:37:39 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i15sm16445277pgo.4.2021.09.26.17.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:37:39 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>
Subject: [RFC PATCH] userfaultfd: support control over mm of remote PIDs
Date:   Sun, 26 Sep 2021 10:06:37 -0700
Message-Id: <20210926170637.245699-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Non-cooperative mode is useful but only for forked processes.
Userfaultfd can be useful to monitor, debug and manage memory of remote
processes.

To support this mode, add a new flag, UFFD_REMOTE_PID, and an optional
second argument to the userfaultfd syscall. When the flag is set, the
second argument is assumed to be the PID of the process that is to be
monitored. Otherwise the flag is ignored.

The syscall enforces that the caller has CAP_SYS_PTRACE to prevent
misuse of this feature.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>

---

I know that I have an RFC regarding the use of iouring with userfaultfd.
I do intend to follow this RFC as well, but it requires some more work.
---
 fs/userfaultfd.c | 71 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 003f0d31743e..cf44e1e13a03 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2053,10 +2053,39 @@ static void init_once_userfaultfd_ctx(void *mem)
 	seqcount_spinlock_init(&ctx->refile_seq, &ctx->fault_pending_wqh.lock);
 }
 
-SYSCALL_DEFINE1(userfaultfd, int, flags)
+static int userfaultfd_get_remote_mm(struct userfaultfd_ctx *ctx, int pidfd)
 {
-	struct userfaultfd_ctx *ctx;
-	int fd;
+	struct task_struct *task;
+	struct pid *pid;
+	struct fd f;
+	int ret;
+
+	f = fdget(pidfd);
+	if (!f.file)
+		return -EBADF;
+
+	pid = pidfd_pid(f.file);
+
+	task = get_pid_task(pid, PIDTYPE_PID);
+	ret = -ESRCH;
+	if (!task)
+		goto err_out;
+
+	ctx->mm = task->mm;
+	mmgrab(ctx->mm);
+	put_task_struct(task);
+	ret = 0;
+out:
+	return ret;
+err_out:
+	fdput(f);
+	goto out;
+}
+
+SYSCALL_DEFINE2(userfaultfd, int, flags, int, pidfd)
+{
+	struct userfaultfd_ctx *ctx = NULL;
+	int ret;
 
 	if (!sysctl_unprivileged_userfaultfd &&
 	    (flags & UFFD_USER_MODE_ONLY) == 0 &&
@@ -2067,14 +2096,19 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 		return -EPERM;
 	}
 
+	if ((flags & UFFD_REMOTE_PID) && !capable(CAP_SYS_PTRACE))
+		return -EPERM;
+
 	BUG_ON(!current->mm);
 
 	/* Check the UFFD_* constants for consistency.  */
+	BUILD_BUG_ON(UFFD_REMOTE_PID & UFFD_SHARED_FCNTL_FLAGS);
 	BUILD_BUG_ON(UFFD_USER_MODE_ONLY & UFFD_SHARED_FCNTL_FLAGS);
 	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
 
-	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | UFFD_USER_MODE_ONLY))
+	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | UFFD_USER_MODE_ONLY |
+		      UFFD_REMOTE_PID))
 		return -EINVAL;
 
 	ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
@@ -2086,17 +2120,30 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	ctx->features = 0;
 	ctx->released = false;
 	atomic_set(&ctx->mmap_changing, 0);
-	ctx->mm = current->mm;
-	/* prevent the mm struct to be freed */
-	mmgrab(ctx->mm);
+	ctx->mm = NULL;
+
+	if (flags & UFFD_REMOTE_PID) {
+		/* the remote mm is grabbed by the following call */
+		ret = userfaultfd_get_remote_mm(ctx, pidfd);
+		if (ret)
+			goto err_out;
+	} else {
+		ctx->mm = current->mm;
+		/* prevent the mm struct to be freed */
+		mmgrab(ctx->mm);
+	}
 
-	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
+	ret = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
 			O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
-	if (fd < 0) {
+	if (ret < 0)
+		goto err_out;
+out:
+	return ret;
+err_out:
+	if (ctx->mm)
 		mmdrop(ctx->mm);
-		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-	}
-	return fd;
+	kmem_cache_free(userfaultfd_ctx_cachep, ctx);
+	goto out;
 }
 
 static int __init userfaultfd_init(void)
-- 
2.25.1


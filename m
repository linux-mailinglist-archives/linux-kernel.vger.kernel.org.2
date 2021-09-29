Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0C41C3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbhI2LxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245266AbhI2Lw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:52:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712BAC061760
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m26so1763076pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hItkjKaxg4Uh2f64bMlyPxgrZcRDpiWgCRGOxnSrprQ=;
        b=FtLWKYuDhpunrKnFXsXBREVmHtlWWgxTNGwGJSvV3L3rSeUh4kx7MQiwiNErW8kuYn
         pF5z0iU0zfASnNwj1Q6H3bXnoE7vgcTrUyWo5qaIDKxRCC36UHH6UDwS9A34LlbQ7Va+
         Rtdlet8cNM/yA7IxNmL0jGr0W7dBgni+sNh8gR6K52YMcxLS3LLLKurJnkh7S6+7WR2V
         Q3nuM2Hfdz/O2TqHWFRFKotR8jMKamWvDvnS1dpCj2C6JAslpjEXqtClXaPbj4GFCr/8
         PGYkCEeW0vNLjaPkIR9oBkAseZgCZ5x15BZjSYAR2Y985JldRfNaKo/BT0Eg76EDG1M+
         H57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hItkjKaxg4Uh2f64bMlyPxgrZcRDpiWgCRGOxnSrprQ=;
        b=rro5du4QoKtDRm/tHYw9K8eoi6gvuWHNf8fKEqBBAMg3X/IWnwQYwwPzFZz5DusBDN
         MAaV5Ixnkmxu94LGBrGcHug7EInDhzgaJJdQZ95BqxsWZJg7+SEWmpBWZxb5HAX6ohVF
         MPsuHEWNEeOhjDJVguV26Ip4opdiPL03jYGRJr60ro8jPmYb+gnItewkaje5bOCvAh87
         VZbUM4qkxcdR4ETTuZLeFUqtUvS5uwHzGxcIzP9LctljbcjKzhpCAWAMPOK6pxRnQtl5
         QIsujFu6z/yep0YloAUy649QdOZM1SJn9eq4owjHr27L+PSnRXTa2hGF7nlRnaY/zR+o
         iVWw==
X-Gm-Message-State: AOAM530ST6+skOwIihVltaLCQipGVI6csMgnw2Go41igt7c1CclMAJ0b
        rnN83OgJ8lEb2JbvrQQoG/I=
X-Google-Smtp-Source: ABdhPJzar4gSruPebWaUw1CGk1TqMuz8q98Im8OxbXEGGA5/ZAtb7uDelt0ZG/XGANoOl2j4KFxUAw==
X-Received: by 2002:a63:2c8f:: with SMTP id s137mr9134656pgs.115.1632916278045;
        Wed, 29 Sep 2021 04:51:18 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id u12sm2403204pgi.21.2021.09.29.04.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 04:51:17 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, viro@zeniv.linux.org.uk,
        christian@brauner.io, dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 4/5] kernel: increase the size of kthread's comm
Date:   Wed, 29 Sep 2021 11:50:35 +0000
Message-Id: <20210929115036.4851-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210929115036.4851-1-laoar.shao@gmail.com>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the kthreads' comm are trucated due to the limitation of
TASK_COMM_LEN, for example,

  rcu_tasks_kthre
  rcu_tasks_rude_
  rcu_tasks_trace
  ecryptfs-kthrea
  vfio-irqfd-clea
  ext4-rsv-conver
  jbd2/nvme0n1p2-
  ...

Besides the in-tree kthreads listed above, the out-of-tree kthreads may
also be trucated, for example,

  rtase_work_queu
  nvidia-modeset/
  UVM global queu
  UVM deferred re
  ...

That is not expected by the author of these kthreads.

This patch increases the size of ktread's comm from 16 to 24, which is
the same with workqueue's, to improve this situation. After this cahnge,
the name of kthread can be fully displayed in /proc/[pid]/comm,
for example,

  rcu_tasks_kthread
  rcu_tasks_rude_kthread
  rcu_tasks_trace_kthread
  ecryptfs-kthread
  vfio-irqfd-cleanup
  ext4-rsv-conversion
  jbd2/nvme0n1p2-8
  ...

Because there're only a few of kthreads, so it won't increase too much
memory.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/exec.c             | 5 ++++-
 include/linux/sched.h | 2 ++
 kernel/fork.c         | 9 ++++++++-
 kernel/kthread.c      | 2 +-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 021c9dc727bc..4bf0501b7766 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1222,9 +1222,12 @@ EXPORT_SYMBOL_GPL(__get_task_comm);
 
 void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 {
+	size_t size;
+
 	task_lock(tsk);
 	trace_task_rename(tsk, buf);
-	strscpy(tsk->comm, buf, TASK_COMM_LEN);
+	size = tsk->flags & PF_KTHREAD ? KTHREAD_COMM_LEN : TASK_COMM_LEN;
+	strscpy(tsk->comm, buf, size);
 	task_unlock(tsk);
 	perf_event_comm(tsk, exec);
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 959eaef248fc..6b336eba4ff6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -276,6 +276,8 @@ struct task_group;
 
 /* Task command name length: */
 #define TASK_COMM_LEN			16
+/* KTHREAD_COMM_LEN must be >= TASK_COMM_LEN */
+#define KTHREAD_COMM_LEN		24
 
 extern void scheduler_tick(void);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 227aec240501..a2939353383d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -723,7 +723,14 @@ static void mmdrop_async(struct mm_struct *mm)
 
 static int task_comm_alloc(struct task_struct *p)
 {
-	p->comm = kzalloc(TASK_COMM_LEN, GFP_KERNEL);
+	size_t size;
+
+	/*
+	 * PF_KTHREAD may be cleared in exec, but the allocated memory can
+	 * be safely freed.
+	 */
+	size = p->flags & PF_KTHREAD ? KTHREAD_COMM_LEN : TASK_COMM_LEN;
+	p->comm = kzalloc(size, GFP_KERNEL);
 	if (!p->comm)
 		return -ENOMEM;
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5b37a8567168..6def951c605a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -398,7 +398,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	task = create->result;
 	if (!IS_ERR(task)) {
 		static const struct sched_param param = { .sched_priority = 0 };
-		char name[TASK_COMM_LEN];
+		char name[KTHREAD_COMM_LEN];
 
 		/*
 		 * task is already visible to other tasks, so updating
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D089C3A5099
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 22:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhFLUsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 16:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229753AbhFLUsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 16:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623530798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+9nkcAASg28WXColzX7UZg8LwsE297V2tiWAYMADEZg=;
        b=VDgjytCgxCMmDOX2mMlaZ9gSAAv7drTz/VfAXqumHUf8iaFpM+hRAiYiKYTAFAED4pZLWl
        aD+JE01ZkCfgqz449rvCiciaTOJ/VNkv6fXAZ5pNKy1qtPWQuhaFtpvkjWrN1oHLqldqHS
        L41ixmTbM8uQsfzDWa+lf89dTEcihac=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-jgt2AldOMKqW3GBPmiHvdg-1; Sat, 12 Jun 2021 16:46:37 -0400
X-MC-Unique: jgt2AldOMKqW3GBPmiHvdg-1
Received: by mail-wr1-f69.google.com with SMTP id g14-20020a5d698e0000b0290117735bd4d3so4549344wru.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 13:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+9nkcAASg28WXColzX7UZg8LwsE297V2tiWAYMADEZg=;
        b=bJgDb11o2zQUQLswg5VakHFUMfJ+DgosGi2y3YWar9rDlzCJ55+YlOnt7lqcVPoG/J
         ab3EFRMo6fQZGa2bZv5pv/LqmRyZfbm8OkcbodDtzic1lU3jUTJ0yRkDfvU9wWapTEfd
         BlrwXjpx2dBqMsJ7vT669KC3/KRjKxrJOfqdXaDxTmQEHQua9X+BtmNvJ9Wk6GRQVnfD
         r3Lc8/rCMICnDQnv83TFDJFcfAWIxaAFAyodRSW5ntLh/5kGb4IYWVsP9t6lewTnk29k
         IcZ5Yqcy6Z6H3eK0CPdjVzZrTlBN2/Yb96Os5nEOxQ01nJOQkEf25fZ2sAItjXeNLTxY
         W+KQ==
X-Gm-Message-State: AOAM532LDE5dlt1cyzzLBczR7wM6v3mupiPOLlj2xfMj/I7EGyomKWgQ
        F/jDqhjFvhvMiPy2zAo6qf5nBoyBneakMoTyGiivkiUFJAsmslUxmKZrWXsiO+UMFMS6Mj/O497
        7p8WuehbUUqnK3ezUh8pe+M0=
X-Received: by 2002:a5d:4291:: with SMTP id k17mr10949312wrq.40.1623530796092;
        Sat, 12 Jun 2021 13:46:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2aLWGp0+5W7LeQkPgVCM54EHR6a+rX/1sZm4i4lSirw4qDm8GxATKPZjB3C90aHCUypU1hA==
X-Received: by 2002:a5d:4291:: with SMTP id k17mr10949300wrq.40.1623530795890;
        Sat, 12 Jun 2021 13:46:35 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id g21sm12030748wrb.46.2021.06.12.13.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 13:46:35 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, llong@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/oom_kill: show oom eligibility when displaying the current memory state of all tasks
Date:   Sat, 12 Jun 2021 21:46:34 +0100
Message-Id: <20210612204634.1102472-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
 - Use single character (e.g. 'R' for MMF_OOM_SKIP) as suggested
   by Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
 - Add new header to oom_dump_tasks documentation


At the present time, when showing potential OOM victims, we do not
exclude tasks which already have MMF_OOM_SKIP set; it is possible that
the last OOM killable victim was already OOM killed, yet the OOM
reaper failed to reclaim memory and set MMF_OOM_SKIP.
This can be confusing/or perhaps even misleading, to the reader of the
OOM report. Now, we already unconditionally display a task's
oom_score_adj_min value that can be set to OOM_SCORE_ADJ_MIN which is
indicative of an "unkillable" task i.e. is not eligible.

This patch provides a clear indication with regard to the OOM
eligibility of each displayed task.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 Documentation/admin-guide/sysctl/vm.rst |  5 ++--
 mm/oom_kill.c                           | 31 +++++++++++++++++++++----
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 586cd4b86428..123be642bc7e 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -658,8 +658,9 @@ oom_dump_tasks
 Enables a system-wide task dump (excluding kernel threads) to be produced
 when the kernel performs an OOM-killing and includes such information as
 pid, uid, tgid, vm size, rss, pgtables_bytes, swapents, oom_score_adj
-score, and name.  This is helpful to determine why the OOM killer was
-invoked, to identify the rogue task that caused it, and to determine why
+score, oom eligibility status and name.  This is helpful to determine why
+the OOM killer was invoked, to identify the rogue task that caused it, and
+to determine why
 the OOM killer chose the task it did to kill.
 
 If this is set to zero, this information is suppressed.  On very
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eefd3f5fde46..094b7b61d66f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -160,6 +160,27 @@ static inline bool is_sysrq_oom(struct oom_control *oc)
 	return oc->order == -1;
 }
 
+/**
+ * is_task_eligible_oom - determine if and why a task cannot be OOM killed
+ * @tsk: task to check
+ *
+ * Needs to be called with task_lock().
+ */
+static const char * is_task_oom_eligible(struct task_struct *p)
+{
+	long adj;
+
+	adj = (long)p->signal->oom_score_adj;
+	if (adj == OOM_SCORE_ADJ_MIN)
+		return "S";
+	else if (test_bit(MMF_OOM_SKIP, &p->mm->flags)
+		return "R";
+	else if (in_vfork(p))
+		return "V";
+	else
+		return "";
+}
+
 /* return true if the task is not adequate as candidate victim task. */
 static bool oom_unkillable_task(struct task_struct *p)
 {
@@ -401,12 +422,13 @@ static int dump_task(struct task_struct *p, void *arg)
 		return 0;
 	}
 
-	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
+	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %13s %s\n",
 		task->pid, from_kuid(&init_user_ns, task_uid(task)),
 		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
 		mm_pgtables_bytes(task->mm),
 		get_mm_counter(task->mm, MM_SWAPENTS),
-		task->signal->oom_score_adj, task->comm);
+		task->signal->oom_score_adj, is_task_oom_eligible(task),
+		task->comm);
 	task_unlock(task);
 
 	return 0;
@@ -420,12 +442,13 @@ static int dump_task(struct task_struct *p, void *arg)
  * memcg, not in the same cpuset, or bound to a disjoint set of mempolicy nodes
  * are not shown.
  * State information includes task's pid, uid, tgid, vm size, rss,
- * pgtables_bytes, swapents, oom_score_adj value, and name.
+ * pgtables_bytes, swapents, oom_score_adj value, oom eligibility status
+ * and name.
  */
 static void dump_tasks(struct oom_control *oc)
 {
 	pr_info("Tasks state (memory values in pages):\n");
-	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
+	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj oom eligible? name\n");
 
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
-- 
2.26.3


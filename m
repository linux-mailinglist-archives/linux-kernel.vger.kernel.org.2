Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD533A47CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhFKRVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhFKRVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623431984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LQMTdrZDXFHIZKhVp6aoer1KMD+nKRx3hDZ0SmFf7u8=;
        b=Jopk0Ol4htOGo0wIAf2yh5cG++cCYCG4qfAxFmWB2yM/ToXfvushhTqUCL7MkHd48BDZK3
        rJ6z5YdUgakLrPui+t9Fi8UQE7uuFY+U5Oyo89G3y3A38JyYqmKB8jUOdebKSq7xHjtT7O
        XnsXpwtojV3QuFu5ZgHZbYJJYLh55ZQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-BL3-QtpPMRWWonRV5aB4QA-1; Fri, 11 Jun 2021 13:19:42 -0400
X-MC-Unique: BL3-QtpPMRWWonRV5aB4QA-1
Received: by mail-wr1-f70.google.com with SMTP id e9-20020a5d6d090000b0290119e91be97dso2946305wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQMTdrZDXFHIZKhVp6aoer1KMD+nKRx3hDZ0SmFf7u8=;
        b=rE2+B0JZkg/ELoxj8ce/NKvTpo3Ve5P1+4GFhsqTyyUmMmtrWspMGRLPU00WdwryMf
         g1jR83ru3KQSL5YwperpXqxKXwpAaiz6ZMGBeqC4dDhQFxe0CdlRrxyQZj0DpB9sDM31
         SzWPoczIt/lGcboYSEt/59x1ARAIXlfBx2SHrlegruc17OrntJ8m0fObP69AcvnvgsBf
         V9uFg4iTADlJtxPAE/tLTCFt1R4/RZ52cqb7mznxZkCl9C8AUsqClZCs1wFakHndirrW
         6VuGZ7x4ak+8qqaElYSb3c/CkfT5r5ZLearbTAF9USG7vhQotkRh4+NgTqhruQ90BL5v
         tVxg==
X-Gm-Message-State: AOAM533ky8PSZTeJoce2fowabsd16AU8znA7T1MZbiUNRakfiYZfjtMo
        MTXd7nohJkWnuCkugNvcEUq2yJhf6P3SyPbjqXyioXcg9vKpZ3fwjVHLs0w4dI/r64jI13kb/Xx
        X9YYArfEH2iqRpzMzkB2trqU=
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr5330807wrt.124.1623431981588;
        Fri, 11 Jun 2021 10:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOuJlp6OjAomJZ5hmpGIriVy58AXB6nudYEJxJgtGTzxeOibi/0KVJxoiETY9l4oZHLLJkJQ==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr5330796wrt.124.1623431981413;
        Fri, 11 Jun 2021 10:19:41 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id d131sm13144458wmd.4.2021.06.11.10.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:19:41 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, llong@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm/oom_kill: show oom eligibility when displaying the current memory state of all tasks
Date:   Fri, 11 Jun 2021 18:19:40 +0100
Message-Id: <20210611171940.960887-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 mm/oom_kill.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eefd3f5fde46..70781d681a6e 100644
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
+		return "no: oom score";
+	else if (test_bit(MMF_OOM_SKIP, &p->mm->flags)
+		return "no: oom reaped";
+	else if (in_vfork(p))
+		return "no: in vfork";
+	else
+		return "yes";
+}
+
 /* return true if the task is not adequate as candidate victim task. */
 static bool oom_unkillable_task(struct task_struct *p)
 {
@@ -401,12 +422,13 @@ static int dump_task(struct task_struct *p, void *arg)
 		return 0;
 	}
 
-	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
+	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %-15s %s\n",
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
+ * pgtables_bytes, swapents, oom_score_adj value, oom eligible status
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B550A3C2330
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 13:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGIL5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 07:57:42 -0400
Received: from mail-m121145.qiye.163.com ([115.236.121.145]:24056 "EHLO
        mail-m121145.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhGIL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 07:57:41 -0400
DKIM-Signature: a=rsa-sha256;
        b=TO35Znobx+zrBkl0UMTUikbg7mG+7QaDHdbOnNa+uUYJS/BP70jyBrSmJcWi/TuvP9p+927BzUUZ3H8PxCtGBBKWqfBfbPkczqKH26bdvXAmtB0+iQOY8ErjDdHkb6514hZWDWch9Doi0JJUahc48EBfVoBkzi69IsUVhj1LxV0=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=T4xMGc7me59KwIsmnVHeeSdisgp1gMZdDkVw03/tF6k=;
        h=date:mime-version:subject:message-id:from;
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 889EF800311;
        Fri,  9 Jul 2021 19:54:55 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH v2] kernel/sched/core: Print the time when the process entered the D state
Date:   Fri,  9 Jul 2021 04:54:49 -0700
Message-Id: <1625831689-122629-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUseGVZPT08YQktDGU4eTk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mwg6FDo4HT8DLhIeHjcjIk4f
        KxgwCy5VSlVKTUlOQ0hKTUJNSk1LVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlOS0I3Bg++
X-HM-Tid: 0a7a8b1ee5efb03akuuu889ef800311
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we need to trigger /proc/sysrq-trigger to view the information
of the D state process in the system.
e.g:
echo w > /proc/sysrq-trigger

Here we print the scheduling time of the process, which is convenient
for us to judge the state of the system and for debugging.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 kernel/sched/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf16f8f..ab422ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8154,10 +8154,12 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
+	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx",
 		free, task_pid_nr(p), ppid,
 		(unsigned long)task_thread_info(p)->flags);
-
+#ifdef CONFIG_SCHED_INFO
+	pr_cont(" sched:%llu\n", p->sched_info.last_arrival);
+#endif
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
 	show_stack(p, NULL, KERN_INFO);
-- 
2.7.4


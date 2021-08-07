Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1893E3461
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhHGJjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:39:43 -0400
Received: from mail-m17655.qiye.163.com ([59.111.176.55]:22044 "EHLO
        mail-m17655.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhHGJjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:39:42 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17655.qiye.163.com (Hmail) with ESMTPA id C1C7A400C1;
        Sat,  7 Aug 2021 17:39:21 +0800 (CST)
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
Subject: [PATCH] sched/core: Prints the schedule time of the process
Date:   Sat,  7 Aug 2021 02:39:12 -0700
Message-Id: <1628329152-97413-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRoaQ0NWHx9MSh1CQxpLTh
        hNVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OQw6Pyo6Sj9WISorTygoPDkC
        SDlPCipVSlVKTUlDSElCSk1JTkpNVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlOS0o3Bg++
X-HM-Tid: 0a7b1ffb3561da01kuwsc1c7a400c1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we need to trigger /proc/sysrq-trigger to view the
information of the D state process in the system.
e.g:
echo w > /proc/sysrq-trigger

Here we print the scheduling time of the process, which is convenient
for us to debug.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 kernel/sched/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 014ce8b..916436d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8183,10 +8183,16 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
+#ifdef CONFIG_SCHED_INFO
+	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx last-run:%llu\n",
+		free, task_pid_nr(p), ppid,
+		(unsigned long)task_thread_info(p)->flags,
+		p->sched_info.last_arrival);
+#else
 	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
 		free, task_pid_nr(p), ppid,
 		(unsigned long)task_thread_info(p)->flags);
-
+#endif
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
 	show_stack(p, NULL, KERN_INFO);
-- 
2.7.4


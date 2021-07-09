Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037BD3C1EC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 07:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhGIFIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 01:08:54 -0400
Received: from mail-m121145.qiye.163.com ([115.236.121.145]:64524 "EHLO
        mail-m121145.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhGIFIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 01:08:53 -0400
DKIM-Signature: a=rsa-sha256;
        b=g4tBW+fqumECGTBlfka/mxLpV/e2lYPhdS7s9oiMJ1FNAfV9ZryRuSCZJ6SyrFoH/vlYFlf7pMlcASjt64lVDK9iFpMFapagdhMb+JW7v/qsL9tTFnc9aLHixf0NzfJHRqRul5yhBYZq5s2laHKrvZaCaa9/x2CNUdySk37gc8o=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=o6m8QVLBIA/2tAPs7aR60tj41WOi+Lh9NWeB8ufBD5s=;
        h=date:mime-version:subject:message-id:from;
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 7FEE8800265;
        Fri,  9 Jul 2021 13:06:06 +0800 (CST)
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
Subject: [PATCH] kernel/sched/core: Print the time when the process entered the D state
Date:   Thu,  8 Jul 2021 22:05:59 -0700
Message-Id: <1625807160-112041-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGR8fGFZLSE9OH0JLTkJPSxpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQw6Nxw6OD9NOhIhKh4fKAoq
        C08aCQxVSlVKTUlOQ0tMSk1MSkpCVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlPTU03Bg++
X-HM-Tid: 0a7a89a89d5ab03akuuu7fee8800265
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
 kernel/sched/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf16f8f..e03474d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8154,9 +8154,10 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
+	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx sched:%llu\n",
 		free, task_pid_nr(p), ppid,
-		(unsigned long)task_thread_info(p)->flags);
+		(unsigned long)task_thread_info(p)->flags,
+		p->sched_info.last_arrival);
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A873C2704
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhGIPpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 11:45:06 -0400
Received: from mail-m121145.qiye.163.com ([115.236.121.145]:45218 "EHLO
        mail-m121145.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhGIPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 11:45:05 -0400
DKIM-Signature: a=rsa-sha256;
        b=J/TVosa94nPVRm5RfFursRrVHiQa0IHWUcjawUEWWIqJ/gi6v7A1+jzIokrcNIKgmrz69dyiR+qBRTDMLgchRqBt/y5oIbcIKw3sE/G3pOATuaT1LjZ7wpXsOvhyFp5/V5/JuCp3d5au8BKQfi0fgJoEaekY9ZAEr0/cm5AOc/U=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=cTHGg0zV9A6CozIf0PtEnQVu10A7CcnDk49PbqA+TeU=;
        h=date:mime-version:subject:message-id:from;
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 5B5B2800135;
        Fri,  9 Jul 2021 23:42:18 +0800 (CST)
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
Subject: [PATCH v3] kernel/sched/core: Print the time when the process entered the D state
Date:   Fri,  9 Jul 2021 08:41:55 -0700
Message-Id: <1625845315-21587-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQxlISFZKGRgaShpMTR4fTxhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        NISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46NRw6Kj9NPhFJKB0xTDki
        GioKCxhVSlVKTUlOQ09OSEhCSUxDVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlOQ0w3Bg++
X-HM-Tid: 0a7a8bef1369b03akuuu5b5b2800135
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
 kernel/sched/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf16f8f..b0e6198 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8154,10 +8154,16 @@ void sched_show_task(struct task_struct *p)
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


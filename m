Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4F9428C56
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhJKLuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:50:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14324 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhJKLuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:50:18 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HScPX2bwVz906G;
        Mon, 11 Oct 2021 19:43:28 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 19:48:16 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 19:48:16 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] tracing: save cmdline only when task does not exist in savecmd for optimization
Date:   Mon, 11 Oct 2021 19:50:18 +0800
Message-ID: <20211011115018.88948-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 85f726a35e504418 use strncpy instead of memcpy when copying comm,
on ARM64 machine, this commit causes performance degradation.

For the task that already exists in savecmd, it is unnecessary to call
set_cmdline to execute strncpy once, run set_cmdline only if the task does
not exist in savecmd.

I have written an example (which is an extreme case) in which trace sched switch
is invoked for 1000 times, as shown in the following:

  for (int i = 0; i < 1000; i++) {
          trace_sched_switch(true, current, current);
 }

On ARM64 machine, compare the data before and after the optimization:
+---------------------+------------------------------+------------------------+
|                     | Total number of instructions | Total number of cycles |
+---------------------+------------------------------+------------------------+
| Before optimization |           1107367            |          658491        |
+---------------------+------------------------------+------------------------+
| After optimization  |            869367            |          520171        |
+---------------------+------------------------------+------------------------+
As shown above, there is nearly 26% performance

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 kernel/trace/trace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7896d30d90f7..a795610a3b37 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2427,8 +2427,11 @@ static int trace_save_cmdline(struct task_struct *tsk)
 		savedcmd->cmdline_idx = idx;
 	}
 
-	savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
-	set_cmdline(idx, tsk->comm);
+	/* save cmdline only when task does not exist in savecmd */
+	if (savedcmd->map_cmdline_to_pid[idx] != tsk->pid) {
+		savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
+		set_cmdline(idx, tsk->comm);
+	}
 
 	arch_spin_unlock(&trace_cmdline_lock);
 
-- 
2.30.GIT


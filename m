Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9970F39F0A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhFHISn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:18:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3469 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhFHISX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:18:23 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fzjft60Ykz6w8W;
        Tue,  8 Jun 2021 16:13:26 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:16:29 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:16:29 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] signal: remove leading spaces before tabs
Date:   Tue, 8 Jun 2021 16:16:23 +0800
Message-ID: <20210608081623.13488-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Run the following command to find and remove the leading spaces before
   tabs:
   sed -r -i 's/^[ ]+\t/\t/' kernel/signal.c
2) Manually check and correct if necessary

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/signal.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9569f736eb5d..6b871bdbacda 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1967,8 +1967,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 
 	BUG_ON(sig == -1);
 
- 	/* do_notify_parent_cldstop should have been called instead.  */
- 	BUG_ON(task_is_stopped_or_traced(tsk));
+	/* do_notify_parent_cldstop should have been called instead.  */
+	BUG_ON(task_is_stopped_or_traced(tsk));
 
 	BUG_ON(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
@@ -2099,20 +2099,20 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 	info.si_utime = nsec_to_clock_t(utime);
 	info.si_stime = nsec_to_clock_t(stime);
 
- 	info.si_code = why;
- 	switch (why) {
- 	case CLD_CONTINUED:
- 		info.si_status = SIGCONT;
- 		break;
- 	case CLD_STOPPED:
- 		info.si_status = tsk->signal->group_exit_code & 0x7f;
- 		break;
- 	case CLD_TRAPPED:
- 		info.si_status = tsk->exit_code & 0x7f;
- 		break;
- 	default:
- 		BUG();
- 	}
+	info.si_code = why;
+	switch (why) {
+	case CLD_CONTINUED:
+		info.si_status = SIGCONT;
+		break;
+	case CLD_STOPPED:
+		info.si_status = tsk->signal->group_exit_code & 0x7f;
+		break;
+	case CLD_TRAPPED:
+		info.si_status = tsk->exit_code & 0x7f;
+		break;
+	default:
+		BUG();
+	}
 
 	sighand = parent->sighand;
 	spin_lock_irqsave(&sighand->siglock, flags);
-- 
2.25.1



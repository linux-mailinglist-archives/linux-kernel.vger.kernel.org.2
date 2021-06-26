Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849E33B4ED7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFZOBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:01:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57147 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZOBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:01:22 -0400
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15QDwxmG005391;
        Sat, 26 Jun 2021 22:58:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sat, 26 Jun 2021 22:58:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15QDwsVn005110
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 26 Jun 2021 22:58:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] tracepoint: Do not warn on EEXIST or ENOENT
Date:   Sat, 26 Jun 2021 22:58:45 +0900
Message-Id: <20210626135845.4080-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is hitting WARN_ON_ONCE() at tracepoint_add_func() [1], but
func_add() returning -EEXIST and func_remove() returning -ENOENT are
not kernel bugs that can justify crashing the system.

Commit d66a270be3310d7a ("tracepoint: Do not warn on ENOMEM") says that
tracepoint should only warn when a kernel API user does not respect the
required preconditions (e.g. same tracepoint enabled twice, or called
to remove a tracepoint that does not exist). But WARN*() must be used to
denote kernel bugs and not to print simple warnings. If someone wants to
print warnings, pr_warn() etc. should be used instead.

Link: https://syzkaller.appspot.com/bug?id=41f4318cf01762389f4d1c1c459da4f542fe5153 [1]
Reported-by: syzbot <syzbot+721aa903751db87aa244@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+721aa903751db87aa244@syzkaller.appspotmail.com>
---
 kernel/tracepoint.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 9f478d29b926..3cfa37a3d05c 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -287,10 +287,8 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	tp_funcs = rcu_dereference_protected(tp->funcs,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
-	if (IS_ERR(old)) {
-		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
+	if (IS_ERR(old))
 		return PTR_ERR(old);
-	}
 
 	/*
 	 * rcu_assign_pointer has as smp_store_release() which makes sure
@@ -320,7 +318,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 	tp_funcs = rcu_dereference_protected(tp->funcs,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_remove(&tp_funcs, func);
-	if (WARN_ON_ONCE(IS_ERR(old)))
+	if (IS_ERR(old))
 		return PTR_ERR(old);
 
 	if (tp_funcs == old)
-- 
2.18.4


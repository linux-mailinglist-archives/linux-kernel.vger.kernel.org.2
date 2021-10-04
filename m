Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3EF4211B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhJDOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:43:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:36885 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234666AbhJDOl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:41:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="311657753"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="311657753"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 07:37:10 -0700
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="622303603"
Received: from shearne-mobl.ger.corp.intel.com (HELO tursulin-mobl2.home) ([10.213.208.122])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 07:37:08 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC 1/8] sched: Add nice value change notifier
Date:   Mon,  4 Oct 2021 15:36:43 +0100
Message-Id: <20211004143650.699120-2-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004143650.699120-1-tvrtko.ursulin@linux.intel.com>
References: <20211004143650.699120-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Implement a simple notifier chain via which interested parties can track
when process nice value changes. Simple because it is global so each user
would have to track which tasks it is interested in.

First intended use case are GPU drivers using task nice as priority hint
when scheduling GPU contexts belonging to respective clients.

To use register_user_nice_notifier and unregister_user_nice_notifier
functions are provided and new nice value and pointer to task_struct
being modified passed to the callbacks.

v2:
 * Move the notifier chain outside task_rq_lock. (Peter)

Opens:
 * Security. Would some sort of a  per process mechanism be better and
   feasible?
     x Peter Zijlstra thinks it may be passable now that it is outside
       core scheduler locks.
 * Put it all behind kconfig to be selected by interested drivers?

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  5 +++++
 kernel/sched/core.c   | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c1a927ddec64..1fcec88e5dbc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2309,4 +2309,9 @@ static inline void sched_core_free(struct task_struct *tsk) { }
 static inline void sched_core_fork(struct task_struct *p) { }
 #endif
 
+struct notifier_block;
+
+extern int register_user_nice_notifier(struct notifier_block *);
+extern int unregister_user_nice_notifier(struct notifier_block *);
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba4128a3e6..fc90b603bb6f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6864,10 +6864,42 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 }
 #endif
 
+ATOMIC_NOTIFIER_HEAD(user_nice_notifier_list);
+
+/**
+ * register_user_nice_notifier - Register function to be called when task nice changes
+ * @nb: Info about notifier function to be called
+ *
+ * Registers a function with the list of functions to be called when task nice
+ * value changes.
+ *
+ * Currently always returns zero, as atomic_notifier_chain_register()
+ * always returns zero.
+ */
+int register_user_nice_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&user_nice_notifier_list, nb);
+}
+EXPORT_SYMBOL(register_user_nice_notifier);
+
+/**
+ * unregister_user_nice_notifier - Unregister previously registered user nice notifier
+ * @nb: Hook to be unregistered
+ *
+ * Unregisters a previously registered user nice notifier function.
+ *
+ * Returns zero on success, or %-ENOENT on failure.
+ */
+int unregister_user_nice_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&user_nice_notifier_list, nb);
+}
+EXPORT_SYMBOL(unregister_user_nice_notifier);
+
 void set_user_nice(struct task_struct *p, long nice)
 {
 	bool queued, running;
-	int old_prio;
+	int old_prio, ret;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -6915,6 +6947,9 @@ void set_user_nice(struct task_struct *p, long nice)
 
 out_unlock:
 	task_rq_unlock(rq, p, &rf);
+
+	ret = atomic_notifier_call_chain(&user_nice_notifier_list, nice, p);
+	WARN_ON_ONCE(ret != NOTIFY_DONE);
 }
 EXPORT_SYMBOL(set_user_nice);
 
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39033426F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhCSUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhCSUdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:33:09 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0D2C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:33:09 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 94so7840998qtc.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wpPOdQxY/Cp24iJgZMVQYaJRsN5Sc7SW8aM4kNhFnG8=;
        b=B0ae8JCQoR1/xCcpWUO7ZVcHBl0eQiDQB8pn60n0m9zpBnta+Iyf3V0rppmSoNbjJk
         QkvVREKyP2QIC6mZP7t6mdI+0bhxknP6pRDpxadGsGDmgLFokJckDuYovvSh8B0/KhAI
         X9sgGjQw9ZUaGBY66UpksGrdP16oyapnoeT4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpPOdQxY/Cp24iJgZMVQYaJRsN5Sc7SW8aM4kNhFnG8=;
        b=o6lAtdZpXLmu5TqfWsOyaYnfLld68efMlBtTUbLlli5DANv9xxjWWKBU4ZefQm8uC8
         b57XPPIvbwMEEOpD5axXT1R61dCV4UGPPDKJ4uAoQZ6rLjNKVXyc4WZrWtxS/UGP6Mbw
         DAzu5lEbHl8U0mK+hRLhXvz0KiTODpOjf1OikS2vvrtaTtq8HnM4Tdi21gD3RgfTGxnX
         XLeWJN8+oVMdSqRhl3R94p/ylbPlZ+i6ZTqoxMxRw4tXlpB+dvwtphWGrP901NGEWoXJ
         c2gJ9H2GnVTh9VQgFvxPbS2svTCGaC1lUX7OULp59LtDbFu2enuF0mXwA4ckbbyk5/8L
         lUfQ==
X-Gm-Message-State: AOAM533UBDwhC6cX92ZbGPe1hSNzbCwBhr9tgon8xe/+O3n7nFXi8AD5
        yH4FeMC8vHwpLbSrd8eW+IDtlg==
X-Google-Smtp-Source: ABdhPJxc3cX19PGa3NLoBd2TtHC+i7bAjsN+261so1oly1nhrVEe7qVxqmm605EFR4CLoRDfQ3I/Jw==
X-Received: by 2002:ac8:4558:: with SMTP id z24mr488100qtn.66.1616185988880;
        Fri, 19 Mar 2021 13:33:08 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:7422:5a6f:e616:23c9])
        by smtp.gmail.com with ESMTPSA id j26sm4588187qtp.30.2021.03.19.13.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:33:08 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 6/6] sched: Debug bits...
Date:   Fri, 19 Mar 2021 16:32:53 -0400
Message-Id: <20210319203253.3352417-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319203253.3352417-1-joel@joelfernandes.org>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 40 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/fair.c |  9 +++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a62e8ad5ce58..58cca96ba93d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -147,6 +147,10 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool
 
 	int pa = __task_prio(a), pb = __task_prio(b);
 
+	trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
+		     a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+		     b->comm, b->pid, pb, b->se.vruntime, b->dl.deadline);
+
 	if (-pa < -pb)
 		return true;
 
@@ -312,12 +316,16 @@ static void __sched_core_enable(void)
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
+
+	printk("core sched enabled\n");
 }
 
 static void __sched_core_disable(void)
 {
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
+
+	printk("core sched disabled\n");
 }
 
 void sched_core_get(void)
@@ -5503,6 +5511,13 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			set_next_task(rq, next);
 		}
 
+		trace_printk("pick pre selected (%u %u %u): %s/%d %llu\n",
+			     rq->core->core_task_seq,
+			     rq->core->core_pick_seq,
+			     rq->core_sched_seq,
+			     next->comm, next->pid,
+			     next->core_cookie.userspace_id);
+
 		rq->core_pick = NULL;
 		return next;
 	}
@@ -5597,6 +5612,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 					rq->core->core_forceidle_seq++;
 			}
 
+			trace_printk("cpu(%d): selected: %s/%d %llu\n",
+				     i, p->comm, p->pid,
+				     p->core_cookie.userspace_id);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -5613,6 +5632,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 
+				trace_printk("max: %s/%d %llu\n",
+					     max->comm, max->pid,
+					     max->core_cookie.userspace_id);
+
 				if (old_max) {
 					rq->core->core_forceidle = false;
 					for_each_cpu(j, smt_mask) {
@@ -5634,6 +5657,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/* Something should have been selected for current CPU */
 	WARN_ON_ONCE(!next);
+	trace_printk("picked: %s/%d %llu\n", next->comm, next->pid,
+		     next->core_cookie.userspace_id);
 
 	/*
 	 * Reschedule siblings
@@ -5675,13 +5700,21 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 
 		/* Did we break L1TF mitigation requirements? */
-		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
+		if (unlikely(!cookie_match(next, rq_i->core_pick))) {
+			trace_printk("[%d]: cookie mismatch. %s/%d/0x%llu/0x%llu\n",
+				     rq_i->cpu, rq_i->core_pick->comm,
+				     rq_i->core_pick->pid,
+				     rq_i->core_pick->core_cookie.userspace_id,
+				     rq_i->core->core_cookie.userspace_id);
+			WARN_ON_ONCE(1);
+		}
 
 		if (rq_i->curr == rq_i->core_pick) {
 			rq_i->core_pick = NULL;
 			continue;
 		}
 
+		trace_printk("IPI(%d)\n", i);
 		resched_curr(rq_i);
 	}
 
@@ -5721,6 +5754,11 @@ static bool try_steal_cookie(int this, int that)
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
+		trace_printk("core fill: %s/%d (%d->%d) %d %d %llu\n",
+			     p->comm, p->pid, that, this,
+			     p->core_occupation, dst->idle->core_occupation,
+			     cookie->userspace_id);
+
 		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fddd7c44bbf3..ebeeebc4223a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10769,6 +10769,15 @@ static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forc
 			cfs_rq->forceidle_seq = fi_seq;
 		}
 
+
+		if (root) {
+			old = cfs_rq->min_vruntime_fi;
+			new = cfs_rq->min_vruntime;
+			root = false;
+			trace_printk("cfs_rq(min_vruntime_fi) %lu->%lu\n",
+				     old, new);
+		}
+
 		cfs_rq->min_vruntime_fi = cfs_rq->min_vruntime;
 	}
 }
-- 
2.31.0.rc2.261.g7f71774620-goog


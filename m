Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417F83483E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbhCXVlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbhCXVkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:40:39 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D50C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:39 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g24so222396qts.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8dIk/riFTyegbaXsO6l7eHjF8mhgDMkRzOkeSlLnA6A=;
        b=eRFLLJpQ1DidiM1LZTivDeF4+xi4+NET4hLnROGLZx158o3Ck094/vMbevo22fTwkD
         v0PCClwh9q8zSaZ58Pr6HY0XcQTkBDTNjONSiYMpL9KFXESWBLlpd9fMKMMUjQaJQtjr
         n5ebtEKdxKzdsD+KDZKx3ivqIwTrf212byiAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8dIk/riFTyegbaXsO6l7eHjF8mhgDMkRzOkeSlLnA6A=;
        b=YIzrIMySrGGP4pZ8VlFNb5NwGj8GZs4dnnsQx6S/s9xvNgjiKTd7yyClSpgfLHFvKr
         JLmLs/xCjk5iyTpHMAmMmLhSvyYM1rzsSGXtI4oWp4ZHyxN/dHXwD4vHjXeLJW/fDlOI
         p6FJDy8ESVyz3Y1bMNT/rfHaUocXceBOFPXLzg7rsRiLwvAbioXysNIZko+EHc8xb7v9
         YXYUg6RW9gp17M/wn5ViwDbCWAAtZ2aAC5ZSKo1QbfwBAXi6SkEYCgxZYY0fvgPg1dxg
         s1faO+WwZYRs1SST3S3X9IrFN1ANzuQNlMYy9mAyGAUtYUDTU57geZkEmFXNxgxJ3roj
         +pDg==
X-Gm-Message-State: AOAM533SvYfJ/E0/4HDdw7PGheMl1Sv5M0eaamD7s7R1iKnYT+Jf9VEw
        iE5UvtDT78aRotZgTznKPxiIIw==
X-Google-Smtp-Source: ABdhPJxzh+wkmcc0EduVe5ulZ9zAeLsS4UxqlTIiqe73ndyz1oHoLNjeAQiL6HJe2DIL0uoB/PIkpw==
X-Received: by 2002:ac8:12c1:: with SMTP id b1mr5080838qtj.8.1616622038774;
        Wed, 24 Mar 2021 14:40:38 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:3177:30e:b1de:1fb4])
        by smtp.gmail.com with ESMTPSA id h75sm2661107qke.80.2021.03.24.14.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:40:38 -0700 (PDT)
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
        Tom Lendacky <thomas.lendacky@amd.com>, dhiatt@digitalocean.com
Subject: [PATCH resend 8/8] sched: Debug bits...
Date:   Wed, 24 Mar 2021 17:40:20 -0400
Message-Id: <20210324214020.34142-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324214020.34142-1-joel@joelfernandes.org>
References: <20210324214020.34142-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 40 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/fair.c | 12 ++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a733891dfe7d..2649efeac19f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -106,6 +106,10 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool
 
 	int pa = __task_prio(a), pb = __task_prio(b);
 
+	trace_printk("(%s/%d;%d,%llu,%llu) ?< (%s/%d;%d,%llu,%llu)\n",
+		     a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+		     b->comm, b->pid, pb, b->se.vruntime, b->dl.deadline);
+
 	if (-pa < -pb)
 		return true;
 
@@ -292,12 +296,16 @@ static void __sched_core_enable(void)
 
 	static_branch_enable(&__sched_core_enabled);
 	__sched_core_flip(true);
+
+	printk("core sched enabled\n");
 }
 
 static void __sched_core_disable(void)
 {
 	__sched_core_flip(false);
 	static_branch_disable(&__sched_core_enabled);
+
+	printk("core sched disabled\n");
 }
 
 void sched_core_get(void)
@@ -5361,6 +5369,13 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
@@ -5455,6 +5470,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 					rq->core->core_forceidle_seq++;
 			}
 
+			trace_printk("cpu(%d): selected: %s/%d %llu\n",
+				     i, p->comm, p->pid,
+				     p->core_cookie.userspace_id);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -5471,6 +5490,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
 
+				trace_printk("max: %s/%d %llu\n",
+					     max->comm, max->pid,
+					     max->core_cookie.userspace_id);
+
 				if (old_max) {
 					rq->core->core_forceidle = false;
 					for_each_cpu(j, smt_mask) {
@@ -5492,6 +5515,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/* Something should have been selected for current CPU */
 	WARN_ON_ONCE(!next);
+	trace_printk("picked: %s/%d %llu\n", next->comm, next->pid,
+		     next->core_cookie.userspace_id);
 
 	/*
 	 * Reschedule siblings
@@ -5533,13 +5558,21 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
 
@@ -5579,6 +5612,11 @@ static bool try_steal_cookie(int this, int that)
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
index 12030b73a032..2432420b4bef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10783,6 +10783,9 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
  */
 static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forceidle)
 {
+	bool root = true;
+	long old, new;
+
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
@@ -10792,6 +10795,15 @@ static void se_fi_update(struct sched_entity *se, unsigned int fi_seq, bool forc
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
2.31.0.291.g576ba9dcdaf-goog


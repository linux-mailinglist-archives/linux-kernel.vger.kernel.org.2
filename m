Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCDF3B89E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 22:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhF3Uy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 16:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbhF3UyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 16:54:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EE5C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 13:51:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h1-20020a255f410000b02905585436b530so5552868ybm.21
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WXCJB/sn116SgSEffDSjzbCu9ljJn1wLs+Vne4KFJ+E=;
        b=bte2f2XYQ1DOjqMdsGzUOiZHs6KmPl58pU/flR4jZH0dBZSy8TYGRVvNhSf84qCwA/
         dXsgZrL4sL1B5mC7YRq0UR0PMS0UYxmuQqlaArrawpRYBZHIZLdY7+j2aU0obbPWyrhG
         JR2At/fYtMg3FMmKwu99cf1V9+UgCvu0qJfTMiN1FXJKrd5Ll+pucNzKR2RXvoRriWIa
         +lynkComSrHQiP/O3PaMv26IpIBO6mnSHNt6poK6AEEJpErvgj9LNZikO/Vs4JmECX4N
         zL6utMIXpZJ/rsK9TEwZXF35TZI81+WjZ+cVDv/reDpTSSXltwRS3zbmFRVImYMSQeBN
         abtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WXCJB/sn116SgSEffDSjzbCu9ljJn1wLs+Vne4KFJ+E=;
        b=L65a+a5f2mJOiBtCLDqyFs2kYKLpiA5e7Yj4Rz0YerSDhn5ANTMr9vqPJXGP9O8BnB
         Zj73wEbWixiGuSKO8HpEVH8YsOgP7RSxjbDSKeBF3puH89l+8Ld2jnqrmqWMYQSrnAa6
         rHMI6D1e0ITb9VZhhgTk2bcAYYPXyHM3OTwwdnN9wOpan28SV8HHYso5Qx20iSVQLcAr
         G1BCW4HACS//8XETkuOTB/BPEYJVraEIQ3a57ZMQ7rTNxA7W7wD5aRHQzEAdstPj9ZGW
         8QebY5iAhXK57fL1yYC5y6tM+h9ZfTiojUHatlBHRzrRbMMp3hXFQPaTIe3RjBVkifKQ
         o1xQ==
X-Gm-Message-State: AOAM531Db3dn1czyf58WdM8FdFOX0126W1G2SVz8oW58Zlxr0xHAiRkm
        Bds63eLBdDoeDKV9CL5jJVRQ4Pk1Xyk=
X-Google-Smtp-Source: ABdhPJxpwShbTyniu85SbURsJRjlKLSAmfOYgM4PaRy3d7FcNFtwT37Wj1f61GUqf0SviwEqaC0xBrhUbOI=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:e135:81d1:5036:d9ff])
 (user=surenb job=sendgmr) by 2002:a25:3b46:: with SMTP id i67mr49622177yba.207.1625086315507;
 Wed, 30 Jun 2021 13:51:55 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:51:51 -0700
Message-Id: <20210630205151.137001-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 1/1] psi: stop relying on timer_pending for poll_work rescheduling
From:   Suren Baghdasaryan <surenb@google.com>
To:     peterz@infradead.org
Cc:     hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, matthias.bgg@gmail.com, minchan@google.com,
        timmurray@google.com, yt.chang@mediatek.com, wenju.xu@mediatek.com,
        jonathan.jmchen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com,
        surenb@google.com, SH Chen <show-hong.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Psi polling mechanism is trying to minimize the number of wakeups to
run psi_poll_work and is currently relying on timer_pending() to detect
when this work is already scheduled. This provides a window of opportunity
for psi_group_change to schedule an immediate psi_poll_work after
poll_timer_fn got called but before psi_poll_work could reschedule itself.
Below is the depiction of this entire window:

poll_timer_fn
  wake_up_interruptible(&group->poll_wait);

psi_poll_worker
  wait_event_interruptible(group->poll_wait, ...)
  psi_poll_work
    psi_schedule_poll_work
      if (timer_pending(&group->poll_timer)) return;
      ...
      mod_timer(&group->poll_timer, jiffies + delay);

Prior to 461daba06bdc we used to rely on poll_scheduled atomic which was
reset and set back inside psi_poll_work and therefore this race window
was much smaller.
The larger window causes increased number of wakeups and our partners
report visible power regression of ~10mA after applying 461daba06bdc.
Bring back the poll_scheduled atomic and make this race window even
narrower by resetting poll_scheduled only when we reach polling expiration
time. This does not completely eliminate the possibility of extra wakeups
caused by a race with psi_group_change however it will limit it to the
worst case scenario of one extra wakeup per every tracking window (0.5s
in the worst case).
By tracing the number of immediate rescheduling attempts performed by
psi_group_change and the number of these attempts being blocked due to
psi monitor being already active, we can assess the effects of this change:

Before the patch:
                                           Run#1    Run#2      Run#3
Immediate reschedules attempted:           684365   1385156    1261240
Immediate reschedules blocked:             682846   1381654    1258682
Immediate reschedules (delta):             1519     3502       2558
Immediate reschedules (% of attempted):    0.22%    0.25%      0.20%

After the patch:
                                           Run#1    Run#2      Run#3
Immediate reschedules attempted:           882244   770298    426218
Immediate reschedules blocked:             881996   769796    426074
Immediate reschedules (delta):             248      502       144
Immediate reschedules (% of attempted):    0.03%    0.07%     0.03%

The number of non-blocked immediate reschedules dropped from 0.22-0.25%
to 0.03-0.07%. The drop is attributed to the decrease in the race window
size and the fact that we allow this race only when psi monitors reach
polling window expiration time.

Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling mechanism")
Reported-by: Kathleen Chang <yt.chang@mediatek.com>
Reported-by: Wenju Xu <wenju.xu@mediatek.com>
Reported-by: Jonathan Chen <jonathan.jmchen@mediatek.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: SH Chen <show-hong.chen@mediatek.com>
---
changes in v2:
- Simplified atomic_cmpxchg() condition per PeterZ
- Added Tested-by:

 include/linux/psi_types.h |  1 +
 kernel/sched/psi.c        | 41 ++++++++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 0a23300d49af..ef8bd89d065e 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -158,6 +158,7 @@ struct psi_group {
 	struct timer_list poll_timer;
 	wait_queue_head_t poll_wait;
 	atomic_t poll_wakeup;
+	atomic_t poll_scheduled;
 
 	/* Protects data used by the monitor */
 	struct mutex trigger_lock;
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 58b36d17a09a..82b664ca9ee9 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -195,6 +195,7 @@ static void group_init(struct psi_group *group)
 	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 	mutex_init(&group->avgs_lock);
 	/* Init trigger-related members */
+	atomic_set(&group->poll_scheduled, 0);
 	mutex_init(&group->trigger_lock);
 	INIT_LIST_HEAD(&group->triggers);
 	memset(group->nr_triggers, 0, sizeof(group->nr_triggers));
@@ -555,18 +556,14 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 	return now + group->poll_min_period;
 }
 
-/* Schedule polling if it's not already scheduled. */
-static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
+/* Schedule polling if it's not already scheduled or forced. */
+static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
+				   bool force)
 {
 	struct task_struct *task;
 
-	/*
-	 * Do not reschedule if already scheduled.
-	 * Possible race with a timer scheduled after this check but before
-	 * mod_timer below can be tolerated because group->polling_next_update
-	 * will keep updates on schedule.
-	 */
-	if (timer_pending(&group->poll_timer))
+	/* cmpxchg should be called even when !force to set poll_scheduled */
+	if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) && !force)
 		return;
 
 	rcu_read_lock();
@@ -578,12 +575,15 @@ static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
 	 */
 	if (likely(task))
 		mod_timer(&group->poll_timer, jiffies + delay);
+	else
+		atomic_set(&group->poll_scheduled, 0);
 
 	rcu_read_unlock();
 }
 
 static void psi_poll_work(struct psi_group *group)
 {
+	bool force_reschedule = false;
 	u32 changed_states;
 	u64 now;
 
@@ -591,6 +591,23 @@ static void psi_poll_work(struct psi_group *group)
 
 	now = sched_clock();
 
+	if (now > group->polling_until) {
+		/*
+		 * We are either about to start or might stop polling if no
+		 * state change was recorded. Resetting poll_scheduled leaves
+		 * a small window for psi_group_change to sneak in and schedule
+		 * an immegiate poll_work before we get to rescheduling. One
+		 * potential extra wakeup at the end of the polling window
+		 * should be negligible and polling_next_update still keeps
+		 * updates correctly on schedule.
+		 */
+		atomic_set(&group->poll_scheduled, 0);
+	} else {
+		/* Polling window is not over, keep rescheduling */
+		force_reschedule = true;
+	}
+
+
 	collect_percpu_times(group, PSI_POLL, &changed_states);
 
 	if (changed_states & group->poll_states) {
@@ -616,7 +633,8 @@ static void psi_poll_work(struct psi_group *group)
 		group->polling_next_update = update_triggers(group, now);
 
 	psi_schedule_poll_work(group,
-		nsecs_to_jiffies(group->polling_next_update - now) + 1);
+		nsecs_to_jiffies(group->polling_next_update - now) + 1,
+		force_reschedule);
 
 out:
 	mutex_unlock(&group->trigger_lock);
@@ -740,7 +758,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	write_seqcount_end(&groupc->seq);
 
 	if (state_mask & group->poll_states)
-		psi_schedule_poll_work(group, 1);
+		psi_schedule_poll_work(group, 1, false);
 
 	if (wake_clock && !delayed_work_pending(&group->avgs_work))
 		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
@@ -1235,6 +1253,7 @@ static void psi_trigger_destroy(struct kref *ref)
 		 * can no longer be found through group->poll_task.
 		 */
 		kthread_stop(task_to_destroy);
+		atomic_set(&group->poll_scheduled, 0);
 	}
 	kfree(t);
 }
-- 
2.32.0.93.g670b81a890-goog


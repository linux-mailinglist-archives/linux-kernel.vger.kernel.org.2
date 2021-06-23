Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D253B1A49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhFWMhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhFWMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:37:10 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5E8C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:34:53 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id g8-20020a5d54080000b0290124a2d22ff8so444104wrv.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/1wrvW+fwHGLL+5GuHesjSuxsAKhvUGMy6Yv1xhbl6Q=;
        b=YStXZsV4QxRXGFFGyRpPpi9+VVhgqZk5FcJtZlnQm+tFlaYWJXBYuP3LfYupQof0AU
         MhHX/40G6ikr8nOMEK5bDmJ5jXQ1ZggLZbfkfnCWHbvZsKYE0W26EaTYEwdLeQGI0rK2
         V3bo7pryfQdE6dAtllFhHMCJpezveb7NUAxEhr6uJZjAQ/mK/A8vFWDoUWRaHzzxhi3P
         iRu98BUs1nVcWaBt94xuAJZ3nyXy5jZWVqGWZcJn/SbHYBlI+8ZUnOXWC4j1ObS96cSu
         JhrJ8oiHSwotea7TlzpVx+UgJLD2LHu2HJRIMvtnHv36oWCIK4jgeAEElkFqdaJSblxQ
         nCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/1wrvW+fwHGLL+5GuHesjSuxsAKhvUGMy6Yv1xhbl6Q=;
        b=KxfuJ4Sx9+lE9oTSqTo9EzjQuSk4SEOCbHWHjHvAs5i6jo0AsI+8G2zQzhOSvb+K71
         t1tWbcwYUgBfOD22QhwiYOaP0w7wc7cNzb9CXtJwk43Xi0rC/FCYhlxqrYgGNleZrxjK
         gyC/K9EmfX6LpNxUv72viDQH6TbRWRb+tsZHioLspB0kbJBc1yWLQqs2qq+EXzV/n69n
         GG2FOg02Y/Z7lukNaLIclf+2C14+jUen4o3RYd4UUa8JIPE0ko5SeYI7BSpCKXpCcrRg
         ZXecOvISsQFft5GyALgdMFzJ8ZWmPfmBqcBO8e4AUQuMmnsrnG3hHbqicosVVNfH9+zg
         WkOw==
X-Gm-Message-State: AOAM533tLpM3MrawtUWfqrbfj7dK7skI6vvVkcwiLp+/c7uQpUFlWjn9
        AOHaIp2h40+q1rtS4QTIEkeOj4LvAMeZ
X-Google-Smtp-Source: ABdhPJz4Jt4ca6Se5/ce1WEjpnPAd/pJ4dH/WDnzhYhUf3yWXYcrY+Rq5xKNihSf/xw+0+7ItTZotEHEDByT
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:2207:: with SMTP id
 z7mr521337wml.0.1624451691475; Wed, 23 Jun 2021 05:34:51 -0700 (PDT)
Date:   Wed, 23 Jun 2021 12:34:41 +0000
In-Reply-To: <20210623123441.592348-1-qperret@google.com>
Message-Id: <20210623123441.592348-4-qperret@google.com>
Mime-Version: 1.0
References: <20210623123441.592348-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v3 3/3] sched: Introduce RLIMIT_UCLAMP
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently nothing preventing tasks from changing their per-task
clamp values in anyway that they like. The rationale is probably that
system administrators are still able to limit those clamps thanks to the
cgroup interface. While this is probably fine in many systems where
userspace apps are expected to drive their own power-performance, this
causes pain in a system where both per-task and per-cgroup clamp values
are expected to be under the control of core system components (as is
the case for Android).

To fix this, let's introduce a new rlimit to control the uclamp
behaviour. This allows unprivileged tasks to lower their uclamp
requests, but not increase them unless they have been allowed to do so
via rlimit. This is consistent with the existing behaviour for nice
values or RT priorities.

The default RLIMIT_UCLAMP is set to RLIMIT_INFINITY to keep the existing
behaviour.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 fs/proc/base.c                      |  1 +
 include/asm-generic/resource.h      |  1 +
 include/uapi/asm-generic/resource.h |  3 +-
 kernel/sched/core.c                 | 48 ++++++++++++++++++++++++-----
 4 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9cbd915025ad..91a78cf1fe79 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -586,6 +586,7 @@ static const struct limit_names lnames[RLIM_NLIMITS] = {
 	[RLIMIT_NICE] = {"Max nice priority", NULL},
 	[RLIMIT_RTPRIO] = {"Max realtime priority", NULL},
 	[RLIMIT_RTTIME] = {"Max realtime timeout", "us"},
+	[RLIMIT_UCLAMP] = {"Max utilization clamp", NULL},
 };
 
 /* Display limits for a process */
diff --git a/include/asm-generic/resource.h b/include/asm-generic/resource.h
index 8874f681b056..53483b7cd4d7 100644
--- a/include/asm-generic/resource.h
+++ b/include/asm-generic/resource.h
@@ -26,6 +26,7 @@
 	[RLIMIT_NICE]		= { 0, 0 },				\
 	[RLIMIT_RTPRIO]		= { 0, 0 },				\
 	[RLIMIT_RTTIME]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
+	[RLIMIT_UCLAMP]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
 }
 
 #endif
diff --git a/include/uapi/asm-generic/resource.h b/include/uapi/asm-generic/resource.h
index f12db7a0da64..4d0fe4d564bf 100644
--- a/include/uapi/asm-generic/resource.h
+++ b/include/uapi/asm-generic/resource.h
@@ -46,7 +46,8 @@
 					   0-39 for nice level 19 .. -20 */
 #define RLIMIT_RTPRIO		14	/* maximum realtime priority */
 #define RLIMIT_RTTIME		15	/* timeout for RT tasks in us */
-#define RLIM_NLIMITS		16
+#define RLIMIT_UCLAMP		16	/* maximum utilization clamp */
+#define RLIM_NLIMITS		17
 
 /*
  * SuS says limits have to be unsigned.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ad055fb9ed2d..b094da4c5fea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1430,6 +1430,11 @@ static int uclamp_validate(struct task_struct *p,
 	if (util_min != -1 && util_max != -1 && util_min > util_max)
 		return -EINVAL;
 
+	return 0;
+}
+
+static void uclamp_enable(void)
+{
 	/*
 	 * We have valid uclamp attributes; make sure uclamp is enabled.
 	 *
@@ -1438,8 +1443,20 @@ static int uclamp_validate(struct task_struct *p,
 	 * scheduler locks.
 	 */
 	static_branch_enable(&sched_uclamp_used);
+}
 
-	return 0;
+static bool can_uclamp(struct task_struct *p, int value, enum uclamp_id clamp_id)
+{
+	unsigned long uc_rlimit = task_rlimit(p, RLIMIT_UCLAMP);
+
+	if (value == -1) {
+		if (rt_task(p) && clamp_id == UCLAMP_MIN)
+			value = sysctl_sched_uclamp_util_min_rt_default;
+		else
+			value = uclamp_none(clamp_id);
+	}
+
+	return value <= p->uclamp_req[clamp_id].value || value <= uc_rlimit;
 }
 
 static bool uclamp_reset(const struct sched_attr *attr,
@@ -1580,6 +1597,11 @@ static inline int uclamp_validate(struct task_struct *p,
 {
 	return -EOPNOTSUPP;
 }
+static inline void uclamp_enable(void) { }
+static bool can_uclamp(struct task_struct *p, int value, enum uclamp_id clamp_id)
+{
+	return true;
+}
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr) { }
 static inline void uclamp_fork(struct task_struct *p) { }
@@ -6116,6 +6138,13 @@ static int __sched_setscheduler(struct task_struct *p,
 	    (rt_policy(policy) != (attr->sched_priority != 0)))
 		return -EINVAL;
 
+	/* Update task specific "requested" clamps */
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
+		retval = uclamp_validate(p, attr);
+		if (retval)
+			return retval;
+	}
+
 	/*
 	 * Allow unprivileged RT tasks to decrease priority:
 	 */
@@ -6165,6 +6194,15 @@ static int __sched_setscheduler(struct task_struct *p,
 		/* Normal users shall not reset the sched_reset_on_fork flag: */
 		if (p->sched_reset_on_fork && !reset_on_fork)
 			return -EPERM;
+
+		/* Can't increase util-clamps */
+		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
+		    !can_uclamp(p, attr->sched_util_min, UCLAMP_MIN))
+			return -EPERM;
+
+		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
+		    !can_uclamp(p, attr->sched_util_max, UCLAMP_MAX))
+			return -EPERM;
 	}
 
 	if (user) {
@@ -6176,12 +6214,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
-	/* Update task specific "requested" clamps */
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
-		retval = uclamp_validate(p, attr);
-		if (retval)
-			return retval;
-	}
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
+		uclamp_enable();
 
 	if (pi)
 		cpuset_read_lock();
-- 
2.32.0.288.g62a8d224e6-goog


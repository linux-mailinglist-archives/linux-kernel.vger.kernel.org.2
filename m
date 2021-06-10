Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271A93A2F18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhFJPPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhFJPPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:15:30 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D397C061760
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:13:21 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id q8-20020ad45ca80000b02902329fd23199so8411910qvh.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UyKCg532ya0XgvMkAABX6u2Se1XVMpduQ2AgUaC8CF8=;
        b=sGSJQHrNKgvm8xcfEDHJKNy9BeRJbNwUNHYZ4uLfbIDG7eLfpLPS9ntTfAlj9jFQ8U
         qXuJjuwHWDwnyVcuYx6ub9TFoiPYCtv7LQfO3kXcayy2wnUTFEg799m6R2wHNOjR4HHG
         RKqXaPFYPiXGK6/TBi8v8jIYoZYUxkEyCzBk6YuOh7HTHEx4+6hqBQPgDJUXds5wFFiO
         bjkSnq7Wa2ZeyyDXhlgj9SQLfAR3hMqbsQYXXdytNMQxhelW/OP/X/diE2jhUZ2eHHMh
         n5Crwe8417o3PxktHTXmTy5FpFRIpCX2ARI99ZnnN3AMCPoIy3kFijz+L83GzhaEm7uA
         Z1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UyKCg532ya0XgvMkAABX6u2Se1XVMpduQ2AgUaC8CF8=;
        b=p20jFu+3X4SAV0/cIVNLKliB07QSMBWLcJuXdzGbGa7nw+Q0IF59WQgggGGJ3uFZ4T
         ldMeNrPthKvqVzf3Fvc6oB4g26d7j3iqtEGA+poEizyqZtTKcUxsMjme8kismj97y3t+
         JFmsnKyNw9QqGAbYPUD66f01DMXwGRZOr18NQgHNB1MDWlFD6TZ7QmQE4CD9neBwB7HH
         6Yx6MOyhCdCBAuahEqTMMWufL11sG03NVVsKAUrmsU3CsHfSI9aFu+Hyupo6uxbW6FH9
         Jv2c6so87pKLecBgzifK12menKH+Bka1C+eqDl13qOsnyVPJgCOz7noGxyrT322Jk1DU
         m1Wg==
X-Gm-Message-State: AOAM532LtsKNaPYufnYBmTat7+VZHpAnQSb4t0Z2hbw57Cc3ci9BnC4N
        U1mhtmmGPyTIb/QtPBjzr+tFI6xsDkft
X-Google-Smtp-Source: ABdhPJw6FOopih+Vw79dLpNZ9+mtSRd3QObfdhlq6xvvLKkvzALF4kvko1QOIOP8wneszb20sa4g+MVxgsyc
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:e942:: with SMTP id
 n2mr94424qvo.5.1623338000487; Thu, 10 Jun 2021 08:13:20 -0700 (PDT)
Date:   Thu, 10 Jun 2021 15:13:06 +0000
In-Reply-To: <20210610151306.1789549-1-qperret@google.com>
Message-Id: <20210610151306.1789549-4-qperret@google.com>
Mime-Version: 1.0
References: <20210610151306.1789549-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2 3/3] sched: Make uclamp changes depend on CAP_SYS_NICE
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently nothing preventing tasks from changing their per-task
clamp values in anyway that they like. The rationale is probably that
system administrators are still able to limit those clamps thanks to the
cgroup interface. However, this causes pain in a system where both
per-task and per-cgroup clamp values are expected to be under the
control of core system components (as is the case for Android).

To fix this, let's require CAP_SYS_NICE to increase per-task clamp
values. This allows unprivileged tasks to lower their requests, but not
increase them, which is consistent with the existing behaviour for nice
values.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 55 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1d4aedbbcf96..6e24daca8d53 100644
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
@@ -1438,8 +1443,32 @@ static int uclamp_validate(struct task_struct *p,
 	 * scheduler locks.
 	 */
 	static_branch_enable(&sched_uclamp_used);
+}
 
-	return 0;
+static bool uclamp_reduce(struct task_struct *p, const struct sched_attr *attr)
+{
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		int util_min = p->uclamp_req[UCLAMP_MIN].value;
+
+		if (attr->sched_util_min + 1 > util_min + 1)
+			return false;
+
+		if (rt_task(p) && attr->sched_util_min == -1 &&
+		    util_min < sysctl_sched_uclamp_util_min_rt_default)
+			return false;
+	}
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		int util_max = p->uclamp_req[UCLAMP_MAX].value;
+
+		if (attr->sched_util_max + 1 > util_max + 1)
+			return false;
+
+		if (attr->sched_util_max == -1 && util_max < uclamp_none(UCLAMP_MAX))
+			return false;
+	}
+
+	return true;
 }
 
 static bool uclamp_reset(const struct sched_attr *attr,
@@ -1580,6 +1609,11 @@ static inline int uclamp_validate(struct task_struct *p,
 {
 	return -EOPNOTSUPP;
 }
+static inline void uclamp_enable(void) { }
+static bool uclamp_reduce(struct task_struct *p, const struct sched_attr *attr)
+{
+	return true;
+}
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr) { }
 static inline void uclamp_fork(struct task_struct *p) { }
@@ -6116,6 +6150,13 @@ static int __sched_setscheduler(struct task_struct *p,
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
@@ -6165,6 +6206,10 @@ static int __sched_setscheduler(struct task_struct *p,
 		/* Normal users shall not reset the sched_reset_on_fork flag: */
 		if (p->sched_reset_on_fork && !reset_on_fork)
 			return -EPERM;
+
+		/* Can't increase util-clamps */
+		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP && !uclamp_reduce(p, attr))
+			return -EPERM;
 	}
 
 	if (user) {
@@ -6176,12 +6221,8 @@ static int __sched_setscheduler(struct task_struct *p,
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
2.32.0.272.g935e593368-goog


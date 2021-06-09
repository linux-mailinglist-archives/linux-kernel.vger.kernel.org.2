Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C33A1C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhFISCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:02:05 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:36534 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhFISCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:02:04 -0400
Received: by mail-wm1-f74.google.com with SMTP id f22-20020a1c6a160000b029018f49a7efb7so2889462wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VBsTTim89Bz2IjfJs4GSW+Fq94w6NsgAirSuoeONkNQ=;
        b=MEkFxzIcrbUn7fv4gWklcOJ8I5eazwVZQ8HNbXP/hZS0qcsFmEpaXudI1KcTHtaYuL
         SXDnW7Kw+0q6olK+LCvdYBFgLbkO8CgpJQrKF2xqYBrM3iQOXt6xlglruv4XKNyQRyOq
         38NLv0cvv0HBzG5Jwc31jSxgSZJDpjN3Au+vyPKvrGXyyvE0ZsYTvxxlAY5qNHyQFNmh
         zJh1osCL8m8s/VJ482cM1E8P3F/3fr9AezJLvvSFbcbxNB/hwpzOjgpHMQoyukgCgsDF
         1Mt8yFsjNOQpxSheb8U7tIz+qYO6D5t+8MIgy1xJq90Og433vJRfjm4t/P9IjOz+pfcy
         5rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VBsTTim89Bz2IjfJs4GSW+Fq94w6NsgAirSuoeONkNQ=;
        b=U1h7e42pmtKlcIgcoZqHFcSAL/P8losKFv8mWminACJN4iT1s3ZFmnSa7IDmlwpVKw
         cFs9/qeDWKlDkZOMIxc5IQtDp7eSb2M/RZn3fU862/sJyRIcQmSLvG/Cm9kQcP854teW
         30qBzRIqxSsD6x5wo2jNorrs3aY0afjK9glt4ir+NHGMnrszRL8qT8ZjgVexuzNKhbUJ
         M4AiN7UO5a8ndojou8ev3lVVGfYuiEKhT2jFQQ1ba3jdHnsh3z5sVGLXUUMdOuh5KXrp
         puYqcfwsdZYw18cFvUjUjC1nmSGeVsvZo6N2N0w9KrRdtwfqGlitdG3yX5QydhMwUF++
         GDFQ==
X-Gm-Message-State: AOAM531WIDaQRzGA8NXCI/BGB8W3QNPN9WiWY/1P39D8Pb2E9DVzXjcv
        IVKruidR4vtdzBtxwEGOFnGsgdCDa1Tg
X-Google-Smtp-Source: ABdhPJy5fCKq1HUJgretDfUvM9Pnp0qYQqs01t/ob/ZuaktNyCsW89GvexBjSjyB00spp6VwAWG22Q7Sc0Cn
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c396:: with SMTP id
 s22mr973153wmj.131.1623261549150; Wed, 09 Jun 2021 10:59:09 -0700 (PDT)
Date:   Wed,  9 Jun 2021 17:59:01 +0000
Message-Id: <20210609175901.1423553-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH] sched: Make uclamp changes depend on CAP_SYS_NICE
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is currently nothing preventing tasks from changing their per-task
clamp values in anyway that they like. The rationale is probably that
systems administrator are still able to limit those clamps thanks to the
cgroup interface. However, this causes pain in a system where both
per-task and per-cgroup clamps values are expected to be under the
control of core system components (as is the case for Android).

To fix this, let's require CAP_SYS_NICE to increase per-task clamp
values. This allows unprivileged tasks to lower their requests, but not
increase them, which is consistent with the existing behaviour for nice
values.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 48 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1d4aedbbcf96..1e5f9ae441a0 100644
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
@@ -1438,8 +1443,25 @@ static int uclamp_validate(struct task_struct *p,
 	 * scheduler locks.
 	 */
 	static_branch_enable(&sched_uclamp_used);
+}
 
-	return 0;
+static bool uclamp_reduce(struct task_struct *p, const struct sched_attr *attr)
+{
+	int util_min, util_max;
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		util_min = p->uclamp_req[UCLAMP_MIN].value;
+		if (attr->sched_util_min > util_min)
+			return false;
+	}
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		util_max = p->uclamp_req[UCLAMP_MAX].value;
+		if (attr->sched_util_max > util_max)
+			return false;
+	}
+
+	return true;
 }
 
 static bool uclamp_reset(const struct sched_attr *attr,
@@ -1580,6 +1602,11 @@ static inline int uclamp_validate(struct task_struct *p,
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
@@ -6116,6 +6143,13 @@ static int __sched_setscheduler(struct task_struct *p,
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
@@ -6165,6 +6199,10 @@ static int __sched_setscheduler(struct task_struct *p,
 		/* Normal users shall not reset the sched_reset_on_fork flag: */
 		if (p->sched_reset_on_fork && !reset_on_fork)
 			return -EPERM;
+
+		/* Can't increase util-clamps */
+		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP && !uclamp_reduce(p, attr))
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
2.32.0.272.g935e593368-goog


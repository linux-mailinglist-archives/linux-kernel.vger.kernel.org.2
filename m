Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7433B1A48
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFWMhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhFWMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:37:07 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:34:50 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 100-20020aed206d0000b029024ea3acef5bso2564016qta.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AEwge1vvi6RLxqX3R0gTLs6eOl30cMd705rUURUnj2E=;
        b=dKpHp77lmHi44Qs2deMsg05joUNnKHpV777MiumsvSuKYgxvRnuqenvCT7bnX62k3E
         QIklI7XHuamhHaaptIIP4fNVgTBthhxGg+0kMYjWKUe/qJL5JzAkA92RhfJyhGUarYl2
         ZRM3c9DGW24h/fhtsHPkb8OtR8BqYWvNdaPyjI/o5w/5aS3H6DgfsxV67XkvJG6LaLYY
         i/0HZFcW/jGIZbSKc+FGG0rQoV0qdiWgnoZ7rR+X27aSzC3NxWzmqMccd/PImqmDtGkh
         S/ZheSUmZrQWJd+JVPLfgk+qyjoE8n5XXN618REw3BsWU1urwsWoyxONmh54uVyqurLq
         kT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AEwge1vvi6RLxqX3R0gTLs6eOl30cMd705rUURUnj2E=;
        b=lZyrwfSmDSnXkJlSa13FE/uPN69vEg+aOQzvr6V5rj1LEZRnakzr6KqBulmLWiy9S3
         MiPCtBAnx1vMyQcTDtVVG4IUbdU64UHJErKwVlkGP/2uKQNU5D1uMFv27OSQTgxkd//n
         dG3VwhxSv+DHAO74BarlUzCLwU6p9vzOEEOUR1HdIIgJc7U1raxm+xW3XS+zDAGmTTtA
         talMPM4LQtjqnYcZ9+r26+KxnLHplJcmRVtrdvXgb+X7cyxKmk5P49vW46iRYwhOzqPB
         SbUKRD0zI8HL6oSrzbR1nLjr8B1X/3+RkpqmkagXvUbTBx3QVNma8L6e1JHFo3k9nZK5
         /3/Q==
X-Gm-Message-State: AOAM530Qq7uMU4vp+z4MUg0F/MdyXu3QsIKkwVUgpPUMUoQus0do4SZW
        e/ZJ0OubVKG42sj99eLBhyJTsmQ27Yi+
X-Google-Smtp-Source: ABdhPJytP6tqCuSg6URfOoFT0ZKeeWuC65mbJt040/kHw2PnZd3EmWiDFSTvhBrHDq+dG8sc9OSGvUaup1dD
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:f8c5:: with SMTP id
 h5mr4423030qvo.32.1624451689468; Wed, 23 Jun 2021 05:34:49 -0700 (PDT)
Date:   Wed, 23 Jun 2021 12:34:40 +0000
In-Reply-To: <20210623123441.592348-1-qperret@google.com>
Message-Id: <20210623123441.592348-3-qperret@google.com>
Mime-Version: 1.0
References: <20210623123441.592348-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v3 2/3] sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS
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

SCHED_FLAG_KEEP_PARAMS can be passed to sched_setattr to specify that
the call must not touch scheduling parameters (nice or priority). This
is particularly handy for uclamp when used in conjunction with
SCHED_FLAG_KEEP_POLICY as that allows to issue a syscall that only
impacts uclamp values.

However, sched_setattr always checks whether the priorities and nice
values passed in sched_attr are valid first, even if those never get
used down the line. This is useless at best since userspace can
trivially bypass this check to set the uclamp values by specifying low
priorities. However, it is cumbersome to do so as there is no single
expression of this that skips both RT and CFS checks at once. As such,
userspace needs to query the task policy first with e.g. sched_getattr
and then set sched_attr.sched_priority accordingly. This is racy and
slower than a single call.

As the priority and nice checks are useless when SCHED_FLAG_KEEP_PARAMS
is specified, simply inherit them in this case to match the policy
inheritance of SCHED_FLAG_KEEP_POLICY.

Reported-by: Wei Wang <wvw@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e514a093a0ba..ad055fb9ed2d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6523,6 +6523,16 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	return -E2BIG;
 }
 
+static void get_params(struct task_struct *p, struct sched_attr *attr)
+{
+	if (task_has_dl_policy(p))
+		__getparam_dl(p, attr);
+	else if (task_has_rt_policy(p))
+		attr->sched_priority = p->rt_priority;
+	else
+		attr->sched_nice = task_nice(p);
+}
+
 /**
  * sys_sched_setscheduler - set/change the scheduler policy and RT priority
  * @pid: the pid in question.
@@ -6584,6 +6594,8 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	rcu_read_unlock();
 
 	if (likely(p)) {
+		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
+			get_params(p, &attr);
 		retval = sched_setattr(p, &attr);
 		put_task_struct(p);
 	}
@@ -6732,12 +6744,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	kattr.sched_policy = p->policy;
 	if (p->sched_reset_on_fork)
 		kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
-	if (task_has_dl_policy(p))
-		__getparam_dl(p, &kattr);
-	else if (task_has_rt_policy(p))
-		kattr.sched_priority = p->rt_priority;
-	else
-		kattr.sched_nice = task_nice(p);
+	get_params(p, &kattr);
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
-- 
2.32.0.288.g62a8d224e6-goog


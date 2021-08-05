Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF8C3E1286
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbhHEKWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbhHEKWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:22:16 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D13C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 03:22:02 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id g187-20020a1c20c40000b02902458d430db6so1088983wmg.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 03:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XpS9vwSPXxSGQkdrbv75L7vaOoKS5FQFXHR+FmBXUOA=;
        b=omUC3VHqzS6LGNxwRBS5jNomE2v18iO4ZmRiE2vdmO/jEJDacq/ZbMLIEQdAbVySvj
         jk4IO3pG40or9Tfbu2rPXdCdE7DiOhRRFU/DewpQuOzv0aBK3bse+cXoexMR9uQeaqr8
         rIcVmSeWKZZo9G/5Bg1qtlpi8DK2/sAtbzS9jBcYI0+S59paqbMK6bTCrnN7KRwaF24M
         LSfTAltQsVdWZyYJvA6noolC6HJaZg3LbLZlVD4WnnV+C3imT5JKwfA6sbZn6fzHj/hE
         KLbM8Ij9R8NxxCkL9JgdNh24siBzz9Wyk4R36uIaJ83b4ORAVbLN7wBa05ah/2nLo6iL
         sElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XpS9vwSPXxSGQkdrbv75L7vaOoKS5FQFXHR+FmBXUOA=;
        b=MAAvy4PP063UeU8+NdDE6ADgc3PEkUNsXiavBn81vd6TE+/qyxxfqW+h3f0RAOui/f
         klPE/jRYinFERFXgnvsbi6AFMjjQ0rMLIqVMrHQWP/E4GIDJ+YlbQfB6pXJsifDtJcca
         A97yvRH9CNxFSoGl2Vuu3qfIY0vnc9zzuvqgvSpyJYzw/7fOwMLOJhOJsLq9hMVLQX0D
         Y+5JOw3+rRwCD992M5er6mEjdoGAS9PdsipPw3ceAEk6/Y4rJ3MCCWkRUi502mi8f4Tl
         8NDQaEOBekVc4QhAH9z8c1DU7bKPzu6Uhr+q2NABydfFHK9mwaRTZ1BaPdV9k67Prm/5
         Fs5w==
X-Gm-Message-State: AOAM531mwtPx0ytKsgky88vZfGbTnjICqZkjfs/PDRSw1pUYFLWmk0F3
        /jWg7QckbkSRWPeOU9WQxDZQ7F7vVhpH
X-Google-Smtp-Source: ABdhPJz/hA0TB8w3hbfHXG8ORvG0Z6vnJt0Xe55/pEO1nFoY9RLozncqn5Ba3+GMBqiLiDG0brW/+WYYeJB6
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fd92:a1bb:45f5:2fef])
 (user=qperret job=sendgmr) by 2002:a7b:c213:: with SMTP id
 x19mr14462830wmi.186.1628158920983; Thu, 05 Aug 2021 03:22:00 -0700 (PDT)
Date:   Thu,  5 Aug 2021 11:21:54 +0100
In-Reply-To: <20210805102154.590709-1-qperret@google.com>
Message-Id: <20210805102154.590709-3-qperret@google.com>
Mime-Version: 1.0
References: <20210805102154.590709-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v5 2/2] sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
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
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index df0480ad59b0..433b4001e71e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7328,6 +7328,16 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
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
@@ -7389,6 +7399,8 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	rcu_read_unlock();
 
 	if (likely(p)) {
+		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
+			get_params(p, &attr);
 		retval = sched_setattr(p, &attr);
 		put_task_struct(p);
 	}
@@ -7537,12 +7549,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
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
 	kattr.sched_flags &= SCHED_FLAG_ALL;
 
 #ifdef CONFIG_UCLAMP_TASK
-- 
2.32.0.554.ge1b32706d8-goog


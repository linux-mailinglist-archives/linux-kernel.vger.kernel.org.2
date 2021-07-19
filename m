Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F873CECD5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381586AbhGSRif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352240AbhGSQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:01:27 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12317C076742
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:52:26 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id sd15-20020a170906ce2fb0290512261c5475so5590244ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W8BP9ROv6HXqXT95uxHeIPQUwabwzYwHzzU6pKzCVxc=;
        b=wRCH4/aGDYCY0Mqo/+dSrnsn50l7bAMy2QowYJngP9ZWWdGsyT4oUGsL58A83ika2X
         7+P52V+kAhCEuejhFy5D//Q40/klsd1+59jxEf8HRpi4uN0iZSIT0PKV7McSpHPb+90z
         H76TGzcjEmr8F1sURQfVSTCyP9hBkr9IsIoiFiW/c5gU7FQA6MoYvPJ7La/XVaG9mBZh
         bU3Z65dk8q2h/DAJ7tCatX6n+Wbf+MOjuzNPPDsgw+JEHKyMup6JVINCbeUKqXBUAmuP
         CLVKNqhekY34/YGLIM8Cetv+IUV5ccrM3aRTgvwYWA30by0GvmS1XuZAWgqvbyZT13Ot
         SSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W8BP9ROv6HXqXT95uxHeIPQUwabwzYwHzzU6pKzCVxc=;
        b=SfP9dsIZ6J4+WfTsHnqrh5TkmlP7o4FksUr6TtjKs6wB9YO4rspjuSsVqFOP4PCkqk
         DN4h9wOxer41RT7zJTyCOxBFZHxhnMjvUhCEPAoB3OVMHXyyuOfdxqaG4okjtIO2dHFq
         AjI+V53KUFzjis3dhA1mEZ2DQX3yCVbhAvW+6ube6Q/F9sbhIrGQ2ntFoMOBAilO/Y9e
         Ogib4+AazNOb0mFFE7zwYo9V5pF25p4a4BmaPJDFIx3KEd693H2fgDvIdkERHInmx8WZ
         gtch+LPibcZT9gKbLfxOAMYgtxue/9Zo6wByNncOLskV4PZLlIVhq+xvNkI7yz+dvykH
         k7mQ==
X-Gm-Message-State: AOAM532upMQ5RDciEx8kss+gsP7pS3M5JqZv0dT9VwGeLKDaZZv4NjiC
        yV8wcRK4nmjMrO2d++X+OLUZn7d4itj1
X-Google-Smtp-Source: ABdhPJyFA7fn5zC3romriEXT6+0rw/R67XwmdHtyhp54JjSb36pc4gPTRwRvDj4QTvTbnSS8KzR66kcYaFPo
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
 (user=qperret job=sendgmr) by 2002:a17:906:2c19:: with SMTP id
 e25mr28634653ejh.477.1626711423204; Mon, 19 Jul 2021 09:17:03 -0700 (PDT)
Date:   Mon, 19 Jul 2021 17:16:56 +0100
In-Reply-To: <20210719161656.3833943-1-qperret@google.com>
Message-Id: <20210719161656.3833943-3-qperret@google.com>
Mime-Version: 1.0
References: <20210719161656.3833943-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v4 2/2] sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com
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
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e801d2c3077b..914076eab242 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7332,6 +7332,16 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
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
@@ -7393,6 +7403,8 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	rcu_read_unlock();
 
 	if (likely(p)) {
+		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
+			get_params(p, &attr);
 		retval = sched_setattr(p, &attr);
 		put_task_struct(p);
 	}
@@ -7541,12 +7553,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
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
2.32.0.402.g57bb445576-goog


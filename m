Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013003A2F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhFJPQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:16:37 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:39479 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhFJPQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:16:21 -0400
Received: by mail-yb1-f202.google.com with SMTP id r5-20020a2582850000b02905381b1b616eso36391273ybk.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sQgN6aRIek9SPblHyHkiCGSXCvzKGScP3r+Gjit2HM0=;
        b=YpdwTQLCYrhX2otGsuGW0gM31oSnBx1INqZeP24FmNOe0qmPIXq4M7HFmlGWAlKFSe
         Vy3gf/yTuKMBy4a4L58I2sCyd7lZPRDPmdtsbNDUPBILbFC7op9v0pezJD6QoQUlmiWn
         629OnqkFUTawr7KK0ZkzWGpJEq2UQ7OsqpKkfDq7+iKEsvJ+VaNVNeGyKR6Wt5hTgKp5
         6Kkx3+SEsVwbK8cVZw9GCLWVHw1gMO38kQvvVk5GS7yyo/U8keNwUuG2Ff+YM2Tb9G4G
         pGhRbDPITnu4MW1lXdlYWMbFxj0Ao6Pq3d1ktDJezPyjxUSGz7VDzF2LH+GH6hykjBUd
         vUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sQgN6aRIek9SPblHyHkiCGSXCvzKGScP3r+Gjit2HM0=;
        b=IpkJ31ULJbqyru8Bs33lvBdII+9jEJhXNM1EqRXm3pwLlAZvo6uaH4f6PiFyWxtDqm
         rMnX8Zlk9QuaM4+elPO3E0+RT1QjKWX0SfPpeN20CHxV1Qj4V/HE3Bhg53e5H8Q5ouh3
         oHVLQ5L9n6HuJ38kxU7wHemuHBU7qK5P5hWBzCOWqc4b00p42qAJ119W18IYldEpwLGs
         y4iAoAv9hzfIwB/fsLg3h9qxHurAsARKouH0qD5CthMzCm+I4Nd7XSRLqDd69/DEVmsJ
         Nl/kWh6HG+dZfuWvGNGrDNjn3gPR0z/xUPwrGadJEFNmvQjHhhR1lmC+YBQVAW6j6VLu
         stpA==
X-Gm-Message-State: AOAM533GlVan3GaNgcUOCx/cfLmwH7q20sMK1c4ZotPIoygriQjd4kLy
        iWC8qNMWbT8K8YtppcezbOWn2TKeusM/
X-Google-Smtp-Source: ABdhPJwqnDc55x3jOicFhhbN4B/hfFgH+d85Rw4HZa5WQPsrXqHmOJenFGkNqCrCFxfsb5ugO72aDwZLeIrc
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a25:4256:: with SMTP id
 p83mr8343434yba.212.1623337998372; Thu, 10 Jun 2021 08:13:18 -0700 (PDT)
Date:   Thu, 10 Jun 2021 15:13:05 +0000
In-Reply-To: <20210610151306.1789549-1-qperret@google.com>
Message-Id: <20210610151306.1789549-3-qperret@google.com>
Mime-Version: 1.0
References: <20210610151306.1789549-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2 2/3] sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS
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
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3b213402798e..1d4aedbbcf96 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6585,6 +6585,10 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	rcu_read_unlock();
 
 	if (likely(p)) {
+		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS) {
+			attr.sched_priority = p->rt_priority;
+			attr.sched_nice = task_nice(p);
+		}
 		retval = sched_setattr(p, &attr);
 		put_task_struct(p);
 	}
-- 
2.32.0.272.g935e593368-goog


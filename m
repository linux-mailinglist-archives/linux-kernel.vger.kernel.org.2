Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2861E3D72AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhG0KLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbhG0KLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:11:10 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0BEC061764
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:11:10 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id s8-20020a5d42480000b02901404c442853so5815259wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M8fGV9XuOvxhABWv6H1Hi3CTxbO7iUQ4hHxLrwKgnhI=;
        b=qQ8Lgx5tLTtB2PtilQSqTMr3gP5bLAJtlapPDv58e5/sXsVab1XL10t4XYS627C0cZ
         Nuc7Lieiisf1BMqWF4k6bY8gfoSRs7OkiOfqmBq9vq39UlEe/42670Lo98FZYJ+6H2T1
         rsu+Hus+4JjHP5/bwtTyZGE5F70x2FbUmpAlvr9JR5ViUjLjXau0SZrc0ItjWJz2NcBU
         fT2ZztTv4ZLA9EPeXdQZw9gLghJ68SJ0UmBegrsXoggKM0KBRsoOcO7ehGJpdYmD8HhA
         t8+T3cfDJ00/dp7Y3Pnb83EKXicKZVprgX5PMJQrzmMWn4VjIftMjK3pv4GryF+DY4TG
         OTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M8fGV9XuOvxhABWv6H1Hi3CTxbO7iUQ4hHxLrwKgnhI=;
        b=BJdPvgPGY3ftpwV+t8qG3Wn1ay8qLNXsJmSu1fbZTN3xZ4ueQSnjPx6lR3ODtSZC+z
         ieZvhhFbaBlXwtLd8sALZVf3nSScSDG9lirgpS8ZwCOo6IMWdJ6+bUGqROrw9iSVAZrv
         5vFS+Weeif9MajquhbYcUOEtfw75fSnedNFInGyFSvLw6skf+iUBthx6MdN7fgKqp/pu
         KpyTd0rBsjYzyJyUNhO8PpyQoEdI8hRoaYduiXuwAjtcSO1XFWkkd0Qm7DIyMNeBM1F2
         0eeAAM1IItCLHJ7IT5n7OMwcTdsRbf5XhDpkwTl7hqy6d7YUe6bjniEesU6NhQECJZxg
         8HNw==
X-Gm-Message-State: AOAM532iiJHAeTpiM8GTLAXcbh85mPIvcxxisw/lRzzp48OqX3ILd3Ce
        hXv8a+xRsYGrC5ny74fjm7qcqPI1Gnb1
X-Google-Smtp-Source: ABdhPJzXcB/fubpj/sGnBdXnymKNQrFX3qziewZPyRKhJDQjyGjZNPrKvHhgRd6gheTvat7hr+AYNybTrS/K
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:c468:e033:fa2b:3a6])
 (user=qperret job=sendgmr) by 2002:a7b:c8d2:: with SMTP id
 f18mr21166013wml.135.1627380669011; Tue, 27 Jul 2021 03:11:09 -0700 (PDT)
Date:   Tue, 27 Jul 2021 11:11:01 +0100
In-Reply-To: <20210727101103.2729607-1-qperret@google.com>
Message-Id: <20210727101103.2729607-2-qperret@google.com>
Mime-Version: 1.0
References: <20210727101103.2729607-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 1/2] sched/deadline: Fix reset_on_fork reporting of DL tasks
From:   Quentin Perret <qperret@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for sched_getattr() to incorrectly report the state of
the reset_on_fork flag when called on a deadline task.

Indeed, if the flag was set on a deadline task using sched_setattr()
with flags (SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_KEEP_PARAMS), then
p->sched_reset_on_fork will be set, but __setscheduler() will bail out
early, which means that the dl_se->flags will not get updated by
__setscheduler_params()->__setparam_dl(). Consequently, if
sched_getattr() is then called on the task, __getparam_dl() will
override kattr.sched_flags with the now out-of-date copy in dl_se->flags
and report the stale value to userspace.

To fix this, make sure to only copy the flags that are relevant to
sched_deadline to and from the dl_se->flags field.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/deadline.c | 7 ++++---
 kernel/sched/sched.h    | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index aaacd6cfd42f..5cafc642e647 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2741,7 +2741,7 @@ void __setparam_dl(struct task_struct *p, const struct sched_attr *attr)
 	dl_se->dl_runtime = attr->sched_runtime;
 	dl_se->dl_deadline = attr->sched_deadline;
 	dl_se->dl_period = attr->sched_period ?: dl_se->dl_deadline;
-	dl_se->flags = attr->sched_flags;
+	dl_se->flags = attr->sched_flags & SCHED_DL_FLAGS;
 	dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
 	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
 }
@@ -2754,7 +2754,8 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
 	attr->sched_runtime = dl_se->dl_runtime;
 	attr->sched_deadline = dl_se->dl_deadline;
 	attr->sched_period = dl_se->dl_period;
-	attr->sched_flags = dl_se->flags;
+	attr->sched_flags &= ~SCHED_DL_FLAGS;
+	attr->sched_flags |= dl_se->flags;
 }
 
 /*
@@ -2851,7 +2852,7 @@ bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 	if (dl_se->dl_runtime != attr->sched_runtime ||
 	    dl_se->dl_deadline != attr->sched_deadline ||
 	    dl_se->dl_period != attr->sched_period ||
-	    dl_se->flags != attr->sched_flags)
+	    dl_se->flags != (attr->sched_flags & SCHED_DL_FLAGS))
 		return true;
 
 	return false;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a243f7b..ad3aee63db26 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -227,6 +227,8 @@ static inline void update_avg(u64 *avg, u64 sample)
  */
 #define SCHED_FLAG_SUGOV	0x10000000
 
+#define SCHED_DL_FLAGS (SCHED_FLAG_RECLAIM | SCHED_FLAG_DL_OVERRUN | SCHED_FLAG_SUGOV)
+
 static inline bool dl_entity_is_special(struct sched_dl_entity *dl_se)
 {
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
-- 
2.32.0.432.gabb21c7263-goog


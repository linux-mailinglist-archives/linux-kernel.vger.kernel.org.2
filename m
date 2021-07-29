Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A352E3DAA81
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhG2Rw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhG2RwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:52:25 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B7C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:52:21 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id v7-20020ac874870000b029024e8ccfcd07so3076187qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LumGgLCeyK4KjVZYvtbb1+LUCYeCqpEP8VhQetdghNU=;
        b=wVpaleMoJoJChs6S3PUwQoyOdiErO3+JvkB5ediExtYYrxunHKaeb7c8qAxRaHtabl
         VSRp3XvD/CJFU0mziZ6tM8hHVZ6RfED3AQP00r2Ub0FgOnHcguxyclUpNXawntmJ5TeV
         6Bnt7RQv9VWlF+ipg0lx6MAUntjj49FhRvfjqBwVtBh1HWKyGc9Cgy0OPUtQfCEXxryX
         QSJjfN/5jTok0O6Us+bl6KsyS/LYBcF5w34M3SjBIyYfkCKZ/bXBCbrdxUTq+rSwMveU
         GqZmi3ZHPPz94xJ6f8McYts27OivZflLBAXm75nnGDhmziwTF1EkkmrvRm5I5guTzWpT
         i5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LumGgLCeyK4KjVZYvtbb1+LUCYeCqpEP8VhQetdghNU=;
        b=eL7Idah5TylQPZaMNH90qOmFLUOWOixkkWIvobJnmw4iTxHAPdfJ55728Q4jt0LrQE
         lohYxVRARgcfTu+c3bOU2qxgPB7qoaH+9d1aQUlxGNmqzzgmYaYEaZkHGsEwrOVtKrsk
         HE/PlWFNhg6fLmeKH+9Sw8wcOL9D5dQiZRCdIlTOMpscqvhW6L5Y4mE70htpVP+FP15u
         nLCw90uL/AU5Z4lhmfKqGOhlcXsS3rHEec7NjMTOZmbK/kCA8v3lmv1v1UTFNTH31qdZ
         dzmocQWcEKiPKNa07OkFPoFOqYSnxlDQAy5s5Yc6/5zo7jPvJyIHysMi8aYuMob2fzFx
         a9qw==
X-Gm-Message-State: AOAM531Djrjt0kJIBmEbYYttwdARmQ+4CHi9fhQGCfmjOkyvc9O/hZUT
        o/G9SQkkYFEUBCCQKnNRO+XdV86JMwmU
X-Google-Smtp-Source: ABdhPJwHd7MjZe7hbMBa55ZBCUnnsyrbcK54YENIxke1fN812v2QPnLaT3TTP0ngssYAtMBjZIDvR3uHX2Im
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a0c:e6a4:: with SMTP id
 j4mr6588994qvn.16.1627581140492; Thu, 29 Jul 2021 10:52:20 -0700 (PDT)
Date:   Thu, 29 Jul 2021 18:52:13 +0100
Message-Id: <20210729175214.294142-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2] sched/deadline: Fix sched_getattr() for DL tasks
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
Cc:     kernel-team@android.com, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In its current state, sched_getattr() can report incorrect sched_flags
if called on a deadline task.

Firstly, if the reset_on_fork flag is set on a deadline task using
sched_setattr() with SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_KEEP_PARAMS,
p->sched_reset_on_fork will be set but __setscheduler() will bail out
early without updating the dl_se->flags. Consequently, if sched_getattr
is then called on the same task, __getparam_dl() will override
kattr.sched_flags with the now out-of-date copy in dl_se->flags and
report a stale reset_on_fork value to userspace.

And secondly, sched_getattr() currently reports SCHED_FLAG_SUGOV as set
if called on a schedutil worker, despite this flag being a kernel-only
value that is not exposed in UAPI headers.

To fix both of these problems, make sure to only copy the flags that are
relevant to sched_deadline to dl_se->flags, and filter them out when
reporting them back to userspace.

Signed-off-by: Quentin Perret <qperret@google.com>
---
v1 can be found here:
https://lore.kernel.org/r/20210727101103.2729607-1-qperret@google.com/

Changes since v1:
 - squashed the two patches together
 - moved the SCHED_FLAG_SUGOV filtering to __getparam_dl()
---
 kernel/sched/deadline.c | 7 ++++---
 kernel/sched/sched.h    | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index aaacd6cfd42f..358a8a2acfc2 100644
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
+	attr->sched_flags |= dl_se->flags & ~SCHED_FLAG_SUGOV;
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
2.32.0.554.ge1b32706d8-goog


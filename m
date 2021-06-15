Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4713A7DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhFOMS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOMSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:18:25 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D34C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:16:20 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id p5-20020a9d45450000b029043ee61dce6bso6949558oti.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NjD4FPdgo2+nqswWfIZK1715ggnWF6oKIJl4krLrGGg=;
        b=JoVUNpYiXFjm/oDJpoxa7Y7wBz8+vi9wTo9DludKR6pKAj/bAk5MfKWLOaMZb35xcB
         qlPs7XVd+IAHUjj0U/KPzM+LgAeUv7LwOBEXsEfQLI+3JTnNMqJ02H3+9lGCACQaIVXq
         hkP+J05uALZttu54AJN4HLG5rTstFyqkvkA5x+OcKveUUj6ayCAIUQaNSRcpoVtfoIkT
         Q8nNgrAePOLpJrcdLBWWKwcPIg7ujLnw7BgzdASo2eRT1DjrsouSVyEBG094Ys3GCESG
         nQc+VZGLDUBL0vPY5P0Ro2Y9uS5o8D2Kj0mvlg3f9JiIcPd5uSL61xGKIz6rLZtxkPJ+
         Kodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NjD4FPdgo2+nqswWfIZK1715ggnWF6oKIJl4krLrGGg=;
        b=c/8iWqyYBHkeUJIt8YMKOaFrefa4TwLJK7LhDRTnmD551hSElPKUwmV6Xs9bPdoTwi
         +GFXfn3bXQ4uJf70WptD2TahOi9NcETERJTMFmHz9gP0zvDKEldqGZwqmfSAjJSsOjIC
         2T256qS9Jc9iQgZOnqJPySLTp6R/XuzGcPcCFHz1y1bVWjV3jlllI7REyOlIb253THVN
         r5e6u0td7PkLjliMKTmHH7MCHjC+ZH1l/M/UCCYUgFk7x/itwLwxpr1pmQO9SBUfJ6+h
         lLEEjtDedUrwsNnPrK1Lg1eRlaAFMjMx3fOYq6XSjR6dw663f5k8qzNrrMxP4AbiOoTU
         L1eg==
X-Gm-Message-State: AOAM533DyQY+wZu97YNNEjxsVcv0c7XGXz/iB549RoAeZVEITMLRuoed
        rDMjBaxoGUL3h523Nbpx/MNQBH9mCWEO7A==
X-Google-Smtp-Source: ABdhPJy6AX/M+s/gk8LkeTnPf43vGExBV3VPlr35MxKPIzt/vNk4BKyTjBa89xFyI8R/YkydTR8tpQ==
X-Received: by 2002:a9d:4104:: with SMTP id o4mr17948463ote.139.1623759379663;
        Tue, 15 Jun 2021 05:16:19 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id w23sm1753507ott.20.2021.06.15.05.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 05:16:19 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH] sched, fair: try to prevent migration thread from preempting non-cfs task
Date:   Tue, 15 Jun 2021 20:15:51 +0800
Message-Id: <20210615121551.31138-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We monitored our latency-sensitive RT tasks are randomly preempted by the
kthread migration/n, which means to migrate task from CPUn to the new
idle CPU which wakes up the migration/n. For example,

    sensing_node-2511    [007] d...   945.351566: sched_switch: prev_comm=sensing_node prev_pid=2511 prev_prio=98 prev_state=S ==> next_comm=cat next_pid=2686 next_prio=120
             cat-2686    [007] d...   945.351569: sched_switch: prev_comm=cat prev_pid=2686 prev_prio=120 prev_state=R+ ==> next_comm=sensing_node next_pid=2512 next_prio=98
    sensing_node-2516    [004] dn..   945.351571: sched_wakeup: comm=migration/7 pid=47 prio=0 target_cpu=007
    sensing_node-2512    [007] d...   945.351572: sched_switch: prev_comm=sensing_node prev_pid=2512 prev_prio=98 prev_state=R ==> next_comm=migration/7 next_pid=47 next_prio=0
    sensing_node-2516    [004] d...   945.351572: sched_switch: prev_comm=sensing_node prev_pid=2516 prev_prio=98 prev_state=S ==> next_comm=sensing_node next_pid=2502 next_prio=98
     migration/7-47      [007] d...   945.351580: sched_switch: prev_comm=migration/7 prev_pid=47 prev_prio=0 prev_state=S ==> next_comm=sensing_node next_pid=2512 next_prio=98
    sensing_node-2502    [004] d...   945.351605: sched_switch: prev_comm=sensing_node prev_pid=2502 prev_prio=98 prev_state=S ==> next_comm=cat next_pid=2686 next_prio=120

When CPU4 is waking migration/7, the CFS thread 'cat' is running on
CPU7, but then 'cat' is preempted by a RT task 'sensing_node', and
then the migration/7 preempts the RT task. The race happens between:
    if (need_active_balance(&env)) {
and
        raw_spin_rq_lock_irqsave(busiest, flags);

In order to reduce the race, we'd better do the last minute check before
waking up migration thread.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>

---

- Prev version
  https://lore.kernel.org/lkml/CAKfTPtBd349eyDhA5ThCAHFd83cGMQKb_LDxD4QvyP-cJOBjqA@mail.gmail.com/

- Similar discussion
  https://lore.kernel.org/lkml/CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com/
---
 kernel/sched/fair.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3248e24a90b0..597c7a940746 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9797,6 +9797,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			/* Record that we found at least one task that could run on this_cpu */
 			env.flags &= ~LBF_ALL_PINNED;
 
+			/*
+			 * There may be a race between load balance starting migration
+			 * thread to pull the cfs running thread and the RT thread
+			 * waking up and preempting cfs task before migration threads
+			 * which then preempt the RT thread.
+			 * We'd better do the last minute check before starting
+			 * migration thread to avoid preempting latency-sensitive thread.
+			 */
+			if (busiest->curr->sched_class != &fair_sched_class) {
+				raw_spin_unlock_irqrestore(&busiest->lock,
+							   flags);
+				goto out;
+			}
+
 			/*
 			 * ->active_balance synchronizes accesses to
 			 * ->active_balance_work.  Once set, it's cleared
-- 
2.17.1


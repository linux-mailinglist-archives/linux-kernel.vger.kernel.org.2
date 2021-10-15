Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED9942F163
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhJOMwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbhJOMwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:52:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5857AC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:50:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g198-20020a1c20cf000000b0030d60cd7fd6so2307474wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sJ9kRmn9CGYL+5N8FlFThe9vRb2XXlEgDB+zrOX5bP4=;
        b=ckdyIQqfZy9y/WFG7SWDYc3bLfqv7WD0S53uXi8Ohr8T03a/bDpZBIpDGkITMxvlpO
         5O1IUgio24zV+dgX3IyEtYGRxfj6ykfjRNBtesnuwivJK6147/ttZ5bycXxRSPKEI8TG
         JxFAgBDOJ5Y3WZKi7SDP6v0WebOWGz53uTl4GvQYclabJIUgmGWINOpHRXVp/XuG+sSA
         DB+zU/GvMmilDJ0jsl+RzGXkIRCq58vSswO7FUoFh5jJgwEYMRhMBNNCAVP2qi1JV8z7
         CctzE9GRkNXKR0XZmSwZIRr4Rynzb1dVqF5MPs6nveuWo8KXE5A4k4POA73Q7mPycob+
         Ssbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sJ9kRmn9CGYL+5N8FlFThe9vRb2XXlEgDB+zrOX5bP4=;
        b=GHIPA6ELx56nQcFMgDlegQ3NvQBOdx+QA9gR7mrj6j3WGgMVZAjU6LiEJMXXf7ft4g
         3GE+lmGzuXWlLBpjOqOHBVnsYLf6hoqXjlY0iHbweCVeRGnNH8aIV931Rylkd4bPMgE+
         kSEfUxOhr0zHjypS7C6I/u9qbvcwXBnwbQJ2pwq2WVlrZRvfCEuKgshBDh3bryUbTzCj
         RrN54PeYIToeYjHIB4OUCb+EhrDjpgQoHfoFzSejBkX0ORIuv5tHPra5lzyb29O0ifQn
         e2YXKBoaKr1aghIAgSBRCN9785TRu5Sg6lHwwGJckc6wab0E85ux+1LHEZ0QAZh2G/zu
         3z2A==
X-Gm-Message-State: AOAM530HrqnTRshypqi3FliH8RGdrY3Ol6TJ+8YXv/6T51FwP59cCcZA
        QjV/q5pZIp7fIElHf1/bEDk1Dw==
X-Google-Smtp-Source: ABdhPJxGhFMx7IVzEPy3vqLsaQAnk4Op7zj0caWCCtkxyl1J69EhU6w9H6jlDBOAiRGSBvhrm6Y2iA==
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr11883106wmk.149.1634302230837;
        Fri, 15 Oct 2021 05:50:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:7ce7:a27f:aba7:bb9d])
        by smtp.gmail.com with ESMTPSA id a2sm5468403wrq.9.2021.10.15.05.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:50:29 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/4] Improve newidle lb cost tracking and early abort
Date:   Fri, 15 Oct 2021 14:46:50 +0200
Message-Id: <20211015124654.18093-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset updates newidle lb cost tracking and early abort:

The time spent running update_blocked_averages is now accounted in the 1st
sched_domain level. This time can be significant and move the cost of
newidle lb above the avg_idle time.

The decay of max_newidle_lb_cost is modified to start only when the field
has not been updated for a while. Recent update will not be decayed
immediatlybut only after a while.

The condition of an avg_idle lower than sysctl_sched_migration_cost has
been removed as the 500us value is quite large and prevent opportunity to
pull task on the newly idle CPU for at least 1st domain levels.

Monitoring sd->max_newidle_lb_cost on cpu0 of a Arm64 system
THX2 (2 nodes * 28 cores * 4 cpus) during the benchmarks gives the
following results:
       min    avg   max
SMT:   1us   33us  273us - this one includes the update of blocked load
MC:    7us   49us  398us
NUMA: 10us   45us  158us


Some results for hackbench -l $LOOPS -g $group :
group      tip/sched/core     + this patchset
1           15.189(+/- 2%)       14.987(+/- 2%)  +1%
4            4.336(+/- 3%)        4.322(+/- 5%)  +0%
16           3.654(+/- 1%)        2.922(+/- 3%) +20%
32           3.209(+/- 1%)        2.919(+/- 3%)  +9%
64           2.965(+/- 1%)        2.826(+/- 1%)  +4%
128          2.954(+/- 1%)        2.993(+/- 8%)  -1%
256          2.951(+/- 1%)        2.894(+/- 1%)  +2%

tbench and reaim have not shown any difference

Change since v1:
- account the time spent in update_blocked_averages() in the 1st domain

- reduce number of call of sched_clock_cpu() 

- change the way max_newidle_lb_cost is decayed. Peter suggested to use a
  IIR but keeping a track of the current max value gave the best result

- removed the condition (this_rq->avg_idle < sysctl_sched_migration_cost)
  as suggested by Peter

Vincent Guittot (4):
  sched/fair: Account update_blocked_averages in newidle_balance cost
  sched/fair: Skip update_blocked_averages if we are defering load
    balance
  sched/fair: Wait before decaying max_newidle_lb_cost
  sched/fair: Remove sysctl_sched_migration_cost condition

 include/linux/sched/topology.h |  2 +-
 kernel/sched/fair.c            | 29 ++++++++++++++++++-----------
 kernel/sched/topology.c        |  2 +-
 3 files changed, 20 insertions(+), 13 deletions(-)

-- 
2.17.1


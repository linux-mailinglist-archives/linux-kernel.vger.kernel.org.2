Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7B43360E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhJSMh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhJSMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:37:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB19C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k7so47276715wrd.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6ESHQOo9KySzj+CoCPClGyaxb6lsjeZdTqttkXRUbsM=;
        b=J1eKkiRReI/jo4nvnXN28MxZt0b0JOxrEmv1OZThkjU2bxXVlFeN81h99SP4gqfPuJ
         bzzeWrmZwWkTx5NNAdL4CJf/WC8Ux5tfQNnYbM4F0zsm2GxwUehFYK3Z7Tv7vjzP0dJl
         m2osxOIktXW6oUxwpljAdrGeXdKBuB0LHlOidXjOl1InnarZmNcAR4DIGnd14DFKibyh
         JLIvP2G2sogOtBQI1U9emjRDZE3yxUock6JptUmDtCeMoROgmsjN13Coavl0WOdwUtpu
         HmN1mxN/pJpfBKPputFBvsaFYommewU3b/GyQ2bX3GAbpnJf1G6cnmxIBxFp7ej7WvKK
         5I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6ESHQOo9KySzj+CoCPClGyaxb6lsjeZdTqttkXRUbsM=;
        b=W9cgXSypTeWjdWll1DcwCCZwKT4WERsMhMB/V69szg8KXiIQFOjER5s+WGfPehRATs
         DLmTCLtG56nYo0BIwvuI8N8nfNqaegqF2PMRv99pMTg6/6BMS48Xc7/9L2DPSS1V81L7
         Lpm3IKM02dNlk2wvTRFsTY6KWvUQnzfQnHkiKWBXdVeYhhE5t8qC5bylMKAAgpLXj8x9
         TXFNsuaGUkeCC4Rg7EPKQc2Wgm60gXa26+MnywF16rFen1aWEmK0Z+kpcPdvEtglsULb
         Qg/QtjDKPLH1oKDfmynN6yf7fbLgehF4yvrfivUbPj4E6T11bobmM0TVYb11w1VBfPLW
         lRXA==
X-Gm-Message-State: AOAM530C76zsNTPSTvZBGDWgIcO5oMjQ94AX4Vc6ah8YX1T2T1ti1m66
        sUhxMTw/2vGlTpxjs2xq21WhRA==
X-Google-Smtp-Source: ABdhPJxtcUBehLH/kWC+8xC+IwhQqMeTHFzatk9gewxEumfqCdo5aNk8BMYKT/CJwtGY4Tx3vfHaIg==
X-Received: by 2002:adf:8bcf:: with SMTP id w15mr44267036wra.144.1634646942550;
        Tue, 19 Oct 2021 05:35:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6dc7:9883:a79c:5be9])
        by smtp.gmail.com with ESMTPSA id p18sm15263683wrn.41.2021.10.19.05.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:35:41 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
Date:   Tue, 19 Oct 2021 14:35:32 +0200
Message-Id: <20211019123537.17146-1-vincent.guittot@linaro.org>
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

Change since v2:
- Update and decay of sd->last_decay_max_lb_cost are gathered in
  update_newidle_cost(). The behavior remains almost the same except that
  the decay can happen during newidle_balance now.

  Tests results haven't shown any differences
  
  I haven't modified rq->max_idle_balance_cost. It acts as the max value
  for avg_idle and prevents the latter to reach high value during long
  idle phase. Moving on an IIR filter instead, could delay the convergence
  of avg_idle to a reasonnable value that reflect current situation.

- Added a minor cleanup of newidle_balance

Change since v1:
- account the time spent in update_blocked_averages() in the 1st domain

- reduce number of call of sched_clock_cpu() 

- change the way max_newidle_lb_cost is decayed. Peter suggested to use a
  IIR but keeping a track of the current max value gave the best result

- removed the condition (this_rq->avg_idle < sysctl_sched_migration_cost)
  as suggested by Peter

Vincent Guittot (5):
  sched/fair: Account update_blocked_averages in newidle_balance cost
  sched/fair: Skip update_blocked_averages if we are defering load
    balance
  sched/fair: Wait before decaying max_newidle_lb_cost
  sched/fair: Remove sysctl_sched_migration_cost condition
  sched/fair: cleanup newidle_balance

 include/linux/sched/topology.h |  2 +-
 kernel/sched/fair.c            | 65 ++++++++++++++++++++++------------
 kernel/sched/topology.c        |  2 +-
 3 files changed, 45 insertions(+), 24 deletions(-)

-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9728836E892
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbhD2KU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:20:59 -0400
Received: from foss.arm.com ([217.140.110.172]:46144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232629AbhD2KUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:20:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C1AE1FB;
        Thu, 29 Apr 2021 03:20:02 -0700 (PDT)
Received: from e120189.arm.com (unknown [10.57.56.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B3483F70D;
        Thu, 29 Apr 2021 03:19:58 -0700 (PDT)
From:   Pierre.Gondois@arm.com
To:     linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        qperret@qperret.net, dietmar.eggemann@arm.com
Cc:     Lukasz.Luba@arm.com, Vincent.Donnefort@arm.com,
        Pierre Gondois <Pierre.Gondois@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Subject: [PATCH v2 0/2] sched/fair: find_energy_efficient_cpu() enhancements
Date:   Thu, 29 Apr 2021 11:19:46 +0100
Message-Id: <20210429101948.31224-1-Pierre.Gondois@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Gondois <Pierre.Gondois@arm.com>

V2:
 - Split the patch in 2. [Quentin]
 - Add testing results to the cover-letter. [Dietmar]
 - Put back 'rcu_read_unlock()' to unlock the rcu
   earlier. [Dietmar]
 - Various comments. [Dietmar/Quentin]

This patchset prevents underflows in find_energy_efficient_cpu().
This is done in the second patch:
sched/fair: Fix negative energy delta in find_energy_efficient_cpu()

The first patch:
sched/fair: Only compute base_energy_pd if necessary
prevents an unnecessary call to compute_energy() if no CPU is available
in a performance domain (pd).
When looping over the pds, it also allows to gather the calls
to compute_energy(), reducing the chances of having utilization signals
being concurrently updated and having a 'negative delta'.

The energy tests of the initial EAS enablement at:
https://lkml.kernel.org/r/20181203095628.11858-1-quentin.perret@arm.com
have been executed using LISA on a Juno-r2 (2xA57 + 4xA53).

To recall the test:
"10 iterations of between 10 and 50 periodic rt-app tasks (16ms period, 
5% duty-cycle) for 30 seconds with energy measurement. Unit is Joules. 
The goal is to save energy, so lower is better."
"Energy is measured with the onboard energy meter. Numbers include 
consumption of big and little CPUs."

+----------+-----------------+-------------------------+
|          | Without patches | With patches            |
+----------+--------+--------+------------------+------+
| Tasks nb |  Mean  |    CI* | Mean             |  CI* |
+----------+--------+--------+------------------+------+
|       10 |   6.57 |   0.24 |   6.46 (-1.63%)  | 0.27 |
|       20 |  12.44 |   0.21 |  12.44 (-0.01%)  | 0.14 |
|       30 |  19.10 |   0.78 |  18.75 (-1.85%)  | 0.15 |
|       40 |  27.27 |   0.53 |  27.35 (+0.31%)  | 0.33 |
|       50 |  36.55 |   0.42 |  36.28 (-0.74%)  | 0.42 |
+----------+-----------------+-------------------------+
CI: confidence interval

For each line, the intervals of values w/ w/o the patches are 
overlapping (consider Mean +/- CI). Thus, the energy results shouldn't 
have been impacted.

Pierre Gondois (2):
  sched/fair: Only compute base_energy_pd if necessary
  sched/fair: Fix negative energy delta in find_energy_efficient_cpu()

 kernel/sched/fair.c | 66 ++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59FB4364D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhJUO6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:58:32 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:52771 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhJUO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:58:31 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 4D8B81C41C8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:56:14 +0100 (IST)
Received: (qmail 9691 invoked from network); 21 Oct 2021 14:56:13 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 21 Oct 2021 14:56:13 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/2] Reduce stacking and overscheduling
Date:   Thu, 21 Oct 2021 15:56:01 +0100
Message-Id: <20211021145603.5313-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series tackles two problems. The first is that heavy wakers
can stack an excessive number of tasks on the same CPU. The
second is that tasks can overschedule when the task has not
reached its minimum preemption granularity.

The patches are independent but were discussed together in the thread
https://lore.kernel.org/r/20210920142614.4891-1-mgorman@techsingularity.net
so are presented together.

With both patches on a zen3 machine

hackbench-process-pipes
                          5.15.0-rc3             5.15.0-rc3
                             vanilla sched-scalewakegran-v3r2
Amean     1        0.3667 (   0.00%)      0.3823 (  -4.27%)
Amean     4        0.5343 (   0.00%)      0.4867 (   8.92%)
Amean     7        0.5300 (   0.00%)      0.5053 (   4.65%)
Amean     12       0.5737 (   0.00%)      0.5450 (   5.00%)
Amean     21       0.6727 (   0.00%)      0.6807 (  -1.19%)
Amean     30       0.8583 (   0.00%)      0.7107 *  17.20%*
Amean     48       1.3977 (   0.00%)      1.0447 *  25.26%*
Amean     79       1.9790 (   0.00%)      1.6033 *  18.98%*
Amean     110      2.8020 (   0.00%)      2.0763 *  25.90%*
Amean     141      3.6683 (   0.00%)      2.5313 *  31.00%*
Amean     172      4.6687 (   0.00%)      3.1163 *  33.25%*
Amean     203      5.2183 (   0.00%)      3.5560 *  31.86%*
Amean     234      6.1077 (   0.00%)      3.8913 *  36.29%*
Amean     265      7.1313 (   0.00%)      4.2293 *  40.69%*
Amean     296      7.7557 (   0.00%)      4.5357 *  41.52%*

                  5.15.0-rc3  5.15.0-rc3
                     vanilla sched-scalewakegran-v3r2
Duration User        2933.05     2034.17
Duration System     25652.83    17137.08
Duration Elapsed      162.50      120.25

-- 
2.31.1

Mel Gorman (2):
  sched/fair: Couple wakee flips with heavy wakers
  sched/fair: Increase wakeup_gran if current task has not executed the
    minimum granularity

 kernel/sched/fair.c     | 27 ++++++++++++++++++++++++---
 kernel/sched/features.h |  2 ++
 2 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.31.1


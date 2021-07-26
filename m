Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2383D5758
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhGZJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:42:32 -0400
Received: from outbound-smtp57.blacknight.com ([46.22.136.241]:40643 "EHLO
        outbound-smtp57.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229593AbhGZJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:42:30 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id 7E86EFA752
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:22:58 +0100 (IST)
Received: (qmail 21543 invoked from network); 26 Jul 2021 10:22:58 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 26 Jul 2021 10:22:58 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 0/9] Modify and/or delete SIS_PROP
Date:   Mon, 26 Jul 2021 11:22:38 +0100
Message-Id: <20210726102247.21437-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scanning for an idle CPU, SIS_PROP limits the scan based on an average
estimated idle time for a domain but it's a somewhat inconsistent and
fuzzy heuristic. Idle time of a CPU does not necessarily correlate with
idle time of a domain, scanning for an idle core is not throttled at all
and successful scans are not accounted for.

The first three patches are accounting patches to put some numbers on the
scan efficiency. Ultimately, they may not be merged but they are useful
for determining if a patch works as advertised.

Patch 4 improves recent_used_cpu to reduce the amount of scanning that is
done in absolute terms.

Patch 5 notes that the target CPU has already been scanned with
select_idle_cpu starts and therefore should be skipped.

Patches 6-9 replace SIS_PROP with a scheme based on partially tracking
idle CPUs, first proposed by Aubrey Li and modified by this series.
It is likely to be the most controversial, not necessary a win, but the
possibility was discussed. The series is likely to be split with one
series being patches 4-5 and a second being patches 6-9.

The series is not a univeral win or loss but there are some improvements
and overall, scan efficiencies are improved. A limiting factor in the
evaluation is that tracking the statistics is expensive on its own and
all tests were run with schedstat enabled.

Depending on how this RFC is received, testing would be done without
schedstat and the series may be split.

 include/linux/sched/topology.h |  13 +++
 kernel/sched/core.c            |   7 +-
 kernel/sched/debug.c           |   8 ++
 kernel/sched/fair.c            | 149 ++++++++++++++++++---------------
 kernel/sched/features.h        |   5 --
 kernel/sched/idle.c            |   5 ++
 kernel/sched/sched.h           |  17 +++-
 kernel/sched/stats.c           |  10 ++-
 kernel/sched/topology.c        |   3 +-
 9 files changed, 133 insertions(+), 84 deletions(-)

-- 
2.26.2


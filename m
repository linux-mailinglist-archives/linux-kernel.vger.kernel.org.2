Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3765C3D5762
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhGZJnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:43:23 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:55334 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232099AbhGZJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:43:21 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id BAEB8CAC8A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:23:49 +0100 (IST)
Received: (qmail 23264 invoked from network); 26 Jul 2021 10:23:49 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 26 Jul 2021 10:23:49 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5/9] sched/fair: Avoid a second scan of target in select_idle_cpu
Date:   Mon, 26 Jul 2021 11:22:43 +0100
Message-Id: <20210726102247.21437-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726102247.21437-1-mgorman@techsingularity.net>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When select_idle_cpu starts scanning for an idle CPU, it starts with
a target CPU that has already been checked by select_idle_sibling.
This patch starts with the next CPU instead.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 75ff991a460a..125c020746b8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6254,7 +6254,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		time = cpu_clock(this);
 	}
 
-	for_each_cpu_wrap(cpu, cpus, target) {
+	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
 			if ((unsigned int)i < nr_cpumask_bits)
-- 
2.26.2


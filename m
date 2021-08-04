Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF83E00AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbhHDL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:59:46 -0400
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:39662 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235848AbhHDL7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:59:44 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id 5A86EBAC23
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 12:59:30 +0100 (IST)
Received: (qmail 30195 invoked from network); 4 Aug 2021 11:59:29 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 4 Aug 2021 11:59:29 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] sched/fair: Avoid a second scan of target in select_idle_cpu
Date:   Wed,  4 Aug 2021 12:58:57 +0100
Message-Id: <20210804115857.6253-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804115857.6253-1-mgorman@techsingularity.net>
References: <20210804115857.6253-1-mgorman@techsingularity.net>
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
index 8ad7666f387c..f412b4504378 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6249,7 +6249,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		time = cpu_clock(this);
 	}
 
-	for_each_cpu_wrap(cpu, cpus, target) {
+	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
 			if ((unsigned int)i < nr_cpumask_bits)
-- 
2.31.1


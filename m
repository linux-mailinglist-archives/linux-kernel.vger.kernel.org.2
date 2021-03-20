Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74084342FD8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhCTWVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:21:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14413 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTWVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:21:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F2wDF03CVzkYy4;
        Sun, 21 Mar 2021 06:19:41 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.194) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sun, 21 Mar 2021 06:21:07 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vincent.guittot@linaro.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <valentin.schneider@arm.com>, <aubrey.li@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xuwei5@huawei.com>,
        <prime.zeng@hisilicon.com>, <guodong.xu@linaro.org>,
        <yangyicong@huawei.com>, <liguozhu@hisilicon.com>,
        <linuxarm@openeuler.org>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] sched/fair: remove redundant test_idle_cores for non-smt
Date:   Sun, 21 Mar 2021 11:14:32 +1300
Message-ID: <20210320221432.924-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.194]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_idle_core() is only done for the case of sched_smt_present.
but test_idle_cores() is done for all machines even those without
smt.
this could contribute to up 8%+ hackbench performance loss on a
machine like kunpeng 920 which has no smt. this patch removes the
redundant test_idle_cores() for non-smt machines.

we run the below hackbench with different -g parameter from 2 to
14, for each different g, we run the command 10 times and get the
average time:
$ numactl -N 0 hackbench -p -T -l 20000 -g $1

hackbench will report the time which is needed to complete a certain
number of messages transmissions between a certain number of tasks,
for example:
$ numactl -N 0 hackbench -p -T -l 20000 -g 10
Running in threaded mode with 10 groups using 40 file descriptors each
(== 400 tasks)
Each sender will pass 20000 messages of 100 bytes

The below is the result of hackbench w/ and w/o this patch:
g=    2      4     6       8      10     12      14
w/o: 1.8151 3.8499 5.5142 7.2491 9.0340 10.7345 12.0929
w/ : 1.8428 3.7436 5.4501 6.9522 8.2882  9.9535 11.3367
                          +4.1%  +8.3%  +7.3%   +6.3%

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2e2ab1e..de42a32 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6038,9 +6038,11 @@ static inline bool test_idle_cores(int cpu, bool def)
 {
 	struct sched_domain_shared *sds;
 
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds)
-		return READ_ONCE(sds->has_idle_cores);
+	if (static_branch_likely(&sched_smt_present)) {
+		sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+		if (sds)
+			return READ_ONCE(sds->has_idle_cores);
+	}
 
 	return def;
 }
-- 
1.8.3.1


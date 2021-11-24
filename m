Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337E045B6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhKXJAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:00:03 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28102 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhKXJAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:00:02 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HzZZ35QP3z1DJST;
        Wed, 24 Nov 2021 16:54:19 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 16:56:51 +0800
Received: from localhost.localdomain (10.67.165.103) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 24 Nov 2021 16:56:51 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <mgorman@suse.de>, <linux-kernel@vger.kernel.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>
Subject: [PATCH] sched/fair: Clear target from cpus to scan in select_idle_cpu
Date:   Wed, 24 Nov 2021 16:54:01 +0800
Message-ID: <20211124085401.14411-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.103]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 56498cfb045d noticed that "When select_idle_cpu starts scanning for
an idle CPU, it starts with a target CPU that has already been checked
by select_idle_sibling. This patch starts with the next CPU instead."
It only changed the scanning start cpu to target + 1 but still leave
the target in the scanning cpumask. The target still have a chance to be
checked in the last turn. Fix this by clear the target from the cpus
to scan.

Fixes: 56498cfb045d ("sched/fair: Avoid a second scan of target in select_idle_cpu")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6d9435..e1031e0da231 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6249,6 +6249,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		return -1;
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	cpumask_clear_cpu(target, cpus);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
-- 
2.33.0


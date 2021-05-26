Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344F2391385
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhEZJUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:20:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3948 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhEZJUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:20:05 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fqlfh0xv7zCxB2;
        Wed, 26 May 2021 17:15:40 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 17:18:30 +0800
Received: from SWX921481.china.huawei.com (10.126.203.64) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 26 May 2021 17:18:27 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vincent.guittot@linaro.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>
CC:     <valentin.schneider@arm.com>, <juri.lelli@redhat.com>,
        <bristot@redhat.com>, <linux-kernel@vger.kernel.org>,
        <guodong.xu@linaro.org>, <yangyicong@huawei.com>,
        <tangchengchang@huawei.com>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] sched: fair: don't depend on wake_wide if waker and wakee are already in same LLC
Date:   Wed, 26 May 2021 21:10:57 +1200
Message-ID: <20210526091057.1800-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.64]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi761-chm.china.huawei.com (10.1.198.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when waker and wakee are already in the same LLC, it is pointless to worry
about the competition caused by pulling wakee to waker's LLC domain.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3248e24a90b0..cfb1bd47acc3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6795,7 +6795,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 			new_cpu = prev_cpu;
 		}
 
-		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
+		/*
+		 * we use wake_wide to make smarter pull and avoid cruel
+		 * competition because of jam-packed tasks in waker's LLC
+		 * domain. But if waker and wakee have been already in
+		 * same LLC domain, it seems it is pointless to depend
+		 * on wake_wide
+		 */
+		want_affine = (cpus_share_cache(cpu, prev_cpu) || !wake_wide(p)) &&
+				cpumask_test_cpu(cpu, p->cpus_ptr);
 	}
 
 	rcu_read_lock();
-- 
2.25.1


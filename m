Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C7E40AB27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhINJyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:54:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15411 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhINJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:54:17 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H7z7n0nZLzR98n;
        Tue, 14 Sep 2021 17:48:53 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 17:52:49 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Tue, 14
 Sep 2021 17:52:49 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] sched: Remove unused inline function __rq_clock_broken()
Date:   Tue, 14 Sep 2021 17:52:44 +0800
Message-ID: <20210914095244.52780-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These is no caller in tree since commit
523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/sched/sched.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 43e7fbe06557..4bca12681802 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1424,11 +1424,6 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 
 extern void update_rq_clock(struct rq *rq);
 
-static inline u64 __rq_clock_broken(struct rq *rq)
-{
-	return READ_ONCE(rq->clock);
-}
-
 /*
  * rq::clock_update_flags bits
  *
-- 
2.17.1


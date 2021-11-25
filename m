Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D819445D330
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 03:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhKYCiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 21:38:03 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31903 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhKYCgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 21:36:01 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J023M0wWSzcbZH;
        Thu, 25 Nov 2021 10:32:47 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 10:32:49 +0800
Received: from huawei.com (10.175.100.227) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 25 Nov
 2021 10:32:48 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        Tang Yizhou <tangyizhou@huawei.com>
Subject: [PATCH 1/2] sched/pelt: Remove redundant variable in __accumulate_pelt_segments
Date:   Thu, 25 Nov 2021 11:00:18 +0800
Message-ID: <20211125030019.10447-2-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211125030019.10447-1-tangyizhou@huawei.com>
References: <20211125030019.10447-1-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the comment of function accumulate_sum() describes the equation clearly,
There is no need to use a redundant variable c3. Let's make a comment for
d3 directly.

Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
---
 kernel/sched/pelt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a554e3bbab2b..3584df2a0b8e 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -60,7 +60,7 @@ static u64 decay_load(u64 val, u64 n)
 
 static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
 {
-	u32 c1, c2, c3 = d3; /* y^0 == 1 */
+	u32 c1, c2;
 
 	/*
 	 * c1 = d1 y^p
@@ -78,7 +78,7 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
 	 */
 	c2 = LOAD_AVG_MAX - decay_load(LOAD_AVG_MAX, periods) - 1024;
 
-	return c1 + c2 + c3;
+	return c1 + c2 + d3;  /* d3: y^0 == 1 */
 }
 
 /*
-- 
2.17.1


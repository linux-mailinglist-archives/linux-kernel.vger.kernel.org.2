Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97C1331D0C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhCIClH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:41:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13453 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhCICk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:40:29 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DvfXy0G6czjVVZ;
        Tue,  9 Mar 2021 10:38:58 +0800 (CST)
Received: from huawei.com (10.175.112.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Mar 2021
 10:40:16 +0800
From:   Xiangyang Yu <yuxiangyang4@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <dvhart@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <yuxiangyang4@Huawei.com>
Subject: [PATCH] kernel/futex: Change pi_state_update_owner() to an inline function
Date:   Tue, 9 Mar 2021 10:40:12 +0800
Message-ID: <20210309024012.1391035-1-yuxiangyang4@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our performance tests, we find that the performance of
sysbench is descend. Function call consumes too many instructions,
change pi_state_update_owner() to an inline function.

Test environment:
CPU: Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz * 2
MEM: 312G

Test case: https://github.com/akopytov/sysbench
Test cmd: ./sysbench --test=threads --num-threads=$thr
              --thread-yields=100 --thread-locks=2 run

$thr    stock   non-inline   inline
256    0.8511     0.9254     0.8588
512    0.8489     0.9232     0.8503
1024   0.8347     0.9248     0.8495
2048   0.8338     0.9575     0.8402

Signed-off-by: Xiangyang Yu <yuxiangyang4@huawei.com>
---
 kernel/futex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index e68db7745039..570dee4e9e6f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -763,7 +763,7 @@ static struct futex_pi_state *alloc_pi_state(void)
 	return pi_state;
 }
 
-static void pi_state_update_owner(struct futex_pi_state *pi_state,
+static inline void pi_state_update_owner(struct futex_pi_state *pi_state,
 				  struct task_struct *new_owner)
 {
 	struct task_struct *old_owner = pi_state->owner;
-- 
2.23.0


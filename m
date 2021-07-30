Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120813DB716
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhG3KZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:25:11 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53016 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238274AbhG3KZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:25:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UhQblfO_1627640692;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UhQblfO_1627640692)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Jul 2021 18:24:55 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] lockdep/selftests: Fix duplicate included locking-selftest-softirq.h
Date:   Fri, 30 Jul 2021 18:24:42 +0800
Message-Id: <1627640682-14225-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following includecheck warning:

./lib/locking-selftest.c: locking-selftest-softirq.h is included more
than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: cae2ed9aa573 ("[PATCH] lockdep: locking API self tests")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 lib/locking-selftest.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 161108e..6010445 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1252,7 +1252,6 @@ static void rwsem_ABBA3(void)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_wlock)
 
-#include "locking-selftest-softirq.h"
 #include "locking-selftest-rlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_rlock)
 
@@ -1306,7 +1305,6 @@ static void rwsem_ABBA3(void)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_hard_wlock)
 
-#include "locking-selftest-softirq.h"
 #include "locking-selftest-rlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_rlock)
 
-- 
1.8.3.1


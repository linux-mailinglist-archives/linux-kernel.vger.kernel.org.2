Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8B43DC5F1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhGaMbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 08:31:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7771 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhGaMbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 08:31:35 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GcNlB0kj5zYgVs;
        Sat, 31 Jul 2021 20:25:26 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 20:31:25 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 20:31:24 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] locking/rtmutex: Add the missing 'ES' of macro CONFIG_DEBUG_RT_MUTEXES
Date:   Sat, 31 Jul 2021 20:30:11 +0800
Message-ID: <20210731123011.4555-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build option name is defined as DEBUG_RT_MUTEXES in lib/Kconfig.debug,
commit f41dcc18698e ("locking/rtmutex: Move debug functions as inlines
into common header") can also corroborate this.

Fixes: f7efc4799f81 ("locking/rtmutex: Inline chainwalk depth check")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b5d9bb5202c6..ad0db322ed3b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -343,7 +343,7 @@ static __always_inline bool
 rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
 			      enum rtmutex_chainwalk chwalk)
 {
-	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEX))
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
 		return waiter != NULL;
 	return chwalk == RT_MUTEX_FULL_CHAINWALK;
 }
-- 
2.25.1


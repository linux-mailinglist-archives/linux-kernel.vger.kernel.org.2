Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B3F3E3DE0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 04:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhHICMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 22:12:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8378 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhHICMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 22:12:40 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gjfd40dDmz85LR;
        Mon,  9 Aug 2021 10:08:24 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 10:12:19 +0800
Received: from use12-sp2.huawei.com (10.67.189.174) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 9 Aug 2021 10:12:18 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
        <boqun.feng@gmail.com>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <xiaoqian9@huawei.com>, <shaolexi@huawei.com>
Subject: [PATCH] semaphore: Add might_sleep() to down_*() family
Date:   Mon, 9 Aug 2021 10:12:15 +0800
Message-ID: <20210809021215.19991-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema774-chm.china.huawei.com (10.1.198.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Semaphore is sleeping lock. Add might_sleep() to down*() family
(with exception of down_trylock()) to detect atomic context sleep.

Previously discussed with Peter Zijlstra, see link:
 https://lore.kernel.org/lkml/20210806082320.GD22037@worktop.programming.kicks-ass.net

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 kernel/locking/semaphore.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 9aa855a96c4a..9ee381e4d2a4 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -54,6 +54,7 @@ void down(struct semaphore *sem)
 {
 	unsigned long flags;
 
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
@@ -77,6 +78,7 @@ int down_interruptible(struct semaphore *sem)
 	unsigned long flags;
 	int result = 0;
 
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
@@ -103,6 +105,7 @@ int down_killable(struct semaphore *sem)
 	unsigned long flags;
 	int result = 0;
 
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
@@ -157,6 +160,7 @@ int down_timeout(struct semaphore *sem, long timeout)
 	unsigned long flags;
 	int result = 0;
 
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
-- 
2.27.0


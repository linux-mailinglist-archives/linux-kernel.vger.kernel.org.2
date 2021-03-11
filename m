Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA313372D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhCKMhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:37:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233231AbhCKMh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:37:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71F9764FE6;
        Thu, 11 Mar 2021 12:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615466245;
        bh=xoDQhYeHDbYrvOHhbPLwzFOvTOQNU8e/De6Dq0M4ByQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lygqAWrsw0cAjANwrNn+32fJYokyJh+qnofSSztfNSbgfRKsA47KFS1eBoJ6fqzKB
         QLlZxyKEfZj3dwoDJrCzSzEgPIQ8DBkU8d3vPyZQR/8fFWkS8uYOC8M0TUjNAZ/5X8
         QeyuIOAUDuHDTrQ8kFLUPePnOt/tvXsO3URkdBhXWZmACcWw4lZy5edfeMyJhauxt6
         UP6D4JRF13qwgVXiTN494GD7b5T6B0VE53e73HzYtPJ5rGQBktYgAKka5G+YtMYalK
         VUbgZDhlWAe8urxwNPAlXY9uvn3bA8AoDg3cJhFv0a8PKyUJT2RdF40qPHgDrJtGJ4
         0chnGWOQHpBow==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>, Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 04/10] tick/nohz: Remove superflous check for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
Date:   Thu, 11 Mar 2021 13:37:02 +0100
Message-Id: <20210311123708.23501-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311123708.23501-1-frederic@kernel.org>
References: <20210311123708.23501-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vtime_accounting_enabled_this_cpu() early check already makes what
follows as dead code in the case of CONFIG_VIRT_CPU_ACCOUNTING_NATIVE.
No need to keep the ifdeferry around.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/tick-sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 77dc8cd61dc8..c86b586d65e0 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1194,7 +1194,6 @@ unsigned long tick_nohz_get_idle_calls(void)
 
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
-#ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	unsigned long ticks;
 
 	if (vtime_accounting_enabled_this_cpu())
@@ -1210,7 +1209,6 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 	 */
 	if (ticks && ticks < LONG_MAX)
 		account_idle_ticks(ticks);
-#endif
 }
 
 void tick_nohz_idle_restart_tick(void)
-- 
2.25.1


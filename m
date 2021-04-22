Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C002367FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhDVMCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236160AbhDVMCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:02:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59943613FA;
        Thu, 22 Apr 2021 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619092932;
        bh=WfTbhoyKQVB6lSkA547QqXilKkbmd2gBojyn1EAI7sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3+PuAi8hOsSIUFpOvW9zW8K6KU8AM+0+5Ek+rmdAKcSNU1w7glaXf1/04OQ6YWZe
         V0HASB+4nxYj8t3xvgjnvWFgcws/7xVvEw4H423c8doV/oYQY5ARWUxWlZReOreR7X
         AgvmyAcP4tmTi4IAkdkkxAzSUk6f8wfO2axLV3UjvHqc6ekQunbd1LR/+1b1grKHHK
         svUnnPoB41vS6E3tRNKJhVM/qKDoXhhYclKnhJf4534IEQfrvnF8nrWVkt7TgMyUvn
         gZp32RsUjSUPekS8Vj77sM1t2gkp1RTcXgTQkq4GCSK95XFjxxLPkIuxe4iEUJxJal
         UNPc4ovw0i61w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 3/8] tick/nohz: Remove superflous check for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
Date:   Thu, 22 Apr 2021 14:01:53 +0200
Message-Id: <20210422120158.33629-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422120158.33629-1-frederic@kernel.org>
References: <20210422120158.33629-1-frederic@kernel.org>
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
index c888445fb181..31efd55ed302 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1192,7 +1192,6 @@ unsigned long tick_nohz_get_idle_calls(void)
 
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
-#ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	unsigned long ticks;
 
 	if (vtime_accounting_enabled_this_cpu())
@@ -1208,7 +1207,6 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 	 */
 	if (ticks && ticks < LONG_MAX)
 		account_idle_ticks(ticks);
-#endif
 }
 
 void tick_nohz_idle_restart_tick(void)
-- 
2.25.1


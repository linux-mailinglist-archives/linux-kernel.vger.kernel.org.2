Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A55B37F004
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbhELXmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243642AbhELXay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:30:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D5AF61412;
        Wed, 12 May 2021 23:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620862185;
        bh=cLPMud3EUmmy1x5y40hJBcTxMVayvV9kggfT1rLF7l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dm5yKglh8rBCeykETDAnpdoLUble6z5Aoi8vaFvqG47TmIFP54+8fMQNmrkJ35ptw
         UvCOlF5ffd+tBz+UHUnxmlU5aW6dQ1YKZdVzV7IadJtV/UqoZhpv+U+2lq7d4Vk7JG
         PRWXEcMn7oPM4oH7Tola66Ehe9PW5ZFtnh+n1ZcHWN5mS6N/s+Ud8GXl7X+iRZjEw3
         K3P2SZBZNrbsHuqv+zzhzP7agEY3PmMmy5C41YfHnuQox4Jl2sObdfCpSDyUC8Ep32
         GaSKinPZQecYXbPfX8DT+ngC512u6OhpsDRAHwMuvsE3KgAWsWLVrCn3f7/4n02aG8
         sziXWUtjvAelg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 03/10] tick/nohz: Remove superflous check for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
Date:   Thu, 13 May 2021 01:29:17 +0200
Message-Id: <20210512232924.150322-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512232924.150322-1-frederic@kernel.org>
References: <20210512232924.150322-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vtime_accounting_enabled_this_cpu() early check already makes what
follows as dead code in the case of CONFIG_VIRT_CPU_ACCOUNTING_NATIVE.
No need to keep the ifdeferry around.

Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/tick-sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 05c1ce1034d6..1afa7595d1e0 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1196,7 +1196,6 @@ unsigned long tick_nohz_get_idle_calls(void)
 
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
-#ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	unsigned long ticks;
 
 	if (vtime_accounting_enabled_this_cpu())
@@ -1212,7 +1211,6 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 	 */
 	if (ticks && ticks < LONG_MAX)
 		account_idle_ticks(ticks);
-#endif
 }
 
 void tick_nohz_idle_restart_tick(void)
-- 
2.25.1


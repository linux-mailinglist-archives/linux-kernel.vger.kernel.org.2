Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562D432C472
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349866AbhCDAOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:14:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240090AbhCDABC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:01:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE27364F6C;
        Thu,  4 Mar 2021 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816021;
        bh=pJYlv08oU8/9jzKWYdo3lStoGM9KGgDAdtLC9Ufx7aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utI5e0G/PEr1OYaoAXPh8+o+wQtRPd3rMqsgKW59ibqs1qj22oWvqMfUzTXI1GM87
         5YTb3fw47YJXLdM8Z3pth4rquBTD2GXTK6qR/LsDQGkGmI8LrSq3iArJgFyLhvnct4
         vBLbLVIydn4WPbHljegmnnGH2uvPE3ZWgzQZpZsvkyBlcaeJ3yc2RelqcAxb8ugkd2
         BjNahX9F1CrG/I5MB5qVozCSSJ3PNI5KjCk/pns+6wl7RvO57l6qVC0InB0djF3vf/
         qxq1ACXMttmQKtFkyyAISpuAd+JjQdVnJfhKrEIUWLbPN5lavAmBq7YV71xHyAvUSS
         qv2GFIsCBTAow==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/10] rcu: Remove superfluous rdp fetch
Date:   Wed,  3 Mar 2021 16:00:10 -0800
Message-Id: <20210304000019.22459-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235958.GA22373@paulmck-ThinkPad-P72>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar<mingo@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da6f521..cdf091f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -648,7 +648,6 @@ static noinstr void rcu_eqs_enter(bool user)
 	instrumentation_begin();
 	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	rdp = this_cpu_ptr(&rcu_data);
 	rcu_prepare_for_idle();
 	rcu_preempt_deferred_qs(current);
 
-- 
2.9.5


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B55737B1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhEKWyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhEKWyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:54:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 113246193F;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=0zvL868RbLnDBhdNNXkDTbR3Z2jBxOtL487by24P1Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGAiEIBnDv/W8n1d+nPT+INxssGlEzVGruW4451VoohL7UqcRWFsOm0OI0zva8ENP
         EhA2tbGayte8uMJXQqjn1NZY/CGfRHrVZmrwKzrY7a4KgjVMN8bbOGauMt/sxQU7im
         5QDcHdmrDiQCgxYMDlBneIKnPuxDt8mOfCtvnKDWnSpZZ6hgRLQ3kKk3c/DD3eipwZ
         8JjZxGHov1LH/SMWylfOwQt0ckUoRehE4LByTJIQeCD+6Gb/jvyIrEIiP5p5WJieX6
         SKgHZyBtBt+grIdBNF4gGFsZN1ztPad57wIQAj3vtrR3kWKJMJBLTlOH+r9pDFM3GA
         bcG6sLbmrUVtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9CC835C0DF5; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/19] rcu: Restrict RCU_STRICT_GRACE_PERIOD to at most four CPUs
Date:   Tue, 11 May 2021 15:52:57 -0700
Message-Id: <20210511225304.2893154-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernels built with CONFIG_RCU_STRICT_GRACE_PERIOD=y can experience
significant lock contention due to RCU's resulting focus on ending grace
periods as soon as possible.  This is OK, but only if there are not very
many CPUs.  This commit therefore puts this Kconfig option off-limits
to systems with more than four CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 1942c1f1bb65..4fd64999300f 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -116,7 +116,7 @@ config RCU_EQS_DEBUG
 
 config RCU_STRICT_GRACE_PERIOD
 	bool "Provide debug RCU implementation with short grace periods"
-	depends on DEBUG_KERNEL && RCU_EXPERT
+	depends on DEBUG_KERNEL && RCU_EXPERT && NR_CPUS <= 4
 	default n
 	select PREEMPT_COUNT if PREEMPT=n
 	help
-- 
2.31.1.189.g2e36527f23


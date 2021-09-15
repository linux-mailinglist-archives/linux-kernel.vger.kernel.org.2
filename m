Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54B540D071
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhIOXrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233133AbhIOXr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E5B4611EE;
        Wed, 15 Sep 2021 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749566;
        bh=xTKDktiwSHNdL7oKoHZhUOKF6h03a9xGCJzWp6ESkSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnPn5xxLMSqNzj7WdsPY6LWsOVU+fgscgktyY4d+egDJUS6e6tEDrF8GsPk9ur1Vx
         qSzQoaJaN00gmVJa39UynH1/pNxlSLwHZBqJXcGuSiZRsk8Al7IDymflGXF2KSIRjG
         ApLqAVhB1XDCaG4wc2yTLGmra2drdAt3YJ+fDkcEHFoE9Hd/ZPCE5X+Vgiaccifvcs
         ku0EGHEOnj/LuOANBbXp22/UaH6r3M6oHzY02JvkAE9k8nwEdVs6NcqeDzieOjBr8P
         v3EBko4MP4ob9OKPT38IKIDuHJ4S/yvyAM8pqW1qB8VC/1NcvJgaA/gB3Y2v1V6jwK
         N8sckiMoRO59Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CC3FD5C0AD4; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/13] rcu-tasks: Correct firstreport usage in check_all_holdout_tasks_trace
Date:   Wed, 15 Sep 2021 16:45:59 -0700
Message-Id: <20210915234604.3907802-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

In check_all_holdout_tasks_trace(), firstreport is a pointer argument;
so, check the dereferenced value, instead of checking the pointer.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 75e7888b3fc9..e2ec548fc0c4 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1129,7 +1129,7 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 	cpus_read_unlock();
 
 	if (needreport) {
-		if (firstreport)
+		if (*firstreport)
 			pr_err("INFO: rcu_tasks_trace detected stalls? (Late IPI?)\n");
 		show_stalled_ipi_trace();
 	}
-- 
2.31.1.189.g2e36527f23


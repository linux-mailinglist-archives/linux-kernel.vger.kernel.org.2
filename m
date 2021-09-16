Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2749840D04F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhIOXnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233046AbhIOXnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AA06610FF;
        Wed, 15 Sep 2021 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749304;
        bh=UtQiNwo4hRxV3EJARWM9ipVjUEeL33HvKLetCScJ6Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FU6YUdFqOQsVm9HC5wKDsFPwbQMZzUjaBfvPHhFxgvxBc5iZJkj3ETrixYuD5nxYH
         Tgi0PKpXJYHI/S5NAG1/1slAeQacnU7AMMZwRpbhEPIafORSze+HW4afkuhc9nl485
         KAy9RX5/H7yUb/havsDTrwA5HlUn06WfSqGkxRiqlRAprOG70tXO0JDoUNvCffN6sJ
         1XZiG8nPjqWo4PFLE6DwtM+aLJeiny4dbnuHhfMwpfcctfnm7f8Idw+GE+NXOkgFWd
         DgtZmiBRGkZnT9OsfV2RfxqqkfG2jrCOrxR0eFDv/mvNPKq7VlpOub3TaH3cWmNtSH
         gtZ6cLDNJcdDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EBCFF5C08E8; Wed, 15 Sep 2021 16:41:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/5] scftorture: Count reschedule IPIs
Date:   Wed, 15 Sep 2021 16:41:40 -0700
Message-Id: <20210915234141.3907301-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only those IPIs that invoke scftorture's scf_handler()
IPI handler function are counted.  This means that runs exercising
only scftorture.weight_resched will look like they have made no forward
progress, resulting in "GP HANG" complaints from the rcutorture scripting.
This commit therefore increments the scf_invoked_count per-CPU counter
immediately after calling resched_cpu().

Fixes: 1ac78b49d61d4 ("scftorture: Add an alternative IPI vector")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 74348abc792b..00bba2bdd4d1 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -341,6 +341,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			cpu = torture_random(trsp) % nr_cpu_ids;
 			scfp->n_resched++;
 			resched_cpu(cpu);
+			this_cpu_inc(scf_invoked_count);
 		}
 		break;
 	case SCF_PRIM_SINGLE:
-- 
2.31.1.189.g2e36527f23


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD933D189E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhGUUYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhGUUYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:24:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A3FB613DC;
        Wed, 21 Jul 2021 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901483;
        bh=osXoyN8oxvcAmu4jmKsY8xk1fGp7eKsWJyNJBNXs/go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZl7iJqLthsI05zmcgojc1wt/LrcFBn+wPQYVUlrY9gToEPnBBZKhtaw1t8MAm1gO
         OEi4C9Up+aNELoEl1+EyWlzkoRMbmHv4K49gK2yFODwKG1lpd1OryZ5CRXHMhOWuf1
         fwSXxX+wry+w3G0RGGoOztwvHLhPNl8DSnYMYufwfSEN54tPjhjrMsab7bbg5dlB0+
         4pWClXay2Ad6vplrwOa6a/mPlueUbuGCG27TTxtt0NRL5Ev3O43mPdCD0KCynDQ0GP
         E+4eEgtuVusWnTLBf0tloxdzw4FggnmljTKTiXXz8870y5PuGuavCMApY3XPxZgHQL
         DNlcuFK7kxCDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 365435C0D47; Wed, 21 Jul 2021 14:04:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/7] scftorture: Avoid NULL pointer exception on early exit
Date:   Wed, 21 Jul 2021 14:04:41 -0700
Message-Id: <20210721210441.796995-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scftorture finds an error in the module parameters controlling
the relative frequencies of smp_call_function*() variants, it takes an
early exit.  So early that it has not allocated memory to track the
kthreads running the test, which results in a segfault.  This commit
therefore checks for the existence of the memory before attempting
to stop the kthreads that would otherwise have been recorded in that
non-existent memory.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 5cf40e4383191..64a08288b1a6d 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -513,7 +513,7 @@ static void scf_torture_cleanup(void)
 		return;
 
 	WRITE_ONCE(scfdone, true);
-	if (nthreads)
+	if (nthreads && scf_stats_p)
 		for (i = 0; i < nthreads; i++)
 			torture_stop_kthread("scftorture_invoker", scf_stats_p[i].task);
 	else
-- 
2.31.1.189.g2e36527f23


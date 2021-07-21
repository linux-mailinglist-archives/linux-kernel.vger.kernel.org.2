Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F203D181D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhGUTql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhGUTqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:46:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74A8C61221;
        Wed, 21 Jul 2021 20:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899236;
        bh=TQmEZg+Sj+04B+Vhe9Tt8lQmPjDUAau6RE/aWEtgw0Y=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=trgxzN4SH23g+lxC+6TR77r37TEz8CwneEgh8WejwWSPY9tDyldQStDaugmKjlSEr
         6Rl2eoipfskIwmafnjPlrkMcGpOHXz9K6R8+7/zXCdAE1z4QNdhAadskZo2xahnbnQ
         4KTg20BE1/ByKxEclWVFLOcXNN8PFld0R5ArmbOK2a413ibdJtYBPA+I7ahVMf5Sfx
         VKQyxFE+9C9wAcNMo90ms3dsEMBLlqcpWiOx34LD+0KsN9YHZcLhpHseJbh7PMvjiq
         Hkm1Cme6X6s/D7vcmdbXaAISNNnVMmXoFO7vz1jSpMkaVvaMYxyR3FOvzJr1LnjDEd
         7OWE8mmGAa5Vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 358D05C09A4; Wed, 21 Jul 2021 13:27:16 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:27:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/2] NOCB-CPU updates for v5.15
Message-ID: <20210721202716.GA2679705@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The following series provides NOCB updates:

1.	Start moving nocb code to its own plugin file, courtesy of
	Frederic Weisbecker.

2.	Remove NOCB deferred wakeup from rcutree_dead_cpu(), courtesy
	of Frederic Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tree.c        |    1 
 b/kernel/rcu/tree_nocb.h   | 1496 +++++++++++++++++++++++++++++++++++++++++++++
 b/kernel/rcu/tree_plugin.h | 1487 --------------------------------------------
 kernel/rcu/tree.c          |    3 
 4 files changed, 1497 insertions(+), 1490 deletions(-)

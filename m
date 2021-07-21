Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544AF3D1897
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhGUUXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhGUUXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:23:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 907C761263;
        Wed, 21 Jul 2021 21:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901461;
        bh=gCCg+hMvU6GW/lVfXphadq9/4+3AeGNA5XV/20mYx+s=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=t3d0O2SIPcuYVVaEUsr301QahTPVsNkgr3rChDzn+m/5knq6ykzSSGqHyquncAkvx
         KrvRp1AS9reD/87N88/FRSuCU2BGyOD0WQjOc1hldGAhGKWVQWaTN7U21a8+QkOHNQ
         SE6xcXP2smjTqXqW5L9vtnoowtAxeF5ADDoo3cQODRxkDDXS5oq1xi4wBrf9hwZZ9n
         bzFQFJvGOKTefGkqPgd1O0BKmibXUQCCQwdPyMPz9fAcGUFZ9cARDjC42jtRtqZJxe
         t4SsYiG8auwl+5KD/94I8c9in473FzknqG+Bk7z0WzEl9kWIRu6nKb6duMja+7SKsx
         FeTqn+tKjh07A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 535EC5C09A4; Wed, 21 Jul 2021 14:04:21 -0700 (PDT)
Date:   Wed, 21 Jul 2021 14:04:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/7] Torture-test updates for v5.15
Message-ID: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains updates to the in-kernel torture tests:

1.	Add measurement of clock readout.

2.	Preempt rather than block when testing task stalls.

3.	Console output claims too few grace periods, courtesy of
	"Jiangong.Han".

4.	Mark statistics data races.

5.	Count lock readers.

6.	Add RPC-like IPI tests.

7.	Avoid NULL pointer exception on early exit.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/locking/locktorture.c |   16 ++++----
 b/kernel/rcu/rcuscale.c        |    4 +-
 b/kernel/rcu/rcutorture.c      |    7 +++
 b/kernel/rcu/refscale.c        |   37 +++++++++++++++++++
 b/kernel/scftorture.c          |   76 +++++++++++++++++++++++++++++++++--------
 kernel/locking/locktorture.c   |    9 ++--
 kernel/scftorture.c            |    2 -
 7 files changed, 121 insertions(+), 30 deletions(-)

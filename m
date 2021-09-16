Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD7540D0AD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhIPAOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233070AbhIPAOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:14:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A9F06103B;
        Thu, 16 Sep 2021 00:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631751209;
        bh=hQK4msfiZojf9oM8LRX9HGFatwI6x3wUm7fjS6j8IN8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=j7aYbPd2QC5o5qcfv7rS9Y8V7OnLzpgitAlpLPjZlgq2+MPSCDMOx0NPp5rBn4y7X
         B1dYv+75lIVWCA/Tx5bTxNCN9LCyW+84lP/m2oib/WrN8Ayfyq94LI8qoJpr5hyJbg
         pT/cw7Mz0bNYYBiklN2xXUg/+BbUk4pYvEEdrQm2gC5dNEzg+cEc4tzvkwpY85zln+
         yocV93ztFWAeoGvcQQ9YbjBwtGas0mwrhLJp9zsGWrSHSpxn9hBnJ+YTqd0tLpyKqz
         GW1g5b/g0YcJpkHrzSRFP2ES5jiIWY2hYjHWrgs6lEB/xiUmLTxogx1jWPWseOTawZ
         MV6Maz0DwAWiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 635295C054E; Wed, 15 Sep 2021 17:13:29 -0700 (PDT)
Date:   Wed, 15 Sep 2021 17:13:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/7] In-kernel torture-test updates for v5.16
Message-ID: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains in-kernel torture-test updates (excluding scftorture,
which has its own branch this time).

1.	Suppressing read-exit testing is not an error.

2.	Warn on individual rcu_torture_init() error conditions.

3.	Warn on individual lock_torture_init() error conditions.

4.	Warn on individual ref_scale_init() error conditions.

5.	Warn on individual rcu_scale_init() error conditions.

6.	Don't cpuhp_remove_state() if cpuhp_setup_state() failed.

7.	Avoid problematic critical section nesting on PREEMPT_RT,
	courtesy of Scott Wood.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/torture.h      |    8 ++++
 b/kernel/locking/locktorture.c |   14 +++----
 b/kernel/rcu/rcuscale.c        |   10 ++---
 b/kernel/rcu/rcutorture.c      |    2 -
 b/kernel/rcu/refscale.c        |    6 +--
 kernel/rcu/rcutorture.c        |   82 ++++++++++++++++++++++++++---------------
 6 files changed, 77 insertions(+), 45 deletions(-)

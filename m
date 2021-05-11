Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE337B1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhEKWpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhEKWpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:45:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30B6161928;
        Tue, 11 May 2021 22:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773043;
        bh=tjdENYeLio88+ega8csnSeNPJ3P6QtDb8foHFp7KLhE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ktGZhzotwRkQdLbd7eP47KB6+daJQBmsIDmg89DYYIzdWCPOvtv0reU074w/PNAzV
         AZzFM7qWWvuTIwGuPa/Y9Tegjn08rzXqrqM8ikpxax786+2+uHXyBQIkO15KBCliOE
         1wxP4rsvftQnNhT27cDwY44tUd1gnDf+UdTmlzZBQ9mhWZniZXEjqOeDjgP5EJWiGf
         XvX1bcU9y9KunudLj1syKrDafNSe1EwoM08TY+m5YHtYqbPFih/Odtvg2p8rkysW05
         8mCILZSCj2l5oy1YPdn0GQbK/IfZH6bxSRz7CHZL+bpJcVcPa2JBrtSO0dA6QXljHS
         JLvfXXNReQ1AQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CBF785C0138; Tue, 11 May 2021 15:44:02 -0700 (PDT)
Date:   Tue, 11 May 2021 15:44:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/3] Documentation updates for v5.14
Message-ID: <20210511224402.GA2892361@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides documentation updates:

1.	Fix statement of RCU's memory-ordering requirements.

2.	Fix diagram references in memory-ordering document, courtesy of
	Frederic Weisbecker.

3.	Add drgn script to dump number of RCU callbacks.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |    4 
 b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst |    2 
 b/tools/rcu/rcu-cbs.py                                                  |   46 ++++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)

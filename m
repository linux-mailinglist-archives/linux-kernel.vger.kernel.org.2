Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE137B1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhEKWmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKWmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:42:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F0DB61606;
        Tue, 11 May 2021 22:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620772875;
        bh=VknOp2+o0dB66DTbseTpEKUnlCAickufM7SgGBJu9p0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=oKQZytHSzLQOGXeDzk0cmx/dAPbmIYH/hXTx2LgiJnhHzAEJcN9e6ekRoYjaepDQ+
         lIYHZEFy6UokGa/XyMTf7vkVeIbqSxfsELiadS/Rhne+LRPCekr9Ev/t+MA1rlcybS
         bMEFGazbo7dH7+SIduMIdx0LxRH5L3SqVZ5DSW+jpneZ7+GV5MLGKilh59iIpN/5tv
         mV8zTOihK8z/JBMUJVFOmO2eahaGu/m24by7vh/zpD7/BZnE1B2bvOA705hki+4Fog
         L7Yx58sEh/GiXwLyDfpycirN9GjYsnO/zrXTuBlZvZWqHjR6CMZSwSoel4+a1j/KBY
         5OSbk72M7kaxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3A1505C0138; Tue, 11 May 2021 15:41:15 -0700 (PDT)
Date:   Tue, 11 May 2021 15:41:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/2] Add "all" to bitmap ranges
Message-ID: <20210511224115.GA2892092@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series adds "all" as a first-class bitmap range, for example so that
"rcu_nocbs=all:1/2" would offload all the even-numbered CPUs regardless
of the number of CPUs on the system.

1.	bitmap_parse: Support 'all' semantics, courtesy of Yury Norov.

2.	rcu/tree_plugin: Don't handle the case of 'all' CPU range,
	courtesy of Yury Norov.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.rst |    5 +++++
 kernel/rcu/tree_plugin.h                        |    9 +++------
 lib/bitmap.c                                    |    9 +++++++++
 lib/test_bitmap.c                               |    7 +++++++
 4 files changed, 24 insertions(+), 6 deletions(-)

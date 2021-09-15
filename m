Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A1440D04A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhIOXmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhIOXmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:42:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB8D960F8F;
        Wed, 15 Sep 2021 23:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749277;
        bh=/nO/zst4HXobeaTIjQ4tntFgOhmHOvUeyhfXrtrNa5g=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=C3BPt5fw5wmdu1hR6UUFSBFgwvB4TX84eXKMLPs9erMOmmrmVYkJDpGw/cpPbo4yM
         uwvLY26jFQEropD1kxxOxSGhX6CBqBeqEr7nNwNJPNAFRckPljnB5BxEfchQJUCEYR
         jeZhCTiorHvkbn+I6FgMVL1leRmmPa6ZWhklMZZm7g4MUj3fxTUS/eNUnIGP6rPyku
         4VmclcjeOPVrkiGjMQEx3lAa/VZj9NKjqN8EC74zG7CE6G/Hg8U+OlvbJXzv25QJpT
         2xnXb1MhyNXP7+y/uup+feDR1sMVvi+h4Zc/hLmEQKzOnjN4h5RIiZLe8OtAqXFdX3
         MMnmlhtAk6G7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 995FA5C054E; Wed, 15 Sep 2021 16:41:17 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:41:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/5] smp_call_function() torture-test updates for v5.16
Message-ID: <20210915234117.GA3907188@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains in-kernel torture-test updates for smp_call_function()
and friends, AKA scftorture.

1.	Allow zero weight to exclude an smp_call_function*() category.

2.	Shut down if nonsensical arguments given.

3.	Account for weight_resched when checking for all zeroes.

4.	Count reschedule IPIs.

5.	Warn on individual scf_torture_init() error conditions.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/scftorture.c |   24 ++++++++++++------------
 kernel/scftorture.c   |   19 ++++++++++++-------
 2 files changed, 24 insertions(+), 19 deletions(-)

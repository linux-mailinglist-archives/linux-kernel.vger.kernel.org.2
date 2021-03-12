Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A26338D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhCLM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:27:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhCLM0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:26:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9DA964F33;
        Fri, 12 Mar 2021 12:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615552009;
        bh=747j9DSXo0t9Jf0l71efpP6DocfOreSCvakfPgvlDQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jD3GOe98q+eVkqDufgvcovhk5QdTZ8fUthhlNljyuicVIYdBSHo2W6apYozR8cmWD
         2A4i7KdQhrM5HutOaaxJDZqUEcHOBGwkLz3LCaDWK4fjGetekYyXf+CIXGQBH0bEC7
         gjPEIV1bIuZe/L7bm3YFw855Y8F3wSuafRrtR0C30gwhUOFvLuW8DDpXPv498Khu4J
         VRQMKBeLieUH8hE0ny7XHr/88AtSDUOD53DnsPEVUMXIt9nhkAg1E9VyDiipCSjPtG
         KHpVAw3nrDoAucQl773y32z6LdgLe/6fV1o3xrwYSHo/IsUhuFd6bPDZmh9wUI7dzw
         Nt6CDWBn8HyTg==
Date:   Fri, 12 Mar 2021 13:26:47 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu: Provide polling interfaces for
 Tree RCU grace periods
Message-ID: <20210312122647.GC3646@lothringen>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304002632.23870-1-paulmck@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 04:26:30PM -0800, paulmck@kernel.org wrote:
>  /**
> + * start_poll_state_synchronize_rcu - Snapshot and start RCU grace period
> + *
> + * Returns a cookie that is used by a later call to cond_synchronize_rcu()
> + * or poll_state_synchronize_rcu() to determine whether or not a full
> + * grace period has elapsed in the meantime.  If the needed grace period
> + * is not already slated to start, notifies RCU core of the need for that
> + * grace period.
> + *
> + * Interrupts must be enabled for the case where it is necessary to awaken
> + * the grace-period kthread.
> + */
> +unsigned long start_poll_synchronize_rcu(void)
> +{
> +	unsigned long flags;
> +	unsigned long gp_seq = get_state_synchronize_rcu();

Ah! It's using rcu_seq_snap() and not rcu_seq_current() and therefore it's
waiting for a safe future grace period, right?

If so, please discard my previous email.

Thanks.

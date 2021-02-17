Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C9431DC69
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhBQPgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:36:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46178 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhBQPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:33:47 -0500
Date:   Wed, 17 Feb 2021 16:32:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613575974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4uM3wH9hVBa0PRle3Aj+gJvZPAjKPZlC62SmlWEA14=;
        b=IFJs0vLCPPYEVHm3uAhwAaHU/f8vZy3j7L77P48JYidoOiqiQoM0M07Auj9eIFKamH8o1K
        C38bDr44sN0CNi9D/LEFPDKSoOFQZspv/juhO4SxELLp7TigwT3DQOADdpIBf9IDSZiMuH
        7YZuhMTbj2R8LeN3kI2LfvlP9lCdTuxrVwgFFc1qL1cFTpohQ6c49D984nlpT2sG+2Lumo
        YmrbHby8evVwNEAjLNS6ulSH6CwzjQbNVf+PBESshqFp+yUmsIeJ62dYr5N63EGrUEsEvX
        VsyrnLYeNuofq76soHfBmpdqvos57SmMG6pSQET8LhQJ9WXYpBC6ji6kpra5zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613575974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4uM3wH9hVBa0PRle3Aj+gJvZPAjKPZlC62SmlWEA14=;
        b=dXQRM80rWzu6UmvciMGAvlsvqDS+BQd9hBlFA1JLDWntEuYOHeuwuHTrF/DYIanqM0TgNy
        nZNzWGOOBR2JBFBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: Should RCU_BOOST kernels use hrtimers in GP kthread?
Message-ID: <20210217153253.fy2mhxo3o3ehsuix@linutronix.de>
References: <20210216183609.GA7027@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210216183609.GA7027@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-16 10:36:09 [-0800], Paul E. McKenney wrote:
> Hello, Sebastian,

Hi Paul,

> I punted on this for the moment by making RCU priority boosting testing
> depend on CONFIG_PREEMPT_RT, but longer term I am wondering if RCU's
> various timed delays and timeouts should use hrtimers rather than normal
> timers in kernels built with CONFIG_RCU_BOOST.  As it is, RCU priority
> boosting can be defeated if any of the RCU grace-period kthread's timeouts
> are serviced by the non-realtime ksoftirqd.

I though boosting is accomplished by acquiring a rt_mutex in a
rcu_read() section. Do you have some code to point me to, to see how a
timer is involved here? Or is it the timer saying that *now* boosting is
needed.

If your hrtimer is a "normal" hrtimer then it will be served by
ksoftirqd, too. You would additionally need one of the
HRTIMER_MODE_*_HARD to make it work.

> This might require things like swait_event_idle_hrtimeout_exclusive(),
> either as primitives or just open coded.
> 
> Thoughts?
> 
> 							Thanx, Paul

Sebastian

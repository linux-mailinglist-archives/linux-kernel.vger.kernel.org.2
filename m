Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE523DEA74
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhHCKHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbhHCKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:07:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B9C061387
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4wevAMoON2BVeDaC/EUtZafrKn0BGHEDvZ9AiAWBsv8=; b=GwAp6t8DYiTSvCe9CTMEDq3whN
        PG0QRaWo/LVrHn3IEIzwzaQZXULuw5YWY0aAWKqStWCGM9KQURZtXmRXaDn0lG9LjgR62g1Q5UvuK
        LZ9VRLcPKAhTLNH2p+qvUqRPKtVXLJmHDSyhmjtNV5+IlpVcWgp3Qr+pMn0X6qj3RrmZ0YfpkCD6P
        sRoriF2uNYwB7SSm7V8X6D/c9WhLJbrjBHVw2eKEXy6V2ala0fJLcvV9iRhdttFQu10dVFQGir9CX
        1FBkPYp8RJpN4AuNMPc0qbmWPBQmhbw3VRckiSMq12q5mBDPhafK3xLwbjuvo0pDpx/WT1lBxdedr
        R35yhBgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mArKI-005OHi-RV; Tue, 03 Aug 2021 10:07:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 249839862A4; Tue,  3 Aug 2021 12:07:13 +0200 (CEST)
Date:   Tue, 3 Aug 2021 12:07:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 58/63] futex: Prevent requeue_pi() lock nesting issue on
 RT
Message-ID: <20210803100713.GB8057@worktop.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135208.418508738@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730135208.418508738@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:51:05PM +0200, Thomas Gleixner wrote:
> @@ -219,6 +221,10 @@ struct futex_q {
>  	struct rt_mutex_waiter *rt_waiter;
>  	union futex_key *requeue_pi_key;
>  	u32 bitset;
> +	atomic_t requeue_state;
> +#ifdef CONFIG_PREEMPT_RT
> +	struct rcuwait requeue_wait;
> +#endif
>  } __randomize_layout;
>  
>  static const struct futex_q futex_q_init = {

Do we want to explicitly initialize requeue_state in futex_q_init? I was
looking where we reset the state machine and eventually figured it out,
but I'm thinking something more explicit might help avoid this for the
next time.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E663E28E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbhHFKuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245241AbhHFKuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:50:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E61C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gPKCT5MM+sB43jvHH5NF4/bb64FZqw0ZhC78sPp1geE=; b=dESNSWjyL0EACftGJ77c1/brrb
        O904632Jfxd0Xs29Yb2gltyUPA4wdn7ytFKpPNfLCSOcsSWN1bdCNjPry6hceTzCU8Vm8daz/mD7J
        nycwH/bz7tAidwvHUH1Q3cw0eREBRgrG4hne7dpNYT7ft+9x1DXf6EVXBq7BmSe9dnHoSLP26e64u
        V4gVI+p8raZga1EpiYBdQrtsygc5bl2iJCmFwpDH0vqTh3YlVdxEjJ7E612da1qoH2McAHF83l7SN
        wdF7DQMmIlqOY0Hl277ruAQHeTq5S68Hj4/kDgoni94qMda34e+iSU/i8t9V/tZRzKHYQl5FEllq6
        BiHqXxhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBxP2-0085wr-Mg; Fri, 06 Aug 2021 10:48:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E603980F93; Fri,  6 Aug 2021 12:48:35 +0200 (CEST)
Date:   Fri, 6 Aug 2021 12:48:35 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V3 48/64] locking/ww_mutex: Add RT priority to W/W order
Message-ID: <20210806104835.GE22037@worktop.programming.kicks-ass.net>
References: <20210805151300.330412127@linutronix.de>
 <20210805153955.595804799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805153955.595804799@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 05:13:48PM +0200, Thomas Gleixner wrote:
>  static inline bool
> +__ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
>  {
> +/*
> + * Can only do the RT prio for WW_RT because task->prio isn't stable due to PI,
> + * so the wait_list ordering will go wobbly. rt_mutex re-queues the waiter and
> + * isn't affected by this.
> + */
> +#ifdef WW_RT
> +	/* kernel prio; less is more */
> +	int a_prio = a->task->prio;
> +	int b_prio = b->task->prio;
> +
> +	if (dl_prio(a_prio) || dl_prio(b_prio)) {

Whoever wrote this was an idiot :-) Both should be rt_prio().

> +
> +		if (a_prio > b_prio)
> +			return true;
> +
> +		if (a_prio < b_prio)
> +			return false;
> +
> +		/* equal static prio */
> +
> +		if (dl_prio(a_prio)) {
> +			if (dl_time_before(b->task->dl.deadline,
> +					   a->task->dl.deadline))
> +				return true;
> +
> +			if (dl_time_before(a->task->dl.deadline,
> +					   b->task->dl.deadline))
> +				return false;
> +		}
> +
> +		/* equal prio */
> +	}
> +#endif
>  
> +	/* FIFO order tie break -- bigger is younger */
>  	return (signed long)(a->stamp - b->stamp) > 0;
>  }

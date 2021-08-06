Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0120C3E2905
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbhHFLB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245261AbhHFLBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:01:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E216C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=REQ1W8sNJktjIPpaOp5ow7XK6buM4/6cGVuTXRlaEIU=; b=EPNGLjamYhabcCG2UgujoxkcIA
        5C4CI6dfC2sfJg59jFnWBnQfwgrZdonWlawskbclRHtO11db150rO1qlLVxWPrKRjqoonQ9MPEuu7
        CARlUqlfsLzXiFMtlIMXB3O51rvBz2Xwdm5nXVK1K/7vKfFypUJhjQ0v+TrRjC248sRH8AgXd27mn
        1I4Mm8b3EIWNHfpLBb1KEFWJsBs2IS/X5dUXsK3Vp+YC7u/cV5bwq/mqMdso2+1XtqCUYsFmFH0jh
        8z2aZNXrQ9/ZDtzHVIhybxx1gsUCPnUeF5jRY7T6FAGfGf1Y5lBuu2jIEn641Qa4Yfa2nz4Rfd24M
        1K5wvI5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBxau-006LPB-TX; Fri, 06 Aug 2021 11:00:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E85A6980F93; Fri,  6 Aug 2021 13:00:51 +0200 (CEST)
Date:   Fri, 6 Aug 2021 13:00:51 +0200
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
Subject: Re: [patch V3 50/64] locking/rtmutex: Extend the rtmutex core to
 support ww_mutex
Message-ID: <20210806110051.GF22037@worktop.programming.kicks-ass.net>
References: <20210805151300.330412127@linutronix.de>
 <20210805153955.709189588@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805153955.709189588@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 05:13:50PM +0200, Thomas Gleixner wrote:
>  static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_node *b)
>  {
> -	return rt_mutex_waiter_less(__node_2_waiter(a), __node_2_waiter(b));

Given ^

> +	struct rt_mutex_waiter *aw = __node_2_waiter(a);
> +	struct rt_mutex_waiter *bw = __node_2_waiter(b);
> +
> +	if (rt_mutex_waiter_less(aw, bw))
> +		return 1;

We can, with this new build_ww_mutex(), do:

	if (!build_ww_mutex())
		return 0;

here, to preserve the old behaviour.

> +	if (rt_mutex_waiter_less(bw, aw))
> +		return 0;
> +
> +	/* NOTE: relies on waiter->ww_ctx being set before insertion */
> +	if (build_ww_mutex() && aw->ww_ctx) {

Then it can go away here.

> +		if (!bw->ww_ctx)
> +			return 1;
> +
> +		return (signed long)(aw->ww_ctx->stamp -
> +				     bw->ww_ctx->stamp) < 0;
> +	}
> +
> +	return 0;
>  }

Also, I found a note that said I had to check what this code does for
!RT tasks, lemme go do that now.

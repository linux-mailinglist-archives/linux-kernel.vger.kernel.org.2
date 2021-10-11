Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1369042927D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbhJKOtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbhJKOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:49:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA135C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Gkf7XkH0VdIK/pbuIoYKIaOT9YKA9EZRImkIx3YMJ7Y=; b=Jv0uYq1DnYV+VksvI4hmLWzKTV
        I/aeYoPtsKVa3iE12nkyRtbx/eXzulMQDvAWllacJiuxsiEtJdhUFYSurWmfGFBy9rjzN9XBNbZXJ
        WtEqgrZ43hhinyYLisZE6ssA9ZS/CYZGkJkzaW036fxkUXdWGr3BKyn599NjNDtYRsez8zh9opNNu
        kvA/UQnfIwcztUHQM+IHsCR2UA6gA7AnuLfHXdExK7Gdoq13aph7Rw2zYGLGT+N6XVgDTloLsHkFm
        StqQO0EZpUMuBSIpbViY3uXzwb4y/NT2FWre783EFvHuI0rZ9kZIP/vmC4RL5jy7KsV60rX8gsE92
        gVOy44aA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZwYA-005kT9-R5; Mon, 11 Oct 2021 14:45:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1304F9811D4; Mon, 11 Oct 2021 16:45:11 +0200 (CEST)
Date:   Mon, 11 Oct 2021 16:45:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RESEND PATCH v2] trace: prevent preemption in
 perf_ftrace_function_call()
Message-ID: <20211011144510.GE174703@worktop.programming.kicks-ass.net>
References: <eafba880-c1ae-2b99-c11e-d5041a2f6c3e@linux.alibaba.com>
 <20211008200328.5b88422d@oasis.local.home>
 <bcdbccc6-a516-2199-d3be-090a5e9f601d@linux.alibaba.com>
 <YWP2rtX9Ol9dZc/l@hirez.programming.kicks-ass.net>
 <YWP6W7Be0Yp6egsn@hirez.programming.kicks-ass.net>
 <87aeef5b-c457-d4df-8abf-f9f035d73dbc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87aeef5b-c457-d4df-8abf-f9f035d73dbc@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 05:39:32PM +0800, 王贇 wrote:
> 
> 
> On 2021/10/11 下午4:48, Peter Zijlstra wrote:
> > On Mon, Oct 11, 2021 at 10:32:46AM +0200, Peter Zijlstra wrote:
> >> diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
> >> index a9f9c5714e65..ca12e2d8e060 100644
> >> --- a/include/linux/trace_recursion.h
> >> +++ b/include/linux/trace_recursion.h
> >> @@ -214,7 +214,14 @@ static __always_inline void trace_clear_recursion(int bit)
> >>  static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
> >>  							 unsigned long parent_ip)
> >>  {
> >> -	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START, TRACE_FTRACE_MAX);
> >> +	bool ret;
> >> +
> >> +	preempt_disable_notrace();
> >> +	ret = trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START, TRACE_FTRACE_MAX);
> >> +	if (!ret)
> >> +		preempt_enable_notrace();
> >> +
> >> +	return ret;
> >>  }
> >>  
> >>  /**
> > 
> > Oh, I might've gotten that wrong, I assumed regular trylock semantics,
> > but it doesn't look like that's right.
> 
> I will use bit instead ret and give some testing :-)
> 
> BTW, would you prefer to merge these changes into this patch or maybe send
> another patch with your suggested-by?

Yeah, please send another patch; once you've confirmed it actually works
etc.. I did this before waking (as evidence per the above), who knows
what else I did wrong :-)

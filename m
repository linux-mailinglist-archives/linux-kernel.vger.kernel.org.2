Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A8F34511F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhCVUtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCVUsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:48:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C031BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PWFVsqo2+tmo86qmOXZPL8ousuA0MG9MCP1WV2GoPnA=; b=MOC8swxiH0Iy8deGmrTB4CJ9h4
        rGRCisS7myKlS4UK4A7UILa28+a7mPJHfp+c8cnNqsApt6rWk+JrdXuB2UtOe98kh7ttx+h2ejTzr
        6TE1dLEdj9d6GSkiolWQxncB4MAFLm+sD4jddySpVFD0ZNoQDhTlij/VSJ0SiqpJLlq3PDN0teau7
        NuhMjHZaMypR8et2OxBNkX1jj51Nwxpa9Lk9nVMYlnzD94QtBEfMhrwlb0oFNauYYRCjlRLyyMGwe
        k/7r+Ft73x5aAjJsQ4i7t47cOxtzwNjhozFirHYHGIpbImK5zpS8Sb56H7T/GDsMx1vLIPp0E7MrS
        qn1DzXdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lORSa-0093gr-8m; Mon, 22 Mar 2021 20:47:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0427830377D;
        Mon, 22 Mar 2021 21:47:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D81582CEE4988; Mon, 22 Mar 2021 21:47:34 +0100 (CET)
Date:   Mon, 22 Mar 2021 21:47:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_call: fix function type mismatch
Message-ID: <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net>
References: <20210322170711.1855115-1-arnd@kernel.org>
 <20210322153214.25d869b1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322153214.25d869b1@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:32:14PM -0400, Steven Rostedt wrote:
> On Mon, 22 Mar 2021 18:06:37 +0100
> Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The __static_call_return0() function is declared to return a 'long',
> > while it aliases a couple of functions that all return 'int'. When
> > building with 'make W=1', gcc warns about this:
> > 
> > kernel/sched/core.c:5420:37: error: cast between incompatible function types from 'long int (*)(void)' to 'int (*)(void)' [-Werror=cast-function-type]
> >  5420 |   static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
> > 
> > Change the function to return 'int' as well, but remove the cast to
> > ensure we get a warning if any of the types ever change.
> 
> I think the answer is the other way around. That is, to make the functions
> it references return long instead. __static_call_return0 is part of the
> dynamic call infrastructure. Perhaps it is currently only used by functions
> that return int, but what happens when it is used for a function that
> returns a pointer?

Steve is correct. Also, why is that warning correct? On x86 we return in
RAX, and using int will simply not inspect the upper 32 bits there.

And I'm fairly sure I had a pointer user somewhere recently.

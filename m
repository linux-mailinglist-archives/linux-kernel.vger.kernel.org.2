Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2B3056A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhA0JRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhA0JOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:14:47 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CB1C061756
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 01:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cI7ne5sAKnl60zHFpX7JAq+fvPms0iaYd3sctP7DFcQ=; b=kmH9Pn/nfsA42sRuItmhn/VsLh
        9YGn03GU1IqflWHp/k89kRILt30JIW7LmBRP7a7ZdUSdS2x9NuHg3lHWoZqjrXZZ/fA59Edt5F5uv
        z8iDBUvta4JuHEJfHrJO198UP4/rFpEYHOKZx3M6ArAhVFQsKhoxiEgGW88/I+7pTbMABk6Ok760u
        Irm8w3MassOpf/S8/VbKR1V0IaILAiknUUSlW8dWaLA+NYUDDgaH8IVeUQw5+wFOnlfGShsyXGYjB
        j5u4kwNn+n7zoeBbpQ17bcGjLKUMWVvQ3fhj7TVsR42ceb+RyO6AqC79wfLZGGFHrEQs/iBMZY17L
        EeWGzDaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4gtZ-0007Pb-Ku; Wed, 27 Jan 2021 09:13:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5E493010C8;
        Wed, 27 Jan 2021 10:13:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87C212144C090; Wed, 27 Jan 2021 10:13:47 +0100 (CET)
Date:   Wed, 27 Jan 2021 10:13:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        rostedt@goodmis.org, jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
 <20210126235730.lgfa2uida5se5urn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126235730.lgfa2uida5se5urn@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 05:57:30PM -0600, Josh Poimboeuf wrote:
> On Fri, Jan 22, 2021 at 05:52:26PM +0100, Peter Zijlstra wrote:
> >  static int static_call_add_module(struct module *mod)
> >  {
> > -	return __static_call_init(mod, mod->static_call_sites,
> > -				  mod->static_call_sites + mod->num_static_call_sites);
> > +	struct static_call_site *start = mod->static_call_sites;
> > +	struct static_call_site *stop = start + mod->num_static_call_sites;
> > +	struct static_call_site *site;
> > +
> > +	for (site = start; site != stop; site++) {
> > +		unsigned long addr = (unsigned long)static_call_key(site);
> > +		struct static_call_ass *ass;
> > +
> > +		/*
> > +		 * Gotta fix up the keys that point to the trampoline.
> > +		 */
> > +		if (!kernel_text_address(addr))
> > +			continue;
> > +
> > +		ass = static_call_find_ass(addr);
> > +		if (!ass) {
> > +			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
> > +				static_call_addr(site));
> > +			return -EINVAL;
> > +		}
> > +		site->key = ((unsigned long)ass->key - (unsigned long)&site->key) |
> > +			    (site->key & STATIC_CALL_SITE_FLAGS);
> 
> Well, I hate it, but I'm not sure I have any better ideas.  It should be
> possible to use kallsyms, instead of the rb-tree/register nonsense.  Not
> sure about the performance impact though.  Might be a good reason to
> speed up kallsyms!

Oh right, let me see if I can make that work.

> Also I do have some naming suggestions ;-)

Nah, we need a little more fun back in the code :-)

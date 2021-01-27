Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569C2306117
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhA0Qfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236969AbhA0Qe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611765196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WpIdPW5/Xk/LzNPMD9BVWon0kc5gQ4TalhuY8UySBx0=;
        b=JYivCycQyaRubIjZAVuRcOC/dSPcwAZraTk/Rrra+qOK8IObaWp+5I57toNwOaPDROzeqN
        OA71kqQ3W3XOl1blwzz8rRjnoVRUIlCMLz5NOppMu7/1hcveQojRdVUsQbWOkLt73g86bE
        DlnBo5x3jjht6lg0IksWkI2RnqxTqWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-n9DqGrW2PCOwJ6pFlVlyxQ-1; Wed, 27 Jan 2021 11:33:13 -0500
X-MC-Unique: n9DqGrW2PCOwJ6pFlVlyxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7E088066ED;
        Wed, 27 Jan 2021 16:33:11 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DB8F5D9C6;
        Wed, 27 Jan 2021 16:33:10 +0000 (UTC)
Date:   Wed, 27 Jan 2021 10:33:08 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        rostedt@goodmis.org, jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <20210127163308.cgiq7jxx2uziuhcc@treble>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
 <20210126235730.lgfa2uida5se5urn@treble>
 <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
 <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
 <20210127155914.jfmr4jay47yck5h5@treble>
 <YBGSdtnKIL3kryos@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBGSdtnKIL3kryos@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 05:19:02PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 27, 2021 at 09:59:14AM -0600, Josh Poimboeuf wrote:
> > On Wed, Jan 27, 2021 at 12:27:09PM +0100, Peter Zijlstra wrote:
> > > On Wed, Jan 27, 2021 at 10:13:47AM +0100, Peter Zijlstra wrote:
> > > > On Tue, Jan 26, 2021 at 05:57:30PM -0600, Josh Poimboeuf wrote:
> > > 
> > > > > Well, I hate it, but I'm not sure I have any better ideas.  It should be
> > > > > possible to use kallsyms, instead of the rb-tree/register nonsense.  Not
> > > > > sure about the performance impact though.  Might be a good reason to
> > > > > speed up kallsyms!
> > > > 
> > > > Oh right, let me see if I can make that work.
> > > 
> > > Something like so compiles.. but it does make the whole thing depend on
> > > KALLSYMS_ALL, which is somewhat yuck.
> > > 
> > > Also, kallsyms_lookup_name() is horrible, but not trivial to fix because
> > > of that compression scheme used.
> > 
> > The KALLSYMS_ALL dependency doesn't bother me personally but I assume
> > some of the tinyconfig folks might not appreciate it being on
> > permanently.
> 
> I suppose this ought to cure the _ALL thing.
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 7ecd2ccba531..83586cc4d954 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -260,6 +260,12 @@ static int symbol_valid(const struct sym_entry *s)
>  {
>  	const char *name = sym_name(s);
>  
> +	/*
> +	 * Always emit __SCK__ symbols for static_call_add_module().
> +	 */
> +	if (!strncmp(name, "__SCK__", 7))
> +		return 1;
> +
>  	/* if --all-symbols is not specified, then symbols outside the text
>  	 * and inittext sections are discarded */
>  	if (!all_symbols) {

This made me LOL for some reason.  I like it though.

What did you think about .static_call_tramp_key?  I could whip up a
patch later unless you beat me to it.

-- 
Josh


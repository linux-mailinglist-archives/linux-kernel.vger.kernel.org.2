Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C930DC35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhBCOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhBCOFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:05:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F57C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dbkLUfv83nI6Xflqb9q1zm/JmR8Ur/R/RfobV1RGkX4=; b=ZUkgLzNkSaDAXOtxyhACOs5Tz5
        n/RKlEB1wOjYA9WO/+qh3T10NNf1+huaUNZ8FSHKu3gSLT78SG/XxJS7I66EDGtIAKLvAQGJCIl6s
        CSCOz9lXn3fkVbdArhcH/+6G6YWwia9NexOfsfWhR6MSBIPLvD/mMu158HUPW8tNE0Z31C/0PQGD6
        fgpOM2cakouhZhZ7kl1GtU1Xrrx3GoDxXrAtVsTKo70YqZdCMcON6BiI+NAwSOZC8ScPkBT4kr0nS
        i3qPPm2HxGdslSxt0DbUKhI80Ym5DxlakHZ95UWUvFPCkmriRQDGUEDx06LZyC25Ig3L7pbzVVNi5
        dsjSAVsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7Ild-00GzO3-6T; Wed, 03 Feb 2021 14:04:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2F3D3003D8;
        Wed,  3 Feb 2021 15:04:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC68A284AA063; Wed,  3 Feb 2021 15:04:23 +0100 (CET)
Date:   Wed, 3 Feb 2021 15:04:23 +0100
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
Message-ID: <YBqtZwIbj6kQEiEd@hirez.programming.kicks-ass.net>
References: <20210126235730.lgfa2uida5se5urn@treble>
 <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
 <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
 <20210127155914.jfmr4jay47yck5h5@treble>
 <YBGSdtnKIL3kryos@hirez.programming.kicks-ass.net>
 <20210127163308.cgiq7jxx2uziuhcc@treble>
 <YBG0cSoJmu8NnoAT@hirez.programming.kicks-ass.net>
 <20210127190003.64rdwoxyjgnq2rtx@treble>
 <20210127190218.hoztl7eidujqarkt@treble>
 <20210127231837.ifddpn7rhwdaepiu@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127231837.ifddpn7rhwdaepiu@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 05:18:37PM -0600, Josh Poimboeuf wrote:
> On Wed, Jan 27, 2021 at 01:02:18PM -0600, Josh Poimboeuf wrote:
> > On Wed, Jan 27, 2021 at 01:00:07PM -0600, Josh Poimboeuf wrote:
> > > On Wed, Jan 27, 2021 at 07:44:01PM +0100, Peter Zijlstra wrote:
> > > > On Wed, Jan 27, 2021 at 10:33:08AM -0600, Josh Poimboeuf wrote:
> > > > 
> > > > > What did you think about .static_call_tramp_key?  I could whip up a
> > > > > patch later unless you beat me to it.
> > > > 
> > > > Yeah, I'm not sure.. why duplicate information already present in
> > > > kallsyms?
> > > 
> > > Well, but it's not exactly duplicating kallsyms.  No need to store
> > > symbol names, just the pointer relationships.  And kallsyms is
> > > presumably slow.
> > > 
> > > > There's a fair number of features that already require KALLSYMS, I can't
> > > > really be bothered about adding one more (kprobes, function_tracer,
> > > > stack_tracer, ftrace_syscalls).
> 
> Here ya go.  It builds...  And the tramp_key section is nice and small.
> 
> Relocation section [1497] '.rela.static_call_tramp_key' for section [1496] '.static_call_tramp_key' at offset 0x179ab818 contains 8 entries:
>   Offset              Type            Value               Addend Name
>   000000000000000000  X86_64_PC32     0x00000000000004c0      +0 __SCT__preempt_schedule
>   0x0000000000000004  X86_64_PC32     0x000000000005ee10      +0 __SCK__preempt_schedule
>   0x0000000000000008  X86_64_PC32     0x00000000000004c8      +0 __SCT__preempt_schedule_notrace
>   0x000000000000000c  X86_64_PC32     0x000000000005ee00      +0 __SCK__preempt_schedule_notrace
>   0x0000000000000010  X86_64_PC32     0x00000000000004d0      +0 __SCT__cond_resched
>   0x0000000000000014  X86_64_PC32     0x000000000005dd20      +0 __SCK__cond_resched
>   0x0000000000000018  X86_64_PC32     0x00000000000004d8      +0 __SCT__might_resched
>   0x000000000000001c  X86_64_PC32     0x000000000005dd10      +0 __SCK__might_resched
> 

Fair enough I suppose. I'll slap a changelog and your SoB on it and I
suppose I'll got commit the whole lot. Then we can forget about it
again.

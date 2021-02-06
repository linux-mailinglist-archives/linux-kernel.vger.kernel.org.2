Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1977B311C56
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 10:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhBFJFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 04:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBFJEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 04:04:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9780C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 01:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZF97VIJoz6En75OLdh7F+uFHUq2TFG5w7tIH8/c2dcA=; b=T2U3nOQS1YS2g/ZYRMACBrwf4+
        atYgkfbQPCulLBHwLxRnxLaQxtCTXyFZp0ukEQuigiao2Zk7Ck+xAHhzmyYaGaO2wvLuIyGJI+f/A
        kfr9zuxEWmRLJV+NNTUoFU/Ofs/o0bOsDkfrDHHMldJYpCCjTuBpPKhodoIncjYd8CoqP/N+Q3Irt
        ZokwJ1/f9B5r+QAwW9ROsyK5RmDW6tL7H+0FxkKbm/zgAaK21BFR5PQw4H3NTH5vLTfWJnH7Ee17E
        psFz8mHVlsgmcQD139VnNI+jZtxYFlJJ/NLtgC6cPEfQGFuhMdJAZ0eG26ktAAIRvHldXdoIb0L8U
        7RCdymrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l8JVE-003Nqu-5m; Sat, 06 Feb 2021 09:03:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8452D981194; Sat,  6 Feb 2021 10:03:38 +0100 (CET)
Date:   Sat, 6 Feb 2021 10:03:38 +0100
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
Message-ID: <20210206090338.GK8912@worktop.programming.kicks-ass.net>
References: <20210127155914.jfmr4jay47yck5h5@treble>
 <YBGSdtnKIL3kryos@hirez.programming.kicks-ass.net>
 <20210127163308.cgiq7jxx2uziuhcc@treble>
 <YBG0cSoJmu8NnoAT@hirez.programming.kicks-ass.net>
 <20210127190003.64rdwoxyjgnq2rtx@treble>
 <20210127190218.hoztl7eidujqarkt@treble>
 <20210127231837.ifddpn7rhwdaepiu@treble>
 <YBqtZwIbj6kQEiEd@hirez.programming.kicks-ass.net>
 <YB1ksCPhD40f0VQn@hirez.programming.kicks-ass.net>
 <20210206023122.ijbihwpzrcxzhi52@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206023122.ijbihwpzrcxzhi52@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 08:31:22PM -0600, Josh Poimboeuf wrote:
> On Fri, Feb 05, 2021 at 04:30:56PM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 03, 2021 at 03:04:23PM +0100, Peter Zijlstra wrote:
> > > Fair enough I suppose. I'll slap a changelog and your SoB on it and I
> > > suppose I'll got commit the whole lot. Then we can forget about it
> > > again.
> > 
> > FWIW, the whole thing looks like this..
> > 
> > ---
> > Subject: static_call: Allow module use without exposing static_call_key
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > Date: Wed, 27 Jan 2021 17:18:37 -0600
> > 
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > When exporting static_call_key; with EXPORT_STATIC_CALL*(), the module
> > can use static_call_update() to change the function called.  This is
> > not desirable in general.
> 
> Looks good to me, thanks for fixing that up.  Never said I tested it ;-)

Yeah, and I'm the genius that 'tested' it with a MODULES=n build :-)

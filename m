Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9930638A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbhA0SqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344084AbhA0Spm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:45:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84631C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rD8CljQu65DLfq8LkyH0pBE2vYkKz5EYDujrWa/e6EU=; b=rLHCmJ0gPHtnmotavllWbTjKpA
        JdHJPL6ay3AUZdmPzfz9VWcuuvWYnKd8aUErHqbGmq3wIdqdAV9ky9Hqj3ksRfeKU6LANIQEiYvEX
        6Hqaoap6aoksYQReHVZE2rSfpYYTLiQ+by4Gp3LaWCnKAcXGK95mNwt4RDG9NSdAJSkQuEGeB40jD
        Lx5r96Fn34cfcDKH3D9HiNJru8rOqLCIWW9Mc5d09EmcBbJyGwGINnebPOKmJuJ2fDcZuKaXYerEX
        R5SPeX3eY0/aAScaFMf5r4BuaP6ZQ9HZf4zmREwaqPbmPQBG+1vGqdOsxwTqCcdL0PYmGfdV7/l2y
        UxXn5FeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4pnQ-007Moe-Cz; Wed, 27 Jan 2021 18:44:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFF4A3059C6;
        Wed, 27 Jan 2021 19:44:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADAED2D1C682A; Wed, 27 Jan 2021 19:44:01 +0100 (CET)
Date:   Wed, 27 Jan 2021 19:44:01 +0100
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
Message-ID: <YBG0cSoJmu8NnoAT@hirez.programming.kicks-ass.net>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
 <20210126235730.lgfa2uida5se5urn@treble>
 <YBEuy6zlBcV8gLvY@hirez.programming.kicks-ass.net>
 <YBFODfNZCjA9s0IP@hirez.programming.kicks-ass.net>
 <20210127155914.jfmr4jay47yck5h5@treble>
 <YBGSdtnKIL3kryos@hirez.programming.kicks-ass.net>
 <20210127163308.cgiq7jxx2uziuhcc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127163308.cgiq7jxx2uziuhcc@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 10:33:08AM -0600, Josh Poimboeuf wrote:

> What did you think about .static_call_tramp_key?  I could whip up a
> patch later unless you beat me to it.

Yeah, I'm not sure.. why duplicate information already present in
kallsyms?

There's a fair number of features that already require KALLSYMS, I can't
really be bothered about adding one more (kprobes, function_tracer,
stack_tracer, ftrace_syscalls).

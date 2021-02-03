Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C76730DB76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhBCNjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhBCNh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:37:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E43FC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 05:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r0k7fkjKZZ1/Vt6lQr+Rtmn6WL7bhCFvwGKVqtcNWZ0=; b=JD4ERjBlcjJ0TYq7tXpsomdani
        m3trTAmxAW1JhLlxvNlVazdX9jfnK7BFy/BrxHFqppV4znvS5JKIil7IvkhEcVoDJd1kulkjMafSi
        idCh//S4tVV/8De/4BJ0TPVs2QHp3zD80eKg2OklccCJoUdeRjWO2QhIarz+I8QEKOn/nmlA+/WVk
        Tt0AuEgWfI5/L6nhS65dgYioST8kCM5wJ7JCpwYd1MPTHdETPTnIz2dooFElJew0Ty+S7KTZt7RF3
        bxXi+/Cikx7vaOOLDaZHMjQ6VWLtZbgvv/NYMgzyz5HTIRWbl21Pdxhcs/4MgR6IOH4oJs123I52S
        oiUdUc/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7ILF-0005GU-9t; Wed, 03 Feb 2021 13:37:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6034C301A66;
        Wed,  3 Feb 2021 14:37:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49125284AA052; Wed,  3 Feb 2021 14:37:05 +0100 (CET)
Date:   Wed, 3 Feb 2021 14:37:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Subject: Re: Process-wide watchpoints
Message-ID: <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net>
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net>
 <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
 <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net>
 <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:49:56PM +0100, Dmitry Vyukov wrote:
> On Wed, Feb 3, 2021 at 1:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Feb 01, 2021 at 09:50:20AM +0100, Dmitry Vyukov wrote:
> > > Or, alternatively would it be reasonable for perf to generate SIGTRAP
> > > directly on watchpoint hit (like ptrace does)? That's what I am
> > > ultimately trying to do by attaching a bpf program.
> >
> > Perf should be able to generate signals, The perf_event_open manpage
> > lists two ways of trigering signals. The second way doesn't work for
> > you, due to it not working on inherited counters, but would the first
> > work?
> >
> > That is, set attr::wakeup_events and fcntl(F_SETSIG).
> 
> The problem is that this sends a signal to the fd owner rather than
> the thread that hit the breakpoint. At least that's what happened in
> our tests. We would like to send a signal to the thread that hit the
> breakpoint.

Ah indeed.. all of this was aimed at self-monitoring.

Letting perf send a signal to the monitored task is intrusive.. let me
think on that.

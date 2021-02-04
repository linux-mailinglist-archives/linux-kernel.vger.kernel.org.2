Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BA230F422
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhBDNrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbhBDNqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:46:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6E9C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rrb7GIsALulMLgBpvfMJZt8+pR64np3LnHjQDkWTEbg=; b=ZB5GwrNmgI54ZMhy7qADcO5Cqe
        pc2TmFfQLSnkqU1glto/94KgR/G3d3mRniKzXkzPeoyRA5ldwMlnvn3n6LDam++0CFlr7T2ovZcnu
        Kjo2MGXvA5aR6SIaKa8YwUvsiFi1lNljVBGEXDam4TDBYmII7uBhtb0oY3iSNL0xs9+uNwX8gC+ro
        FoZXo9W31kiLLOaSXJ7Da+E3kcrVv55vPMqpluufijq5k/C6fozVECaZkgDQdHHaTZ9zObMw5snJh
        3gBeifdOkJolEQGsB4XxG4EOpd/mKpIIJzkemPPfS9kdyLGhV8ZZe1KHXWkhE5vQcnI9TBHhOjL6J
        zjUwB3FA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7ex4-0007c4-Bp; Thu, 04 Feb 2021 13:45:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB36230066E;
        Thu,  4 Feb 2021 14:45:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A86D72C12E8F6; Thu,  4 Feb 2021 14:45:40 +0100 (CET)
Date:   Thu, 4 Feb 2021 14:45:40 +0100
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
Message-ID: <YBv6hG0lD8bsiGG/@hirez.programming.kicks-ass.net>
References: <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net>
 <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net>
 <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
 <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net>
 <CACT4Y+ZLSyVMkPfh3PftEWKC1kC+o1XLxo_o6i4BiyRuPig27g@mail.gmail.com>
 <YBvj6eJR/DY2TsEB@hirez.programming.kicks-ass.net>
 <CACT4Y+a17L2pUY1kkRB_v_y3P_sbMpSLb6rVfXmGM7LkbAvj5Q@mail.gmail.com>
 <YBvyTDR+q0M62vKR@hirez.programming.kicks-ass.net>
 <CACT4Y+ZbWMa7zsa84dOBZ0C0Qgik2uDST+bzX=TrSU6vFXkkCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZbWMa7zsa84dOBZ0C0Qgik2uDST+bzX=TrSU6vFXkkCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 02:35:36PM +0100, Dmitry Vyukov wrote:
> On Thu, Feb 4, 2021 at 2:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Feb 04, 2021 at 01:53:59PM +0100, Dmitry Vyukov wrote:
> > > Humm... I was thinking of perf_event_open(pid == 0).
> > > It does not make sense to send SIGTRAP in a remote process, because it
> > > does not necessarily cooperate with us.
> > >
> > > But is there any problem with clone w/o CLONE_THREAD? Assuming the
> > > current process has setup the signal handler, the child will have the
> > > same handler and the same code/address space. So delivery of SIGTRAP
> > > should work the same way in the child.
> >
> > Nothing should be doing CLONE_VM without CLONE_THREAD. Yes, it's
> > possible, but if you do so, you get to keep the pieces IMO.
> >
> > Current libc either does a full clone (fork) or pthread_create,
> > pthread_create does CLONE_THREAD.
> 
> I meant a different thing.
> I meant that we could restrict synchronous SIGTRAP for (1)
> perf_event_open(pid != 0) and (2) disable it after exec.

Ah, I figured a generic means to inherit across a process, but not a
process tree might be useful.

I don't much like magical/implied constraints.

> What is the issue here for clone without CLONE_THREAD?

It's an abomination that's possible and an endless cause of trouble :/

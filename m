Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE9E32BCAA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381315AbhCCOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842965AbhCCKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD2EC08ECA4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RRqVDNmqK8qWgfS2O35qxiJ4bts6fZ0niwzW8fuS1pE=; b=RZxNeBzv4lnmfhVYK840iREUeF
        W6lHMxTpkq+4pRUUJ3aOlWBf6ktD2mMo0UptaXOfuzkV/Z2RDN32ZJA/aMTTCsWkpM9cNEcS1sI3i
        /ns/0khSsg3vlB84N5dd0erf87ZjTK0rKw9AaixgMgUNKMioP7Ip7XAZHqXbm2km6XM7pE6Le3yEZ
        km+RvqDGMKiKRdiWjAGNuq3B6LQ0IohV2MDQeQPi0BUW9Q/jwOmgvmxqQEHFeumkhYZW06ZK6c7dN
        XC4YV16WVQmyIJKlaT5iIvEXcgg+5gVvYs/aatti7GwnBSbeJTyy9YvqZlCfmSaRABQLFC0XY/s1P
        2Nf/5SFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHO8G-0023te-UB; Wed, 03 Mar 2021 09:49:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26027303205;
        Wed,  3 Mar 2021 10:49:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D520E264F0E2E; Wed,  3 Mar 2021 10:49:27 +0100 (CET)
Date:   Wed, 3 Mar 2021 10:49:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>
Subject: Re: [PATCH] sched: Optimize __calc_delta.
Message-ID: <YD9bp7C9k6ojjq/5@hirez.programming.kicks-ass.net>
References: <20210226195239.3905966-1-joshdon@google.com>
 <YDliCOPy9s1RdLwd@hirez.programming.kicks-ass.net>
 <CABk29Nv7iJEcDg3rgSvfTkXEM69ZeLByJAsZYuA5qpdj645nZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nv7iJEcDg3rgSvfTkXEM69ZeLByJAsZYuA5qpdj645nZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 12:55:07PM -0800, Josh Don wrote:
> On Fri, Feb 26, 2021 at 1:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Feb 26, 2021 at 11:52:39AM -0800, Josh Don wrote:
> > > From: Clement Courbet <courbet@google.com>
> > >
> > > A significant portion of __calc_delta time is spent in the loop
> > > shifting a u64 by 32 bits. Use a __builtin_clz instead of iterating.
> > >
> > > This is ~7x faster on benchmarks.
> >
> > Have you tried on hardware without such fancy instructions?
> 
> Was not able to find any on hand unfortunately. Clement did rework the
> patch to use fls() instead, and has benchmarks for the generic and asm
> variations. All of which are faster than the loop. In my next reply,
> I'll include the updated patch inline.

Excellent; I have some vague memories where using fls ended up slower
for some ARMs, but I can't seem to remember enough to even Google it :/

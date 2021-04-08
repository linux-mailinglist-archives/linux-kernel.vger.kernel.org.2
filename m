Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95E358A19
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhDHQtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhDHQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:49:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38677C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tLdMJ4vAhY0dljsEQkW3I5q8Gz/FHaM+IhXZFq9oiug=; b=J9An1k+7gAaK2KDmSD/xLD7jhh
        aavOX9ApkeGmz2kctpgBRIWSk98pKU7R7iqtdZ/Fsxs6pOXKVRasV249bkptfQ12mgegPp3+IMWmt
        /Lv6mfyojGt2HKK/zPWchAqbiHtWvftK6PXr0d4a22mrIvHwdmY02ttWSnsHYmjr84tkLnm6YNGRN
        ZNPeU2X1kuZ9lvhBh2pv7PHa5cSkIX0NBVvNuTM/dwhBIHY6GGw416dVYG3c1C7s9sDUoNWgu4lSq
        3ZnM97jfln7KiWxeZpJrZfGHzQMvlHdBEbtCN8kfdoRZoUVOMEIQ4Wxy7tVfDOoFvvOrC/FTGvT9i
        oTkMMZhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXnx-00GXdG-3V; Thu, 08 Apr 2021 16:47:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61F943001DB;
        Thu,  8 Apr 2021 18:46:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AA8E2BCD72D1; Thu,  8 Apr 2021 17:02:20 +0200 (CEST)
Date:   Thu, 8 Apr 2021 17:02:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, joel@joelfernandes.org,
        chris.hyser@oracle.com, joshdon@google.com, mingo@kernel.org,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YG8a/LbO4PXFLEix@hirez.programming.kicks-ass.net>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <YG3i2JF2vBY4CseK@blackbook>
 <YG37MBLBIXIPVv7u@hirez.programming.kicks-ass.net>
 <YG8EYKgcwLCfIZAV@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG8EYKgcwLCfIZAV@blackbook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 03:25:52PM +0200, Michal Koutný wrote:
> On Wed, Apr 07, 2021 at 08:34:24PM +0200, Peter Zijlstra <peterz@infradead.org> wrote:
> > IMO as long as cgroups have that tasks file, you get to support people
> > using it. That means that tasks joining your cgroup need to 'inherit'
> > cgroup properties.
> The tasks file is consequence of binding this to cgroups, I'm one step
> back. Why to make "core isolation" a cgroup property?

Yeah, dunno, people asked for it. I'm just proposing an implementation
that, when given the need, seems to make sense and is internally
consistent.

> (I understand this could help "visualize" what the common domains are if
> cgroups were the only API but with prctl the structure can be
> arbitrarily modified anyway.)
> 
> 
> > Given something like:
> > 
> >         R
> >        / \
> >       A   B
> >          / \
> >         C   D
> Thanks for the example. 
> 
> > B group can set core_sched=1 and then all its (and its decendants) tasks
> > get to have the same (group) cookie and cannot share with others.
> The same could be achieved with the first task of group B allocating its
> new cookie which would be inherited in its descednants.

Except then the task can CLEAR its own cookie and escape the constraint.

> > In that scenario the D subtree is a restriction (doesn't share) with the
> > B subtree.
> This implies D's isolation from everything else too, not just B's
> members, no?

Correct. Look at it as a contraint on co-scheduling, you can never,
whatever you do, share an SMT sibling with someone outside your subtree.

> > And all of B is a restriction on all its tasks, including the Real-Time
> > task that set a task cookie, in that none of them can share with tasks
> > outside of B (including system tasks which are in R), irrespective of
> > what they do with their task cookie.
> IIUC, the equivalent restriction could be achieved with the PTRACE-like
> check in the prctl API too (with respectively divided uids).

I'm not sure I understand; if tasks in A and B are of the same user,
then ptrace will not help anything. And per the above, you always have
ptrace on yourself so you can escape your constraint per the above.

> I'm curious whether the cgroup API actually simplifies things that are
> possible with the clone/prctl API or allows anything that wouldn't be
> otherwise possible.

With the cgroup API it is impossible for a task to escape the cgroup
constraint. It can never share a core with anything not in the subtree.

This is not possible with just the task interface.

If this is actually needed I've no clue, IMO all of cgroups is not
needed :-) Clearly other people feel differently about that.


Much of this would go away if CLEAR were not possible I suppose. But
IIRC the idea was to let a task isolate itself temporarily, while doing
some sensitive thing (eg. encrypt an email) but otherwise not be
constrained. But I'm not sure I can remember all the various things
people wanted this crud for :/

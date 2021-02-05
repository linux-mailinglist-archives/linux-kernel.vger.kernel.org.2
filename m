Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2043310973
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhBEKsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBEKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:44:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A41C061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AZTrsdIgEHD7KFjMJJWY83JzN98tigxEzZxfCzeUzSI=; b=L3nRt+3TAeaRteiVZDzGWTUV8h
        7v0OHOuv/hp1rSAtqPpcvda/thx4Kk4sy5tSZXPFbZ0f+9YjyXwZxTBVUYF3jvAnm5icdYINefK6C
        1mqKuOqODiTDEYZ3sOOrzr51DqaFj3cIgwlFdLTQYZcDJCXSDitLtJs+/bZK6pgSvsdz9HlOR1ZEP
        bGhM4qA6VYrsVm/UYLm7qE9qlKIqGzXkw4D2jBAWZ83p0mqswUPrCop92bWPUuw+M+5uQKWwHItvv
        PyD4GNpkz7x4Et+7y4Zgjfz/nmTMPQ+yxDBxCrr0kcOwriYnGNwEMJTPTtLtsJxL4Aay8UfJ4XBqg
        U4mope0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7yZx-0001nm-K0; Fri, 05 Feb 2021 10:43:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FBCD3013E5;
        Fri,  5 Feb 2021 11:43:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DC112BBE1CB0; Fri,  5 Feb 2021 11:43:03 +0100 (CET)
Date:   Fri, 5 Feb 2021 11:43:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Hyser <chris.hyser@oracle.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
Message-ID: <YB0hN5XG5dB0xiBh@hirez.programming.kicks-ass.net>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
 <YBv9Uy1dyv8E2LAz@hirez.programming.kicks-ass.net>
 <94bb9424-008e-6d3c-dff6-a1329c16551f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94bb9424-008e-6d3c-dff6-a1329c16551f@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 03:52:55PM -0500, Chris Hyser wrote:

> A second complication was a decision that new processes (not threads) do not
> inherit their parents cookie. Thus forking is also not a means to share a
> cookie. Basically with a "from-only" interface, the new task would need to
> be modified to call prctl() itself. From-only also does not allow for
> setting a cookie on an unmodified already running task. This can be fixed by
> providing both a "to" and "from" sharing interface that allows helper
> programs to construct arbitrary configurations from unmodified programs.

Do we really want to inhibit on fork() or would exec() be a better
place? What about those applications that use fork() based workers?

> > Also, how do I set a unique cookie on myself with this interface?
> 
> The v10 patch still uses the overloaded v9 mechanism (which as mentioned
> above is if two tasks w/o cookies share a cookie they get a new shared
> unique cookie). Yes, that is clearly an inconsistency and kludgy. The
> mechanism is documented in the docs, but clearly not obvious from the

I've not seen a document so far (also, I'm not one to actually read
documentation, much preferring comments and Changelogs).

> So based on the above, how about we add a "create" to pair with "clear" and
> call it "create" vs "set" since we are creating a unique opaque cookie
> versus setting a particular value. And as mentioned, because one can't
> specify a cookie directly but only thru sharing relationships, we need both
> "to" and "from" to make it completely usable.
> 
> So we end up with something like this:
>     PR_SCHED_CORE_CREATE                       -- give yourself a unique cookie
>     PR_SCHED_CORE_CLEAR                        -- clear your core sched cookie
>     PR_SCHED_CORE_SHARE_FROM <src_task>        -- get their cookie for you
>     PR_SCHED_CORE_SHARE_TO   <dest_task>       -- push your cookie to them

I'm still wondering why we need _FROM/_TO. What exactly will we miss
with just _SHARE <pid>?

	current		arg_task
	<none>		<none>		-EDAFT
	<none>		<cookie>	current gets cookie
	<cookie>	<none>		arg_task gets cookie
	<cookie>	<cookie>	-EDAFTER

(I have a suspicion, but I want to see it spelled out).

Also, do we wants this interface to be able to work on processes? Things
like fcntl(F_SETOWN_EX) allow you to specify a PID type.

> An additional question is should the inheritability of a process' cookie be
> configurable? The current code gives the child process their own unique
> cookie if the parent had a cookie. That is useful in some cases, but many
> other configurations could be made much easier with inheritance.

What was the argument for not following the traditional fork() semantics
and inheriting everything?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB41342DF3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCTPsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhCTPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:48:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12680C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zbIftbE/u+M6OpaoufTPcNdH56Tj34uXrx7w5JT/Y1E=; b=LyhUjltMocKGlYzFZaWpwVKKMv
        ySLz6nUd3mia5MaCshd5GXoP4WBQA2w4mlmIuVtLlFlWTZvfzKQvnAl9xNTBgDaQMBpS2QtIcxMq0
        uPq/1bPD6S/FXoav9lnU460MRrj7InICCK7W91FJPFzS7BHKdD2kSfW1EBybv0M7Uie4ZbDW4NcKw
        KrGjD19/Hoz4fvTOttiiLKvHVsa6YzsS2Ta/Ap188h7ACCJyMVIYznPid8Kgm5dj8cnJfS6mn0oUJ
        JZJKtWEzt9TLW/Q+cSRbBrRJANhc936jeq5g/y+P0PrOBASdavEQsH1Rfg3JaqqcyXNRsbYyfZV0D
        ShwF5NnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNdo9-005zlT-1B; Sat, 20 Mar 2021 15:46:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 350839864FF; Sat, 20 Mar 2021 16:46:32 +0100 (CET)
Date:   Sat, 20 Mar 2021 16:46:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 2/6] sched: tagging interface for core scheduling
Message-ID: <20210320154632.GZ4746@worktop.programming.kicks-ass.net>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319203253.3352417-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 04:32:49PM -0400, Joel Fernandes (Google) wrote:
> From: Josh Don <joshdon@google.com>
> 
> Adds per-task and per-cgroup interfaces for specifying which tasks can
> co-execute on adjacent SMT hyperthreads via core scheduling.
> 
> The per-task interface hooks are implemented here, but are not currently
> used. The following patch adds a prctl interface which then takes
> advantage of these.
> 
> The cgroup interface can be used to toggle a unique cookie value for all
> descendent tasks, preventing these tasks from sharing with any others.
> See Documentation/admin-guide/hw-vuln/core-scheduling.rst for a full
> rundown.
> 
> One important property of this interface is that neither the per-task
> nor the per-cgroup setting overrides the other. For example, if two
> tasks are in different cgroups, and one or both of the cgroups is tagged
> using the per-cgroup interface, then these tasks cannot share, even if
> they use the per-task interface to attempt to share with one another.
> 
> The above is implemented by making the overall core scheduling cookie a
> compound structure, containing both a task-level cookie and a
> group-level cookie. Two tasks will only be allowed to share if all
> fields of their respective cookies match.
> 
> Core scheduler has extra overhead.  Enable it only for machines with
> more than one SMT hardware thread.

Oh man.. I'd soooo hoped to first see the simple task interface and then
see the cgroup patch on top of that... I'll see if I can flip them
myself (on monday).

> +#ifdef CONFIG_SCHED_CORE
> +struct sched_core_cookie {
> +	unsigned long task_cookie;
> +	unsigned long group_cookie;
> +
> +	/* A u64 representation of the cookie used only for display to
> +	 * userspace. We avoid exposing the actual cookie contents, which
> +	 * are kernel pointers.
> +	 */

Tssk, invalid comment style that..

> +	u64 userspace_id;
> +};

> +static unsigned long sched_core_alloc_task_cookie(void)
> +{
> +	struct sched_core_task_cookie *ck =
> +		kmalloc(sizeof(struct sched_core_task_cookie), GFP_KERNEL);

	struct sched_core_task_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);

Also, those type names are unfortunately long..

> +static void sched_core_get_task_cookie(unsigned long cookie)
> +{
> +	struct sched_core_task_cookie *ptr =
> +		(struct sched_core_task_cookie *)cookie;

	struct sched_core_task_cookie *ptr = (void *)cookie;

Know your language and use it to avoid typing excessively long names :-)


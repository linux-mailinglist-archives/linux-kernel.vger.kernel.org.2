Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2EE34A2D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhCZH7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhCZH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:58:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D91AC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JXRxO8ZLRKfbNFgtpxpGRAeI6d4On0gl/yZORiSd/bE=; b=rXBPmMQgxKYMc5o12FfB3/aJZi
        HR8IH0ecfuxg8SiC8E5qLjmMDACO9Z8z1Np2S2Ghm1OjWkMPqS12z3LLTHmKDeJQ2xr96i888ta5r
        ie8OrN/bUeMqAo75qKT9S0mm05L40Px8ljVO1/vRM1sgjO69UhyUfHV7PPuwETMd6IBXBqmTGxu+k
        m3pY+vfwNtLthIC7Uwgi8BfzdcYD95m9bgu9poWxx8dfFfHr5R4n1xaIUEdWERRnOFQJF7N0tQJLY
        +JD4vVxu2zcjlWgbNuN6U5x09OZ69SjfHbifl9AXVmS5/j/CKfm97stULGkuZ5FtU7+2jrfcdDiD+
        64w6KihA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPhMS-002zx1-JB; Fri, 26 Mar 2021 07:58:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AC673003E1;
        Fri, 26 Mar 2021 08:58:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 031F220C8D69C; Fri, 26 Mar 2021 08:58:27 +0100 (CET)
Date:   Fri, 26 Mar 2021 08:58:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] task_struct::state frobbing
Message-ID: <YF2UI8LFH0YaY6aJ@hirez.programming.kicks-ass.net>
References: <YFzSWR6mAGitxMqA@hirez.programming.kicks-ass.net>
 <20210325182735.GA28349@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325182735.GA28349@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 07:27:35PM +0100, Oleg Nesterov wrote:
> On 03/25, Peter Zijlstra wrote:
> >
> >  static void ptrace_unfreeze_traced(struct task_struct *task)
> >  {
> > -	if (task->state != __TASK_TRACED)
> > +	if (READ_ONCE(task->__state) != __TASK_TRACED)
> >  		return;
> 
> this change is correct,
> 
> > @@ -201,11 +201,11 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
> >  	 * Recheck state under the lock to close this race.
> >  	 */
> >  	spin_lock_irq(&task->sighand->siglock);
> > -	if (task->state == __TASK_TRACED) {
> > +	if (READ_ONCE(task->__state) == __TASK_TRACED) {
> 
> this too,
> 
> > @@ -240,7 +240,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
> >  	 */
> >  	read_lock(&tasklist_lock);
> >  	if (child->ptrace && child->parent == current) {
> > -		WARN_ON(child->state == __TASK_TRACED);
> > +		WARN_ON(task_is_traced(child));
> >  		/*
> >  		 * child->sighand can't be NULL, release_task()
> >  		 * does ptrace_unlink() before __exit_signal().
> > @@ -257,7 +257,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
> >  			 * ptrace_stop() changes ->state back to TASK_RUNNING,
> >  			 * so we should not worry about leaking __TASK_TRACED.
> >  			 */
> > -			WARN_ON(child->state == __TASK_TRACED);
> > +			WARN_ON(task_is_traced(child));
> 
> 
> the two above are not.
> 
> "state == __TASK_TRACED" and task_is_traced() is not the same thing.
> 
> "state == __TASK_TRACED" means that debugger changed the state from TASK_TRACED
> to __TASK_TRACED (iow, removed TASK_WAKEKILL) to ensure the tracee can not run,
> this doesn't affect task_is_traced().

Ah, my bad. I didn't expect the other bits to be relevant there,
should've read the code better. Will fix. Thanks!

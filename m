Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6344F208
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 08:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhKMHmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 02:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhKMHme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 02:42:34 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB45C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 23:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1ZlGfwZLOlCg9D47cdd/t53MBwf6+56wY9caM1o2VUM=; b=BqwgwSfSB1ez7UVe/m2YuLJAmX
        MMfhwOjBfQMARCnl8MTPG5sjQ87dD1IvEIdyknP0DnqRSbmwrP+3izwkTyy3kHpep+S7eR+W5hpNy
        klniVFKWlQp9zIb0hoIA2okVmyWabSu4NqJViqgeIYyZAZoy4SLS5RlvQxI2T4WOAwCnqdtyBziqP
        iGPSdGOLbm0tZC3fsJsZG2KrzeDNktcRA7A3ayb78FYzFM6dc9GApEd0ZilYoEyar0WEYlVd5br6l
        MptZkFP5zb96vSPKIrfX1y4r9H3+jTIFWOuT8F7AbGGozNUFFM0gfH/+9RbopHpOp79+mEW4L1CoW
        Yo4E59Yw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlnd6-00FmZu-Fx; Sat, 13 Nov 2021 07:39:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D942230001B;
        Sat, 13 Nov 2021 08:39:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93F25205E4DB6; Sat, 13 Nov 2021 08:39:14 +0100 (CET)
Date:   Sat, 13 Nov 2021 08:39:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Brian Chen <brianchen118@gmail.com>, brianc118@fb.com,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] psi: fix PSI_MEM_FULL state when tasks are in memstall
 and doing reclaim
Message-ID: <YY9rohAcZ/1IGNDd@hirez.programming.kicks-ass.net>
References: <20211110213312.310243-1-brianchen118@gmail.com>
 <YY6cAFtHOhw2zEc7@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY6cAFtHOhw2zEc7@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 11:53:20AM -0500, Johannes Weiner wrote:
> On Wed, Nov 10, 2021 at 09:33:12PM +0000, Brian Chen wrote:
> > We've noticed cases where tasks in a cgroup are stalled on memory but
> > there is little memory FULL pressure since tasks stay on the runqueue
> > in reclaim.
> > 
> > A simple example involves a single threaded program that keeps leaking
> > and touching large amounts of memory. It runs in a cgroup with swap
> > enabled, memory.high set at 10M and cpu.max ratio set at 5%. Though
> > there is significant CPU pressure and memory SOME, there is barely any
> > memory FULL since the task enters reclaim and stays on the runqueue.
> > However, this memory-bound task is effectively stalled on memory and
> > we expect memory FULL to match memory SOME in this scenario.
> > 
> > The code is confused about memstall && running, thinking there is a
> > stalled task and a productive task when there's only one task: a
> > reclaimer that's counted as both. To fix this, we redefine the
> > condition for PSI_MEM_FULL to check that all running tasks are in an
> > active memstall instead of checking that there are no running tasks.
> > 
> >         case PSI_MEM_FULL:
> > -               return unlikely(tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]);
> > +               return unlikely(tasks[NR_MEMSTALL] &&
> > +                       tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
> > 
> > This will capture reclaimers. It will also capture tasks that called
> > psi_memstall_enter() and are about to sleep, but this should be
> > negligible noise.
> > 
> > Signed-off-by: Brian Chen <brianchen118@gmail.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> This bug essentially causes us to count memory-some in walltime and
> memory-full in tasktime, which can be quite confusing and misleading
> in combined CPU and memory pressure situations.
> 
> The fix looks good to me, thanks Brian.
> 
> The bug's been there since the initial psi commit, so I don't think a
> stable backport is warranted.
> 
> Peter, absent objections, can you please pick this up through -tip?

Yep can do. Note that our psi_group_cpu data structure is now completely
filled (the extra tasks state filled the last hole):

struct psi_group_cpu {
	seqcount_t                 seq __attribute__((__aligned__(64))); /*     0     4 */
	unsigned int               tasks[5];             /*     4    20 */
	u32                        state_mask;           /*    24     4 */
	u32                        times[7];             /*    28    28 */
	u64                        state_start;          /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u32                        times_prev[2][7] __attribute__((__aligned__(64))); /*    64    56 */

	/* size: 128, cachelines: 2, members: 6 */
	/* padding: 8 */
	/* forced alignments: 2 */
} __attribute__((__aligned__(64)));


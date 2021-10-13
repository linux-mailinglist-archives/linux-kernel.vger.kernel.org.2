Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672EC42C463
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbhJMPFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbhJMPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:05:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501F0C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z/8lezCtAAQUJrDwdNzrHnDIWbY6BINWvzK71dQDBUc=; b=UqpqVCWUkpyVk4F5QgpVT7SuDc
        u2AbQs0DFfarcOVIwGjBP0wJjFLxUPtjcMDJZX5KdRmeYS1ib6XBo8nifbi+r3fyHuvw3lYSFPODR
        Nudav5upuPkG5AA+FD4vGjN8C5zveM+4zRbWqsdiykgEDS2IOJlZzmg4yKv/p8awoneclhs324Klb
        jI8VG/pn8o0NqMVQjaAnTRvEdVuXeq1x2UvtimVMjatlH5wkA5C5igzDNCFCevOHBIj5gVqkpJfmC
        E+xkdOyy3MDYNVBmHH/qtHfbErRhzGoiaHn9nz/r+Lh6bUdfO/728uuN04T19RwlNdcsqo7mOFebG
        OHvAg71Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mafl4-007XJz-1H; Wed, 13 Oct 2021 15:01:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BCA8030030B;
        Wed, 13 Oct 2021 17:01:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5100E2CA86B35; Wed, 13 Oct 2021 17:01:29 +0200 (CEST)
Date:   Wed, 13 Oct 2021 17:01:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch v4 1/8] add basic task isolation prctl interface
Message-ID: <YWb0ycw/sNV8isBH@hirez.programming.kicks-ass.net>
References: <20211007192346.731667417@fedora.localdomain>
 <20211007193525.755160804@fedora.localdomain>
 <YWWIHkoAdTkzU0TP@hirez.programming.kicks-ass.net>
 <20211013105637.GA88322@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013105637.GA88322@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 07:56:37AM -0300, Marcelo Tosatti wrote:
> Hi Peter,
> 
> On Tue, Oct 12, 2021 at 03:05:34PM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 07, 2021 at 04:23:47PM -0300, Marcelo Tosatti wrote:
> > > Add basic prctl task isolation interface, which allows
> > > informing the kernel that application is executing 
> > > latency sensitive code (where interruptions are undesired).
> > > 
> > > Interface is described by task_isolation.rst (added by
> > > next patch).
> > 
> > That does not absolve you from actually writing a changelog here.
> > Life is too short to try and read rst shit.
> 
> The rst is concise and contains all necessary information.

rst is a piece of crap and makes it harder to read plain text files.

> Changelog is on the patch header (I would appreciate reviews of
> the interface itself, not sure why the changelog is important).

Adding an interface without Changelog is a no-no. Changelogs go on the
patches themselves, not someplace random.

> The rst compiled in PDF form is attached. Its only 6 pages long, it
> described the interface (please if you think of any improvement 
> to that document, and not only the interface).

Wth would I want to read a pdf? Plain text is what I want, without
added crap on. That's my complaint with rst, it makes reading the actual
document harder by having all that nonsense sprinkled in.

I spend 99% of my time looking at fixed width text in a text editor.
Having to open a browser or some random other crap gui program is a
fail.

> > including the kill-me-on-any-interruption thing, vs the inherently racy
> > nature of some of the don't disturb me stuff.
> 
> The kill-me-on-any-interruption thing is not included in this patchset
> (maybe it can be implemented using this interface, if desired, but we
> do not see the need for such feature at the moment).

It's something that has been requested lots, and has been part of
previous series. Since it's a known and desired feature, any proposed
interface ought to be able to deal with it. Otherwise we need to invent
yet another interface once that feature does get around to be
implemented.

> > Also, see:
> > 
> >   https://lkml.kernel.org/r/20210929152429.186930629@infradead.org
> 
> As you can see from the below pseudocode, we were thinking of queueing
> the (invalidate icache or TLB flush) in case app is in userspace,
> to perform on return to kernel space, but the approach in your patch might be
> superior (will take sometime to parse that thread...).

Let me assume you're talking about kernel TLB invalidates, otherwise it
would be terribly broken.

> > Suppose:
> > 
> > 	CPU0					CPU1
> > 
> > 	sys_prctl()
> > 	<kernel entry>
> > 	  // marks task 'important'
> > 						text_poke_sync()
> > 						  // checks CPU0, not userspace, queues IPI
> > 	<kernel exit>
> > 
> > 	$important userspace			  arch_send_call_function_ipi_mask()
> > 	<IPI>
> > 	  // finds task is 'important' and
> > 	  // can't take interrupts
> > 	  sigkill()
> > 
> > *Whoopsie*
> > 
> > 
> > Fundamentally CPU1 can't elide the IPI until CPU0 is in userspace,
> > therefore CPU0 can't wait for quescence in kernelspace, but if it goes
> > to userspace, it'll get killed on interruption. Catch-22.
> 
> We have been using a BPF tool for logging and monitoring of
> interruptions:
> https://github.com/xzpeter/rt-trace-bpf

I've no idea what you need bpf for, we have tracepoints in the entry
paths that should suffice.

> But there is no such thing as 
> 
>          // finds task is 'important' and
>          // can't take interrupts
>          sigkill()
> 
> On this patchset.

But the interface should allow for it.

> We have been discussing something like this to avoid TLBs / invalidate
> i-cache IPIs, but 
> 
>  #define CPU_REQ_FLUSH_TLB       0x1     /*      __flush_tlb_all()       */ 
>  #define CPU_REQ_INV_ICACHE      0x2     /*      sync_core()             */ 

sync_core() is *NOT* an I$ flush.

>  
>  #define IN_USER_MODE            (0x1 << 16) 
>  
>  /* when CPU is in kernel mode, should IPI rather than queuing the 
>     request on per-cpu state variable */ 
>  #define IN_KERNEL_MODE                (0) 
>  
>  Then on entry/exit would have to add a conditional branch: 
>  
>  Exit to userspace: 
>  ----------------- 
>  
>        cpu = smp_processor_id(); 
>  
>        if (isolation_enabled(cpu)) { 
>                atomic_or(IN_USER_MODE, &percpudata->user_kernel_state); 
>        } 
>  
>  Kernel entry: 
>  ------------- 
>  
>        cpu = smp_processor_id(); 
>  
>        if (isolation_enabled(cpu)) { 
>                reqs = atomic_xchg(&percpudata->user_kernel_state, IN_KERNEL_MODE); 
>                if (reqs & CPU_REQ_FLUSH_TLB) 
>                        flush_tlb_all(); 
>                if (reqs & CPU_REQ_INV_ICACHE) 
>                        invalidate_icache(); 
>        } 
>  
>  Request side: 
>  ------------- 
>  
>        int targetcpu; 
>  
>        do { 
>                struct percpudata *pcpudata = per_cpu(&percpudata, targetcpu); 
>  
>                old_state = pcpudata->user_kernel_state; 
>  
>                /* in kernel mode ? */ 
>                if (!(old_state & IN_USER_MODE)) { 
>                        smp_call_function_single(request_fn, targetcpu, 1); 
>                        break; 
>                } 
>                new_state = remote_state | CPU_REQ_FLUSH_TLB; // (or CPU_REQ_INV_ICACHE)
>        } while (atomic_cmpxchg(&pcpudata->user_kernel_state, old_state, new_state) != old_state); 
> 

That's absolutely terrible :/ you're adding extra unconditinal atomics
to the entry/exit path instead of using the ones that are already there.
That's no good.

Also, you're very much not dealing with that race either.

Also, I think you're broken vs instrumentation, all of this needs to
happen super early on entry, possibly while still on the entry stack,
otherwise the missed TLBi might be handled too late and we just used a
stale TLB entry.



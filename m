Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB75F42DAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhJNNoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231538AbhJNNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634218937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZlV5oZ4TtPFhgNbhdsHywrhrxZw6kvmmBHWdSCbMDc=;
        b=dVc5nMaeGcR/pPHKQh07dLZjlE6MAkWZti7QHZfxHso3KrnhhvId/priAv7HogNWS0qbcJ
        Dw9oKDRXKV5vvgOy6FIDiFV6laNeHYxp+TofAK20UamQLjH4ahSnMOVwGFRALPEI0wiJNM
        2OWs8jMJsi32Fkrv34pawH7wNLFpWys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-QYLIUZTfOy-_b1iMbVdsUg-1; Thu, 14 Oct 2021 09:42:13 -0400
X-MC-Unique: QYLIUZTfOy-_b1iMbVdsUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B9611006AA9;
        Thu, 14 Oct 2021 13:42:00 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C74991001B2C;
        Thu, 14 Oct 2021 13:41:59 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id D6554416D862; Thu, 14 Oct 2021 10:02:20 -0300 (-03)
Date:   Thu, 14 Oct 2021 10:02:20 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch v4 1/8] add basic task isolation prctl interface
Message-ID: <20211014130220.GA5812@fuller.cnet>
References: <20211007192346.731667417@fedora.localdomain>
 <20211007193525.755160804@fedora.localdomain>
 <YWWIHkoAdTkzU0TP@hirez.programming.kicks-ass.net>
 <20211013105637.GA88322@fuller.cnet>
 <YWb0ycw/sNV8isBH@hirez.programming.kicks-ass.net>
 <20211013160630.GA106511@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013160630.GA106511@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> What are the requirements of the signal exactly (and why it is popular) ?
> Because the interruption event can be due to:
> 
> * An IPI.
> * A system call.

IRQs (easy to trace), exceptions.

> In the "full task isolation mode" patchset (the one from Alex), a system call
> will automatically generate a SIGKILL once a system call is performed
> (after the prctl to enable task isolated mode, but
> before the prctl to disable task isolated mode).
> This can be implemented, if desired, by SECCOMP syscall blocking
> (which already exists).
> 
> For other interruptions, which happen through IPIs, one can print
> the stack trace of the program (or interrupt) that generated
> the IPI to find out the cause (which is what rt-trace-bpf.py is doing).
> 
> An alternative would be to add tracepoints so that one can
> find out which function in the kernel caused the CPU and
> task to become "a target for interruptions".

For example, adding a tracepoint to mark_vmstat_dirty() function
(allowing to see how that function was invoked on a given CPU, and
by whom) appears to be sufficient information to debug problems.

(mark_vmstat_dirty() from
[patch v4 5/8] task isolation: sync vmstats conditional on changes)

Instead of a coredump image with a SIGKILL sent at that point.

Looking at

https://github.com/abelits/libtmc

One can see the notification via SIGUSR1 being used.

To support something similar to it, one would add a new bit to 
flags field of:

+struct task_isol_activate_control {
+       __u64 flags;
+       __u64 quiesce_oneshot_mask;
+       __u64 pad[6];
+};

Remove 

+ 	       ret = -EINVAL;
+               if (act_ctrl.flags)
+                       goto out;

From the handler, shrink the padded space and use it.

> 
> > > > Also, see:
> > > > 
> > > >   https://lkml.kernel.org/r/20210929152429.186930629@infradead.org
> > > 
> > > As you can see from the below pseudocode, we were thinking of queueing
> > > the (invalidate icache or TLB flush) in case app is in userspace,
> > > to perform on return to kernel space, but the approach in your patch might be
> > > superior (will take sometime to parse that thread...).
> > 
> > Let me assume you're talking about kernel TLB invalidates, otherwise it
> > would be terribly broken.
> > 
> > > > Suppose:
> > > > 
> > > > 	CPU0					CPU1
> > > > 
> > > > 	sys_prctl()
> > > > 	<kernel entry>
> > > > 	  // marks task 'important'
> > > > 						text_poke_sync()
> > > > 						  // checks CPU0, not userspace, queues IPI
> > > > 	<kernel exit>
> > > > 
> > > > 	$important userspace			  arch_send_call_function_ipi_mask()
> > > > 	<IPI>
> > > > 	  // finds task is 'important' and
> > > > 	  // can't take interrupts
> > > > 	  sigkill()
> > > > 
> > > > *Whoopsie*
> > > > 
> > > > 
> > > > Fundamentally CPU1 can't elide the IPI until CPU0 is in userspace,
> > > > therefore CPU0 can't wait for quescence in kernelspace, but if it goes
> > > > to userspace, it'll get killed on interruption. Catch-22.

To reiterate on this point:

> > > >         CPU0                                    CPU1
> > > > 
> > > >         sys_prctl()
> > > >         <kernel entry>
> > > >           // marks task 'important'
> > > >                                                 text_poke_sync()
> > > >                                                   // checks CPU0, not userspace, queues IPI
> > > >         <kernel exit>

1) Such races can be fixed by proper uses of atomic variables.

2) If a signal to an application is desired, fail to see why this
interface (ignoring bugs related to the particular mechanism) does not
allow it.

So hopefully this addresses your comments.


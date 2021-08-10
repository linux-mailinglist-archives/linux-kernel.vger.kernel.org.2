Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9E43E836F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhHJTLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:11:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232134AbhHJTLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628622655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CeeWOr20G8vMlXMIgCb+dhwlhkMVHuKXZOFuLCaca/M=;
        b=B5e5SHCWBoMo7ygHMA8RqDYWWxpvso7zJVObfqgpOG5Y2Bjq1UgTybmb1u1DD8LNa7Fygu
        uNOLizxEniB+QbAHHobQbhNXf0B0aLvk1U1muBaOsmivIlfX35smBhLU2aJ4gyHQkXw3AB
        lbmPP0rWjwTtEZnfmqpP+Rxogtm8rjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-klAc7vKJMciObYbw2OjLmg-1; Tue, 10 Aug 2021 15:10:54 -0400
X-MC-Unique: klAc7vKJMciObYbw2OjLmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 526B88042EF;
        Tue, 10 Aug 2021 19:10:53 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7140F10016FB;
        Tue, 10 Aug 2021 19:10:44 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 4B5EE4175296; Tue, 10 Aug 2021 15:37:46 -0300 (-03)
Date:   Tue, 10 Aug 2021 15:37:46 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch 0/4] extensible prctl task isolation interface and vmstat
 sync (v2)
Message-ID: <20210810183746.GA32986@fuller.cnet>
References: <20210730201827.269106165@fuller.cnet>
 <87czqlqmlr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czqlqmlr.ffs@tglx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:40:48PM +0200, Thomas Gleixner wrote:
> Marcelo,
> 
> On Fri, Jul 30 2021 at 17:18, Marcelo Tosatti wrote:
> 
> can you pretty please:
> 
>  1) Add a version number to your patch series right where it belongs:
> 
>     [patch V2 N/M]
> 
>     Just having a (v2) at the end of the subject line of 0/M is sloppy
>     at best.
> 
>  2) Provide a lore link to the previous version
> 
> Thanks,
> 
>         tglx

Thomas,

Sure, will resend -v3 once done with the following:

1) Adding support for KVM.

2) Adding a tool called "chisol" to util-linux, similar 
to chrt/taskset, to prctl+exec (for unmodified applications).

This raises the question whether or not to add an option to preserve
the task parameters across fork (i think the answer is yes).

--

But the following points are unclear to me (in quotes are earlier 
comments you made):

1) "It's about silencing different and largely independent parts of the OS
on a particular CPU. Just defining upfront that there is only the choice
of all or nothing _is_ policy.

There is a very wide range of use case scenarios out there and just
because the ones which you care about needs X does not mean that X is
the right thing for everybody else. You still can have X and let other
people define their own set of things they want to be protected
against.

Aside of that having it selectively is a plus for debugability, testing
etc."

So for the ability to individually select what parts of the OS 
on a particular CPU are quiesced, there is:

+	defmask = defmask | ISOL_F_QUIESCE_VMSTATS;
+
+	ret = prctl(PR_ISOL_SET, ISOL_F_QUIESCE, defmask,
+                   0, 0);
+	if (ret == -1) {
+               perror("prctl PR_ISOL_SET");
+               return EXIT_FAILURE;
+	}

However there is a feeling that implementation details are being exposed 
to userspace... However that seems to be alright: what could happen is that
the feature ceases to exist (say vmstat sync), in kernel, and the bit
is kept for compability (but the kernel does nothing about it). 

That of course means whatever "vmstat sync" replacement comes up, it should
avoid IPIs as well.

Any thoughts on this?

2) "Again: I fundamentaly disagree with the proposed task isolation patches
approach as they leave no choice at all.

There is a reasonable middle ground where an application is willing to
pay the price (delay) until the reqested quiescing has taken place in
order to run undisturbed (hint: cache ...) and also is willing to take
the addtional overhead of an occacional syscall in the slow path without
tripping some OS imposed isolation safe guard.

Aside of that such a granular approach does not necessarily require the
application to be aware of it. If the admin knows the computational
pattern of the application, e.g.

 1     read_data_set() <- involving syscalls/OS obviously
 2     compute_set()   <- let me alone
 3     save_data_set() <- involving syscalls/OS obviously

       repeat the above...

then it's at his discretion to decide to inflict a particular isolation
set on the task which is obviously ineffective while doing #1 and #3 but
might provide the so desired 0.9% boost for compute_set() which
dominates the judgement.

That's what we need to think about and once we figured out how to do
that it gives Marcelo the mechanism to solve his 'run virt undisturbed
by vmstat or whatever' problem and it allows Alex to build his stuff on
it.

Summary: The problem to be solved cannot be restricted to

    self_defined_important_task(OWN_WORLD);

Policy is not a binary on/off problem. It's manifold across all levels
of the stack and only a kernel problem when it comes down to the last
line of defence.

Up to the point where the kernel puts the line of last defence, policy
is defined by the user/admin via mechanims provided by the kernel.

Emphasis on "mechanims provided by the kernel", aka. user API.

Just in case, I hope that I don't have to explain what level of scrunity
and thought this requires."

OK, so perhaps a handful of use-cases can clarify whether the proposed
interface requires changes?

The example on samples/task_isolation/ is focused on "enter task isolation
and very rarely exit".

There are two other cases i am aware of:

A) Christoph's use-case:

	1) Enter task-isolation.
	2) Latency sensitive loop begins.
	3) Some event interrupts latency sensitive section.

	4) Handling of the event requires N syscalls, which the programmer
	   would be interested in happening without quiescing at 
	   every return to system call. The current scheme would be:


       /*
        * Application can either set the value from ISOL_F_QUIESCE_DEFMASK,
        * which is configurable through
        * /sys/kernel/task_isolation/default_quiesce_activities,
        * or specific values.
        *
        * Using ISOL_F_QUIESCE_DEFMASK allows for the application to
        * take advantage of future quiescing capabilities without
        * modification (provided default_quiesce_activities is
        * configured accordingly).
        */
       defmask = defmask | ISOL_F_QUIESCE_VMSTATS;

       ret = prctl(PR_ISOL_SET, ISOL_F_QUIESCE, defmask,
                   0, 0);
       if (ret == -1) {
               perror("prctl PR_ISOL_SET");
               return EXIT_FAILURE;
       }

lat_loop:
       ret = prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE, 0, 0, 0);
       if (ret == -1) {
               perror("prctl PR_ISOL_CTRL_SET (ISOL_F_QUIESCE)");
               return EXIT_FAILURE;
       }

       latency sensitive loop

       if (event == 1) {
		/* disables quiescing of all features, while maintaining
		 * other features such as logging and avoidance of
		 * interruptions enabled.
		 */
		ret = prctl(PR_ISOL_CTRL_SET, 0, 0, 0, 0);
		syscall1
		syscall2
		...
		syscallN
		/* reenter isolated mode with quiescing */
		goto lat_loop;
	}
	...

Should it be possible to modify individual quiescing parts individually
while maintaining isolated mode? Yes, that seems to be desired.


The other use-case (from you) seems to be:

 1     read_data_set() <- involving syscalls/OS obviously
 2     compute_set()   <- let me alone
 3     save_data_set() <- involving syscalls/OS obviously

       repeat the above...

Well, the implementation of Christoph's use above seems not
to be that bad as well:

 1     read_data_set() <- involving syscalls/OS obviously
	/* disables quiescing of all (or some, if desired)
	 * features, while maintaining other features such
	 * as logging and avoidance of interruptions enabled.
	 */
	ret = prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE, 0, 0, 0);

 2     compute_set()   <- let me alone

	ret = prctl(PR_ISOL_CTRL_SET, 0, 0, 0, 0);

 3     save_data_set() <- involving syscalls/OS obviously

       repeat the above...

What kind of different behaviour, other than enabling/disabling
quiescing, would be desired in this use-case?


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338583F9B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhH0Ot7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233308AbhH0Oty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630075742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9XfvT2HHPhbVW83kTqVHZHH9h+AjHmygzwCOdbyzRj8=;
        b=BkPTT7/jVthmKsSgVHZK06doxONGHxzJqgayoA2b8R2GENjckJP//UU5e8ogIySdlm8C+s
        ACTNtX85AsyC4mXwDcuukZV1w6luaFK+DFpn8Ml+mkG+hU4XC09ONFD3+TrudRS5td6bQu
        PtT+cKUm4fgv7igk33v330EJQWNAGwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-vsyxJpXrMaSKvSGEpZasrw-1; Fri, 27 Aug 2021 10:49:01 -0400
X-MC-Unique: vsyxJpXrMaSKvSGEpZasrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D83D1107ACF5;
        Fri, 27 Aug 2021 14:48:59 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BA1069280;
        Fri, 27 Aug 2021 14:48:51 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id AF32F4172ED4; Fri, 27 Aug 2021 11:44:16 -0300 (-03)
Date:   Fri, 27 Aug 2021 11:44:16 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch V3 2/8] add prctl task isolation prctl docs and samples
Message-ID: <20210827144416.GA186908@fuller.cnet>
References: <20210824152423.300346181@fuller.cnet>
 <20210824152646.706875395@fuller.cnet>
 <20210826095958.GA908505@lothringen>
 <20210826121131.GA152063@fuller.cnet>
 <20210827130820.GA918573@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827130820.GA918573@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 03:08:20PM +0200, Frederic Weisbecker wrote:
> On Thu, Aug 26, 2021 at 09:11:31AM -0300, Marcelo Tosatti wrote:
> > Hi Frederic,
> > 
> > On Thu, Aug 26, 2021 at 11:59:58AM +0200, Frederic Weisbecker wrote:
> > > > +Note: the prctl interface is independent of nohz_full=.
> > > > +
> > > > +The prctl options are:
> > > > +
> > > > +
> > > > +        - PR_ISOL_FEAT: Retrieve supported features.
> > > > +        - PR_ISOL_GET: Retrieve task isolation parameters.
> > > > +        - PR_ISOL_SET: Set task isolation parameters.
> > > > +        - PR_ISOL_CTRL_GET: Retrieve task isolation state.
> > > > +        - PR_ISOL_CTRL_SET: Set task isolation state.
> > > > +        - PR_ISOL_GET_INT: Retrieve internal parameters.
> > > > +        - PR_ISOL_SET_INT: Retrieve internal parameters.
> > > 
> > > There should be some short summary here to explain the difference
> > > between parameter, state, and internal parameter. I personally have
> > > no clue so far.
> > 
> > Yes, those have been written without clear definitions and can be
> > improved (it makes sense to me, so please indicate what is not 
> > clear to you). So:
> > 
> > * "Feature": a generic name for a task isolation feature.
> > Examples of features could be logging, new operating modes (syscalls
> > disallowed), userspace notifications, etc. One feature is quiescing.
> > 
> > * "Parameter": a specific choice from a given set of possible choices
> > that dictate how the particular feature in question should act.
> > 
> > * "Internal parameter": A parameter (as in above) but not related to
> > task isolation features themselves, but to "internal characteristics"
> > (well, there is only one example of internal parameter so far
> > and that is inheritance across clone/fork).
> > 
> > Maybe "internal parameter" is a bad name and something different should
> > be used instead ?
> > 
> > Should i add the description aboves to the document file?
> 
> Ok so to make things clearer, may I suggest:
> 
>    s/PR_ISOL_FEAT/PR_ISOL_GET_FEAT
> 
> to make it more obvious that we are not going to write or configure something.
> 
> Also:
> 
>   s/PR_ISOL_SET/PR_ISOL_CFG_SET  or  s/PR_ISOL_SET/PR_ISOL_PARAM_SET
>   s/PR_ISOL_GET/PR_ISOL_CFG_GET  or  s/PR_ISOL_GET/PR_ISOL_PARAM_GET
> 
> because SET or GET alone are too general. I first thought they were the
> activation interface whereas they are only the configuration stage.

Sounds good.

> And then PR_ISOL_CTRL_GET/SET look good. Although perhaps
> PR_ISOL_ACTIVATE_SET/GET would probably be clearer. Or even this is where
> the trimmed name PR_ISOL_SET/GET would make sense.

PR_ISOL_ACTIVATE_SET/GET indeed is quite clear. Will change.

> > > > +---------------------
> > > > +Interface description
> > > > +---------------------
> > > > +
> > > > +**PR_ISOL_FEAT**:
> > > > +
> > > > +        Returns the supported features and feature
> > > > +        capabilities, as a bitmask::
> > > > +
> > > > +                prctl(PR_ISOL_FEAT, feat, arg3, arg4, arg5);
> > > > +
> > > > +        The 'feat' argument specifies whether to return
> > > > +        supported features (if zero), or feature capabilities
> > > > +        (if not zero). Possible non-zero values for 'feat' are:
> > > > +
> > > > +        - ``ISOL_F_QUIESCE``:
> > > > +
> > > > +                Returns a bitmask containing which kernel
> > > > +                activities are supported for quiescing.
> > > > +
> > > > +        Features and its capabilities are defined at
> > > > include/uapi/linux/task_isolation.h.
> > > 
> > > Preferably have feat a parameter name. We never know if we want
> > > to extend it in the future.
> > 
> > It is a parameter name:
> > 
> > prctl(PR_ISOL_FEAT, feat-A, arg3, arg4, arg5);
> > 
> > prctl(PR_ISOL_FEAT, feat-B, arg3, arg4, arg5);
> > 
> > And yes, the idea is that new features can be added.
> > 
> > So unless i misunderstood you, there are no changes necessary here.
> 
> Ok, indeed that was my misunderstanding.
> 
> > > > +**PR_ISOL_GET**:
> > > > +
> > > > +        Retrieve task isolation feature configuration.
> > > > +        The general format is::
> > > > +
> > > > +                prctl(PR_ISOL_GET, feat, arg3, arg4, arg5);
> > > > +
> > > > +        The 'feat' argument specifies whether to return
> > > > +        configured features (if zero), or individual feature
> > > > +        configuration (if not zero).
> > > 
> > > You might need to elaborate a bit on the "feat" behaviour difference.
> > 
> > Not sure what you mean? There is only one "feat" yet, which is
> > ISOL_F_QUIESCE:
> 
> Sorry my misunderstanding again. So if I understand correctly prctl(PR_ISOL_GET,
> 0, ...) returns a mask of all features that have been configured through
> PR_ISOL_SET(), right?

Yes.

> > > > +**PR_ISOL_SET**:
> > > > +
> > > > +        Configures task isolation features. The general format is::
> > > > +
> > > > +                prctl(PR_ISOL_SET, feat, arg3, arg4, arg5);
> > > > +
> > > > +        The 'feat' argument specifies which feature to configure.
> > > > +        Possible values for feat are:
> > > > +
> > > > +        - ``ISOL_F_QUIESCE``:
> > > > +
> > > > +                The 'arg3' argument is a bitmask specifying which
> > > > +                kernel activities to quiesce. Possible bit sets are:
> > > > +
> > > > +                - ``ISOL_F_QUIESCE_VMSTATS``
> > > > +
> > > > +                  VM statistics are maintained in per-CPU counters to
> > > > +                  improve performance. When a CPU modifies a VM statistic,
> > > > +                  this modification is kept in the per-CPU counter.
> > > > +                  Certain activities require a global count, which
> > > > +                  involves requesting each CPU to flush its local counters
> > > > +                  to the global VM counters.
> > > > +
> > > > +                  This flush is implemented via a workqueue item, which
> > > > +                  might schedule a workqueue on isolated CPUs.
> > > > +
> > > > +                  To avoid this interruption, task isolation can be
> > > > +                  configured to, upon return from system calls, synchronize
> > > > +                  the per-CPU counters to global counters, thus avoiding
> > > > +                  the interruption.
> > > > +
> > > > +                  To ensure the application returns to userspace
> > > > +                  with no modified per-CPU counters, its necessary to
> > > > +                  use mlockall() in addition to this isolcpus flag.
> > > 
> > > So prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ISOL_F_QUIESCE_VMSTATS, ...) will quiesce
> > > on all subsequent return to userspace, right?
> > 
> > Yes. Hum, i think i dropped that clarification (by mistake). Will re-add
> > it.
> 
> So how are we going to implement oneshot quiescing? As in quiescing only upon
> the return of a given prctl().
> 
> Maybe using a feature something like ISOL_F_QUIESCE_ONCE?
> 
> But then suppose I do this:
> 
> prctl(PR_ISOL_SET, ISOL_F_QUIESCE_ONCE, ISOL_F_QUIESCE_VMSTATS, ...)
> prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE_ONCE, ...) //will quiesce on this return only
> prctl(PR_ISOL_CTRL_GET,  ...)
> 
> What should PR_ISOL_CTRL_GET return above? Probably nothing.

Yeah, nothing.

So the "quiesce once" feature, as i understand, was suggested by
Christoph for the following type of application:

lat_loop:

	do {
		events = pending_events();
		if (events & DATAPATH_EVENT)
			process_data()
	} while (!(events & UNFREQUENT_ERROR_EVENT))

	syscall1()
	syscall2()
	...
	syscallN()
	goto lat_loop;

With the V3 patchset, one would have to:

	prctl(PR_ISOL_SET, ISOL_F_OTHER, ...);
	prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ISOL_F_QUIESCE_VMSTATS, ...);
	...
	prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE|ISOL_F_OTHER);
lat_loop:
	do {
		events = pending_events();
		if (events & DATAPATH_EVENT)
			process_data()
	} while (!(events & UNFREQUENT_ERROR_EVENT))

	/* disables quiescing while executing system calls */
	prctl(PR_ISOL_CTRL_SET, ISOL_F_OTHER);
	syscall1()
	syscall2()
	...
	syscallN()

	/* no more system calls, enables quiescing */
	prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE|ISOL_F_OTHER);
	goto lat_loop;

But for an interface with less system calls (true "quiesce once") one could do:

	prctl(PR_ISOL_SET, ISOL_F_OTHER, ...);
	/* rather than do it at _CTRL_SET as you suggest, enable it at
	 * configuration time.
	 */
	prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ISOL_F_QUIESCE_VMSTATS|ISOL_F_QUIESCE_ONCE, ...);
	...

lat_loop:
	prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE|ISOL_F_OTHER);
	do {
		events = pending_events();
		if (events & DATAPATH_EVENT)
			process_data()
	} while (!(events & UNFREQUENT_ERROR_EVENT))

	/* disables quiescing while executing system calls */
	syscall1()
	syscall2()
	...
	syscallN()

	goto lat_loop;

But see how it starts to get weird: both versions (new feature, 
ISOL_F_QUIESCE_ONCE, or new "quiesce feature', ISOL_F_QUIESCE_ONCE)
are using space reserved to

"a list of different features" 
or
"a list of different quiesce features".

To add something which is not either a new task isolation 
feature or quiesce feature, but a separate control
(which could apply to all of features, or which one might want
to apply only to certain features, and in that case a bitmap
might be specified).

So i think adding a new parameter such as:

prctl(PR_ISOL_SET, ISOL_F_QUIESCE, CMD, arg, ...);

is a good idea. So one can have (with two commands, SET_QUIESCE 
and SET_ONESHOT).

prctl(PR_ISOL_SET, ISOL_F_QUIESCE, SET_QUIESCE, ISOL_F_QUIESCE_VMSTAT);
prctl(PR_ISOL_SET, ISOL_F_QUIESCE, SET_ONESHOT, ISOL_F_QUIESCE_VMSTAT);

Then its possible to add random commands with random parameters
(rather than be limited by a single bitmask to control quiescing).

Does that make sense?

> > > > +
> > > > +**PR_ISOL_CTRL_GET**:
> > > > +
> > > > +        Retrieve task isolation control.
> > > > +
> > > > +                prctl(PR_ISOL_CTRL_GET, 0, 0, 0, 0);
> > > > +
> > > > +        Returns which isolation features are active.
> > > > +
> > > > +**PR_ISOL_CTRL_SET**:
> > > > +
> > > > +        Activates/deactivates task isolation control.
> > > > +
> > > > +                prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
> > > > +
> > > > +        The 'mask' argument specifies which features
> > > > +        to activate (bit set) or deactivate (bit clear).
> > > > +
> > > > +        For ISOL_F_QUIESCE, quiescing of background activities
> > > > +        happens on return to userspace from the
> > > > +        prctl(PR_ISOL_CTRL_SET) call, and on return from
> > > > +        subsequent system calls.
> > > 
> > > Now I'm lost again on the difference with PR_ISOL_SET
> > 
> > PR_ISOL_SET configures the features parameters.
> > 
> > PR_ISOL_CTRL_SET _activates_ task isolation.
> > 
> > You earlier wrote:
> > 
> > "I would rather decouple the above with, for modes:
> > 
> >   PR_TASK_ISOLATION_SET
> >   PR_TASK_ISOLATION_GET
> > 
> > And for oneshot requests:
> > 
> >   PR_TASK_ISOLATION_REQUEST"
> > 
> > Now we have PR_ISOL_SET/PR_ISOL_GET (to configure the parameters of 
> > task isolation features), and PR_ISOL_CTRL_SET to activate that
> > isolation (and we pass a bitmask to PR_ISOL_CTRL_SET indicating what
> > features should be active). How the particular features behave 
> > is determined at PR_ISOL_SET time.
> 
> I guess that makes sense. This way we can quiesce everything in one go
> instead of issuing a prctl() for each features, which adds further noise.
> Sounds proper.
> 
> > 
> > This allows the administrator to, via chisol, configure task isolation:
> > 
> > +
> > +       if (argc - optind < 1) {
> > +	       warnx(_("bad usage"));
> > +               errtryhelp(EXIT_FAILURE);
> > + 	}
> > +
> > +       if (quiesce_act_mask) {
> > + 	        ret = prctl(PR_ISOL_SET, ISOL_F_QUIESCE, quiesce_act_mask, 0, 0);
> > +	       if (ret == -1) {
> > +	                perror("prctl PR_ISOL_SET");
> > +                       exit(EXIT_FAILURE);
> > +	       }
> > +       }
> > 
> > And the application, which has to be modified only once with:
> > 
> > +#ifdef PR_ISOL_GET
> > +       ret = prctl(PR_ISOL_GET, 0, 0, 0, 0);
> > +	if (ret != -1) {
> > +               unsigned long mask = ret;
> > +
> > +               TEST0(prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0));
> > +	}
> > +#endif
> > +
> >         frc(&ts2);
> >         do {
> >                 workload_fn(t->dst_buf, t->src_buf, g.workload_mem_size);
> > 
> > Makes sense?
> 
> Yes! Btw you might want to fetch the mask of PR_ISOL_GET into the
> second parameter instead of using the return value which is only
> 32 bits or prctl() and the highest significant bit is even reserved
> for the error.

Would be good to do this for all cases, so you can extend the
struct (or pad it).
> 
> > > > +**PR_ISOL_GET_INT**:
> > > > +
> > > > +        Retrieves task isolation internal parameters.
> > > > +
> > > > +        The general format is::
> > > > +
> > > > +                prctl(PR_ISOL_GET_INT, cmd, arg3, arg4, arg5);
> > > > +
> > > > +        The 'cmd' argument specifies which parameter to configure.
> > > > +        Possible values for cmd are:
> > > > +
> > > > +        - ``INHERIT_CFG``:
> > > > +
> > > > +                Retrieve inheritance configuration.
> > > > +
> > > > +                The 'arg3' argument is a pointer to a struct
> > > > +                inherit_control::
> > > > +
> > > > +                        struct task_isol_inherit_control {
> > > > +                                __u8    inherit_mask;
> > > > +                                __u8    pad[7];
> > > > +                        };
> > > > +
> > > > +                See PR_ISOL_SET_INT description below for meaning
> > > > +                of structure fields.
> > > > +
> > > > +**PR_ISOL_SET_INT**:
> > > > +
> > > > +        Sets task isolation internal parameters.
> > > > +
> > > > +        The general format is::
> > > > +
> > > > +                prctl(PR_ISOL_SET_INT, cmd, arg3, arg4, arg5);
> > > > +
> > > > +        The 'cmd' argument specifies which parameter to configure.
> > > > +        Possible values for cmd are:
> > > > +
> > > > +        - ``INHERIT_CFG``:
> > > > +
> > > > +                Set inheritance configuration when a new task
> > > > +                is created via fork and clone.
> > > > +
> > > > +                The 'arg3' argument is a pointer to a struct
> > > > +                inherit_control::
> > > > +
> > > > +                        struct task_isol_inherit_control {
> > > > +                                __u8    inherit_mask;
> > > > +                                __u8    pad[7];
> > > > +                        };
> > > > +
> > > > +                inherit_mask is a bitmask that specifies which part
> > > > +                of task isolation to be inherited:
> > > > +
> > > > +                - Bit ISOL_INHERIT_CONF: Inherit task isolation configuration.
> > > > +                  This is the stated written via prctl(PR_ISOL_SET, ...).
> > > > +
> > > > +                - Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
> > > > +                  (requires ISOL_INHERIT_CONF to be set). The new task
> > > > +                  should behave, right after fork/clone, in the same manner
> > > > +                  as the parent task _after_ it executed:
> > > > +
> > > > +                        prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
> > > > +
> > > > +                  with a valid mask.
> > > 
> > > I'm wondering if those things shouldn't be set on arg4 for PR_ISOL_SET instead?
> > > Arguably having a whole prctl for that makes it easier to extend. But then
> > > PR_ISOL_SET_INT must always be called before PR_ISOL_SET, otherwise we create
> > > noise, right?
> > 
> > It has to be called before PR_ISOL_CTRL_SET, yes.
> > 
> > Decided on a separate prctl because the inheritance control
> > is not a feature itself: it acts on all features (or how task isolation
> > features are inherited across fork/clone).
> > 
> > So yes, first idea was to "lets add this to PR_ISOL_SET", but then it
> > became weird to have something that controls the features as a feature
> > itself... It would be ISOL_F_INHERIT_CONTROL. Can change to that, if 
> > you prefer.
> 
> Funny but that would work. Either way, let's keep things that way for now.
> Just the naming is unfortunate.
> 
> Well that could be a clone flag after all... 

Yes, it could as well. But there are no more bits for older clone
interfaces, and clone3 seems to be problematic (moreover, this
interface would need backporting to older kernels).

> But what about exec()? Should we
> make its inheritance tunable? Well we can still extend the interface later if
> necessary for that.

Hum, not sure... Yes, can extend it later.

Thanks!


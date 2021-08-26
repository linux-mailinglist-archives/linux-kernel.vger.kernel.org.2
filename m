Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977DF3F879D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbhHZMhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234812AbhHZMh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629981398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRPnE/86lZAQsP4JI0ns+doKVhUH0dZxIPRG0JiQmm0=;
        b=UuR42kD4gI+fty/VKyfcwe40/ckK/lBLxzrF6MA1eWmZuQkbi6kktMxZX4uMs794N/A/wm
        JWO4Fn1yEv/9BiUyApBLoV9Sl2Q7XiROxcR1kQedXQiENRcmfRlf7ODgBuqY+3EayxnymE
        wGA5ot+6OFYzahbqqdTP5wvHgNwU5VM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-5AqA1qJ-Pd-TaAlW5Mpi1g-1; Thu, 26 Aug 2021 08:36:35 -0400
X-MC-Unique: 5AqA1qJ-Pd-TaAlW5Mpi1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 187651082926;
        Thu, 26 Aug 2021 12:36:34 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3072268D95;
        Thu, 26 Aug 2021 12:36:33 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id E6160416D8BC; Thu, 26 Aug 2021 09:11:31 -0300 (-03)
Date:   Thu, 26 Aug 2021 09:11:31 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch V3 2/8] add prctl task isolation prctl docs and samples
Message-ID: <20210826121131.GA152063@fuller.cnet>
References: <20210824152423.300346181@fuller.cnet>
 <20210824152646.706875395@fuller.cnet>
 <20210826095958.GA908505@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826095958.GA908505@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On Thu, Aug 26, 2021 at 11:59:58AM +0200, Frederic Weisbecker wrote:
> On Tue, Aug 24, 2021 at 12:24:25PM -0300, Marcelo Tosatti wrote:
> > Add documentation and userspace sample code for prctl
> > task isolation interface.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> >  Documentation/userspace-api/task_isolation.rst |  211 +++++++++++++++++++++++++
> >  samples/Kconfig                                |    7 
> >  samples/Makefile                               |    1 
> >  samples/task_isolation/Makefile                |    9 +
> >  samples/task_isolation/task_isol.c             |   83 +++++++++
> >  samples/task_isolation/task_isol.h             |    9 +
> >  samples/task_isolation/task_isol_userloop.c    |   56 ++++++
> >  7 files changed, 376 insertions(+)
> > 
> > Index: linux-2.6/Documentation/userspace-api/task_isolation.rst
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6/Documentation/userspace-api/task_isolation.rst
> > @@ -0,0 +1,281 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===============================
> > +Task isolation prctl interface
> > +===============================
> > +
> > +Certain types of applications benefit from running uninterrupted by
> > +background OS activities. Realtime systems and high-bandwidth networking
> > +applications with user-space drivers can fall into the category.
> > +
> > +To create an OS noise free environment for the application, this
> > +interface allows userspace to inform the kernel the start and
> > +end of the latency sensitive application section (with configurable
> > +system behaviour for that section).
> > +
> > +Note: the prctl interface is independent of nohz_full=.
> > +
> > +The prctl options are:
> > +
> > +
> > +        - PR_ISOL_FEAT: Retrieve supported features.
> > +        - PR_ISOL_GET: Retrieve task isolation parameters.
> > +        - PR_ISOL_SET: Set task isolation parameters.
> > +        - PR_ISOL_CTRL_GET: Retrieve task isolation state.
> > +        - PR_ISOL_CTRL_SET: Set task isolation state.
> > +        - PR_ISOL_GET_INT: Retrieve internal parameters.
> > +        - PR_ISOL_SET_INT: Retrieve internal parameters.
> 
> There should be some short summary here to explain the difference
> between parameter, state, and internal parameter. I personally have
> no clue so far.

Yes, those have been written without clear definitions and can be
improved (it makes sense to me, so please indicate what is not 
clear to you). So:

* "Feature": a generic name for a task isolation feature.
Examples of features could be logging, new operating modes (syscalls
disallowed), userspace notifications, etc. One feature is quiescing.

* "Parameter": a specific choice from a given set of possible choices
that dictate how the particular feature in question should act.

* "Internal parameter": A parameter (as in above) but not related to
task isolation features themselves, but to "internal characteristics"
(well, there is only one example of internal parameter so far
and that is inheritance across clone/fork).

Maybe "internal parameter" is a bad name and something different should
be used instead ?

Should i add the description aboves to the document file?

> > +Inheritance of the isolation parameters and state, across
> > +fork(2) and clone(2), can be changed via
> > +PR_ISOL_GET_INT/PR_ISOL_SET_INT.
> > +
> > +At a high-level, task isolation is divided in two steps:
> > +
> > +1. Configuration.
> > +2. Activation.
> > +
> > +Section "Userspace support" describes how to use
> > +task isolation.
> > +
> > +In terms of the interface, the sequence of steps to activate
> > +task isolation are:
> > +
> > +1. Retrieve supported task isolation features (PR_ISOL_FEAT).
> > +2. Configure task isolation features (PR_ISOL_SET/PR_ISOL_GET).
> > +3. Activate or deactivate task isolation features
> > +   (PR_ISOL_CTRL_GET/PR_ISOL_CTRL_SET).
> > +4. Optionally configure inheritance (PR_ISOL_GET_INT/PR_ISOL_SET_INT).
> > +
> > +This interface is based on ideas and code from the
> > +task isolation patchset from Alex Belits:
> > +https://lwn.net/Articles/816298/
> > +
> > +--------------------
> > +Feature description
> > +--------------------
> > +
> > +        - ``ISOL_F_QUIESCE``
> > +
> > +        This feature allows quiescing select kernel activities on
> > +        return from system calls.
> > +
> > +---------------------
> > +Interface description
> > +---------------------
> > +
> > +**PR_ISOL_FEAT**:
> > +
> > +        Returns the supported features and feature
> > +        capabilities, as a bitmask::
> > +
> > +                prctl(PR_ISOL_FEAT, feat, arg3, arg4, arg5);
> > +
> > +        The 'feat' argument specifies whether to return
> > +        supported features (if zero), or feature capabilities
> > +        (if not zero). Possible non-zero values for 'feat' are:
> > +
> > +        - ``ISOL_F_QUIESCE``:
> > +
> > +                Returns a bitmask containing which kernel
> > +                activities are supported for quiescing.
> > +
> > +        Features and its capabilities are defined at
> > include/uapi/linux/task_isolation.h.
> 
> Preferably have feat a parameter name. We never know if we want
> to extend it in the future.

It is a parameter name:

prctl(PR_ISOL_FEAT, feat-A, arg3, arg4, arg5);

prctl(PR_ISOL_FEAT, feat-B, arg3, arg4, arg5);

And yes, the idea is that new features can be added.

So unless i misunderstood you, there are no changes necessary here.

> > +
> > +**PR_ISOL_GET**:
> > +
> > +        Retrieve task isolation feature configuration.
> > +        The general format is::
> > +
> > +                prctl(PR_ISOL_GET, feat, arg3, arg4, arg5);
> > +
> > +        The 'feat' argument specifies whether to return
> > +        configured features (if zero), or individual feature
> > +        configuration (if not zero).
> 
> You might need to elaborate a bit on the "feat" behaviour difference.

Not sure what you mean? There is only one "feat" yet, which is
ISOL_F_QUIESCE:

> > +        values for 'feat' are:
> > +
> > +        - ``ISOL_F_QUIESCE``:
> > +
> > +                Returns a bitmask containing which kernel
> > +                activities are enabled for quiescing.

If one were to add a new feature, he would add:

	     - ``ISOL_F_FEATURE2``:

		     Returns a ... 

Unclear what improvement are you suggesting?

> > +**PR_ISOL_SET**:
> > +
> > +        Configures task isolation features. The general format is::
> > +
> > +                prctl(PR_ISOL_SET, feat, arg3, arg4, arg5);
> > +
> > +        The 'feat' argument specifies which feature to configure.
> > +        Possible values for feat are:
> > +
> > +        - ``ISOL_F_QUIESCE``:
> > +
> > +                The 'arg3' argument is a bitmask specifying which
> > +                kernel activities to quiesce. Possible bit sets are:
> > +
> > +                - ``ISOL_F_QUIESCE_VMSTATS``
> > +
> > +                  VM statistics are maintained in per-CPU counters to
> > +                  improve performance. When a CPU modifies a VM statistic,
> > +                  this modification is kept in the per-CPU counter.
> > +                  Certain activities require a global count, which
> > +                  involves requesting each CPU to flush its local counters
> > +                  to the global VM counters.
> > +
> > +                  This flush is implemented via a workqueue item, which
> > +                  might schedule a workqueue on isolated CPUs.
> > +
> > +                  To avoid this interruption, task isolation can be
> > +                  configured to, upon return from system calls, synchronize
> > +                  the per-CPU counters to global counters, thus avoiding
> > +                  the interruption.
> > +
> > +                  To ensure the application returns to userspace
> > +                  with no modified per-CPU counters, its necessary to
> > +                  use mlockall() in addition to this isolcpus flag.
> 
> So prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ISOL_F_QUIESCE_VMSTATS, ...) will quiesce
> on all subsequent return to userspace, right?

Yes. Hum, i think i dropped that clarification (by mistake). Will re-add
it.

> > +
> > +**PR_ISOL_CTRL_GET**:
> > +
> > +        Retrieve task isolation control.
> > +
> > +                prctl(PR_ISOL_CTRL_GET, 0, 0, 0, 0);
> > +
> > +        Returns which isolation features are active.
> > +
> > +**PR_ISOL_CTRL_SET**:
> > +
> > +        Activates/deactivates task isolation control.
> > +
> > +                prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
> > +
> > +        The 'mask' argument specifies which features
> > +        to activate (bit set) or deactivate (bit clear).
> > +
> > +        For ISOL_F_QUIESCE, quiescing of background activities
> > +        happens on return to userspace from the
> > +        prctl(PR_ISOL_CTRL_SET) call, and on return from
> > +        subsequent system calls.
> 
> Now I'm lost again on the difference with PR_ISOL_SET

PR_ISOL_SET configures the features parameters.

PR_ISOL_CTRL_SET _activates_ task isolation.

You earlier wrote:

"I would rather decouple the above with, for modes:

  PR_TASK_ISOLATION_SET
  PR_TASK_ISOLATION_GET

And for oneshot requests:

  PR_TASK_ISOLATION_REQUEST"

Now we have PR_ISOL_SET/PR_ISOL_GET (to configure the parameters of 
task isolation features), and PR_ISOL_CTRL_SET to activate that
isolation (and we pass a bitmask to PR_ISOL_CTRL_SET indicating what
features should be active). How the particular features behave 
is determined at PR_ISOL_SET time.

This allows the administrator to, via chisol, configure task isolation:

+
+       if (argc - optind < 1) {
+	       warnx(_("bad usage"));
+               errtryhelp(EXIT_FAILURE);
+ 	}
+
+       if (quiesce_act_mask) {
+ 	        ret = prctl(PR_ISOL_SET, ISOL_F_QUIESCE, quiesce_act_mask, 0, 0);
+	       if (ret == -1) {
+	                perror("prctl PR_ISOL_SET");
+                       exit(EXIT_FAILURE);
+	       }
+       }

And the application, which has to be modified only once with:

+#ifdef PR_ISOL_GET
+       ret = prctl(PR_ISOL_GET, 0, 0, 0, 0);
+	if (ret != -1) {
+               unsigned long mask = ret;
+
+               TEST0(prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0));
+	}
+#endif
+
        frc(&ts2);
        do {
                workload_fn(t->dst_buf, t->src_buf, g.workload_mem_size);

Makes sense?

(BTW, please let me know how the wording would be so it is 
easier to understand... if it is not simple to you, it won't
be simple to others as well).

> > +
> > +        Quiescing can be adjusted (while active) by
> > +        prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ...).
> > +
> > +**PR_ISOL_GET_INT**:
> > +
> > +        Retrieves task isolation internal parameters.
> > +
> > +        The general format is::
> > +
> > +                prctl(PR_ISOL_GET_INT, cmd, arg3, arg4, arg5);
> > +
> > +        The 'cmd' argument specifies which parameter to configure.
> > +        Possible values for cmd are:
> > +
> > +        - ``INHERIT_CFG``:
> > +
> > +                Retrieve inheritance configuration.
> > +
> > +                The 'arg3' argument is a pointer to a struct
> > +                inherit_control::
> > +
> > +                        struct task_isol_inherit_control {
> > +                                __u8    inherit_mask;
> > +                                __u8    pad[7];
> > +                        };
> > +
> > +                See PR_ISOL_SET_INT description below for meaning
> > +                of structure fields.
> > +
> > +**PR_ISOL_SET_INT**:
> > +
> > +        Sets task isolation internal parameters.
> > +
> > +        The general format is::
> > +
> > +                prctl(PR_ISOL_SET_INT, cmd, arg3, arg4, arg5);
> > +
> > +        The 'cmd' argument specifies which parameter to configure.
> > +        Possible values for cmd are:
> > +
> > +        - ``INHERIT_CFG``:
> > +
> > +                Set inheritance configuration when a new task
> > +                is created via fork and clone.
> > +
> > +                The 'arg3' argument is a pointer to a struct
> > +                inherit_control::
> > +
> > +                        struct task_isol_inherit_control {
> > +                                __u8    inherit_mask;
> > +                                __u8    pad[7];
> > +                        };
> > +
> > +                inherit_mask is a bitmask that specifies which part
> > +                of task isolation to be inherited:
> > +
> > +                - Bit ISOL_INHERIT_CONF: Inherit task isolation configuration.
> > +                  This is the stated written via prctl(PR_ISOL_SET, ...).
> > +
> > +                - Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
> > +                  (requires ISOL_INHERIT_CONF to be set). The new task
> > +                  should behave, right after fork/clone, in the same manner
> > +                  as the parent task _after_ it executed:
> > +
> > +                        prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
> > +
> > +                  with a valid mask.
> 
> I'm wondering if those things shouldn't be set on arg4 for PR_ISOL_SET instead?
> Arguably having a whole prctl for that makes it easier to extend. But then
> PR_ISOL_SET_INT must always be called before PR_ISOL_SET, otherwise we create
> noise, right?

It has to be called before PR_ISOL_CTRL_SET, yes.

Decided on a separate prctl because the inheritance control
is not a feature itself: it acts on all features (or how task isolation
features are inherited across fork/clone).

So yes, first idea was to "lets add this to PR_ISOL_SET", but then it
became weird to have something that controls the features as a feature
itself... It would be ISOL_F_INHERIT_CONTROL. Can change to that, if 
you prefer.


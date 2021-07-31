Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8A3DC21E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhGaAuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231337AbhGaAuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627692606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bVgL9mv99Ej9Hc+BD5Lm8gN4EaGO8Q5Hc4cQFke/yuQ=;
        b=A7xndW52Jt2j9JPLp/jBeQeGvZqOyNr/oExalzftBEBz3j8c4+wVOZP1YKb/4ZHwzDN5XH
        SymAelplF0kWOKKsTvtXYYJYIURyT0J59K/CkkjWfr38urgux5lgkSo7+wuF58jNB7BexR
        PwERmY2DwI/PIDXxLx3B6S6Wzw7OlCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-mMzhi99OPSyXcC_oafjqAA-1; Fri, 30 Jul 2021 20:50:05 -0400
X-MC-Unique: mMzhi99OPSyXcC_oafjqAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1220687122E;
        Sat, 31 Jul 2021 00:50:04 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B54010016F2;
        Sat, 31 Jul 2021 00:49:56 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id E5CBA41752B5; Fri, 30 Jul 2021 21:49:51 -0300 (-03)
Date:   Fri, 30 Jul 2021 21:49:51 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nitesh Lal <nilal@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210731004951.GA77573@fuller.cnet>
References: <20210730201827.269106165@fuller.cnet>
 <20210730202010.240095394@fuller.cnet>
 <CAFki+Lnf0cs62Se0aPubzYxP9wh7xjMXn7RXEPvrmtBdYBrsow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFki+Lnf0cs62Se0aPubzYxP9wh7xjMXn7RXEPvrmtBdYBrsow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 07:36:31PM -0400, Nitesh Lal wrote:
> On Fri, Jul 30, 2021 at 4:21 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> 
> > Add basic prctl task isolation interface, which allows
> > informing the kernel that application is executing
> > latency sensitive code (where interruptions are undesired).
> >
> > Interface is described by task_isolation.rst (added by this patch).
> >
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> >
> > Index: linux-2.6/Documentation/userspace-api/task_isolation.rst
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6/Documentation/userspace-api/task_isolation.rst
> > @@ -0,0 +1,187 @@
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
> > +
> > +To create a OS noise free environment for the application, this
> > +interface allows userspace to inform the kernel the start and
> > +end of the latency sensitive application section (with configurable
> > +system behaviour for that section).
> > +
> > +The prctl options are:
> > +
> > +
> > +        - PR_ISOL_FEAT: Retrieve supported features.
> > +        - PR_ISOL_GET: Retrieve task isolation parameters.
> > +        - PR_ISOL_SET: Set task isolation parameters.
> > +        - PR_ISOL_CTRL_GET: Retrieve task isolation state.
> > +        - PR_ISOL_CTRL_SET: Set task isolation state (enable/disable task
> > isolation).
> > +
> >
> 
> Didn't we decide to replace FEAT/FEATURES with MODE?

Searching for the definition of mode:

mode: one of a series of ways that a machine can be made to work
in manual/automatic mode.

mode: a particular way of doing something.

mode: a way of operating, living, or behaving.

So "mode" seems to fit the case where one case can be chosen 
between different choices (exclusively).

Now for this case it seems a composition of things is what is
happening, because quiescing might be functional with both 
"syscalls allowed" and "syscalls not allowed" modes 
(in that case, "mode" makes more sense).

> > +The isolation parameters and state are not inherited by
> > +children created by fork(2) and clone(2). The setting is
> > +preserved across execve(2).
> > +
> > +The sequence of steps to enable task isolation are:
> > +
> > +1. Retrieve supported task isolation features (PR_ISOL_FEAT).
> > +
> > +2. Configure task isolation features (PR_ISOL_SET/PR_ISOL_GET).
> > +
> > +3. Activate or deactivate task isolation features
> > +   (PR_ISOL_CTRL_GET/PR_ISOL_CTRL_SET).
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
> > +        capabilities, as a bitmask. Features and its capabilities
> > +        are defined at include/uapi/linux/task_isolation.h::
> > +
> > +                prctl(PR_ISOL_FEAT, feat, arg3, arg4, arg5);
> > +
> > +        The 'feat' argument specifies whether to return
> > +        supported features (if zero), or feature capabilities
> > +        (if not zero). Possible non-zero values for 'feat' are:
> >
> 
> By feature capabilities you mean the kernel activities (vmstat, tlb_flush)?

Not necessarily, but in the case of ISOL_F_QUIESCE, yes, the different
kernel activities that might interrupt the task.

Feature capabilities is a generic term. For example, one might add

ISOL_F_NOTIFY with ISOL_F_NOTIFY_SIGNAL capabilities.
or
ISOL_F_NOTIFY with ISOL_F_NOTIFY_EVENTFD capabilities.
or
ISOL_F_future_feature with ISOL_F_future_feature_capability.

> +
> > +        - ``ISOL_F_QUIESCE``:
> > +
> > +                If arg3 is zero, returns a bitmask containing
> > +                which kernel activities are supported for quiescing.
> > +
> > +                If arg3 is ISOL_F_QUIESCE_DEFMASK, returns
> > +                default_quiesce_mask, a system-wide configurable.
> > +                See description of default_quiesce_mask below.
> > +
> > +**PR_ISOL_GET**:
> > +
> > +        Retrieve task isolation feature configuration.
> > +        The general format is::
> > +
> > +                prctl(PR_ISOL_GET, feat, arg3, arg4, arg5);
> > +
> > +        Possible values for feat are:
> > +
> > +        - ``ISOL_F_QUIESCE``:
> > +
> > +                Returns a bitmask containing which kernel
> > +                activities are enabled for quiescing.
> > +
> > +
> > +**PR_ISOL_SET**:
> > +
> > +        Configures task isolation features. The general format is::
> > +
> > +                prctl(PR_ISOL_SET, feat, arg3, arg4, arg5);
> > +
> > +        The 'feat' argument specifies which feature to configure.
> > +        Possible values for feat are:
> >
> 
> We should be able to enable multiple features as well via this? Something
> like ISOL_F_QUIESCE|ISOL_F_BLOCK_INTERRUPTORS as you have mentioned in the
> last posting.

One probably would do it separately (PR_ISOL_SET configures each
feature separately):

       ret = prctl(PR_ISOL_FEAT, 0, 0, 0, 0);
       if (ret == -1) {
               perror("prctl PR_ISOL_FEAT");
               return EXIT_FAILURE;
       }

       if (!(ret & ISOL_F_BLOCK_INTERRUPTORS)) {
               printf("ISOL_F_BLOCK_INTERRUPTORS feature unsupported, quitting\n");
               return EXIT_FAILURE;
       }

       ret = prctl(PR_ISOL_SET, ISOL_F_BLOCK_INTERRUPTORS, params...);
       if (ret == -1) {
               perror("prctl PR_ISOL_SET");
               return EXIT_FAILURE;
       }

       /* configure ISOL_F_QUIESCE, ISOL_F_NOTIFY,
 	* ISOL_F_future_feature... */

	ctrl_set_mask = ISOL_F_QUIESCE|ISOL_F_BLOCK_INTERRUPTORS|
			ISOL_F_NOTIFY|ISOL_F_future_feature;

	/* 
	 * activate isolation mode with the features
	 * as configured above
	 */
	ret = prctl(PR_ISOL_CTRL_SET, ctrl_set_mask, 0, 0, 0);
	if (ret == -1) {
		perror("prctl PR_ISOL_CTRL_SET (ISOL_F_QUIESCE)");
		return EXIT_FAILURE;
	}

	latency sensitive loop

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
> > +                  configured to, upon return from system calls,
> > synchronize
> > +                  the per-CPU counters to global counters, thus avoiding
> > +                  the interruption.
> > +
> > +                  To ensure the application returns to userspace
> > +                  with no modified per-CPU counters, its necessary to
> > +                  use mlockall() in addition to this isolcpus flag.
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
> > +
> > +        Quiescing can be adjusted (while active) by
> > +        prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ...).
> >
> 
> Why do we need this additional control? We should be able to enable or
> disable task isolation using the _GET_ and _SET_ calls, isn't it?

The distinction is so one is able to configure the features separately,
and then enter isolated mode with them activated.

> > +
> > +--------------------
> > +Default quiesce mask
> > +--------------------
> > +
> > +Applications can either explicitly specify individual
> > +background activities that should be quiesced, or
> > +obtain a system configurable value, which is to be
> > +configured by the system admin/mgmt system.
> > +
> > +/sys/kernel/task_isolation/available_quiesce lists, as
> > +one string per line, the activities which the kernel
> > +supports quiescing.
> >
> 
> Probably replace 'quiesce' with 'quiesce_activities' because we are really
> controlling the kernel activities via this control and not the quiesce
> state/feature itself.

OK, makes sense.

> > +
> > +To configure the default quiesce mask, write a comma separated
> > +list of strings (from available_quiesce) to
> > +/sys/kernel/task_isolation/default_quiesce.
> > +
> > +echo > /sys/kernel/task_isolation/default_quiesce disables
> > +all quiescing via ISOL_F_QUIESCE_DEFMASK.
> > +
> > +Using ISOL_F_QUIESCE_DEFMASK allows for the application to
> > +take advantage of future quiescing capabilities without
> > +modification (provided default_quiesce is configured
> > +accordingly).
> >
> 
> ISOL_F_QUIESCE_DEFMASK is really telling to quite all kernel
> activities including the one that is not currently supported or I am
> misinterpreting something?

Its telling to quiesce activities that are configured via
/sys/kernel/task_isolation/default_quiesce, including
ones that are not currently supported (in the future,
/sys/kernel/task_isolation/default_quiesce will have to contain the bit
for the new feature as 1).

So userspace can either:

quiesce_mask = value of /sys/kernel/task_isolation/default_quiesce
prctl(PR_ISOL_SET, ISOL_F_QUIESCE, quiesce_mask, 0, 0);

(so that new features might be automatically enabled by
a sysadmin).

or

quiesce_mask = application choice of bits
prctl(PR_ISOL_SET, ISOL_F_QUIESCE, quiesce_mask, 0, 0);

(so that new features might be automatically enabled by
a sysadmin).




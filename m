Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12023922F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhEZWxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:53:46 -0400
Received: from ms.lwn.net ([45.79.88.28]:44940 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232187AbhEZWxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:53:43 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6FEB72A0;
        Wed, 26 May 2021 22:52:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6FEB72A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622069531; bh=HaP1zHWhUOfXM33Yrfi0/91rHT2gpd7X4R5EBCYoHaA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AmvR6+bW0GTy6OFboURpXmtDnPu/0EJpopGQMlYXOouFZGSigXvnqNmiCykkSdqlj
         v3R8nAuBWqgFfGJdNl7YBgkwaSfxAFK5hXvMNzjDfsGqB8yhPwhl+nXyUSmLKO3b3Q
         xyYwIP95Ll94h6PrXMXOrklEUszTZOllN3HfA2dZ5saKEV1dq16GmE8EDyD0gw1f8B
         oZBzo1TqtPP1abbKhG6PCqUPiL/M2kcNV3HJShrBR1tQXobyzSvWCM4y35hNwh5ak5
         KUtrUkE/XAKyLj2fYPthfCK0og3o2Ay2rWTBuzLwKqO/LLWXUwUuge+aHPCCbqGg5u
         GON7xKhvjKEaQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, mingo@kernel.org,
        peterz@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Add usecases, design and interface for
 core scheduling
In-Reply-To: <20210526175623.34781-1-joel@joelfernandes.org>
References: <20210526175623.34781-1-joel@joelfernandes.org>
Date:   Wed, 26 May 2021 16:52:10 -0600
Message-ID: <87y2c13y79.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Joel Fernandes (Google)" <joel@joelfernandes.org> writes:

> Now that core scheduling is merged, update the documentation.

Yay documentation!

A couple of nits...

> Co-developed-by: Chris Hyser <chris.hyser@oracle.com>
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> Co-developed-by: Josh Don <joshdon@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> Cc: mingo@kernel.org
> Cc: peterz@infradead.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> ---
>  .../admin-guide/hw-vuln/core-scheduling.rst   | 211 ++++++++++++++++++
>  Documentation/admin-guide/hw-vuln/index.rst   |   1 +

As I understand it, there are use cases for core scheduling that go well
beyond dancing around hardware vulnerabilities.  So do we really want to
bury the documentation for this feature there?  To me it seems like the
user-space API manual might be a better place, but perhaps I'm missing
something.

>  2 files changed, 212 insertions(+)
>  create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst
>
> diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> new file mode 100644
> index 000000000000..585edf16183b
> --- /dev/null
> +++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> @@ -0,0 +1,211 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Core Scheduling
> +***************

We have a nicely laid-out set of conventions for subsection headings,
described in Documentation/doc-guide/sphinx.rst; it would be nice if
this document would conform to that.

> +Core scheduling support allows userspace to define groups of tasks that can
> +share a core. These groups can be specified either for security usecases (one
> +group of tasks don't trust another), or for performance usecases (some
> +workloads may benefit from running on the same core as they don't need the same
> +hardware resources of the shared core, or may prefer different cores if they
> +do share hardware resource needs). This document only describes the security
> +usecase.
> +
> +Security usecase
> +----------------
> +A cross-HT attack involves the attacker and victim running on different Hyper
> +Threads of the same core. MDS and L1TF are examples of such attacks.  The only
> +full mitigation of cross-HT attacks is to disable Hyper Threading (HT). Core
> +scheduling is a scheduler feature that can mitigate some (not all) cross-HT
> +attacks. It allows HT to be turned on safely by ensuring that tasks in a

by ensuring that *only* tasks in a trusted group ... right?

> +user-designated trusted group can share a core. This increase in core sharing
> +can also improve performance, however it is not guaranteed that performance
> +will always improve, though that is seen to be the case with a number of real
> +world workloads. In theory, core scheduling aims to perform at least as good as

s/good/well/

> +when Hyper Threading is disabled. In practice, this is mostly the case though
> +not always: as synchronizing scheduling decisions across 2 or more CPUs in a
> +core involves additional overhead - especially when the system is lightly
> +loaded. When ``total_threads <= N_CPUS/2``, the extra overhead may cause core
> +scheduling to perform more poorly compared to SMT-disabled, where N_CPUS is the
> +total number of CPUs. Please measure the performance of your workloads always.
> +
> +Usage
> +-----
> +Core scheduling support is enabled via the ``CONFIG_SCHED_CORE`` config option.

The use of ``literal text`` markup isn't necessary here, and is known to
irritate some people.

> +Using this feature, userspace defines groups of tasks that can be co-scheduled
> +on the same core. The core scheduler uses this information to make sure that
> +tasks that are not in the same group never run simultaneously on a core, while
> +doing its best to satisfy the system's scheduling requirements.
> +
> +Core scheduling can be enabled via the ``PR_SCHED_CORE`` prctl interface.
> +This interface provides support for the creation of core scheduling groups, as
> +well as admission and removal of tasks from created groups.
> +
> +::

I'd just say "from created groups::" and leave off the separate "::" line.

> +
> +    #include <sys/prctl.h>
> +
> +    int prctl(int option, unsigned long arg2, unsigned long arg3,
> +            unsigned long arg4, unsigned long arg5);
> +
> +option:
> +    ``PR_SCHED_CORE``

Did you want that to be in the literal block?  If you don't indent it
that won't work.  If you *do* want it, you really don't need the literal
markup. 

> +
> +arg2:
> +    Command for operation, must be one off:
> +    - ``PR_SCHED_CORE_GET              0  -- get core_sched cookie of ``pid``.
> +    - ``PR_SCHED_CORE_CREATE           1  -- create a new unique cookie for ``pid``.
> +    - ``PR_SCHED_CORE_SHARE_TO         2  -- push core_sched cookie to ``pid``.
> +    - ``PR_SCHED_CORE_SHARE_FROM       3  -- pull core_sched cookie from ``pid``.
> +
> +arg3:
> +    ``pid`` of the task for which the operation applies.
> +
> +arg4:
> +    ``pid_type`` for which the operation applies. It is of type ``enum pid_type``.
> +    For example, if arg4 is ``PIDTYPE_TGID``, then the operation of this command
> +    will be performed for all tasks in the task group of ``pid``.
> +
> +arg5:
> +    userspace pointer to an unsigned long for storing the cookie returned by
> +    ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
> +
> +Cookie Transferral
> +~~~~~~~~~~~~~~~~~~
> +Transferring a cookie between the current and other tasks is possible using
> +PR_SCHED_CORE_SHARE_FROM and PR_SCHED_CORE_SHARE_TO to inherit a cookie from a
> +specified task or a share a cookie with a task. In combination this allows a
> +simple helper program to pull a cookie from a task in an existing core
> +scheduling group and share it with already running tasks.

There must be some sort of security model here, right?  You can't just
steal somebody else's cookies, even if they are the yummy chocolate-chip
variety.  It would be good to say what the policy is.

> +Design/Implementation
> +---------------------
> +Each task that is tagged is assigned a cookie internally in the kernel. As
> +mentioned in `Usage`_, tasks with the same cookie value are assumed to trust
> +each other and share a core.
> +
> +The basic idea is that, every schedule event tries to select tasks for all the
> +siblings of a core such that all the selected tasks running on a core are
> +trusted (same cookie) at any point in time. Kernel threads are assumed trusted.

...and kernel threads trust random user tasks too?  Interesting.

> +The idle task is considered special, as it trusts everything and everything
> +trusts it.
> +
> +During a schedule() event on any sibling of a core, the highest priority task on
> +the sibling's core is picked and assigned to the sibling calling schedule(), if
> +the sibling has the task enqueued. For rest of the siblings in the core,
> +highest priority task with the same cookie is selected if there is one runnable
> +in their individual run queues. If a task with same cookie is not available,
> +the idle task is selected.  Idle task is globally trusted.
> +
> +Once a task has been selected for all the siblings in the core, an IPI is sent to
> +siblings for whom a new task was selected. Siblings on receiving the IPI will
> +switch to the new task immediately. If an idle task is selected for a sibling,
> +then the sibling is considered to be in a `forced idle` state. I.e., it may
> +have tasks on its on runqueue to run, however it will still have to run idle.
> +More on this in the next section.
> +
> +Forced-idling of tasks
> +----------------------

You're idling *CPUs*, not tasks, right?

> +The scheduler tries its best to find tasks that trust each other such that all
> +tasks selected to be scheduled are of the highest priority in a core.  However,
> +it is possible that some runqueues had tasks that were incompatible with the
> +highest priority ones in the core. Favoring security over fairness, one or more
> +siblings could be forced to select a lower priority task if the highest
> +priority task is not trusted with respect to the core wide highest priority
> +task.  If a sibling does not have a trusted task to run, it will be forced idle
> +by the scheduler (idle thread is scheduled to run).
> +
> +When the highest priority task is selected to run, a reschedule-IPI is sent to
> +the sibling to force it into idle. This results in 4 cases which need to be
> +considered depending on whether a VM or a regular usermode process was running
> +on either HT::
> +
> +          HT1 (attack)            HT2 (victim)
> +   A      idle -> user space      user space -> idle
> +   B      idle -> user space      guest -> idle
> +   C      idle -> guest           user space -> idle
> +   D      idle -> guest           guest -> idle
> +
> +Note that for better performance, we do not wait for the destination CPU
> +(victim) to enter idle mode. This is because the sending of the IPI would bring
> +the destination CPU immediately into kernel mode from user space, or VMEXIT
> +in the case of guests. At best, this would only leak some scheduler metadata
> +which may not be worth protecting. It is also possible that the IPI is received
> +too late on some architectures, but this has not been observed in the case of
> +x86.
> +
> +Trust model
> +-----------
> +Core scheduling maintains trust relationships amongst groups of tasks by
> +assigning them a tag that is the same cookie value.
> +When a system with core scheduling boots, all tasks are considered to trust
> +each other. This is because the core scheduler does not have information about
> +trust relationships until userspace uses the above mentioned interfaces, to
> +communicate them. In other words, all tasks have a default cookie value of 0.
> +and are considered system-wide trusted. The stunning of siblings running

"stunning"?  Is this idling or are you doing something more violent here?

> +cookie-0 tasks is also avoided.

[...]

Thanks,

jon

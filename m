Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605A9397B30
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhFAU0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 16:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbhFAU0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 16:26:34 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D039C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 13:24:52 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j189so153183qkf.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3bd06kCbSKH+YO3Nu7Nh6Yw0bI1NiQjiXlC29AZjnao=;
        b=jX42O7b7M8GVDLyJYoIc/vh3K9vdZnnIWQtH35ZOiKF1d6iwKKog/xN6Es6TKixh+q
         C/pCnQBqaWPOYGVlsQWR+0Mr4oEslCJUKgP/YUWCp5UxOOFLEGqYU341mg04SBSFWQUa
         n+WUDnQj5LmnNzdkjqKLquyfn45aXfDrvoxl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3bd06kCbSKH+YO3Nu7Nh6Yw0bI1NiQjiXlC29AZjnao=;
        b=pCut8BkXMzJJEbHrlie/TPeUzGgg6ss7/wl3AAnRGVoeKQJL1+9DcuboXaa1n6Fee5
         7RCw/D3hZd/5HPrYWP4nHXsvwZ8PcLpHQvi+e+d2zmd8qOuNUE+GYXghsudQKPuCLPTN
         nhXurT1YsMMDoTNoV+9Yfq0BV7Oig2ahVVM+ukDh8ofiImyG1Ybg73U8oNRXFRVudRew
         y04+LAzHfcs3sCvAXA6YJa2XglfoV1BFdUadGPUtxJGqUBaEIAlZ9DuopeorVAKPNATh
         GU9+ft3ryiyojS9YsWaYKDdwEoGvavO+pMdKMVpN35kNiUSmF8FZ+7x35Ru6KXN+fxAG
         NHBQ==
X-Gm-Message-State: AOAM532Q3aEpidK8JHTPSls3fTPwoI9FBhwN94ouHGDTUcqZOxi2EOb0
        u41URIMoVaf5390TGCZQF01Bew==
X-Google-Smtp-Source: ABdhPJz/KssSBdYdqZeG7DtcGA/QWfxxrWkwCwnA3nspd111rQ8ecaXRxxCQRfuco/UAcsU59aW7Fg==
X-Received: by 2002:a37:6581:: with SMTP id z123mr23567260qkb.47.1622579091181;
        Tue, 01 Jun 2021 13:24:51 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:959f:df0e:4ded:f970])
        by smtp.gmail.com with ESMTPSA id k125sm11872084qkf.53.2021.06.01.13.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:24:50 -0700 (PDT)
Date:   Tue, 1 Jun 2021 16:24:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Chris Hyser <chris.hyser@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>,
        mingo@kernel.org, peterz@infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Add usecases, design and interface for
 core scheduling
Message-ID: <YLaXko3JYl4JRVv8@google.com>
References: <20210526175623.34781-1-joel@joelfernandes.org>
 <cc52ec64-62df-34ed-3aee-c149b165b1df@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc52ec64-62df-34ed-3aee-c149b165b1df@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the late reply, holidays and all.

On Wed, May 26, 2021 at 05:43:01PM -0400, Chris Hyser wrote:
[..]
> > +Usage
> > +-----
> > +Core scheduling support is enabled via the ``CONFIG_SCHED_CORE`` config option.
> > +Using this feature, userspace defines groups of tasks that can be co-scheduled
> > +on the same core. The core scheduler uses this information to make sure that
> > +tasks that are not in the same group never run simultaneously on a core, while
> > +doing its best to satisfy the system's scheduling requirements.
> > +
> > +Core scheduling can be enabled via the ``PR_SCHED_CORE`` prctl interface.
> > +This interface provides support for the creation of core scheduling groups, as
> > +well as admission and removal of tasks from created groups.
> > +
> > +::
> > +
> > +    #include <sys/prctl.h>
> > +
> > +    int prctl(int option, unsigned long arg2, unsigned long arg3,
> > +            unsigned long arg4, unsigned long arg5);
> > +
> > +option:
> > +    ``PR_SCHED_CORE``
> > +
> > +arg2:
> > +    Command for operation, must be one off:
> > +    - ``PR_SCHED_CORE_GET              0  -- get core_sched cookie of ``pid``.
> > +    - ``PR_SCHED_CORE_CREATE           1  -- create a new unique cookie for ``pid``.
> > +    - ``PR_SCHED_CORE_SHARE_TO         2  -- push core_sched cookie to ``pid``.
> > +    - ``PR_SCHED_CORE_SHARE_FROM       3  -- pull core_sched cookie from ``pid``.
> > +
> > +arg3:
> > +    ``pid`` of the task for which the operation applies.
> > +
> > +arg4:
> > +    ``pid_type`` for which the operation applies. It is of type ``enum pid_type``.
> > +    For example, if arg4 is ``PIDTYPE_TGID``, then the operation of this command
> > +    will be performed for all tasks in the task group of ``pid``.
> > +
> > +arg5:
> > +    userspace pointer to an unsigned long for storing the cookie returned by
> > +    ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
> 
> Thanks Joel.

Np, thanks.

> In terms of using the prctl() interface to achieve what was once done with
> cgroups, we might want to add some text somewhere in here along the lines of
> say:

Sure.

> 
> -----------
> 
> The simplest way to build hierarchies of threads/processes which share a
> cookie and thus a core is to rely on the fact that the core-sched cookie is
> inherited across forks/clones and execs, thus setting a cookie for the
> 'initial' script/executable/daemon will place every spawned child in the
> same core-sched group. The prctl() API is useful for verification or making
> more specific or elaborate changes.

Just a question:  What kind of verification and why?

> Clearing a cookie can be done with
> PR_SCHED_CORE_SHARE_* involving a task w/o a cookie presumably owned by root
> or other secure user.

I would drop this part from the description tbh, since it seems a rather
corner case. It seems odd to have to clear a cookie once it is set, but if
you can provide me a usecase for clearing, then I can add that in. We don't
clear the cookie in our ChromeOS usecases.

thanks,

 - Joel


> 
> 
> 
> > +
> > +Cookie Transferral
> > +~~~~~~~~~~~~~~~~~~
> > +Transferring a cookie between the current and other tasks is possible using
> > +PR_SCHED_CORE_SHARE_FROM and PR_SCHED_CORE_SHARE_TO to inherit a cookie from a
> > +specified task or a share a cookie with a task. In combination this allows a
> > +simple helper program to pull a cookie from a task in an existing core
> > +scheduling group and share it with already running tasks.
> > +
> > +Design/Implementation
> > +---------------------
> > +Each task that is tagged is assigned a cookie internally in the kernel. As
> > +mentioned in `Usage`_, tasks with the same cookie value are assumed to trust
> > +each other and share a core.
> > +
> > +The basic idea is that, every schedule event tries to select tasks for all the
> > +siblings of a core such that all the selected tasks running on a core are
> > +trusted (same cookie) at any point in time. Kernel threads are assumed trusted.
> > +The idle task is considered special, as it trusts everything and everything
> > +trusts it.
> > +
> > +During a schedule() event on any sibling of a core, the highest priority task on
> > +the sibling's core is picked and assigned to the sibling calling schedule(), if
> > +the sibling has the task enqueued. For rest of the siblings in the core,
> > +highest priority task with the same cookie is selected if there is one runnable
> > +in their individual run queues. If a task with same cookie is not available,
> > +the idle task is selected.  Idle task is globally trusted.
> > +
> > +Once a task has been selected for all the siblings in the core, an IPI is sent to
> > +siblings for whom a new task was selected. Siblings on receiving the IPI will
> > +switch to the new task immediately. If an idle task is selected for a sibling,
> > +then the sibling is considered to be in a `forced idle` state. I.e., it may
> > +have tasks on its on runqueue to run, however it will still have to run idle.
> > +More on this in the next section.
> > +
> > +Forced-idling of tasks
> > +----------------------
> > +The scheduler tries its best to find tasks that trust each other such that all
> > +tasks selected to be scheduled are of the highest priority in a core.  However,
> > +it is possible that some runqueues had tasks that were incompatible with the
> > +highest priority ones in the core. Favoring security over fairness, one or more
> > +siblings could be forced to select a lower priority task if the highest
> > +priority task is not trusted with respect to the core wide highest priority
> > +task.  If a sibling does not have a trusted task to run, it will be forced idle
> > +by the scheduler (idle thread is scheduled to run).
> > +
> > +When the highest priority task is selected to run, a reschedule-IPI is sent to
> > +the sibling to force it into idle. This results in 4 cases which need to be
> > +considered depending on whether a VM or a regular usermode process was running
> > +on either HT::
> > +
> > +          HT1 (attack)            HT2 (victim)
> > +   A      idle -> user space      user space -> idle
> > +   B      idle -> user space      guest -> idle
> > +   C      idle -> guest           user space -> idle
> > +   D      idle -> guest           guest -> idle
> > +
> > +Note that for better performance, we do not wait for the destination CPU
> > +(victim) to enter idle mode. This is because the sending of the IPI would bring
> > +the destination CPU immediately into kernel mode from user space, or VMEXIT
> > +in the case of guests. At best, this would only leak some scheduler metadata
> > +which may not be worth protecting. It is also possible that the IPI is received
> > +too late on some architectures, but this has not been observed in the case of
> > +x86.
> > +
> > +Trust model
> > +-----------
> > +Core scheduling maintains trust relationships amongst groups of tasks by
> > +assigning them a tag that is the same cookie value.
> > +When a system with core scheduling boots, all tasks are considered to trust
> > +each other. This is because the core scheduler does not have information about
> > +trust relationships until userspace uses the above mentioned interfaces, to
> > +communicate them. In other words, all tasks have a default cookie value of 0.
> > +and are considered system-wide trusted. The stunning of siblings running
> > +cookie-0 tasks is also avoided.
> > +
> > +Once userspace uses the above mentioned interfaces to group sets of tasks, tasks
> > +within such groups are considered to trust each other, but do not trust those
> > +outside. Tasks outside the group also don't trust tasks within.
> > +
> > +Limitations of core-scheduling
> > +------------------------------
> > +Core scheduling tries to guarantee that only trusted tasks run concurrently on a
> > +core. But there could be small window of time during which untrusted tasks run
> > +concurrently or kernel could be running concurrently with a task not trusted by
> > +kernel.
> > +
> > +1. IPI processing delays
> > +########################
> > +Core scheduling selects only trusted tasks to run together. IPI is used to notify
> > +the siblings to switch to the new task. But there could be hardware delays in
> > +receiving of the IPI on some arch (on x86, this has not been observed). This may
> > +cause an attacker task to start running on a CPU before its siblings receive the
> > +IPI. Even though cache is flushed on entry to user mode, victim tasks on siblings
> > +may populate data in the cache and micro architectural buffers after the attacker
> > +starts to run and this is a possibility for data leak.
> > +
> > +Open cross-HT issues that core scheduling does not solve
> > +--------------------------------------------------------
> > +1. For MDS
> > +##########
> > +Core scheduling cannot protect against MDS attacks between an HT running in
> > +user mode and another running in kernel mode. Even though both HTs run tasks
> > +which trust each other, kernel memory is still considered untrusted. Such
> > +attacks are possible for any combination of sibling CPU modes (host or guest mode).
> > +
> > +2. For L1TF
> > +###########
> > +Core scheduling cannot protect against an L1TF guest attacker exploiting a
> > +guest or host victim. This is because the guest attacker can craft invalid
> > +PTEs which are not inverted due to a vulnerable guest kernel. The only
> > +solution is to disable EPT (Extended Page Tables).
> > +
> > +For both MDS and L1TF, if the guest vCPU is configured to not trust each
> > +other (by tagging separately), then the guest to guest attacks would go away.
> > +Or it could be a system admin policy which considers guest to guest attacks as
> > +a guest problem.
> > +
> > +Another approach to resolve these would be to make every untrusted task on the
> > +system to not trust every other untrusted task. While this could reduce
> > +parallelism of the untrusted tasks, it would still solve the above issues while
> > +allowing system processes (trusted tasks) to share a core.
> > +
> > +3. Protecting the kernel (IRQ, syscall, VMEXIT)
> > +###############################################
> > +Unfortunately, core scheduling does not protect kernel contexts running on
> > +sibling hyperthreads from one another. Prototypes of mitigations have been posted
> > +to LKML to solve this, but it is debatable whether such windows are practically
> > +exploitable, and whether the performance overhead of the prototypes are worth
> > +it (not to mention, the added code complexity).
> > +
> > +Other Use cases
> > +---------------
> > +The main use case for Core scheduling is mitigating the cross-HT vulnerabilities
> > +with SMT enabled. There are other use cases where this feature could be used:
> > +
> > +- Isolating tasks that needs a whole core: Examples include realtime tasks, tasks
> > +  that uses SIMD instructions etc.
> > +- Gang scheduling: Requirements for a group of tasks that needs to be scheduled
> > +  together could also be realized using core scheduling. One example is vCPUs of
> > +  a VM.
> > diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
> > index ca4dbdd9016d..f12cda55538b 100644
> > --- a/Documentation/admin-guide/hw-vuln/index.rst
> > +++ b/Documentation/admin-guide/hw-vuln/index.rst
> > @@ -15,3 +15,4 @@ are configurable at compile, boot or run time.
> >      tsx_async_abort
> >      multihit.rst
> >      special-register-buffer-data-sampling.rst
> > +   core-scheduling.rst
> > 

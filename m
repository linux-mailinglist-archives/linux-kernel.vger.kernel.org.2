Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552933F84F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbhHZKAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240937AbhHZKAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:00:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64C9C610CE;
        Thu, 26 Aug 2021 10:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629972000;
        bh=+vOuO6pVGtwIHauXlArhk8MXcOcwWPAI4yK03amf+Sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZuiOR0HRB1eNxAehKUhRfRHivVQXr8gebBXRhay7U24LXSnePddDSGPJflJWmEKy
         IrzPjpmJZ9n9ooVrwzVBCl+mgTOOpL0o6HilOB5Wpg2kKgA8AFUFq/qDhD8qH1G/hw
         4Ub1ZvSLeBne1tFtqZks+XL36m92dMbokCIzg69PUrnnv4v+SscAPo9BLUNuROzqrj
         dKGgtkI3z0M+qL0TEaEGbeICmUaUrZPzb9PoepYr4E8wEBfVgPgRQzBUSBCBgPRXt/
         vORWIoMk7oAoTKYwiAaQEML0bOcnc/a+NCxYRcCvZa7lRWEqj+pvyp0MnVdPxnVeK9
         WYutAju+BmhEQ==
Date:   Thu, 26 Aug 2021 11:59:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch V3 2/8] add prctl task isolation prctl docs and samples
Message-ID: <20210826095958.GA908505@lothringen>
References: <20210824152423.300346181@fuller.cnet>
 <20210824152646.706875395@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824152646.706875395@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:24:25PM -0300, Marcelo Tosatti wrote:
> Add documentation and userspace sample code for prctl
> task isolation interface.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
>  Documentation/userspace-api/task_isolation.rst |  211 +++++++++++++++++++++++++
>  samples/Kconfig                                |    7 
>  samples/Makefile                               |    1 
>  samples/task_isolation/Makefile                |    9 +
>  samples/task_isolation/task_isol.c             |   83 +++++++++
>  samples/task_isolation/task_isol.h             |    9 +
>  samples/task_isolation/task_isol_userloop.c    |   56 ++++++
>  7 files changed, 376 insertions(+)
> 
> Index: linux-2.6/Documentation/userspace-api/task_isolation.rst
> ===================================================================
> --- /dev/null
> +++ linux-2.6/Documentation/userspace-api/task_isolation.rst
> @@ -0,0 +1,281 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================
> +Task isolation prctl interface
> +===============================
> +
> +Certain types of applications benefit from running uninterrupted by
> +background OS activities. Realtime systems and high-bandwidth networking
> +applications with user-space drivers can fall into the category.
> +
> +To create an OS noise free environment for the application, this
> +interface allows userspace to inform the kernel the start and
> +end of the latency sensitive application section (with configurable
> +system behaviour for that section).
> +
> +Note: the prctl interface is independent of nohz_full=.
> +
> +The prctl options are:
> +
> +
> +        - PR_ISOL_FEAT: Retrieve supported features.
> +        - PR_ISOL_GET: Retrieve task isolation parameters.
> +        - PR_ISOL_SET: Set task isolation parameters.
> +        - PR_ISOL_CTRL_GET: Retrieve task isolation state.
> +        - PR_ISOL_CTRL_SET: Set task isolation state.
> +        - PR_ISOL_GET_INT: Retrieve internal parameters.
> +        - PR_ISOL_SET_INT: Retrieve internal parameters.

There should be some short summary here to explain the difference
between parameter, state, and internal parameter. I personally have
no clue so far.

> +
> +
> +Inheritance of the isolation parameters and state, across
> +fork(2) and clone(2), can be changed via
> +PR_ISOL_GET_INT/PR_ISOL_SET_INT.
> +
> +At a high-level, task isolation is divided in two steps:
> +
> +1. Configuration.
> +2. Activation.
> +
> +Section "Userspace support" describes how to use
> +task isolation.
> +
> +In terms of the interface, the sequence of steps to activate
> +task isolation are:
> +
> +1. Retrieve supported task isolation features (PR_ISOL_FEAT).
> +2. Configure task isolation features (PR_ISOL_SET/PR_ISOL_GET).
> +3. Activate or deactivate task isolation features
> +   (PR_ISOL_CTRL_GET/PR_ISOL_CTRL_SET).
> +4. Optionally configure inheritance (PR_ISOL_GET_INT/PR_ISOL_SET_INT).
> +
> +This interface is based on ideas and code from the
> +task isolation patchset from Alex Belits:
> +https://lwn.net/Articles/816298/
> +
> +--------------------
> +Feature description
> +--------------------
> +
> +        - ``ISOL_F_QUIESCE``
> +
> +        This feature allows quiescing select kernel activities on
> +        return from system calls.
> +
> +---------------------
> +Interface description
> +---------------------
> +
> +**PR_ISOL_FEAT**:
> +
> +        Returns the supported features and feature
> +        capabilities, as a bitmask::
> +
> +                prctl(PR_ISOL_FEAT, feat, arg3, arg4, arg5);
> +
> +        The 'feat' argument specifies whether to return
> +        supported features (if zero), or feature capabilities
> +        (if not zero). Possible non-zero values for 'feat' are:
> +
> +        - ``ISOL_F_QUIESCE``:
> +
> +                Returns a bitmask containing which kernel
> +                activities are supported for quiescing.
> +
> +        Features and its capabilities are defined at
> include/uapi/linux/task_isolation.h.

Preferably have feat a parameter name. We never know if we want
to extend it in the future.

> +
> +**PR_ISOL_GET**:
> +
> +        Retrieve task isolation feature configuration.
> +        The general format is::
> +
> +                prctl(PR_ISOL_GET, feat, arg3, arg4, arg5);
> +
> +        The 'feat' argument specifies whether to return
> +        configured features (if zero), or individual feature
> +        configuration (if not zero).

You might need to elaborate a bit on the "feat" behaviour difference.

> +        values for 'feat' are:
> +
> +        - ``ISOL_F_QUIESCE``:
> +
> +                Returns a bitmask containing which kernel
> +                activities are enabled for quiescing.
> +
> +
> +**PR_ISOL_SET**:
> +
> +        Configures task isolation features. The general format is::
> +
> +                prctl(PR_ISOL_SET, feat, arg3, arg4, arg5);
> +
> +        The 'feat' argument specifies which feature to configure.
> +        Possible values for feat are:
> +
> +        - ``ISOL_F_QUIESCE``:
> +
> +                The 'arg3' argument is a bitmask specifying which
> +                kernel activities to quiesce. Possible bit sets are:
> +
> +                - ``ISOL_F_QUIESCE_VMSTATS``
> +
> +                  VM statistics are maintained in per-CPU counters to
> +                  improve performance. When a CPU modifies a VM statistic,
> +                  this modification is kept in the per-CPU counter.
> +                  Certain activities require a global count, which
> +                  involves requesting each CPU to flush its local counters
> +                  to the global VM counters.
> +
> +                  This flush is implemented via a workqueue item, which
> +                  might schedule a workqueue on isolated CPUs.
> +
> +                  To avoid this interruption, task isolation can be
> +                  configured to, upon return from system calls, synchronize
> +                  the per-CPU counters to global counters, thus avoiding
> +                  the interruption.
> +
> +                  To ensure the application returns to userspace
> +                  with no modified per-CPU counters, its necessary to
> +                  use mlockall() in addition to this isolcpus flag.

So prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ISOL_F_QUIESCE_VMSTATS, ...) will quiesce
on all subsequent return to userspace, right?

> +
> +**PR_ISOL_CTRL_GET**:
> +
> +        Retrieve task isolation control.
> +
> +                prctl(PR_ISOL_CTRL_GET, 0, 0, 0, 0);
> +
> +        Returns which isolation features are active.
> +
> +**PR_ISOL_CTRL_SET**:
> +
> +        Activates/deactivates task isolation control.
> +
> +                prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
> +
> +        The 'mask' argument specifies which features
> +        to activate (bit set) or deactivate (bit clear).
> +
> +        For ISOL_F_QUIESCE, quiescing of background activities
> +        happens on return to userspace from the
> +        prctl(PR_ISOL_CTRL_SET) call, and on return from
> +        subsequent system calls.

Now I'm lost again on the difference with PR_ISOL_SET

> +
> +        Quiescing can be adjusted (while active) by
> +        prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ...).
> +
> +**PR_ISOL_GET_INT**:
> +
> +        Retrieves task isolation internal parameters.
> +
> +        The general format is::
> +
> +                prctl(PR_ISOL_GET_INT, cmd, arg3, arg4, arg5);
> +
> +        The 'cmd' argument specifies which parameter to configure.
> +        Possible values for cmd are:
> +
> +        - ``INHERIT_CFG``:
> +
> +                Retrieve inheritance configuration.
> +
> +                The 'arg3' argument is a pointer to a struct
> +                inherit_control::
> +
> +                        struct task_isol_inherit_control {
> +                                __u8    inherit_mask;
> +                                __u8    pad[7];
> +                        };
> +
> +                See PR_ISOL_SET_INT description below for meaning
> +                of structure fields.
> +
> +**PR_ISOL_SET_INT**:
> +
> +        Sets task isolation internal parameters.
> +
> +        The general format is::
> +
> +                prctl(PR_ISOL_SET_INT, cmd, arg3, arg4, arg5);
> +
> +        The 'cmd' argument specifies which parameter to configure.
> +        Possible values for cmd are:
> +
> +        - ``INHERIT_CFG``:
> +
> +                Set inheritance configuration when a new task
> +                is created via fork and clone.
> +
> +                The 'arg3' argument is a pointer to a struct
> +                inherit_control::
> +
> +                        struct task_isol_inherit_control {
> +                                __u8    inherit_mask;
> +                                __u8    pad[7];
> +                        };
> +
> +                inherit_mask is a bitmask that specifies which part
> +                of task isolation to be inherited:
> +
> +                - Bit ISOL_INHERIT_CONF: Inherit task isolation configuration.
> +                  This is the stated written via prctl(PR_ISOL_SET, ...).
> +
> +                - Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
> +                  (requires ISOL_INHERIT_CONF to be set). The new task
> +                  should behave, right after fork/clone, in the same manner
> +                  as the parent task _after_ it executed:
> +
> +                        prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
> +
> +                  with a valid mask.

I'm wondering if those things shouldn't be set on arg4 for PR_ISOL_SET instead?
Arguably having a whole prctl for that makes it easier to extend. But then
PR_ISOL_SET_INT must always be called before PR_ISOL_SET, otherwise we create
noise, right?

Thanks.

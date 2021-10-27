Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2781443C9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbhJ0Mkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236394AbhJ0Mke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:40:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02D5F60F02;
        Wed, 27 Oct 2021 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635338289;
        bh=0EJwjFr8tsSalutM0b22CAYufXNK4KFNQQ/YmgpEHP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpZana94uewjwJaj0LiycIVs6foie/uAG0wuQoUpaJJxwnDR09Ev/MYoVzOm0JIFe
         K7X4R2lf2DAHdX5jnDvxpPNThd3AXLEd+qy3tr56ZoSvu8mAZqhXqrT7TwaDOp5Udx
         JK4C4mNh4EJq6s6UhHukHoiMcgekpK2w/jBCOIsLy5bQ1Tja/XFz1aboabsSJ8t1zu
         S35GEZURcegxFULuvpsuV/nHEi/HBoIn6Qht4l1gkHd9OldeHzyUpSzlSPe00MwC23
         Ux7vUW3sb/XDXQhsfNqr+7QuVLhcxQAwBdFHNOiZg2l4aesWIpDj6Bib+f3t3zuxih
         VyNoJmpN7o7Qw==
Date:   Wed, 27 Oct 2021 14:38:06 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v5 2/8] add prctl task isolation prctl docs and samples
Message-ID: <20211027123806.GA70141@lothringen>
References: <20211019152431.885037499@fedora.localdomain>
 <20211019154210.706067872@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019154210.706067872@fedora.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 12:24:33PM -0300, Marcelo Tosatti wrote:
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
> +        - PR_ISOL_FEAT_GET: Retrieve supported features.
> +        - PR_ISOL_CFG_GET: Retrieve task isolation configuration.
> +        - PR_ISOL_CFG_SET: Set task isolation configuration.
> +        - PR_ISOL_ACTIVATE_GET: Retrieve task isolation activation state.
> +        - PR_ISOL_ACTIVATE_SET: Set task isolation activation state.
> +
> +Summary of terms:
> +
> +
> +- feature:
> +
> +        A distinct attribute or aspect of task isolation. Examples of
> +        features could be logging, new operating modes (eg: syscalls disallowed),
> +        userspace notifications, etc. The only feature currently available is quiescing.
> +
> +- configuration:
> +
> +        A specific choice from a given set
> +        of possible choices that dictate how the particular feature
> +        in question should behave.
> +
> +- activation state:
> +
> +        The activation state (whether activate/inactive) of the task

active/inactive ?

> +        isolation features (features must be configured before
> +        being activated).
> +
[...]
> +Feature description
> +--------------------
> +
> +        - ``ISOL_F_QUIESCE``
> +
> +        This feature allows quiescing select kernel activities on

selected?

> +        return from system calls.
> +
> +
[...]
> +        - ``I_CFG_INHERIT``:
> +                Set inheritance configuration when a new task
> +                is created via fork and clone.
> +
> +                The ``(int *)arg4`` argument is a pointer to::
> +
> +                        struct task_isol_inherit_control {
> +                                __u8    inherit_mask;
> +                                __u8    pad[7];
> +                        };
> +
> +                inherit_mask is a bitmask that specifies which part
> +                of task isolation should be inherited:
> +
> +                - Bit ISOL_INHERIT_CONF: Inherit task isolation configuration.
> +                  This is the stated written via prctl(PR_ISOL_CFG_SET, ...).

state

> +
> +                - Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
> +                  (requires ISOL_INHERIT_CONF to be set). The new task
> +                  should behave, after fork/clone, in the same manner
> +                  as the parent task after it executed:
> +
> +                        prctl(PR_ISOL_ACTIVATE_SET, &mask, ...);
> +
> +**PR_ISOL_ACTIVATE_GET**:
> +
> +        Retrieve task isolation activation state.
> +
> +        The general format is::
> +
> +                prctl(PR_ISOL_ACTIVATE_GET, pmask, arg3, arg4, arg5);
> +
> +        'pmask' specifies the location of a feature mask, where
> +        the current active mask will be copied. See PR_ISOL_ACTIVATE_SET
> +        for description of individual bits.
> +
> +
> +**PR_ISOL_ACTIVATE_SET**:
> +
> +        Set task isolation activation state (activates/deactivates
> +        task isolation).
> +
> +        The general format is::
> +
> +                prctl(PR_ISOL_ACTIVATE_SET, pmask, arg3, arg4, arg5);
> +
> +
> +        The 'pmask' argument specifies the location of an 8 byte mask
> +        containing which features should be activated. Features whose
> +        bits are cleared will be deactivated. The possible
> +        bits for this mask are:
> +
> +                - ``ISOL_F_QUIESCE``:
> +
> +                Activate quiescing of background kernel activities.
> +                Quiescing happens on return to userspace from this
> +                system call, and on return from subsequent
> +                system calls (unless quiesce_oneshot_mask is configured,
> +                see below).
> +
> +        If the arg3 argument is non-zero, it specifies a pointer to::
> +
> +         struct task_isol_activate_control {
> +                 __u64 flags;
> +                 __u64 quiesce_oneshot_mask;

So you are using an entire argument here to set a single feature (ISOL_F_QUIESCE).
It looks like the oneshot VS every syscall behaviour should be defined at
configuration time for individual ISOL_F_QUIESCE features.

Also do we want that to always apply to all syscalls? Should we expect corner
cases with some of them? What about exceptions and interrupts?

My wild guess is that we need to leave room for future flexibility. Either open
some configuration space on ISOL_F_QUIESCE for that or create a seperate
ISOL_F_QUIESCE_ONESHOT.

Other than that, the general interface looks good! Now time for me to
look at the implementation...

Thanks.

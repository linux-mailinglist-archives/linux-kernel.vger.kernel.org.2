Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0970D45A5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbhKWOkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238446AbhKWOkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:40:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 806A060FE8;
        Tue, 23 Nov 2021 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637678249;
        bh=1uDEvFK4C4GbaR1cDKVcOBukWvQhHZwNGUgoe4eHI7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFP7tfUXqroo6SYM8ik2Avl1bCxZCg5ydbDyFRwCKW2Hfmiy4p2mgS/UDdrO+wZUn
         Oot1yVGMfQAukTpF+I81qk4KvzHa7Uc9pY5+1UvCbIsa+W2tEEWH8I7HT8amAeyuSg
         4rkr+H12wNVkUJxfpVlmvdDSqHc7dbYY3X5UGafg4IQtGlKO5Zd4ltVT59ot77/9HK
         K+ivIHV37MMwFJtkTyV/PzoiUXJd368r9Mzbgi0pAYoSD+WwKv2T809rOJOK66c+jI
         JE7HztPfMSVwbnbvie7d4vEO1KehpV6GVSlZz/tdaIEC5IplaXJC9oPMFS/N9J3b6R
         1jwV5veH5GP/w==
Date:   Tue, 23 Nov 2021 15:37:26 +0100
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
Subject: Re: [patch v7 02/10] add prctl task isolation prctl docs and samples
Message-ID: <20211123143726.GC479935@lothringen>
References: <20211112123531.497831890@fuller.cnet>
 <20211112123750.692268849@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112123750.692268849@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 09:35:33AM -0300, Marcelo Tosatti wrote:
> +**PR_ISOL_CFG_GET**:
> +
> +        Retrieve task isolation configuration.
> +        The general format is::
> +
> +                prctl(PR_ISOL_CFG_GET, what, arg3, arg4, arg5);
> +
> +        The 'what' argument specifies what to configure. Possible values are:
> +
> +        - ``I_CFG_FEAT``:
> +
> +                Return configuration of task isolation features. The 'arg3' argument specifies
> +                whether to return configured features (if zero), or individual
> +                feature configuration (if not zero), as follows.
> +
> +                - ``0``:
> +
> +                        Return the bitmask of configured features, in the location
> +                        pointed  to  by  ``(int *)arg4``. The buffer should allow space
> +                        for 8 bytes.
> +
> +                - ``ISOL_F_QUIESCE``:
> +
> +                        If arg4 is QUIESCE_CONTROL, return the control structure for
> +                        quiescing of background kernel activities, in the location
> +                        pointed to by ``(int *)arg5``::
> +
> +                         struct task_isol_quiesce_control {
> +                                __u64 flags;
> +                                __u64 quiesce_mask;
> +                                __u64 quiesce_oneshot_mask;
> +                                __u64 pad[5];
> +                         };
> +
> +                        See PR_ISOL_CFG_GET description for meaning of
> fields.

PR_ISOL_CFG_SET ?

[...]
> +
> +                        *quiesce_oneshot_mask*: A bitmask indicating which kernel
> +                        activities should behave in oneshot mode, that is, quiescing
> +                        will happen on return from prctl(PR_ISOL_ACTIVATE_SET), but not
> +                        on return of subsequent system calls. The corresponding bit(s)
> +                        must also be set at quiesce_mask.

Don't forget to mention interrupts and exceptions.

> +
> +                        *pad*: Additional space for future enhancements.
> +
> +                        For quiesce_mask (and quiesce_oneshot_mask), possible bit sets are:
> +
> +                        - ``ISOL_F_QUIESCE_VMSTATS``
> +
> +                        VM statistics are maintained in per-CPU counters to
> +                        improve performance. When a CPU modifies a VM statistic,
> +                        this modification is kept in the per-CPU counter.
> +                        Certain activities require a global count, which
> +                        involves requesting each CPU to flush its local counters
> +                        to the global VM counters.
> +
> +                        This flush is implemented via a workqueue item, which
> +                        might schedule a workqueue on isolated CPUs.
> +
> +                        To avoid this interruption, task isolation can be
> +                        configured to, upon return from system calls, synchronize
> +                        the per-CPU counters to global counters, thus avoiding
> +                        the interruption.
> +
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
> +                  This is the state written via prctl(PR_ISOL_CFG_SET, ...).
> +
> +                - Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
> +                  (requires ISOL_INHERIT_CONF to be set). The new task
> +                  should behave, after fork/clone, in the same manner
> +                  as the parent task after it executed:
> +
> +                        prctl(PR_ISOL_ACTIVATE_SET, &mask, ...);

I'm confused, what is the purpose of ISOL_INHERIT_CONF?

Thanks.

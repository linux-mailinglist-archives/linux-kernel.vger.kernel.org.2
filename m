Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B245A2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhKWMjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:39:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231623AbhKWMjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:39:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA41160F26;
        Tue, 23 Nov 2021 12:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637670983;
        bh=MYHEX86QfMcNpolSFzzLd/pHC5k4X3EcOgdamAz5rTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3q7O/jqm07gr78a9qaNS6ehgnXXDdmmAsCNsDQ9uXztlkPbAlZR0t/XHkQpg9LN/
         aM22RYUruE7qBe0KvQRx40FTXX9teK2oDWVK9ol7z7lDewST96WT2i+/VA08XQTxUB
         lhwcXy+hLMSbTpgt20L95NAQDKFfVCqQjIlvMdKPQw2J8GSBVoZk5GqdQuryocOA81
         6o/US7IFxx7MAgzdHkdhkuH8G3vVArLvaS+rJuHSPtEKsnMAJWAb+ADxXGOAeVbawe
         RnWsEn+dH3X0vIWr+didr67Xu/cyq8MCsLau7HV9vwxfvppuyE7LpbHgAwrKeFNFR8
         aogF8L5QpFY5Q==
Date:   Tue, 23 Nov 2021 13:36:20 +0100
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
Message-ID: <20211123123620.GB479935@lothringen>
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
> +**PR_ISOL_CFG_SET**:
> +
> +        Set task isolation configuration.
> +        The general format is::
> +
> +                prctl(PR_ISOL_CFG_SET, what, arg3, arg4, arg5);
> +
> +        The 'what' argument specifies what to configure. Possible values are:
> +
> +        - ``I_CFG_FEAT``:
> +
> +                Set configuration of task isolation features. 'arg3' specifies
> +                the feature. Possible values are:
> +
> +                - ``ISOL_F_QUIESCE``:
> +
> +                        If arg4 is QUIESCE_CONTROL, set the control structure
> +                        for quiescing of background kernel activities, from
> +                        the location pointed to by ``(int *)arg5``::
> +
> +                         struct task_isol_quiesce_control {
> +                                __u64 flags;
> +                                __u64 quiesce_mask;
> +                                __u64 quiesce_oneshot_mask;
> +                                __u64 pad[5];
> +                         };
> +
> +                        Where:
> +
> +                        *flags*: Additional flags (should be zero).
> +
> +                        *quiesce_mask*: A bitmask containing which kernel
> +                        activities to quiesce.
> +
> +                        *quiesce_oneshot_mask*: A bitmask indicating which kernel
> +                        activities should behave in oneshot mode, that is, quiescing
> +                        will happen on return from prctl(PR_ISOL_ACTIVATE_SET), but not
> +                        on return of subsequent system calls. The corresponding bit(s)
> +                        must also be set at quiesce_mask.
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

Sorry I know this is already v7 but we really don't want to screw up this interface.

What would be more simple and flexible for individual features to quiesce:

   arg3 = ISOL_F_QUIESCE
   arg4 = which feature to quiesce (eg: ISOL_F_QUIESCE_VMSTATS)
   arg5 =

       struct task_isol_quiesce_control {
           __u64 flags; //with ONESHOT as the first and only possible flag for now
           __u64 pad[5];
       };

This way we can really do a finegrained control over each feature to quiesce.

Thanks.

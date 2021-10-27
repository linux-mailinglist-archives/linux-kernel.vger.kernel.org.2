Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6408A43C88A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhJ0L3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 07:29:37 -0400
Received: from foss.arm.com ([217.140.110.172]:42242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhJ0L3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:29:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E4191FB;
        Wed, 27 Oct 2021 04:27:11 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.72.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6CBE3F73D;
        Wed, 27 Oct 2021 04:27:09 -0700 (PDT)
Date:   Wed, 27 Oct 2021 12:26:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org
Subject: Re: [PATCH] arm64: Select POSIX_CPU_TIMERS_TASK_WORK
Message-ID: <20211027112658.GA54628@C02TD0UTHF1T.local>
References: <20211018144713.873464-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018144713.873464-1-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Marc Z to Cc, since this affects KVM]

On Mon, Oct 18, 2021 at 04:47:13PM +0200, Nicolas Saenz Julienne wrote:
> With 6caa5812e2d1 ("KVM: arm64: Use generic KVM xfer to guest work
> function") all arm64 exit paths are properly equipped to handle the
> POSIX timers' task work.
> 
> Deferring timer callbacks to thread context, not only limits the amount
> of time spent in hard interrupt context, but is a safer
> implementation[1], and will allow PREEMPT_RT setups to use KVM[2].
> 
> So let's enable POSIX_CPU_TIMERS_TASK_WORK on arm64.
> 
> [1] https://lore.kernel.org/all/20200716201923.228696399@linutronix.de/
> [2] https://www.spinics.net/lists/linux-rt-users/msg24860.html

Trivial nit: could we please make that second link:

  https://lore.kernel.org/linux-rt-users/87v92bdnlx.ffs@tglx/

> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Regardless, this makes sense to me, and given you've tested it:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> 
> ---
> 
> This was tested by running all relevant kernel timer self-tests and
> making sure KVM still works as expected.
> 
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 789036cf74f5..ce0d0d254542 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -191,6 +191,7 @@ config ARM64
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> +	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
>  	select HAVE_FUNCTION_ARG_ACCESS_API
>  	select HAVE_FUTEX_CMPXCHG if FUTEX
>  	select MMU_GATHER_RCU_TABLE_FREE
> -- 
> 2.32.0
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4D53AB188
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhFQKnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:43:08 -0400
Received: from foss.arm.com ([217.140.110.172]:51604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhFQKnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:43:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E46D31B;
        Thu, 17 Jun 2021 03:41:00 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72B1A3F694;
        Thu, 17 Jun 2021 03:40:57 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:40:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210617103524.GA82133@C02TD0UTHF1T.local>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote:
> On arm32, the only way to safely flush icache from usermode is to call
> cacheflush(2).  This also handles any required pipeline flushes, so
> membarrier's SYNC_CORE feature is useless on arm.  Remove it.

Unfortunately, it's a bit more complicated than that, and these days
SYNC_CORE is equally necessary on arm as on arm64. This is something
that changed in the architecture over time, but since ARMv7 we generally
need both the cache maintenance *and* a context synchronization event
(the latter must occur on the CPU which will execute the instructions).

If you look at the latest ARMv7-AR manual (ARM DDI 406C.d), section
A3.5.4 "Concurrent modification and execution of instructions" covers
this. That manual can be found at:

	https://developer.arm.com/documentation/ddi0406/latest/

Likewise for ARMv8-A; the latest manual (ARM DDI 0487G.a) covers this in
sections B2.2.5 and E2.3.5. That manual can be found at:

	https://developer.arm.com/documentation/ddi0487/ga

I am not sure about exactly what's required 11MPcore, since that's
somewhat a special case as the only SMP design prior to ARMv7-A
mandating broadcast maintenance.

For intuition's sake, one reason for this is that once a CPU has fetched
an instruction from an instruction cache into its pipeline and that
instruction is "in-flight", changes to that instruction cache are not
guaranteed to affect the "in-flight" copy (which e.g. could be
decomposed into micro-ops and so on). While these parts of a CPU aren't
necessarily designed as caches, they effectively transiently cache a
stale copy of the instruction while it is being executed.

This is more pronounced on newer designs with more complex execution
pipelines (e.g. with bigger windows for out-of-order execution and
speculation), and generally it's unlikely for this to be noticed on
smaller/simpler designs.

As above, modifying instructions requires two things:

1) Making sure that *subsequent* instruction fetches will see the new
   instructions. This is what cacheflush(2) does, and this is similar to
   what SW does on arm64 with DC CVAU + IC IVAU instructions and
   associated memory barriers.

2) Making sure that a CPU fetches the instructions *after* the cache
   maintenance is complete. There are a few ways to do this:

   * A context synchronization event (e.g. an ISB or exception return)
     on the CPU that will execute the instructions. This is what
     membarrier(SYNC_CORE) does.

   * In ARMv8-A there are some restrictions on the order in which
     modified instructions are guaranteed to be observed (e.g. if you
     publish a function, then subsequently install a branch to that new
     function), where an ISB may not be necessary. In the latest ARMv8-A
     manual as linked above, those are described in sections:

     - B2.3.8 "Ordering of instruction fetches" (for 64-bit)
     - E2.3.8 "Ordering of instruction fetches" (for 32-bit)

   * Where we can guarantee that a CPU cannot possibly have an
     instruction in-flight (e.g. due to a lack of a mapping to fetch
     instructions from), nothing is necessary. This is what we rely on
     when faulting in code pages. In these cases, the CPU is liable to
     take fault on the missing translation anyway.

Thanks,
Mark.

> 
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/arm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 24804f11302d..89a885fba724 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -10,7 +10,6 @@ config ARM
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_KEEPINITRD
>  	select ARCH_HAS_KCOV
> -	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
>  	select ARCH_HAS_PHYS_TO_DMA
> -- 
> 2.31.1
> 

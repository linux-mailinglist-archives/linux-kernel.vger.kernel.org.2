Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AE83BF7A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhGHJg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:36:27 -0400
Received: from foss.arm.com ([217.140.110.172]:54632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhGHJg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:36:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 819DFED1;
        Thu,  8 Jul 2021 02:33:44 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D573E3F5A1;
        Thu,  8 Jul 2021 02:33:42 -0700 (PDT)
Date:   Thu, 8 Jul 2021 10:33:40 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        linux-arm-kernel@lits.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Add missing header <asm/smp.h> in two files
Message-ID: <20210708093340.GB24650@C02TD0UTHF1T.local>
References: <5726396.lOV4Wx5bFT@iron-maiden>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5726396.lOV4Wx5bFT@iron-maiden>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 01:54:13PM -0400, Carlos Bilbao wrote:
> Add missing header <asm/smp.h> on include/asm/smp_plat.h, as it calls function
> cpu_logical_map(). Also include it on kernel/cpufeature.c since it has calls to
> functions cpu_panic_kernel() and cpu_die_early().
>  
> Both files call functions defined on this header, make the header dependencies 
> less fragile.
> 
> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>

Per our usual rules, we should include a header if we directly use a
something defined in that header, so this makes sense to me.

I have a couple of minor comments below; with those fixed up:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> ---
>  arch/arm64/include/asm/smp_plat.h | 1 +
>  arch/arm64/kernel/cpufeature.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
> index 99ad77df8f52..140c7a03a901 100644
> --- a/arch/arm64/include/asm/smp_plat.h
> +++ b/arch/arm64/include/asm/smp_plat.h
> @@ -11,6 +11,7 @@
>  #include <linux/cpumask.h>
>  
>  #include <asm/types.h>
> +#include <asm/smp.h>

We try to keep the includes in alphabetical order; could you please make
this:

| #include <asm/smp.h>
| #include <asm/types.h>

>  struct mpidr_hash {
>         u64     mask;
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 125d5c9471ac..350d8601ff28 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -84,6 +84,7 @@
>  #include <asm/sysreg.h>
>  #include <asm/traps.h>
>  #include <asm/virt.h>
> +#include <asm/smp.h>

Similarly, here:

| #include <asm/smp.h>
| #include <asm/sysreg.h>
| #include <asm/traps.h>
| #include <asm/virt.h>

(I checked the file, and immediately before <asm/sysreg.h> we include
<asm/processor.h>).

Thanks,
Mark.

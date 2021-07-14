Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38AE3C8B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 20:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbhGNSue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 14:50:34 -0400
Received: from foss.arm.com ([217.140.110.172]:38356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240126AbhGNSub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCB33D6E;
        Wed, 14 Jul 2021 11:47:39 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.2.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BE2F3F774;
        Wed, 14 Jul 2021 11:47:37 -0700 (PDT)
Date:   Wed, 14 Jul 2021 19:47:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Henry Willard <henry.willard@oracle.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tabba@google.com,
        keescook@chromium.org, ardb@kernel.org, samitolvanen@google.com,
        joe@perches.com, nixiaoming@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kexec: add support for kexec with spin-table
Message-ID: <20210714184733.GB28555@C02TD0UTHF1T.local>
References: <1626284473-1168-1-git-send-email-henry.willard@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626284473-1168-1-git-send-email-henry.willard@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henry,

On Wed, Jul 14, 2021 at 10:41:13AM -0700, Henry Willard wrote:
> With one special exception kexec is not supported on systems
> that use spin-table as the cpu enablement method instead of PSCI.
> The spin-table implementation lacks cpu_die() and several other
> methods needed by the hotplug framework used by kexec on Arm64.
> 
> Some embedded systems may not have a need for the Arm Trusted
> Firmware, or they may lack it during early bring-up. Some of
> these may have a more primitive version of u-boot that uses a
> special device from which to load the kernel. Kexec can be
> especially useful for testing new kernels in such an environment.
> 
> What is needed to support kexec is some place for cpu_die to park
> the secondary CPUs outside the kernel while the primary copies
> the new kernel into place and starts it. One possibility is to
> use the control-code-page where arm64_relocate_new_kernel_size()
> executes, but that requires a complicated and racy dance to get
> the secondary CPUs from the control-code-page to the new
> kernel after it has been copied.
> 
> The spin-table mechanism is setup before the Linux kernel
> is entered with details provided in the device tree. The
> "release-address" DT variable provides the address of a word the
> secondary CPUs are polling. The boot CPU will store the real address
> of secondary_holding_pen() at that address, and the secondary CPUs
> will branch to that address. secondary_holding_pen() is another
> loop where the secondary CPUs wait to be called up by the boot CPU.
> 
> This patch uses that mechanism to implement cpu_die(). In modern
> versions of u-boot that implement spin-table, the address of the
> loop in protected memory can be derived from the "release-address"
> value. The patch validates the existence of the loop before
> proceeding. smp_spin_table_cpu_die() uses cpu_soft_restart() to
> branch to the loop with the MMU and caching turned off where the
> CPU waits until released by the new kernel. After that kexec
> reboot proceeds normally.

This isn't true for all spin-table implementations; for example this is
not safe with the boot-wrapper.

While, I'm not necessarily opposed to providing a mechanism to return a
CPU back to the spin-table, the presence of that mechanism needs to be
explicitly defined in the device tree (e.g. with a "cpu-return-addr"
property or similar), and we need to thoroughly document the contract
(e.g. what state the CPU is in when it is returned). We've generally
steered clear of this since it is much more complicated than it may
initially seem, and there is immense scope for error.

If we do choose to extend spin-table in this way, we'll also need to
enforce that each cpu has a unique cpu-release-address, or this is
unsound to begin with (since e.g. the kernel can't return CPUs that it
doesn't know are stuck in the holding pen). We will also need a
mechanism to reliably identify when the CPU has been successfully
returned.

I would very much like to avoid this if possible. U-Boot does have a
PSCI implementation that some platforms use; is it not possible to use
this?

If this is for early bringup, and you're using the first kernel as a
bootloader, I'd suggest that you boot that with "nosmp", such that the
first kernel doesn't touch the secondary CPUs at all.

> The special exception is the kdump capture kernel, which gets
> started even if the secondaries can't be stopped.
> 
> Signed-off-by: Henry Willard <henry.willard@oracle.com>
> ---
>  arch/arm64/kernel/smp_spin_table.c | 111 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
> index 7e1624ecab3c..35c7fa764476 100644
> --- a/arch/arm64/kernel/smp_spin_table.c
> +++ b/arch/arm64/kernel/smp_spin_table.c
> @@ -13,16 +13,27 @@
>  #include <linux/mm.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/daifflags.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/cputype.h>
>  #include <asm/io.h>
>  #include <asm/smp_plat.h>
> +#include <asm/mmu_context.h>
> +#include <asm/kexec.h>
> +
> +#include "cpu-reset.h"
>  
>  extern void secondary_holding_pen(void);
>  volatile unsigned long __section(".mmuoff.data.read")
>  secondary_holding_pen_release = INVALID_HWID;
>  
>  static phys_addr_t cpu_release_addr[NR_CPUS];
> +static unsigned int spin_table_loop[4] = {
> +	0xd503205f,        /* wfe */
> +	0x58000060,        /* ldr  x0, spin_table_cpu_release_addr */
> +	0xb4ffffc0,        /* cbnz x0, 0b */
> +	0xd61f0000         /* br   x0 */
> +};
>  
>  /*
>   * Write secondary_holding_pen_release in a way that is guaranteed to be
> @@ -119,9 +130,109 @@ static int smp_spin_table_cpu_boot(unsigned int cpu)
>  	return 0;
>  }
>  
> +
> +/*
> + * There is a four instruction loop set aside in protected
> + * memory by u-boot where secondary CPUs wait for the kernel to
> + * start.
> + *
> + * 0:       wfe
> + *          ldr    x0, spin_table_cpu_release_addr
> + *          cbz    x0, 0b
> + *          br     x0
> + * spin_table_cpu_release_addr:
> + *          .quad  0
> + *
> + * The address of spin_table_cpu_release_addr is passed in the
> + * "release-address" property in the device table.
> + * smp_spin_table_cpu_prepare() stores the real address of
> + * secondary_holding_pen() where the secondary CPUs loop
> + * until they are released one at a time by smp_spin_table_cpu_boot().
> + * We reuse the spin-table loop by clearing spin_table_cpu_release_addr,
> + * and branching to the beginning of the loop via cpu_soft_restart(),
> + * which turns off the MMU and caching.
> + */
> +static void smp_spin_table_cpu_die(unsigned int cpu)
> +{
> +	__le64 __iomem *release_addr;
> +	unsigned int *spin_table_inst;
> +	unsigned long spin_table_start;
> +
> +	if (!cpu_release_addr[cpu])
> +		goto spin;
> +
> +	spin_table_start = (cpu_release_addr[cpu] - sizeof(spin_table_loop));
> +
> +	/*
> +	 * The cpu-release-addr may or may not be inside the linear mapping.
> +	 * As ioremap_cache will either give us a new mapping or reuse the
> +	 * existing linear mapping, we can use it to cover both cases. In
> +	 * either case the memory will be MT_NORMAL.
> +	 */
> +	release_addr = ioremap_cache(spin_table_start,
> +				sizeof(*release_addr) +
> +				sizeof(spin_table_loop));
> +
> +	if (!release_addr)
> +		goto spin;
> +
> +	spin_table_inst = (unsigned int *)release_addr;
> +	if (spin_table_inst[0] != spin_table_loop[0] ||
> +		spin_table_inst[1] != spin_table_loop[1] ||
> +		spin_table_inst[2] != spin_table_loop[2] ||
> +		spin_table_inst[3] != spin_table_loop[3])
> +		goto spin;

Please don't hard-code a specific sequence for this; if we *really* need
this, we should be given a cpu-return-addr explicitly, and we should
simply trust it.

> +
> +	/*
> +	 * Clear the release address, so that we can use it again
> +	 */
> +	writeq_relaxed(0, release_addr + 2);
> +	dcache_clean_inval_poc((__force unsigned long)(release_addr + 2),
> +			(__force unsigned long)(release_addr + 2) +
> +				    sizeof(*release_addr));

What is the `+ 2` for?

> +
> +	iounmap(release_addr);
> +
> +	local_daif_mask();
> +	cpu_soft_restart(spin_table_start, 0, 0, 0);
> +
> +	BUG();  /* Should never get here */
> +
> +spin:
> +	cpu_park_loop();
> +
> +}
> +
> +static int smp_spin_table_cpu_kill(unsigned int cpu)
> +{
> +	unsigned long start, end;
> +
> +	start = jiffies;
> +	end = start + msecs_to_jiffies(100);
> +
> +	do {
> +		if (!cpu_online(cpu)) {
> +			pr_info("CPU%d killed\n", cpu);
> +			return 0;
> +		}
> +	} while (time_before(jiffies, end));
> +	pr_warn("CPU%d may not have shut down cleanly\n", cpu);
> +	return -ETIMEDOUT;
> +
> +}

If we're going to extend this, we must add a mechanism to reliably
identify when the CPU has been returned successfully. We can't rely on
cpu_online(), becuase there's a window between the CPU marking itself as
offline and actually exiting the kernel.

> +
> +/* Nothing to do here */
> +static int smp_spin_table_cpu_disable(unsigned int cpu)
> +{
> +	return 0;
> +}

For implementations where we cannot return the CPU, cpu_disable() *must*
fail.

Thanks,
Mark.

> +
>  const struct cpu_operations smp_spin_table_ops = {
>  	.name		= "spin-table",
>  	.cpu_init	= smp_spin_table_cpu_init,
>  	.cpu_prepare	= smp_spin_table_cpu_prepare,
>  	.cpu_boot	= smp_spin_table_cpu_boot,
> +	.cpu_die	= smp_spin_table_cpu_die,
> +	.cpu_kill	= smp_spin_table_cpu_kill,
> +	.cpu_disable	= smp_spin_table_cpu_disable,
>  };
> -- 
> 1.8.3.1
> 

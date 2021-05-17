Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5E386B66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbhEQUcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:32:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44570 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhEQUcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:32:52 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id A5DAA20B7188;
        Mon, 17 May 2021 13:31:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5DAA20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1621283495;
        bh=+NhnXSLEEJVe5AKkog56DLhbOIesqKPIgLMypmjSRE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbvitoZS1YjW1YS3HQLZwb/TynDAH46ZbNYe4eTJBzPZxxF3eFb4IhHKfYot5aLSb
         zx96B0YPfQnUbuxywFC8QqbiMBBAYMiKnN5+NH7iF86A6ZRCuoqa09/qqk1ncib4Zn
         u6pq+csA1eDNeZxyybWGxXTWZ2XFJSTLsvjotsxA=
Date:   Mon, 17 May 2021 15:31:32 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     jens.wiklander@linaro.org, zajec5@gmail.com,
        Allen Pais <allen.lkml@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Allen Pais <apais@linux.microsoft.com>
Subject: Re: [PATCH] optee: Disable shm cache when booting the crash kernel
Message-ID: <20210517203132.GL4967@sequoia>
References: <20210225090610.242623-1-allen.lkml@gmail.com>
 <20210507035816.426585-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507035816.426585-1-tyhicks@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-06 22:58:16, Tyler Hicks wrote:
> The .shutdown hook is not called after a kernel crash when a kdump
> kernel is pre-loaded. A kexec into the kdump kernel takes place as
> quickly as possible without allowing drivers to clean up.
> 
> That means that the OP-TEE shared memory cache, which was initialized by
> the kernel that crashed, is still in place when the kdump kernel is
> booted. As the kdump kernel is shutdown, the .shutdown hook is called,
> which calls optee_disable_shm_cache(), and OP-TEE's
> OPTEE_SMC_DISABLE_SHM_CACHE API returns virtual addresses that are not
> mapped for the kdump kernel since the cache was set up by the previous
> kernel. Trying to dereference the tee_shm pointer or otherwise translate
> the address results in a fault that cannot be handled:
> 
>  Unable to handle kernel paging request at virtual address ffff4317b9c09744
>  Mem abort info:
>    ESR = 0x96000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>  Data abort info:
>    ISV = 0, ISS = 0x00000004
>    CM = 0, WnR = 0
>  swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000970b1e000
>  [ffff4317b9c09744] pgd=0000000000000000, p4d=0000000000000000
>  Internal error: Oops: 96000004 [#1] SMP
>  Modules linked in: bnxt_en pcie_iproc_platform pcie_iproc diagbe(O)
>  CPU: 4 PID: 1 Comm: systemd-shutdow Tainted: G           O      5.10.19.8 #1
>  Hardware name: Redacted (DT)
>  pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
>  pc : tee_shm_free (/usr/src/kernel/drivers/tee/tee_shm.c:363)
>  lr : optee_disable_shm_cache (/usr/src/kernel/drivers/tee/optee/call.c:441)
>  sp : ffff80001005bb70
>  x29: ffff80001005bb70 x28: ffff608e74648e00
>  x27: ffff80001005bb98 x26: dead000000000100
>  x25: ffff80001005bbb8 x24: aaaaaaaaaaaaaaaa
>  x23: ffff608e74cf8818 x22: ffff608e738be600
>  x21: ffff80001005bbc8 x20: ffff608e738be638
>  x19: ffff4317b9c09700 x18: ffffffffffffffff
>  x17: 0000000000000041 x16: ffffba61b5171764
>  x15: 0000000000000004 x14: 0000000000000fff
>  x13: ffffba61b5c9dfc8 x12: 0000000000000003
>  x11: 0000000000000000 x10: 0000000000000000
>  x9 : ffffba61b5413824 x8 : 00000000ffff4317
>  x7 : 0000000000000000 x6 : 0000000000000000
>  x5 : 0000000000000000 x4 : 0000000000000000
>  x3 : 0000000000000000 x2 : ffff4317b9c09700
>  x1 : 00000000ffff4317 x0 : ffff4317b9c09700
>  Call trace:
>  tee_shm_free (/usr/src/kernel/drivers/tee/tee_shm.c:363)
>  optee_disable_shm_cache (/usr/src/kernel/drivers/tee/optee/call.c:441)
>  optee_shutdown (/usr/src/kernel/drivers/tee/optee/core.c:636)
>  platform_drv_shutdown (/usr/src/kernel/drivers/base/platform.c:800)
>  device_shutdown (/usr/src/kernel/include/linux/device.h:758 /usr/src/kernel/drivers/base/core.c:4078)
>  kernel_restart (/usr/src/kernel/kernel/reboot.c:221 /usr/src/kernel/kernel/reboot.c:248)
>  __arm64_sys_reboot (/usr/src/kernel/kernel/reboot.c:349 /usr/src/kernel/kernel/reboot.c:312 /usr/src/kernel/kernel/reboot.c:312)
>  do_el0_svc (/usr/src/kernel/arch/arm64/kernel/syscall.c:56 /usr/src/kernel/arch/arm64/kernel/syscall.c:158 /usr/src/kernel/arch/arm64/kernel/syscall.c:197)
>  el0_svc (/usr/src/kernel/arch/arm64/kernel/entry-common.c:368)
>  el0_sync_handler (/usr/src/kernel/arch/arm64/kernel/entry-common.c:428)
>  el0_sync (/usr/src/kernel/arch/arm64/kernel/entry.S:671)
>  Code: aa0003f3 b5000060 12800003 14000002 (b9404663)
> 
> When booting the kdump kernel, drain the shared memory cache while being
> careful to not translate the addresses returned from
> OPTEE_SMC_DISABLE_SHM_CACHE. Once the invalid cache objects are drained
> and the cache is disabled, proceed with re-enabling the cache so that we
> aren't dealing with invalid addresses while shutting down the kdump
> kernel.
> 
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
> 
> This patch fixes a crash introduced by "optee: fix tee out of memory
> failure seen during kexec reboot"[1]. However, I don't think that the
> original two patch series[2] plus this patch is the full solution to
> properly handling OP-TEE shared memory across kexec.
> 
> While testing this fix, I did about 10 kexec reboots and then triggered
> a kernel crash by writing 'c' to /proc/sysrq-trigger. The kdump kernel
> became unresponsive during boot while steadily streaming the following
> errors to the serial console:
> 
>  arm-smmu 64000000.mmu: Blocked unknown Stream ID 0x2000; boot with "arm-smmu.disable_bypass=0" to allow, but this may have security implications
>  arm-smmu 64000000.mmu:     GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x00002000, GFSYNR2 0x00000000
> 
> I suspect that this is related to the problems of OP-TEE shared memory
> handling across kexec. My current hunch is that while we've disabled the
> shared memory cache with this patch, we haven't unregistered all of the
> addresses that the previous kernel (which crashed) had registered with
> OP-TEE and that perhaps OP-TEE OS is still trying to make use those
> addresses?
> 
> I'm still pretty early in investigating that assumption and
> I'm learning about OP-TEE as I go but I wanted to get this initial
> fix-of-the-fix out so that it was clear that the v2 of the series[2] is
> not complete.
> 
> [1] https://lore.kernel.org/lkml/20210225090610.242623-2-allen.lkml@gmail.com/
> [2] https://lore.kernel.org/lkml/20210225090610.242623-1-allen.lkml@gmail.com/#t
> 
>  drivers/tee/optee/call.c          | 11 ++++++++++-
>  drivers/tee/optee/core.c          | 13 +++++++++++--
>  drivers/tee/optee/optee_private.h |  2 +-
>  3 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 6132cc8d014c..799e84bec63d 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -417,8 +417,10 @@ void optee_enable_shm_cache(struct optee *optee)
>   * optee_disable_shm_cache() - Disables caching of some shared memory allocation
>   *			      in OP-TEE
>   * @optee:	main service struct
> + * @is_mapped:	true if the cached shared memory addresses were mapped by this
> + *		kernel, are safe to dereference, and should be freed
>   */
> -void optee_disable_shm_cache(struct optee *optee)
> +void optee_disable_shm_cache(struct optee *optee, bool is_mapped)
>  {
>  	struct optee_call_waiter w;
>  
> @@ -437,6 +439,13 @@ void optee_disable_shm_cache(struct optee *optee)
>  		if (res.result.status == OPTEE_SMC_RETURN_OK) {
>  			struct tee_shm *shm;
>  
> +			/*
> +			 * Shared memory references that were not mapped by
> +			 * this kernel must be ignored to prevent a crash.
> +			 */
> +			if (!is_mapped)
> +				continue;
> +
>  			shm = reg_pair_to_ptr(res.result.shm_upper32,
>  					      res.result.shm_lower32);
>  			tee_shm_free(shm);
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 69d1f698907c..9985c671bd1f 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -6,6 +6,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/arm-smccc.h>
> +#include <linux/crash_dump.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -588,7 +589,7 @@ static int optee_remove(struct platform_device *pdev)
>  	 * reference counters and also avoid wild pointers in secure world
>  	 * into the old shared memory range.
>  	 */
> -	optee_disable_shm_cache(optee);
> +	optee_disable_shm_cache(optee, true);
>  
>  	/*
>  	 * The two devices have to be unregistered before we can free the
> @@ -618,7 +619,7 @@ static int optee_remove(struct platform_device *pdev)
>   */
>  static void optee_shutdown(struct platform_device *pdev)
>  {
> -	optee_disable_shm_cache(platform_get_drvdata(pdev));
> +	optee_disable_shm_cache(platform_get_drvdata(pdev), true);
>  }
>  
>  static int optee_probe(struct platform_device *pdev)
> @@ -705,6 +706,14 @@ static int optee_probe(struct platform_device *pdev)
>  	optee->memremaped_shm = memremaped_shm;
>  	optee->pool = pool;
>  
> +	/*
> +	 * The kexec into the crash kernel did not call our .shutdown hook. The
> +	 * shm cache objects registered with OP-TEE are not valid for the crash
> +	 * kernel.
> +	 */
> +	if (is_kdump_kernel())
> +		optee_disable_shm_cache(optee, false);

Additional testing showed that only clearing the shm cache when booting
the kdump kernel isn't quite enough. A kexec from an old kernel, without
Allen's fix ("optee: fix OOM seen due to tee_shm_free()"), to a new
kernel that contain the fix can still result in stale/invalid shm cache
addresses hanging around in the secure world. When the fixed kernel is
shutdown, it can still experience a crash and/or memory corruption
because the secure world returns bad addresses from
OPTEE_SMC_DISABLE_SHM_CACHE that are not valid for the current kernel.

In order to safely support kexec within the OP-TEE driver, I think the
best option is going to always do a call to optee_disable_shm_cache()
prior to calling optee_enable_shm_cache() in optee_probe().

This series is in need of a v3 with all the new knowledge/fixes after
testing kexec/kdump more with OP-TEE. I'll try to get a v3 out in the
coming days.

Tyler

> +
>  	optee_enable_shm_cache(optee);
>  
>  	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index e25b216a14ef..16d8c82213e7 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -158,7 +158,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
>  int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
>  
>  void optee_enable_shm_cache(struct optee *optee);
> -void optee_disable_shm_cache(struct optee *optee);
> +void optee_disable_shm_cache(struct optee *optee, bool is_mapped);
>  
>  int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
>  		       struct page **pages, size_t num_pages,
> -- 
> 2.25.1
> 

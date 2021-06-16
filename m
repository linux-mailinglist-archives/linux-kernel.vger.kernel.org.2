Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CEE3AA4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 22:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhFPUG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 16:06:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:43107 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhFPUG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 16:06:27 -0400
IronPort-SDR: d/9d5+5zwJ+NHV/H9EXl0n3splWLrxYR0xYL8D7bUpO5wTdzGuNhS5e0WOqRotBeZ/iEU3yVcY
 SZQEUx+i/f7g==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="203227311"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="203227311"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 13:04:17 -0700
IronPort-SDR: pCyWVQdC9o6zW0J8FkMtBNU1n/5215iiqiFT+911KSuWDZHnA8ROgKsClbzbmbB+6Pd/VPjcwC
 LMr8PVb0Bypw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="415865790"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2021 13:04:15 -0700
Received: from [10.209.60.10] (kliang2-MOBL.ccr.corp.intel.com [10.209.60.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B00A05808A3;
        Wed, 16 Jun 2021 13:04:14 -0700 (PDT)
Subject: Re: [patch V2 32/52] x86/fpu/xstate: Sanitize handling of independent
 features
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210614154408.673478623@linutronix.de>
 <20210614155356.961460910@linutronix.de>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <7309d6fa-dd25-ac31-7b05-d88f59d18213@linux.intel.com>
Date:   Wed, 16 Jun 2021 16:04:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614155356.961460910@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2021 11:44 AM, Thomas Gleixner wrote:
> The copy functions for the independent features are horribly named and the
> supervisor and independent part is just overengineered.
> 
> The point is that the supplied mask has either to be a subset of the
> independent feature or a subset of the task->fpu.xstate managed features.
> 
> Rewrite it so it checks check for invalid overlaps of these areas in the
> caller supplied feature mask. Rename it so it follows the new naming
> convention for these operations. Mop up the function documentation.
> 
> This allows to use that function for other purposes as well.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> ---
>   arch/x86/events/intel/lbr.c       |    6 +-
>   arch/x86/include/asm/fpu/xstate.h |    5 +-
>   arch/x86/kernel/fpu/xstate.c      |   93 +++++++++++++++++++-------------------
>   3 files changed, 53 insertions(+), 51 deletions(-)
> 
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -491,7 +491,7 @@ static void intel_pmu_arch_lbr_xrstors(v
>   {
>   	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
>   
> -	copy_kernel_to_independent_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
> +	xrstors_from_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
>   }
>   
>   static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
> @@ -576,7 +576,7 @@ static void intel_pmu_arch_lbr_xsaves(vo
>   {
>   	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
>   
> -	copy_independent_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
> +	xsaves_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
>   }
>   
>   static void __intel_pmu_lbr_save(void *ctx)
> @@ -992,7 +992,7 @@ static void intel_pmu_arch_lbr_read_xsav
>   		intel_pmu_store_lbr(cpuc, NULL);
>   		return;
>   	}
> -	copy_independent_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
> +	xsaves_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
>   
>   	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
>   }

I tested the LBR Xsave feature on a Alder Lake machine. It looks good.

However, when I did other CPU hotplug test, it gave me an Oops.

$ sudo bash -c 'echo 0 > /sys/devices/system/cpu/cpu1/online'
$ sudo bash -c 'echo 1 > /sys/devices/system/cpu/cpu1/online'

[  108.912963] IRQ 132: no longer affine to CPU1
[  108.913010] IRQ148: set affinity failed(-22).
[  108.913038] IRQ149: set affinity failed(-22).
[  108.913050] IRQ150: set affinity failed(-22).
[  108.917436] smpboot: CPU 1 is now offline
[  111.191655] x86: Booting SMP configuration:
[  111.191661] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  111.200452] BUG: unable to handle page fault for address: 
ffffffff996a96a0
[  111.207312] #PF: supervisor write access in kernel mode
[  111.207325] #PF: error_code(0x0003) - permissions violation
[  111.207335] PGD 40a02b067 P4D 40a02b067 PUD 40a02c063 PMD 106bdb063 
PTE 8000000409ea9161
[  111.218116] Oops: 0003 [#1] PREEMPT SMP NOPTI
[  111.218137] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 
5.13.0-rc5-perf+ #123
[  111.218156] RIP: 0010:fpu__init_cpu_xstate+0x3e/0x130
[  111.218184] Code: 00 00 00 48 8b 05 02 08 66 01 48 85 c0 0f 84 a7 00 
00 00 55 48 89 c6 4889 e5 53 81 e6 00 01 00 00 0f 85 b5 00 00 00 80 e4 
fe <48> 89 05 db 07 66 01 9c 58 0f 1f 4400 00 48 89 c3 fa 66 0f 1f 44
[  111.218195] RSP: 0000:ffffa466401abec0 EFLAGS: 00010002
[  111.273756] RAX: 0000000000000207 RBX: 0000000000000008 RCX: 
0000000000000000
[  111.273764] RDX: 0000000000310800 RSI: 0000000000000000 RDI: 
0000000080050033
[  111.273772] RBP: ffffa466401abec8 R08: 00000000fffffe00 R09: 
ffff98729f686078
[  111.273778] R10: ffffffff99826000 R11: ffffa466401abdde R12: 
0000000000000001
[  111.273783] R13: 0000000000000000 R14: ffff986f00c20000 R15: 
000000000000b000
[  111.273789] FS:  0000000000000000(0000) GS:ffff98729f680000(0000) 
knlGS:0000000000000000
[  111.273798] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  111.273805] CR2: ffffffff996a96a0 CR3: 000000040a026001 CR4: 
0000000000330ea0
[  111.273813] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  111.273817] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
0000000000000400
[  111.273834] invalid opcode: 0000 [#2] PREEMPT SMP NOPTI
[  111.273843] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 
5.13.0-rc5-perf+ #123

Thanks,
Kan

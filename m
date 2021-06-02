Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61048398EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhFBPhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231998AbhFBPhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:37:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9C1861263;
        Wed,  2 Jun 2021 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622648148;
        bh=0VLoy0rhrQHu2OpUhQg9K0BeIaXnqhH0K+dJ8W7apEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEF0gC+Xowua9jjpLt35zgXLSxzEp08SmG0kbNGjWOuYDvBtXnSjPq85TjEp8G6AS
         S/nn8h0s6rwqeVlQaQu2V3UmFLWqgNOEdDrE1RuzL29+nNjxywACS5TBhrB69bkS5l
         b6+TP1ZamPM3rx4A2UxtmmX9t9IAfkTmo2IuAswWBJZVKZ5hDS+CbkI6zY7bMlKeda
         p+ACMexjGC09X6FmF3k8XFAzY0uhP2JNO8ks9jIcKQFj3rSpWjyIB3VMkFREqcwQF9
         Od+IEYffF4oym8bB7B4Qh6wIHGov1nmiHh9v+TREjzL2z/COlZHyoMjTykHi15vb+f
         Bq/Il6Gla8hyQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B7C1D40EFC; Wed,  2 Jun 2021 12:35:44 -0300 (-03)
Date:   Wed, 2 Jun 2021 12:35:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:x86/cpu 4/4] Warning: Kernel ABI header at
 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at
 'arch/x86/include/asm/cpufeatures.h':  111< /* free                                    (
 3*32+29) */
Message-ID: <YLelUPtti40D7DUl@kernel.org>
References: <20210602094153.GH1271937@shao2-debian>
 <YLdTRopUV9OyulSq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YLdTRopUV9OyulSq@zn.tnic>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 02, 2021 at 11:45:42AM +0200, Borislav Petkov escreveu:
> + acme.
> 
> On Wed, Jun 02, 2021 at 05:41:53PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
> > head:   cbcddaa33d7e11a053cb80a4a635c023b4f8b906
> > commit: cbcddaa33d7e11a053cb80a4a635c023b4f8b906 [4/4] perf/x86/rapl: Use CPUID bit on AMD and Hygon parts
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce:
> > cd tools/perf && ./check-headers.sh
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > perfheadercheck warnings: (new ones prefixed by >>)
> >    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':   87< #define X86_FEATURE_K7			( 3*32+ 5) /* "" Athlon */
> >    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':   87> /* FREE, was #define X86_FEATURE_K7			( 3*32+ 5) "" Athlon */
> > >> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  111< /* free					( 3*32+29) */
> > >> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  111> #define X86_FEATURE_RAPL		( 3*32+29) /* AMD/Hygon RAPL interface */
> >    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  239> #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* "" PV unlock function */
> >    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  240> #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* "" PV vcpu_is_preempted function */
> >    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  295> #define X86_FEATURE_SGX1		(11*32+ 8) /* "" Basic SGX */
> >    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  296> #define X86_FEATURE_SGX2		(11*32+ 9) /* "" SGX Enclave Dynamic Memory Management (EDMM) */
> >    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  343> #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
> >    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  362> #define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* Bus Lock detect */
> >    Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h':  383> #define X86_FEATURE_HYBRID_CPU		(18*32+15) /* "" This part has CPUs of more than one type */
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 0day folks, please make a note if you can, to send such cpufeatures.h
> header sync warnings to acme as he's verifying the feature bits modified
> before synching.
> 
> Better yet, you can even ignore those altogether but I'm sure acme has a
> preference here.

Borislav,

	This is an attempt, suggested by PeterZ for us to try to
automate those updates, so what I was expecting wasn't a report that
something changed, as I notice it myself, but an attempt at checking if
the changes in these updates would entail changes in the tools build.

	Say, is there a script in tools/perf/trace/beauty/ that ends up
producing a different .c that then gets compiled/linked with tooling? Or
this is just a trivial change like happens from time to time, a typo
fix, some comments added, etc.

	Some examples of what those scripts do:

⬢[acme@toolbox perf]$ tools/perf/trace/beauty/fadvise.sh
static const char *fadvise_advices[] = {
	[0] = "NORMAL",
	[1] = "RANDOM",
	[2] = "SEQUENTIAL",
	[3] = "WILLNEED",
	[4] = "DONTNEED",
	[5] = "NOREUSE",
};
⬢[acme@toolbox perf]$ tools/perf/trace/beauty/socket.sh
static const char *socket_families[] = {
	[0] = "UNSPEC",
	[1] = "LOCAL",
	[2] = "INET",
	[3] = "AX25",
	[4] = "IPX",
	[5] = "APPLETALK",
	[6] = "NETROM",
	[7] = "BRIDGE",
	[8] = "ATMPVC",
	[9] = "X25",
	[10] = "INET6",
	[11] = "ROSE",
	[12] = "DECnet",
	[13] = "NETBEUI",
	[14] = "SECURITY",
	[15] = "KEY",
	[16] = "NETLINK",
	[17] = "PACKET",
	[18] = "ASH",
	[19] = "ECONET",
	[20] = "ATMSVC",
	[21] = "RDS",
	[22] = "SNA",
	[23] = "IRDA",
	[24] = "PPPOX",
	[25] = "WANPIPE",
	[26] = "LLC",
	[27] = "IB",
	[28] = "MPLS",
	[29] = "CAN",
	[30] = "TIPC",
	[31] = "BLUETOOTH",
	[32] = "IUCV",
	[33] = "RXRPC",
	[34] = "ISDN",
	[35] = "PHONET",
	[36] = "IEEE802154",
	[37] = "CAIF",
	[38] = "ALG",
	[39] = "NFC",
	[40] = "VSOCK",
	[41] = "KCM",
	[42] = "QIPCRTR",
	[43] = "SMC",
	[44] = "XDP",
};
⬢[acme@toolbox perf]$

	Some of those files are used for building the tools, so that a
tarball generated from:

⬢[acme@toolbox perf]$ make help | grep perf
  perf-tar-src-pkg    - Build perf-5.13.0-rc4.tar source tarball
  perf-targz-src-pkg  - Build perf-5.13.0-rc4.tar.gz source tarball
  perf-tarbz2-src-pkg - Build perf-5.13.0-rc4.tar.bz2 source tarball
  perf-tarxz-src-pkg  - Build perf-5.13.0-rc4.tar.xz source tarball
⬢[acme@toolbox perf]$

will build in older systems where things added to the updated copy of
the kernel headers isn't present, so trying to update the file and then
rebuild perf, only warning me if it doesn't build would give me an early
warning about things that are breaking and that I should look sooner
rather than later.

	Doing just the diff is not that useful :-)

- Arnaldo

One more output that is x86 specific and allows this to work:

      # perf trace -e msr:* --filter="msr!=FS_BASE && msr != IA32_TSC_DEADLINE && msr != 0x830 && msr != 0x83f && msr !=IA32_SPEC_CTRL" --filter-pids 3750
         0.000 Timer/5033 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
         0.009 Timer/5033 msr:write_msr(msr: LSTAR, val: -1398800368)
         0.010 Timer/5033 msr:write_msr(msr: TSC_AUX, val: 4)
         0.050 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
        45.661 gnome-terminal/12595 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
        45.672 gnome-terminal/12595 msr:write_msr(msr: LSTAR, val: -1398800368)
        45.675 gnome-terminal/12595 msr:write_msr(msr: TSC_AUX, val: 3)
        54.852 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
       130.508 Timer/4050 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
       130.527 Timer/4050 msr:write_msr(msr: LSTAR, val: -1398800368)
       130.531 Timer/4050 msr:write_msr(msr: TSC_AUX, val: 3)
       140.924 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
       164.738 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
       603.578 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
       620.809 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
       690.115 JS Watchdog/4259 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
       690.136 JS Watchdog/4259 msr:write_msr(msr: LSTAR, val: -1398800368)
       690.141 JS Watchdog/4259 msr:write_msr(msr: TSC_AUX, val: 3)
       690.186 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
       759.016 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
    ^C[root@quaco ~]#
    
    Or look at the first 3 write_msr events for that IA32_TSC_DEADLINE to learn why
    it happens so often:
    
      # perf trace --max-events=3 --max-stack=8 -e msr:* --filter="msr==IA32_TSC_DEADLINE" --filter-pids 3750
         0.000 :0/0 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 19296732550862)
                                           do_trace_write_msr ([kernel.kallsyms])
                                           do_trace_write_msr ([kernel.kallsyms])
                                           lapic_next_deadline ([kernel.kallsyms])
                                           clockevents_program_event ([kernel.kallsyms])
                                           hrtimer_interrupt ([kernel.kallsyms])
                                           smp_apic_timer_interrupt ([kernel.kallsyms])
                                           apic_timer_interrupt ([kernel.kallsyms])
                                           cpuidle_enter_state ([kernel.kallsyms])
        32.646 :0/0 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 19296800134158)
                                           do_trace_write_msr ([kernel.kallsyms])
                                           do_trace_write_msr ([kernel.kallsyms])
                                           lapic_next_deadline ([kernel.kallsyms])
                                           clockevents_program_event ([kernel.kallsyms])
                                           hrtimer_start_range_ns ([kernel.kallsyms])
                                           tick_nohz_restart_sched_tick ([kernel.kallsyms])
                                           tick_nohz_idle_exit ([kernel.kallsyms])
                                           do_idle ([kernel.kallsyms])
        32.802 :0/0 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 19297507436922)
                                           do_trace_write_msr ([kernel.kallsyms])
                                           do_trace_write_msr ([kernel.kallsyms])
                                           lapic_next_deadline ([kernel.kallsyms])
                                           clockevents_program_event ([kernel.kallsyms])
                                           hrtimer_try_to_cancel ([kernel.kallsyms])
                                           hrtimer_cancel ([kernel.kallsyms])
                                           tick_nohz_restart_sched_tick ([kernel.kallsyms])
                                           tick_nohz_idle_exit ([kernel.kallsyms])
      #



⬢[acme@toolbox perf]$ tools/perf/trace/beauty/tracepoints/x86_msr.sh 
static const char *x86_MSRs[] = {
	[0x00000000] = "IA32_P5_MC_ADDR",
	[0x00000001] = "IA32_P5_MC_TYPE",
	[0x00000010] = "IA32_TSC",
	[0x00000017] = "IA32_PLATFORM_ID",
	[0x0000001b] = "IA32_APICBASE",
	[0x00000020] = "KNC_PERFCTR0",
	[0x00000021] = "KNC_PERFCTR1",
	[0x00000028] = "KNC_EVNTSEL0",
	[0x00000029] = "KNC_EVNTSEL1",
	[0x0000002a] = "IA32_EBL_CR_POWERON",
	[0x0000002c] = "EBC_FREQUENCY_ID",
	[0x00000033] = "TEST_CTRL",
	[0x00000034] = "SMI_COUNT",
	[0x0000003a] = "IA32_FEAT_CTL",
	[0x0000003b] = "IA32_TSC_ADJUST",
	[0x00000040] = "LBR_CORE_FROM",
	[0x00000048] = "IA32_SPEC_CTRL",
	[0x00000049] = "IA32_PRED_CMD",
	[0x0000004e] = "PPIN_CTL",
	[0x0000004f] = "PPIN",
	[0x00000060] = "LBR_CORE_TO",
	[0x00000079] = "IA32_UCODE_WRITE",
	[0x0000008b] = "AMD64_PATCH_LEVEL",
	[0x0000008C] = "IA32_SGXLEPUBKEYHASH0",
	[0x0000008D] = "IA32_SGXLEPUBKEYHASH1",
	[0x0000008E] = "IA32_SGXLEPUBKEYHASH2",
	[0x0000008F] = "IA32_SGXLEPUBKEYHASH3",
	[0x0000009b] = "IA32_SMM_MONITOR_CTL",
	[0x0000009e] = "IA32_SMBASE",
	[0x000000c1] = "IA32_PERFCTR0",
	[0x000000c2] = "IA32_PERFCTR1",
	[0x000000cd] = "FSB_FREQ",
	[0x000000ce] = "PLATFORM_INFO",
	[0x000000cf] = "IA32_CORE_CAPS",
	[0x000000e2] = "PKG_CST_CONFIG_CONTROL",
	[0x000000e7] = "IA32_MPERF",
	[0x000000e8] = "IA32_APERF",
	[0x000000fe] = "MTRRcap",
	[0x00000107] = "IDT_FCR1",
	[0x00000108] = "IDT_FCR2",
	[0x00000109] = "IDT_FCR3",
	[0x0000010a] = "IA32_ARCH_CAPABILITIES",
	[0x0000010b] = "IA32_FLUSH_CMD",
	[0x0000010F] = "TSX_FORCE_ABORT",
	[0x00000110] = "IDT_MCR0",
	[0x00000111] = "IDT_MCR1",
	[0x00000112] = "IDT_MCR2",
	[0x00000113] = "IDT_MCR3",
	[0x00000114] = "IDT_MCR4",
	[0x00000115] = "IDT_MCR5",
	[0x00000116] = "IDT_MCR6",
	[0x00000117] = "IDT_MCR7",
	[0x00000119] = "IA32_BBL_CR_CTL",
	[0x0000011e] = "IA32_BBL_CR_CTL3",
	[0x00000120] = "IDT_MCR_CTRL",
	[0x00000122] = "IA32_TSX_CTRL",
	[0x00000123] = "IA32_MCU_OPT_CTRL",
	[0x00000140] = "MISC_FEATURES_ENABLES",
	[0x00000174] = "IA32_SYSENTER_CS",
	[0x00000175] = "IA32_SYSENTER_ESP",
	[0x00000176] = "IA32_SYSENTER_EIP",
	[0x00000179] = "IA32_MCG_CAP",
	[0x0000017a] = "IA32_MCG_STATUS",
	[0x0000017b] = "IA32_MCG_CTL",
	[0x0000017f] = "ERROR_CONTROL",
	[0x00000180] = "IA32_MCG_EAX",
	[0x00000181] = "IA32_MCG_EBX",
	[0x00000182] = "IA32_MCG_ECX",
	[0x00000183] = "IA32_MCG_EDX",
	[0x00000184] = "IA32_MCG_ESI",
	[0x00000185] = "IA32_MCG_EDI",
	[0x00000186] = "IA32_MCG_EBP",
	[0x00000187] = "IA32_MCG_ESP",
	[0x00000188] = "IA32_MCG_EFLAGS",
	[0x00000189] = "IA32_MCG_EIP",
	[0x0000018a] = "IA32_MCG_RESERVED",
	[0x00000198] = "IA32_PERF_STATUS",
	[0x00000199] = "IA32_PERF_CTL",
	[0x0000019a] = "IA32_THERM_CONTROL",
	[0x0000019b] = "IA32_THERM_INTERRUPT",
	[0x0000019c] = "IA32_THERM_STATUS",
	[0x0000019d] = "THERM2_CTL",
	[0x000001a0] = "IA32_MISC_ENABLE",
	[0x000001a2] = "IA32_TEMPERATURE_TARGET",
	[0x000001a4] = "MISC_FEATURE_CONTROL",
	[0x000001a6] = "OFFCORE_RSP_0",
	[0x000001a7] = "OFFCORE_RSP_1",
	[0x000001aa] = "MISC_PWR_MGMT",
	[0x000001ad] = "TURBO_RATIO_LIMIT",
	[0x000001ae] = "TURBO_RATIO_LIMIT1",
	[0x000001af] = "TURBO_RATIO_LIMIT2",
	[0x000001b0] = "IA32_ENERGY_PERF_BIAS",
	[0x000001b1] = "IA32_PACKAGE_THERM_STATUS",
	[0x000001b2] = "IA32_PACKAGE_THERM_INTERRUPT",
	[0x000001c8] = "LBR_SELECT",
	[0x000001c9] = "LBR_TOS",
	[0x000001d9] = "IA32_DEBUGCTLMSR",
	[0x000001db] = "IA32_LASTBRANCHFROMIP",
	[0x000001dc] = "IA32_LASTBRANCHTOIP",
	[0x000001dd] = "IA32_LASTINTFROMIP",
	[0x000001de] = "IA32_LASTINTTOIP",
	[0x000001fc] = "IA32_POWER_CTL",
	[0x00000250] = "MTRRfix64K_00000",
	[0x00000258] = "MTRRfix16K_80000",
	[0x00000259] = "MTRRfix16K_A0000",
	[0x00000268] = "MTRRfix4K_C0000",
	[0x00000269] = "MTRRfix4K_C8000",
	[0x0000026a] = "MTRRfix4K_D0000",
	[0x0000026b] = "MTRRfix4K_D8000",
	[0x0000026c] = "MTRRfix4K_E0000",
	[0x0000026d] = "MTRRfix4K_E8000",
	[0x0000026e] = "MTRRfix4K_F0000",
	[0x0000026f] = "MTRRfix4K_F8000",
	[0x00000277] = "IA32_CR_PAT",
	[0x00000280] = "IA32_MC0_CTL2",
	[0x000002ff] = "MTRRdefType",
	[0x00000309] = "CORE_PERF_FIXED_CTR0",
	[0x0000030a] = "CORE_PERF_FIXED_CTR1",
	[0x0000030b] = "CORE_PERF_FIXED_CTR2",
	[0x0000030c] = "CORE_PERF_FIXED_CTR3",
	[0x00000329] = "PERF_METRICS",
	[0x00000345] = "IA32_PERF_CAPABILITIES",
	[0x0000038d] = "CORE_PERF_FIXED_CTR_CTRL",
	[0x0000038e] = "CORE_PERF_GLOBAL_STATUS",
	[0x0000038f] = "CORE_PERF_GLOBAL_CTRL",
	[0x00000390] = "CORE_PERF_GLOBAL_OVF_CTRL",
	[0x000003f1] = "IA32_PEBS_ENABLE",
	[0x000003f2] = "PEBS_DATA_CFG",
	[0x000003f6] = "PEBS_LD_LAT_THRESHOLD",
	[0x000003f7] = "PEBS_FRONTEND",
	[0x000003f8] = "PKG_C3_RESIDENCY",
	[0x000003f9] = "PKG_C6_RESIDENCY",
	[0x000003fa] = "PKG_C7_RESIDENCY",
	[0x000003fc] = "CORE_C3_RESIDENCY",
	[0x000003fd] = "CORE_C6_RESIDENCY",
	[0x000003fe] = "CORE_C7_RESIDENCY",
	[0x000003ff] = "KNL_CORE_C6_RESIDENCY",
	[0x00000400] = "IA32_MC0_CTL",
	[0x00000401] = "IA32_MC0_STATUS",
	[0x00000402] = "IA32_MC0_ADDR",
	[0x00000403] = "IA32_MC0_MISC",
	[0x00000480] = "IA32_VMX_BASIC",
	[0x00000481] = "IA32_VMX_PINBASED_CTLS",
	[0x00000482] = "IA32_VMX_PROCBASED_CTLS",
	[0x00000483] = "IA32_VMX_EXIT_CTLS",
	[0x00000484] = "IA32_VMX_ENTRY_CTLS",
	[0x00000485] = "IA32_VMX_MISC",
	[0x00000486] = "IA32_VMX_CR0_FIXED0",
	[0x00000487] = "IA32_VMX_CR0_FIXED1",
	[0x00000488] = "IA32_VMX_CR4_FIXED0",
	[0x00000489] = "IA32_VMX_CR4_FIXED1",
	[0x0000048a] = "IA32_VMX_VMCS_ENUM",
	[0x0000048b] = "IA32_VMX_PROCBASED_CTLS2",
	[0x0000048c] = "IA32_VMX_EPT_VPID_CAP",
	[0x0000048d] = "IA32_VMX_TRUE_PINBASED_CTLS",
	[0x0000048e] = "IA32_VMX_TRUE_PROCBASED_CTLS",
	[0x0000048f] = "IA32_VMX_TRUE_EXIT_CTLS",
	[0x00000490] = "IA32_VMX_TRUE_ENTRY_CTLS",
	[0x00000491] = "IA32_VMX_VMFUNC",
	[0x000004c1] = "IA32_PMC0",
	[0x000004d0] = "IA32_MCG_EXT_CTL",
	[0x00000560] = "IA32_RTIT_OUTPUT_BASE",
	[0x00000561] = "IA32_RTIT_OUTPUT_MASK",
	[0x00000570] = "IA32_RTIT_CTL",
	[0x00000571] = "IA32_RTIT_STATUS",
	[0x00000572] = "IA32_RTIT_CR3_MATCH",
	[0x00000580] = "IA32_RTIT_ADDR0_A",
	[0x00000581] = "IA32_RTIT_ADDR0_B",
	[0x00000582] = "IA32_RTIT_ADDR1_A",
	[0x00000583] = "IA32_RTIT_ADDR1_B",
	[0x00000584] = "IA32_RTIT_ADDR2_A",
	[0x00000585] = "IA32_RTIT_ADDR2_B",
	[0x00000586] = "IA32_RTIT_ADDR3_A",
	[0x00000587] = "IA32_RTIT_ADDR3_B",
	[0x00000600] = "IA32_DS_AREA",
	[0x00000606] = "RAPL_POWER_UNIT",
	[0x0000060a] = "PKGC3_IRTL",
	[0x0000060b] = "PKGC6_IRTL",
	[0x0000060c] = "PKGC7_IRTL",
	[0x0000060d] = "PKG_C2_RESIDENCY",
	[0x00000610] = "PKG_POWER_LIMIT",
	[0x00000611] = "PKG_ENERGY_STATUS",
	[0x00000613] = "PKG_PERF_STATUS",
	[0x00000614] = "PKG_POWER_INFO",
	[0x00000618] = "DRAM_POWER_LIMIT",
	[0x00000619] = "DRAM_ENERGY_STATUS",
	[0x0000061b] = "DRAM_PERF_STATUS",
	[0x0000061c] = "DRAM_POWER_INFO",
	[0x00000630] = "PKG_C8_RESIDENCY",
	[0x00000631] = "PKG_C9_RESIDENCY",
	[0x00000632] = "PKG_C10_RESIDENCY",
	[0x00000633] = "PKGC8_IRTL",
	[0x00000634] = "PKGC9_IRTL",
	[0x00000635] = "PKGC10_IRTL",
	[0x00000638] = "PP0_POWER_LIMIT",
	[0x00000639] = "PP0_ENERGY_STATUS",
	[0x0000063a] = "PP0_POLICY",
	[0x0000063b] = "PP0_PERF_STATUS",
	[0x00000640] = "PP1_POWER_LIMIT",
	[0x00000641] = "PP1_ENERGY_STATUS",
	[0x00000642] = "PP1_POLICY",
	[0x00000648] = "CONFIG_TDP_NOMINAL",
	[0x00000649] = "CONFIG_TDP_LEVEL_1",
	[0x0000064A] = "CONFIG_TDP_LEVEL_2",
	[0x0000064B] = "CONFIG_TDP_CONTROL",
	[0x0000064C] = "TURBO_ACTIVATION_RATIO",
	[0x0000064D] = "PLATFORM_ENERGY_STATUS",
	[0x0000064e] = "PPERF",
	[0x0000064f] = "PERF_LIMIT_REASONS",
	[0x00000658] = "PKG_WEIGHTED_CORE_C0_RES",
	[0x00000659] = "PKG_ANY_CORE_C0_RES",
	[0x0000065A] = "PKG_ANY_GFXE_C0_RES",
	[0x0000065B] = "PKG_BOTH_CORE_GFXE_C0_RES",
	[0x00000660] = "CORE_C1_RES",
	[0x00000664] = "MODULE_C6_RES_MS",
	[0x00000668] = "CC6_DEMOTION_POLICY_CONFIG",
	[0x00000669] = "MC6_DEMOTION_POLICY_CONFIG",
	[0x00000680] = "LBR_NHM_FROM",
	[0x00000690] = "CORE_PERF_LIMIT_REASONS",
	[0x000006B0] = "GFX_PERF_LIMIT_REASONS",
	[0x000006B1] = "RING_PERF_LIMIT_REASONS",
	[0x000006c0] = "LBR_NHM_TO",
	[0x00000770] = "PM_ENABLE",
	[0x00000771] = "HWP_CAPABILITIES",
	[0x00000772] = "HWP_REQUEST_PKG",
	[0x00000773] = "HWP_INTERRUPT",
	[0x00000774] = "HWP_REQUEST",
	[0x00000777] = "HWP_STATUS",
	[0x00000d90] = "IA32_BNDCFGS",
	[0x00000d93] = "IA32_PASID",
	[0x00000da0] = "IA32_XSS",
	[0x00000dc0] = "LBR_INFO_0",
	[0x00000ffc] = "IA32_BNDCFGS_RSVD",
};

#define x86_64_specific_MSRs_offset 0xc0000080
static const char *x86_64_specific_MSRs[] = {
	[0xc0000080 - x86_64_specific_MSRs_offset] = "EFER",
	[0xc0000081 - x86_64_specific_MSRs_offset] = "STAR",
	[0xc0000082 - x86_64_specific_MSRs_offset] = "LSTAR",
	[0xc0000083 - x86_64_specific_MSRs_offset] = "CSTAR",
	[0xc0000084 - x86_64_specific_MSRs_offset] = "SYSCALL_MASK",
	[0xc0000085 - x86_64_specific_MSRs_offset] = "K6_UWCCR",
	[0xc0000086 - x86_64_specific_MSRs_offset] = "K6_EPMR",
	[0xc0000087 - x86_64_specific_MSRs_offset] = "K6_PSOR",
	[0xc0000088 - x86_64_specific_MSRs_offset] = "K6_PFIR",
	[0xc00000e9 - x86_64_specific_MSRs_offset] = "F17H_IRPERF",
	[0xc0000100 - x86_64_specific_MSRs_offset] = "FS_BASE",
	[0xc0000101 - x86_64_specific_MSRs_offset] = "GS_BASE",
	[0xc0000102 - x86_64_specific_MSRs_offset] = "KERNEL_GS_BASE",
	[0xc0000103 - x86_64_specific_MSRs_offset] = "TSC_AUX",
	[0xc0000104 - x86_64_specific_MSRs_offset] = "AMD64_TSC_RATIO",
};

#define x86_AMD_V_KVM_MSRs_offset 0xc0010000
static const char *x86_AMD_V_KVM_MSRs[] = {
	[0xc0010000 - x86_AMD_V_KVM_MSRs_offset] = "K7_EVNTSEL0",
	[0xc0010001 - x86_AMD_V_KVM_MSRs_offset] = "K7_EVNTSEL1",
	[0xc0010002 - x86_AMD_V_KVM_MSRs_offset] = "K7_EVNTSEL2",
	[0xc0010003 - x86_AMD_V_KVM_MSRs_offset] = "K7_EVNTSEL3",
	[0xc0010004 - x86_AMD_V_KVM_MSRs_offset] = "K7_PERFCTR0",
	[0xc0010005 - x86_AMD_V_KVM_MSRs_offset] = "K7_PERFCTR1",
	[0xc0010006 - x86_AMD_V_KVM_MSRs_offset] = "K7_PERFCTR2",
	[0xc0010007 - x86_AMD_V_KVM_MSRs_offset] = "K7_PERFCTR3",
	[0xc0010010 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_SYSCFG",
	[0xc0010015 - x86_AMD_V_KVM_MSRs_offset] = "K7_HWCR",
	[0xc001001a - x86_AMD_V_KVM_MSRs_offset] = "K8_TOP_MEM1",
	[0xc001001b - x86_AMD_V_KVM_MSRs_offset] = "K7_CLK_CTL",
	[0xc001001d - x86_AMD_V_KVM_MSRs_offset] = "K8_TOP_MEM2",
	[0xc001001f - x86_AMD_V_KVM_MSRs_offset] = "AMD64_NB_CFG",
	[0xc0010020 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_PATCH_LOADER",
	[0xc0010041 - x86_AMD_V_KVM_MSRs_offset] = "K7_FID_VID_CTL",
	[0xc0010042 - x86_AMD_V_KVM_MSRs_offset] = "K7_FID_VID_STATUS",
	[0xc0010044 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_MC0_MASK",
	[0xc0010055 - x86_AMD_V_KVM_MSRs_offset] = "K8_INT_PENDING_MSG",
	[0xc0010058 - x86_AMD_V_KVM_MSRs_offset] = "FAM10H_MMIO_CONF_BASE",
	[0xc0010062 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PERF_CTL",
	[0xc0010063 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PERF_STATUS",
	[0xc0010064 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PSTATE_DEF_BASE",
	[0xc001007a - x86_AMD_V_KVM_MSRs_offset] = "F15H_CU_PWR_ACCUMULATOR",
	[0xc001007b - x86_AMD_V_KVM_MSRs_offset] = "F15H_CU_MAX_PWR_ACCUMULATOR",
	[0xc0010112 - x86_AMD_V_KVM_MSRs_offset] = "K8_TSEG_ADDR",
	[0xc0010113 - x86_AMD_V_KVM_MSRs_offset] = "K8_TSEG_MASK",
	[0xc0010114 - x86_AMD_V_KVM_MSRs_offset] = "VM_CR",
	[0xc0010115 - x86_AMD_V_KVM_MSRs_offset] = "VM_IGNNE",
	[0xc0010117 - x86_AMD_V_KVM_MSRs_offset] = "VM_HSAVE_PA",
	[0xc001011e - x86_AMD_V_KVM_MSRs_offset] = "AMD64_VM_PAGE_FLUSH",
	[0xc001011f - x86_AMD_V_KVM_MSRs_offset] = "AMD64_VIRT_SPEC_CTRL",
	[0xc0010130 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_SEV_ES_GHCB",
	[0xc0010131 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_SEV",
	[0xc0010140 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_OSVW_ID_LENGTH",
	[0xc0010141 - x86_AMD_V_KVM_MSRs_offset] = "AMD64_OSVW_STATUS",
	[0xc0010200 - x86_AMD_V_KVM_MSRs_offset] = "F15H_PERF_CTL",
	[0xc0010201 - x86_AMD_V_KVM_MSRs_offset] = "F15H_PERF_CTR",
	[0xc0010230 - x86_AMD_V_KVM_MSRs_offset] = "F16H_L2I_PERF_CTL",
	[0xc0010231 - x86_AMD_V_KVM_MSRs_offset] = "F16H_L2I_PERF_CTR",
	[0xc0010240 - x86_AMD_V_KVM_MSRs_offset] = "F15H_NB_PERF_CTL",
	[0xc0010241 - x86_AMD_V_KVM_MSRs_offset] = "F15H_NB_PERF_CTR",
	[0xc0010280 - x86_AMD_V_KVM_MSRs_offset] = "F15H_PTSC",
	[0xc0010299 - x86_AMD_V_KVM_MSRs_offset] = "AMD_RAPL_POWER_UNIT",
	[0xc001029a - x86_AMD_V_KVM_MSRs_offset] = "AMD_CORE_ENERGY_STATUS",
	[0xc001029b - x86_AMD_V_KVM_MSRs_offset] = "AMD_PKG_ENERGY_STATUS",
	[0xc00102f0 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN_CTL",
	[0xc00102f1 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN",
};
⬢[acme@toolbox perf]$

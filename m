Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC883FFECD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348334AbhICLQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:16:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:51668 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231486AbhICLQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:16:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="219094550"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="gz'50?scan'50,208,50";a="219094550"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 04:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="gz'50?scan'50,208,50";a="692100458"
Received: from lkp-server01.sh.intel.com (HELO 2115029a3e5c) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2021 04:15:46 -0700
Received: from kbuild by 2115029a3e5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mM7Af-0000Nm-Ic; Fri, 03 Sep 2021 11:15:45 +0000
Date:   Fri, 3 Sep 2021 19:15:16 +0800
From:   kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: arch/arm64/kvm/va_layout.c:188:6: warning: no previous prototype for
 'kvm_patch_vector_branch'
Message-ID: <202109031902.1EDVl0VH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a9c9a6f741cdaa2fa9ba24a790db8d07295761e3
commit: 63b3f96e1a989846a5a521d4fbef4bc86406929d kvm: Select SCHED_INFO instead of TASK_DELAY_ACCT
date:   4 months ago
config: arm64-buildonly-randconfig-r006-20210902 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63b3f96e1a989846a5a521d4fbef4bc86406929d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 63b3f96e1a989846a5a521d4fbef4bc86406929d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/va_layout.c:188:6: warning: no previous prototype for 'kvm_patch_vector_branch' [-Wmissing-prototypes]
     188 | void kvm_patch_vector_branch(struct alt_instr *alt,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kvm/va_layout.c:286:6: warning: no previous prototype for 'kvm_get_kimage_voffset' [-Wmissing-prototypes]
     286 | void kvm_get_kimage_voffset(struct alt_instr *alt,
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kvm/va_layout.c:292:6: warning: no previous prototype for 'kvm_compute_final_ctr_el0' [-Wmissing-prototypes]
     292 | void kvm_compute_final_ctr_el0(struct alt_instr *alt,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
--
>> arch/arm64/kvm/handle_exit.c:177:35: warning: initialized field overwritten [-Woverride-init]
     177 |         [ESR_ELx_EC_WFx]        = kvm_handle_wfx,
         |                                   ^~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:177:35: note: (near initialization for 'arm_exit_handlers[1]')
   arch/arm64/kvm/handle_exit.c:178:35: warning: initialized field overwritten [-Woverride-init]
     178 |         [ESR_ELx_EC_CP15_32]    = kvm_handle_cp15_32,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:178:35: note: (near initialization for 'arm_exit_handlers[3]')
   arch/arm64/kvm/handle_exit.c:179:35: warning: initialized field overwritten [-Woverride-init]
     179 |         [ESR_ELx_EC_CP15_64]    = kvm_handle_cp15_64,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:179:35: note: (near initialization for 'arm_exit_handlers[4]')
   arch/arm64/kvm/handle_exit.c:180:35: warning: initialized field overwritten [-Woverride-init]
     180 |         [ESR_ELx_EC_CP14_MR]    = kvm_handle_cp14_32,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:180:35: note: (near initialization for 'arm_exit_handlers[5]')
   arch/arm64/kvm/handle_exit.c:181:35: warning: initialized field overwritten [-Woverride-init]
     181 |         [ESR_ELx_EC_CP14_LS]    = kvm_handle_cp14_load_store,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:181:35: note: (near initialization for 'arm_exit_handlers[6]')
   arch/arm64/kvm/handle_exit.c:182:35: warning: initialized field overwritten [-Woverride-init]
     182 |         [ESR_ELx_EC_CP14_64]    = kvm_handle_cp14_64,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:182:35: note: (near initialization for 'arm_exit_handlers[12]')
   arch/arm64/kvm/handle_exit.c:183:35: warning: initialized field overwritten [-Woverride-init]
     183 |         [ESR_ELx_EC_HVC32]      = handle_hvc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:183:35: note: (near initialization for 'arm_exit_handlers[18]')
   arch/arm64/kvm/handle_exit.c:184:35: warning: initialized field overwritten [-Woverride-init]
     184 |         [ESR_ELx_EC_SMC32]      = handle_smc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:184:35: note: (near initialization for 'arm_exit_handlers[19]')
   arch/arm64/kvm/handle_exit.c:185:35: warning: initialized field overwritten [-Woverride-init]
     185 |         [ESR_ELx_EC_HVC64]      = handle_hvc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:185:35: note: (near initialization for 'arm_exit_handlers[22]')
   arch/arm64/kvm/handle_exit.c:186:35: warning: initialized field overwritten [-Woverride-init]
     186 |         [ESR_ELx_EC_SMC64]      = handle_smc,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:186:35: note: (near initialization for 'arm_exit_handlers[23]')
   arch/arm64/kvm/handle_exit.c:187:35: warning: initialized field overwritten [-Woverride-init]
     187 |         [ESR_ELx_EC_SYS64]      = kvm_handle_sys_reg,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:187:35: note: (near initialization for 'arm_exit_handlers[24]')
   arch/arm64/kvm/handle_exit.c:188:35: warning: initialized field overwritten [-Woverride-init]
     188 |         [ESR_ELx_EC_SVE]        = handle_sve,
         |                                   ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:188:35: note: (near initialization for 'arm_exit_handlers[25]')
   arch/arm64/kvm/handle_exit.c:189:35: warning: initialized field overwritten [-Woverride-init]
     189 |         [ESR_ELx_EC_IABT_LOW]   = kvm_handle_guest_abort,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:189:35: note: (near initialization for 'arm_exit_handlers[32]')
   arch/arm64/kvm/handle_exit.c:190:35: warning: initialized field overwritten [-Woverride-init]
     190 |         [ESR_ELx_EC_DABT_LOW]   = kvm_handle_guest_abort,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:190:35: note: (near initialization for 'arm_exit_handlers[36]')
   arch/arm64/kvm/handle_exit.c:191:35: warning: initialized field overwritten [-Woverride-init]
     191 |         [ESR_ELx_EC_SOFTSTP_LOW]= kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:191:35: note: (near initialization for 'arm_exit_handlers[50]')
   arch/arm64/kvm/handle_exit.c:192:35: warning: initialized field overwritten [-Woverride-init]
     192 |         [ESR_ELx_EC_WATCHPT_LOW]= kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:192:35: note: (near initialization for 'arm_exit_handlers[52]')
   arch/arm64/kvm/handle_exit.c:193:35: warning: initialized field overwritten [-Woverride-init]
     193 |         [ESR_ELx_EC_BREAKPT_LOW]= kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:193:35: note: (near initialization for 'arm_exit_handlers[48]')
   arch/arm64/kvm/handle_exit.c:194:35: warning: initialized field overwritten [-Woverride-init]
     194 |         [ESR_ELx_EC_BKPT32]     = kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:194:35: note: (near initialization for 'arm_exit_handlers[56]')
   arch/arm64/kvm/handle_exit.c:195:35: warning: initialized field overwritten [-Woverride-init]
     195 |         [ESR_ELx_EC_BRK64]      = kvm_handle_guest_debug,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:195:35: note: (near initialization for 'arm_exit_handlers[60]')
   arch/arm64/kvm/handle_exit.c:196:35: warning: initialized field overwritten [-Woverride-init]
     196 |         [ESR_ELx_EC_FP_ASIMD]   = handle_no_fpsimd,
         |                                   ^~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:196:35: note: (near initialization for 'arm_exit_handlers[7]')
   arch/arm64/kvm/handle_exit.c:197:35: warning: initialized field overwritten [-Woverride-init]
     197 |         [ESR_ELx_EC_PAC]        = kvm_handle_ptrauth,
         |                                   ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:197:35: note: (near initialization for 'arm_exit_handlers[9]')
>> arch/arm64/kvm/handle_exit.c:295:24: warning: no previous prototype for 'nvhe_hyp_panic_handler' [-Wmissing-prototypes]
     295 | void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr, u64 elr,
         |                        ^~~~~~~~~~~~~~~~~~~~~~
--
>> arch/arm64/kvm/sys_regs.c:1564:20: warning: initialized field overwritten [-Woverride-init]
    1564 |           .reset = reset_pmcr, .reg = PMCR_EL0 },
         |                    ^~~~~~~~~~
   arch/arm64/kvm/sys_regs.c:1564:20: note: (near initialization for 'sys_reg_descs[216].reset')
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:71,
                    from include/linux/compiler.h:248,
                    from include/linux/build_bug.h:5,
                    from include/linux/bitfield.h:10,
                    from arch/arm64/kvm/sys_regs.c:12:
>> include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1576:45: note: in expansion of macro 'NULL'
    1576 |           .access = access_pmceid, .reset = NULL },
         |                                             ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[222].reset')
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1576:45: note: in expansion of macro 'NULL'
    1576 |           .access = access_pmceid, .reset = NULL },
         |                                             ^~~~
>> include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1578:45: note: in expansion of macro 'NULL'
    1578 |           .access = access_pmceid, .reset = NULL },
         |                                             ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[223].reset')
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1578:45: note: in expansion of macro 'NULL'
    1578 |           .access = access_pmceid, .reset = NULL },
         |                                             ^~~~
>> include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1582:50: note: in expansion of macro 'NULL'
    1582 |           .access = access_pmu_evtyper, .reset = NULL },
         |                                                  ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[225].reset')
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1582:50: note: in expansion of macro 'NULL'
    1582 |           .access = access_pmu_evtyper, .reset = NULL },
         |                                                  ^~~~
>> include/linux/stddef.h:8:14: warning: initialized field overwritten [-Woverride-init]
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1584:49: note: in expansion of macro 'NULL'
    1584 |           .access = access_pmu_evcntr, .reset = NULL },
         |                                                 ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'sys_reg_descs[226].reset')
       8 | #define NULL ((void *)0)
         |              ^
   arch/arm64/kvm/sys_regs.c:1584:49: note: in expansion of macro 'NULL'
    1584 |           .access = access_pmu_evcntr, .reset = NULL },
         |                                                 ^~~~
   arch/arm64/kvm/sys_regs.c:1590:20: warning: initialized field overwritten [-Woverride-init]
    1590 |           .reset = reset_val, .reg = PMUSERENR_EL0, .val = 0 },
         |                    ^~~~~~~~~
   arch/arm64/kvm/sys_regs.c:1590:20: note: (near initialization for 'sys_reg_descs[227].reset')
   arch/arm64/kvm/sys_regs.c:1745:20: warning: initialized field overwritten [-Woverride-init]
    1745 |           .reset = reset_val, .reg = PMCCFILTR_EL0, .val = 0 },
         |                    ^~~~~~~~~
   arch/arm64/kvm/sys_regs.c:1745:20: note: (near initialization for 'sys_reg_descs[369].reset')
--
>> arch/arm64/kvm/hyp/vhe/switch.c:215:17: warning: no previous prototype for 'hyp_panic' [-Wmissing-prototypes]
     215 | void __noreturn hyp_panic(void)
         |                 ^~~~~~~~~
>> arch/arm64/kvm/hyp/vhe/switch.c:225:17: warning: no previous prototype for 'kvm_unexpected_el2_exception' [-Wmissing-prototypes]
     225 | asmlinkage void kvm_unexpected_el2_exception(void)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> arch/arm64/kvm/hyp/nvhe/switch.c:264:17: warning: no previous prototype for 'hyp_panic' [-Wmissing-prototypes]
     264 | void __noreturn hyp_panic(void)
         |                 ^~~~~~~~~
>> arch/arm64/kvm/hyp/nvhe/switch.c:286:17: warning: no previous prototype for 'kvm_unexpected_el2_exception' [-Wmissing-prototypes]
     286 | asmlinkage void kvm_unexpected_el2_exception(void)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> arch/arm64/kvm/hyp/nvhe/hyp-main.c:233:6: warning: no previous prototype for 'handle_trap' [-Wmissing-prototypes]
     233 | void handle_trap(struct kvm_cpu_context *host_ctxt)
         |      ^~~~~~~~~~~
--
>> arch/arm64/kvm/hyp/nvhe/psci-relay.c:203:28: warning: no previous prototype for 'kvm_host_psci_cpu_entry' [-Wmissing-prototypes]
     203 | asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
--
>> arch/arm64/kvm/hyp/nvhe/setup.c:146:17: warning: no previous prototype for '__pkvm_init_finalise' [-Wmissing-prototypes]
     146 | void __noreturn __pkvm_init_finalise(void)
         |                 ^~~~~~~~~~~~~~~~~~~~


vim +/kvm_patch_vector_branch +188 arch/arm64/kvm/va_layout.c

71dcb8be6d29cf Marc Zyngier  2018-02-27  187  
71dcb8be6d29cf Marc Zyngier  2018-02-27 @188  void kvm_patch_vector_branch(struct alt_instr *alt,
71dcb8be6d29cf Marc Zyngier  2018-02-27  189  			     __le32 *origptr, __le32 *updptr, int nr_inst)
71dcb8be6d29cf Marc Zyngier  2018-02-27  190  {
71dcb8be6d29cf Marc Zyngier  2018-02-27  191  	u64 addr;
71dcb8be6d29cf Marc Zyngier  2018-02-27  192  	u32 insn;
71dcb8be6d29cf Marc Zyngier  2018-02-27  193  
b881cdce77b48b Will Deacon   2020-11-13  194  	BUG_ON(nr_inst != 4);
71dcb8be6d29cf Marc Zyngier  2018-02-27  195  
c4792b6dbc5070 Will Deacon   2020-11-13  196  	if (!cpus_have_const_cap(ARM64_SPECTRE_V3A) || WARN_ON_ONCE(has_vhe()))
71dcb8be6d29cf Marc Zyngier  2018-02-27  197  		return;
71dcb8be6d29cf Marc Zyngier  2018-02-27  198  
71dcb8be6d29cf Marc Zyngier  2018-02-27  199  	/*
71dcb8be6d29cf Marc Zyngier  2018-02-27  200  	 * Compute HYP VA by using the same computation as kern_hyp_va()
71dcb8be6d29cf Marc Zyngier  2018-02-27  201  	 */
d084ecc5c72811 David Brazdil 2020-12-02  202  	addr = __early_kern_hyp_va((u64)kvm_ksym_ref(__kvm_hyp_vector));
71dcb8be6d29cf Marc Zyngier  2018-02-27  203  
71dcb8be6d29cf Marc Zyngier  2018-02-27  204  	/* Use PC[10:7] to branch to the same vector in KVM */
71dcb8be6d29cf Marc Zyngier  2018-02-27  205  	addr |= ((u64)origptr & GENMASK_ULL(10, 7));
71dcb8be6d29cf Marc Zyngier  2018-02-27  206  
71dcb8be6d29cf Marc Zyngier  2018-02-27  207  	/*
3dbf100b0b10e9 James Morse   2019-06-18  208  	 * Branch over the preamble in order to avoid the initial store on
3dbf100b0b10e9 James Morse   2019-06-18  209  	 * the stack (which we already perform in the hardening vectors).
71dcb8be6d29cf Marc Zyngier  2018-02-27  210  	 */
3dbf100b0b10e9 James Morse   2019-06-18  211  	addr += KVM_VECTOR_PREAMBLE;
71dcb8be6d29cf Marc Zyngier  2018-02-27  212  
71dcb8be6d29cf Marc Zyngier  2018-02-27  213  	/* movz x0, #(addr & 0xffff) */
71dcb8be6d29cf Marc Zyngier  2018-02-27  214  	insn = aarch64_insn_gen_movewide(AARCH64_INSN_REG_0,
71dcb8be6d29cf Marc Zyngier  2018-02-27  215  					 (u16)addr,
71dcb8be6d29cf Marc Zyngier  2018-02-27  216  					 0,
71dcb8be6d29cf Marc Zyngier  2018-02-27  217  					 AARCH64_INSN_VARIANT_64BIT,
71dcb8be6d29cf Marc Zyngier  2018-02-27  218  					 AARCH64_INSN_MOVEWIDE_ZERO);
71dcb8be6d29cf Marc Zyngier  2018-02-27  219  	*updptr++ = cpu_to_le32(insn);
71dcb8be6d29cf Marc Zyngier  2018-02-27  220  
71dcb8be6d29cf Marc Zyngier  2018-02-27  221  	/* movk x0, #((addr >> 16) & 0xffff), lsl #16 */
71dcb8be6d29cf Marc Zyngier  2018-02-27  222  	insn = aarch64_insn_gen_movewide(AARCH64_INSN_REG_0,
71dcb8be6d29cf Marc Zyngier  2018-02-27  223  					 (u16)(addr >> 16),
71dcb8be6d29cf Marc Zyngier  2018-02-27  224  					 16,
71dcb8be6d29cf Marc Zyngier  2018-02-27  225  					 AARCH64_INSN_VARIANT_64BIT,
71dcb8be6d29cf Marc Zyngier  2018-02-27  226  					 AARCH64_INSN_MOVEWIDE_KEEP);
71dcb8be6d29cf Marc Zyngier  2018-02-27  227  	*updptr++ = cpu_to_le32(insn);
71dcb8be6d29cf Marc Zyngier  2018-02-27  228  
71dcb8be6d29cf Marc Zyngier  2018-02-27  229  	/* movk x0, #((addr >> 32) & 0xffff), lsl #32 */
71dcb8be6d29cf Marc Zyngier  2018-02-27  230  	insn = aarch64_insn_gen_movewide(AARCH64_INSN_REG_0,
71dcb8be6d29cf Marc Zyngier  2018-02-27  231  					 (u16)(addr >> 32),
71dcb8be6d29cf Marc Zyngier  2018-02-27  232  					 32,
71dcb8be6d29cf Marc Zyngier  2018-02-27  233  					 AARCH64_INSN_VARIANT_64BIT,
71dcb8be6d29cf Marc Zyngier  2018-02-27  234  					 AARCH64_INSN_MOVEWIDE_KEEP);
71dcb8be6d29cf Marc Zyngier  2018-02-27  235  	*updptr++ = cpu_to_le32(insn);
71dcb8be6d29cf Marc Zyngier  2018-02-27  236  
71dcb8be6d29cf Marc Zyngier  2018-02-27  237  	/* br x0 */
71dcb8be6d29cf Marc Zyngier  2018-02-27  238  	insn = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_0,
71dcb8be6d29cf Marc Zyngier  2018-02-27  239  					   AARCH64_INSN_BRANCH_NOLINK);
71dcb8be6d29cf Marc Zyngier  2018-02-27  240  	*updptr++ = cpu_to_le32(insn);
71dcb8be6d29cf Marc Zyngier  2018-02-27  241  }
1db9d9ded77138 Marc Zyngier  2020-10-21  242  
1db9d9ded77138 Marc Zyngier  2020-10-21  243  static void generate_mov_q(u64 val, __le32 *origptr, __le32 *updptr, int nr_inst)
1db9d9ded77138 Marc Zyngier  2020-10-21  244  {
1db9d9ded77138 Marc Zyngier  2020-10-21  245  	u32 insn, oinsn, rd;
1db9d9ded77138 Marc Zyngier  2020-10-21  246  
1db9d9ded77138 Marc Zyngier  2020-10-21  247  	BUG_ON(nr_inst != 4);
1db9d9ded77138 Marc Zyngier  2020-10-21  248  
1db9d9ded77138 Marc Zyngier  2020-10-21  249  	/* Compute target register */
1db9d9ded77138 Marc Zyngier  2020-10-21  250  	oinsn = le32_to_cpu(*origptr);
1db9d9ded77138 Marc Zyngier  2020-10-21  251  	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, oinsn);
1db9d9ded77138 Marc Zyngier  2020-10-21  252  
1db9d9ded77138 Marc Zyngier  2020-10-21  253  	/* movz rd, #(val & 0xffff) */
1db9d9ded77138 Marc Zyngier  2020-10-21  254  	insn = aarch64_insn_gen_movewide(rd,
1db9d9ded77138 Marc Zyngier  2020-10-21  255  					 (u16)val,
1db9d9ded77138 Marc Zyngier  2020-10-21  256  					 0,
1db9d9ded77138 Marc Zyngier  2020-10-21  257  					 AARCH64_INSN_VARIANT_64BIT,
1db9d9ded77138 Marc Zyngier  2020-10-21  258  					 AARCH64_INSN_MOVEWIDE_ZERO);
1db9d9ded77138 Marc Zyngier  2020-10-21  259  	*updptr++ = cpu_to_le32(insn);
1db9d9ded77138 Marc Zyngier  2020-10-21  260  
1db9d9ded77138 Marc Zyngier  2020-10-21  261  	/* movk rd, #((val >> 16) & 0xffff), lsl #16 */
1db9d9ded77138 Marc Zyngier  2020-10-21  262  	insn = aarch64_insn_gen_movewide(rd,
1db9d9ded77138 Marc Zyngier  2020-10-21  263  					 (u16)(val >> 16),
1db9d9ded77138 Marc Zyngier  2020-10-21  264  					 16,
1db9d9ded77138 Marc Zyngier  2020-10-21  265  					 AARCH64_INSN_VARIANT_64BIT,
1db9d9ded77138 Marc Zyngier  2020-10-21  266  					 AARCH64_INSN_MOVEWIDE_KEEP);
1db9d9ded77138 Marc Zyngier  2020-10-21  267  	*updptr++ = cpu_to_le32(insn);
1db9d9ded77138 Marc Zyngier  2020-10-21  268  
1db9d9ded77138 Marc Zyngier  2020-10-21  269  	/* movk rd, #((val >> 32) & 0xffff), lsl #32 */
1db9d9ded77138 Marc Zyngier  2020-10-21  270  	insn = aarch64_insn_gen_movewide(rd,
1db9d9ded77138 Marc Zyngier  2020-10-21  271  					 (u16)(val >> 32),
1db9d9ded77138 Marc Zyngier  2020-10-21  272  					 32,
1db9d9ded77138 Marc Zyngier  2020-10-21  273  					 AARCH64_INSN_VARIANT_64BIT,
1db9d9ded77138 Marc Zyngier  2020-10-21  274  					 AARCH64_INSN_MOVEWIDE_KEEP);
1db9d9ded77138 Marc Zyngier  2020-10-21  275  	*updptr++ = cpu_to_le32(insn);
1db9d9ded77138 Marc Zyngier  2020-10-21  276  
1db9d9ded77138 Marc Zyngier  2020-10-21  277  	/* movk rd, #((val >> 48) & 0xffff), lsl #48 */
1db9d9ded77138 Marc Zyngier  2020-10-21  278  	insn = aarch64_insn_gen_movewide(rd,
1db9d9ded77138 Marc Zyngier  2020-10-21  279  					 (u16)(val >> 48),
1db9d9ded77138 Marc Zyngier  2020-10-21  280  					 48,
1db9d9ded77138 Marc Zyngier  2020-10-21  281  					 AARCH64_INSN_VARIANT_64BIT,
1db9d9ded77138 Marc Zyngier  2020-10-21  282  					 AARCH64_INSN_MOVEWIDE_KEEP);
1db9d9ded77138 Marc Zyngier  2020-10-21  283  	*updptr++ = cpu_to_le32(insn);
1db9d9ded77138 Marc Zyngier  2020-10-21  284  }
1db9d9ded77138 Marc Zyngier  2020-10-21  285  
68b824e428c5fb Marc Zyngier  2020-10-24 @286  void kvm_get_kimage_voffset(struct alt_instr *alt,
68b824e428c5fb Marc Zyngier  2020-10-24  287  			    __le32 *origptr, __le32 *updptr, int nr_inst)
68b824e428c5fb Marc Zyngier  2020-10-24  288  {
68b824e428c5fb Marc Zyngier  2020-10-24  289  	generate_mov_q(kimage_voffset, origptr, updptr, nr_inst);
68b824e428c5fb Marc Zyngier  2020-10-24  290  }
755db23420a1ce Marc Zyngier  2021-03-22  291  
755db23420a1ce Marc Zyngier  2021-03-22 @292  void kvm_compute_final_ctr_el0(struct alt_instr *alt,

:::::: The code at line 188 was first introduced by commit
:::::: 71dcb8be6d29cffff3f4a4463232f38786e97797 arm64: KVM: Allow far branches from vector slots to the main vectors

:::::: TO: Marc Zyngier <marc.zyngier@arm.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--oyUTqETQ0mS9luUI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--oyUTqETQ0mS9luUI--

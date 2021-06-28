Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC5F3B6B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 02:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhF2ACg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 20:02:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:10856 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhF2ACf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 20:02:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="195350898"
X-IronPort-AV: E=Sophos;i="5.83,307,1616482800"; 
   d="scan'208";a="195350898"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 17:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,307,1616482800"; 
   d="scan'208";a="641102926"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2021 17:00:02 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ly1AX-0008ml-6b; Tue, 29 Jun 2021 00:00:01 +0000
Date:   Tue, 29 Jun 2021 07:59:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 05333d72e9fb69c377e22d2975fdd28a9bdf2e5d
Message-ID: <60da625e.2Y1ub+RLpcSqYHtX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: 05333d72e9fb69c377e22d2975fdd28a9bdf2e5d  Merge branch 'irq/core'

i386-tinyconfig vmlinux size:

+-------+-----------------------------------+------------------------------------------+
| DELTA |              SYMBOL               |                  COMMIT                  |
+-------+-----------------------------------+------------------------------------------+
|  +592 | TOTAL                             | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +447 | TEXT                              | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +169 | DATA                              | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|   -64 | BSS                               | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +879 | __fpu_restore_sig()               | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +555 | copy_xstate_to_uabi_buf()         | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +470 | init.text                         | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +330 | copy_uabi_to_xstate()             | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +265 | __convert_from_fxsr()             | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +252 | altinstructions                   | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +193 | clocksource_watchdog()            | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +180 | altinstr_aux                      | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +150 | perf_clear_dirty_counters()       | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +113 | sld_setup()                       | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +111 | fpu__clear_user_states()          | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  +105 | fpu_clone()                       | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|   +91 | validate_xsaves_xrstors()         | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|   +80 | fpu_flush_thread()                | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|   +76 | save_fpregs_to_fpstate()          | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|   +68 | clocksource_verify_percpu()       | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|   +66 | __clocksource_update_freq_scale() | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|   +64 | intel_spr_extra_regs              | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|   -64 | xstate_supervisor_only_offsets    | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|   -65 | xstateregs_get()                  | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|   -82 | copy_fpregs_to_fpstate()          | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|   -94 | sanitize_restored_user_xstate()   | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  -103 | fpu__clear()                      | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  -125 | fpu__copy()                       | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  -179 | copy_supervisor_to_kernel()       | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  -201 | copy_kernel_to_xstate()           | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  -259 | copy_user_to_xstate()             | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  -261 | fpstate_sanitize_xstate()         | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  -273 | convert_from_fxsr()               | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  -372 | copy_xstate_to_kernel()           | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
|  -914 | __fpu__restore_sig()              | 62fb9874f5da..05333d72e9fb (ALL COMMITS) |
+-------+-----------------------------------+------------------------------------------+

elapsed time: 723m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
arm                         palmz72_defconfig
powerpc                         wii_defconfig
riscv                             allnoconfig
m68k                        stmark2_defconfig
arm                             pxa_defconfig
powerpc                      pcm030_defconfig
powerpc                    adder875_defconfig
powerpc                    socrates_defconfig
powerpc                     sbc8548_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     mpc5200_defconfig
h8300                       h8s-sim_defconfig
powerpc                      ep88xc_defconfig
mips                            ar7_defconfig
powerpc                       ppc64_defconfig
powerpc                     akebono_defconfig
m68k                       m5249evb_defconfig
mips                           ip22_defconfig
sh                          polaris_defconfig
arm                           h3600_defconfig
powerpc                      arches_defconfig
arm                             rpc_defconfig
arm                        vexpress_defconfig
sh                 kfr2r09-romimage_defconfig
sh                         apsh4a3a_defconfig
csky                             alldefconfig
arm                          pxa910_defconfig
mips                           ip27_defconfig
mips                           jazz_defconfig
arm                          pcm027_defconfig
mips                     loongson1c_defconfig
arm                       netwinder_defconfig
arm                        oxnas_v6_defconfig
sh                   sh7724_generic_defconfig
powerpc64                           defconfig
mips                          malta_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     tqm8541_defconfig
mips                        omega2p_defconfig
microblaze                      mmu_defconfig
mips                         db1xxx_defconfig
powerpc                      bamboo_defconfig
sh                           se7619_defconfig
sh                         ecovec24_defconfig
sh                           se7722_defconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
h8300                    h8300h-sim_defconfig
mips                        vocore2_defconfig
mips                      maltasmvp_defconfig
arm                         hackkit_defconfig
m68k                        m5272c3_defconfig
sh                            hp6xx_defconfig
um                           x86_64_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     sequoia_defconfig
mips                          ath79_defconfig
powerpc                     skiroot_defconfig
powerpc                      mgcoge_defconfig
mips                       lemote2f_defconfig
powerpc                      ppc44x_defconfig
powerpc                      ppc64e_defconfig
powerpc                       holly_defconfig
arm                          ep93xx_defconfig
arm                         assabet_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210628
i386                 randconfig-a002-20210628
i386                 randconfig-a003-20210628
i386                 randconfig-a006-20210628
i386                 randconfig-a005-20210628
i386                 randconfig-a004-20210628
x86_64               randconfig-a012-20210628
x86_64               randconfig-a016-20210628
x86_64               randconfig-a015-20210628
x86_64               randconfig-a013-20210628
x86_64               randconfig-a014-20210628
x86_64               randconfig-a011-20210628
i386                 randconfig-a011-20210628
i386                 randconfig-a014-20210628
i386                 randconfig-a013-20210628
i386                 randconfig-a015-20210628
i386                 randconfig-a016-20210628
i386                 randconfig-a012-20210628
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210628
x86_64               randconfig-a002-20210628
x86_64               randconfig-a005-20210628
x86_64               randconfig-a001-20210628
x86_64               randconfig-a003-20210628
x86_64               randconfig-a004-20210628
x86_64               randconfig-a006-20210628

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

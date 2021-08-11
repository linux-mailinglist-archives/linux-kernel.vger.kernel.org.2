Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7DD3E932C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhHKOAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:00:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:49691 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232194AbhHKOAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:00:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="213273780"
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="213273780"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="469410173"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2021 07:00:21 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mDomJ-000Lh5-2Z; Wed, 11 Aug 2021 14:00:19 +0000
Date:   Wed, 11 Aug 2021 21:59:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.08.06a] BUILD REGRESSION
 31c3569d656f0188aa63f826b69e62e8634302f7
Message-ID: <6113d7be.OtiNjLKPh5a63keu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.08.06a
branch HEAD: 31c3569d656f0188aa63f826b69e62e8634302f7  EXP cpu: Add ->thread_ack to multi_cpu_stop() debugging

possible Error/Warning in current branch:

(.text+0x2d64): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: (.text+0x2e08): undefined reference to `__aeabi_uldivmod'
cpu.c:(.text+0x1dd6): undefined reference to `__udivdi3'
cpu.c:(.text.unlikely+0x61): undefined reference to `__udivdi3'
kernel/cpu.c:143: undefined reference to `__udivdi3'
kernel/cpu.c:144:6: error: redefinition of 'cpu_hp_stop_now'
kernel/cpu.c:146:6: error: redefinition of 'cpu_hp_stop_now'
kernel/cpu.c:155:6: error: conflicting types for 'cpu_hp_check_delay'
kernel/cpu.c:158:6: error: conflicting types for 'cpu_hp_check_delay'
kernel/cpu.c:184: undefined reference to `__udivdi3'
kernel/cpu.c:733:45: error: passing 'const char [19]' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
ld: cpu.c:(.text+0x6c4): undefined reference to `__udivdi3'
ld: cpu.c:(.text.unlikely+0x7b): undefined reference to `__udivdi3'
ld: kernel/cpu.c:153: undefined reference to `__udivdi3'
ld: kernel/cpu.c:170: undefined reference to `__udivdi3'
ld: kernel/cpu.c:212: undefined reference to `__udivdi3'
riscv32-linux-ld: cpu.c:(.text+0x1ef2): undefined reference to `__udivdi3'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-c024-20210811
|   |-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay
|   `-- kernel-cpu.c:error:redefinition-of-cpu_hp_stop_now
|-- arc-allyesconfig
|   |-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay
|   `-- kernel-cpu.c:error:redefinition-of-cpu_hp_stop_now
|-- arc-defconfig
|   |-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay
|   `-- kernel-cpu.c:error:redefinition-of-cpu_hp_stop_now
|-- arc-randconfig-r024-20210810
|   `-- kernel-cpu.c:error:redefinition-of-cpu_hp_stop_now
|-- arm-omap2plus_defconfig
|   |-- (.text):undefined-reference-to-__aeabi_uldivmod
|   `-- arm-linux-gnueabi-ld:(.text):undefined-reference-to-__aeabi_uldivmod
|-- i386-buildonly-randconfig-r003-20210810
|   |-- cpu.c:(.text.unlikely):undefined-reference-to-__udivdi3
|   |-- ld:cpu.c:(.text):undefined-reference-to-__udivdi3
|   `-- ld:cpu.c:(.text.unlikely):undefined-reference-to-__udivdi3
|-- i386-randconfig-a004-20210810
|   |-- kernel-cpu.c:undefined-reference-to-__udivdi3
|   `-- ld:kernel-cpu.c:undefined-reference-to-__udivdi3
|-- i386-randconfig-a011-20210810
|   |-- kernel-cpu.c:undefined-reference-to-__udivdi3
|   `-- ld:kernel-cpu.c:undefined-reference-to-__udivdi3
|-- i386-randconfig-a013-20210810
|   |-- kernel-cpu.c:undefined-reference-to-__udivdi3
|   `-- ld:kernel-cpu.c:undefined-reference-to-__udivdi3
|-- i386-randconfig-m021-20210810
|   |-- kernel-cpu.c:undefined-reference-to-__udivdi3
|   `-- ld:kernel-cpu.c:undefined-reference-to-__udivdi3
|-- i386-randconfig-r014-20210810
|   |-- kernel-cpu.c:undefined-reference-to-__udivdi3
|   `-- ld:kernel-cpu.c:undefined-reference-to-__udivdi3
|-- mips-bigsur_defconfig
|   `-- kernel-cpu.c:error:redefinition-of-cpu_hp_stop_now
|-- openrisc-randconfig-r023-20210810
|   |-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay
|   `-- kernel-cpu.c:error:redefinition-of-cpu_hp_stop_now
|-- riscv-randconfig-r024-20210811
|   |-- cpu.c:(.text):undefined-reference-to-__udivdi3
|   `-- riscv32-linux-ld:cpu.c:(.text):undefined-reference-to-__udivdi3
`-- riscv-randconfig-r026-20210811
    |-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay
    `-- kernel-cpu.c:error:redefinition-of-cpu_hp_stop_now

clang_recent_errors
|-- hexagon-randconfig-r003-20210810
|   `-- kernel-cpu.c:error:passing-const-char-to-parameter-of-type-void-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
`-- hexagon-randconfig-r045-20210810
    |-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay
    `-- kernel-cpu.c:error:redefinition-of-cpu_hp_stop_now

elapsed time: 726m

configs tested: 136
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210811
i386                 randconfig-c001-20210809
arm                       omap2plus_defconfig
arm                         at91_dt_defconfig
arm                           omap1_defconfig
arm                         s3c2410_defconfig
arm                           viper_defconfig
xtensa                         virt_defconfig
sh                           se7722_defconfig
m68k                        m5307c3_defconfig
arc                         haps_hs_defconfig
arc                     nsimosci_hs_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      acadia_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      makalu_defconfig
arm                          imote2_defconfig
s390                          debug_defconfig
powerpc                 mpc834x_itx_defconfig
nds32                               defconfig
mips                           jazz_defconfig
mips                           rs90_defconfig
powerpc                           allnoconfig
m68k                             alldefconfig
powerpc                    adder875_defconfig
mips                      bmips_stb_defconfig
sh                           se7712_defconfig
mips                        qi_lb60_defconfig
powerpc                     pseries_defconfig
xtensa                    xip_kc705_defconfig
arc                      axs103_smp_defconfig
arm                            lart_defconfig
mips                      maltasmvp_defconfig
xtensa                  cadence_csp_defconfig
arm                       aspeed_g4_defconfig
mips                         bigsur_defconfig
sh                          sdk7786_defconfig
sh                        dreamcast_defconfig
sh                            hp6xx_defconfig
nds32                             allnoconfig
powerpc                     mpc83xx_defconfig
mips                      loongson3_defconfig
microblaze                      mmu_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
x86_64               randconfig-a004-20210810
x86_64               randconfig-a006-20210810
x86_64               randconfig-a003-20210810
x86_64               randconfig-a005-20210810
x86_64               randconfig-a002-20210810
x86_64               randconfig-a001-20210810
i386                 randconfig-a004-20210810
i386                 randconfig-a002-20210810
i386                 randconfig-a001-20210810
i386                 randconfig-a003-20210810
i386                 randconfig-a006-20210810
i386                 randconfig-a005-20210810
x86_64               randconfig-a016-20210808
x86_64               randconfig-a012-20210808
x86_64               randconfig-a013-20210808
x86_64               randconfig-a011-20210808
x86_64               randconfig-a014-20210808
x86_64               randconfig-a015-20210808
i386                 randconfig-a011-20210810
i386                 randconfig-a015-20210810
i386                 randconfig-a013-20210810
i386                 randconfig-a014-20210810
i386                 randconfig-a016-20210810
i386                 randconfig-a012-20210810
i386                 randconfig-a012-20210809
i386                 randconfig-a015-20210809
i386                 randconfig-a011-20210809
i386                 randconfig-a013-20210809
i386                 randconfig-a014-20210809
i386                 randconfig-a016-20210809
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210811
x86_64               randconfig-c001-20210810
x86_64               randconfig-a013-20210810
x86_64               randconfig-a011-20210810
x86_64               randconfig-a012-20210810
x86_64               randconfig-a016-20210810
x86_64               randconfig-a014-20210810
x86_64               randconfig-a015-20210810
x86_64               randconfig-a004-20210811
x86_64               randconfig-a006-20210811
x86_64               randconfig-a003-20210811
x86_64               randconfig-a002-20210811
x86_64               randconfig-a005-20210811
x86_64               randconfig-a001-20210811

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

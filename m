Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF173ECA15
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbhHOPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 11:52:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:12150 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhHOPwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 11:52:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="301335535"
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="301335535"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 08:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="675205951"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Aug 2021 08:51:41 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mFIQH-000Pv8-5T; Sun, 15 Aug 2021 15:51:41 +0000
Date:   Sun, 15 Aug 2021 23:51:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.08.12a] BUILD REGRESSION
 3d4b7b3ca5de1d3669890684c3e60d3dad6ea468
Message-ID: <611937e6.01Keyb5y+yRUMF4/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.08.12a
branch HEAD: 3d4b7b3ca5de1d3669890684c3e60d3dad6ea468  EXP cpu: Identify CPUs entering new multi_cpu_stop() states

Error/Warning reports:

https://lore.kernel.org/lkml/202108140834.Q4T8R5pI-lkp@intel.com
https://lore.kernel.org/lkml/202108152013.vPXwN8gj-lkp@intel.com

Error/Warning in current branch:

kernel/cpu.c:158:6: error: conflicting types for 'cpu_hp_check_delay'; have 'bool(const char *, const void *)' {aka '_Bool(const char *, const void *)'}
kernel/cpu.c:159:6: error: conflicting types for 'cpu_hp_check_delay'; have 'bool(const char *, const void *)' {aka '_Bool(const char *, const void *)'}
powerpc-linux-ld: cpu.c:(.text+0x1698): undefined reference to `__udivdi3'

possible Error/Warning in current branch:

kernel/cpu.c:733:45: error: passing 'const char [19]' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
kernel/cpu.c:746:45: error: passing 'const char [19]' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
mips-linux-ld: cpu.c:(.text+0x17f0): undefined reference to `__udivdi3'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- alpha-allyesconfig
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- alpha-randconfig-r021-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- arc-allyesconfig
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- arc-buildonly-randconfig-r005-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- arc-defconfig
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- arc-randconfig-p002-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- arc-randconfig-r011-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- arc-randconfig-r031-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- arc-randconfig-r036-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- arc-randconfig-r043-20210812
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- ia64-randconfig-r032-20210814
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- ia64-randconfig-r036-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- mips-bmips_stb_defconfig
|   `-- mips-linux-ld:cpu.c:(.text):undefined-reference-to-__udivdi3
|-- mips-ip27_defconfig
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- mips-randconfig-p002-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- openrisc-buildonly-randconfig-r001-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- openrisc-buildonly-randconfig-r004-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- powerpc-cell_defconfig
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- powerpc-randconfig-r013-20210815
|   `-- powerpc-linux-ld:cpu.c:(.text):undefined-reference-to-__udivdi3
|-- riscv-nommu_k210_defconfig
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- riscv-nommu_virt_defconfig
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- sparc-randconfig-c024-20210814
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- sparc-randconfig-p001-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
|-- sparc-randconfig-r025-20210815
|   `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)
`-- sparc64-randconfig-r001-20210815
    `-- kernel-cpu.c:error:conflicting-types-for-cpu_hp_check_delay-have-bool(const-char-const-void-)-aka-_Bool(const-char-const-void-)

clang_recent_errors
|-- arm64-randconfig-r034-20210815
|   `-- kernel-cpu.c:error:passing-const-char-to-parameter-of-type-void-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
|-- hexagon-randconfig-r045-20210815
|   `-- kernel-cpu.c:error:passing-const-char-to-parameter-of-type-void-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers
`-- riscv-randconfig-r002-20210815
    `-- kernel-cpu.c:error:passing-const-char-to-parameter-of-type-void-discards-qualifiers-Werror-Wincompatible-pointer-types-discards-qualifiers

elapsed time: 2951m

configs tested: 193
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210812
i386                 randconfig-c001-20210813
i386                 randconfig-c001-20210814
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
mips                     loongson1c_defconfig
arm                          ep93xx_defconfig
arm                          iop32x_defconfig
h8300                       h8s-sim_defconfig
riscv                    nommu_k210_defconfig
arm                        clps711x_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                          hp300_defconfig
arm                         at91_dt_defconfig
powerpc                      mgcoge_defconfig
m68k                          sun3x_defconfig
xtensa                          iss_defconfig
arm                      jornada720_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
arm                       omap2plus_defconfig
powerpc                     pq2fads_defconfig
mips                  maltasmvp_eva_defconfig
h8300                            alldefconfig
mips                     cu1830-neo_defconfig
sparc                            alldefconfig
arm                          lpd270_defconfig
arm                          simpad_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
mips                      bmips_stb_defconfig
sh                           se7619_defconfig
arm                         orion5x_defconfig
sh                           se7750_defconfig
powerpc                    socrates_defconfig
riscv                             allnoconfig
powerpc                     ksi8560_defconfig
sh                               alldefconfig
arm                         s3c6400_defconfig
arm                             mxs_defconfig
sparc                       sparc32_defconfig
arm                        multi_v5_defconfig
powerpc                      makalu_defconfig
m68k                        m5307c3_defconfig
mips                        qi_lb60_defconfig
arm                        mvebu_v7_defconfig
mips                        bcm63xx_defconfig
powerpc                     mpc5200_defconfig
mips                      fuloong2e_defconfig
xtensa                       common_defconfig
mips                       lemote2f_defconfig
riscv                    nommu_virt_defconfig
xtensa                  audio_kc705_defconfig
powerpc                        cell_defconfig
sh                        sh7785lcr_defconfig
mips                           ip27_defconfig
powerpc                      obs600_defconfig
arm                           stm32_defconfig
m68k                       bvme6000_defconfig
arm                         axm55xx_defconfig
powerpc                    amigaone_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc837x_mds_defconfig
sh                   sh7724_generic_defconfig
sh                          sdk7780_defconfig
powerpc                        warp_defconfig
arm                         lpc18xx_defconfig
arm                             rpc_defconfig
arm                        cerfcube_defconfig
sh                           sh2007_defconfig
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
i386                 randconfig-a004-20210814
i386                 randconfig-a002-20210814
i386                 randconfig-a001-20210814
i386                 randconfig-a003-20210814
i386                 randconfig-a006-20210814
i386                 randconfig-a005-20210814
i386                 randconfig-a004-20210813
i386                 randconfig-a003-20210813
i386                 randconfig-a001-20210813
i386                 randconfig-a002-20210813
i386                 randconfig-a006-20210813
i386                 randconfig-a005-20210813
i386                 randconfig-a004-20210815
i386                 randconfig-a001-20210815
i386                 randconfig-a002-20210815
i386                 randconfig-a003-20210815
i386                 randconfig-a006-20210815
i386                 randconfig-a005-20210815
x86_64               randconfig-a011-20210813
x86_64               randconfig-a013-20210813
x86_64               randconfig-a012-20210813
x86_64               randconfig-a016-20210813
x86_64               randconfig-a015-20210813
x86_64               randconfig-a014-20210813
x86_64               randconfig-a013-20210815
x86_64               randconfig-a011-20210815
x86_64               randconfig-a016-20210815
x86_64               randconfig-a012-20210815
x86_64               randconfig-a014-20210815
x86_64               randconfig-a015-20210815
x86_64               randconfig-a004-20210814
x86_64               randconfig-a006-20210814
x86_64               randconfig-a003-20210814
x86_64               randconfig-a001-20210814
x86_64               randconfig-a005-20210814
x86_64               randconfig-a002-20210814
i386                 randconfig-a011-20210815
i386                 randconfig-a015-20210815
i386                 randconfig-a014-20210815
i386                 randconfig-a013-20210815
i386                 randconfig-a016-20210815
i386                 randconfig-a012-20210815
i386                 randconfig-a011-20210814
i386                 randconfig-a015-20210814
i386                 randconfig-a013-20210814
i386                 randconfig-a014-20210814
i386                 randconfig-a016-20210814
i386                 randconfig-a012-20210814
riscv                            allyesconfig
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
x86_64               randconfig-c001-20210815
x86_64               randconfig-c001-20210814
x86_64               randconfig-c001-20210813
x86_64               randconfig-a004-20210815
x86_64               randconfig-a006-20210815
x86_64               randconfig-a003-20210815
x86_64               randconfig-a001-20210815
x86_64               randconfig-a002-20210815
x86_64               randconfig-a005-20210815
x86_64               randconfig-a006-20210813
x86_64               randconfig-a004-20210813
x86_64               randconfig-a003-20210813
x86_64               randconfig-a002-20210813
x86_64               randconfig-a005-20210813
x86_64               randconfig-a001-20210813
x86_64               randconfig-a013-20210814
x86_64               randconfig-a011-20210814
x86_64               randconfig-a016-20210814
x86_64               randconfig-a012-20210814
x86_64               randconfig-a014-20210814
x86_64               randconfig-a015-20210814

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

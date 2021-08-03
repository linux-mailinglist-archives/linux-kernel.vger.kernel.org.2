Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A103DEF85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhHCOAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:00:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:53449 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236195AbhHCOAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:00:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="211826667"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="211826667"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 07:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="636615263"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Aug 2021 07:00:31 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mAuy6-000DxZ-Kr; Tue, 03 Aug 2021 14:00:30 +0000
Date:   Tue, 03 Aug 2021 22:00:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.07.27b] BUILD REGRESSION
 11e66439ec35a4e59ab0bafdc33b56f395cc3b49
Message-ID: <61094bf6.C//rsc9Qu4Ra+DfP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.07.27b
branch HEAD: 11e66439ec35a4e59ab0bafdc33b56f395cc3b49  squash! EXP clocksource: Forgive repeated long-latency watchdog clocksource reads

Error/Warning reports:

https://lore.kernel.org/lkml/202108031531.OOHJRGNF-lkp@intel.com
https://lore.kernel.org/lkml/202108031628.fVRe8td4-lkp@intel.com
https://lore.kernel.org/lkml/202108031746.8g84G1Wc-lkp@intel.com

Error/Warning in current branch:

arm-linux-gnueabi-ld: cpu.c:(.text+0x18c0): undefined reference to `__aeabi_uldivmod'
cpu.c:(.text+0x1860): undefined reference to `__aeabi_uldivmod'
cpu.c:(.text+0x30c): undefined reference to `__udivdi3'
cpu.c:(.text+0x656): undefined reference to `__udivdi3'
mips-linux-ld: cpu.c:(.text+0x444): undefined reference to `__udivdi3'
riscv32-linux-ld: cpu.c:(.text+0x1a36): undefined reference to `__udivdi3'

possible Error/Warning in current branch:

kernel/cpu.c:170:41: warning: integer overflow in expression of type 'long int' results in '1215752192' [-Woverflow]
kernel/cpu.c:184: undefined reference to `__udivdi3'
kernel/cpu.c:184:38: warning: integer overflow in expression of type 'long int' results in '1215752192' [-Woverflow]
ld: kernel/cpu.c:212: undefined reference to `__udivdi3'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allyesconfig
|   `-- kernel-cpu.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- arc-randconfig-c003-20210803
|   `-- kernel-cpu.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- arm-defconfig
|   |-- arm-linux-gnueabi-ld:cpu.c:(.text):undefined-reference-to-__aeabi_uldivmod
|   `-- cpu.c:(.text):undefined-reference-to-__aeabi_uldivmod
|-- i386-randconfig-c001-20210803
|   `-- kernel-cpu.c:warning:integer-overflow-in-expression-of-type-long-int-results-in
|-- i386-randconfig-f002-20200411
|   |-- kernel-cpu.c:undefined-reference-to-__udivdi3
|   `-- ld:kernel-cpu.c:undefined-reference-to-__udivdi3
|-- mips-bmips_be_defconfig
|   |-- cpu.c:(.text):undefined-reference-to-__udivdi3
|   `-- mips-linux-ld:cpu.c:(.text):undefined-reference-to-__udivdi3
`-- riscv-rv32_defconfig
    |-- cpu.c:(.text):undefined-reference-to-__udivdi3
    `-- riscv32-linux-ld:cpu.c:(.text):undefined-reference-to-__udivdi3

elapsed time: 731m

configs tested: 140
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210803
sh                           se7751_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                       bvme6000_defconfig
arm                         mv78xx0_defconfig
powerpc                     kmeter1_defconfig
sh                     sh7710voipgw_defconfig
ia64                                defconfig
x86_64                            allnoconfig
riscv                               defconfig
arm                         nhk8815_defconfig
arm                  colibri_pxa300_defconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
sh                         apsh4a3a_defconfig
riscv                            allyesconfig
powerpc                     powernv_defconfig
mips                         bigsur_defconfig
openrisc                 simple_smp_defconfig
arm                        spear3xx_defconfig
arc                          axs103_defconfig
sh                           se7724_defconfig
m68k                         apollo_defconfig
arm                       cns3420vb_defconfig
arm                          iop32x_defconfig
mips                 decstation_r4k_defconfig
arm                        trizeps4_defconfig
sh                           se7722_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
sh                            titan_defconfig
powerpc                    socrates_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
sh                        sh7763rdp_defconfig
sh                          sdk7786_defconfig
nds32                            alldefconfig
powerpc                  mpc866_ads_defconfig
powerpc                     mpc83xx_defconfig
m68k                           sun3_defconfig
riscv                    nommu_k210_defconfig
arm                          badge4_defconfig
arm                              alldefconfig
powerpc                 xes_mpc85xx_defconfig
m68k                        mvme16x_defconfig
mips                       rbtx49xx_defconfig
powerpc                     ksi8560_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      bamboo_defconfig
arm                          ixp4xx_defconfig
powerpc                      ppc44x_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     akebono_defconfig
nds32                             allnoconfig
powerpc                    klondike_defconfig
mips                       bmips_be_defconfig
riscv                             allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
x86_64               randconfig-a002-20210803
x86_64               randconfig-a004-20210803
x86_64               randconfig-a006-20210803
x86_64               randconfig-a003-20210803
x86_64               randconfig-a001-20210803
x86_64               randconfig-a005-20210803
i386                 randconfig-a004-20210803
i386                 randconfig-a005-20210803
i386                 randconfig-a002-20210803
i386                 randconfig-a006-20210803
i386                 randconfig-a001-20210803
i386                 randconfig-a003-20210803
i386                 randconfig-a012-20210803
i386                 randconfig-a011-20210803
i386                 randconfig-a015-20210803
i386                 randconfig-a013-20210803
i386                 randconfig-a014-20210803
i386                 randconfig-a016-20210803
i386                 randconfig-a012-20210802
i386                 randconfig-a011-20210802
i386                 randconfig-a015-20210802
i386                 randconfig-a013-20210802
i386                 randconfig-a014-20210802
i386                 randconfig-a016-20210802
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210803
x86_64               randconfig-c001-20210802
x86_64               randconfig-a002-20210802
x86_64               randconfig-a004-20210802
x86_64               randconfig-a006-20210802
x86_64               randconfig-a003-20210802
x86_64               randconfig-a001-20210802
x86_64               randconfig-a005-20210802
x86_64               randconfig-a012-20210803
x86_64               randconfig-a016-20210803
x86_64               randconfig-a013-20210803
x86_64               randconfig-a011-20210803
x86_64               randconfig-a014-20210803
x86_64               randconfig-a015-20210803

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

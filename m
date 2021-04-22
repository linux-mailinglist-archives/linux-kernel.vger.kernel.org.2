Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8E368823
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbhDVUl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:41:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:61374 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236896AbhDVUl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:41:56 -0400
IronPort-SDR: VLsPP6NajfGaLOVXOEZU9uXSTI+jDxwTfvKftjg1EULE9KIzYV90acKfrAARZ+7zK9WhpjduKC
 UwGTRxfbO5fw==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="281297996"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="281297996"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 13:41:21 -0700
IronPort-SDR: p4C9qSMY9GsJU9kPMQIbJaL0zM5ExKQxbS2h4MTZswzUF+gQOaLI7zcOdePLDrvwLqq1tolcZ3
 Sa102fPpqOVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="384890541"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2021 13:41:19 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZg8U-0004Kd-St; Thu, 22 Apr 2021 20:41:18 +0000
Date:   Fri, 23 Apr 2021 04:40:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS WITH WARNING
 2ea46c6fc9452ac100ad907b051d797225847e33
Message-ID: <6081df35.4e9jrx0YrBccQyiw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 2ea46c6fc9452ac100ad907b051d797225847e33  cpumask/hotplug: Fix cpu_dying() state tracking

Warning in current branch:

kernel/sched/fair.c:637:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
kernel/sched/fair.c:637:5: warning: no previous prototype for function 'sched_update_scaling' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-bcm2835_defconfig
|   `-- kernel-sched-fair.c:warning:no-previous-prototype-for-sched_update_scaling
|-- h8300-randconfig-r025-20210421
|   `-- kernel-sched-fair.c:warning:no-previous-prototype-for-sched_update_scaling
|-- m68k-allmodconfig
|   `-- kernel-sched-fair.c:warning:no-previous-prototype-for-sched_update_scaling
|-- m68k-allyesconfig
|   `-- kernel-sched-fair.c:warning:no-previous-prototype-for-sched_update_scaling
`-- nds32-allyesconfig
    `-- kernel-sched-fair.c:warning:no-previous-prototype-for-sched_update_scaling

clang_recent_errors
|-- x86_64-randconfig-a012-20210421
|   `-- kernel-sched-fair.c:warning:no-previous-prototype-for-function-sched_update_scaling
|-- x86_64-randconfig-a013-20210421
|   `-- kernel-sched-fair.c:warning:no-previous-prototype-for-function-sched_update_scaling
`-- x86_64-randconfig-a014-20210421
    `-- kernel-sched-fair.c:warning:no-previous-prototype-for-function-sched_update_scaling

elapsed time: 722m

configs tested: 182
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                            lart_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
sh                             shx3_defconfig
um                                  defconfig
powerpc                      ppc44x_defconfig
mips                           jazz_defconfig
sh                        apsh4ad0a_defconfig
arm                        mvebu_v7_defconfig
arm                         lpc32xx_defconfig
arc                        nsimosci_defconfig
m68k                            q40_defconfig
powerpc                          allyesconfig
arc                           tb10x_defconfig
arm                        multi_v5_defconfig
arm                      footbridge_defconfig
alpha                               defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
powerpc                  iss476-smp_defconfig
powerpc                      ep88xc_defconfig
arc                      axs103_smp_defconfig
powerpc                 linkstation_defconfig
arm                         s5pv210_defconfig
sparc                       sparc32_defconfig
sh                              ul2_defconfig
powerpc                     asp8347_defconfig
ia64                          tiger_defconfig
mips                        nlm_xlr_defconfig
mips                  decstation_64_defconfig
m68k                         apollo_defconfig
sh                   sh7770_generic_defconfig
mips                            e55_defconfig
sh                        sh7757lcr_defconfig
sh                          lboxre2_defconfig
m68k                          hp300_defconfig
mips                           xway_defconfig
powerpc                  storcenter_defconfig
mips                           ci20_defconfig
powerpc                  mpc885_ads_defconfig
mips                          rm200_defconfig
powerpc                      acadia_defconfig
nds32                               defconfig
sh                          sdk7780_defconfig
sh                            titan_defconfig
sh                           se7724_defconfig
arm                          pcm027_defconfig
arm                        magician_defconfig
ia64                            zx1_defconfig
mips                      maltasmvp_defconfig
arm                         cm_x300_defconfig
arm                         bcm2835_defconfig
arm                        keystone_defconfig
ia64                         bigsur_defconfig
s390                          debug_defconfig
x86_64                           alldefconfig
m68k                         amcore_defconfig
mips                       capcella_defconfig
um                            kunit_defconfig
arm                        oxnas_v6_defconfig
arm                           sama5_defconfig
mips                     cu1000-neo_defconfig
arm                           u8500_defconfig
sh                           se7343_defconfig
mips                           ip32_defconfig
mips                        maltaup_defconfig
mips                        bcm47xx_defconfig
powerpc                 canyonlands_defconfig
arc                        vdk_hs38_defconfig
powerpc                     tqm5200_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                     loongson1b_defconfig
arc                          axs101_defconfig
mips                     decstation_defconfig
arm                       aspeed_g5_defconfig
arm                   milbeaut_m10v_defconfig
arm                         mv78xx0_defconfig
arc                              allyesconfig
mips                      pistachio_defconfig
arm                          pxa910_defconfig
mips                             allyesconfig
powerpc                     skiroot_defconfig
mips                      maltaaprp_defconfig
mips                         tb0287_defconfig
um                             i386_defconfig
arm                           spitz_defconfig
powerpc                     kmeter1_defconfig
arm                         nhk8815_defconfig
powerpc                      walnut_defconfig
powerpc                     rainier_defconfig
arm                           stm32_defconfig
powerpc                     mpc83xx_defconfig
arm                        trizeps4_defconfig
nds32                             allnoconfig
mips                 decstation_r4k_defconfig
i386                             alldefconfig
arc                                 defconfig
powerpc                 xes_mpc85xx_defconfig
sh                           sh2007_defconfig
arm                    vt8500_v6_v7_defconfig
arm                       omap2plus_defconfig
arm                      tct_hammer_defconfig
m68k                        mvme16x_defconfig
sh                           se7722_defconfig
openrisc                         alldefconfig
sh                            migor_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210421
x86_64               randconfig-a002-20210421
x86_64               randconfig-a001-20210421
x86_64               randconfig-a005-20210421
x86_64               randconfig-a006-20210421
x86_64               randconfig-a003-20210421
i386                 randconfig-a005-20210421
i386                 randconfig-a002-20210421
i386                 randconfig-a001-20210421
i386                 randconfig-a006-20210421
i386                 randconfig-a004-20210421
i386                 randconfig-a003-20210421
x86_64               randconfig-a015-20210422
x86_64               randconfig-a016-20210422
x86_64               randconfig-a011-20210422
x86_64               randconfig-a014-20210422
x86_64               randconfig-a012-20210422
x86_64               randconfig-a013-20210422
i386                 randconfig-a012-20210421
i386                 randconfig-a014-20210421
i386                 randconfig-a011-20210421
i386                 randconfig-a013-20210421
i386                 randconfig-a015-20210421
i386                 randconfig-a016-20210421
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210421
x86_64               randconfig-a016-20210421
x86_64               randconfig-a011-20210421
x86_64               randconfig-a014-20210421
x86_64               randconfig-a013-20210421
x86_64               randconfig-a012-20210421

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

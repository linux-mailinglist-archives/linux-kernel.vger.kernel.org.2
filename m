Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DD044FCBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 02:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhKOB3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 20:29:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:11239 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhKOB3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 20:29:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="213393981"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="213393981"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 17:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="671330893"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Nov 2021 17:26:00 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mmQkx-000LxG-DI; Mon, 15 Nov 2021 01:25:59 +0000
Date:   Mon, 15 Nov 2021 09:25:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 979292af5b512c27803316de2cd06970c54251e5
Message-ID: <6191b702.PgjoIoSiLqJmQsf2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 979292af5b512c27803316de2cd06970c54251e5  Merge tag 'irqchip-fixes-5.16-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 721m

configs tested: 220
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211115
mips                 randconfig-c004-20211115
arm                       omap2plus_defconfig
mips                         tb0219_defconfig
powerpc                     pq2fads_defconfig
openrisc                            defconfig
m68k                           sun3_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc64                           defconfig
arm                  colibri_pxa270_defconfig
xtensa                       common_defconfig
i386                             alldefconfig
sh                          urquell_defconfig
sh                        sh7763rdp_defconfig
powerpc                     mpc83xx_defconfig
microblaze                      mmu_defconfig
arm                         orion5x_defconfig
arc                          axs101_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 mpc834x_itx_defconfig
csky                             alldefconfig
arm                             rpc_defconfig
arm                        mini2440_defconfig
arm                         palmz72_defconfig
sh                           se7721_defconfig
powerpc                          g5_defconfig
arm                          ixp4xx_defconfig
mips                       lemote2f_defconfig
h8300                            allyesconfig
riscv                    nommu_k210_defconfig
arm                         lpc18xx_defconfig
powerpc                      ppc44x_defconfig
arm                          imote2_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                        vdk_hs38_defconfig
arm                          pcm027_defconfig
sparc64                             defconfig
arm                         assabet_defconfig
sparc                       sparc32_defconfig
powerpc                     rainier_defconfig
m68k                          sun3x_defconfig
powerpc                     tqm8555_defconfig
um                               alldefconfig
sh                            migor_defconfig
arm                        vexpress_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
arm                      jornada720_defconfig
alpha                            alldefconfig
arm                      tct_hammer_defconfig
powerpc                        warp_defconfig
m68k                          multi_defconfig
arm64                            alldefconfig
powerpc                       holly_defconfig
mips                      maltaaprp_defconfig
arm                           h3600_defconfig
sh                            titan_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                           sh2007_defconfig
ia64                             alldefconfig
parisc                generic-64bit_defconfig
mips                        jmr3927_defconfig
riscv                    nommu_virt_defconfig
sh                           se7619_defconfig
sparc64                          alldefconfig
mips                       bmips_be_defconfig
mips                        bcm47xx_defconfig
xtensa                          iss_defconfig
sh                           se7724_defconfig
mips                        omega2p_defconfig
arm                           u8500_defconfig
arm                           spitz_defconfig
sh                     magicpanelr2_defconfig
sh                                  defconfig
sh                           se7722_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8272_ads_defconfig
mips                      pic32mzda_defconfig
mips                        bcm63xx_defconfig
arm                            dove_defconfig
mips                     loongson1b_defconfig
arm                           sama7_defconfig
arm                          collie_defconfig
arc                      axs103_smp_defconfig
sh                           se7751_defconfig
sh                             sh03_defconfig
xtensa                              defconfig
powerpc64                        alldefconfig
powerpc                 mpc8315_rdb_defconfig
sh                   secureedge5410_defconfig
parisc                generic-32bit_defconfig
xtensa                  cadence_csp_defconfig
arm                       mainstone_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     powernv_defconfig
mips                     decstation_defconfig
openrisc                 simple_smp_defconfig
mips                        maltaup_defconfig
powerpc                     mpc512x_defconfig
m68k                       bvme6000_defconfig
mips                           ip32_defconfig
sh                         ap325rxa_defconfig
openrisc                  or1klitex_defconfig
arm                          moxart_defconfig
sh                        edosk7760_defconfig
arm                        magician_defconfig
arm                       multi_v4t_defconfig
sh                           se7206_defconfig
powerpc                      pcm030_defconfig
um                                  defconfig
arm                        multi_v7_defconfig
arm                  randconfig-c002-20211114
arm                  randconfig-c002-20211115
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a006-20211115
i386                 randconfig-a003-20211115
i386                 randconfig-a005-20211115
i386                 randconfig-a001-20211115
i386                 randconfig-a004-20211115
i386                 randconfig-a002-20211115
x86_64               randconfig-a015-20211114
x86_64               randconfig-a013-20211114
x86_64               randconfig-a012-20211114
x86_64               randconfig-a011-20211114
x86_64               randconfig-a016-20211114
x86_64               randconfig-a014-20211114
i386                 randconfig-a014-20211114
i386                 randconfig-a016-20211114
i386                 randconfig-a012-20211114
i386                 randconfig-a013-20211114
i386                 randconfig-a011-20211114
i386                 randconfig-a015-20211114
arc                  randconfig-r043-20211114
s390                 randconfig-r044-20211114
riscv                randconfig-r042-20211114
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20211114
i386                 randconfig-c001-20211114
arm                  randconfig-c002-20211114
riscv                randconfig-c006-20211114
powerpc              randconfig-c003-20211114
s390                 randconfig-c005-20211114
mips                 randconfig-c004-20211114
x86_64               randconfig-a005-20211114
x86_64               randconfig-a003-20211114
x86_64               randconfig-a001-20211114
x86_64               randconfig-a002-20211114
x86_64               randconfig-a006-20211114
x86_64               randconfig-a004-20211114
i386                 randconfig-a006-20211114
i386                 randconfig-a003-20211114
i386                 randconfig-a005-20211114
i386                 randconfig-a001-20211114
i386                 randconfig-a004-20211114
i386                 randconfig-a002-20211114
x86_64               randconfig-a015-20211115
x86_64               randconfig-a013-20211115
x86_64               randconfig-a011-20211115
x86_64               randconfig-a012-20211115
x86_64               randconfig-a016-20211115
x86_64               randconfig-a014-20211115
i386                 randconfig-a014-20211115
i386                 randconfig-a016-20211115
i386                 randconfig-a012-20211115
i386                 randconfig-a013-20211115
i386                 randconfig-a011-20211115
i386                 randconfig-a015-20211115
hexagon              randconfig-r045-20211115
hexagon              randconfig-r041-20211115
s390                 randconfig-r044-20211115
riscv                randconfig-r042-20211115
hexagon              randconfig-r045-20211114
hexagon              randconfig-r041-20211114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

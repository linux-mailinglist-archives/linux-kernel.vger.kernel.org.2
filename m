Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5C405F31
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 00:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbhIIWEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 18:04:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:63207 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343758AbhIIWEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:04:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="281938652"
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="281938652"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 15:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="539972235"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Sep 2021 15:02:53 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mOS8C-0003ZR-Du; Thu, 09 Sep 2021 22:02:52 +0000
Date:   Fri, 10 Sep 2021 06:02:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 868ad33bfa3bf39960982682ad3a0f8ebda1656e
Message-ID: <613a846f.Ur9VXdbMlWG6G1+c%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 868ad33bfa3bf39960982682ad3a0f8ebda1656e  sched: Prevent balance_push() on remote runqueues

elapsed time: 729m

configs tested: 176
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210908
arm                       aspeed_g4_defconfig
sh                   sh7724_generic_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                            hisi_defconfig
mips                        nlm_xlr_defconfig
mips                  decstation_64_defconfig
um                           x86_64_defconfig
mips                        omega2p_defconfig
powerpc                     asp8347_defconfig
arm                         lpc32xx_defconfig
powerpc                       eiger_defconfig
h8300                            alldefconfig
powerpc                 mpc834x_itx_defconfig
sh                        sh7763rdp_defconfig
xtensa                    smp_lx200_defconfig
arm                          collie_defconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
powerpc                  storcenter_defconfig
arm                          ep93xx_defconfig
sparc                       sparc32_defconfig
arm                           sama5_defconfig
powerpc                     taishan_defconfig
powerpc                     tqm8548_defconfig
m68k                        m5272c3_defconfig
microblaze                      mmu_defconfig
powerpc                     mpc5200_defconfig
arm                        spear6xx_defconfig
alpha                            allyesconfig
arc                        nsimosci_defconfig
s390                                defconfig
arm                         lpc18xx_defconfig
sh                             sh03_defconfig
sh                            titan_defconfig
sh                            shmin_defconfig
arm                      integrator_defconfig
mips                      maltaaprp_defconfig
powerpc                      chrp32_defconfig
arm                         socfpga_defconfig
powerpc                     ep8248e_defconfig
arm                          pxa168_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    klondike_defconfig
openrisc                            defconfig
mips                          ath79_defconfig
m68k                       m5208evb_defconfig
m68k                        m5407c3_defconfig
arm                       versatile_defconfig
arm                        cerfcube_defconfig
arm                          ixp4xx_defconfig
mips                      fuloong2e_defconfig
powerpc                      obs600_defconfig
powerpc                 canyonlands_defconfig
ia64                             allmodconfig
arm                         at91_dt_defconfig
powerpc                      ppc6xx_defconfig
arm                        multi_v5_defconfig
powerpc                     kilauea_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
ia64                        generic_defconfig
arm                         vf610m4_defconfig
mips                           ip32_defconfig
sh                           se7750_defconfig
mips                        workpad_defconfig
powerpc                        warp_defconfig
arm                         mv78xx0_defconfig
sh                           se7343_defconfig
powerpc                     redwood_defconfig
sh                          r7785rp_defconfig
x86_64                           alldefconfig
ia64                          tiger_defconfig
mips                       capcella_defconfig
powerpc                         wii_defconfig
mips                          ath25_defconfig
mips                       lemote2f_defconfig
xtensa                  nommu_kc705_defconfig
arc                          axs103_defconfig
mips                       rbtx49xx_defconfig
mips                        vocore2_defconfig
powerpc                      makalu_defconfig
powerpc                    sam440ep_defconfig
openrisc                         alldefconfig
arm                           viper_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc8315_rdb_defconfig
xtensa                    xip_kc705_defconfig
sh                        edosk7760_defconfig
mips                        qi_lb60_defconfig
m68k                       bvme6000_defconfig
powerpc                     ppa8548_defconfig
x86_64               randconfig-c001-20210908
arm                  randconfig-c002-20210908
x86_64                            allnoconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210908
x86_64               randconfig-a006-20210908
x86_64               randconfig-a003-20210908
x86_64               randconfig-a001-20210908
x86_64               randconfig-a005-20210908
x86_64               randconfig-a002-20210908
i386                 randconfig-a005-20210908
i386                 randconfig-a004-20210908
i386                 randconfig-a006-20210908
i386                 randconfig-a002-20210908
i386                 randconfig-a001-20210908
i386                 randconfig-a003-20210908
arc                  randconfig-r043-20210908
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
s390                 randconfig-c005-20210908
powerpc              randconfig-c003-20210908
mips                 randconfig-c004-20210908
i386                 randconfig-c001-20210908
x86_64               randconfig-c007-20210908
arm                  randconfig-c002-20210908
riscv                randconfig-c006-20210908
x86_64               randconfig-a016-20210908
x86_64               randconfig-a011-20210908
x86_64               randconfig-a012-20210908
x86_64               randconfig-a015-20210908
x86_64               randconfig-a014-20210908
x86_64               randconfig-a013-20210908
i386                 randconfig-a012-20210908
i386                 randconfig-a015-20210908
i386                 randconfig-a011-20210908
i386                 randconfig-a013-20210908
i386                 randconfig-a014-20210908
i386                 randconfig-a016-20210908
s390                 randconfig-r044-20210908
riscv                randconfig-r042-20210908
hexagon              randconfig-r045-20210908
hexagon              randconfig-r041-20210908

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

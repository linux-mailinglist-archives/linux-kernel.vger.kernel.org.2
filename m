Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F9345B0C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 01:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhKXAf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 19:35:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:31539 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhKXAfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 19:35:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="235117157"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="235117157"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 16:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="591400924"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2021 16:32:10 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpgCn-0003Eb-Bn; Wed, 24 Nov 2021 00:32:09 +0000
Date:   Wed, 24 Nov 2021 08:31:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp] BUILD SUCCESS
 64bc5a949ae1d2ea3f092672146fbd6f7ce67ada
Message-ID: <619d87f2.qmg8io/NBBn97LBg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: 64bc5a949ae1d2ea3f092672146fbd6f7ce67ada  Merge branch 'for-linus/kspp' into for-next/kspp

elapsed time: 1404m

configs tested: 243
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211123
sh                      rts7751r2d1_defconfig
sh                        apsh4ad0a_defconfig
arm                         vf610m4_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      tqm8xx_defconfig
arm                         socfpga_defconfig
arm                          pcm027_defconfig
powerpc                        fsp2_defconfig
mips                  decstation_64_defconfig
sh                         ecovec24_defconfig
mips                         rt305x_defconfig
arm                         at91_dt_defconfig
arm                        mvebu_v5_defconfig
riscv                    nommu_virt_defconfig
powerpc                       eiger_defconfig
sh                           se7722_defconfig
mips                      fuloong2e_defconfig
powerpc                      bamboo_defconfig
mips                          ath25_defconfig
sh                             shx3_defconfig
powerpc                 mpc836x_mds_defconfig
nios2                         3c120_defconfig
sh                         microdev_defconfig
xtensa                    smp_lx200_defconfig
mips                       capcella_defconfig
h8300                            alldefconfig
sh                           se7705_defconfig
powerpc                    adder875_defconfig
mips                        maltaup_defconfig
sparc                       sparc64_defconfig
sparc64                          alldefconfig
mips                           gcw0_defconfig
arm                          pxa3xx_defconfig
powerpc                 linkstation_defconfig
arm                        magician_defconfig
sh                           se7343_defconfig
ia64                             alldefconfig
arm                           stm32_defconfig
xtensa                       common_defconfig
m68k                        stmark2_defconfig
mips                     cu1830-neo_defconfig
m68k                        m5407c3_defconfig
arm                          ep93xx_defconfig
powerpc                     akebono_defconfig
powerpc                          allyesconfig
mips                      malta_kvm_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          lboxre2_defconfig
powerpc                     pq2fads_defconfig
powerpc                      pasemi_defconfig
mips                            ar7_defconfig
h8300                     edosk2674_defconfig
arm                         hackkit_defconfig
m68k                            q40_defconfig
arc                            hsdk_defconfig
mips                  cavium_octeon_defconfig
mips                     decstation_defconfig
openrisc                            defconfig
mips                           xway_defconfig
powerpc                      pmac32_defconfig
m68k                       m5249evb_defconfig
powerpc                     tqm8555_defconfig
arm                          badge4_defconfig
powerpc                     rainier_defconfig
arm                         s5pv210_defconfig
alpha                               defconfig
arm                          simpad_defconfig
m68k                       m5475evb_defconfig
powerpc                      walnut_defconfig
powerpc64                           defconfig
ia64                            zx1_defconfig
sh                              ul2_defconfig
powerpc                  mpc885_ads_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7712_defconfig
mips                        qi_lb60_defconfig
arm                        vexpress_defconfig
h8300                               defconfig
arm                         cm_x300_defconfig
arm                         axm55xx_defconfig
arm                      footbridge_defconfig
arm                        shmobile_defconfig
arm                            xcep_defconfig
m68k                          multi_defconfig
arc                          axs103_defconfig
sh                             espt_defconfig
powerpc                      ppc64e_defconfig
powerpc                 canyonlands_defconfig
sh                        edosk7705_defconfig
powerpc                      chrp32_defconfig
mips                     loongson2k_defconfig
powerpc                   lite5200b_defconfig
arm                           h5000_defconfig
powerpc                    ge_imp3a_defconfig
ia64                          tiger_defconfig
mips                       rbtx49xx_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                 simple_smp_defconfig
powerpc                       ebony_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     pseries_defconfig
arm                        oxnas_v6_defconfig
arm                     eseries_pxa_defconfig
arm                           sama5_defconfig
arm                          pxa168_defconfig
sh                          r7785rp_defconfig
ia64                        generic_defconfig
powerpc                   currituck_defconfig
riscv                          rv32_defconfig
sh                           se7750_defconfig
arm                        realview_defconfig
powerpc                      acadia_defconfig
powerpc                     stx_gp3_defconfig
um                                  defconfig
sh                   rts7751r2dplus_defconfig
arm                     am200epdkit_defconfig
arc                        nsimosci_defconfig
arm                          gemini_defconfig
arm                            lart_defconfig
microblaze                          defconfig
powerpc                 mpc837x_rdb_defconfig
s390                       zfcpdump_defconfig
mips                           mtx1_defconfig
mips                       bmips_be_defconfig
mips                           ip32_defconfig
mips                          rm200_defconfig
arc                     nsimosci_hs_defconfig
mips                      maltaaprp_defconfig
arm                              alldefconfig
arm                  randconfig-c002-20211123
arm                  randconfig-c002-20211122
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
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211123
x86_64               randconfig-a003-20211123
x86_64               randconfig-a006-20211123
x86_64               randconfig-a004-20211123
x86_64               randconfig-a005-20211123
x86_64               randconfig-a002-20211123
i386                 randconfig-a001-20211123
i386                 randconfig-a002-20211123
i386                 randconfig-a005-20211123
i386                 randconfig-a006-20211123
i386                 randconfig-a004-20211123
i386                 randconfig-a003-20211123
x86_64               randconfig-a014-20211122
x86_64               randconfig-a011-20211122
x86_64               randconfig-a012-20211122
x86_64               randconfig-a016-20211122
x86_64               randconfig-a013-20211122
x86_64               randconfig-a015-20211122
i386                 randconfig-a016-20211122
i386                 randconfig-a015-20211122
i386                 randconfig-a012-20211122
i386                 randconfig-a013-20211122
i386                 randconfig-a014-20211122
i386                 randconfig-a011-20211122
arc                  randconfig-r043-20211122
s390                 randconfig-r044-20211122
riscv                randconfig-r042-20211122
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211123
i386                 randconfig-c001-20211123
powerpc              randconfig-c003-20211123
arm                  randconfig-c002-20211123
riscv                randconfig-c006-20211123
x86_64               randconfig-c007-20211123
mips                 randconfig-c004-20211123
i386                 randconfig-a001-20211122
i386                 randconfig-a002-20211122
i386                 randconfig-a005-20211122
i386                 randconfig-a006-20211122
i386                 randconfig-a004-20211122
i386                 randconfig-a003-20211122
x86_64               randconfig-a014-20211123
x86_64               randconfig-a011-20211123
x86_64               randconfig-a012-20211123
x86_64               randconfig-a016-20211123
x86_64               randconfig-a013-20211123
x86_64               randconfig-a015-20211123
i386                 randconfig-a016-20211123
i386                 randconfig-a015-20211123
i386                 randconfig-a012-20211123
i386                 randconfig-a013-20211123
i386                 randconfig-a014-20211123
i386                 randconfig-a011-20211123
x86_64               randconfig-a001-20211122
x86_64               randconfig-a003-20211122
x86_64               randconfig-a006-20211122
x86_64               randconfig-a004-20211122
x86_64               randconfig-a005-20211122
x86_64               randconfig-a002-20211122
hexagon              randconfig-r045-20211123
s390                 randconfig-r044-20211123
hexagon              randconfig-r041-20211123
riscv                randconfig-r042-20211123

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EEB37B5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 08:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhELGTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 02:19:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:41907 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhELGTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 02:19:15 -0400
IronPort-SDR: 8VR/McrrqP2NDzHraoFmgHVUiAkNwhspaXaPgplInRrizzdDBqR/vNqRy3aFosUYCRx1YE/vPs
 Gq8wNTNOoayA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="187059473"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="187059473"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 23:17:51 -0700
IronPort-SDR: eKCNMpeHPWLmk7vJIwjhuSmXBop7XerPWQWy872xdGO86m0g2BRrimnNjVJ8HpeYt6nQhGXy1U
 voQZiO92UGew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="625097068"
Received: from lkp-server01.sh.intel.com (HELO 1e931876798f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 May 2021 23:17:50 -0700
Received: from kbuild by 1e931876798f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgiBp-000027-F3; Wed, 12 May 2021 06:17:49 +0000
Date:   Wed, 12 May 2021 14:16:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS
 2515dd6ce8e545b0b2eece84920048ef9ed846c4
Message-ID: <609b72d9.ZKqSJCdOfS+r7bXa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
branch HEAD: 2515dd6ce8e545b0b2eece84920048ef9ed846c4  stack: Replace "o" output with "r" input constraint

elapsed time: 1325m

configs tested: 216
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
powerpc                    amigaone_defconfig
nios2                            allyesconfig
mips                      malta_kvm_defconfig
arm                           u8500_defconfig
sh                            hp6xx_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     pseries_defconfig
powerpc                  storcenter_defconfig
arm                      footbridge_defconfig
mips                            gpr_defconfig
sh                           se7705_defconfig
mips                        workpad_defconfig
arm                        shmobile_defconfig
arm                  colibri_pxa270_defconfig
arm                         axm55xx_defconfig
m68k                       m5475evb_defconfig
sparc                       sparc64_defconfig
powerpc                   currituck_defconfig
m68k                        mvme147_defconfig
sh                             shx3_defconfig
mips                        qi_lb60_defconfig
parisc                generic-32bit_defconfig
powerpc                     tqm8548_defconfig
powerpc64                           defconfig
powerpc                     ep8248e_defconfig
mips                      bmips_stb_defconfig
mips                         tb0226_defconfig
powerpc                     tqm8541_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc64e_defconfig
arm                         s3c2410_defconfig
arm                           viper_defconfig
arm                          gemini_defconfig
arm                          pcm027_defconfig
powerpc                     tqm8540_defconfig
sh                              ul2_defconfig
mips                     loongson1c_defconfig
arm                        mvebu_v5_defconfig
mips                          ath25_defconfig
sh                            migor_defconfig
mips                     decstation_defconfig
m68k                        m5407c3_defconfig
arm                            xcep_defconfig
h8300                     edosk2674_defconfig
powerpc                        fsp2_defconfig
xtensa                           alldefconfig
powerpc                     tqm8560_defconfig
powerpc                     ppa8548_defconfig
arm                        multi_v7_defconfig
arm                       mainstone_defconfig
mips                            ar7_defconfig
powerpc                      bamboo_defconfig
arm                        mvebu_v7_defconfig
arm                        clps711x_defconfig
powerpc                     stx_gp3_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7721_defconfig
sh                          polaris_defconfig
mips                           ip27_defconfig
sh                           se7751_defconfig
arm                            pleb_defconfig
sh                               alldefconfig
arc                    vdk_hs38_smp_defconfig
powerpc                       holly_defconfig
sh                        apsh4ad0a_defconfig
mips                       lemote2f_defconfig
xtensa                generic_kc705_defconfig
arm                             mxs_defconfig
arm                           tegra_defconfig
ia64                             alldefconfig
arm                        spear3xx_defconfig
arm                              alldefconfig
sh                          lboxre2_defconfig
powerpc                       maple_defconfig
xtensa                         virt_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                        edosk7760_defconfig
mips                       capcella_defconfig
nios2                         10m50_defconfig
arm                             rpc_defconfig
arc                           tb10x_defconfig
mips                        nlm_xlp_defconfig
powerpc                  mpc866_ads_defconfig
sh                 kfr2r09-romimage_defconfig
riscv                             allnoconfig
s390                                defconfig
m68k                       m5208evb_defconfig
sh                        sh7763rdp_defconfig
sh                             espt_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                    ge_imp3a_defconfig
arc                        vdk_hs38_defconfig
arm                         socfpga_defconfig
m68k                          amiga_defconfig
nios2                         3c120_defconfig
arm                           stm32_defconfig
sh                        dreamcast_defconfig
sh                           se7780_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                        jmr3927_defconfig
arm                       imx_v4_v5_defconfig
sh                                  defconfig
sh                          rsk7264_defconfig
powerpc                     pq2fads_defconfig
arm                           sama5_defconfig
powerpc                   lite5200b_defconfig
s390                          debug_defconfig
m68k                        m5307c3_defconfig
powerpc                 linkstation_defconfig
arm                       netwinder_defconfig
sh                           sh2007_defconfig
m68k                        mvme16x_defconfig
powerpc                         wii_defconfig
ia64                         bigsur_defconfig
powerpc                         ps3_defconfig
sh                          r7785rp_defconfig
mips                        omega2p_defconfig
arm                          imote2_defconfig
alpha                            alldefconfig
sh                               j2_defconfig
powerpc                     tqm8555_defconfig
mips                          ath79_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                         tb0287_defconfig
m68k                            q40_defconfig
arm                         assabet_defconfig
m68k                           sun3_defconfig
arm                             pxa_defconfig
powerpc                   bluestone_defconfig
arm                         bcm2835_defconfig
openrisc                    or1ksim_defconfig
arm                         at91_dt_defconfig
sh                            titan_defconfig
x86_64                           alldefconfig
powerpc                      chrp32_defconfig
arm                      tct_hammer_defconfig
arm                     am200epdkit_defconfig
um                            kunit_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210511
i386                 randconfig-a001-20210511
i386                 randconfig-a005-20210511
i386                 randconfig-a004-20210511
i386                 randconfig-a002-20210511
i386                 randconfig-a006-20210511
x86_64               randconfig-a012-20210511
x86_64               randconfig-a015-20210511
x86_64               randconfig-a011-20210511
x86_64               randconfig-a013-20210511
x86_64               randconfig-a016-20210511
x86_64               randconfig-a014-20210511
i386                 randconfig-a016-20210511
i386                 randconfig-a014-20210511
i386                 randconfig-a011-20210511
i386                 randconfig-a015-20210511
i386                 randconfig-a012-20210511
i386                 randconfig-a013-20210511
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210511
x86_64               randconfig-a004-20210511
x86_64               randconfig-a001-20210511
x86_64               randconfig-a005-20210511
x86_64               randconfig-a002-20210511
x86_64               randconfig-a006-20210511

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

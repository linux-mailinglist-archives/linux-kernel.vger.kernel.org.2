Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFC741E9A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353013AbhJAJfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 05:35:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:59914 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352995AbhJAJfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 05:35:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="310926100"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="310926100"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 02:33:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="556212054"
Received: from lkp-server01.sh.intel.com (HELO 72c3bd3cf19c) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2021 02:33:47 -0700
Received: from kbuild by 72c3bd3cf19c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mWEvL-00010i-9i; Fri, 01 Oct 2021 09:33:47 +0000
Date:   Fri, 01 Oct 2021 17:33:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-fixes] BUILD SUCCESS
 3831a0d40886a227dfa6ce85819f50acb634ab41
Message-ID: <6156d5f2.1tO5vtoZEPVYe4qO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-fixes
branch HEAD: 3831a0d40886a227dfa6ce85819f50acb634ab41  firewire: Remove function callback casts

elapsed time: 1420m

configs tested: 287
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20210930
i386                 randconfig-c001-20211001
powerpc              randconfig-c003-20210930
arm                         s3c6400_defconfig
mips                malta_qemu_32r6_defconfig
sh                   secureedge5410_defconfig
m68k                         amcore_defconfig
sh                            shmin_defconfig
powerpc                   motionpro_defconfig
sh                           se7750_defconfig
arm                       imx_v6_v7_defconfig
mips                           xway_defconfig
csky                             alldefconfig
mips                        workpad_defconfig
arc                        vdk_hs38_defconfig
mips                        maltaup_defconfig
arm                        vexpress_defconfig
arm                       multi_v4t_defconfig
powerpc                        cell_defconfig
mips                     loongson2k_defconfig
mips                         mpc30x_defconfig
mips                          rb532_defconfig
arm                     eseries_pxa_defconfig
sh                   sh7770_generic_defconfig
x86_64                              defconfig
mips                        vocore2_defconfig
arm                        spear3xx_defconfig
sh                           se7722_defconfig
alpha                            alldefconfig
arm                           h3600_defconfig
arm                          ep93xx_defconfig
arc                              allyesconfig
powerpc                    amigaone_defconfig
sparc                       sparc64_defconfig
mips                            gpr_defconfig
sh                           se7721_defconfig
sh                   sh7724_generic_defconfig
mips                         db1xxx_defconfig
powerpc                       eiger_defconfig
powerpc                          allmodconfig
sh                           se7619_defconfig
powerpc                 mpc836x_mds_defconfig
sh                                  defconfig
riscv                            alldefconfig
powerpc                      cm5200_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     kilauea_defconfig
sh                               alldefconfig
mips                           mtx1_defconfig
arm                       aspeed_g5_defconfig
sh                        sh7763rdp_defconfig
ia64                          tiger_defconfig
powerpc                    ge_imp3a_defconfig
arm                          gemini_defconfig
powerpc                       ebony_defconfig
arm                            mmp2_defconfig
arc                        nsim_700_defconfig
arm                       netwinder_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                              defconfig
mips                          ath79_defconfig
microblaze                          defconfig
powerpc                     tqm8541_defconfig
powerpc                      mgcoge_defconfig
mips                          rm200_defconfig
powerpc                     mpc83xx_defconfig
arm                       mainstone_defconfig
mips                     loongson1b_defconfig
powerpc                      ppc64e_defconfig
sh                           se7780_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      ppc40x_defconfig
arm                           viper_defconfig
arm                       imx_v4_v5_defconfig
arm                           corgi_defconfig
arm                        magician_defconfig
mips                          ath25_defconfig
powerpc                     stx_gp3_defconfig
mips                         tb0287_defconfig
powerpc                     powernv_defconfig
arm                        oxnas_v6_defconfig
arm                        spear6xx_defconfig
sh                            titan_defconfig
sh                             espt_defconfig
powerpc                        icon_defconfig
arm                            zeus_defconfig
sh                           se7724_defconfig
sparc                            allyesconfig
arm                   milbeaut_m10v_defconfig
arm                          iop32x_defconfig
mips                         cobalt_defconfig
sh                          sdk7786_defconfig
powerpc                     ksi8560_defconfig
h8300                       h8s-sim_defconfig
arm                         bcm2835_defconfig
arm                            lart_defconfig
sparc64                             defconfig
arm                           tegra_defconfig
m68k                         apollo_defconfig
powerpc                 mpc8560_ads_defconfig
mips                     cu1000-neo_defconfig
mips                        qi_lb60_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    klondike_defconfig
powerpc                     taishan_defconfig
mips                        nlm_xlr_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      pcm030_defconfig
powerpc                 linkstation_defconfig
s390                       zfcpdump_defconfig
powerpc                      tqm8xx_defconfig
m68k                            q40_defconfig
arm                  colibri_pxa270_defconfig
sh                        edosk7705_defconfig
arm                  colibri_pxa300_defconfig
arm                         at91_dt_defconfig
sh                ecovec24-romimage_defconfig
arm                             ezx_defconfig
arm                         assabet_defconfig
m68k                       m5475evb_defconfig
mips                       rbtx49xx_defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
m68k                        m5272c3_defconfig
sh                              ul2_defconfig
sh                     magicpanelr2_defconfig
openrisc                            defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8540_defconfig
arm                        multi_v7_defconfig
m68k                        m5307c3_defconfig
sh                           se7751_defconfig
arm                          simpad_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-64bit_defconfig
powerpc                     pseries_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                           u8500_defconfig
xtensa                       common_defconfig
arc                        nsimosci_defconfig
arm                              alldefconfig
mips                          malta_defconfig
riscv                          rv32_defconfig
s390                          debug_defconfig
csky                                defconfig
ia64                             alldefconfig
ia64                             allyesconfig
powerpc                    socrates_defconfig
um                             i386_defconfig
sh                        apsh4ad0a_defconfig
mips                       bmips_be_defconfig
mips                       lemote2f_defconfig
powerpc                     tqm5200_defconfig
powerpc64                           defconfig
x86_64                           alldefconfig
mips                            e55_defconfig
mips                      malta_kvm_defconfig
arm                         palmz72_defconfig
arm                          ixp4xx_defconfig
powerpc                     mpc512x_defconfig
mips                   sb1250_swarm_defconfig
powerpc                 mpc8272_ads_defconfig
arm                       aspeed_g4_defconfig
arm                            qcom_defconfig
arm                           sama7_defconfig
powerpc                   microwatt_defconfig
powerpc                      obs600_defconfig
ia64                        generic_defconfig
sh                            hp6xx_defconfig
powerpc                     redwood_defconfig
arm                       omap2plus_defconfig
sh                          r7780mp_defconfig
powerpc                         ps3_defconfig
arc                          axs101_defconfig
powerpc                 mpc834x_itx_defconfig
mips                       capcella_defconfig
arm                          pxa168_defconfig
xtensa                    xip_kc705_defconfig
arc                         haps_hs_defconfig
arc                           tb10x_defconfig
arm                  randconfig-c002-20210930
x86_64               randconfig-c001-20210930
x86_64               randconfig-c001-20211001
arm                  randconfig-c002-20211001
ia64                                defconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
x86_64               randconfig-a003-20211001
x86_64               randconfig-a005-20211001
x86_64               randconfig-a001-20211001
x86_64               randconfig-a002-20211001
x86_64               randconfig-a004-20211001
x86_64               randconfig-a006-20211001
x86_64               randconfig-a004-20210930
x86_64               randconfig-a001-20210930
x86_64               randconfig-a002-20210930
x86_64               randconfig-a005-20210930
x86_64               randconfig-a006-20210930
x86_64               randconfig-a003-20210930
i386                 randconfig-a003-20210930
i386                 randconfig-a001-20210930
i386                 randconfig-a004-20210930
i386                 randconfig-a002-20210930
i386                 randconfig-a006-20210930
i386                 randconfig-a005-20210930
i386                 randconfig-a001-20211001
i386                 randconfig-a003-20211001
i386                 randconfig-a005-20211001
i386                 randconfig-a002-20211001
i386                 randconfig-a004-20211001
i386                 randconfig-a006-20211001
arc                  randconfig-r043-20210930
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
i386                 randconfig-c001-20210930
arm                  randconfig-c002-20210930
powerpc              randconfig-c003-20210930
mips                 randconfig-c004-20210930
s390                 randconfig-c005-20210930
riscv                randconfig-c006-20210930
x86_64               randconfig-c007-20210930
x86_64               randconfig-c007-20211001
i386                 randconfig-c001-20211001
arm                  randconfig-c002-20211001
s390                 randconfig-c005-20211001
powerpc              randconfig-c003-20211001
riscv                randconfig-c006-20211001
mips                 randconfig-c004-20211001
x86_64               randconfig-a015-20210930
x86_64               randconfig-a011-20210930
x86_64               randconfig-a012-20210930
x86_64               randconfig-a013-20210930
x86_64               randconfig-a016-20210930
x86_64               randconfig-a014-20210930
x86_64               randconfig-a015-20211001
x86_64               randconfig-a012-20211001
x86_64               randconfig-a016-20211001
x86_64               randconfig-a014-20211001
x86_64               randconfig-a013-20211001
x86_64               randconfig-a011-20211001
i386                 randconfig-a014-20210930
i386                 randconfig-a013-20210930
i386                 randconfig-a011-20210930
i386                 randconfig-a015-20210930
i386                 randconfig-a016-20210930
i386                 randconfig-a012-20210930
riscv                randconfig-r042-20210930
hexagon              randconfig-r041-20210930
s390                 randconfig-r044-20210930
hexagon              randconfig-r045-20210930
hexagon              randconfig-r045-20211001
hexagon              randconfig-r041-20211001
s390                 randconfig-r044-20211001
riscv                randconfig-r042-20211001

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

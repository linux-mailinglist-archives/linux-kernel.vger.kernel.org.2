Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76D139F060
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFHIHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:07:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:36546 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhFHIHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:07:14 -0400
IronPort-SDR: ipvxDWOCtAQTgfAEfiiwkQ8Gc4YjIAkeL9hmo0c9K1q8etk56esP6SQVv0xy5ECXXvoCHtuwZS
 Z7RS0QsUWNDA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="201776101"
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="201776101"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 01:05:21 -0700
IronPort-SDR: JtSzRtqX9OMjYvemGeAVLMyRGdKSNaTn4yoPEntggF876g892HjLc4IqNpNDJ3bUh4mRDQyLW0
 qTZqODSb2Pjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="413303587"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2021 01:05:20 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lqWjf-0008uR-RA; Tue, 08 Jun 2021 08:05:19 +0000
Date:   Tue, 08 Jun 2021 16:05:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/kspp] BUILD SUCCESS
 a45cb78e6a9031e34e34b3171414e88a444fd667
Message-ID: <60bf24b4.3mt4eylGOOYLZraD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: a45cb78e6a9031e34e34b3171414e88a444fd667  Merge branch 'for-next/Warray-bounds' into for-next/kspp

elapsed time: 720m

configs tested: 174
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                     davinci_all_defconfig
powerpc64                           defconfig
powerpc                     sbc8548_defconfig
arm                       versatile_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     akebono_defconfig
openrisc                  or1klitex_defconfig
powerpc                       ppc64_defconfig
arm                        multi_v7_defconfig
mips                         tb0219_defconfig
sh                ecovec24-romimage_defconfig
arm                            mmp2_defconfig
arm                           tegra_defconfig
xtensa                           alldefconfig
powerpc                      makalu_defconfig
mips                     loongson2k_defconfig
mips                          rm200_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           omap1_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                             sh03_defconfig
arm                           sama5_defconfig
mips                        omega2p_defconfig
s390                             alldefconfig
sh                            migor_defconfig
m68k                            q40_defconfig
powerpc                 mpc8272_ads_defconfig
arm                             ezx_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                           se7343_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     powernv_defconfig
mips                           rs90_defconfig
arm                         mv78xx0_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
sh                   sh7724_generic_defconfig
mips                       capcella_defconfig
mips                           ip32_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
sh                 kfr2r09-romimage_defconfig
arm                            lart_defconfig
riscv                          rv32_defconfig
powerpc                   motionpro_defconfig
arm                      jornada720_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    adder875_defconfig
x86_64                           alldefconfig
arm                            hisi_defconfig
xtensa                           allyesconfig
arc                            hsdk_defconfig
s390                                defconfig
arc                          axs103_defconfig
mips                       bmips_be_defconfig
powerpc                      pasemi_defconfig
sh                          r7780mp_defconfig
arm                        realview_defconfig
mips                           ci20_defconfig
arm                         axm55xx_defconfig
mips                         db1xxx_defconfig
arm                      footbridge_defconfig
sh                          sdk7780_defconfig
mips                           jazz_defconfig
arm                        mvebu_v5_defconfig
xtensa                  nommu_kc705_defconfig
arc                        nsimosci_defconfig
powerpc                 mpc832x_mds_defconfig
sh                             espt_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
powerpc                         ps3_defconfig
powerpc                     mpc5200_defconfig
m68k                       m5208evb_defconfig
sparc                       sparc64_defconfig
powerpc                 canyonlands_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           ip28_defconfig
powerpc                      ep88xc_defconfig
mips                        maltaup_defconfig
arm                        vexpress_defconfig
sh                           se7619_defconfig
mips                          rb532_defconfig
mips                         tb0226_defconfig
powerpc                     ppa8548_defconfig
powerpc                          allyesconfig
arm                         vf610m4_defconfig
powerpc                mpc7448_hpc2_defconfig
nios2                               defconfig
arm                            qcom_defconfig
mips                           mtx1_defconfig
arm                         s5pv210_defconfig
arc                        vdk_hs38_defconfig
nios2                         10m50_defconfig
parisc                              defconfig
sh                         microdev_defconfig
sh                     magicpanelr2_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                        fsp2_defconfig
x86_64                              defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210607
i386                 randconfig-a006-20210607
i386                 randconfig-a004-20210607
i386                 randconfig-a001-20210607
i386                 randconfig-a002-20210607
i386                 randconfig-a005-20210607
x86_64               randconfig-a015-20210607
x86_64               randconfig-a011-20210607
x86_64               randconfig-a014-20210607
x86_64               randconfig-a012-20210607
x86_64               randconfig-a016-20210607
x86_64               randconfig-a013-20210607
i386                 randconfig-a015-20210607
i386                 randconfig-a013-20210607
i386                 randconfig-a011-20210607
i386                 randconfig-a016-20210607
i386                 randconfig-a014-20210607
i386                 randconfig-a012-20210607
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210607
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

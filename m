Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B744C39EADE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhFHAkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:40:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:63759 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhFHAkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:40:06 -0400
IronPort-SDR: 4W9U8ECziSZU1ScDGlgOKBhg4yKFPJgIxV0pN5B0w4AnVyjOUg67l4oEkZOi9mr3XczhZ+sEZD
 4gmlfdTi9B2w==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="226086133"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="226086133"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 17:38:14 -0700
IronPort-SDR: s95zH8NAbUU0BR+idcxClf6YJ18jainXzWii12i/px4J2/vnUAiQtHgH99Jsx8FefISjaJHHdd
 Ty7I0+35YM+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="551418168"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2021 17:38:12 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lqPkx-0008dM-Vk; Tue, 08 Jun 2021 00:38:11 +0000
Date:   Tue, 08 Jun 2021 08:37:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 23721c8e92f73f9f89e7362c50c2996a5c9ad483
Message-ID: <60bebbb5.k4YxU46FNufye3a1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 23721c8e92f73f9f89e7362c50c2996a5c9ad483  x86/crash: Remove crash_reserve_low_1M()

elapsed time: 732m

configs tested: 198
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                     loongson2k_defconfig
sh                          r7780mp_defconfig
arc                    vdk_hs38_smp_defconfig
arm                      pxa255-idp_defconfig
arm                         assabet_defconfig
arc                          axs103_defconfig
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
powerpc                    sam440ep_defconfig
m68k                         amcore_defconfig
arm                           viper_defconfig
sh                     sh7710voipgw_defconfig
s390                          debug_defconfig
arc                            hsdk_defconfig
mips                            e55_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                          rm200_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           omap1_defconfig
sh                             sh03_defconfig
sh                          sdk7780_defconfig
sparc64                          alldefconfig
h8300                    h8300h-sim_defconfig
powerpc                     ksi8560_defconfig
s390                                defconfig
powerpc                 xes_mpc85xx_defconfig
arm                           sama5_defconfig
mips                        omega2p_defconfig
s390                             alldefconfig
sh                            migor_defconfig
openrisc                         alldefconfig
powerpc                    mvme5100_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
powerpc                      ppc44x_defconfig
m68k                            q40_defconfig
powerpc                 mpc8272_ads_defconfig
arm                             ezx_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                           se7343_defconfig
arc                     nsimosci_hs_defconfig
mips                      pic32mzda_defconfig
riscv                            alldefconfig
arm                        cerfcube_defconfig
mips                      malta_kvm_defconfig
arm                          ep93xx_defconfig
alpha                            allyesconfig
powerpc                mpc7448_hpc2_defconfig
sh                        sh7757lcr_defconfig
powerpc                  mpc866_ads_defconfig
sh                 kfr2r09-romimage_defconfig
x86_64                           allyesconfig
arm                            lart_defconfig
mips                           ip32_defconfig
riscv                          rv32_defconfig
powerpc                   motionpro_defconfig
arm                      jornada720_defconfig
arm                        realview_defconfig
m68k                            mac_defconfig
x86_64                            allnoconfig
powerpc                     tqm8548_defconfig
powerpc                     tqm8540_defconfig
arm                           sunxi_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    adder875_defconfig
x86_64                           alldefconfig
arm                            hisi_defconfig
arm                             pxa_defconfig
arm                        shmobile_defconfig
sh                   sh7770_generic_defconfig
m68k                                defconfig
xtensa                           allyesconfig
mips                       bmips_be_defconfig
powerpc                      pasemi_defconfig
mips                           ci20_defconfig
riscv                    nommu_k210_defconfig
arc                              allyesconfig
sh                          rsk7264_defconfig
arm                             mxs_defconfig
um                             i386_defconfig
powerpc                      ppc6xx_defconfig
arm                         axm55xx_defconfig
mips                         db1xxx_defconfig
arm                      footbridge_defconfig
h8300                     edosk2674_defconfig
nds32                             allnoconfig
mips                           jazz_defconfig
arm                        mvebu_v5_defconfig
arc                        nsimosci_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                 mpc832x_mds_defconfig
sh                             espt_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                         ps3_defconfig
powerpc                     mpc5200_defconfig
m68k                       m5208evb_defconfig
sparc                       sparc64_defconfig
powerpc                 canyonlands_defconfig
sh                          lboxre2_defconfig
sh                               alldefconfig
mips                           mtx1_defconfig
powerpc                          g5_defconfig
arm                         mv78xx0_defconfig
um                           x86_64_defconfig
s390                       zfcpdump_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                            qcom_defconfig
arm                         s5pv210_defconfig
powerpc                 linkstation_defconfig
ia64                        generic_defconfig
powerpc                     taishan_defconfig
arm                         palmz72_defconfig
arm                         lpc32xx_defconfig
sh                      rts7751r2d1_defconfig
sh                                  defconfig
powerpc                        warp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                          allmodconfig
arm                          lpd270_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                        fsp2_defconfig
x86_64                              defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
csky                                defconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                            kunit_defconfig
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765F839AF47
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 02:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFDBAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:00:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:39988 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhFDBA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:00:29 -0400
IronPort-SDR: qDZM4P+vFDCGUTbIP965hgVSWiZhKXJDYyvy2toED6TC2iLNgHBOSabJIaII1vDu6zYuR8wnKU
 ynMUydzxx56w==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="204008154"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="204008154"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:58:34 -0700
IronPort-SDR: YRpe7Jp2DFHdvsi7S01sCXl6a4tFY9mxEUMENsaZLN4pfY5gBvhYermqVH3ihO+RlVBsg4AyNB
 pKX8DkaJIx/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="550906405"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jun 2021 17:58:33 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1loyAS-0006XD-MP; Fri, 04 Jun 2021 00:58:32 +0000
Date:   Fri, 04 Jun 2021 08:58:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/testing] BUILD SUCCESS
 ddaa22b54f133972330447c9be6680683eaa5097
Message-ID: <60b97aaa.HfB64pVnvPDcgZ5F%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/testing
branch HEAD: ddaa22b54f133972330447c9be6680683eaa5097  treewide: Fix fall-through warnings for Clang

elapsed time: 11571m

configs tested: 180
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                         amcore_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc44x_defconfig
mips                        nlm_xlp_defconfig
powerpc                  iss476-smp_defconfig
powerpc                    sam440ep_defconfig
sh                        edosk7760_defconfig
arm                          iop32x_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
sh                          lboxre2_defconfig
powerpc                       maple_defconfig
sh                          sdk7780_defconfig
mips                      malta_kvm_defconfig
arm                         palmz72_defconfig
mips                       bmips_be_defconfig
arm                           sunxi_defconfig
powerpc                     tqm8560_defconfig
powerpc                     skiroot_defconfig
m68k                       m5475evb_defconfig
m68k                        m5307c3_defconfig
m68k                         apollo_defconfig
sh                           se7712_defconfig
arm                        keystone_defconfig
s390                          debug_defconfig
mips                     loongson1b_defconfig
mips                      pistachio_defconfig
sh                   rts7751r2dplus_defconfig
mips                  maltasmvp_eva_defconfig
arm                      footbridge_defconfig
mips                  decstation_64_defconfig
openrisc                 simple_smp_defconfig
arm                     davinci_all_defconfig
arc                        vdk_hs38_defconfig
sparc64                          alldefconfig
arm                          pxa910_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                     nsimosci_hs_defconfig
ia64                             allmodconfig
sh                            shmin_defconfig
arm                          collie_defconfig
powerpc                     ppa8548_defconfig
mips                         tb0287_defconfig
arm64                            alldefconfig
mips                        bcm47xx_defconfig
h8300                               defconfig
sh                     sh7710voipgw_defconfig
mips                           ip22_defconfig
powerpc                    amigaone_defconfig
mips                    maltaup_xpa_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                       ebony_defconfig
mips                        vocore2_defconfig
mips                        workpad_defconfig
arm                          moxart_defconfig
mips                          malta_defconfig
powerpc                     pseries_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          r7780mp_defconfig
powerpc                    mvme5100_defconfig
mips                          ath79_defconfig
arm                          lpd270_defconfig
mips                          rm200_defconfig
riscv                    nommu_virt_defconfig
arm                          ep93xx_defconfig
sh                           se7343_defconfig
ia64                             allyesconfig
powerpc                   lite5200b_defconfig
alpha                               defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8548_defconfig
arm                        multi_v5_defconfig
mips                            e55_defconfig
mips                        omega2p_defconfig
arm                        mini2440_defconfig
arm                          badge4_defconfig
ia64                             alldefconfig
powerpc                 mpc836x_mds_defconfig
arm                      jornada720_defconfig
powerpc                    ge_imp3a_defconfig
sh                          polaris_defconfig
powerpc                      obs600_defconfig
powerpc                        fsp2_defconfig
arm                        multi_v7_defconfig
nios2                         3c120_defconfig
sh                          kfr2r09_defconfig
arc                      axs103_smp_defconfig
arm                        cerfcube_defconfig
mips                           ci20_defconfig
xtensa                  cadence_csp_defconfig
xtensa                           allyesconfig
arm                       omap2plus_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     mpc83xx_defconfig
microblaze                          defconfig
powerpc                   motionpro_defconfig
powerpc                      bamboo_defconfig
arm                     am200epdkit_defconfig
arm                          exynos_defconfig
mips                     cu1830-neo_defconfig
arm                           corgi_defconfig
mips                     cu1000-neo_defconfig
parisc                generic-64bit_defconfig
mips                         rt305x_defconfig
arm                        mvebu_v5_defconfig
mips                      maltaaprp_defconfig
x86_64                            allnoconfig
ia64                                defconfig
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
x86_64               randconfig-a005-20210526
x86_64               randconfig-a001-20210526
x86_64               randconfig-a006-20210526
x86_64               randconfig-a003-20210526
x86_64               randconfig-a004-20210526
x86_64               randconfig-a002-20210526
i386                 randconfig-a001-20210526
i386                 randconfig-a002-20210526
i386                 randconfig-a005-20210526
i386                 randconfig-a004-20210526
i386                 randconfig-a003-20210526
i386                 randconfig-a006-20210526
i386                 randconfig-a011-20210526
i386                 randconfig-a016-20210526
i386                 randconfig-a015-20210526
i386                 randconfig-a012-20210526
i386                 randconfig-a014-20210526
i386                 randconfig-a013-20210526
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210526
x86_64               randconfig-a013-20210526
x86_64               randconfig-a012-20210526
x86_64               randconfig-a014-20210526
x86_64               randconfig-a016-20210526
x86_64               randconfig-a015-20210526
x86_64               randconfig-a011-20210526

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

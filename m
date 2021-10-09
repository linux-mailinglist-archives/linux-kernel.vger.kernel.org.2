Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C05427C10
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhJIQjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:39:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:55992 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhJIQjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:39:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="226961587"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="226961587"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 09:37:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="440253688"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2021 09:37:52 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mZFM7-0000OT-Sa; Sat, 09 Oct 2021 16:37:51 +0000
Date:   Sun, 10 Oct 2021 00:36:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 d298b03506d3e161f7492c440babb0bfae35e650
Message-ID: <6161c528.6gaU4HbrwHlcFRMR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: d298b03506d3e161f7492c440babb0bfae35e650  x86/fpu: Restore the masking out of reserved MXCSR bits

elapsed time: 1803m

configs tested: 182
configs skipped: 77

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
i386                 randconfig-c001-20211009
sh                           se7206_defconfig
sh                   sh7724_generic_defconfig
powerpc                      pasemi_defconfig
x86_64                              defconfig
arm                        cerfcube_defconfig
nios2                         10m50_defconfig
mips                       capcella_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                        omega2p_defconfig
sh                        dreamcast_defconfig
mips                           gcw0_defconfig
sh                        sh7763rdp_defconfig
mips                        jmr3927_defconfig
s390                                defconfig
powerpc                     pq2fads_defconfig
arc                         haps_hs_defconfig
mips                         mpc30x_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                          multi_defconfig
arm                         axm55xx_defconfig
arm                           stm32_defconfig
powerpc                     pseries_defconfig
xtensa                           alldefconfig
arm                          moxart_defconfig
sh                           se7724_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                       cns3420vb_defconfig
mips                           rs90_defconfig
xtensa                              defconfig
powerpc                     mpc83xx_defconfig
sh                      rts7751r2d1_defconfig
m68k                          atari_defconfig
arm                             mxs_defconfig
sh                   sh7770_generic_defconfig
arm                        mvebu_v7_defconfig
powerpc                      tqm8xx_defconfig
powerpc                 mpc8560_ads_defconfig
sh                            titan_defconfig
sh                             espt_defconfig
arm                      jornada720_defconfig
powerpc                  mpc885_ads_defconfig
arm                       imx_v4_v5_defconfig
arm                          collie_defconfig
sh                               allmodconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                  storcenter_defconfig
powerpc                    gamecube_defconfig
sh                        edosk7705_defconfig
mips                        bcm63xx_defconfig
mips                     loongson1b_defconfig
arm64                            alldefconfig
mips                    maltaup_xpa_defconfig
riscv                             allnoconfig
arm                          ixp4xx_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
sh                           se7712_defconfig
sh                   secureedge5410_defconfig
arm                        vexpress_defconfig
powerpc                      ppc40x_defconfig
um                                  defconfig
mips                           ip22_defconfig
mips                   sb1250_swarm_defconfig
arm                        realview_defconfig
arm                       versatile_defconfig
powerpc                 mpc836x_mds_defconfig
arm                          gemini_defconfig
m68k                            q40_defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                               j2_defconfig
sh                            shmin_defconfig
sh                           se7619_defconfig
sh                           se7721_defconfig
powerpc                      arches_defconfig
arm                           u8500_defconfig
h8300                    h8300h-sim_defconfig
arm                           viper_defconfig
mips                 decstation_r4k_defconfig
m68k                        m5307c3_defconfig
arm                   milbeaut_m10v_defconfig
arm                  colibri_pxa270_defconfig
arm                            mps2_defconfig
sh                          lboxre2_defconfig
mips                           xway_defconfig
x86_64               randconfig-c001-20211009
arm                  randconfig-c002-20211009
x86_64               randconfig-c001-20211008
i386                 randconfig-c001-20211008
arm                  randconfig-c002-20211008
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20211009
x86_64               randconfig-a005-20211009
x86_64               randconfig-a001-20211009
x86_64               randconfig-a002-20211009
x86_64               randconfig-a004-20211009
x86_64               randconfig-a006-20211009
i386                 randconfig-a001-20211009
i386                 randconfig-a003-20211009
i386                 randconfig-a005-20211009
i386                 randconfig-a004-20211009
i386                 randconfig-a002-20211009
i386                 randconfig-a006-20211009
x86_64               randconfig-a015-20211008
x86_64               randconfig-a012-20211008
x86_64               randconfig-a016-20211008
x86_64               randconfig-a013-20211008
x86_64               randconfig-a011-20211008
x86_64               randconfig-a014-20211008
i386                 randconfig-a013-20211008
i386                 randconfig-a016-20211008
i386                 randconfig-a014-20211008
i386                 randconfig-a011-20211008
i386                 randconfig-a012-20211008
i386                 randconfig-a015-20211008
arc                  randconfig-r043-20211008
s390                 randconfig-r044-20211008
riscv                randconfig-r042-20211008
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a003-20211008
x86_64               randconfig-a005-20211008
x86_64               randconfig-a001-20211008
x86_64               randconfig-a002-20211008
x86_64               randconfig-a004-20211008
x86_64               randconfig-a006-20211008
i386                 randconfig-a001-20211008
i386                 randconfig-a003-20211008
i386                 randconfig-a005-20211008
i386                 randconfig-a004-20211008
i386                 randconfig-a002-20211008
i386                 randconfig-a006-20211008
x86_64               randconfig-a015-20211009
x86_64               randconfig-a012-20211009
x86_64               randconfig-a016-20211009
x86_64               randconfig-a013-20211009
x86_64               randconfig-a011-20211009
x86_64               randconfig-a014-20211009
i386                 randconfig-a013-20211009
i386                 randconfig-a016-20211009
i386                 randconfig-a014-20211009
i386                 randconfig-a012-20211009
i386                 randconfig-a011-20211009
i386                 randconfig-a015-20211009
hexagon              randconfig-r045-20211009
hexagon              randconfig-r041-20211009
s390                 randconfig-r044-20211009
riscv                randconfig-r042-20211009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

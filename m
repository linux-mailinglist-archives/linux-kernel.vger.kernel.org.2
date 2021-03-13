Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29052339A42
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 01:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhCMAE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 19:04:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:61339 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235916AbhCMAEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 19:04:15 -0500
IronPort-SDR: elYwwFohj2fGY0rxwcOcmfVIEcaUYLRXVPtuuUdTiDvToR0SCLefTGRJd8Tq33vASyOENonKow
 Gimjxf/3g5xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168823261"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="168823261"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 16:04:08 -0800
IronPort-SDR: KKv46a+nOHPYH8LqJsykw8QsmADHFvo+oKUwu76TFgbeRJh0flP5PmeCqLWf0W9PSgz0FhYZ0Q
 CBwbQPA2+vfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="521581864"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2021 16:04:05 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKrlF-0001h7-6w; Sat, 13 Mar 2021 00:04:05 +0000
Date:   Sat, 13 Mar 2021 08:03:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD SUCCESS
 054ac8ad5ebe4a69e1f0e842483821ddbe560121
Message-ID: <604c014e.5dHlm+m2FZlaOhCT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: 054ac8ad5ebe4a69e1f0e842483821ddbe560121  x86/paravirt: Have only one paravirt patch function

elapsed time: 720m

configs tested: 161
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
arm                     davinci_all_defconfig
powerpc                      pasemi_defconfig
powerpc                     powernv_defconfig
arm                   milbeaut_m10v_defconfig
arm                       versatile_defconfig
arm                          moxart_defconfig
arm                        cerfcube_defconfig
sh                            migor_defconfig
mips                        bcm63xx_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
mips                        nlm_xlp_defconfig
mips                   sb1250_swarm_defconfig
arm                             pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     pseries_defconfig
arm                        mini2440_defconfig
arm                        keystone_defconfig
sh                           se7780_defconfig
sh                          sdk7786_defconfig
sparc                            alldefconfig
m68k                            mac_defconfig
powerpc                      ppc44x_defconfig
h8300                     edosk2674_defconfig
sh                          r7785rp_defconfig
arm                          iop32x_defconfig
arm                          badge4_defconfig
m68k                        m5307c3_defconfig
mips                      pistachio_defconfig
ia64                             alldefconfig
arm                       aspeed_g5_defconfig
powerpc                     ep8248e_defconfig
arm                          simpad_defconfig
parisc                generic-64bit_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                         apollo_defconfig
arm                       cns3420vb_defconfig
arc                        nsim_700_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                          allyesconfig
arm                         vf610m4_defconfig
arm                      integrator_defconfig
arm                         s3c6400_defconfig
arm                      footbridge_defconfig
h8300                    h8300h-sim_defconfig
powerpc                     akebono_defconfig
m68k                            q40_defconfig
parisc                           allyesconfig
arm                        oxnas_v6_defconfig
sh                           se7705_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                generic_kc705_defconfig
powerpc                     tqm5200_defconfig
sparc                            allyesconfig
sparc                       sparc32_defconfig
arc                        nsimosci_defconfig
mips                           gcw0_defconfig
arm                       imx_v6_v7_defconfig
mips                          malta_defconfig
mips                        jmr3927_defconfig
mips                       capcella_defconfig
m68k                       bvme6000_defconfig
arm                          pxa3xx_defconfig
sh                        edosk7760_defconfig
arm                  colibri_pxa270_defconfig
mips                      loongson3_defconfig
powerpc                      pmac32_defconfig
arm                          imote2_defconfig
s390                          debug_defconfig
sh                           se7751_defconfig
sparc                       sparc64_defconfig
powerpc                     mpc83xx_defconfig
mips                         tb0226_defconfig
arm                         nhk8815_defconfig
powerpc                         ps3_defconfig
nios2                         10m50_defconfig
arc                           tb10x_defconfig
mips                         tb0287_defconfig
arm                         palmz72_defconfig
alpha                               defconfig
sh                        sh7757lcr_defconfig
sh                          rsk7201_defconfig
arm                       omap2plus_defconfig
powerpc                      bamboo_defconfig
parisc                generic-32bit_defconfig
powerpc                      ppc6xx_defconfig
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
s390                                defconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210312
i386                 randconfig-a005-20210312
i386                 randconfig-a002-20210312
i386                 randconfig-a003-20210312
i386                 randconfig-a004-20210312
i386                 randconfig-a006-20210312
x86_64               randconfig-a011-20210312
x86_64               randconfig-a016-20210312
x86_64               randconfig-a013-20210312
x86_64               randconfig-a014-20210312
x86_64               randconfig-a015-20210312
x86_64               randconfig-a012-20210312
i386                 randconfig-a013-20210312
i386                 randconfig-a016-20210312
i386                 randconfig-a011-20210312
i386                 randconfig-a015-20210312
i386                 randconfig-a014-20210312
i386                 randconfig-a012-20210312
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210312
x86_64               randconfig-a001-20210312
x86_64               randconfig-a005-20210312
x86_64               randconfig-a003-20210312
x86_64               randconfig-a002-20210312
x86_64               randconfig-a004-20210312

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

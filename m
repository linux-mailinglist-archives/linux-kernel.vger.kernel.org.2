Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EF5367346
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbhDUTRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:17:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:30709 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238683AbhDUTRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:17:34 -0400
IronPort-SDR: Yb/i+IWYYTe9KCQIOMPZxMDaHy3u6e8hA+p3/ehKkwTHnmBsaIAz6k3dyH1tocJH/qNfdLw0ra
 a9+mdTMJD01g==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="216410141"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="216410141"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 12:17:00 -0700
IronPort-SDR: wL1GMd3DH4nTUveL+j5Dz6APfmKwDFrODu9dYaVZhjKEfgRMFq1tsJBt2aZz95gxvLE3cWFVM2
 tmrCUtxtXAVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="453031555"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2021 12:16:59 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZILK-0003jJ-Qo; Wed, 21 Apr 2021 19:16:58 +0000
Date:   Thu, 22 Apr 2021 03:16:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c1d2a603724a0c05e09d41753ff4b0409c1e2d56
Message-ID: <60807a1a.DcI2pkipuz1dy1fq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: c1d2a603724a0c05e09d41753ff4b0409c1e2d56  Merge branch 'linus'

elapsed time: 722m

configs tested: 156
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
i386                             allyesconfig
riscv                            allyesconfig
arm                      tct_hammer_defconfig
sh                           se7724_defconfig
mips                      pic32mzda_defconfig
arm64                            alldefconfig
arm                           tegra_defconfig
ia64                            zx1_defconfig
powerpc                    sam440ep_defconfig
arm                       aspeed_g4_defconfig
powerpc                       maple_defconfig
sh                        sh7763rdp_defconfig
arm                              alldefconfig
arm                       omap2plus_defconfig
mips                           rs90_defconfig
arm                      integrator_defconfig
s390                       zfcpdump_defconfig
m68k                        m5307c3_defconfig
arm                          badge4_defconfig
m68k                           sun3_defconfig
mips                           ip22_defconfig
arm                      footbridge_defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
powerpc                  iss476-smp_defconfig
h8300                     edosk2674_defconfig
arm                          pxa3xx_defconfig
s390                             allmodconfig
h8300                               defconfig
arm                          lpd270_defconfig
arm                        multi_v7_defconfig
m68k                          amiga_defconfig
powerpc                      katmai_defconfig
arm                          simpad_defconfig
sh                     magicpanelr2_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     redwood_defconfig
powerpc                          g5_defconfig
arm                           omap1_defconfig
arm                         cm_x300_defconfig
arm                         bcm2835_defconfig
arm                        keystone_defconfig
ia64                         bigsur_defconfig
powerpc                   motionpro_defconfig
mips                     decstation_defconfig
arm                   milbeaut_m10v_defconfig
um                               alldefconfig
arm                       multi_v4t_defconfig
microblaze                          defconfig
mips                        maltaup_defconfig
mips                        bcm47xx_defconfig
powerpc                 canyonlands_defconfig
powerpc                      ppc44x_defconfig
arm                            qcom_defconfig
arc                     haps_hs_smp_defconfig
arm                       imx_v6_v7_defconfig
arm                          collie_defconfig
powerpc                     skiroot_defconfig
mips                      maltaaprp_defconfig
sh                           se7206_defconfig
sh                          sdk7786_defconfig
powerpc                     ksi8560_defconfig
arc                          axs103_defconfig
arm                        clps711x_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                          sun3x_defconfig
sh                          rsk7201_defconfig
xtensa                           alldefconfig
powerpc                 mpc836x_mds_defconfig
mips                     loongson1b_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                        fsp2_defconfig
arm                         mv78xx0_defconfig
powerpc                     mpc83xx_defconfig
sh                           se7722_defconfig
openrisc                         alldefconfig
powerpc                      acadia_defconfig
mips                            e55_defconfig
sh                            migor_defconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210421
x86_64               randconfig-a002-20210421
x86_64               randconfig-a001-20210421
x86_64               randconfig-a005-20210421
x86_64               randconfig-a006-20210421
x86_64               randconfig-a003-20210421
i386                 randconfig-a005-20210421
i386                 randconfig-a002-20210421
i386                 randconfig-a001-20210421
i386                 randconfig-a006-20210421
i386                 randconfig-a004-20210421
i386                 randconfig-a003-20210421
i386                 randconfig-a012-20210421
i386                 randconfig-a014-20210421
i386                 randconfig-a011-20210421
i386                 randconfig-a013-20210421
i386                 randconfig-a015-20210421
i386                 randconfig-a016-20210421
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
x86_64               randconfig-a015-20210421
x86_64               randconfig-a016-20210421
x86_64               randconfig-a011-20210421
x86_64               randconfig-a014-20210421
x86_64               randconfig-a013-20210421
x86_64               randconfig-a012-20210421

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

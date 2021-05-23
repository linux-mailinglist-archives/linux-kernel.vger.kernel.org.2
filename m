Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B510F38D97C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 09:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhEWHpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 03:45:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:34148 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231559AbhEWHpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 03:45:40 -0400
IronPort-SDR: w043QvQxqR1ZXvCKQlfcPNZLuZjwzsItZJmVL6fEb8qP4qKpHaKZ0gyVyPgLksI+RXofuKC1n1
 JQ71wv+nGn+g==
X-IronPort-AV: E=McAfee;i="6200,9189,9992"; a="182050169"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="182050169"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 00:43:36 -0700
IronPort-SDR: 1dPdJnUjRXHP3sLGzPEvHwFkxw2yFrnjqcZCk8XSzgJWvT84NbBd1I2vTgKzAVBde7aOpm5VGq
 9ogOKniMX/ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="469719616"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 23 May 2021 00:43:35 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lkilq-0000lA-GE; Sun, 23 May 2021 07:43:34 +0000
Date:   Sun, 23 May 2021 15:42:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 adba154658a814db4954fce33bdd0e72a2cde776
Message-ID: <60aa0768.c1Z3m88SSMBOHMxj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: adba154658a814db4954fce33bdd0e72a2cde776  Merge branch 'linus'

elapsed time: 723m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                               j2_defconfig
arm                            pleb_defconfig
arm                         lubbock_defconfig
arm                        mvebu_v7_defconfig
sh                           se7619_defconfig
h8300                            allyesconfig
powerpc                      chrp32_defconfig
arm                         hackkit_defconfig
openrisc                            defconfig
openrisc                 simple_smp_defconfig
nds32                            alldefconfig
powerpc                     pq2fads_defconfig
mips                           jazz_defconfig
arm                      pxa255-idp_defconfig
sh                   rts7751r2dplus_defconfig
s390                          debug_defconfig
arm64                            alldefconfig
mips                     cu1000-neo_defconfig
mips                       bmips_be_defconfig
xtensa                  cadence_csp_defconfig
arm                      jornada720_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      ppc6xx_defconfig
arm                           h5000_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     skiroot_defconfig
sh                           se7705_defconfig
arm                          pxa3xx_defconfig
arm                       versatile_defconfig
m68k                            mac_defconfig
mips                        nlm_xlr_defconfig
arm                        multi_v7_defconfig
sh                                  defconfig
m68k                       m5475evb_defconfig
arm                        spear6xx_defconfig
um                             i386_defconfig
xtensa                              defconfig
sh                        edosk7705_defconfig
arm                    vt8500_v6_v7_defconfig
xtensa                           alldefconfig
mips                   sb1250_swarm_defconfig
arm                         nhk8815_defconfig
powerpc                      pasemi_defconfig
powerpc                      obs600_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                 decstation_r4k_defconfig
arc                     haps_hs_smp_defconfig
x86_64                           alldefconfig
arm                         vf610m4_defconfig
h8300                               defconfig
powerpc                     akebono_defconfig
powerpc                       ppc64_defconfig
riscv                          rv32_defconfig
sh                        sh7757lcr_defconfig
mips                           gcw0_defconfig
m68k                            q40_defconfig
sh                        sh7763rdp_defconfig
powerpc                      katmai_defconfig
powerpc                     stx_gp3_defconfig
sh                     magicpanelr2_defconfig
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
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
i386                 randconfig-a001-20210523
i386                 randconfig-a005-20210523
i386                 randconfig-a002-20210523
i386                 randconfig-a003-20210523
i386                 randconfig-a004-20210523
i386                 randconfig-a006-20210523
x86_64               randconfig-a013-20210523
x86_64               randconfig-a014-20210523
x86_64               randconfig-a012-20210523
x86_64               randconfig-a016-20210523
x86_64               randconfig-a015-20210523
x86_64               randconfig-a011-20210523
i386                 randconfig-a016-20210523
i386                 randconfig-a011-20210523
i386                 randconfig-a015-20210523
i386                 randconfig-a012-20210523
i386                 randconfig-a014-20210523
i386                 randconfig-a013-20210523
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210523
x86_64               randconfig-a006-20210523
x86_64               randconfig-a001-20210523
x86_64               randconfig-a005-20210523
x86_64               randconfig-a003-20210523
x86_64               randconfig-a004-20210523
x86_64               randconfig-a002-20210523

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

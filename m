Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880903F9033
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 23:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbhHZVh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 17:37:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:5170 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhHZVhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 17:37:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="215999606"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="215999606"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 14:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="687158070"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2021 14:36:36 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJN35-0001kA-BC; Thu, 26 Aug 2021 21:36:35 +0000
Date:   Fri, 27 Aug 2021 05:36:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 366e7ad6ba5f4cb2ffd0b7316e404d6ee9c0f401
Message-ID: <6128095f.KMWQO+CxxEalEE5Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 366e7ad6ba5f4cb2ffd0b7316e404d6ee9c0f401  sched/fair: Mark tg_is_idle() an inline in the !CONFIG_FAIR_GROUP_SCHED case

possible Warning in current branch (please contact us if interested):

kernel/sched/fair.c:446:21: warning: Access to field 'my_q' results in a dereference of a null pointer (loaded from variable 'se') [clang-analyzer-core.NullDereference]

Warning ids grouped by kconfigs:

clang_recent_errors
`-- mips-randconfig-c004-20210826
    `-- kernel-sched-fair.c:warning:Access-to-field-my_q-results-in-a-dereference-of-a-null-pointer-(loaded-from-variable-se-)-clang-analyzer-core.NullDereference

elapsed time: 748m

configs tested: 176
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210826
arm                          gemini_defconfig
mips                      fuloong2e_defconfig
powerpc                       holly_defconfig
m68k                            mac_defconfig
powerpc                 mpc836x_mds_defconfig
sh                           se7722_defconfig
powerpc                     powernv_defconfig
powerpc                        warp_defconfig
mips                      loongson3_defconfig
powerpc                 mpc834x_itx_defconfig
sh                         microdev_defconfig
arm                       netwinder_defconfig
arm                         mv78xx0_defconfig
ia64                      gensparse_defconfig
arm                        keystone_defconfig
mips                        vocore2_defconfig
sh                           se7721_defconfig
arm                         nhk8815_defconfig
powerpc                    amigaone_defconfig
m68k                       m5249evb_defconfig
arm                            mmp2_defconfig
powerpc                       eiger_defconfig
powerpc                 canyonlands_defconfig
mips                     loongson1b_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                           alldefconfig
arm                        oxnas_v6_defconfig
nds32                            alldefconfig
powerpc                    ge_imp3a_defconfig
sh                          rsk7269_defconfig
powerpc                 mpc837x_mds_defconfig
arm                      integrator_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                          rm200_defconfig
arm                       cns3420vb_defconfig
powerpc                     asp8347_defconfig
m68k                        stmark2_defconfig
arm                        multi_v7_defconfig
mips                     loongson2k_defconfig
powerpc                      ep88xc_defconfig
mips                         bigsur_defconfig
arm                            zeus_defconfig
h8300                     edosk2674_defconfig
powerpc                     pq2fads_defconfig
arm                         bcm2835_defconfig
mips                        jmr3927_defconfig
mips                       bmips_be_defconfig
sh                           se7206_defconfig
arm                          moxart_defconfig
powerpc                      obs600_defconfig
xtensa                generic_kc705_defconfig
arm                         lpc18xx_defconfig
powerpc                          g5_defconfig
xtensa                          iss_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      mgcoge_defconfig
arm                          pcm027_defconfig
arm                   milbeaut_m10v_defconfig
sh                          lboxre2_defconfig
arm                           corgi_defconfig
sh                          sdk7780_defconfig
mips                          malta_defconfig
arm                          ep93xx_defconfig
powerpc                        icon_defconfig
xtensa                    xip_kc705_defconfig
mips                        qi_lb60_defconfig
powerpc                         wii_defconfig
mips                           ci20_defconfig
mips                   sb1250_swarm_defconfig
h8300                       h8s-sim_defconfig
powerpc                      bamboo_defconfig
arm                            mps2_defconfig
arm                           sunxi_defconfig
xtensa                  cadence_csp_defconfig
arm                         shannon_defconfig
arm                             pxa_defconfig
powerpc                   lite5200b_defconfig
powerpc                      pmac32_defconfig
sh                        edosk7760_defconfig
arm64                            alldefconfig
powerpc                      ppc64e_defconfig
mips                        bcm47xx_defconfig
powerpc                      ppc40x_defconfig
arm                        multi_v5_defconfig
powerpc                     pseries_defconfig
arm                           omap1_defconfig
powerpc                  storcenter_defconfig
arm                       spear13xx_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
x86_64               randconfig-a005-20210826
x86_64               randconfig-a006-20210826
x86_64               randconfig-a001-20210826
x86_64               randconfig-a003-20210826
x86_64               randconfig-a004-20210826
x86_64               randconfig-a002-20210826
i386                 randconfig-a006-20210826
i386                 randconfig-a001-20210826
i386                 randconfig-a002-20210826
i386                 randconfig-a005-20210826
i386                 randconfig-a003-20210826
i386                 randconfig-a004-20210826
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210826
s390                 randconfig-c005-20210826
arm                  randconfig-c002-20210826
riscv                randconfig-c006-20210826
powerpc              randconfig-c003-20210826
x86_64               randconfig-c007-20210826
mips                 randconfig-c004-20210826
x86_64               randconfig-a014-20210826
x86_64               randconfig-a015-20210826
x86_64               randconfig-a016-20210826
x86_64               randconfig-a013-20210826
x86_64               randconfig-a012-20210826
x86_64               randconfig-a011-20210826
i386                 randconfig-a011-20210826
i386                 randconfig-a016-20210826
i386                 randconfig-a012-20210826
i386                 randconfig-a014-20210826
i386                 randconfig-a013-20210826
i386                 randconfig-a015-20210826
hexagon              randconfig-r041-20210826
hexagon              randconfig-r045-20210826
riscv                randconfig-r042-20210826
s390                 randconfig-r044-20210826

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

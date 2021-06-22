Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E923B0F76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 23:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhFVVgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 17:36:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:3936 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVVgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:36:44 -0400
IronPort-SDR: HNVJvuwzzmgNocWwWs8Y6FC4c2vSX0Zi0ffH/7/PI7kTQo8fUYmI9IMkVFFqhMCjEP1FsKYrTS
 +4gJ2+uT5iSw==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="206963826"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="206963826"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 14:34:27 -0700
IronPort-SDR: f8Fa9emEbLQUMNOy4AdkUjB9/f/SiONsG3+mr4t903a1q7e8yOfIjSDkDla8WHoHP7H2KNHvgr
 eWtYvbPOn4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="556756264"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2021 14:34:23 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lvo2I-0005TV-Ah; Tue, 22 Jun 2021 21:34:22 +0000
Date:   Wed, 23 Jun 2021 05:34:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD REGRESSION
 7cb5dd8e2c8ce2b8f778f37cfd8bb955d663d16d
Message-ID: <60d25759.z0rUIr09VUv9s4zM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 7cb5dd8e2c8ce2b8f778f37cfd8bb955d663d16d  selftests: futex: Add futex compare requeue test

possible Error/Warning in current branch:

include/linux/atomic-arch-fallback.h:60:32: error: implicit declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'? [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arc-allyesconfig
    `-- include-linux-atomic-arch-fallback.h:error:implicit-declaration-of-function-arch_cmpxchg64

elapsed time: 724m

configs tested: 139
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      mgcoge_defconfig
sh                            titan_defconfig
arm                         s5pv210_defconfig
h8300                            alldefconfig
sh                           se7619_defconfig
arc                          axs103_defconfig
powerpc                      chrp32_defconfig
m68k                        mvme16x_defconfig
openrisc                            defconfig
arm                         s3c2410_defconfig
powerpc                   motionpro_defconfig
arc                        vdk_hs38_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     tqm5200_defconfig
powerpc                    gamecube_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         at91_dt_defconfig
mips                         db1xxx_defconfig
arc                        nsimosci_defconfig
um                           x86_64_defconfig
mips                         rt305x_defconfig
arm                           h5000_defconfig
sh                           se7343_defconfig
sh                           sh2007_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        keystone_defconfig
arm                          exynos_defconfig
mips                       lemote2f_defconfig
openrisc                         alldefconfig
mips                      fuloong2e_defconfig
sh                             espt_defconfig
arm                         palmz72_defconfig
sh                            shmin_defconfig
powerpc                 mpc836x_mds_defconfig
arm                       aspeed_g5_defconfig
arc                        nsim_700_defconfig
arm                       versatile_defconfig
mips                         tb0226_defconfig
sh                          lboxre2_defconfig
m68k                         apollo_defconfig
mips                           jazz_defconfig
sh                               allmodconfig
mips                        jmr3927_defconfig
powerpc                     pq2fads_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7269_defconfig
powerpc                          g5_defconfig
arm                            hisi_defconfig
m68k                          hp300_defconfig
sh                           se7722_defconfig
powerpc                      pasemi_defconfig
m68k                       m5208evb_defconfig
ia64                         bigsur_defconfig
sh                 kfr2r09-romimage_defconfig
alpha                            alldefconfig
mips                        omega2p_defconfig
m68k                         amcore_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                    sam440ep_defconfig
arm                             rpc_defconfig
powerpc                     sequoia_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
i386                 randconfig-a011-20210622
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                            kunit_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

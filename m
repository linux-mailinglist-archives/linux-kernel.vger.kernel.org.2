Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B9C3C7587
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhGMRKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:10:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:19756 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhGMRKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:10:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="207191544"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="207191544"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 10:06:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="630111019"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2021 10:06:11 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3LrG-000I0k-DW; Tue, 13 Jul 2021 17:06:10 +0000
Date:   Wed, 14 Jul 2021 01:06:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS WITH WARNING
 e9ba16e68cce2f85e9f5d2eba5c0453f1a741fd2
Message-ID: <60edc7fd.zmXeNPwg6P2P6iWy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
branch HEAD: e9ba16e68cce2f85e9f5d2eba5c0453f1a741fd2  smpboot: Mark idle_init() as __always_inlined to work around aggressive compiler un-inlining

Warning reports:

https://lore.kernel.org/lkml/202107131739.sf3PdEHZ-lkp@intel.com

Warning in current branch:

kernel/smpboot.c:50:20: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]

possible Warning in current branch:

kernel/smpboot.c:50:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
kernel/smpboot.c:50:20: sparse: sparse: duplicate inline

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r006-20210713
|   `-- kernel-smpboot.c:warning:inline-is-not-at-beginning-of-declaration
`-- mips-randconfig-s031-20210713
    `-- kernel-smpboot.c:sparse:sparse:duplicate-inline

clang_recent_errors
|-- arm64-buildonly-randconfig-r003-20210713
|   `-- kernel-smpboot.c:warning:duplicate-inline-declaration-specifier
`-- x86_64-randconfig-a004-20210713
    `-- kernel-smpboot.c:warning:duplicate-inline-declaration-specifier

elapsed time: 726m

configs tested: 100
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      ep88xc_defconfig
arc                     haps_hs_smp_defconfig
sh                             espt_defconfig
arm                             ezx_defconfig
riscv                          rv32_defconfig
h8300                       h8s-sim_defconfig
arm                         axm55xx_defconfig
m68k                        m5407c3_defconfig
mips                         db1xxx_defconfig
arm                         assabet_defconfig
arm                         orion5x_defconfig
arm                    vt8500_v6_v7_defconfig
nds32                               defconfig
arm                       netwinder_defconfig
xtensa                           alldefconfig
sh                            migor_defconfig
powerpc                 mpc8313_rdb_defconfig
riscv                            allyesconfig
sh                          r7785rp_defconfig
microblaze                          defconfig
arm                         nhk8815_defconfig
mips                        workpad_defconfig
sh                         microdev_defconfig
mips                        omega2p_defconfig
powerpc                mpc7448_hpc2_defconfig
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
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210713
i386                 randconfig-a004-20210713
i386                 randconfig-a006-20210713
i386                 randconfig-a001-20210713
i386                 randconfig-a002-20210713
i386                 randconfig-a003-20210713
x86_64               randconfig-a013-20210713
x86_64               randconfig-a014-20210713
x86_64               randconfig-a012-20210713
x86_64               randconfig-a015-20210713
x86_64               randconfig-a016-20210713
x86_64               randconfig-a011-20210713
i386                 randconfig-a015-20210713
i386                 randconfig-a014-20210713
i386                 randconfig-a011-20210713
i386                 randconfig-a013-20210713
i386                 randconfig-a012-20210713
i386                 randconfig-a016-20210713
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210713
x86_64               randconfig-a005-20210713
x86_64               randconfig-a004-20210713
x86_64               randconfig-a003-20210713
x86_64               randconfig-a002-20210713
x86_64               randconfig-a006-20210713
x86_64               randconfig-a001-20210713

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

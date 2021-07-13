Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC02D3C758A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhGMRLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:11:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:19849 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhGMRLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:11:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="207191831"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="207191831"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 10:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="654468502"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2021 10:07:11 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3LsE-000I0s-Fm; Tue, 13 Jul 2021 17:07:10 +0000
Date:   Wed, 14 Jul 2021 01:06:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 79e920060fa72d0e827a104d74578fa077c59b66
Message-ID: <60edc800.8NfMkPDDOJIU+e2l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 79e920060fa72d0e827a104d74578fa077c59b66  Merge branch 'WIP/fixes'

i386-tinyconfig vmlinux size:

=================================================================================
 TOTAL  TEXT  __mutex_trylock_common()                                           
=================================================================================
     0     0                         0  79e920060fa7 Merge branch 'WIP/fixes'    
   -64   -64                       +78  7fef2edf7cc7..79e920060fa7 (ALL COMMITS) 
=================================================================================

elapsed time: 726m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
nios2                         3c120_defconfig
powerpc                      mgcoge_defconfig
arm                         mv78xx0_defconfig
arm                            zeus_defconfig
powerpc                     powernv_defconfig
powerpc                  storcenter_defconfig
sh                           se7343_defconfig
arm                          badge4_defconfig
arm                       multi_v4t_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38C3D9D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 07:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhG2Fe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 01:34:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:7585 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230096AbhG2Fe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 01:34:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="212533398"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="212533398"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 22:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="581183984"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2021 22:34:53 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m8yh2-0008uE-Cn; Thu, 29 Jul 2021 05:34:52 +0000
Date:   Thu, 29 Jul 2021 13:34:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 56dbe080de28142d2116bd39e2897bebe6f2ebb6
Message-ID: <61023dd7.ksY1GIocqpDPCTEO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 56dbe080de28142d2116bd39e2897bebe6f2ebb6  rcu: Comment rcu_gp_init() code waiting for CPU-hotplug operations

elapsed time: 720m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210728
powerpc                     kilauea_defconfig
m68k                          multi_defconfig
sh                          polaris_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                       holly_defconfig
x86_64                              defconfig
arm                       spear13xx_defconfig
mips                  cavium_octeon_defconfig
ia64                             allmodconfig
sh                          rsk7269_defconfig
m68k                       m5249evb_defconfig
sh                           sh2007_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     mpc5200_defconfig
powerpc                    adder875_defconfig
sh                          r7780mp_defconfig
mips                           mtx1_defconfig
m68k                             allmodconfig
arm                        vexpress_defconfig
mips                     loongson2k_defconfig
sh                          rsk7264_defconfig
sh                   sh7770_generic_defconfig
h8300                            alldefconfig
openrisc                 simple_smp_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
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
x86_64               randconfig-a006-20210728
x86_64               randconfig-a003-20210728
x86_64               randconfig-a001-20210728
x86_64               randconfig-a004-20210728
x86_64               randconfig-a005-20210728
x86_64               randconfig-a002-20210728
i386                 randconfig-a005-20210728
i386                 randconfig-a003-20210728
i386                 randconfig-a004-20210728
i386                 randconfig-a002-20210728
i386                 randconfig-a001-20210728
i386                 randconfig-a006-20210728
i386                 randconfig-a016-20210728
i386                 randconfig-a012-20210728
i386                 randconfig-a013-20210728
i386                 randconfig-a014-20210728
i386                 randconfig-a011-20210728
i386                 randconfig-a015-20210728
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
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210728
x86_64               randconfig-a016-20210728
x86_64               randconfig-a011-20210728
x86_64               randconfig-a014-20210728
x86_64               randconfig-a013-20210728
x86_64               randconfig-a012-20210728
x86_64               randconfig-a015-20210728

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

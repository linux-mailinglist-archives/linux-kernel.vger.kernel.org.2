Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF803EFEF2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhHRIQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:16:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:12517 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239275AbhHRIQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:16:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="203474691"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="203474691"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 01:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="676981703"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2021 01:15:55 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGGjr-000Skk-1q; Wed, 18 Aug 2021 08:15:55 +0000
Date:   Wed, 18 Aug 2021 16:15:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a27fdfde0570b552d0ba088938c6cf5833e5dbe1
Message-ID: <611cc1b3.Ycu44XzK7D1Zx77y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a27fdfde0570b552d0ba088938c6cf5833e5dbe1  Merge branch 'locking/core'

elapsed time: 723m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
powerpc                     sequoia_defconfig
sh                        sh7757lcr_defconfig
powerpc                        icon_defconfig
powerpc                     redwood_defconfig
powerpc                     asp8347_defconfig
parisc                generic-32bit_defconfig
powerpc                 mpc837x_mds_defconfig
arm                            mps2_defconfig
mips                        jmr3927_defconfig
arm                      footbridge_defconfig
arm                          ep93xx_defconfig
arm                        keystone_defconfig
mips                          ath79_defconfig
arm                         socfpga_defconfig
xtensa                    xip_kc705_defconfig
mips                     loongson1c_defconfig
arm                          badge4_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210816
x86_64               randconfig-a004-20210816
x86_64               randconfig-a003-20210816
x86_64               randconfig-a001-20210816
x86_64               randconfig-a005-20210816
x86_64               randconfig-a002-20210816
i386                 randconfig-a004-20210816
i386                 randconfig-a003-20210816
i386                 randconfig-a002-20210816
i386                 randconfig-a001-20210816
i386                 randconfig-a006-20210816
i386                 randconfig-a005-20210816
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210817
x86_64               randconfig-a004-20210817
x86_64               randconfig-a003-20210817
x86_64               randconfig-a001-20210817
x86_64               randconfig-a002-20210817
x86_64               randconfig-a005-20210817
x86_64               randconfig-a011-20210816
x86_64               randconfig-a013-20210816
x86_64               randconfig-a016-20210816
x86_64               randconfig-a012-20210816
x86_64               randconfig-a015-20210816
x86_64               randconfig-a014-20210816
i386                 randconfig-a011-20210816
i386                 randconfig-a015-20210816
i386                 randconfig-a013-20210816
i386                 randconfig-a014-20210816
i386                 randconfig-a016-20210816
i386                 randconfig-a012-20210816

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

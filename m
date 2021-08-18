Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D6C3F0CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhHRUei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:34:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:20425 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233719AbhHRUeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:34:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="216149702"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="216149702"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 13:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="594154865"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Aug 2021 13:34:01 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGSG8-000TIn-Hb; Wed, 18 Aug 2021 20:34:00 +0000
Date:   Thu, 19 Aug 2021 04:33:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9e6333f6eae38059fea56ab2c10c17b099f2c1ee
Message-ID: <611d6e92.+k8mqqberOGfMzLF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9e6333f6eae38059fea56ab2c10c17b099f2c1ee  Merge branch 'linus'

elapsed time: 720m

configs tested: 120
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
i386                 randconfig-c001-20210818
powerpc                     pq2fads_defconfig
powerpc                      walnut_defconfig
powerpc                       holly_defconfig
arm                             ezx_defconfig
powerpc                     mpc512x_defconfig
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
mips                      malta_kvm_defconfig
powerpc                     rainier_defconfig
ia64                        generic_defconfig
powerpc                     tqm8540_defconfig
mips                      maltasmvp_defconfig
powerpc                      mgcoge_defconfig
arc                         haps_hs_defconfig
arm                       aspeed_g5_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             alldefconfig
sh                          r7785rp_defconfig
mips                        jmr3927_defconfig
mips                         mpc30x_defconfig
mips                      loongson3_defconfig
powerpc                   microwatt_defconfig
arm                  colibri_pxa270_defconfig
um                               alldefconfig
sh                           se7721_defconfig
sh                          rsk7201_defconfig
sh                           se7724_defconfig
powerpc                        cell_defconfig
openrisc                 simple_smp_defconfig
mips                        vocore2_defconfig
powerpc                        icon_defconfig
arm                  colibri_pxa300_defconfig
sh                   sh7724_generic_defconfig
sparc                            alldefconfig
m68k                            mac_defconfig
powerpc                   currituck_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          lpd270_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         cm_x300_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                      cm5200_defconfig
arm                       spear13xx_defconfig
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

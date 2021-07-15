Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1280A3C9AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbhGOJHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:07:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:65002 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239580AbhGOJHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:07:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="232330742"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="232330742"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 02:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="413076587"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Jul 2021 02:04:40 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3xIN-000JXP-EK; Thu, 15 Jul 2021 09:04:39 +0000
Date:   Thu, 15 Jul 2021 17:04:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.07.06b] BUILD SUCCESS
 78aed650973828532e6fd75fef166b96e4cd4be8
Message-ID: <60effa25.Q28Dq01sPcWNG7Qh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.07.06b
branch HEAD: 78aed650973828532e6fd75fef166b96e4cd4be8  doc: Update stallwarn.rst with recent changes

elapsed time: 721m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
openrisc                  or1klitex_defconfig
mips                         db1xxx_defconfig
mips                      malta_kvm_defconfig
s390                             allyesconfig
sh                          sdk7786_defconfig
powerpc                   currituck_defconfig
sh                          polaris_defconfig
mips                      pic32mzda_defconfig
powerpc                      bamboo_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                            gpr_defconfig
powerpc                 mpc837x_mds_defconfig
sh                               j2_defconfig
microblaze                          defconfig
sh                     sh7710voipgw_defconfig
mips                 decstation_r4k_defconfig
powerpc                     tqm5200_defconfig
sh                         microdev_defconfig
mips                        bcm63xx_defconfig
arm                          imote2_defconfig
arm                           omap1_defconfig
powerpc                     mpc83xx_defconfig
powerpc                 canyonlands_defconfig
arm                         s3c2410_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                    klondike_defconfig
openrisc                            defconfig
m68k                       m5275evb_defconfig
arm                         mv78xx0_defconfig
ia64                            zx1_defconfig
mips                           ip28_defconfig
powerpc                   bluestone_defconfig
arm                         s3c6400_defconfig
powerpc                       holly_defconfig
openrisc                 simple_smp_defconfig
arc                         haps_hs_defconfig
powerpc                   lite5200b_defconfig
sparc                            alldefconfig
xtensa                  nommu_kc705_defconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210715
i386                 randconfig-a006-20210715
i386                 randconfig-a004-20210715
i386                 randconfig-a001-20210715
i386                 randconfig-a002-20210715
i386                 randconfig-a005-20210714
i386                 randconfig-a006-20210714
i386                 randconfig-a004-20210714
i386                 randconfig-a001-20210714
i386                 randconfig-a003-20210714
i386                 randconfig-a002-20210714
i386                 randconfig-a014-20210715
i386                 randconfig-a015-20210715
i386                 randconfig-a011-20210715
i386                 randconfig-a013-20210715
i386                 randconfig-a012-20210715
i386                 randconfig-a016-20210715
i386                 randconfig-a014-20210714
i386                 randconfig-a015-20210714
i386                 randconfig-a011-20210714
i386                 randconfig-a013-20210714
i386                 randconfig-a012-20210714
i386                 randconfig-a016-20210714
x86_64               randconfig-a005-20210714
x86_64               randconfig-a004-20210714
x86_64               randconfig-a002-20210714
x86_64               randconfig-a003-20210714
x86_64               randconfig-a006-20210714
x86_64               randconfig-a001-20210714
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
x86_64               randconfig-b001-20210714
x86_64               randconfig-a013-20210714
x86_64               randconfig-a015-20210714
x86_64               randconfig-a012-20210714
x86_64               randconfig-a014-20210714
x86_64               randconfig-a016-20210714
x86_64               randconfig-a011-20210714

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

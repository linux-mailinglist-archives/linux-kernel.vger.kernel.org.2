Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E153375BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhEFTX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:23:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:11573 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230375AbhEFTX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:23:56 -0400
IronPort-SDR: OkO4XUuoBAFb9jy9R7MVCPQjmeSdD+cId1H4GxLaGPnD913k8YMKp1/tyEjOTdQHTI1oQ9jIIj
 5383KImpKD+A==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="198201123"
X-IronPort-AV: E=Sophos;i="5.82,278,1613462400"; 
   d="scan'208";a="198201123"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 12:22:57 -0700
IronPort-SDR: rLoJ3bDmn8wvyHaylVhzmYw2PVY36v573Y95MNaDEbqeMWGrZ8UrO/s238JGtLZCnCgWTE3l1x
 XWvZUJpiIs6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,278,1613462400"; 
   d="scan'208";a="459436694"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 May 2021 12:22:56 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lejaJ-000AqO-RF; Thu, 06 May 2021 19:22:55 +0000
Date:   Fri, 07 May 2021 03:22:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 82bfffc736c8fad4dd79c9721a6196dcd593d3a1
Message-ID: <609441e1.u7YLfolQg7I785wU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 82bfffc736c8fad4dd79c9721a6196dcd593d3a1  Merge branch 'linus'

elapsed time: 721m

configs tested: 102
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
riscv                            allyesconfig
i386                             allyesconfig
arm                         cm_x300_defconfig
arm                         hackkit_defconfig
arm                     eseries_pxa_defconfig
powerpc                        fsp2_defconfig
s390                          debug_defconfig
mips                      malta_kvm_defconfig
h8300                    h8300h-sim_defconfig
powerpc                        cell_defconfig
powerpc                     tqm8560_defconfig
mips                      maltasmvp_defconfig
sh                                  defconfig
arm                         at91_dt_defconfig
xtensa                    smp_lx200_defconfig
mips                           ip22_defconfig
sh                          landisk_defconfig
arm                            mmp2_defconfig
arm                          ep93xx_defconfig
m68k                            mac_defconfig
sh                           se7705_defconfig
arm                        clps711x_defconfig
m68k                       bvme6000_defconfig
arm                     am200epdkit_defconfig
arm                          exynos_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210506
i386                 randconfig-a006-20210506
i386                 randconfig-a001-20210506
i386                 randconfig-a005-20210506
i386                 randconfig-a004-20210506
i386                 randconfig-a002-20210506
x86_64               randconfig-a014-20210506
x86_64               randconfig-a015-20210506
x86_64               randconfig-a012-20210506
x86_64               randconfig-a013-20210506
x86_64               randconfig-a011-20210506
x86_64               randconfig-a016-20210506
i386                 randconfig-a015-20210506
i386                 randconfig-a013-20210506
i386                 randconfig-a016-20210506
i386                 randconfig-a014-20210506
i386                 randconfig-a012-20210506
i386                 randconfig-a011-20210506
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
x86_64               randconfig-a001-20210506
x86_64               randconfig-a003-20210506
x86_64               randconfig-a005-20210506
x86_64               randconfig-a002-20210506
x86_64               randconfig-a006-20210506
x86_64               randconfig-a004-20210506

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

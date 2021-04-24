Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8B636A2CE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhDXTfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 15:35:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:42940 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231814AbhDXTfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 15:35:51 -0400
IronPort-SDR: dSyYwcWBxRo0M0Ld+X7Na3ZNzXH8PmCxteX2q8U5sk3/YPGjNyFbK01Oc79GoxQaqZjYSGIPXj
 trg9vw1zdUmg==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="196253525"
X-IronPort-AV: E=Sophos;i="5.82,248,1613462400"; 
   d="scan'208";a="196253525"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 12:35:11 -0700
IronPort-SDR: eWaAuycVZvMYE5H07eDng9z4pX7deCf2/JaifkPQa2f60yrJW4x5fcl59Nm4fxqTq5VaI3/L77
 PH3E33nayR3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,248,1613462400"; 
   d="scan'208";a="464658036"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2021 12:35:10 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1laO3Z-0005DM-FX; Sat, 24 Apr 2021 19:35:09 +0000
Date:   Sun, 25 Apr 2021 03:34:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8db8c57757fd307764c22a3c987850bec0a863f1
Message-ID: <608472d2.KpO4ZMR7MX3SYmAg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8db8c57757fd307764c22a3c987850bec0a863f1  Merge branch 'linus'

elapsed time: 723m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
powerpc                  mpc885_ads_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         bcm2835_defconfig
powerpc                      walnut_defconfig
mips                       capcella_defconfig
arm                        trizeps4_defconfig
arm                           sama5_defconfig
arc                 nsimosci_hs_smp_defconfig
i386                                defconfig
arm                          exynos_defconfig
ia64                             alldefconfig
m68k                                defconfig
arc                        vdk_hs38_defconfig
arm                     eseries_pxa_defconfig
arc                      axs103_smp_defconfig
powerpc                     tqm8555_defconfig
sh                           se7619_defconfig
mips                 decstation_r4k_defconfig
powerpc                      tqm8xx_defconfig
arm                            qcom_defconfig
arm                        magician_defconfig
sh                           sh2007_defconfig
mips                        vocore2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210424
i386                 randconfig-a002-20210424
i386                 randconfig-a001-20210424
i386                 randconfig-a006-20210424
i386                 randconfig-a004-20210424
i386                 randconfig-a003-20210424
x86_64               randconfig-a015-20210424
x86_64               randconfig-a016-20210424
x86_64               randconfig-a011-20210424
x86_64               randconfig-a014-20210424
x86_64               randconfig-a013-20210424
x86_64               randconfig-a012-20210424
i386                 randconfig-a012-20210424
i386                 randconfig-a014-20210424
i386                 randconfig-a011-20210424
i386                 randconfig-a013-20210424
i386                 randconfig-a015-20210424
i386                 randconfig-a016-20210424
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-a004-20210424
x86_64               randconfig-a002-20210424
x86_64               randconfig-a001-20210424
x86_64               randconfig-a006-20210424
x86_64               randconfig-a005-20210424
x86_64               randconfig-a003-20210424

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

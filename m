Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9CB43B7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhJZREe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:04:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:57534 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237306AbhJZREc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:04:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="316168185"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="316168185"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 10:02:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="497433494"
Received: from lkp-server01.sh.intel.com (HELO 072b454ebba8) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2021 10:02:05 -0700
Received: from kbuild by 072b454ebba8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfPps-0000BA-Ka; Tue, 26 Oct 2021 17:02:04 +0000
Date:   Wed, 27 Oct 2021 01:01:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 f2739ca15c414ebad88f4333e3186fd4144c1753
Message-ID: <61783461.o9JjNHP7CPQE/7Ed%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: f2739ca15c414ebad88f4333e3186fd4144c1753  x86/of: Kill unused early_init_dt_scan_chosen_arch()

elapsed time: 1901m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211025
powerpc                      walnut_defconfig
m68k                         amcore_defconfig
arc                        nsim_700_defconfig
powerpc                        cell_defconfig
nios2                            alldefconfig
arm                       mainstone_defconfig
mips                          rb532_defconfig
arm                           sunxi_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    mvme5100_defconfig
sh                        sh7763rdp_defconfig
mips                         tb0226_defconfig
powerpc                     tqm8560_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8272_ads_defconfig
arm                            xcep_defconfig
powerpc                     kmeter1_defconfig
arm                    vt8500_v6_v7_defconfig
sh                   sh7724_generic_defconfig
mips                           ci20_defconfig
sh                          lboxre2_defconfig
mips                           ip28_defconfig
sh                           se7206_defconfig
sh                                  defconfig
sh                             espt_defconfig
powerpc                         wii_defconfig
arm                  randconfig-c002-20211025
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a013-20211025
x86_64               randconfig-a015-20211025
x86_64               randconfig-a011-20211025
x86_64               randconfig-a014-20211025
x86_64               randconfig-a016-20211025
x86_64               randconfig-a012-20211025
i386                 randconfig-a012-20211025
i386                 randconfig-a013-20211025
i386                 randconfig-a011-20211025
i386                 randconfig-a016-20211025
i386                 randconfig-a015-20211025
i386                 randconfig-a014-20211025
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20211025
powerpc              randconfig-c003-20211025
arm                  randconfig-c002-20211025
x86_64               randconfig-c007-20211025
mips                 randconfig-c004-20211025
i386                 randconfig-c001-20211025
s390                 randconfig-c005-20211025
x86_64               randconfig-a002-20211025
x86_64               randconfig-a004-20211025
x86_64               randconfig-a005-20211025
x86_64               randconfig-a006-20211025
x86_64               randconfig-a001-20211025
x86_64               randconfig-a003-20211025
i386                 randconfig-a003-20211025
i386                 randconfig-a004-20211025
i386                 randconfig-a002-20211025
i386                 randconfig-a005-20211025
i386                 randconfig-a001-20211025
i386                 randconfig-a006-20211025
hexagon              randconfig-r045-20211025
hexagon              randconfig-r041-20211025

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

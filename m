Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59B8342C37
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhCTLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:31:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:32632 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhCTLaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:30:25 -0400
IronPort-SDR: cMog1SIBxguM+ITla5tSs1Ug/Wf//XujwtlmB0inN0+jGLqjWw/GJuUBYXpF4SGqQEAU3wYkK+
 63vqWUR/b/mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="254032204"
X-IronPort-AV: E=Sophos;i="5.81,264,1610438400"; 
   d="scan'208";a="254032204"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2021 03:39:21 -0700
IronPort-SDR: nkqQn3d6e4nHqCFN4nNVcORNo2fhTM85RXzgsU309YLb/CLcbVCbGaSCt0mzut1jxfTpjCpKFt
 q7fXGM91qkgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,264,1610438400"; 
   d="scan'208";a="434561430"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2021 03:39:19 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lNZ0p-0002XS-7t; Sat, 20 Mar 2021 10:39:19 +0000
Date:   Sat, 20 Mar 2021 18:38:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 dd926880da8dbbe409e709c1d3c1620729a94732
Message-ID: <6055d0ae.rXjskpVDfxFHK9VM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: dd926880da8dbbe409e709c1d3c1620729a94732  x86/apic/of: Fix CPU devicetree-node lookups

elapsed time: 727m

configs tested: 131
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
i386                             allyesconfig
riscv                            allyesconfig
sh                          rsk7203_defconfig
sh                          kfr2r09_defconfig
arc                            hsdk_defconfig
mips                       rbtx49xx_defconfig
powerpc                     stx_gp3_defconfig
sh                   rts7751r2dplus_defconfig
mips                malta_kvm_guest_defconfig
mips                         tb0287_defconfig
arm                         lubbock_defconfig
arm                          ep93xx_defconfig
sh                            hp6xx_defconfig
ia64                             allmodconfig
m68k                            q40_defconfig
arm                   milbeaut_m10v_defconfig
arm                        neponset_defconfig
arm                        multi_v7_defconfig
sh                        edosk7705_defconfig
powerpc                  mpc885_ads_defconfig
arm                         cm_x300_defconfig
powerpc                     pq2fads_defconfig
mips                     loongson1c_defconfig
m68k                           sun3_defconfig
mips                        bcm63xx_defconfig
sh                      rts7751r2d1_defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
powerpc                     ksi8560_defconfig
powerpc                     taishan_defconfig
powerpc                        warp_defconfig
arm                        mvebu_v7_defconfig
xtensa                  audio_kc705_defconfig
m68k                        stmark2_defconfig
arm                       aspeed_g4_defconfig
powerpc                       maple_defconfig
arm                       mainstone_defconfig
sparc64                             defconfig
powerpc                      acadia_defconfig
powerpc                      pmac32_defconfig
sh                          landisk_defconfig
parisc                           alldefconfig
arc                      axs103_smp_defconfig
arm                    vt8500_v6_v7_defconfig
ia64                            zx1_defconfig
powerpc                     skiroot_defconfig
sh                     magicpanelr2_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
i386                 randconfig-a001-20210319
i386                 randconfig-a005-20210319
i386                 randconfig-a003-20210319
i386                 randconfig-a002-20210319
i386                 randconfig-a006-20210319
i386                 randconfig-a004-20210319
x86_64               randconfig-a011-20210318
x86_64               randconfig-a016-20210318
x86_64               randconfig-a013-20210318
x86_64               randconfig-a015-20210318
x86_64               randconfig-a014-20210318
x86_64               randconfig-a012-20210318
i386                 randconfig-a013-20210318
i386                 randconfig-a016-20210318
i386                 randconfig-a011-20210318
i386                 randconfig-a014-20210318
i386                 randconfig-a015-20210318
i386                 randconfig-a012-20210318
i386                 randconfig-a013-20210319
i386                 randconfig-a016-20210319
i386                 randconfig-a011-20210319
i386                 randconfig-a014-20210319
i386                 randconfig-a015-20210319
i386                 randconfig-a012-20210319
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210318
x86_64               randconfig-a001-20210318
x86_64               randconfig-a005-20210318
x86_64               randconfig-a002-20210318
x86_64               randconfig-a003-20210318
x86_64               randconfig-a004-20210318

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

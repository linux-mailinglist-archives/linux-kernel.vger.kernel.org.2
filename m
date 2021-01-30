Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844BF309892
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 23:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhA3WKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 17:10:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:63303 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhA3WKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 17:10:32 -0500
IronPort-SDR: SJCTL/zsMjJvB0pBN1lW3OhCTvnSNQi/BaG+r3GHOkrW0X644HJEQiV+F4AVQLaFUDEjt8lUiP
 DbLaf/c2VK2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9880"; a="160324738"
X-IronPort-AV: E=Sophos;i="5.79,389,1602572400"; 
   d="scan'208";a="160324738"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 14:09:51 -0800
IronPort-SDR: x9npy6tW89Nbhbtp4lJwOL/sjk94kiwuNXIg96ayqExhxVU9GRjYE9g2RWCzhNlglvJRuJarGM
 fwvD14vLRBtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,389,1602572400"; 
   d="scan'208";a="476920972"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2021 14:09:50 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5yRB-00054I-NN; Sat, 30 Jan 2021 22:09:49 +0000
Date:   Sun, 31 Jan 2021 06:08:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a7e0bdf1b07ea6169930ec42b0bdb17e1c1e3bb0
Message-ID: <6015d8f3.xnblDS1XqLIcyefv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a7e0bdf1b07ea6169930ec42b0bdb17e1c1e3bb0  Merge branch 'irq/urgent'

elapsed time: 720m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc836x_rdk_defconfig
mips                           ip28_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                    amigaone_defconfig
mips                          rb532_defconfig
arm                              alldefconfig
arm                             pxa_defconfig
arm                       omap2plus_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         lubbock_defconfig
microblaze                          defconfig
xtensa                  cadence_csp_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
powerpc                     tqm8548_defconfig
sh                           sh2007_defconfig
xtensa                         virt_defconfig
mips                      pic32mzda_defconfig
powerpc                     asp8347_defconfig
sh                   sh7770_generic_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210130
i386                 randconfig-a003-20210130
i386                 randconfig-a002-20210130
i386                 randconfig-a001-20210130
i386                 randconfig-a004-20210130
i386                 randconfig-a006-20210130
x86_64               randconfig-a004-20210130
x86_64               randconfig-a002-20210130
x86_64               randconfig-a001-20210130
x86_64               randconfig-a005-20210130
x86_64               randconfig-a006-20210130
x86_64               randconfig-a003-20210130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

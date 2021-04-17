Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324B93632B7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 01:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhDQX46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 19:56:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:45810 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhDQX45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 19:56:57 -0400
IronPort-SDR: 0Mvo4Gok3P0jVRG9sdkps2CWIMmcttmcZCy75CdZQL21a9KibOA9nfBnRChtR7wZ5yuYGNi6ac
 rn69sq7NyvpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9957"; a="195301059"
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="195301059"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 16:56:30 -0700
IronPort-SDR: qfvDhv9AIudS4sp6jgif5Ad1kHM1CWiJK5+1hwn2zqspS0em6LLSmUXTBA5Smk03kr17GY6apV
 /SRYUINYfCWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="451788912"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Apr 2021 16:56:29 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXunc-000156-Cb; Sat, 17 Apr 2021 23:56:28 +0000
Date:   Sun, 18 Apr 2021 07:56:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 9406415f46f6127fd31bb66f0260f7a61a8d2786
Message-ID: <607b759c.JfTBwY7yYhQCr48q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 9406415f46f6127fd31bb66f0260f7a61a8d2786  sched/debug: Rename the sched_debug parameter to sched_verbose

elapsed time: 723m

configs tested: 97
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
powerpc                       ebony_defconfig
powerpc                     ksi8560_defconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
arm                       aspeed_g5_defconfig
powerpc                       eiger_defconfig
powerpc                 mpc834x_mds_defconfig
arm                            zeus_defconfig
sh                           se7705_defconfig
arm                       omap2plus_defconfig
powerpc                     mpc83xx_defconfig
mips                      loongson3_defconfig
riscv                          rv32_defconfig
i386                             alldefconfig
arm                        shmobile_defconfig
mips                      pic32mzda_defconfig
m68k                          atari_defconfig
openrisc                            defconfig
arm                         s3c2410_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                 randconfig-a003-20210417
i386                 randconfig-a006-20210417
i386                 randconfig-a001-20210417
i386                 randconfig-a005-20210417
i386                 randconfig-a004-20210417
i386                 randconfig-a002-20210417
i386                 randconfig-a015-20210417
i386                 randconfig-a014-20210417
i386                 randconfig-a013-20210417
i386                 randconfig-a012-20210417
i386                 randconfig-a016-20210417
i386                 randconfig-a011-20210417
x86_64               randconfig-a003-20210417
x86_64               randconfig-a002-20210417
x86_64               randconfig-a005-20210417
x86_64               randconfig-a001-20210417
x86_64               randconfig-a006-20210417
x86_64               randconfig-a004-20210417
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a014-20210417
x86_64               randconfig-a015-20210417
x86_64               randconfig-a011-20210417
x86_64               randconfig-a013-20210417
x86_64               randconfig-a012-20210417
x86_64               randconfig-a016-20210417

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

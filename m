Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE971376BC0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhEGVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:31:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:45476 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGVbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:31:41 -0400
IronPort-SDR: OPSN2vFQ88J1W6GMS5vXjxbOPecXT9+fRmFE7dvlEZATV4WpTtDkSr30VkSpiEA+HsMABAH6MR
 w18en3aCvEZw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="185947419"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="185947419"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 14:30:40 -0700
IronPort-SDR: tqA1mL7jroLZ4Eh7M1vu/lfOYCGD6U1FZpuUDoLoCdGNlKEPC9pUBuBcJHJRts9PdRORE9+EbA
 sbiNyyuTeRyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="431674395"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 May 2021 14:30:39 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lf83S-000BPX-G8; Fri, 07 May 2021 21:30:38 +0000
Date:   Sat, 08 May 2021 05:29:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 89415891e947d7cf834778ace844ee3e8850ef0a
Message-ID: <6095b155.LTEfMmMqRe1Op8YC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 89415891e947d7cf834778ace844ee3e8850ef0a  Merge branch 'linus'

elapsed time: 724m

configs tested: 101
configs skipped: 3

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
powerpc                         ps3_defconfig
sparc                       sparc64_defconfig
x86_64                            allnoconfig
arc                     nsimosci_hs_defconfig
mips                           ip22_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
sh                      rts7751r2d1_defconfig
arm                         hackkit_defconfig
arm                        shmobile_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                           jazz_defconfig
m68k                             allyesconfig
sh                                  defconfig
arc                        vdk_hs38_defconfig
arm                          moxart_defconfig
powerpc                      obs600_defconfig
arm                       imx_v6_v7_defconfig
ia64                        generic_defconfig
mips                        bcm47xx_defconfig
arm                          exynos_defconfig
m68k                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
i386                 randconfig-a003-20210507
i386                 randconfig-a006-20210507
i386                 randconfig-a001-20210507
i386                 randconfig-a005-20210507
i386                 randconfig-a004-20210507
i386                 randconfig-a002-20210507
i386                 randconfig-a015-20210506
i386                 randconfig-a013-20210506
i386                 randconfig-a016-20210506
i386                 randconfig-a014-20210506
i386                 randconfig-a012-20210506
i386                 randconfig-a011-20210506
x86_64               randconfig-a001-20210507
x86_64               randconfig-a003-20210507
x86_64               randconfig-a005-20210507
x86_64               randconfig-a002-20210507
x86_64               randconfig-a006-20210507
x86_64               randconfig-a004-20210507
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
x86_64               randconfig-a014-20210507
x86_64               randconfig-a015-20210507
x86_64               randconfig-a012-20210507
x86_64               randconfig-a013-20210507
x86_64               randconfig-a011-20210507
x86_64               randconfig-a016-20210507

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

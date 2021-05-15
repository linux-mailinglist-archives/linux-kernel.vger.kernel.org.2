Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8F3818E2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhEOM7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 08:59:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:55470 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhEOM66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 08:58:58 -0400
IronPort-SDR: v3wPTswd+qPLQ8Pq3OP56Zt+/VEGDL6D3XxDDl8dmLby2QCt3oh2N/ag1YnvF8Cj1YTgxrytOl
 uHOTuuGqlg2g==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="199968114"
X-IronPort-AV: E=Sophos;i="5.82,301,1613462400"; 
   d="scan'208";a="199968114"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2021 05:57:45 -0700
IronPort-SDR: g9IyEF5jFkJSJ2uDGE1UfmVJ3/tzzlEteAYUR9VSRFqLn/Qa1DyUf6+snJlyxPDSK8fghJnmGJ
 rAS4g7gX5Qsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,301,1613462400"; 
   d="scan'208";a="438318522"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 May 2021 05:57:44 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lhtrT-00018Y-LS; Sat, 15 May 2021 12:57:43 +0000
Date:   Sat, 15 May 2021 20:56:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.05.14a] BUILD SUCCESS
 bea1f4fb70c07ff28726c8ba9cbde228b60d1128
Message-ID: <609fc510.srnpERyMHmPrxA1u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.05.14a
branch HEAD: bea1f4fb70c07ff28726c8ba9cbde228b60d1128  EXP mm, slub: move slub_debug static key enabling outside slab_mutex

elapsed time: 720m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7705_defconfig
m68k                          hp300_defconfig
mips                        workpad_defconfig
mips                     loongson2k_defconfig
sh                           se7343_defconfig
h8300                            allyesconfig
s390                          debug_defconfig
mips                         db1xxx_defconfig
xtensa                           allyesconfig
powerpc                     tqm8541_defconfig
ia64                                defconfig
arm                         lubbock_defconfig
csky                                defconfig
powerpc                     mpc5200_defconfig
parisc                generic-64bit_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
arm                            mps2_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
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
x86_64               randconfig-a004-20210514
x86_64               randconfig-a003-20210514
x86_64               randconfig-a001-20210514
x86_64               randconfig-a005-20210514
x86_64               randconfig-a002-20210514
x86_64               randconfig-a006-20210514
i386                 randconfig-a003-20210515
i386                 randconfig-a001-20210515
i386                 randconfig-a004-20210515
i386                 randconfig-a005-20210515
i386                 randconfig-a002-20210515
i386                 randconfig-a006-20210515
i386                 randconfig-a016-20210515
i386                 randconfig-a014-20210515
i386                 randconfig-a011-20210515
i386                 randconfig-a012-20210515
i386                 randconfig-a015-20210515
i386                 randconfig-a013-20210515
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
x86_64               randconfig-a015-20210514
x86_64               randconfig-a012-20210514
x86_64               randconfig-a011-20210514
x86_64               randconfig-a013-20210514
x86_64               randconfig-a016-20210514
x86_64               randconfig-a014-20210514

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

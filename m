Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDDB32BE37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385365AbhCCRKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:10:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:22403 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhCCNFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:05:13 -0500
IronPort-SDR: RYehrRKERWhIJE8Vb/KtJ/Y6bcK2Cd6Ovu7Nij3unrLOm50fOVpYdra7SMiuklhgLh6k6KiOjR
 BjR5BOJ+HMvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174828312"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="174828312"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 05:03:36 -0800
IronPort-SDR: 55lkj2sT9W6nBoIT5jfZGlpvR3QNgsRPLRZ6KcCJGfd+jDPvdGp2zIqrVA2woFz5+8zu0D5Fz1
 SHQDve60uRpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="600150906"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 03 Mar 2021 05:03:34 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHRA6-0001Vg-7Z; Wed, 03 Mar 2021 13:03:34 +0000
Date:   Wed, 03 Mar 2021 21:03:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.02.26a] BUILD SUCCESS
 4ee0eb7c0cbccaae8e5e3681d852d4e7f50c4378
Message-ID: <603f8915.g52koxmZcrPY0rND%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.02.26a
branch HEAD: 4ee0eb7c0cbccaae8e5e3681d852d4e7f50c4378  rcu/tree: Add a trace event for RCU CPU stall warnings

elapsed time: 720m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          urquell_defconfig
arm                       cns3420vb_defconfig
sh                   secureedge5410_defconfig
mips                          malta_defconfig
arm                         assabet_defconfig
arm                      tct_hammer_defconfig
mips                         bigsur_defconfig
m68k                       bvme6000_defconfig
arm                          collie_defconfig
nds32                            alldefconfig
h8300                    h8300h-sim_defconfig
powerpc                        cell_defconfig
mips                      maltasmvp_defconfig
arm                        spear6xx_defconfig
parisc                generic-64bit_defconfig
arm                       versatile_defconfig
arc                              alldefconfig
sh                     magicpanelr2_defconfig
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
s390                             allmodconfig
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
i386                 randconfig-a005-20210303
i386                 randconfig-a003-20210303
i386                 randconfig-a002-20210303
i386                 randconfig-a004-20210303
i386                 randconfig-a006-20210303
i386                 randconfig-a001-20210303
i386                 randconfig-a016-20210303
i386                 randconfig-a012-20210303
i386                 randconfig-a014-20210303
i386                 randconfig-a013-20210303
i386                 randconfig-a011-20210303
i386                 randconfig-a015-20210303
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210302
x86_64               randconfig-a016-20210302
x86_64               randconfig-a015-20210302
x86_64               randconfig-a014-20210302
x86_64               randconfig-a012-20210302
x86_64               randconfig-a011-20210302
x86_64               randconfig-a006-20210303
x86_64               randconfig-a001-20210303
x86_64               randconfig-a004-20210303
x86_64               randconfig-a002-20210303
x86_64               randconfig-a005-20210303
x86_64               randconfig-a003-20210303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

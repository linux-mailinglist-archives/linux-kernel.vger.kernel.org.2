Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BFD305365
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhA0Gqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:46:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:61582 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232261AbhA0Gnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 01:43:31 -0500
IronPort-SDR: AB/u04AAT+qh/yyQz6pES6WuN/Nzm0Ut+MZwUWAtGFoj437kgNhcANzcHqN8BROgLe3XwGbYGf
 KpEYhYWBW5WA==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="177457867"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="177457867"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 22:42:39 -0800
IronPort-SDR: 9nwOMXbb/0BgNi41l0JKib7QYyFRbc1Sv0qwK1N6sDajvCRMvqkveKW8jdEdBz44755xVpwIQp
 NEeiPLDigHZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="407007641"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2021 22:42:38 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l4eXF-0001PZ-Mi; Wed, 27 Jan 2021 06:42:37 +0000
Date:   Wed, 27 Jan 2021 14:41:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.01.22b] BUILD SUCCESS
 c6f6fddad7c84f0bd7fba3f1b076b71d6b902ab4
Message-ID: <60110b2b.xPEoUiTLmt9MXBpv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.01.22b
branch HEAD: c6f6fddad7c84f0bd7fba3f1b076b71d6b902ab4  rcu-tasks: Rectify kernel-doc for struct rcu_tasks

elapsed time: 726m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                generic_kc705_defconfig
x86_64                           allyesconfig
nios2                         10m50_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                         virt_defconfig
arc                         haps_hs_defconfig
arm                          prima2_defconfig
mips                           rs90_defconfig
arm                            xcep_defconfig
mips                         tb0287_defconfig
sh                          polaris_defconfig
xtensa                    smp_lx200_defconfig
parisc                generic-32bit_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     kilauea_defconfig
mips                         rt305x_defconfig
mips                  cavium_octeon_defconfig
arm                       netwinder_defconfig
powerpc                      katmai_defconfig
arm                           viper_defconfig
arm                        trizeps4_defconfig
arm                       aspeed_g4_defconfig
powerpc                     pq2fads_defconfig
powerpc                     powernv_defconfig
arm                          pcm027_defconfig
mips                       capcella_defconfig
arm                          ep93xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210126
i386                 randconfig-a002-20210126
i386                 randconfig-a004-20210126
i386                 randconfig-a006-20210126
i386                 randconfig-a003-20210126
i386                 randconfig-a005-20210126
x86_64               randconfig-a012-20210126
x86_64               randconfig-a016-20210126
x86_64               randconfig-a015-20210126
x86_64               randconfig-a011-20210126
x86_64               randconfig-a013-20210126
x86_64               randconfig-a014-20210126
i386                 randconfig-a013-20210126
i386                 randconfig-a011-20210126
i386                 randconfig-a012-20210126
i386                 randconfig-a015-20210126
i386                 randconfig-a014-20210126
i386                 randconfig-a016-20210126
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210126
x86_64               randconfig-a002-20210126
x86_64               randconfig-a001-20210126
x86_64               randconfig-a005-20210126
x86_64               randconfig-a006-20210126
x86_64               randconfig-a004-20210126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

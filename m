Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557473820BC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 22:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhEPUDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 16:03:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:54757 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhEPUDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 16:03:47 -0400
IronPort-SDR: pmxTJXbPdhQ5feeq0Et8huCWVguJAgGor7JkeTLtdNhe4azhZJD1yp+jQQVqpcFKI7PI26Z2US
 0HydzlNycV9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="200037107"
X-IronPort-AV: E=Sophos;i="5.82,304,1613462400"; 
   d="scan'208";a="200037107"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 13:02:25 -0700
IronPort-SDR: LZn1ZlVtIZDiaER9GdgcoUL9+KaZn3l5/65Syn8uFaLemS1y4iAZKXuwKOzc/kbxtx21W55gsB
 PebB09eGQH1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,304,1613462400"; 
   d="scan'208";a="438615982"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 May 2021 13:02:21 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1liMxx-0001Wn-7d; Sun, 16 May 2021 20:02:21 +0000
Date:   Mon, 17 May 2021 04:01:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 3728f04de2767e3318a9ae2a711522074e77c139
Message-ID: <60a17a12.8qmpXVjs6hn3johX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 3728f04de2767e3318a9ae2a711522074e77c139  Merge branch 'locking/core'

elapsed time: 720m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          polaris_defconfig
powerpc                     powernv_defconfig
powerpc                         wii_defconfig
h8300                    h8300h-sim_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                      maltaaprp_defconfig
powerpc                    ge_imp3a_defconfig
m68k                       m5475evb_defconfig
mips                         db1xxx_defconfig
sparc                            alldefconfig
powerpc                 mpc836x_rdk_defconfig
sh                          sdk7780_defconfig
m68k                          amiga_defconfig
arm                          pcm027_defconfig
mips                        jmr3927_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7750_defconfig
powerpc                       ebony_defconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
mips                   sb1250_swarm_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210516
i386                 randconfig-a001-20210516
i386                 randconfig-a004-20210516
i386                 randconfig-a005-20210516
i386                 randconfig-a002-20210516
i386                 randconfig-a006-20210516
i386                 randconfig-a016-20210516
i386                 randconfig-a014-20210516
i386                 randconfig-a011-20210516
i386                 randconfig-a012-20210516
i386                 randconfig-a015-20210516
i386                 randconfig-a013-20210516
x86_64               randconfig-a004-20210516
x86_64               randconfig-a003-20210516
x86_64               randconfig-a001-20210516
x86_64               randconfig-a005-20210516
x86_64               randconfig-a002-20210516
x86_64               randconfig-a006-20210516
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
x86_64               randconfig-a015-20210516
x86_64               randconfig-a012-20210516
x86_64               randconfig-a011-20210516
x86_64               randconfig-a013-20210516
x86_64               randconfig-a016-20210516
x86_64               randconfig-a014-20210516

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

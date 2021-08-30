Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093AD3FAF5E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 03:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhH3BCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 21:02:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:34935 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234317AbhH3BCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 21:02:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="216343066"
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="216343066"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 18:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="scan'208";a="688906649"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2021 18:01:09 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKVfg-0004gx-HX; Mon, 30 Aug 2021 01:01:08 +0000
Date:   Mon, 30 Aug 2021 09:00:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 a055fcc132d4c25b96d1115aea514258810dc6fc
Message-ID: <612c2db6.dG1OB/M2Xe6sQU9v%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: a055fcc132d4c25b96d1115aea514258810dc6fc  locking/rtmutex: Return success on deadlock for ww_mutex waiters

possible Warning in current branch (please contact us if interested):

kernel/locking/rtmutex.c:756 rt_mutex_adjust_prio_chain() error: we previously assumed 'orig_waiter' could be null (see line 644)

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-m021-20210827
    `-- kernel-locking-rtmutex.c-rt_mutex_adjust_prio_chain()-error:we-previously-assumed-orig_waiter-could-be-null-(see-line-)

elapsed time: 3617m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
i386                 randconfig-c001-20210827
arm                         cm_x300_defconfig
mips                           ip27_defconfig
powerpc                 mpc8313_rdb_defconfig
s390                             alldefconfig
arc                    vdk_hs38_smp_defconfig
arm                       netwinder_defconfig
openrisc                 simple_smp_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                        warp_defconfig
m68k                        mvme147_defconfig
arm                          badge4_defconfig
xtensa                       common_defconfig
powerpc                     akebono_defconfig
m68k                       m5249evb_defconfig
arm                             ezx_defconfig
powerpc                 mpc85xx_cds_defconfig
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
x86_64               randconfig-a014-20210827
x86_64               randconfig-a015-20210827
x86_64               randconfig-a016-20210827
x86_64               randconfig-a013-20210827
x86_64               randconfig-a012-20210827
x86_64               randconfig-a011-20210827
i386                 randconfig-a011-20210827
i386                 randconfig-a016-20210827
i386                 randconfig-a012-20210827
i386                 randconfig-a014-20210827
i386                 randconfig-a013-20210827
i386                 randconfig-a015-20210827
arc                  randconfig-r043-20210827
riscv                randconfig-r042-20210827
s390                 randconfig-r044-20210827
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210827
i386                 randconfig-c001-20210827
arm                  randconfig-c002-20210827
riscv                randconfig-c006-20210827
powerpc              randconfig-c003-20210827
x86_64               randconfig-c007-20210827
mips                 randconfig-c004-20210827
i386                 randconfig-a006-20210827
i386                 randconfig-a001-20210827
i386                 randconfig-a002-20210827
i386                 randconfig-a005-20210827
i386                 randconfig-a004-20210827
i386                 randconfig-a003-20210827
x86_64               randconfig-a005-20210827
x86_64               randconfig-a001-20210827
x86_64               randconfig-a006-20210827
x86_64               randconfig-a003-20210827
x86_64               randconfig-a004-20210827
x86_64               randconfig-a002-20210827

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

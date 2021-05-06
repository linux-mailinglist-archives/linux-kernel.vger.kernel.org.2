Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A13752FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbhEFLZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:25:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:15098 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234589AbhEFLZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:25:58 -0400
IronPort-SDR: b4QAR52UMyRmCQnbjpzenfSFUHGZkbqpBZGkDLJchjkGQXNg+gA1Fm2Md71noZnmG9WGvmD6vj
 9BzQqbNOTusQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="185576497"
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="185576497"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 04:25:00 -0700
IronPort-SDR: UwzLFitVhz94btr00mR08mTaF5Z2ww1afaHhfyIKOUZR6ofQbOQ/oF5i/mPQ7FKnUJILvRrqUC
 pY7hXA1cBWOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="434305522"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 May 2021 04:24:59 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lec7m-000AZ4-F9; Thu, 06 May 2021 11:24:58 +0000
Date:   Thu, 06 May 2021 19:24:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.05.02a] BUILD SUCCESS WITH WARNING
 35d2c62851bc03a945ae81ab0726985f726107b1
Message-ID: <6093d1e1.mXsFI1aq2SlF88mE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.05.02a
branch HEAD: 35d2c62851bc03a945ae81ab0726985f726107b1  refscale: Add measurement of clock readout

Warning reports:

https://lore.kernel.org/lkml/202105061040.osgFAKrJ-lkp@intel.com

Warning in current branch:

kernel/rcu/refscale.c:472:15: warning: variable 'x' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- kernel-rcu-refscale.c:warning:variable-x-set-but-not-used
|-- nds32-allyesconfig
|   `-- kernel-rcu-refscale.c:warning:variable-x-set-but-not-used
|-- nios2-allyesconfig
|   `-- kernel-rcu-refscale.c:warning:variable-x-set-but-not-used
|-- nios2-randconfig-r014-20210505
|   `-- kernel-rcu-refscale.c:warning:variable-x-set-but-not-used
|-- parisc-allyesconfig
|   `-- kernel-rcu-refscale.c:warning:variable-x-set-but-not-used
|-- riscv-allmodconfig
|   `-- kernel-rcu-refscale.c:warning:variable-x-set-but-not-used
|-- s390-allmodconfig
|   `-- kernel-rcu-refscale.c:warning:variable-x-set-but-not-used
|-- s390-allyesconfig
|   `-- kernel-rcu-refscale.c:warning:variable-x-set-but-not-used
|-- s390-defconfig
|   `-- kernel-rcu-refscale.c:warning:variable-x-set-but-not-used
`-- sh-allmodconfig
    `-- kernel-rcu-refscale.c:warning:variable-x-set-but-not-used

elapsed time: 724m

configs tested: 113
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
sh                           se7705_defconfig
sh                             sh03_defconfig
um                                  defconfig
sh                         ecovec24_defconfig
powerpc                     tqm8541_defconfig
mips                           gcw0_defconfig
h8300                     edosk2674_defconfig
xtensa                          iss_defconfig
ia64                         bigsur_defconfig
powerpc                     mpc5200_defconfig
mips                     loongson1b_defconfig
arm                          iop32x_defconfig
arm                         nhk8815_defconfig
mips                           ip27_defconfig
sh                          r7785rp_defconfig
mips                        omega2p_defconfig
sparc64                          alldefconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                             pxa_defconfig
powerpc                      ep88xc_defconfig
sparc                            allyesconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                       holly_defconfig
alpha                            allyesconfig
arm                            mps2_defconfig
openrisc                  or1klitex_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                        qi_lb60_defconfig
arm                         palmz72_defconfig
mips                       bmips_be_defconfig
sh                           se7619_defconfig
powerpc                     redwood_defconfig
openrisc                            defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm8548_defconfig
x86_64                            allnoconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210506
i386                 randconfig-a006-20210506
i386                 randconfig-a001-20210506
i386                 randconfig-a005-20210506
i386                 randconfig-a004-20210506
i386                 randconfig-a002-20210506
x86_64               randconfig-a001-20210505
x86_64               randconfig-a003-20210505
x86_64               randconfig-a005-20210505
x86_64               randconfig-a002-20210505
x86_64               randconfig-a006-20210505
x86_64               randconfig-a004-20210505
i386                 randconfig-a015-20210505
i386                 randconfig-a013-20210505
i386                 randconfig-a016-20210505
i386                 randconfig-a014-20210505
i386                 randconfig-a012-20210505
i386                 randconfig-a011-20210505
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210505
x86_64               randconfig-a015-20210505
x86_64               randconfig-a012-20210505
x86_64               randconfig-a013-20210505
x86_64               randconfig-a011-20210505
x86_64               randconfig-a016-20210505

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

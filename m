Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DEB33E9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCQGkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:40:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:45704 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhCQGkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:40:32 -0400
IronPort-SDR: O+qa7HZwm6pGHpnhoP/SOpRwtcozKVdraKlkEoD1cTBx0hqYke6o2fVskZ2zJC6HTbn5KMPq+N
 ZQXGECOmlkBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="187031143"
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; 
   d="scan'208";a="187031143"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 23:40:31 -0700
IronPort-SDR: nBI4hiuGh5C7Tl0+W/NuopKUwgD3okFWwKwhJhgN3+Mm6uDqs0m4eib1CX6L5so9PRXEo0zLAa
 0uu8o/GE/Dlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; 
   d="scan'208";a="379167087"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 Mar 2021 23:40:30 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMPr3-0000XJ-CF; Wed, 17 Mar 2021 06:40:29 +0000
Date:   Wed, 17 Mar 2021 14:40:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD REGRESSION
 9035ae87fcb36d2a7c8872e1cc0a46c0c5b619a8
Message-ID: <6051a453.HniNU0uQ3wkGIe9k%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 9035ae87fcb36d2a7c8872e1cc0a46c0c5b619a8  torture: Fix grace-period rate output

Error/Warning reports:

https://lore.kernel.org/lkml/202103170728.9kxVaZbV-lkp@intel.com

Error/Warning in current branch:

ERROR: modpost: "rcu_read_lock_longwait" [kernel/rcu/rcutorture.ko] undefined!
ERROR: modpost: "rcu_read_lock_longwait_held" [kernel/rcu/rcutorture.ko] undefined!
ERROR: modpost: "rcu_read_unlock_longwait" [kernel/rcu/rcutorture.ko] undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20210316
|   |-- ERROR:rcu_read_lock_longwait-kernel-rcu-rcutorture.ko-undefined
|   |-- ERROR:rcu_read_lock_longwait_held-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:rcu_read_unlock_longwait-kernel-rcu-rcutorture.ko-undefined
|-- i386-randconfig-s001-20210316
|   |-- ERROR:rcu_read_lock_longwait-kernel-rcu-rcutorture.ko-undefined
|   |-- ERROR:rcu_read_lock_longwait_held-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:rcu_read_unlock_longwait-kernel-rcu-rcutorture.ko-undefined
|-- s390-defconfig
|   |-- ERROR:rcu_read_lock_longwait-kernel-rcu-rcutorture.ko-undefined
|   |-- ERROR:rcu_read_lock_longwait_held-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:rcu_read_unlock_longwait-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-a011-20210316
|   |-- ERROR:rcu_read_lock_longwait-kernel-rcu-rcutorture.ko-undefined
|   |-- ERROR:rcu_read_lock_longwait_held-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:rcu_read_unlock_longwait-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-a013-20210316
|   |-- ERROR:rcu_read_lock_longwait-kernel-rcu-rcutorture.ko-undefined
|   |-- ERROR:rcu_read_lock_longwait_held-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:rcu_read_unlock_longwait-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-a015-20210316
|   |-- ERROR:rcu_read_lock_longwait-kernel-rcu-rcutorture.ko-undefined
|   |-- ERROR:rcu_read_lock_longwait_held-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:rcu_read_unlock_longwait-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-a016-20210316
|   |-- ERROR:rcu_read_lock_longwait-kernel-rcu-rcutorture.ko-undefined
|   |-- ERROR:rcu_read_lock_longwait_held-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:rcu_read_unlock_longwait-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-m001-20210316
|   |-- ERROR:rcu_read_lock_longwait-kernel-rcu-rcutorture.ko-undefined
|   |-- ERROR:rcu_read_lock_longwait_held-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:rcu_read_unlock_longwait-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-r015-20210316
|   |-- ERROR:rcu_read_lock_longwait-kernel-rcu-rcutorture.ko-undefined
|   |-- ERROR:rcu_read_lock_longwait_held-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:rcu_read_unlock_longwait-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-r016-20210316
|   |-- ERROR:rcu_read_lock_longwait-kernel-rcu-rcutorture.ko-undefined
|   |-- ERROR:rcu_read_lock_longwait_held-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:rcu_read_unlock_longwait-kernel-rcu-rcutorture.ko-undefined
`-- x86_64-rhel-8.3
    |-- ERROR:rcu_read_lock_longwait-kernel-rcu-rcutorture.ko-undefined
    |-- ERROR:rcu_read_lock_longwait_held-kernel-rcu-rcutorture.ko-undefined
    `-- ERROR:rcu_read_unlock_longwait-kernel-rcu-rcutorture.ko-undefined

elapsed time: 722m

configs tested: 119
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                         hackkit_defconfig
arm                          gemini_defconfig
sh                               j2_defconfig
arm                         vf610m4_defconfig
powerpc                      pmac32_defconfig
sh                           se7705_defconfig
nios2                         10m50_defconfig
sh                         apsh4a3a_defconfig
powerpc                    klondike_defconfig
powerpc                       ppc64_defconfig
arm                        cerfcube_defconfig
nios2                         3c120_defconfig
parisc                generic-32bit_defconfig
powerpc                      ppc6xx_defconfig
microblaze                      mmu_defconfig
powerpc                         ps3_defconfig
sh                           se7206_defconfig
arm                       netwinder_defconfig
arm                           spitz_defconfig
mips                        nlm_xlp_defconfig
arm                        spear6xx_defconfig
powerpc                     taishan_defconfig
arm                         lpc32xx_defconfig
arm                           tegra_defconfig
arm                        neponset_defconfig
arc                     nsimosci_hs_defconfig
mips                         tb0287_defconfig
arm                        clps711x_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                          ep93xx_defconfig
powerpc                     mpc512x_defconfig
arm                         orion5x_defconfig
mips                         bigsur_defconfig
powerpc                     ep8248e_defconfig
powerpc                      cm5200_defconfig
mips                     loongson1c_defconfig
sparc64                             defconfig
arm                            mps2_defconfig
mips                         tb0219_defconfig
mips                     cu1000-neo_defconfig
xtensa                  cadence_csp_defconfig
powerpc               mpc834x_itxgp_defconfig
um                            kunit_defconfig
powerpc                 mpc837x_rdb_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210316
i386                 randconfig-a005-20210316
i386                 randconfig-a002-20210316
i386                 randconfig-a003-20210316
i386                 randconfig-a004-20210316
i386                 randconfig-a006-20210316
x86_64               randconfig-a011-20210316
x86_64               randconfig-a016-20210316
x86_64               randconfig-a013-20210316
x86_64               randconfig-a014-20210316
x86_64               randconfig-a015-20210316
x86_64               randconfig-a012-20210316
i386                 randconfig-a013-20210316
i386                 randconfig-a016-20210316
i386                 randconfig-a011-20210316
i386                 randconfig-a012-20210316
i386                 randconfig-a015-20210316
i386                 randconfig-a014-20210316
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210316
x86_64               randconfig-a001-20210316
x86_64               randconfig-a005-20210316
x86_64               randconfig-a004-20210316
x86_64               randconfig-a003-20210316
x86_64               randconfig-a002-20210316

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

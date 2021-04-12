Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5035B84E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 03:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhDLBuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 21:50:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:15563 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236431AbhDLBuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 21:50:17 -0400
IronPort-SDR: y9j1OXq5IlpRv24iMffJe059QdwuMehuVqQoBdkwz5Gys1JXfZENjU7GCp0qogSgPUgmUzEO+Y
 bRfFcV1TKjDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="190903201"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="190903201"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 18:50:00 -0700
IronPort-SDR: zY/jgH9xEh7WY8Vm3EhExNREVEvbX4dUZS4ntn/VGVwVCZXUBWS/mLbKW4Ls1EnTzxYJWnfz+s
 ZlRNyALwHJdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="381386582"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2021 18:49:58 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVli9-00005Y-AE; Mon, 12 Apr 2021 01:49:57 +0000
Date:   Mon, 12 Apr 2021 09:49:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 c9450f728cfba0613163ed85f8c26eeeeed9def2
Message-ID: <6073a70f.lZzByGOp+UHGKBcM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: c9450f728cfba0613163ed85f8c26eeeeed9def2  Merge branch 'for-mingo-lkmm' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into locking/core

elapsed time: 723m

configs tested: 115
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
sh                   sh7724_generic_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      ppc64e_defconfig
arm                            hisi_defconfig
xtensa                          iss_defconfig
arm                           spitz_defconfig
m68k                        mvme147_defconfig
mips                            gpr_defconfig
microblaze                          defconfig
xtensa                generic_kc705_defconfig
mips                         db1xxx_defconfig
arm                       netwinder_defconfig
openrisc                 simple_smp_defconfig
sh                         ecovec24_defconfig
mips                  cavium_octeon_defconfig
m68k                        m5307c3_defconfig
mips                        omega2p_defconfig
parisc                generic-64bit_defconfig
powerpc                      katmai_defconfig
mips                          ath79_defconfig
h8300                       h8s-sim_defconfig
arm                         hackkit_defconfig
sh                          urquell_defconfig
mips                  maltasmvp_eva_defconfig
x86_64                           alldefconfig
powerpc                 canyonlands_defconfig
powerpc                         ps3_defconfig
powerpc                     redwood_defconfig
arm                             rpc_defconfig
m68k                          sun3x_defconfig
arm                          ep93xx_defconfig
riscv                          rv32_defconfig
mips                           ip22_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      mgcoge_defconfig
mips                            ar7_defconfig
parisc                           allyesconfig
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
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210411
i386                 randconfig-a001-20210411
i386                 randconfig-a006-20210411
i386                 randconfig-a005-20210411
i386                 randconfig-a004-20210411
i386                 randconfig-a002-20210411
i386                 randconfig-a015-20210411
i386                 randconfig-a014-20210411
i386                 randconfig-a013-20210411
i386                 randconfig-a012-20210411
i386                 randconfig-a016-20210411
i386                 randconfig-a011-20210411
x86_64               randconfig-a003-20210411
x86_64               randconfig-a002-20210411
x86_64               randconfig-a001-20210411
x86_64               randconfig-a005-20210411
x86_64               randconfig-a006-20210411
x86_64               randconfig-a004-20210411
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
x86_64               randconfig-a014-20210411
x86_64               randconfig-a015-20210411
x86_64               randconfig-a011-20210411
x86_64               randconfig-a013-20210411
x86_64               randconfig-a012-20210411
x86_64               randconfig-a016-20210411

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

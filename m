Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF43BA003
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 13:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhGBLvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 07:51:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:42653 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhGBLvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 07:51:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="208673636"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="208673636"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 04:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="644850790"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jul 2021 04:48:40 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lzHey-000B3w-9d; Fri, 02 Jul 2021 11:48:40 +0000
Date:   Fri, 02 Jul 2021 19:48:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 a030f26738499018bb5fe3da1516896efdf809a0
Message-ID: <60defcfc.18RVV5KUzMOUe4f0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: a030f26738499018bb5fe3da1516896efdf809a0  Merge branch 'urgent.2021.07.01a' into HEAD

i386-tinyconfig vmlinux size:

+-------+------------------------------+------------------------------------------+
| DELTA |            SYMBOL            |                  COMMIT                  |
+-------+------------------------------+------------------------------------------+
| +2412 | TOTAL                        | 6efb943b8616..a030f2673849 (ALL COMMITS) |
| +2190 | TEXT                         | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|  +198 | DATA                         | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|  +565 | init.text                    | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|  +206 | __get_vm_area_node.isra()    | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|  +154 | alloc_ucounts()              | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|  +150 | perf_clear_dirty_counters()  | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|  +140 | page_vma_mapped_walk()       | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|  +113 | sld_setup()                  | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|  +100 | inc_rlimit_ucounts()         | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   +97 | unmap_mapping_range_tree()   | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   +96 | vma_address()                | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   +88 | fork_init()                  | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   +83 | user_namespace_sysctl_init() | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   +81 | set_cred_ucounts()           | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   +79 | vmalloc_no_huge()            | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   +74 | amd_get_highest_perf()       | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   +70 | force_sig_perf()             | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   +68 | init_ucounts                 | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   +66 | unmap_mapping_page()         | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   +64 | intel_spr_extra_regs         | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   -64 | __kthread_cancel_work()      | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   -69 | parse_reservelow()           | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|   -89 | unmap_mapping_pages()        | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|  -166 | inc_ucount()                 | 6efb943b8616..a030f2673849 (ALL COMMITS) |
|  -206 | __get_vm_area_node()         | 6efb943b8616..a030f2673849 (ALL COMMITS) |
+-------+------------------------------+------------------------------------------+

elapsed time: 727m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                      fuloong2e_defconfig
arm                         vf610m4_defconfig
sh                           se7619_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7780_defconfig
mips                     cu1830-neo_defconfig
powerpc                    socrates_defconfig
arm                            lart_defconfig
ia64                        generic_defconfig
mips                     loongson2k_defconfig
sh                          sdk7780_defconfig
arm                         assabet_defconfig
m68k                        mvme147_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     tqm8541_defconfig
mips                         tb0219_defconfig
arm                        spear6xx_defconfig
mips                           xway_defconfig
arm                          ixp4xx_defconfig
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
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
x86_64               randconfig-a002-20210630
x86_64               randconfig-a001-20210630
x86_64               randconfig-a004-20210630
x86_64               randconfig-a005-20210630
x86_64               randconfig-a006-20210630
x86_64               randconfig-a003-20210630
i386                 randconfig-a004-20210630
i386                 randconfig-a001-20210630
i386                 randconfig-a003-20210630
i386                 randconfig-a002-20210630
i386                 randconfig-a005-20210630
i386                 randconfig-a006-20210630
i386                 randconfig-a014-20210630
i386                 randconfig-a011-20210630
i386                 randconfig-a016-20210630
i386                 randconfig-a012-20210630
i386                 randconfig-a013-20210630
i386                 randconfig-a015-20210630
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210630
x86_64               randconfig-a012-20210630
x86_64               randconfig-a015-20210630
x86_64               randconfig-a016-20210630
x86_64               randconfig-a013-20210630
x86_64               randconfig-a011-20210630
x86_64               randconfig-a014-20210630

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

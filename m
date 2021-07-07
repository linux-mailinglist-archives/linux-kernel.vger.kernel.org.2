Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FBD3BE751
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhGGLnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:43:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:41278 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231546AbhGGLnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:43:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="270404633"
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="270404633"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 04:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="645356607"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jul 2021 04:40:48 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m15v5-000DZ6-Kc; Wed, 07 Jul 2021 11:40:47 +0000
Date:   Wed, 07 Jul 2021 19:39:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.07.06a] BUILD SUCCESS
 41a95363ac9f020cc0e4fcc4b73015c60b6620f0
Message-ID: <60e59286.NqcpU3HZ2or1xgFr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.07.06a
branch HEAD: 41a95363ac9f020cc0e4fcc4b73015c60b6620f0  rcu: Explain why rcu_all_qs() is a stub in preemptible TREE RCU

i386-tinyconfig vmlinux size:

+-------+-----------------------------------+------------------------------------------+
| DELTA |              SYMBOL               |                  COMMIT                  |
+-------+-----------------------------------+------------------------------------------+
| +2931 | TOTAL                             | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
| +2566 | TEXT                              | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|  +285 | DATA                              | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|  +565 | init.text                         | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|  +206 | __get_vm_area_node.isra()         | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|  +201 | clocksource_watchdog()            | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|  +154 | alloc_ucounts()                   | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|  +150 | perf_clear_dirty_counters()       | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|  +140 | page_vma_mapped_walk()            | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|  +113 | sld_setup()                       | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|  +100 | inc_rlimit_ucounts()              | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +97 | unmap_mapping_range_tree()        | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +96 | vma_address()                     | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +88 | fork_init()                       | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +83 | user_namespace_sysctl_init()      | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +81 | set_cred_ucounts()                | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +79 | vmalloc_no_huge()                 | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +74 | amd_get_highest_perf()            | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +70 | force_sig_perf()                  | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +68 | clocksource_verify_percpu()       | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +68 | init_ucounts                      | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +66 | __clocksource_update_freq_scale() | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +66 | unmap_mapping_page()              | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   +64 | intel_spr_extra_regs              | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   -64 | __kthread_cancel_work()           | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   -69 | parse_reservelow()                | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|   -89 | unmap_mapping_pages()             | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|  -166 | inc_ucount()                      | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
|  -206 | __get_vm_area_node()              | 6efb943b8616..41a95363ac9f (ALL COMMITS) |
+-------+-----------------------------------+------------------------------------------+

elapsed time: 726m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
mips                        omega2p_defconfig
arm                            hisi_defconfig
xtensa                           alldefconfig
sh                           se7721_defconfig
s390                       zfcpdump_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     tqm5200_defconfig
mips                          ath25_defconfig
sh                           se7619_defconfig
arm                          pxa168_defconfig
powerpc                    ge_imp3a_defconfig
sh                           se7206_defconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                      bamboo_defconfig
arc                        nsim_700_defconfig
mips                         tb0226_defconfig
powerpc                   motionpro_defconfig
sh                           se7750_defconfig
ia64                      gensparse_defconfig
microblaze                      mmu_defconfig
m68k                        stmark2_defconfig
mips                      fuloong2e_defconfig
arm                          pcm027_defconfig
mips                          rb532_defconfig
arm                         lpc32xx_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210706
i386                 randconfig-a006-20210706
i386                 randconfig-a001-20210706
i386                 randconfig-a003-20210706
i386                 randconfig-a005-20210706
i386                 randconfig-a002-20210706
x86_64               randconfig-a015-20210706
x86_64               randconfig-a014-20210706
x86_64               randconfig-a012-20210706
x86_64               randconfig-a011-20210706
x86_64               randconfig-a016-20210706
x86_64               randconfig-a013-20210706
i386                 randconfig-a015-20210706
i386                 randconfig-a016-20210706
i386                 randconfig-a012-20210706
i386                 randconfig-a011-20210706
i386                 randconfig-a014-20210706
i386                 randconfig-a013-20210706
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
x86_64               randconfig-b001-20210706
x86_64               randconfig-a004-20210706
x86_64               randconfig-a002-20210706
x86_64               randconfig-a005-20210706
x86_64               randconfig-a006-20210706
x86_64               randconfig-a003-20210706
x86_64               randconfig-a001-20210706

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8883BB949
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhGEIc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:32:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:15368 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhGEIc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:32:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="230662830"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="230662830"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 01:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="644136112"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2021 01:29:50 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m0JzB-000CLj-SQ; Mon, 05 Jul 2021 08:29:49 +0000
Date:   Mon, 05 Jul 2021 16:29:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:merge-example-rcu2] BUILD SUCCESS
 3b8b47bcac43e6fb91ee93153d0780af4ae5ec43
Message-ID: <60e2c2cc.922ywSVTQKKhFMt9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git merge-example-rcu2
branch HEAD: 3b8b47bcac43e6fb91ee93153d0780af4ae5ec43  Merge remote-tracking branch 'linus/master' into merge-example-rcu2

i386-tinyconfig vmlinux size:

+-------+------------------------------------------------+---------------------------------------------------------------------------+
| DELTA |                     SYMBOL                     |                                  COMMIT                                   |
+-------+------------------------------------------------+---------------------------------------------------------------------------+
| -1148 | TOTAL                                          | 6efb943b8616..3b8b47bcac43 (ALL COMMITS)                                  |
| +2385 | TOTAL                                          | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
| -3561 | TOTAL                                          | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +358 | DATA                                           | 6efb943b8616..3b8b47bcac43 (ALL COMMITS)                                  |
|  +198 | DATA                                           | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|  +159 | DATA                                           | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
| -1444 | TEXT                                           | 6efb943b8616..3b8b47bcac43 (ALL COMMITS)                                  |
| +2163 | TEXT                                           | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
| -3634 | TEXT                                           | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +862 | init.text                                      | 6efb943b8616..3b8b47bcac43 (ALL COMMITS)                                  |
|  +565 | init.text                                      | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|  +297 | init.text                                      | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +825 | copy_page_from_iter_atomic()                   | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +671 | unmap_page_range()                             | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +479 | pcpu_balance_workfn()                          | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +421 | shrink_lruvec()                                | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +376 | __dump_page()                                  | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +240 | pcpu_balance_free()                            | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +232 | start_kernel()                                 | 6efb943b8616..3b8b47bcac43 (ALL COMMITS)                                  |
|  +227 | start_kernel()                                 | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +206 | __get_vm_area_node.isra()                      | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|  +193 | clocksource_watchdog()                         | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +183 | pools_show()                                   | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +183 | try_to_migrate_one()                           | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +168 | _parse_integer_limit()                         | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +161 | free_area_init()                               | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +154 | alloc_ucounts()                                | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|  +150 | perf_clear_dirty_counters()                    | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|  +150 | __set_page_dirty()                             | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +148 | percpu_pagelist_high_fraction_sysctl_handler() | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +144 | free_pcp_prepare()                             | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +142 | simple_write_end()                             | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +140 | page_vma_mapped_walk()                         | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|  +129 | string_escape_mem()                            | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +113 | sld_setup()                                    | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|  +106 | copy_page_to_iter()                            | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +106 | simple_strntoull()                             | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  +100 | inc_rlimit_ucounts()                           | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +97 | unmap_mapping_range_tree()                     | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +97 | kswapd()                                       | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +97 | __driver_probe_device()                        | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +96 | vma_address()                                  | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +96 | try_to_migrate()                               | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +92 | first_iovec_segment()                          | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +88 | fork_init()                                    | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +88 | ram_aops                                       | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +87 | zone_set_pageset_high_and_batch()              | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +86 | page_mlock_one()                               | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +83 | user_namespace_sysctl_init()                   | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +81 | set_cred_ucounts()                             | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +79 | vmalloc_no_huge()                              | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +78 | free_unref_page_commit()                       | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +76 | boot_pageset                                   | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +74 | amd_get_highest_perf()                         | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +70 | force_sig_perf()                               | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +68 | init_ucounts                                   | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +68 | clocksource_verify_percpu()                    | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +68 | simple_readpage()                              | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +67 | seq_escape_mem()                               | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +66 | unmap_mapping_page()                           | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +66 | __clocksource_update_freq_scale()              | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +66 | __rmqueue_pcplist()                            | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   +64 | intel_spr_extra_regs                           | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   +64 | free_pcppages_bulk()                           | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   -64 | __kthread_cancel_work()                        | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   -65 | zone_batchsize()                               | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   -68 | simple_readpage()                              | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   -69 | parse_reservelow()                             | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   -70 | _copy_from_iter()                              | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   -70 | _copy_from_iter_nocache()                      | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   -79 | escape_hex()                                   | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   -82 | fault_in_pages_readable()                      | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   -88 | ramfs_aops                                     | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   -89 | unmap_mapping_pages()                          | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|   -93 | _copy_to_iter()                                | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|   -98 | account_page_dirtied()                         | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -110 | string_escape_mem_ascii()                      | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -114 | csum_and_copy_from_iter()                      | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -123 | csum_and_copy_to_iter()                        | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -134 | really_probe()                                 | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -138 | memmap_init_zone                               | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -140 | _parse_integer()                               | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -141 | simple_write_end()                             | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -146 | percpu_pagelist_fraction_sysctl_handler()      | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -166 | inc_ucount()                                   | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|  -183 | show_pools()                                   | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -206 | __get_vm_area_node()                           | 4e2b64e124c7 Merge remote-tracking branch 'linus/master' into HEAD        |
|  -341 | iov_iter_alignment()                           | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -370 | iov_iter_get_pages_alloc()                     | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -385 | __dump_page()                                  | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -392 | iov_iter_npages()                              | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -392 | iov_iter_get_pages()                           | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -447 | iov_iter_advance()                             | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -453 | shrink_inactive_list()                         | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -469 | iov_iter_gap_alignment()                       | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -539 | __pcpu_balance_workfn()                        | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -612 | iov_iter_for_each_range()                      | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -651 | _copy_from_iter_full()                         | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -651 | _copy_from_iter_full_nocache()                 | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -684 | zap_p4d_range()                                | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -692 | iov_iter_copy_from_user_atomic()               | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
|  -913 | csum_and_copy_from_iter_full()                 | 3b8b47bcac43 Merge remote-tracking branch 'linus/master' into merge-examp |
+-------+------------------------------------------------+---------------------------------------------------------------------------+

elapsed time: 724m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                     loongson2k_defconfig
openrisc                         alldefconfig
m68k                        m5307c3_defconfig
m68k                        stmark2_defconfig
powerpc                      ppc44x_defconfig
powerpc                     mpc5200_defconfig
ia64                             allmodconfig
nds32                               defconfig
riscv                               defconfig
powerpc                     tqm8540_defconfig
arm                             pxa_defconfig
mips                        workpad_defconfig
powerpc                    amigaone_defconfig
parisc                              defconfig
arm                            dove_defconfig
powerpc                 mpc836x_mds_defconfig
arm                          gemini_defconfig
nds32                             allnoconfig
parisc                generic-32bit_defconfig
sparc                       sparc32_defconfig
sh                          rsk7201_defconfig
powerpc                      pcm030_defconfig
arm                         socfpga_defconfig
mips                      fuloong2e_defconfig
powerpc                     mpc512x_defconfig
sh                          landisk_defconfig
mips                      pic32mzda_defconfig
sh                            titan_defconfig
sh                           sh2007_defconfig
sh                      rts7751r2d1_defconfig
arm                         hackkit_defconfig
sparc                               defconfig
powerpc                    mvme5100_defconfig
csky                             alldefconfig
powerpc                 canyonlands_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210705
i386                 randconfig-a006-20210705
i386                 randconfig-a001-20210705
i386                 randconfig-a003-20210705
i386                 randconfig-a005-20210705
i386                 randconfig-a002-20210705
i386                 randconfig-a015-20210705
i386                 randconfig-a016-20210705
i386                 randconfig-a012-20210705
i386                 randconfig-a011-20210705
i386                 randconfig-a014-20210705
i386                 randconfig-a013-20210705
x86_64               randconfig-a004-20210705
x86_64               randconfig-a002-20210705
x86_64               randconfig-a005-20210705
x86_64               randconfig-a006-20210705
x86_64               randconfig-a003-20210705
x86_64               randconfig-a001-20210705
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210705
x86_64               randconfig-a015-20210705
x86_64               randconfig-a014-20210705
x86_64               randconfig-a012-20210705
x86_64               randconfig-a011-20210705
x86_64               randconfig-a016-20210705
x86_64               randconfig-a013-20210705

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9A73B7055
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhF2KCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 06:02:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:64487 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232661AbhF2KCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 06:02:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="229745413"
X-IronPort-AV: E=Sophos;i="5.83,308,1616482800"; 
   d="scan'208";a="229745413"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 03:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,308,1616482800"; 
   d="scan'208";a="456713479"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2021 03:00:12 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyAXM-00094G-7r; Tue, 29 Jun 2021 10:00:12 +0000
Date:   Tue, 29 Jun 2021 17:59:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 272ceea2f06c92bcd3bb8e00c3030c85e380243e
Message-ID: <60daef1f.RCxVmbpYl49Yt5gP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 272ceea2f06c92bcd3bb8e00c3030c85e380243e  Merge branch 'sched/urgent'

i386-tinyconfig vmlinux size:

+-------+-----------------------------------+------------------------------------------+
| DELTA |              SYMBOL               |                  COMMIT                  |
+-------+-----------------------------------+------------------------------------------+
|  +592 | TOTAL                             | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +447 | TEXT                              | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +169 | DATA                              | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|   -64 | BSS                               | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +879 | __fpu_restore_sig()               | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +555 | copy_xstate_to_uabi_buf()         | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +470 | init.text                         | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +330 | copy_uabi_to_xstate()             | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +265 | __convert_from_fxsr()             | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +252 | altinstructions                   | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +193 | clocksource_watchdog()            | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +180 | altinstr_aux                      | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +150 | perf_clear_dirty_counters()       | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +113 | sld_setup()                       | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +111 | fpu__clear_user_states()          | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  +105 | fpu_clone()                       | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|   +91 | validate_xsaves_xrstors()         | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|   +80 | fpu_flush_thread()                | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|   +76 | save_fpregs_to_fpstate()          | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|   +68 | clocksource_verify_percpu()       | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|   +66 | __clocksource_update_freq_scale() | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|   +64 | intel_spr_extra_regs              | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|   -64 | xstate_supervisor_only_offsets    | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|   -65 | xstateregs_get()                  | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|   -82 | copy_fpregs_to_fpstate()          | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|   -94 | sanitize_restored_user_xstate()   | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  -103 | fpu__clear()                      | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  -125 | fpu__copy()                       | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  -179 | copy_supervisor_to_kernel()       | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  -201 | copy_kernel_to_xstate()           | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  -259 | copy_user_to_xstate()             | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  -261 | fpstate_sanitize_xstate()         | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  -273 | convert_from_fxsr()               | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  -372 | copy_xstate_to_kernel()           | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
|  -914 | __fpu__restore_sig()              | 62fb9874f5da..272ceea2f06c (ALL COMMITS) |
+-------+-----------------------------------+------------------------------------------+

elapsed time: 722m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                    vt8500_v6_v7_defconfig
sh                          rsk7269_defconfig
powerpc                       holly_defconfig
arm                          iop32x_defconfig
arm                          gemini_defconfig
s390                             allmodconfig
sh                           se7343_defconfig
arm                       spear13xx_defconfig
m68k                          multi_defconfig
sh                          rsk7201_defconfig
powerpc                      pasemi_defconfig
sh                          r7780mp_defconfig
m68k                            mac_defconfig
mips                           ci20_defconfig
arm                           sunxi_defconfig
sh                          urquell_defconfig
m68k                       m5249evb_defconfig
sh                           se7780_defconfig
arc                          axs101_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                    gamecube_defconfig
powerpc                      bamboo_defconfig
x86_64                           alldefconfig
arc                     nsimosci_hs_defconfig
arm                         nhk8815_defconfig
powerpc                    socrates_defconfig
powerpc                       ppc64_defconfig
arm                          pxa910_defconfig
sparc                            allyesconfig
arc                 nsimosci_hs_smp_defconfig
riscv                    nommu_virt_defconfig
mips                  decstation_64_defconfig
arm                          collie_defconfig
mips                      maltaaprp_defconfig
powerpc                      chrp32_defconfig
mips                         tb0226_defconfig
h8300                            alldefconfig
sh                           se7750_defconfig
um                           x86_64_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     sequoia_defconfig
mips                          ath79_defconfig
powerpc                     skiroot_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210628
i386                 randconfig-a002-20210628
i386                 randconfig-a003-20210628
i386                 randconfig-a006-20210628
i386                 randconfig-a005-20210628
i386                 randconfig-a004-20210628
x86_64               randconfig-a012-20210628
x86_64               randconfig-a016-20210628
x86_64               randconfig-a015-20210628
x86_64               randconfig-a013-20210628
x86_64               randconfig-a014-20210628
x86_64               randconfig-a011-20210628
i386                 randconfig-a011-20210628
i386                 randconfig-a014-20210628
i386                 randconfig-a013-20210628
i386                 randconfig-a015-20210628
i386                 randconfig-a016-20210628
i386                 randconfig-a012-20210628
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210628
x86_64               randconfig-a002-20210628
x86_64               randconfig-a005-20210628
x86_64               randconfig-a001-20210628
x86_64               randconfig-a003-20210628
x86_64               randconfig-a004-20210628
x86_64               randconfig-a006-20210628

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A633582EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhDHMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:11:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:18099 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230449AbhDHMLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:11:17 -0400
IronPort-SDR: DcQMz7489lx/7PdpHVvvWutsxsfdUP7uWjteR5wCD63VaYpBNVRNArYdavy35Xt9m22C0Kim1r
 kTeWqXMz65MA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="278797662"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="278797662"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 05:11:06 -0700
IronPort-SDR: JrBxGLcSw1qnAP0ZgE3nvGnzPoVAnOAxwjrQ5SYRIfCf0LjnbYveTpMR6pg4J+3M2KcWWRCdjW
 9+jufHgLeHbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="610060623"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Apr 2021 05:11:03 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUTUz-000Exu-Qi; Thu, 08 Apr 2021 12:11:01 +0000
Date:   Thu, 08 Apr 2021 20:10:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.04.06a] BUILD SUCCESS WITH WARNING
 2d5149067a2aca5be4d24fc0f8368e48b47d222d
Message-ID: <606ef2ab.WpCcluWkMRosaAFX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.06a
branch HEAD: 2d5149067a2aca5be4d24fc0f8368e48b47d222d  rcu: Restrict RCU_STRICT_GRACE_PERIOD to at most four CPUs

possible Warning in current branch:

include/linux/rcutiny.h:105:44: sparse: sparse: context imbalance in 'find_lock_task_mm' - wrong count at exit
include/linux/rcutiny.h:105:44: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
include/linux/rcutiny.h:105:44: sparse: sparse: context imbalance in 'send_sigqueue' - wrong count at exit

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-s022-20210407
    |-- include-linux-rcutiny.h:sparse:sparse:context-imbalance-in-find_lock_task_mm-wrong-count-at-exit
    |-- include-linux-rcutiny.h:sparse:sparse:context-imbalance-in-perf_lock_task_context-different-lock-contexts-for-basic-block
    `-- include-linux-rcutiny.h:sparse:sparse:context-imbalance-in-send_sigqueue-wrong-count-at-exit

elapsed time: 720m

configs tested: 92
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
riscv                            allyesconfig
m68k                         amcore_defconfig
powerpc                   currituck_defconfig
sh                            hp6xx_defconfig
arc                     nsimosci_hs_defconfig
arm                            zeus_defconfig
openrisc                  or1klitex_defconfig
arm                         at91_dt_defconfig
sh                   rts7751r2dplus_defconfig
sh                          kfr2r09_defconfig
parisc                              defconfig
arm                           omap1_defconfig
arm                        neponset_defconfig
openrisc                 simple_smp_defconfig
sh                         ecovec24_defconfig
m68k                            q40_defconfig
sparc                       sparc32_defconfig
mips                        nlm_xlr_defconfig
sh                          rsk7201_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8541_defconfig
mips                            ar7_defconfig
powerpc                        fsp2_defconfig
um                               allyesconfig
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
i386                 randconfig-a006-20210407
i386                 randconfig-a003-20210407
i386                 randconfig-a001-20210407
i386                 randconfig-a002-20210407
i386                 randconfig-a005-20210407
x86_64               randconfig-a014-20210407
x86_64               randconfig-a015-20210407
x86_64               randconfig-a013-20210407
x86_64               randconfig-a011-20210407
x86_64               randconfig-a012-20210407
x86_64               randconfig-a016-20210407
i386                 randconfig-a014-20210407
i386                 randconfig-a011-20210407
i386                 randconfig-a016-20210407
i386                 randconfig-a012-20210407
i386                 randconfig-a015-20210407
i386                 randconfig-a013-20210407
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

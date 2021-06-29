Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0AD3B7056
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhF2KCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 06:02:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:24477 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232690AbhF2KCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 06:02:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="195412090"
X-IronPort-AV: E=Sophos;i="5.83,308,1616482800"; 
   d="scan'208";a="195412090"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 03:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,308,1616482800"; 
   d="scan'208";a="408111782"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2021 03:00:12 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyAXM-00094I-8j; Tue, 29 Jun 2021 10:00:12 +0000
Date:   Tue, 29 Jun 2021 17:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 d2343cb8d154fe20c4499711bb3a9af2095b2b4b
Message-ID: <60daef1c.gE7RbReckddbHuQ5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: d2343cb8d154fe20c4499711bb3a9af2095b2b4b  sched/core: Disable CONFIG_SCHED_CORE by default

elapsed time: 721m

configs tested: 136
configs skipped: 2

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
powerpc                 mpc836x_rdk_defconfig
powerpc                     mpc5200_defconfig
h8300                       h8s-sim_defconfig
powerpc                      ep88xc_defconfig
mips                            ar7_defconfig
powerpc                       ppc64_defconfig
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
arc                          axs101_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                    gamecube_defconfig
powerpc                      bamboo_defconfig
x86_64                           alldefconfig
arc                     nsimosci_hs_defconfig
arm                         nhk8815_defconfig
mips                           ip27_defconfig
mips                           jazz_defconfig
arm                          pcm027_defconfig
mips                     loongson1c_defconfig
arm                       netwinder_defconfig
arm                        oxnas_v6_defconfig
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
arm                         socfpga_defconfig
arm                           h3600_defconfig
s390                             alldefconfig
arm                  colibri_pxa270_defconfig
arm                          lpd270_defconfig
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
x86_64               randconfig-a012-20210629
x86_64               randconfig-a016-20210629
x86_64               randconfig-a015-20210629
x86_64               randconfig-a013-20210629
x86_64               randconfig-a014-20210629
x86_64               randconfig-a011-20210629

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

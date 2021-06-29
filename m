Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7563B6C60
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 04:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhF2CDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 22:03:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:20116 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhF2CDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 22:03:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="205061132"
X-IronPort-AV: E=Sophos;i="5.83,307,1616482800"; 
   d="scan'208";a="205061132"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 19:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,307,1616482800"; 
   d="scan'208";a="557778172"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2021 19:01:14 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ly33p-0008pW-9b; Tue, 29 Jun 2021 02:01:13 +0000
Date:   Tue, 29 Jun 2021 10:00:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 031e3bd8986fffe31e1ddbf5264cccfe30c9abd7
Message-ID: <60da7ec0.ltQ/iJOyKa8pnvo2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
branch HEAD: 031e3bd8986fffe31e1ddbf5264cccfe30c9abd7  sched: Optimize housekeeping_cpumask() in for_each_cpu_and()

elapsed time: 724m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
arm                         palmz72_defconfig
powerpc                         wii_defconfig
riscv                             allnoconfig
m68k                        stmark2_defconfig
powerpc                     akebono_defconfig
m68k                       m5249evb_defconfig
powerpc                     sbc8548_defconfig
mips                           ip22_defconfig
powerpc                      pasemi_defconfig
sh                          r7780mp_defconfig
m68k                            mac_defconfig
mips                           ci20_defconfig
arc                          axs101_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                    gamecube_defconfig
arm                           sunxi_defconfig
mips                     loongson2k_defconfig
arm                     eseries_pxa_defconfig
powerpc                      obs600_defconfig
sh                           se7722_defconfig
sh                 kfr2r09-romimage_defconfig
sh                         apsh4a3a_defconfig
csky                             alldefconfig
arm                          pxa910_defconfig
mips                           ip27_defconfig
mips                           jazz_defconfig
arm                          pcm027_defconfig
mips                     loongson1c_defconfig
arm                       netwinder_defconfig
arm                        oxnas_v6_defconfig
sh                          urquell_defconfig
powerpc                    socrates_defconfig
powerpc                       ppc64_defconfig
powerpc                     asp8347_defconfig
arm                        mvebu_v5_defconfig
mips                           rs90_defconfig
powerpc                     tqm8548_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                  decstation_64_defconfig
arm                          collie_defconfig
mips                      maltaaprp_defconfig
sparc                            allyesconfig
riscv                    nommu_virt_defconfig
powerpc64                           defconfig
mips                         db1xxx_defconfig
powerpc                      bamboo_defconfig
sh                           se7619_defconfig
sh                         ecovec24_defconfig
powerpc                      chrp32_defconfig
mips                         tb0226_defconfig
h8300                            alldefconfig
powerpc                      mgcoge_defconfig
sh                            hp6xx_defconfig
mips                       lemote2f_defconfig
powerpc                      ppc44x_defconfig
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
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                             allyesconfig
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
x86_64               randconfig-a013-20210628
x86_64               randconfig-a011-20210628
x86_64               randconfig-a016-20210628
x86_64               randconfig-a015-20210628
x86_64               randconfig-a014-20210628
i386                 randconfig-a011-20210628
i386                 randconfig-a014-20210628
i386                 randconfig-a013-20210628
i386                 randconfig-a015-20210628
i386                 randconfig-a016-20210628
i386                 randconfig-a012-20210628
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4250D3ADDC8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 10:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhFTIvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 04:51:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:54922 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhFTIvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 04:51:01 -0400
IronPort-SDR: GeQ/WDGRRwO+sV44UO4IRj46b2iq6ljf+8LRTBg+7cZzLKSFdC2FdGa+THHYcyWXVyaglhF6bq
 nKZiAMJLdJpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10020"; a="228251332"
X-IronPort-AV: E=Sophos;i="5.83,286,1616482800"; 
   d="scan'208";a="228251332"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 01:48:48 -0700
IronPort-SDR: QzSXA6IBsKaz7Zixsv4kv8BU4/YxbWjYpRkYhmpFi15aY/LrGVvI4OryDTF4Xxh6ESAh7aKIKp
 qt3kMiBdBcRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,286,1616482800"; 
   d="scan'208";a="486160949"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2021 01:48:47 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lut8I-00042p-Kb; Sun, 20 Jun 2021 08:48:46 +0000
Date:   Sun, 20 Jun 2021 16:48:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/urgent] BUILD REGRESSION
 64c71be97c02c3d3f24dea7c290912ad300538b9
Message-ID: <60cf00e7.nqQ+5Cex/i6+Imgr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/urgent
branch HEAD: 64c71be97c02c3d3f24dea7c290912ad300538b9  cpu/hotplug: Cure the cpusets trainwreck

Error/Warning in current branch:

kernel/cpu.c:1353:2: error: implicit declaration of function 'cpu_up_down_serialize_trainwrecks' [-Werror,-Wimplicit-function-declaration]
kernel/cpu.c:1353:2: error: implicit declaration of function 'cpu_up_down_serialize_trainwrecks' [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- kernel-cpu.c:error:implicit-declaration-of-function-cpu_up_down_serialize_trainwrecks
|-- arc-defconfig
|   `-- kernel-cpu.c:error:implicit-declaration-of-function-cpu_up_down_serialize_trainwrecks
|-- arm64-randconfig-r023-20210620
|   `-- kernel-cpu.c:error:implicit-declaration-of-function-cpu_up_down_serialize_trainwrecks
|-- ia64-bigsur_defconfig
|   `-- kernel-cpu.c:error:implicit-declaration-of-function-cpu_up_down_serialize_trainwrecks
|-- mips-nlm_xlp_defconfig
|   `-- kernel-cpu.c:error:implicit-declaration-of-function-cpu_up_down_serialize_trainwrecks
|-- mips-randconfig-r005-20210620
|   `-- kernel-cpu.c:error:implicit-declaration-of-function-cpu_up_down_serialize_trainwrecks
|-- riscv-nommu_k210_defconfig
|   `-- kernel-cpu.c:error:implicit-declaration-of-function-cpu_up_down_serialize_trainwrecks
`-- riscv-nommu_virt_defconfig
    `-- kernel-cpu.c:error:implicit-declaration-of-function-cpu_up_down_serialize_trainwrecks

clang_recent_errors
`-- riscv-randconfig-r031-20210620
    `-- kernel-cpu.c:error:implicit-declaration-of-function-cpu_up_down_serialize_trainwrecks-Werror-Wimplicit-function-declaration

elapsed time: 723m

configs tested: 120
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc834x_itx_defconfig
mips                     loongson2k_defconfig
powerpc                     ep8248e_defconfig
sh                             espt_defconfig
mips                          ath79_defconfig
um                            kunit_defconfig
sh                           se7206_defconfig
sh                         apsh4a3a_defconfig
sparc                       sparc64_defconfig
arm                         mv78xx0_defconfig
sh                            migor_defconfig
arm                         at91_dt_defconfig
x86_64                            allnoconfig
sh                              ul2_defconfig
arm                           sunxi_defconfig
arm                          imote2_defconfig
powerpc                      ep88xc_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                           rs90_defconfig
m68k                        m5272c3_defconfig
mips                         cobalt_defconfig
powerpc                       maple_defconfig
arm                           stm32_defconfig
arm                         assabet_defconfig
arm                           h3600_defconfig
arm                       multi_v4t_defconfig
powerpc                        cell_defconfig
sh                          landisk_defconfig
powerpc                      ppc6xx_defconfig
mips                 decstation_r4k_defconfig
arm                     davinci_all_defconfig
powerpc                     redwood_defconfig
arm                       imx_v6_v7_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc834x_mds_defconfig
mips                        nlm_xlp_defconfig
mips                         db1xxx_defconfig
powerpc                          g5_defconfig
arm                            hisi_defconfig
mips                        nlm_xlr_defconfig
powerpc                 mpc8540_ads_defconfig
parisc                generic-64bit_defconfig
m68k                         amcore_defconfig
m68k                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210620
i386                 randconfig-a002-20210620
i386                 randconfig-a003-20210620
i386                 randconfig-a006-20210620
i386                 randconfig-a005-20210620
i386                 randconfig-a004-20210620
x86_64               randconfig-a012-20210620
x86_64               randconfig-a016-20210620
x86_64               randconfig-a015-20210620
x86_64               randconfig-a014-20210620
x86_64               randconfig-a013-20210620
x86_64               randconfig-a011-20210620
i386                 randconfig-a011-20210620
i386                 randconfig-a014-20210620
i386                 randconfig-a013-20210620
i386                 randconfig-a015-20210620
i386                 randconfig-a012-20210620
i386                 randconfig-a016-20210620
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210620
x86_64               randconfig-a002-20210620
x86_64               randconfig-a001-20210620
x86_64               randconfig-a005-20210620
x86_64               randconfig-a003-20210620
x86_64               randconfig-a004-20210620
x86_64               randconfig-a006-20210620

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

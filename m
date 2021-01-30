Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131023093EC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhA3KDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:03:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:17308 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhA3KC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 05:02:56 -0500
IronPort-SDR: AZ3jiZDOudHWoWS/s3omRIpbkKcz1jIQeABEBXjp4tPdBZIh5StEioC0UHiiNTe2oOwH98lgy9
 exdXmHdjUp0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="177008477"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="177008477"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 22:28:53 -0800
IronPort-SDR: P3Nhkn2+RZsRozcLLDe3kcaiY+UBBxpUlgtsBLIEBeCgc2QI6PdqmrSWVDeqLuWFJnP/MpRNXo
 AzXeqtApcvZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="370676392"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 29 Jan 2021 22:28:52 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5jkZ-0004Ky-D8; Sat, 30 Jan 2021 06:28:51 +0000
Date:   Sat, 30 Jan 2021 14:28:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 1dba8a9538f5164eb8874eed4c7d6799a3c64963
Message-ID: <6014fc72.zzbjrVzhmo/X5FC/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 1dba8a9538f5164eb8874eed4c7d6799a3c64963  thermal: Move therm_throt there from x86/mce

elapsed time: 720m

configs tested: 120
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
sh                          sdk7786_defconfig
mips                          malta_defconfig
mips                           ip22_defconfig
sh                             espt_defconfig
arm                  colibri_pxa300_defconfig
x86_64                           allyesconfig
powerpc                 mpc8315_rdb_defconfig
mips                         rt305x_defconfig
sh                          kfr2r09_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                             rpc_defconfig
arm                      jornada720_defconfig
sh                             shx3_defconfig
h8300                       h8s-sim_defconfig
mips                  maltasmvp_eva_defconfig
arm                            xcep_defconfig
sparc                       sparc32_defconfig
mips                  decstation_64_defconfig
m68k                          hp300_defconfig
mips                      fuloong2e_defconfig
sh                        edosk7760_defconfig
sparc                       sparc64_defconfig
ia64                            zx1_defconfig
powerpc                     ppa8548_defconfig
powerpc                     tqm8548_defconfig
sh                           sh2007_defconfig
arm                         axm55xx_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                                defconfig
arm                         shannon_defconfig
mips                      pistachio_defconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
sh                           se7721_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      walnut_defconfig
sh                             sh03_defconfig
sh                         ecovec24_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210129
x86_64               randconfig-a003-20210129
x86_64               randconfig-a001-20210129
x86_64               randconfig-a005-20210129
x86_64               randconfig-a006-20210129
x86_64               randconfig-a004-20210129
i386                 randconfig-a005-20210130
i386                 randconfig-a003-20210130
i386                 randconfig-a002-20210130
i386                 randconfig-a001-20210130
i386                 randconfig-a004-20210130
i386                 randconfig-a006-20210130
i386                 randconfig-a013-20210130
i386                 randconfig-a011-20210130
i386                 randconfig-a015-20210130
i386                 randconfig-a012-20210130
i386                 randconfig-a014-20210130
i386                 randconfig-a016-20210130
x86_64               randconfig-a004-20210130
x86_64               randconfig-a002-20210130
x86_64               randconfig-a001-20210130
x86_64               randconfig-a005-20210130
x86_64               randconfig-a006-20210130
x86_64               randconfig-a003-20210130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210129
x86_64               randconfig-a015-20210129
x86_64               randconfig-a016-20210129
x86_64               randconfig-a011-20210129
x86_64               randconfig-a013-20210129
x86_64               randconfig-a014-20210129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69655339918
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhCLVbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:31:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:51874 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235227AbhCLVbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:31:00 -0500
IronPort-SDR: HKSCYMMOMyRocnSPv3NgV0o2MPJENa0cNhm3I3gm4DCBzTwjmpDqGJgNtS/B9e/zXnJSU3OT/x
 XycfR420Kw+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168808377"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="168808377"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 13:30:52 -0800
IronPort-SDR: HYHmvIpmB98qlDjuXkJb+FB6rt8M8HhwLFbsWIfkMSmBKcdU/ANROXbktYwZx5tEIH+dX/zSOV
 NJeJXxfny/qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="521550439"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2021 13:30:49 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKpMu-0001cB-Ss; Fri, 12 Mar 2021 21:30:48 +0000
Date:   Sat, 13 Mar 2021 05:30:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 ba08abca66d46381df60842f64f70099d5482b92
Message-ID: <604bdd6c.JQU1lzVMpC9LMjt3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: ba08abca66d46381df60842f64f70099d5482b92  objtool,x86: Fix uaccess PUSHF/POPF validation

elapsed time: 729m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
arm                     davinci_all_defconfig
powerpc                      pasemi_defconfig
powerpc                     powernv_defconfig
arm                   milbeaut_m10v_defconfig
arm                       versatile_defconfig
arm                             pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     pseries_defconfig
arm                        mini2440_defconfig
arm                        keystone_defconfig
sh                           se7780_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      pmac32_defconfig
powerpc                     mpc512x_defconfig
powerpc                     kilauea_defconfig
powerpc                      ppc44x_defconfig
sh                        edosk7705_defconfig
riscv                    nommu_k210_defconfig
powerpc                  storcenter_defconfig
sparc                       sparc64_defconfig
m68k                            mac_defconfig
xtensa                  cadence_csp_defconfig
arm                       imx_v6_v7_defconfig
mips                          rb532_defconfig
mips                 decstation_r4k_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc832x_mds_defconfig
sh                   secureedge5410_defconfig
powerpc                     mpc5200_defconfig
mips                  maltasmvp_eva_defconfig
m68k                        m5307c3_defconfig
mips                      pistachio_defconfig
ia64                             alldefconfig
parisc                generic-64bit_defconfig
riscv                    nommu_virt_defconfig
csky                                defconfig
arm                         s3c2410_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     akebono_defconfig
powerpc                    amigaone_defconfig
powerpc                     ppa8548_defconfig
powerpc                       ebony_defconfig
arm                         lpc32xx_defconfig
sh                          rsk7201_defconfig
sh                          urquell_defconfig
arm64                            alldefconfig
mips                        omega2p_defconfig
mips                      bmips_stb_defconfig
arm                       multi_v4t_defconfig
arm                        oxnas_v6_defconfig
powerpc                         ps3_defconfig
arm                         axm55xx_defconfig
arm                          moxart_defconfig
m68k                       m5475evb_defconfig
sh                             shx3_defconfig
m68k                            q40_defconfig
sh                            migor_defconfig
parisc                           allyesconfig
mips                         tb0287_defconfig
nios2                         10m50_defconfig
arm                         palmz72_defconfig
sh                        sh7757lcr_defconfig
arm                       omap2plus_defconfig
powerpc                      bamboo_defconfig
parisc                generic-32bit_defconfig
powerpc                      ppc6xx_defconfig
arm                         nhk8815_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210312
i386                 randconfig-a005-20210312
i386                 randconfig-a002-20210312
i386                 randconfig-a003-20210312
i386                 randconfig-a004-20210312
i386                 randconfig-a006-20210312
x86_64               randconfig-a011-20210312
x86_64               randconfig-a016-20210312
x86_64               randconfig-a013-20210312
x86_64               randconfig-a014-20210312
x86_64               randconfig-a015-20210312
x86_64               randconfig-a012-20210312
i386                 randconfig-a013-20210312
i386                 randconfig-a016-20210312
i386                 randconfig-a011-20210312
i386                 randconfig-a015-20210312
i386                 randconfig-a014-20210312
i386                 randconfig-a012-20210312
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210312
x86_64               randconfig-a001-20210312
x86_64               randconfig-a005-20210312
x86_64               randconfig-a003-20210312
x86_64               randconfig-a002-20210312
x86_64               randconfig-a004-20210312

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

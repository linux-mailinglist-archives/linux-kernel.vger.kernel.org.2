Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA938017A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 03:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhENBZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 21:25:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:20295 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhENBZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 21:25:45 -0400
IronPort-SDR: oHXCSjqLSOuriHdcNFKRGCJ+dALoDmQOk/f/1+lGWNPg3H3B7LjGrQ+yPALxrBzHeM8eaHhscl
 HV6x7zcfg88g==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="198133918"
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="198133918"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 18:24:34 -0700
IronPort-SDR: gueUklMoyCdFMI9L040LK4bsg/ZctAhCRD1yHOn+Wapj+OEJ4J7aUCAMi6Kal1yAbh/3YEq1JS
 hPjG+5yzFR9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="436111194"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 May 2021 18:24:33 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lhMZ6-0000UB-W9; Fri, 14 May 2021 01:24:32 +0000
Date:   Fri, 14 May 2021 09:24:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS WITH WARNING
 915a2bc3c6b71e9802b89c5c981b2d5367e1ae3f
Message-ID: <609dd13a.0ETlwbVNJL5N+MT7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 915a2bc3c6b71e9802b89c5c981b2d5367e1ae3f  sched/isolation: Reconcile rcu_nocbs= and nohz_full=

possible Warning in current branch:

include/linux/spinlock_api_smp.h:160:9: sparse: sparse: context imbalance in 'sched_core_update_cookie' - wrong count at exit

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm64-randconfig-s031-20210513
    `-- include-linux-spinlock_api_smp.h:sparse:sparse:context-imbalance-in-sched_core_update_cookie-wrong-count-at-exit

elapsed time: 726m

configs tested: 152
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm8541_defconfig
xtensa                         virt_defconfig
powerpc64                           defconfig
arm                             rpc_defconfig
arm                        cerfcube_defconfig
powerpc                      ep88xc_defconfig
sh                         apsh4a3a_defconfig
m68k                        mvme16x_defconfig
mips                      bmips_stb_defconfig
arm                            mmp2_defconfig
powerpc                   currituck_defconfig
sh                         ap325rxa_defconfig
mips                  maltasmvp_eva_defconfig
mips                           mtx1_defconfig
arm                           u8500_defconfig
powerpc                     taishan_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                         apollo_defconfig
sh                          r7785rp_defconfig
arm                        mini2440_defconfig
xtensa                              defconfig
mips                        workpad_defconfig
mips                     decstation_defconfig
riscv                            alldefconfig
powerpc                       maple_defconfig
powerpc                 linkstation_defconfig
powerpc                  storcenter_defconfig
ia64                             alldefconfig
arm                        clps711x_defconfig
powerpc                      mgcoge_defconfig
sh                         microdev_defconfig
arm                  colibri_pxa270_defconfig
xtensa                  cadence_csp_defconfig
h8300                       h8s-sim_defconfig
arm                      tct_hammer_defconfig
mips                      fuloong2e_defconfig
arm                       cns3420vb_defconfig
powerpc                        fsp2_defconfig
mips                       bmips_be_defconfig
mips                        bcm63xx_defconfig
m68k                          hp300_defconfig
arm                      footbridge_defconfig
mips                       rbtx49xx_defconfig
sh                         ecovec24_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7712_defconfig
powerpc                     sequoia_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           ip27_defconfig
sh                           se7751_defconfig
arm                       spear13xx_defconfig
arc                          axs103_defconfig
powerpc                       ebony_defconfig
arm                            lart_defconfig
m68k                           sun3_defconfig
um                            kunit_defconfig
riscv                          rv32_defconfig
mips                      malta_kvm_defconfig
arm                       imx_v6_v7_defconfig
arc                            hsdk_defconfig
arm                         lubbock_defconfig
sh                              ul2_defconfig
sh                           se7619_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                          rb532_defconfig
h8300                               defconfig
ia64                             allyesconfig
powerpc                          allyesconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     asp8347_defconfig
powerpc                     tqm8540_defconfig
xtensa                       common_defconfig
arm                           viper_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc85xx_cds_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
i386                 randconfig-a006-20210513
x86_64               randconfig-a012-20210513
x86_64               randconfig-a015-20210513
x86_64               randconfig-a011-20210513
x86_64               randconfig-a013-20210513
x86_64               randconfig-a016-20210513
x86_64               randconfig-a014-20210513
i386                 randconfig-a016-20210513
i386                 randconfig-a014-20210513
i386                 randconfig-a011-20210513
i386                 randconfig-a015-20210513
i386                 randconfig-a012-20210513
i386                 randconfig-a013-20210513
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

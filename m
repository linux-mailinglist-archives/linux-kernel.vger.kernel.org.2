Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E551347033
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhCXDhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:37:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:64168 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232851AbhCXDhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:37:02 -0400
IronPort-SDR: UAR5FUhH+bSd8FqVAWM/M2soVubxWyhz6hO6ie1vHp3CNq88WMb2lgpc7niVDoHqn14HV608Hm
 eQjivWMnz0Dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="187305628"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="187305628"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 20:37:01 -0700
IronPort-SDR: Px6iLYlvxa2irDUHw6KMK98+ykSXJ0Ig9ncSqRNR1dxFVK8fjSQRetynKJ6cs385tPLmvGSuM0
 UxIxwX6pOeCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="413627951"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2021 20:37:00 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lOuKJ-0000xp-FG; Wed, 24 Mar 2021 03:36:59 +0000
Date:   Wed, 24 Mar 2021 11:36:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 6256e668b7af9d81472e03c6a171630c08f8858a
Message-ID: <605ab3d2.ARos3hgMpXqYRfsh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 6256e668b7af9d81472e03c6a171630c08f8858a  x86/kprobes: Use int3 instead of debug trap for single-step

elapsed time: 724m

configs tested: 150
configs skipped: 66

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
mips                        workpad_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                     cu1000-neo_defconfig
arm                        mini2440_defconfig
powerpc                     redwood_defconfig
mips                            ar7_defconfig
m68k                            mac_defconfig
arm                          imote2_defconfig
mips                      bmips_stb_defconfig
arm                   milbeaut_m10v_defconfig
arm                         mv78xx0_defconfig
arm                           h5000_defconfig
arm                        spear3xx_defconfig
sh                         ap325rxa_defconfig
mips                         bigsur_defconfig
m68k                        m5407c3_defconfig
arm                            hisi_defconfig
arm                        vexpress_defconfig
arm                         shannon_defconfig
arm                       omap2plus_defconfig
arm                      tct_hammer_defconfig
powerpc                      cm5200_defconfig
powerpc                  iss476-smp_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      mgcoge_defconfig
mips                           ip32_defconfig
xtensa                       common_defconfig
riscv                          rv32_defconfig
s390                                defconfig
mips                         tb0287_defconfig
sh                          sdk7780_defconfig
powerpc                  storcenter_defconfig
powerpc                     kilauea_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    socrates_defconfig
arm                       imx_v6_v7_defconfig
arm                        neponset_defconfig
sh                            hp6xx_defconfig
arm                         orion5x_defconfig
powerpc                   bluestone_defconfig
arc                     haps_hs_smp_defconfig
s390                             alldefconfig
mips                            e55_defconfig
sh                     sh7710voipgw_defconfig
m68k                        stmark2_defconfig
nios2                         3c120_defconfig
sh                          landisk_defconfig
sh                   secureedge5410_defconfig
arm                      integrator_defconfig
powerpc                 mpc836x_mds_defconfig
arm                     davinci_all_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          rsk7201_defconfig
mips                     cu1830-neo_defconfig
arm                        shmobile_defconfig
powerpc                     ep8248e_defconfig
powerpc                      makalu_defconfig
arm                         lpc32xx_defconfig
arm                             pxa_defconfig
powerpc                     tqm8555_defconfig
powerpc                       eiger_defconfig
arm                          pxa168_defconfig
powerpc                      obs600_defconfig
powerpc64                           defconfig
mips                          ath25_defconfig
arm                  colibri_pxa300_defconfig
mips                           jazz_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7619_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210323
x86_64               randconfig-a003-20210323
x86_64               randconfig-a006-20210323
x86_64               randconfig-a001-20210323
x86_64               randconfig-a004-20210323
x86_64               randconfig-a005-20210323
i386                 randconfig-a003-20210323
i386                 randconfig-a004-20210323
i386                 randconfig-a001-20210323
i386                 randconfig-a002-20210323
i386                 randconfig-a006-20210323
i386                 randconfig-a005-20210323
i386                 randconfig-a004-20210324
i386                 randconfig-a003-20210324
i386                 randconfig-a001-20210324
i386                 randconfig-a002-20210324
i386                 randconfig-a006-20210324
i386                 randconfig-a005-20210324
i386                 randconfig-a014-20210323
i386                 randconfig-a011-20210323
i386                 randconfig-a015-20210323
i386                 randconfig-a016-20210323
i386                 randconfig-a012-20210323
i386                 randconfig-a013-20210323
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210323
x86_64               randconfig-a015-20210323
x86_64               randconfig-a013-20210323
x86_64               randconfig-a014-20210323
x86_64               randconfig-a011-20210323
x86_64               randconfig-a016-20210323

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

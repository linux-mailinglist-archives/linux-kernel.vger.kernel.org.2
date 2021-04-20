Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08858365253
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 08:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhDTGYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 02:24:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:13097 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhDTGXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 02:23:47 -0400
IronPort-SDR: gewS/JqqUWBYeNGXUN1d24tN9whMcmfGnLgpD1SBR2nXLN1oYZnCIx4CAeCbyz9wUrEtXWtatW
 GBAxjrjXpycQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="182582943"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="182582943"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 23:23:15 -0700
IronPort-SDR: QYo7obKrXUtRXcJVRJSlGddrIDJjFjhVxaURWXrcyTrs4yej+rHeOFDopQmIb6nd8q45GhJjP2
 gZHszoDKhdTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="420278884"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Apr 2021 23:23:14 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYjmz-0002Bn-DE; Tue, 20 Apr 2021 06:23:13 +0000
Date:   Tue, 20 Apr 2021 14:22:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 e48f64fea89e61301248c4be02b406d934a4bac3
Message-ID: <607e7331.YjfZuqEela9pd8Nf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: e48f64fea89e61301248c4be02b406d934a4bac3  Merge branch 'core/entry'

elapsed time: 1157m

configs tested: 156
configs skipped: 3

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
i386                             allyesconfig
riscv                            allyesconfig
m68k                        mvme16x_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           xway_defconfig
sh                             espt_defconfig
sparc64                          alldefconfig
powerpc                   motionpro_defconfig
sh                         ap325rxa_defconfig
nds32                             allnoconfig
mips                      pic32mzda_defconfig
sh                           se7206_defconfig
powerpc                      ep88xc_defconfig
powerpc                     sbc8548_defconfig
mips                            gpr_defconfig
arm                         orion5x_defconfig
sh                          rsk7201_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                       versatile_defconfig
s390                             alldefconfig
mips                      pistachio_defconfig
arm                        spear3xx_defconfig
h8300                       h8s-sim_defconfig
arm                     davinci_all_defconfig
nios2                         3c120_defconfig
m68k                            q40_defconfig
sh                ecovec24-romimage_defconfig
sh                          rsk7203_defconfig
powerpc                 mpc8272_ads_defconfig
mips                          rb532_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc834x_itx_defconfig
xtensa                    smp_lx200_defconfig
arm                        mini2440_defconfig
arm                        neponset_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                           se7750_defconfig
sh                         apsh4a3a_defconfig
sparc                       sparc32_defconfig
um                               alldefconfig
m68k                        m5272c3_defconfig
powerpc                         ps3_defconfig
xtensa                           allyesconfig
powerpc                 mpc832x_rdb_defconfig
sparc                       sparc64_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            hp6xx_defconfig
alpha                            alldefconfig
arm                            lart_defconfig
powerpc                          g5_defconfig
powerpc                      bamboo_defconfig
mips                        nlm_xlr_defconfig
powerpc                     pq2fads_defconfig
m68k                       m5475evb_defconfig
arc                      axs103_smp_defconfig
mips                      malta_kvm_defconfig
riscv                            alldefconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      ppc64e_defconfig
powerpc                         wii_defconfig
mips                            e55_defconfig
arm                         hackkit_defconfig
powerpc                     ep8248e_defconfig
xtensa                       common_defconfig
h8300                               defconfig
ia64                             allmodconfig
ia64                                defconfig
powerpc                      katmai_defconfig
sh                         ecovec24_defconfig
powerpc                     mpc5200_defconfig
mips                         mpc30x_defconfig
parisc                           alldefconfig
powerpc                       holly_defconfig
sh                        sh7785lcr_defconfig
m68k                          multi_defconfig
sh                          landisk_defconfig
arm                          pcm027_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          imote2_defconfig
arm                          gemini_defconfig
arm                          exynos_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc834x_mds_defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210419
x86_64               randconfig-a001-20210419
x86_64               randconfig-a005-20210419
x86_64               randconfig-a002-20210419
x86_64               randconfig-a006-20210419
x86_64               randconfig-a004-20210419
i386                 randconfig-a003-20210419
i386                 randconfig-a001-20210419
i386                 randconfig-a006-20210419
i386                 randconfig-a005-20210419
i386                 randconfig-a004-20210419
i386                 randconfig-a002-20210419
i386                 randconfig-a015-20210419
i386                 randconfig-a013-20210419
i386                 randconfig-a014-20210419
i386                 randconfig-a016-20210419
i386                 randconfig-a012-20210419
i386                 randconfig-a011-20210419
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210419
x86_64               randconfig-a015-20210419
x86_64               randconfig-a013-20210419
x86_64               randconfig-a011-20210419
x86_64               randconfig-a012-20210419
x86_64               randconfig-a016-20210419

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

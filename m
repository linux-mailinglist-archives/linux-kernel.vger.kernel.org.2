Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0612C3BC3A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 23:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhGEVfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 17:35:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:40797 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233057AbhGEVff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 17:35:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="189405285"
X-IronPort-AV: E=Sophos;i="5.83,326,1616482800"; 
   d="scan'208";a="189405285"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 14:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,326,1616482800"; 
   d="scan'208";a="422622637"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jul 2021 14:32:57 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m0WD2-000CbP-LJ; Mon, 05 Jul 2021 21:32:56 +0000
Date:   Tue, 06 Jul 2021 05:32:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ae3527382df224b8151f6dd4d7409c602ddcd596
Message-ID: <60e37a5f.E1d1GjWCNNspxvBG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ae3527382df224b8151f6dd4d7409c602ddcd596  Merge branch 'locking/urgent'

elapsed time: 726m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                         virt_defconfig
arc                                 defconfig
arm                            pleb_defconfig
xtensa                    smp_lx200_defconfig
arc                        nsim_700_defconfig
arm                        vexpress_defconfig
mips                     loongson2k_defconfig
arm                        mvebu_v5_defconfig
x86_64                           alldefconfig
m68k                       m5275evb_defconfig
powerpc                     tqm8560_defconfig
arm                     davinci_all_defconfig
arm                         socfpga_defconfig
mips                     loongson1c_defconfig
mips                        maltaup_defconfig
sparc64                          alldefconfig
xtensa                          iss_defconfig
sh                      rts7751r2d1_defconfig
arc                        vdk_hs38_defconfig
powerpc                       holly_defconfig
powerpc                    ge_imp3a_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     ep8248e_defconfig
sparc                            alldefconfig
powerpc                      acadia_defconfig
sh                             shx3_defconfig
sh                           se7619_defconfig
mips                           ci20_defconfig
sh                             sh03_defconfig
sh                            titan_defconfig
mips                       rbtx49xx_defconfig
powerpc                        cell_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         cm_x300_defconfig
sh                           se7750_defconfig
arm                       multi_v4t_defconfig
s390                             allyesconfig
powerpc                     mpc5200_defconfig
powerpc                     tqm8540_defconfig
m68k                          hp300_defconfig
mips                         tb0219_defconfig
mips                       capcella_defconfig
mips                           gcw0_defconfig
powerpc                     mpc512x_defconfig
sh                        sh7757lcr_defconfig
arc                        nsimosci_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     mpc83xx_defconfig
mips                        vocore2_defconfig
arm                      jornada720_defconfig
arm                        realview_defconfig
csky                             alldefconfig
xtensa                       common_defconfig
arm                          gemini_defconfig
sh                          rsk7269_defconfig
powerpc                      makalu_defconfig
mips                        workpad_defconfig
powerpc                     tqm5200_defconfig
arm                           stm32_defconfig
um                                  defconfig
arm                         orion5x_defconfig
m68k                          multi_defconfig
s390                       zfcpdump_defconfig
mips                  cavium_octeon_defconfig
m68k                       m5475evb_defconfig
mips                     cu1000-neo_defconfig
sh                           se7206_defconfig
m68k                          atari_defconfig
arm                        multi_v5_defconfig
ia64                            zx1_defconfig
openrisc                  or1klitex_defconfig
arm                       aspeed_g5_defconfig
arm                       cns3420vb_defconfig
um                             i386_defconfig
parisc                generic-32bit_defconfig
arm                         hackkit_defconfig
powerpc                    mvme5100_defconfig
powerpc                 canyonlands_defconfig
powerpc                  mpc885_ads_defconfig
m68k                        mvme16x_defconfig
m68k                         amcore_defconfig
parisc                           allyesconfig
sh                           se7721_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
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
x86_64               randconfig-a004-20210705
x86_64               randconfig-a002-20210705
x86_64               randconfig-a005-20210705
x86_64               randconfig-a006-20210705
x86_64               randconfig-a003-20210705
x86_64               randconfig-a001-20210705
i386                 randconfig-a004-20210705
i386                 randconfig-a006-20210705
i386                 randconfig-a001-20210705
i386                 randconfig-a003-20210705
i386                 randconfig-a005-20210705
i386                 randconfig-a002-20210705
i386                 randconfig-a015-20210705
i386                 randconfig-a016-20210705
i386                 randconfig-a012-20210705
i386                 randconfig-a011-20210705
i386                 randconfig-a014-20210705
i386                 randconfig-a013-20210705
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210705
x86_64               randconfig-a015-20210705
x86_64               randconfig-a014-20210705
x86_64               randconfig-a012-20210705
x86_64               randconfig-a011-20210705
x86_64               randconfig-a016-20210705
x86_64               randconfig-a013-20210705

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

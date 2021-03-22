Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86440344904
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhCVPP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:15:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:19902 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhCVPPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:15:37 -0400
IronPort-SDR: 8nPfxkHMUeMeCzYQqzaC3SZu+D8WZqjL3PKNkyl1j4PWikIO0r8FVVqXyNgbjEtHasKt3blMM2
 pLBX7Oy2flVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="170251357"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="170251357"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 08:15:34 -0700
IronPort-SDR: SZYRT8xe714sBHz4WH3p31ZMCmNMEqYc9rRJXpzelKEDbKsS/Ii8WwROmqt+t5/2GBsHBehzU6
 DBvpySfAVbYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="513345237"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2021 08:15:33 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lOMHE-00009A-Eb; Mon, 22 Mar 2021 15:15:32 +0000
Date:   Mon, 22 Mar 2021 23:14:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 3b03706fa621ce31a3e9ef6307020fde4e6aae16
Message-ID: <6058b45e.PW+o6tJ2UPhg1mE2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 3b03706fa621ce31a3e9ef6307020fde4e6aae16  sched: Fix various typos

elapsed time: 723m

configs tested: 153
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
riscv                            allyesconfig
i386                             allyesconfig
arm                         socfpga_defconfig
m68k                         apollo_defconfig
parisc                generic-64bit_defconfig
xtensa                       common_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                         ps3_defconfig
nds32                            alldefconfig
arc                         haps_hs_defconfig
powerpc                     mpc512x_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc836x_mds_defconfig
sh                                  defconfig
sh                          urquell_defconfig
xtensa                    xip_kc705_defconfig
sh                        sh7757lcr_defconfig
m68k                        m5407c3_defconfig
sh                          polaris_defconfig
powerpc                      mgcoge_defconfig
mips                      pic32mzda_defconfig
powerpc                      arches_defconfig
arm                            mmp2_defconfig
riscv                               defconfig
m68k                       m5475evb_defconfig
mips                          rm200_defconfig
alpha                            allyesconfig
powerpc                     skiroot_defconfig
arc                          axs103_defconfig
arm                            zeus_defconfig
arm                        mvebu_v7_defconfig
s390                                defconfig
arm                          pcm027_defconfig
powerpc                       ppc64_defconfig
mips                       lemote2f_defconfig
arm                     eseries_pxa_defconfig
arm                      tct_hammer_defconfig
powerpc                      walnut_defconfig
arm                      footbridge_defconfig
mips                   sb1250_swarm_defconfig
sh                               alldefconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     ep8248e_defconfig
sh                     magicpanelr2_defconfig
powerpc                    klondike_defconfig
sh                        dreamcast_defconfig
powerpc                     kilauea_defconfig
i386                                defconfig
sh                          rsk7201_defconfig
powerpc                  iss476-smp_defconfig
mips                           ip27_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     kmeter1_defconfig
ia64                          tiger_defconfig
arm                        vexpress_defconfig
ia64                      gensparse_defconfig
mips                         db1xxx_defconfig
arm                       versatile_defconfig
arm                            dove_defconfig
mips                        vocore2_defconfig
mips                      fuloong2e_defconfig
sh                          r7780mp_defconfig
mips                        bcm47xx_defconfig
powerpc                        icon_defconfig
mips                           ip28_defconfig
arm                          simpad_defconfig
s390                       zfcpdump_defconfig
sh                        apsh4ad0a_defconfig
mips                      loongson3_defconfig
powerpc                     mpc5200_defconfig
arm                         cm_x300_defconfig
sh                           se7722_defconfig
powerpc                    socrates_defconfig
mips                           gcw0_defconfig
sh                           se7206_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                          amiga_defconfig
mips                          malta_defconfig
m68k                            mac_defconfig
powerpc                 mpc8272_ads_defconfig
mips                            gpr_defconfig
sh                           se7619_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc8315_rdb_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210322
i386                 randconfig-a003-20210322
i386                 randconfig-a001-20210322
i386                 randconfig-a002-20210322
i386                 randconfig-a006-20210322
i386                 randconfig-a005-20210322
x86_64               randconfig-a012-20210322
x86_64               randconfig-a015-20210322
x86_64               randconfig-a013-20210322
x86_64               randconfig-a014-20210322
x86_64               randconfig-a016-20210322
x86_64               randconfig-a011-20210322
i386                 randconfig-a014-20210322
i386                 randconfig-a011-20210322
i386                 randconfig-a015-20210322
i386                 randconfig-a016-20210322
i386                 randconfig-a012-20210322
i386                 randconfig-a013-20210322
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210322
x86_64               randconfig-a003-20210322
x86_64               randconfig-a001-20210322
x86_64               randconfig-a006-20210322
x86_64               randconfig-a004-20210322
x86_64               randconfig-a005-20210322

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

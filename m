Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D133B9415
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 17:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhGAPlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 11:41:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:58858 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233588AbhGAPlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 11:41:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="188939466"
X-IronPort-AV: E=Sophos;i="5.83,314,1616482800"; 
   d="scan'208";a="188939466"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 08:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,314,1616482800"; 
   d="scan'208";a="457706397"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2021 08:38:50 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyym9-000AcJ-Cd; Thu, 01 Jul 2021 15:38:49 +0000
Date:   Thu, 01 Jul 2021 23:37:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/clang-fallthrough] BUILD SUCCESS
 9cd4c121b15b50e32f797c1ad140a0a0f93aca51
Message-ID: <60dde152.4TjoqK8v5bVUCbM4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/clang-fallthrough
branch HEAD: 9cd4c121b15b50e32f797c1ad140a0a0f93aca51  scsi: aic94xx: Fix fall-through warning for Clang

elapsed time: 723m

configs tested: 148
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          urquell_defconfig
arm                          pcm027_defconfig
arc                    vdk_hs38_smp_defconfig
arc                        nsimosci_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      tqm8xx_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     tqm8548_defconfig
sh                           se7619_defconfig
mips                        workpad_defconfig
arm                         at91_dt_defconfig
sh                           se7712_defconfig
ia64                         bigsur_defconfig
mips                      maltasmvp_defconfig
arm                       omap2plus_defconfig
arm                         axm55xx_defconfig
m68k                        mvme16x_defconfig
powerpc                     ep8248e_defconfig
arm                            xcep_defconfig
sh                          sdk7786_defconfig
sh                        dreamcast_defconfig
sh                        edosk7705_defconfig
arm                            zeus_defconfig
powerpc                       maple_defconfig
powerpc                 mpc834x_mds_defconfig
arm                          collie_defconfig
sh                           se7721_defconfig
arc                            hsdk_defconfig
arm                       netwinder_defconfig
powerpc                 mpc8540_ads_defconfig
parisc                           alldefconfig
mips                         db1xxx_defconfig
sh                          r7785rp_defconfig
sh                          rsk7203_defconfig
s390                             allyesconfig
mips                        qi_lb60_defconfig
powerpc                        warp_defconfig
arm                           h5000_defconfig
mips                   sb1250_swarm_defconfig
mips                      bmips_stb_defconfig
powerpc                     sequoia_defconfig
xtensa                       common_defconfig
arm                       spear13xx_defconfig
sh                          landisk_defconfig
um                               alldefconfig
sh                              ul2_defconfig
ia64                             allmodconfig
m68k                        m5307c3_defconfig
arm                        magician_defconfig
mips                          ath25_defconfig
sh                          sdk7780_defconfig
mips                          rm200_defconfig
mips                        omega2p_defconfig
mips                  decstation_64_defconfig
powerpc                  mpc885_ads_defconfig
sh                           se7206_defconfig
nios2                            alldefconfig
mips                     loongson1c_defconfig
sh                           se7343_defconfig
x86_64                            allnoconfig
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
x86_64               randconfig-a002-20210630
x86_64               randconfig-a001-20210630
x86_64               randconfig-a004-20210630
x86_64               randconfig-a005-20210630
x86_64               randconfig-a006-20210630
x86_64               randconfig-a003-20210630
i386                 randconfig-a004-20210630
i386                 randconfig-a001-20210630
i386                 randconfig-a003-20210630
i386                 randconfig-a002-20210630
i386                 randconfig-a005-20210630
i386                 randconfig-a006-20210630
i386                 randconfig-a015-20210701
i386                 randconfig-a016-20210701
i386                 randconfig-a011-20210701
i386                 randconfig-a012-20210701
i386                 randconfig-a013-20210701
i386                 randconfig-a014-20210701
i386                 randconfig-a014-20210630
i386                 randconfig-a011-20210630
i386                 randconfig-a016-20210630
i386                 randconfig-a012-20210630
i386                 randconfig-a013-20210630
i386                 randconfig-a015-20210630
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210630
x86_64               randconfig-a012-20210630
x86_64               randconfig-a015-20210630
x86_64               randconfig-a016-20210630
x86_64               randconfig-a013-20210630
x86_64               randconfig-a011-20210630
x86_64               randconfig-a014-20210630
x86_64               randconfig-a015-20210701
x86_64               randconfig-a012-20210701
x86_64               randconfig-a014-20210701
x86_64               randconfig-a011-20210701
x86_64               randconfig-a016-20210701
x86_64               randconfig-a013-20210701

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

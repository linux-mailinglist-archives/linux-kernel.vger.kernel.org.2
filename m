Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA23C7599
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhGMRTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:19:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:24282 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMRTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:19:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="271324176"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="271324176"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 10:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="654472036"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2021 10:16:11 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3M0w-000I1J-Ol; Tue, 13 Jul 2021 17:16:10 +0000
Date:   Wed, 14 Jul 2021 01:15:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/clang-fallthrough] BUILD SUCCESS WITH
 WARNING 570d444e9f773ab12a6a4281b357fc5b80e4dd7a
Message-ID: <60edca25.k00ut905IFBjPyt5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/clang-fallthrough
branch HEAD: 570d444e9f773ab12a6a4281b357fc5b80e4dd7a  Makefile: Enable -Wimplicit-fallthrough for Clang

Warning in current branch:

kernel/sched/core.c:3141:4: warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
sound/core/pcm_native.c:3799:3: warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]

possible Warning in current branch:

arch/mips/include/asm/fpu.h:79:3: warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
arch/mips/mm/tlbex.c:1386:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/char/lp.c:764:3: warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
drivers/dma/ipu/ipu_idmac.c:621:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:382:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/mmc/host/jz4740_mmc.c:792:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/pci/proc.c:234:3: warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
drivers/scsi/libsas/sas_discover.c:467:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/video/fbdev/xilinxfb.c:244:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
include/math-emu/op-common.h:332:8: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- nds32-randconfig-r004-20210713
    `-- include-math-emu-op-common.h:warning:this-statement-may-fall-through

clang_recent_errors
|-- arm64-randconfig-r002-20210711
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-pci-proc.c:warning:fallthrough-annotation-in-unreachable-code
|   |-- drivers-scsi-libsas-sas_discover.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-video-fbdev-xilinxfb.c:warning:unannotated-fall-through-between-switch-labels
|   `-- kernel-sched-core.c:warning:fallthrough-annotation-in-unreachable-code
|-- arm64-randconfig-r036-20210713
|   `-- drivers-dma-ipu-ipu_idmac.c:warning:unannotated-fall-through-between-switch-labels
|-- mips-randconfig-r025-20210713
|   |-- arch-mips-include-asm-fpu.h:warning:fallthrough-annotation-in-unreachable-code
|   |-- arch-mips-mm-tlbex.c:warning:unannotated-fall-through-between-switch-labels
|   `-- drivers-mmc-host-jz4740_mmc.c:warning:unannotated-fall-through-between-switch-labels
|-- riscv-buildonly-randconfig-r003-20210712
|   |-- kernel-sched-core.c:warning:fallthrough-annotation-in-unreachable-code
|   `-- sound-core-pcm_native.c:warning:fallthrough-annotation-in-unreachable-code
|-- x86_64-randconfig-a003-20210713
|   |-- drivers-char-lp.c:warning:fallthrough-annotation-in-unreachable-code
|   `-- drivers-scsi-libsas-sas_discover.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a004-20210713
|   `-- drivers-scsi-libsas-sas_discover.c:warning:unannotated-fall-through-between-switch-labels
`-- x86_64-randconfig-a006-20210713
    `-- kernel-sched-core.c:warning:fallthrough-annotation-in-unreachable-code

elapsed time: 864m

configs tested: 135
configs skipped: 5

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      ep88xc_defconfig
arc                     haps_hs_smp_defconfig
sh                             espt_defconfig
arm                             ezx_defconfig
riscv                          rv32_defconfig
arm                  colibri_pxa300_defconfig
h8300                       h8s-sim_defconfig
arm                         axm55xx_defconfig
m68k                        m5407c3_defconfig
mips                         db1xxx_defconfig
arm                         assabet_defconfig
arm                         orion5x_defconfig
sh                          urquell_defconfig
powerpc                    gamecube_defconfig
arm                    vt8500_v6_v7_defconfig
nds32                               defconfig
arm                       netwinder_defconfig
xtensa                           alldefconfig
sh                            migor_defconfig
arm                     davinci_all_defconfig
mips                         tb0219_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     akebono_defconfig
powerpc                    mvme5100_defconfig
arm                            mps2_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc8313_rdb_defconfig
riscv                            allyesconfig
sh                          r7785rp_defconfig
microblaze                          defconfig
arm                         nhk8815_defconfig
mips                         tb0287_defconfig
powerpc                   motionpro_defconfig
powerpc                  storcenter_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     taishan_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    klondike_defconfig
powerpc                      ppc40x_defconfig
arm                           viper_defconfig
arm                          gemini_defconfig
powerpc                 mpc8560_ads_defconfig
arm                            mmp2_defconfig
arm                        multi_v5_defconfig
mips                            e55_defconfig
arm                            zeus_defconfig
powerpc                     powernv_defconfig
sh                           se7343_defconfig
arm                          badge4_defconfig
arm                       multi_v4t_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
csky                                defconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210712
x86_64               randconfig-a003-20210712
x86_64               randconfig-a005-20210712
x86_64               randconfig-a006-20210712
i386                 randconfig-a004-20210712
i386                 randconfig-a006-20210712
i386                 randconfig-a005-20210713
i386                 randconfig-a004-20210713
i386                 randconfig-a006-20210713
i386                 randconfig-a001-20210713
i386                 randconfig-a002-20210713
i386                 randconfig-a003-20210713
i386                 randconfig-a005-20210712
i386                 randconfig-a001-20210712
i386                 randconfig-a002-20210712
x86_64               randconfig-a013-20210713
x86_64               randconfig-a014-20210713
x86_64               randconfig-a012-20210713
x86_64               randconfig-a015-20210713
x86_64               randconfig-a016-20210713
x86_64               randconfig-a011-20210713
i386                 randconfig-a014-20210712
i386                 randconfig-a013-20210712
i386                 randconfig-a016-20210712
i386                 randconfig-a015-20210712
i386                 randconfig-a011-20210712
i386                 randconfig-a012-20210712
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-b001-20210713
x86_64               randconfig-a005-20210713
x86_64               randconfig-a004-20210713
x86_64               randconfig-a003-20210713
x86_64               randconfig-a002-20210713
x86_64               randconfig-a006-20210713
x86_64               randconfig-a001-20210713

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

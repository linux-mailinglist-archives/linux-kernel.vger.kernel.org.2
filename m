Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEF43C3351
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 08:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhGJGzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 02:55:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:5167 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhGJGzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 02:55:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="197085651"
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="197085651"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 23:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="647443087"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jul 2021 23:52:26 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m26qg-000FSH-5K; Sat, 10 Jul 2021 06:52:26 +0000
Date:   Sat, 10 Jul 2021 14:52:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 48400483565f0b7e633cbef94b139ff295b59de3
Message-ID: <60e94396.pf3Y4bDNpXLs/Li+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 48400483565f0b7e633cbef94b139ff295b59de3  Merge tag 'irqchip-fixes-5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 1027m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                generic_kc705_defconfig
powerpc                    socrates_defconfig
powerpc                      mgcoge_defconfig
arm                             rpc_defconfig
sh                          rsk7201_defconfig
arm                          imote2_defconfig
mips                      malta_kvm_defconfig
arm                          pcm027_defconfig
mips                       lemote2f_defconfig
arm                         orion5x_defconfig
mips                   sb1250_swarm_defconfig
mips                           gcw0_defconfig
m68k                            q40_defconfig
mips                        jmr3927_defconfig
sh                           se7705_defconfig
powerpc64                           defconfig
h8300                    h8300h-sim_defconfig
arm                         s3c2410_defconfig
arm                       spear13xx_defconfig
powerpc                       maple_defconfig
m68k                        m5307c3_defconfig
powerpc                    gamecube_defconfig
arm                            dove_defconfig
mips                          ath79_defconfig
arc                         haps_hs_defconfig
arc                            hsdk_defconfig
arm                         shannon_defconfig
alpha                            alldefconfig
mips                malta_qemu_32r6_defconfig
powerpc                     taishan_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      obs600_defconfig
sh                           se7343_defconfig
sh                             sh03_defconfig
powerpc                      cm5200_defconfig
arm                         s5pv210_defconfig
riscv                             allnoconfig
sh                           sh2007_defconfig
m68k                         apollo_defconfig
mips                     loongson1c_defconfig
arm                           viper_defconfig
s390                             allyesconfig
arm                        mvebu_v5_defconfig
mips                       capcella_defconfig
mips                      pistachio_defconfig
arc                                 defconfig
mips                  maltasmvp_eva_defconfig
mips                           xway_defconfig
arc                    vdk_hs38_smp_defconfig
mips                           rs90_defconfig
powerpc                      ppc64e_defconfig
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
x86_64               randconfig-a004-20210709
x86_64               randconfig-a005-20210709
x86_64               randconfig-a002-20210709
x86_64               randconfig-a006-20210709
x86_64               randconfig-a003-20210709
x86_64               randconfig-a001-20210709
i386                 randconfig-a006-20210709
i386                 randconfig-a004-20210709
i386                 randconfig-a001-20210709
i386                 randconfig-a003-20210709
i386                 randconfig-a005-20210709
i386                 randconfig-a002-20210709
i386                 randconfig-a015-20210709
i386                 randconfig-a016-20210709
i386                 randconfig-a011-20210709
i386                 randconfig-a012-20210709
i386                 randconfig-a013-20210709
i386                 randconfig-a014-20210709
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-b001-20210709
x86_64               randconfig-a015-20210709
x86_64               randconfig-a011-20210709
x86_64               randconfig-a012-20210709
x86_64               randconfig-a014-20210709
x86_64               randconfig-a016-20210709
x86_64               randconfig-a013-20210709

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1043632B8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 01:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhDQX5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 19:57:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:23512 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhDQX5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 19:57:00 -0400
IronPort-SDR: qEj99afdF70h+L+kQPwdAFMaHmRZ8a1y89tUN1dg+hNWftGqXQu4VHpbpwHIxjMuG9LHeKXXZf
 Olm8zEFZQrvw==
X-IronPort-AV: E=McAfee;i="6200,9189,9957"; a="195219579"
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="195219579"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 16:56:32 -0700
IronPort-SDR: 3fuMSAGRb86Hf3eb8E9V6jW3k6KpeEg6NX2I8eL0bgE2nrRtrFOwIq5B58W4AZ6rowg8OZcUlL
 PC3RYrfQ8kmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="384633843"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Apr 2021 16:56:29 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXunc-000158-Df; Sat, 17 Apr 2021 23:56:28 +0000
Date:   Sun, 18 Apr 2021 07:56:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 84a24bf8c52e66b7ac89ada5e3cfbe72d65c1896
Message-ID: <607b759b.j2kYG3eJobnKYtr4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 84a24bf8c52e66b7ac89ada5e3cfbe72d65c1896  locking/qrwlock: Fix ordering in queued_write_lock_slowpath()

elapsed time: 723m

configs tested: 119
configs skipped: 2

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
powerpc                       ebony_defconfig
powerpc                     ksi8560_defconfig
powerpc                      pcm030_defconfig
powerpc                      pasemi_defconfig
m68k                          amiga_defconfig
ia64                          tiger_defconfig
mips                  decstation_64_defconfig
powerpc                        icon_defconfig
powerpc                      arches_defconfig
arm                        vexpress_defconfig
powerpc                       eiger_defconfig
sh                            hp6xx_defconfig
arm                        trizeps4_defconfig
powerpc                   motionpro_defconfig
powerpc                     powernv_defconfig
sh                             espt_defconfig
m68k                        mvme147_defconfig
sh                           se7780_defconfig
sh                          lboxre2_defconfig
mips                           gcw0_defconfig
arm                       aspeed_g5_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     sbc8548_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      ppc44x_defconfig
arm                            zeus_defconfig
sh                           se7705_defconfig
arm                       omap2plus_defconfig
powerpc                     mpc83xx_defconfig
mips                      loongson3_defconfig
riscv                          rv32_defconfig
i386                             alldefconfig
arm                        shmobile_defconfig
mips                      pic32mzda_defconfig
m68k                          atari_defconfig
openrisc                            defconfig
arm                         s3c2410_defconfig
arm                         bcm2835_defconfig
powerpc                    socrates_defconfig
arm                             rpc_defconfig
arm                      footbridge_defconfig
arm                        neponset_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
x86_64               randconfig-a003-20210417
x86_64               randconfig-a002-20210417
x86_64               randconfig-a005-20210417
x86_64               randconfig-a001-20210417
x86_64               randconfig-a006-20210417
x86_64               randconfig-a004-20210417
i386                 randconfig-a003-20210417
i386                 randconfig-a006-20210417
i386                 randconfig-a001-20210417
i386                 randconfig-a005-20210417
i386                 randconfig-a004-20210417
i386                 randconfig-a002-20210417
i386                 randconfig-a015-20210417
i386                 randconfig-a014-20210417
i386                 randconfig-a013-20210417
i386                 randconfig-a012-20210417
i386                 randconfig-a016-20210417
i386                 randconfig-a011-20210417
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a014-20210417
x86_64               randconfig-a015-20210417
x86_64               randconfig-a011-20210417
x86_64               randconfig-a013-20210417
x86_64               randconfig-a012-20210417
x86_64               randconfig-a016-20210417

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394C83C97CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 06:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbhGOE4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 00:56:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:20364 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbhGOE4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:56:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190154378"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="190154378"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 21:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="413004881"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2021 21:53:32 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3tNM-000JMW-8v; Thu, 15 Jul 2021 04:53:32 +0000
Date:   Thu, 15 Jul 2021 12:52:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/clang-fallthrough] BUILD SUCCESS WITH
 WARNING b7eb335e26a9c7f258c96b3962c283c379d3ede0
Message-ID: <60efbf18.d9n6eXv275OJcc7T%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/clang-fallthrough
branch HEAD: b7eb335e26a9c7f258c96b3962c283c379d3ede0  Makefile: Enable -Wimplicit-fallthrough for Clang

Warning in current branch:

sound/core/pcm_native.c:3799:3: warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]

possible Warning in current branch:

arch/powerpc/platforms/pasemi/idle.c:45:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/char/lp.c:736:3: warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm-randconfig-r002-20210714
|   |-- drivers-char-lp.c:warning:fallthrough-annotation-in-unreachable-code
|   `-- sound-core-pcm_native.c:warning:fallthrough-annotation-in-unreachable-code
`-- powerpc-randconfig-r024-20210714
    `-- arch-powerpc-platforms-pasemi-idle.c:warning:unannotated-fall-through-between-switch-labels

elapsed time: 720m

configs tested: 126
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  cavium_octeon_defconfig
arm                         hackkit_defconfig
arc                        vdk_hs38_defconfig
arm                           omap1_defconfig
arm                           tegra_defconfig
sh                          polaris_defconfig
mips                      pic32mzda_defconfig
powerpc                      bamboo_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                            gpr_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                   bluestone_defconfig
arm                         lpc18xx_defconfig
powerpc                 mpc834x_mds_defconfig
mips                 decstation_r4k_defconfig
arm                  colibri_pxa300_defconfig
sh                           se7705_defconfig
powerpc                     sequoia_defconfig
mips                  decstation_64_defconfig
m68k                        m5272c3_defconfig
s390                       zfcpdump_defconfig
sh                        sh7763rdp_defconfig
ia64                         bigsur_defconfig
powerpc                     tqm8548_defconfig
arm                         s3c2410_defconfig
powerpc                      ppc44x_defconfig
powerpc                    ge_imp3a_defconfig
mips                           ip27_defconfig
arc                            hsdk_defconfig
mips                       capcella_defconfig
powerpc64                        alldefconfig
parisc                           alldefconfig
openrisc                            defconfig
mips                        maltaup_defconfig
mips                           ci20_defconfig
arc                                 defconfig
powerpc                     mpc83xx_defconfig
powerpc                 canyonlands_defconfig
mips                           ip28_defconfig
arm                         s3c6400_defconfig
powerpc                       holly_defconfig
openrisc                 simple_smp_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
s390                             allyesconfig
parisc                           allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210714
x86_64               randconfig-a004-20210714
x86_64               randconfig-a002-20210714
x86_64               randconfig-a003-20210714
x86_64               randconfig-a006-20210714
x86_64               randconfig-a001-20210714
i386                 randconfig-a005-20210714
i386                 randconfig-a006-20210714
i386                 randconfig-a004-20210714
i386                 randconfig-a001-20210714
i386                 randconfig-a003-20210714
i386                 randconfig-a002-20210714
x86_64               randconfig-a013-20210715
x86_64               randconfig-a012-20210715
x86_64               randconfig-a015-20210715
x86_64               randconfig-a014-20210715
x86_64               randconfig-a016-20210715
x86_64               randconfig-a011-20210715
i386                 randconfig-a014-20210714
i386                 randconfig-a015-20210714
i386                 randconfig-a011-20210714
i386                 randconfig-a013-20210714
i386                 randconfig-a012-20210714
i386                 randconfig-a016-20210714
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210714
x86_64               randconfig-b001-20210715
x86_64               randconfig-a013-20210714
x86_64               randconfig-a015-20210714
x86_64               randconfig-a012-20210714
x86_64               randconfig-a014-20210714
x86_64               randconfig-a016-20210714
x86_64               randconfig-a011-20210714

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

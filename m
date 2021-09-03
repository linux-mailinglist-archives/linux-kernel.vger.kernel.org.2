Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA6400121
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349194AbhICOVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:21:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:57548 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhICOVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:21:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="304996074"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="304996074"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="521710705"
Received: from lkp-server01.sh.intel.com (HELO 2115029a3e5c) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2021 07:20:07 -0700
Received: from kbuild by 2115029a3e5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mMA34-0000XC-VP; Fri, 03 Sep 2021 14:20:06 +0000
Date:   Fri, 03 Sep 2021 22:19:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS WITH WARNING
 340576590dac4bb58d532a8ad5bfa806d8ab473c
Message-ID: <61322ed8.9KjUhAGZIAit9egN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 340576590dac4bb58d532a8ad5bfa806d8ab473c  futex: Avoid redundant task lookup

Warning reports:

https://lore.kernel.org/lkml/202109030619.m4Qsguzx-lkp@intel.com

Warning in current branch:

kernel/futex.c:2016:18: warning: variable 'vpid' set but not used [-Wunused-but-set-variable]
kernel/futex.c:2037:11: warning: variable 'vpid' set but not used [-Wunused-but-set-variable]
kernel/futex.c:2037:18: warning: variable 'vpid' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allnoconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- alpha-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- alpha-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- alpha-randconfig-r005-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- alpha-randconfig-r006-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arc-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arc-axs103_smp_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arc-buildonly-randconfig-r005-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arc-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arc-randconfig-r001-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arc-randconfig-r013-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arc-randconfig-r021-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arc-randconfig-r032-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm-allmodconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm-aspeed_g5_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm-davinci_all_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm-hisi_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm-pcm027_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm-randconfig-r005-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm-tegra_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm-versatile_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm64-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm64-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm64-randconfig-r016-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- arm64-randconfig-r023-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- csky-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- csky-randconfig-r003-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- h8300-allmodconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- h8300-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- h8300-randconfig-r004-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- h8300-randconfig-r014-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- h8300-randconfig-r026-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- h8300-randconfig-r036-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- i386-alldefconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- i386-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- i386-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- i386-randconfig-c021-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- i386-randconfig-m021-20210902
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- i386-randconfig-m021-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- i386-randconfig-r022-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- i386-randconfig-s001-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- i386-randconfig-s002-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- ia64-allmodconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- ia64-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- ia64-buildonly-randconfig-r003-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- ia64-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- ia64-randconfig-r024-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- m68k-allmodconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- m68k-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- m68k-buildonly-randconfig-r006-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- m68k-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- m68k-mac_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- m68k-mvme147_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- m68k-randconfig-r004-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- m68k-randconfig-r014-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- m68k-randconfig-r021-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- microblaze-allmodconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- microblaze-buildonly-randconfig-r001-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- microblaze-randconfig-r004-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- microblaze-randconfig-r022-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- mips-allmodconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- mips-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- mips-buildonly-randconfig-r001-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- mips-capcella_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- mips-cobalt_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- mips-gcw0_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- mips-randconfig-r033-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- mips-rbtx49xx_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- mips-workpad_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nds32-allnoconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nds32-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nds32-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nds32-randconfig-r003-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nds32-randconfig-r005-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nds32-randconfig-r012-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nds32-randconfig-r036-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nios2-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nios2-buildonly-randconfig-r005-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nios2-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nios2-randconfig-r023-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nios2-randconfig-r031-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nios2-randconfig-r034-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- nios2-randconfig-r036-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- openrisc-buildonly-randconfig-r004-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- openrisc-randconfig-r021-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- parisc-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- parisc-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- parisc-randconfig-r012-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- parisc-randconfig-r015-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-acadia_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-allmodconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-allnoconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-asp8347_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-gamecube_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-lite5200b_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-mpc832x_rdb_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-pmac32_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-ppc40x_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-randconfig-r011-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-randconfig-r015-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc-sequoia_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc64-randconfig-c023-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc64-randconfig-r021-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- powerpc64-randconfig-r026-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- riscv-allmodconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- riscv-allnoconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- riscv-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- riscv-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- riscv-nommu_virt_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- riscv-randconfig-r025-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- riscv-randconfig-r042-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- riscv-rv32_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- s390-allmodconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- s390-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- s390-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- s390-randconfig-r023-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- s390-randconfig-r044-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- sh-allmodconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- sh-edosk7705_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- sparc-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- sparc-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- sparc-randconfig-r035-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- sparc64-randconfig-r005-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- sparc64-randconfig-r016-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- sparc64-randconfig-r034-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- um-i386_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- um-x86_64_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-allmodconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-kexec
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a001-20210902
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a002-20210902
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a003-20210902
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a004-20210902
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a005-20210902
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a006-20210902
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a011-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a012-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a013-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a014-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a015-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-a016-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-c022-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-randconfig-r025-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-rhel-8.3
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- x86_64-rhel-8.3-kselftests
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- xtensa-allyesconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- xtensa-buildonly-randconfig-r004-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- xtensa-iss_defconfig
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- xtensa-randconfig-r006-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
|-- xtensa-randconfig-r014-20210903
|   `-- kernel-futex.c:warning:variable-vpid-set-but-not-used
`-- xtensa-randconfig-r015-20210903
    `-- kernel-futex.c:warning:variable-vpid-set-but-not-used

elapsed time: 1087m

configs tested: 114
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
powerpc                    gamecube_defconfig
powerpc                      acadia_defconfig
arm                       versatile_defconfig
sh                        sh7757lcr_defconfig
sh                   secureedge5410_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
powerpc                      pmac32_defconfig
mips                         cobalt_defconfig
sh                        edosk7705_defconfig
xtensa                          iss_defconfig
sh                           sh2007_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
arm                          pcm027_defconfig
i386                             alldefconfig
arm                       aspeed_g5_defconfig
m68k                       m5275evb_defconfig
mips                        bcm63xx_defconfig
mips                       capcella_defconfig
powerpc                     sequoia_defconfig
mips                       rbtx49xx_defconfig
m68k                            mac_defconfig
arm                           tegra_defconfig
sh                          rsk7201_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                   lite5200b_defconfig
powerpc                     asp8347_defconfig
m68k                        mvme147_defconfig
powerpc                      ppc40x_defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210902
x86_64               randconfig-a006-20210902
x86_64               randconfig-a003-20210902
x86_64               randconfig-a005-20210902
x86_64               randconfig-a001-20210902
x86_64               randconfig-a002-20210902
x86_64               randconfig-a016-20210903
x86_64               randconfig-a011-20210903
x86_64               randconfig-a012-20210903
x86_64               randconfig-a015-20210903
x86_64               randconfig-a014-20210903
x86_64               randconfig-a013-20210903
riscv                randconfig-r042-20210903
s390                 randconfig-r044-20210903
arc                  randconfig-r043-20210903
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210903
x86_64               randconfig-a006-20210903
x86_64               randconfig-a003-20210903
x86_64               randconfig-a005-20210903
x86_64               randconfig-a001-20210903
x86_64               randconfig-a002-20210903
i386                 randconfig-a005-20210903
i386                 randconfig-a004-20210903
i386                 randconfig-a006-20210903
i386                 randconfig-a002-20210903
i386                 randconfig-a001-20210903
i386                 randconfig-a003-20210903
hexagon              randconfig-r045-20210903
hexagon              randconfig-r041-20210903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ECE3ECAA5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 21:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhHOTXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 15:23:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:39751 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhHOTXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 15:23:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="215790942"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="215790942"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 12:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="640298304"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2021 12:22:43 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mFLiV-000Q1c-6k; Sun, 15 Aug 2021 19:22:43 +0000
Date:   Mon, 16 Aug 2021 03:22:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5b38334330db0396aa56c34a6ee88b06425a0986
Message-ID: <6119696b.av1zWMZf3Ul8lBgV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5b38334330db0396aa56c34a6ee88b06425a0986  Merge branch 'core/debugobjects'

elapsed time: 723m

configs tested: 177
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210815
i386                 randconfig-c001-20210816
sh                          rsk7264_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                   currituck_defconfig
powerpc                     tqm8560_defconfig
sh                           se7780_defconfig
sh                          landisk_defconfig
mips                         mpc30x_defconfig
powerpc                     ksi8560_defconfig
mips                      fuloong2e_defconfig
powerpc                     asp8347_defconfig
arm                             rpc_defconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
sh                   secureedge5410_defconfig
powerpc                     tqm8540_defconfig
arm                        neponset_defconfig
powerpc                     stx_gp3_defconfig
m68k                          hp300_defconfig
arm                         at91_dt_defconfig
powerpc                      mgcoge_defconfig
m68k                          sun3x_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
powerpc                    klondike_defconfig
mips                malta_qemu_32r6_defconfig
arm                        mini2440_defconfig
arc                              alldefconfig
mips                     cu1830-neo_defconfig
sparc                            alldefconfig
arm                          lpd270_defconfig
arm                          simpad_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
sh                          r7785rp_defconfig
m68k                       m5275evb_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     akebono_defconfig
mips                     decstation_defconfig
arm                         mv78xx0_defconfig
arm                          ixp4xx_defconfig
ia64                      gensparse_defconfig
powerpc                         ps3_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                         lubbock_defconfig
arm                        magician_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                               alldefconfig
arm                         s3c6400_defconfig
arm                             mxs_defconfig
sparc                       sparc32_defconfig
arm                        multi_v5_defconfig
powerpc                      makalu_defconfig
mips                            ar7_defconfig
i386                                defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc8272_ads_defconfig
m68k                          atari_defconfig
arm                         s5pv210_defconfig
m68k                        mvme147_defconfig
powerpc                      pasemi_defconfig
mips                         db1xxx_defconfig
arm                           stm32_defconfig
powerpc                        icon_defconfig
powerpc                     mpc5200_defconfig
i386                             alldefconfig
powerpc                 mpc832x_rdb_defconfig
arm                        spear6xx_defconfig
sparc                       sparc64_defconfig
xtensa                generic_kc705_defconfig
sh                           se7751_defconfig
powerpc                 linkstation_defconfig
m68k                        m5407c3_defconfig
mips                           ip22_defconfig
arm                         shannon_defconfig
mips                        workpad_defconfig
m68k                        mvme16x_defconfig
arm                          badge4_defconfig
arm                        clps711x_defconfig
riscv                    nommu_virt_defconfig
arm                          iop32x_defconfig
xtensa                  audio_kc705_defconfig
powerpc                        cell_defconfig
sh                        sh7785lcr_defconfig
mips                           ip27_defconfig
powerpc                      obs600_defconfig
m68k                       bvme6000_defconfig
riscv                               defconfig
powerpc                 canyonlands_defconfig
arm                             pxa_defconfig
arm                          pxa910_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                         tb0219_defconfig
arm                      tct_hammer_defconfig
um                             i386_defconfig
arm                      integrator_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210815
i386                 randconfig-a001-20210815
i386                 randconfig-a002-20210815
i386                 randconfig-a003-20210815
i386                 randconfig-a006-20210815
i386                 randconfig-a005-20210815
x86_64               randconfig-a013-20210815
x86_64               randconfig-a011-20210815
x86_64               randconfig-a016-20210815
x86_64               randconfig-a012-20210815
x86_64               randconfig-a014-20210815
x86_64               randconfig-a015-20210815
i386                 randconfig-a011-20210815
i386                 randconfig-a015-20210815
i386                 randconfig-a014-20210815
i386                 randconfig-a013-20210815
i386                 randconfig-a016-20210815
i386                 randconfig-a012-20210815
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210815
x86_64               randconfig-a004-20210815
x86_64               randconfig-a006-20210815
x86_64               randconfig-a003-20210815
x86_64               randconfig-a001-20210815
x86_64               randconfig-a002-20210815
x86_64               randconfig-a005-20210815
x86_64               randconfig-a011-20210816
x86_64               randconfig-a013-20210816
x86_64               randconfig-a016-20210816
x86_64               randconfig-a012-20210816
x86_64               randconfig-a015-20210816
x86_64               randconfig-a014-20210816

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

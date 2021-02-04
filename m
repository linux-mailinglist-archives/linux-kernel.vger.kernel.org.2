Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644D130E87A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhBDA2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:28:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:34177 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233391AbhBDA23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:28:29 -0500
IronPort-SDR: ORKdyPwDiyjIZxKr1KVoaQeQo08DU3uF7PHmeQl0oRip7HUQgZAWtKB6Y8MjOeWe3MRqjgpV0K
 +hZV+i70bVdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="180370434"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="180370434"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 16:27:47 -0800
IronPort-SDR: Oll7Yyq4L0zLQQvWdIbClB4lxw2tcvqz3OYiCxC2HRgxP/PaBebdyAj4sqRCrnBD5+sex+nqwZ
 +yGd+UvHHhrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="396860673"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Feb 2021 16:27:44 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l7SUq-0000ZD-7y; Thu, 04 Feb 2021 00:27:44 +0000
Date:   Thu, 04 Feb 2021 08:27:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7f1b11ba3564a391169420d98162987a12d0795d
Message-ID: <601b3f76.rvnz1ygEUeKESiC7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 7f1b11ba3564a391169420d98162987a12d0795d  tools/power/turbostat: Fallback to an MSR read for EPB

elapsed time: 724m

configs tested: 212
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
s390                       zfcpdump_defconfig
mips                           ip28_defconfig
sh                           se7724_defconfig
c6x                                 defconfig
xtensa                              defconfig
arm                      jornada720_defconfig
c6x                        evmc6457_defconfig
powerpc                      mgcoge_defconfig
mips                        qi_lb60_defconfig
mips                        nlm_xlr_defconfig
powerpc                     kilauea_defconfig
mips                           ip27_defconfig
powerpc                     powernv_defconfig
arm                        mvebu_v7_defconfig
alpha                               defconfig
ia64                         bigsur_defconfig
mips                            gpr_defconfig
arm                         cm_x300_defconfig
sh                          urquell_defconfig
arm                        spear6xx_defconfig
sh                ecovec24-romimage_defconfig
c6x                        evmc6472_defconfig
powerpc                       ebony_defconfig
m68k                             allmodconfig
arm                       multi_v4t_defconfig
sh                              ul2_defconfig
riscv                             allnoconfig
sh                          rsk7203_defconfig
powerpc                    socrates_defconfig
arm                         mv78xx0_defconfig
powerpc                     stx_gp3_defconfig
powerpc                        icon_defconfig
powerpc                  mpc866_ads_defconfig
sh                           se7751_defconfig
sh                            migor_defconfig
sh                          polaris_defconfig
ia64                          tiger_defconfig
mips                       lemote2f_defconfig
arm                        oxnas_v6_defconfig
mips                        nlm_xlp_defconfig
openrisc                            defconfig
mips                      bmips_stb_defconfig
arc                           tb10x_defconfig
sh                          landisk_defconfig
m68k                            q40_defconfig
arc                    vdk_hs38_smp_defconfig
c6x                        evmc6474_defconfig
powerpc                      makalu_defconfig
powerpc                      ppc44x_defconfig
openrisc                  or1klitex_defconfig
powerpc                    klondike_defconfig
arm                          pcm027_defconfig
powerpc64                        alldefconfig
arc                      axs103_smp_defconfig
arc                            hsdk_defconfig
arc                        nsim_700_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                       m5208evb_defconfig
powerpc                        warp_defconfig
xtensa                  audio_kc705_defconfig
sh                     magicpanelr2_defconfig
powerpc                 mpc836x_rdk_defconfig
nios2                               defconfig
h8300                     edosk2674_defconfig
sh                          rsk7201_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                          g5_defconfig
arm                        cerfcube_defconfig
arm                       omap2plus_defconfig
powerpc                       holly_defconfig
mips                       rbtx49xx_defconfig
mips                           ip32_defconfig
mips                      maltasmvp_defconfig
nds32                             allnoconfig
sh                          sdk7780_defconfig
sh                         microdev_defconfig
arm                          pxa168_defconfig
arc                          axs103_defconfig
sh                             espt_defconfig
arm                           stm32_defconfig
powerpc                     tqm8555_defconfig
c6x                              alldefconfig
microblaze                      mmu_defconfig
arm                            zeus_defconfig
arm                         at91_dt_defconfig
powerpc                      pmac32_defconfig
s390                          debug_defconfig
mips                         bigsur_defconfig
arm                          lpd270_defconfig
c6x                              allyesconfig
arm                       netwinder_defconfig
xtensa                          iss_defconfig
arm                         orion5x_defconfig
arm                          collie_defconfig
arm                         axm55xx_defconfig
nios2                         3c120_defconfig
mips                      fuloong2e_defconfig
arm                             mxs_defconfig
arm                      footbridge_defconfig
xtensa                         virt_defconfig
xtensa                generic_kc705_defconfig
powerpc                      pcm030_defconfig
arm                      tct_hammer_defconfig
mips                           ip22_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210202
i386                 randconfig-a005-20210202
i386                 randconfig-a003-20210202
i386                 randconfig-a006-20210202
i386                 randconfig-a002-20210202
i386                 randconfig-a004-20210202
i386                 randconfig-a001-20210203
i386                 randconfig-a005-20210203
i386                 randconfig-a003-20210203
i386                 randconfig-a006-20210203
i386                 randconfig-a002-20210203
i386                 randconfig-a004-20210203
i386                 randconfig-a001-20210204
i386                 randconfig-a005-20210204
i386                 randconfig-a003-20210204
i386                 randconfig-a006-20210204
i386                 randconfig-a002-20210204
i386                 randconfig-a004-20210204
x86_64               randconfig-a013-20210202
x86_64               randconfig-a014-20210202
x86_64               randconfig-a015-20210202
x86_64               randconfig-a016-20210202
x86_64               randconfig-a011-20210202
x86_64               randconfig-a012-20210202
i386                 randconfig-a013-20210202
i386                 randconfig-a016-20210202
i386                 randconfig-a014-20210202
i386                 randconfig-a012-20210202
i386                 randconfig-a015-20210202
i386                 randconfig-a011-20210202
i386                 randconfig-a013-20210203
i386                 randconfig-a016-20210203
i386                 randconfig-a014-20210203
i386                 randconfig-a012-20210203
i386                 randconfig-a015-20210203
i386                 randconfig-a011-20210203
x86_64               randconfig-a006-20210203
x86_64               randconfig-a001-20210203
x86_64               randconfig-a005-20210203
x86_64               randconfig-a002-20210203
x86_64               randconfig-a004-20210203
x86_64               randconfig-a003-20210203
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210204
x86_64               randconfig-a001-20210204
x86_64               randconfig-a005-20210204
x86_64               randconfig-a002-20210204
x86_64               randconfig-a004-20210204
x86_64               randconfig-a003-20210204
x86_64               randconfig-a006-20210202
x86_64               randconfig-a001-20210202
x86_64               randconfig-a005-20210202
x86_64               randconfig-a002-20210202
x86_64               randconfig-a004-20210202
x86_64               randconfig-a003-20210202
x86_64               randconfig-a013-20210203
x86_64               randconfig-a014-20210203
x86_64               randconfig-a015-20210203
x86_64               randconfig-a016-20210203
x86_64               randconfig-a011-20210203
x86_64               randconfig-a012-20210203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931DB34E0F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhC3F7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:59:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:40649 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhC3F7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:59:17 -0400
IronPort-SDR: Cd44C8hkHbIo2VaTLUwlupHrpef/i86GUz/yXlsLLaE1RiFYJmSGBKyoXvcLPjU9e8+6ABSLPr
 7+wjTDbwT7JQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191794004"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="191794004"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 22:59:16 -0700
IronPort-SDR: 9cB8lwmdUUZf8KkR4efb6mhY6FmHVx0YAk9j/kt5HCLJDsWz0ixi+Et+gzEPNSe/na76odf8us
 1CiPV3HFYtEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="415695385"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2021 22:59:15 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lR7PG-00055X-En; Tue, 30 Mar 2021 05:59:14 +0000
Date:   Tue, 30 Mar 2021 13:58:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 d4c7c28806616809e3baa0b7cd8c665516b2726d
Message-ID: <6062bdf3.+qW91E6qryHvGT3D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: d4c7c28806616809e3baa0b7cd8c665516b2726d  timekeeping: Allow runtime PM from change_clocksource()

elapsed time: 902m

configs tested: 167
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
arm64                            alldefconfig
xtensa                              defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                            hsdk_defconfig
sh                            hp6xx_defconfig
powerpc                      makalu_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       versatile_defconfig
arm                         mv78xx0_defconfig
powerpc                    sam440ep_defconfig
powerpc                  storcenter_defconfig
parisc                           allyesconfig
arm                          simpad_defconfig
m68k                        stmark2_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        mvme16x_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      ppc40x_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc834x_itx_defconfig
mips                         tb0219_defconfig
mips                            ar7_defconfig
arm                     am200epdkit_defconfig
arm                          pxa910_defconfig
arm                          collie_defconfig
m68k                       m5475evb_defconfig
sparc                            allyesconfig
sh                ecovec24-romimage_defconfig
arm                        vexpress_defconfig
sh                         ecovec24_defconfig
arm                         lpc18xx_defconfig
powerpc                     rainier_defconfig
um                                  defconfig
powerpc                   motionpro_defconfig
mips                           gcw0_defconfig
arm                          gemini_defconfig
powerpc                     ppa8548_defconfig
mips                         cobalt_defconfig
arm                      tct_hammer_defconfig
powerpc                       holly_defconfig
m68k                            mac_defconfig
powerpc64                        alldefconfig
mips                       lemote2f_defconfig
arm                         hackkit_defconfig
m68k                             alldefconfig
parisc                generic-64bit_defconfig
riscv                    nommu_virt_defconfig
alpha                               defconfig
xtensa                  cadence_csp_defconfig
arm                  colibri_pxa300_defconfig
powerpc                 mpc85xx_cds_defconfig
arc                          axs101_defconfig
powerpc                      chrp32_defconfig
mips                           xway_defconfig
arm                      pxa255-idp_defconfig
powerpc                 canyonlands_defconfig
sh                           se7724_defconfig
m68k                        m5407c3_defconfig
arm                          pcm027_defconfig
mips                           rs90_defconfig
sh                        dreamcast_defconfig
arm                          pxa3xx_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          kfr2r09_defconfig
arm                        neponset_defconfig
powerpc                     mpc5200_defconfig
powerpc                  mpc885_ads_defconfig
mips                     loongson1b_defconfig
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
arm                         assabet_defconfig
sh                               alldefconfig
arm                         s3c6400_defconfig
xtensa                       common_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                         ps3_defconfig
arm                       mainstone_defconfig
arm                           omap1_defconfig
mips                      pic32mzda_defconfig
mips                        jmr3927_defconfig
m68k                       m5275evb_defconfig
mips                        nlm_xlp_defconfig
sh                           se7206_defconfig
mips                     cu1830-neo_defconfig
nios2                         10m50_defconfig
sh                            shmin_defconfig
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
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210329
x86_64               randconfig-a003-20210329
x86_64               randconfig-a006-20210329
x86_64               randconfig-a001-20210329
x86_64               randconfig-a005-20210329
x86_64               randconfig-a004-20210329
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
i386                 randconfig-a001-20210329
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a014-20210329
i386                 randconfig-a011-20210329
i386                 randconfig-a015-20210329
i386                 randconfig-a016-20210329
i386                 randconfig-a013-20210329
i386                 randconfig-a012-20210329
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210329
x86_64               randconfig-a012-20210329
x86_64               randconfig-a013-20210329
x86_64               randconfig-a014-20210329
x86_64               randconfig-a011-20210329
x86_64               randconfig-a016-20210329

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

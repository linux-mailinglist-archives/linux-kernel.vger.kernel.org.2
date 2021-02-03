Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE8230D485
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhBCIAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:00:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:49659 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231738AbhBCIAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:00:50 -0500
IronPort-SDR: L1e6FdDJO5Hyb/1JlbN/wUTDSa9Q9uv+CEc1xk9HpWnStfBlZoPktalRK9lLAeGL2u/7tqyHfC
 hHILQbm0m/1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="245079208"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="245079208"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 00:00:07 -0800
IronPort-SDR: qkAfBktwlV6HRCGXXObtgSdX9Px3Xaj4rgzT4r/ulgDQGiNcplPtMRchfOv33PbHeQrGpaqlop
 U0qT2I80lZDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="356642309"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Feb 2021 00:00:04 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l7D52-0000AC-Ai; Wed, 03 Feb 2021 08:00:04 +0000
Date:   Wed, 03 Feb 2021 15:59:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 ebb22a05943666155e6da04407cc6e913974c78c
Message-ID: <601a57d3.aYV2BoYgRCOC2ToU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: ebb22a05943666155e6da04407cc6e913974c78c  rtc: mc146818: Dont test for bit 0-5 in Register D

elapsed time: 728m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
h8300                     edosk2674_defconfig
arm                          ep93xx_defconfig
h8300                               defconfig
arm                           viper_defconfig
powerpc                     mpc5200_defconfig
arm                             pxa_defconfig
powerpc                      acadia_defconfig
m68k                        m5272c3_defconfig
arm                        neponset_defconfig
powerpc                      tqm8xx_defconfig
m68k                        m5407c3_defconfig
arm                         lubbock_defconfig
arm                            dove_defconfig
mips                        vocore2_defconfig
mips                     loongson1c_defconfig
mips                          malta_defconfig
sh                        apsh4ad0a_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
mips                        qi_lb60_defconfig
arm                          collie_defconfig
arm                         cm_x300_defconfig
sh                           se7206_defconfig
powerpc                     pq2fads_defconfig
mips                             allyesconfig
arm                      integrator_defconfig
mips                        bcm63xx_defconfig
sh                          landisk_defconfig
m68k                            q40_defconfig
arc                    vdk_hs38_smp_defconfig
arc                           tb10x_defconfig
c6x                        evmc6474_defconfig
openrisc                  or1klitex_defconfig
arm                          pcm027_defconfig
sh                         ap325rxa_defconfig
arc                         haps_hs_defconfig
powerpc                      katmai_defconfig
arm                           h5000_defconfig
powerpc                     tqm8560_defconfig
arm                        multi_v7_defconfig
powerpc                       holly_defconfig
mips                       rbtx49xx_defconfig
mips                           ip32_defconfig
mips                      maltasmvp_defconfig
sh                             espt_defconfig
arm                           stm32_defconfig
powerpc                     tqm8555_defconfig
c6x                        evmc6472_defconfig
c6x                              alldefconfig
microblaze                      mmu_defconfig
m68k                       m5208evb_defconfig
powerpc                    klondike_defconfig
arm                        realview_defconfig
m68k                        mvme147_defconfig
powerpc64                        alldefconfig
mips                      bmips_stb_defconfig
powerpc                      cm5200_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     skiroot_defconfig
microblaze                          defconfig
powerpc                          allyesconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                        fsp2_defconfig
arm                        keystone_defconfig
powerpc                      ppc40x_defconfig
sh                            migor_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210202
i386                 randconfig-a005-20210202
i386                 randconfig-a003-20210202
i386                 randconfig-a006-20210202
i386                 randconfig-a002-20210202
i386                 randconfig-a004-20210202
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
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
x86_64               randconfig-a006-20210202
x86_64               randconfig-a001-20210202
x86_64               randconfig-a005-20210202
x86_64               randconfig-a002-20210202
x86_64               randconfig-a004-20210202
x86_64               randconfig-a003-20210202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

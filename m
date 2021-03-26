Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB08234A0B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 05:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhCZExt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 00:53:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:2921 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhCZExf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 00:53:35 -0400
IronPort-SDR: YViMqqaFEbyojj1L7QU+eFyKNNPU+Js1zwylE5MTRmwxoRtO5pDs+TDkBm5p7CDWYRx89ztS0Y
 HHDp8K1RBz6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="276210447"
X-IronPort-AV: E=Sophos;i="5.81,279,1610438400"; 
   d="scan'208";a="276210447"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 21:53:35 -0700
IronPort-SDR: nbxNCru7Vw67sz8Av1enCtQZZVME1SQ42tEJN/n8+Jdtt1XNmdsozEdhu9Vr/bRD/KE+w+MaIT
 w+rBFs5HniyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,279,1610438400"; 
   d="scan'208";a="443672659"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2021 21:53:34 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPeTV-0002WJ-E1; Fri, 26 Mar 2021 04:53:33 +0000
Date:   Fri, 26 Mar 2021 12:53:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 1a0dfc099c1e61e22045705265a1323ac294bea6
Message-ID: <605d68b1.7SNHzYhtJhn5gi7X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 1a0dfc099c1e61e22045705265a1323ac294bea6  rcu-tasks: Make ksoftirqd provide RCU Tasks quiescent states

elapsed time: 725m

configs tested: 154
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
mips                           ip28_defconfig
powerpc                   lite5200b_defconfig
arm                         s5pv210_defconfig
powerpc                   currituck_defconfig
h8300                            alldefconfig
powerpc                     ksi8560_defconfig
powerpc                       maple_defconfig
powerpc                      obs600_defconfig
sparc64                             defconfig
arm                         assabet_defconfig
xtensa                              defconfig
sh                         ecovec24_defconfig
sh                               alldefconfig
m68k                       m5475evb_defconfig
sh                   secureedge5410_defconfig
arm                        cerfcube_defconfig
powerpc                     mpc5200_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7264_defconfig
csky                                defconfig
sh                     sh7710voipgw_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           gcw0_defconfig
arc                         haps_hs_defconfig
um                             i386_defconfig
arm                          badge4_defconfig
sh                           se7780_defconfig
powerpc                       ppc64_defconfig
arm                           spitz_defconfig
arm                        keystone_defconfig
arm                          lpd270_defconfig
mips                      maltaaprp_defconfig
arm                        spear3xx_defconfig
arm                       imx_v6_v7_defconfig
mips                     loongson1c_defconfig
powerpc                     sequoia_defconfig
powerpc                      katmai_defconfig
arm                        multi_v7_defconfig
powerpc                   motionpro_defconfig
arm                         lpc18xx_defconfig
mips                     decstation_defconfig
sh                             espt_defconfig
mips                        bcm63xx_defconfig
m68k                                defconfig
mips                  cavium_octeon_defconfig
m68k                           sun3_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     tqm5200_defconfig
powerpc                 linkstation_defconfig
powerpc64                           defconfig
mips                          malta_defconfig
csky                             alldefconfig
nds32                            alldefconfig
riscv                    nommu_k210_defconfig
powerpc                      ep88xc_defconfig
xtensa                    xip_kc705_defconfig
mips                        omega2p_defconfig
sh                     magicpanelr2_defconfig
arm                          pcm027_defconfig
powerpc                     stx_gp3_defconfig
mips                           ip22_defconfig
m68k                          amiga_defconfig
arc                            hsdk_defconfig
arm                          imote2_defconfig
sh                           se7712_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        multi_v5_defconfig
mips                         cobalt_defconfig
powerpc                        icon_defconfig
nios2                               defconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
m68k                            mac_defconfig
powerpc                     tqm8548_defconfig
sh                          polaris_defconfig
mips                        qi_lb60_defconfig
mips                       lemote2f_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210325
x86_64               randconfig-a003-20210325
x86_64               randconfig-a006-20210325
x86_64               randconfig-a001-20210325
x86_64               randconfig-a005-20210325
x86_64               randconfig-a004-20210325
i386                 randconfig-a003-20210325
i386                 randconfig-a004-20210325
i386                 randconfig-a001-20210325
i386                 randconfig-a002-20210325
i386                 randconfig-a006-20210325
i386                 randconfig-a005-20210325
i386                 randconfig-a014-20210325
i386                 randconfig-a011-20210325
i386                 randconfig-a015-20210325
i386                 randconfig-a016-20210325
i386                 randconfig-a013-20210325
i386                 randconfig-a012-20210325
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-a012-20210325
x86_64               randconfig-a015-20210325
x86_64               randconfig-a014-20210325
x86_64               randconfig-a013-20210325
x86_64               randconfig-a011-20210325
x86_64               randconfig-a016-20210325

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

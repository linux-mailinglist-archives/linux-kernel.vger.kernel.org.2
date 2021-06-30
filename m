Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB5B3B7E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhF3HeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:34:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:52915 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233112AbhF3Hdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:33:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="195458616"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="195458616"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 00:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="457113942"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2021 00:31:18 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyUgn-0009dt-Hw; Wed, 30 Jun 2021 07:31:17 +0000
Date:   Wed, 30 Jun 2021 15:30:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.06.25a] BUILD SUCCESS
 48434fc6700c31bd258713c24b78053fe47d393e
Message-ID: <60dc1da2.2F+bIPtfwGwvUAkN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.06.25a
branch HEAD: 48434fc6700c31bd258713c24b78053fe47d393e  rcu: Remove useless "ret" update in rcu_gp_fqs_loop()

elapsed time: 724m

configs tested: 152
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                           allyesconfig
arm                         at91_dt_defconfig
arm                       imx_v6_v7_defconfig
ia64                         bigsur_defconfig
powerpc                     mpc512x_defconfig
powerpc                     mpc5200_defconfig
sh                        edosk7760_defconfig
mips                            ar7_defconfig
sh                           se7712_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      pcm030_defconfig
arm                            qcom_defconfig
arm                           sama5_defconfig
sh                            titan_defconfig
mips                     loongson1c_defconfig
ia64                        generic_defconfig
arm                         hackkit_defconfig
m68k                        m5307c3_defconfig
powerpc                      mgcoge_defconfig
powerpc                     skiroot_defconfig
arm                      integrator_defconfig
powerpc                      chrp32_defconfig
arm                            mmp2_defconfig
arm                         palmz72_defconfig
powerpc                     stx_gp3_defconfig
powerpc                  mpc885_ads_defconfig
arm                            zeus_defconfig
riscv                    nommu_k210_defconfig
arc                         haps_hs_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8540_defconfig
mips                           gcw0_defconfig
powerpc                    amigaone_defconfig
arm                            lart_defconfig
riscv                    nommu_virt_defconfig
sh                         apsh4a3a_defconfig
csky                                defconfig
powerpc                   currituck_defconfig
nios2                               defconfig
mips                  cavium_octeon_defconfig
arm                       mainstone_defconfig
powerpc                     rainier_defconfig
arm                          pcm027_defconfig
arc                          axs101_defconfig
sh                          sdk7786_defconfig
powerpc                       maple_defconfig
powerpc                      ep88xc_defconfig
arc                     haps_hs_smp_defconfig
m68k                       bvme6000_defconfig
xtensa                              defconfig
powerpc                     powernv_defconfig
sh                           se7751_defconfig
mips                        qi_lb60_defconfig
powerpc                     pseries_defconfig
powerpc                       eiger_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                  nommu_kc705_defconfig
mips                        workpad_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc8560_ads_defconfig
sparc                       sparc32_defconfig
mips                           ci20_defconfig
sh                           se7780_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
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
i386                 randconfig-a001-20210628
i386                 randconfig-a002-20210628
i386                 randconfig-a003-20210628
i386                 randconfig-a006-20210628
i386                 randconfig-a005-20210628
i386                 randconfig-a004-20210628
i386                 randconfig-a002-20210629
i386                 randconfig-a001-20210629
i386                 randconfig-a003-20210629
i386                 randconfig-a006-20210629
i386                 randconfig-a005-20210629
i386                 randconfig-a004-20210629
x86_64               randconfig-a012-20210628
x86_64               randconfig-a016-20210628
x86_64               randconfig-a015-20210628
x86_64               randconfig-a013-20210628
x86_64               randconfig-a014-20210628
x86_64               randconfig-a011-20210628
i386                 randconfig-a011-20210628
i386                 randconfig-a014-20210628
i386                 randconfig-a013-20210628
i386                 randconfig-a015-20210628
i386                 randconfig-a016-20210628
i386                 randconfig-a012-20210628
x86_64               randconfig-a002-20210629
x86_64               randconfig-a005-20210629
x86_64               randconfig-a001-20210629
x86_64               randconfig-a003-20210629
x86_64               randconfig-a004-20210629
x86_64               randconfig-a006-20210629
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210628
x86_64               randconfig-a002-20210628
x86_64               randconfig-a005-20210628
x86_64               randconfig-a001-20210628
x86_64               randconfig-a003-20210628
x86_64               randconfig-a004-20210628
x86_64               randconfig-a006-20210628

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

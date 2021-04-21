Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182CE366542
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 08:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhDUGQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 02:16:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:45128 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhDUGQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 02:16:12 -0400
IronPort-SDR: qSsCaWvwuaGVVmN7tUfjjz1kX3LnWQ/22LxTidDYcmF+hs1XUdabrqINTETAXhsHJ9R8Yjbf4a
 zuudKx+prLuA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195759952"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="195759952"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 23:15:38 -0700
IronPort-SDR: dpqKJ+krBNo6ABAtxA489DqSqUU/TSBf3vo59IZdr0WiqjcRrctAbmpOSxVN5FArM4A6XZzFaZ
 w/vPH2mkU8PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="445835633"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2021 23:15:36 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZ69A-0003Si-88; Wed, 21 Apr 2021 06:15:36 +0000
Date:   Wed, 21 Apr 2021 14:14:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.04.19a] BUILD SUCCESS
 429f7c8f275519c2c00b8e161e250f807ef608a9
Message-ID: <607fc2e2.0S2cfHIQ+dz/DAyJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.19a
branch HEAD: 429f7c8f275519c2c00b8e161e250f807ef608a9  EXP torture: Add longsleep rcutorture scenarios

elapsed time: 721m

configs tested: 159
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
sh                           se7705_defconfig
powerpc                     tqm8541_defconfig
m68k                        m5307c3_defconfig
powerpc                     rainier_defconfig
powerpc                  storcenter_defconfig
mips                          ath79_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
mips                     decstation_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
arc                     haps_hs_smp_defconfig
m68k                            q40_defconfig
arm                      pxa255-idp_defconfig
h8300                            alldefconfig
ia64                      gensparse_defconfig
arm                         cm_x300_defconfig
m68k                          hp300_defconfig
sh                           se7722_defconfig
m68k                             alldefconfig
arm                         lubbock_defconfig
sh                   rts7751r2dplus_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                       maple_defconfig
powerpc                          allyesconfig
ia64                            zx1_defconfig
mips                      maltaaprp_defconfig
nds32                               defconfig
powerpc                     tqm8555_defconfig
powerpc                 mpc834x_mds_defconfig
mips                           ip27_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                             allyesconfig
mips                           rs90_defconfig
sh                            shmin_defconfig
sh                          polaris_defconfig
xtensa                       common_defconfig
mips                  decstation_64_defconfig
sh                           se7619_defconfig
powerpc                 mpc85xx_cds_defconfig
sparc                       sparc64_defconfig
mips                        nlm_xlr_defconfig
powerpc                        cell_defconfig
h8300                       h8s-sim_defconfig
arm                     davinci_all_defconfig
mips                          malta_defconfig
mips                        bcm47xx_defconfig
arm                           viper_defconfig
ia64                             alldefconfig
mips                      fuloong2e_defconfig
powerpc                 linkstation_defconfig
mips                      pic32mzda_defconfig
arm                         nhk8815_defconfig
mips                         tb0287_defconfig
sh                          rsk7203_defconfig
sh                          landisk_defconfig
powerpc                       eiger_defconfig
arm                       omap2plus_defconfig
powerpc                   bluestone_defconfig
arm                          ep93xx_defconfig
arm                      integrator_defconfig
xtensa                  cadence_csp_defconfig
mips                         rt305x_defconfig
powerpc                      obs600_defconfig
arm                        spear6xx_defconfig
nios2                            allyesconfig
arm                        keystone_defconfig
sh                              ul2_defconfig
powerpc                      tqm8xx_defconfig
sh                         microdev_defconfig
arm                           spitz_defconfig
m68k                       m5475evb_defconfig
arm                            lart_defconfig
powerpc                 canyonlands_defconfig
powerpc                        icon_defconfig
m68k                        m5407c3_defconfig
um                               allyesconfig
arm                       multi_v4t_defconfig
sh                             shx3_defconfig
mips                        bcm63xx_defconfig
arm                         lpc18xx_defconfig
sh                             sh03_defconfig
mips                     cu1000-neo_defconfig
powerpc                      arches_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210420
i386                 randconfig-a002-20210420
i386                 randconfig-a001-20210420
i386                 randconfig-a006-20210420
i386                 randconfig-a004-20210420
i386                 randconfig-a003-20210420
x86_64               randconfig-a015-20210420
x86_64               randconfig-a016-20210420
x86_64               randconfig-a011-20210420
x86_64               randconfig-a014-20210420
x86_64               randconfig-a013-20210420
x86_64               randconfig-a012-20210420
i386                 randconfig-a012-20210420
i386                 randconfig-a014-20210420
i386                 randconfig-a011-20210420
i386                 randconfig-a013-20210420
i386                 randconfig-a015-20210420
i386                 randconfig-a016-20210420
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210420
x86_64               randconfig-a002-20210420
x86_64               randconfig-a001-20210420
x86_64               randconfig-a005-20210420
x86_64               randconfig-a006-20210420
x86_64               randconfig-a003-20210420

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

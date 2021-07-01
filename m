Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F243B8D9E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhGAGID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:08:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:62893 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbhGAGIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:08:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="294113632"
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="294113632"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 23:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="644336637"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2021 23:05:26 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyppF-000AKq-Lu; Thu, 01 Jul 2021 06:05:25 +0000
Date:   Thu, 01 Jul 2021 14:04:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.06.29a] BUILD SUCCESS
 24c95d1af15e700c498d51057e2768b8af4f98e2
Message-ID: <60dd5aef.wpH4WxhTo/Dt9RCa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.06.29a
branch HEAD: 24c95d1af15e700c498d51057e2768b8af4f98e2  rcu: Remove useless "ret" update in rcu_gp_fqs_loop()

elapsed time: 724m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
arm                         s5pv210_defconfig
m68k                        m5272c3_defconfig
ia64                             alldefconfig
sh                           se7722_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      mgcoge_defconfig
powerpc                     asp8347_defconfig
arm                         nhk8815_defconfig
arm                         hackkit_defconfig
powerpc                   bluestone_defconfig
mips                       capcella_defconfig
arm                      pxa255-idp_defconfig
sh                        edosk7705_defconfig
powerpc                     pseries_defconfig
mips                       bmips_be_defconfig
powerpc                   currituck_defconfig
mips                          ath25_defconfig
powerpc                      obs600_defconfig
mips                           xway_defconfig
m68k                        mvme147_defconfig
mips                       lemote2f_defconfig
sh                          sdk7780_defconfig
mips                          rm200_defconfig
s390                             allyesconfig
mips                        omega2p_defconfig
mips                  decstation_64_defconfig
arc                        nsimosci_defconfig
sh                          kfr2r09_defconfig
powerpc64                           defconfig
m68k                          sun3x_defconfig
powerpc                     ksi8560_defconfig
xtensa                  nommu_kc705_defconfig
sh                      rts7751r2d1_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                       eiger_defconfig
sh                         ecovec24_defconfig
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
x86_64               randconfig-a002-20210630
x86_64               randconfig-a001-20210630
x86_64               randconfig-a004-20210630
x86_64               randconfig-a005-20210630
x86_64               randconfig-a006-20210630
x86_64               randconfig-a003-20210630
i386                 randconfig-a004-20210630
i386                 randconfig-a001-20210630
i386                 randconfig-a003-20210630
i386                 randconfig-a002-20210630
i386                 randconfig-a005-20210630
i386                 randconfig-a006-20210630
i386                 randconfig-a014-20210630
i386                 randconfig-a011-20210630
i386                 randconfig-a016-20210630
i386                 randconfig-a012-20210630
i386                 randconfig-a013-20210630
i386                 randconfig-a015-20210630
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210630
x86_64               randconfig-a012-20210630
x86_64               randconfig-a015-20210630
x86_64               randconfig-a016-20210630
x86_64               randconfig-a013-20210630
x86_64               randconfig-a011-20210630
x86_64               randconfig-a014-20210630

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93F736F4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 05:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhD3D5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 23:57:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:49416 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhD3D5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:57:11 -0400
IronPort-SDR: 9fqjZohXy6ulz6H3GIBlDOdFFnYp9JGTa1LJdNnaMkjDZewBOpKVFj17eVfUss5M3n6KnxL2fw
 PNFQh8kkkC9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="177344250"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="177344250"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 20:56:24 -0700
IronPort-SDR: d68n6hjdwGlH7B6PDGl3a18rvHBHy47BzdL+gkFvwEfBIwENKS7sQNbm36qwdMNB36sJNSZ5S+
 5sgy0aXYJk0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="605532170"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2021 20:56:22 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lcKGL-0007xp-VD; Fri, 30 Apr 2021 03:56:21 +0000
Date:   Fri, 30 Apr 2021 11:55:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:clocksource] BUILD SUCCESS
 4fe46427c9e41b5be0c3d210f81510a84c5c54c8
Message-ID: <608b7fb8.VEv6peiLel5AA9ZW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git clocksource
branch HEAD: 4fe46427c9e41b5be0c3d210f81510a84c5c54c8  fixup! clocksource: Reduce clocksource-skew threshold for TSC

elapsed time: 720m

configs tested: 125
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
i386                             allyesconfig
riscv                            allyesconfig
nds32                             allnoconfig
arm                           h3600_defconfig
mips                         db1xxx_defconfig
arm                      integrator_defconfig
powerpc                         ps3_defconfig
powerpc                      pmac32_defconfig
m68k                       m5249evb_defconfig
arm64                            alldefconfig
um                             i386_defconfig
arc                        nsimosci_defconfig
arm                         socfpga_defconfig
sh                         microdev_defconfig
m68k                       bvme6000_defconfig
arm                           tegra_defconfig
powerpc                        icon_defconfig
i386                             alldefconfig
csky                                defconfig
arm                          simpad_defconfig
m68k                        m5307c3_defconfig
arm                           sunxi_defconfig
sh                          rsk7201_defconfig
nios2                            allyesconfig
sh                        sh7763rdp_defconfig
arm                        neponset_defconfig
mips                          rb532_defconfig
mips                       bmips_be_defconfig
sparc                       sparc32_defconfig
arc                    vdk_hs38_smp_defconfig
x86_64                           alldefconfig
sh                             shx3_defconfig
mips                        vocore2_defconfig
m68k                            q40_defconfig
arc                              alldefconfig
m68k                        m5272c3_defconfig
openrisc                 simple_smp_defconfig
powerpc                     ppa8548_defconfig
arc                          axs103_defconfig
powerpc                    ge_imp3a_defconfig
sh                            titan_defconfig
arm                        keystone_defconfig
mips                           gcw0_defconfig
sh                          kfr2r09_defconfig
ia64                             allyesconfig
arm                          pxa168_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc8272_ads_defconfig
sh                        edosk7760_defconfig
sh                   sh7770_generic_defconfig
sh                            hp6xx_defconfig
arm                          lpd270_defconfig
openrisc                    or1ksim_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210429
x86_64               randconfig-a002-20210429
x86_64               randconfig-a005-20210429
x86_64               randconfig-a006-20210429
x86_64               randconfig-a001-20210429
x86_64               randconfig-a003-20210429
i386                 randconfig-a005-20210429
i386                 randconfig-a002-20210429
i386                 randconfig-a001-20210429
i386                 randconfig-a006-20210429
i386                 randconfig-a003-20210429
i386                 randconfig-a004-20210429
i386                 randconfig-a012-20210429
i386                 randconfig-a014-20210429
i386                 randconfig-a013-20210429
i386                 randconfig-a011-20210429
i386                 randconfig-a015-20210429
i386                 randconfig-a016-20210429
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
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
x86_64               randconfig-a015-20210429
x86_64               randconfig-a016-20210429
x86_64               randconfig-a011-20210429
x86_64               randconfig-a014-20210429
x86_64               randconfig-a013-20210429
x86_64               randconfig-a012-20210429

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D0632FE5F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 02:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCGBoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 20:44:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:24825 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhCGBno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 20:43:44 -0500
IronPort-SDR: XOH147QHvXSO3LvhOwXWq4Nsi3GUh19Qoqv7Un7kc5yvyZKhTfhmgAEu/nG3qrNcvrZsypBSC3
 CKn2bZT/m5yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9915"; a="187959423"
X-IronPort-AV: E=Sophos;i="5.81,229,1610438400"; 
   d="scan'208";a="187959423"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2021 17:43:43 -0800
IronPort-SDR: DgF5Ts55kmqSmBuM4VE7x5OQz8KohYNtLL7IS8GyPqFV9QWLEVWMKrv9p1eQ1AltBUWVMllalu
 21RjkqEI6Qyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,229,1610438400"; 
   d="scan'208";a="429911422"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2021 17:43:42 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lIiSL-000046-GD; Sun, 07 Mar 2021 01:43:41 +0000
Date:   Sun, 07 Mar 2021 09:43:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.03.03b] BUILD SUCCESS
 b4838c004a52080e221bc224d6425a5a8eba238d
Message-ID: <60442fa8.wBSEORQszJ26MEQS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.03.03b
branch HEAD: b4838c004a52080e221bc224d6425a5a8eba238d  net: phy: make mdio_bus_phy_suspend/resume as __maybe_unused

elapsed time: 3149m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        spear6xx_defconfig
powerpc                      arches_defconfig
powerpc                     pseries_defconfig
xtensa                          iss_defconfig
sh                              ul2_defconfig
microblaze                      mmu_defconfig
nds32                            alldefconfig
sh                           se7705_defconfig
mips                        maltaup_defconfig
arm                      pxa255-idp_defconfig
arm                          pxa168_defconfig
powerpc                     pq2fads_defconfig
arm                           h3600_defconfig
arm                        cerfcube_defconfig
sh                            shmin_defconfig
arm                         cm_x300_defconfig
mips                         db1xxx_defconfig
sh                        edosk7760_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm8540_defconfig
arm                          pxa3xx_defconfig
arm                        shmobile_defconfig
m68k                          atari_defconfig
arm                            mmp2_defconfig
powerpc                 mpc836x_mds_defconfig
mips                         rt305x_defconfig
sh                   secureedge5410_defconfig
powerpc                      ppc6xx_defconfig
arm                          iop32x_defconfig
powerpc                     ksi8560_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
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
x86_64               randconfig-a006-20210304
x86_64               randconfig-a001-20210304
x86_64               randconfig-a004-20210304
x86_64               randconfig-a005-20210304
x86_64               randconfig-a002-20210304
x86_64               randconfig-a003-20210304
i386                 randconfig-a005-20210304
i386                 randconfig-a003-20210304
i386                 randconfig-a002-20210304
i386                 randconfig-a004-20210304
i386                 randconfig-a006-20210304
i386                 randconfig-a001-20210304
i386                 randconfig-a016-20210304
i386                 randconfig-a012-20210304
i386                 randconfig-a013-20210304
i386                 randconfig-a014-20210304
i386                 randconfig-a015-20210304
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

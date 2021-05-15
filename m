Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513673814F2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhEOBhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:37:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:62774 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232532AbhEOBhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:37:39 -0400
IronPort-SDR: 0QxwWv9J7cwi8m5uE9IzAeW1QkDeCBKvOWPXeP+yUALT8T5aaO8hI/g3VPhDolN6K5jQCI6TXf
 D+ZGloNlMWiQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="200306176"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="200306176"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 18:36:27 -0700
IronPort-SDR: 7OKlwbjZ1GCQtGwnNEhRjnLA4iXXTic1AYXefCSMCYxgZ8Wv0FsvAZAf0t/cIyZ6+oIdW2Eg0q
 CnQn6Dgtl02A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="539199083"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 May 2021 18:36:25 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lhjE8-0000yA-Vn; Sat, 15 May 2021 01:36:24 +0000
Date:   Sat, 15 May 2021 09:35:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 3486d2c9be652a31033363bdd50391b0c8a8fe21
Message-ID: <609f2579.YTTYe2WyPUQaot7V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 3486d2c9be652a31033363bdd50391b0c8a8fe21  clocksource/drivers/hyper-v: Re-enable VDSO_CLOCKMODE_HVCLOCK on X86

elapsed time: 725m

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
mips                         tb0219_defconfig
ia64                          tiger_defconfig
powerpc                      acadia_defconfig
powerpc                 mpc836x_mds_defconfig
sh                                  defconfig
arc                              allyesconfig
powerpc                 mpc8313_rdb_defconfig
m68k                        mvme16x_defconfig
m68k                       m5249evb_defconfig
arc                          axs103_defconfig
mips                           mtx1_defconfig
arm                           stm32_defconfig
mips                           ip32_defconfig
arm                           sunxi_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                          rsk7264_defconfig
arm                         lpc32xx_defconfig
powerpc                 mpc834x_mds_defconfig
sh                         ecovec24_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ppc64_defconfig
arm                   milbeaut_m10v_defconfig
mips                          rb532_defconfig
arm                          ixp4xx_defconfig
um                                  defconfig
openrisc                         alldefconfig
m68k                       m5208evb_defconfig
m68k                        m5407c3_defconfig
powerpc                      arches_defconfig
arm                           omap1_defconfig
arm                         mv78xx0_defconfig
nios2                         3c120_defconfig
nios2                            alldefconfig
powerpc                        fsp2_defconfig
arm                        mvebu_v7_defconfig
h8300                               defconfig
openrisc                  or1klitex_defconfig
powerpc                    amigaone_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc832x_mds_defconfig
sh                           se7206_defconfig
mips                      pistachio_defconfig
arm                        oxnas_v6_defconfig
arm                      jornada720_defconfig
ia64                                defconfig
mips                          rm200_defconfig
powerpc                       eiger_defconfig
powerpc                     mpc5200_defconfig
parisc                generic-64bit_defconfig
arm                            mps2_defconfig
powerpc                      chrp32_defconfig
arm                      pxa255-idp_defconfig
sh                        edosk7705_defconfig
powerpc                     sequoia_defconfig
powerpc                      makalu_defconfig
powerpc                        icon_defconfig
powerpc                   currituck_defconfig
riscv                               defconfig
arm                       mainstone_defconfig
openrisc                            defconfig
arm                        mvebu_v5_defconfig
arc                           tb10x_defconfig
sparc64                          alldefconfig
openrisc                    or1ksim_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210514
x86_64               randconfig-a003-20210514
x86_64               randconfig-a001-20210514
x86_64               randconfig-a005-20210514
x86_64               randconfig-a002-20210514
x86_64               randconfig-a006-20210514
i386                 randconfig-a003-20210514
i386                 randconfig-a001-20210514
i386                 randconfig-a004-20210514
i386                 randconfig-a005-20210514
i386                 randconfig-a002-20210514
i386                 randconfig-a006-20210514
x86_64               randconfig-a012-20210515
x86_64               randconfig-a015-20210515
x86_64               randconfig-a011-20210515
x86_64               randconfig-a013-20210515
x86_64               randconfig-a016-20210515
x86_64               randconfig-a014-20210515
i386                 randconfig-a016-20210515
i386                 randconfig-a014-20210515
i386                 randconfig-a011-20210515
i386                 randconfig-a012-20210515
i386                 randconfig-a015-20210515
i386                 randconfig-a013-20210515
i386                 randconfig-a016-20210514
i386                 randconfig-a014-20210514
i386                 randconfig-a011-20210514
i386                 randconfig-a012-20210514
i386                 randconfig-a015-20210514
i386                 randconfig-a013-20210514
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210515
x86_64               randconfig-a003-20210515
x86_64               randconfig-a001-20210515
x86_64               randconfig-a005-20210515
x86_64               randconfig-a002-20210515
x86_64               randconfig-a006-20210515
x86_64               randconfig-a015-20210514
x86_64               randconfig-a012-20210514
x86_64               randconfig-a011-20210514
x86_64               randconfig-a013-20210514
x86_64               randconfig-a016-20210514
x86_64               randconfig-a014-20210514

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

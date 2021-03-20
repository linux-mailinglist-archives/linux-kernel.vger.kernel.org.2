Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679CD3429ED
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 03:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhCTCMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 22:12:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:33487 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhCTCLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 22:11:54 -0400
IronPort-SDR: UWUGn8uJF6IjmUYha9Oor4ldoMlXRvaa+KLaGgx15LQ/cSH+PiZT00bP8lmJd50pjE7fISOTs+
 bv6HbSvi59aA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="177130587"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="177130587"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 19:11:53 -0700
IronPort-SDR: B5XxM6zhwaoLqTLGf3jGinthCkinZd3BPbek8z3uSvcxtc6DxHCv9+/2t6HoWqWR8/HgHcFJQV
 OEdqQ7cZT+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="440294316"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2021 19:11:52 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lNR5j-0002Fi-CT; Sat, 20 Mar 2021 02:11:51 +0000
Date:   Sat, 20 Mar 2021 10:11:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 75e5f8b5058d581688be8098ca0c335780a6d8df
Message-ID: <605559e0.zjmDQtkTLeepEDbC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 75e5f8b5058d581688be8098ca0c335780a6d8df  Merge branch 'x86/seves'

elapsed time: 721m

configs tested: 136
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
powerpc                      walnut_defconfig
sh                             sh03_defconfig
sh                           se7343_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          rsk7203_defconfig
sh                          kfr2r09_defconfig
arc                            hsdk_defconfig
mips                       rbtx49xx_defconfig
powerpc                     stx_gp3_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                   bluestone_defconfig
arm                         at91_dt_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      pmac32_defconfig
powerpc                     skiroot_defconfig
arm                           sunxi_defconfig
arm                  colibri_pxa300_defconfig
arm                            qcom_defconfig
powerpc                     redwood_defconfig
nds32                             allnoconfig
powerpc                   lite5200b_defconfig
powerpc                 canyonlands_defconfig
ia64                             allmodconfig
m68k                            q40_defconfig
arm                   milbeaut_m10v_defconfig
arm                        neponset_defconfig
arm                        multi_v7_defconfig
sh                        edosk7705_defconfig
arm                    vt8500_v6_v7_defconfig
mips                         tb0287_defconfig
arm                           u8500_defconfig
arm                          imote2_defconfig
sh                      rts7751r2d1_defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
powerpc                     ksi8560_defconfig
powerpc                     taishan_defconfig
powerpc                        warp_defconfig
arm                        mvebu_v7_defconfig
xtensa                  audio_kc705_defconfig
m68k                        stmark2_defconfig
arm                       aspeed_g4_defconfig
powerpc                       maple_defconfig
arm                       mainstone_defconfig
sparc64                             defconfig
powerpc                      acadia_defconfig
sh                           se7750_defconfig
mips                     decstation_defconfig
mips                        qi_lb60_defconfig
sh                          landisk_defconfig
parisc                           alldefconfig
arc                      axs103_smp_defconfig
mips                          ath25_defconfig
powerpc                        cell_defconfig
powerpc                     tqm8560_defconfig
powerpc                     tqm5200_defconfig
parisc                              defconfig
powerpc                 linkstation_defconfig
s390                             allmodconfig
arm                       versatile_defconfig
arm                        clps711x_defconfig
powerpc               mpc834x_itxgp_defconfig
parisc                generic-64bit_defconfig
mips                        maltaup_defconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
x86_64               randconfig-a011-20210318
x86_64               randconfig-a016-20210318
x86_64               randconfig-a013-20210318
x86_64               randconfig-a015-20210318
x86_64               randconfig-a014-20210318
x86_64               randconfig-a012-20210318
i386                 randconfig-a013-20210318
i386                 randconfig-a016-20210318
i386                 randconfig-a011-20210318
i386                 randconfig-a014-20210318
i386                 randconfig-a015-20210318
i386                 randconfig-a012-20210318
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210318
x86_64               randconfig-a001-20210318
x86_64               randconfig-a005-20210318
x86_64               randconfig-a002-20210318
x86_64               randconfig-a003-20210318
x86_64               randconfig-a004-20210318

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

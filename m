Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DDF30828A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhA2Aj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:39:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:4467 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231485AbhA2Ai3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:38:29 -0500
IronPort-SDR: iKtfz7l0JslZ6ozzB2VlHvruH/CO7LL2SSBtAIZRXd3rssWnKacg8hJYgbW8kQCDZg6DcSFE7x
 gBAbbRgXCTDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="244426133"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="244426133"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 16:37:39 -0800
IronPort-SDR: +ZWFadapcl/NvqUp6onlCzGZ/gYfB0wPZKSaJmDotGAspX32nghcCPV1qSofLq0RY/D9GTTugx
 LQDx66evHYXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="370080887"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2021 16:37:38 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5Hn7-0003EL-L3; Fri, 29 Jan 2021 00:37:37 +0000
Date:   Fri, 29 Jan 2021 08:37:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 bf594bf400016a1ac58c753bcc0393a39c36f669
Message-ID: <601358b2.n6q4rYy7Vwh6FEAl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: bf594bf400016a1ac58c753bcc0393a39c36f669  locking/rtmutex: Add missing kernel-doc markup

elapsed time: 720m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          urquell_defconfig
nds32                             allnoconfig
arm                        keystone_defconfig
mips                         tb0226_defconfig
sh                            hp6xx_defconfig
powerpc                     tqm8560_defconfig
xtensa                           allyesconfig
mips                      pic32mzda_defconfig
powerpc                     pseries_defconfig
arm                          ep93xx_defconfig
openrisc                    or1ksim_defconfig
m68k                        m5407c3_defconfig
arm                  colibri_pxa270_defconfig
arm                       multi_v4t_defconfig
sh                        sh7785lcr_defconfig
arm                        oxnas_v6_defconfig
arm                       aspeed_g4_defconfig
c6x                        evmc6678_defconfig
mips                          malta_defconfig
arc                           tb10x_defconfig
sh                          sdk7780_defconfig
mips                      malta_kvm_defconfig
sh                   secureedge5410_defconfig
arc                              alldefconfig
mips                   sb1250_swarm_defconfig
powerpc                  mpc885_ads_defconfig
nios2                         3c120_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                            hsdk_defconfig
mips                        bcm63xx_defconfig
openrisc                            defconfig
ia64                        generic_defconfig
openrisc                 simple_smp_defconfig
mips                  cavium_octeon_defconfig
sparc                            allyesconfig
powerpc                  storcenter_defconfig
x86_64                              defconfig
m68k                                defconfig
powerpc                    ge_imp3a_defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
sh                          r7785rp_defconfig
ia64                         bigsur_defconfig
m68k                        m5272c3_defconfig
m68k                        mvme16x_defconfig
arc                         haps_hs_defconfig
sparc64                          alldefconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210128
i386                 randconfig-a002-20210128
i386                 randconfig-a004-20210128
i386                 randconfig-a005-20210128
i386                 randconfig-a003-20210128
i386                 randconfig-a006-20210128
x86_64               randconfig-a012-20210128
x86_64               randconfig-a015-20210128
x86_64               randconfig-a016-20210128
x86_64               randconfig-a011-20210128
x86_64               randconfig-a013-20210128
x86_64               randconfig-a014-20210128
i386                 randconfig-a013-20210128
i386                 randconfig-a011-20210128
i386                 randconfig-a012-20210128
i386                 randconfig-a016-20210128
i386                 randconfig-a014-20210128
i386                 randconfig-a015-20210128
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
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210128
x86_64               randconfig-a003-20210128
x86_64               randconfig-a001-20210128
x86_64               randconfig-a005-20210128
x86_64               randconfig-a006-20210128
x86_64               randconfig-a004-20210128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

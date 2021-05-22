Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55EF38D54E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhEVKuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:50:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:28980 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhEVKuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:50:17 -0400
IronPort-SDR: qOmGj/dHwmm4lCCCTZRwaBQ6E62Gv+FMU3qtf52Pk2hHi7L5s4daX75reuB1+ZsPBDKGhqFlJS
 PKPO7XkVC2dw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="265553977"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265553977"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2021 03:48:52 -0700
IronPort-SDR: 1DCxHiNwwhIAso2wfzdNL9msnAu/JE3C6jcHcGyzCaenmDVM4JzKhNLgi+4AfuI0dUUB1Ncsfa
 MFh2E9tg/VgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407020215"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 22 May 2021 03:48:51 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lkPBa-00001x-Id; Sat, 22 May 2021 10:48:50 +0000
Date:   Sat, 22 May 2021 18:47:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 fa9882cea6d78ad27f5239aecaf0ae583eb15ca1
Message-ID: <60a8e15a.HHpCjmkOj7K0PDmt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: fa9882cea6d78ad27f5239aecaf0ae583eb15ca1  Documentation/RCU: Fix emphasis markers

elapsed time: 1828m

configs tested: 122
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                generic_kc705_defconfig
mips                         tb0219_defconfig
arc                     haps_hs_smp_defconfig
mips                       capcella_defconfig
m68k                        mvme147_defconfig
xtensa                              defconfig
arm                            mmp2_defconfig
powerpc                        warp_defconfig
powerpc                     skiroot_defconfig
arm                            mps2_defconfig
powerpc                 mpc836x_mds_defconfig
sh                          rsk7269_defconfig
x86_64                           allyesconfig
powerpc                    socrates_defconfig
mips                           xway_defconfig
arm                        mvebu_v5_defconfig
h8300                     edosk2674_defconfig
m68k                       m5249evb_defconfig
arm                      pxa255-idp_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                        icon_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     cu1000-neo_defconfig
mips                        maltaup_defconfig
powerpc                         wii_defconfig
h8300                            alldefconfig
powerpc                      katmai_defconfig
xtensa                       common_defconfig
powerpc                     akebono_defconfig
mips                         tb0287_defconfig
um                           x86_64_defconfig
sh                          r7780mp_defconfig
arm                            lart_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      mgcoge_defconfig
arm                           u8500_defconfig
arm                         lpc32xx_defconfig
h8300                               defconfig
mips                     loongson2k_defconfig
arm                     am200epdkit_defconfig
powerpc                     mpc83xx_defconfig
arm                         s3c2410_defconfig
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
i386                 randconfig-a001-20210521
i386                 randconfig-a005-20210521
i386                 randconfig-a002-20210521
i386                 randconfig-a006-20210521
i386                 randconfig-a003-20210521
i386                 randconfig-a004-20210521
x86_64               randconfig-a013-20210521
x86_64               randconfig-a014-20210521
x86_64               randconfig-a012-20210521
x86_64               randconfig-a016-20210521
x86_64               randconfig-a015-20210521
x86_64               randconfig-a011-20210521
i386                 randconfig-a016-20210521
i386                 randconfig-a011-20210521
i386                 randconfig-a015-20210521
i386                 randconfig-a012-20210521
i386                 randconfig-a014-20210521
i386                 randconfig-a013-20210521
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-b001-20210521
x86_64               randconfig-a006-20210521
x86_64               randconfig-a001-20210521
x86_64               randconfig-a005-20210521
x86_64               randconfig-a003-20210521
x86_64               randconfig-a004-20210521
x86_64               randconfig-a002-20210521

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

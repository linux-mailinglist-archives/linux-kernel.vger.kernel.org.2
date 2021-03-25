Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC213491CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhCYMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:22:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:6964 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhCYMWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:22:10 -0400
IronPort-SDR: AnDiDpFQp4oa6FW2pb4ahfFcKaGu7VwCkBff3u+ZiW8n/I6K3D+3wRislfuwZidIaaR+BudVpN
 gwTS7AYvAKeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="254910244"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="254910244"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 05:22:09 -0700
IronPort-SDR: whx/PZZB6VXvzysSHlXd7SJWmA7iG8ZD+edjdKAIFS+n6RBaN2a899pzT64Hgu975uiJ5/Si4x
 pwalzFPYQIRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="436441438"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2021 05:22:08 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPP03-0001vp-Ic; Thu, 25 Mar 2021 12:22:07 +0000
Date:   Thu, 25 Mar 2021 20:21:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.03.18a] BUILD SUCCESS
 31531c0247544b81d26d4dc4e4aa7dd6ef466f12
Message-ID: <605c8061.lDpj9t0ODYjN9nnK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.03.18a
branch HEAD: 31531c0247544b81d26d4dc4e4aa7dd6ef466f12  fixup! torture: Add prototype kvm-remote.sh script

elapsed time: 721m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                         hackkit_defconfig
powerpc                    klondike_defconfig
powerpc                     tqm8555_defconfig
h8300                    h8300h-sim_defconfig
sh                          lboxre2_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
sh                             sh03_defconfig
sh                           se7343_defconfig
sh                               j2_defconfig
sh                        apsh4ad0a_defconfig
mips                          ath25_defconfig
arm                      integrator_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                        workpad_defconfig
powerpc64                           defconfig
arm                          pcm027_defconfig
xtensa                    smp_lx200_defconfig
arm                        keystone_defconfig
mips                           ip27_defconfig
arm                       netwinder_defconfig
arm                        cerfcube_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      ppc44x_defconfig
sh                           se7705_defconfig
arm                          moxart_defconfig
m68k                        m5407c3_defconfig
powerpc                     sequoia_defconfig
arc                           tb10x_defconfig
powerpc                    ge_imp3a_defconfig
m68k                       m5208evb_defconfig
powerpc                 linkstation_defconfig
sh                   secureedge5410_defconfig
powerpc                      katmai_defconfig
arm                        vexpress_defconfig
sh                          urquell_defconfig
powerpc                          g5_defconfig
arm                         mv78xx0_defconfig
arm                          exynos_defconfig
riscv                             allnoconfig
sh                      rts7751r2d1_defconfig
arm                      tct_hammer_defconfig
powerpc                       ebony_defconfig
powerpc                  iss476-smp_defconfig
mips                      maltaaprp_defconfig
arm                       imx_v6_v7_defconfig
arm64                            alldefconfig
arm                           viper_defconfig
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
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec
x86_64                           allyesconfig

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A3349274
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhCYMwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:52:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:55288 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhCYMwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:52:16 -0400
IronPort-SDR: SgpyEuTIgQlPsAr5YErQaZgFni8wYIETWnHPAsk3/waLhEoHadoXlUIUZdv0h3AcGLk3QLP+ks
 SNhJ+bYeRD8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="178473335"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="178473335"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 05:52:16 -0700
IronPort-SDR: rszMn68O13K3AOyp9a3LFNKbXinmyqlmZbv23Hd6ion3s/M1t9rHKw7K7mVJfQpam8/GfyWlGw
 +2KRyFRiC5wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="409357696"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2021 05:52:15 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPPTC-0001wm-Ch; Thu, 25 Mar 2021 12:52:14 +0000
Date:   Thu, 25 Mar 2021 20:52:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.03.22a] BUILD SUCCESS
 27cbc21bc1b24dd014f778e95711bfa91ac15564
Message-ID: <605c877a.ig67Le4U3Z4sevfJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.03.22a
branch HEAD: 27cbc21bc1b24dd014f778e95711bfa91ac15564  rcu: Fix various typos in comments

elapsed time: 726m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
riscv                            allmodconfig
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
powerpc                      pcm030_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      acadia_defconfig
mips                         tb0226_defconfig
powerpc                        cell_defconfig
alpha                            alldefconfig
mips                      pic32mzda_defconfig
ia64                          tiger_defconfig
parisc                generic-32bit_defconfig
sh                               j2_defconfig
sh                        apsh4ad0a_defconfig
mips                          ath25_defconfig
arm                      integrator_defconfig
mips                        bcm63xx_defconfig
mips                         tb0287_defconfig
m68k                          atari_defconfig
arm                          pcm027_defconfig
microblaze                      mmu_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                        workpad_defconfig
powerpc64                           defconfig
xtensa                    smp_lx200_defconfig
arm                        keystone_defconfig
mips                           ip27_defconfig
arm                       netwinder_defconfig
arm                        cerfcube_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      ppc44x_defconfig
mips                           gcw0_defconfig
powerpc                 mpc834x_mds_defconfig
arc                          axs103_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     tqm8548_defconfig
arm                        multi_v5_defconfig
sh                           sh2007_defconfig
xtensa                  cadence_csp_defconfig
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
xtensa                    xip_kc705_defconfig
arc                      axs103_smp_defconfig
mips                  maltasmvp_eva_defconfig
sh                          urquell_defconfig
powerpc                          g5_defconfig
arm                         mv78xx0_defconfig
arm                          exynos_defconfig
riscv                             allnoconfig
arm                          gemini_defconfig
sh                           se7751_defconfig
openrisc                    or1ksim_defconfig
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
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
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

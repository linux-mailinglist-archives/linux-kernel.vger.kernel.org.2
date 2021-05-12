Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633CC37BAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 12:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhELKft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 06:35:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:56450 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhELKfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 06:35:48 -0400
IronPort-SDR: BKQ3hvwlDy9Fso6PU32m1TABNRUSm0J1CM7ouJNK0bmbhdc4hDeOuq3sC9NVqQ3fQDm3kRMyye
 1BdfvM+Zmn7A==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="263600722"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="263600722"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 03:34:40 -0700
IronPort-SDR: J/pj4gQ8oIVJKqmlRaFUvS6JJBA3VX6PEAwtltFf0agmuJMwJyVjZYA1hTAlO1qvj5hVuLyGlu
 9GbIOcZIUMSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="409200541"
Received: from lkp-server01.sh.intel.com (HELO 1e931876798f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 May 2021 03:34:39 -0700
Received: from kbuild by 1e931876798f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgmCM-0000FN-QX; Wed, 12 May 2021 10:34:38 +0000
Date:   Wed, 12 May 2021 18:33:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 eb644db2c64efa2122cfbf9a7b17453ca74e0400
Message-ID: <609baf08.awAzk46voQKjZMRL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: eb644db2c64efa2122cfbf9a7b17453ca74e0400  torture: Add clocksource-watchdog testing to torture.sh

elapsed time: 1070m

configs tested: 149
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                         tb0287_defconfig
m68k                          sun3x_defconfig
mips                          rb532_defconfig
arm                      jornada720_defconfig
arm                          imote2_defconfig
powerpc                      pcm030_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            hisi_defconfig
powerpc                     tqm8560_defconfig
mips                        nlm_xlp_defconfig
sh                                  defconfig
arm                        multi_v7_defconfig
arm                        clps711x_defconfig
powerpc                  storcenter_defconfig
powerpc                     stx_gp3_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7721_defconfig
ia64                             allmodconfig
mips                          ath25_defconfig
powerpc                      ppc44x_defconfig
arc                          axs101_defconfig
powerpc                      ep88xc_defconfig
mips                        jmr3927_defconfig
um                            kunit_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          rsk7203_defconfig
powerpc                    klondike_defconfig
powerpc                     sequoia_defconfig
arm                            dove_defconfig
mips                      maltasmvp_defconfig
powerpc                      tqm8xx_defconfig
mips                      bmips_stb_defconfig
arm                            xcep_defconfig
arm                        vexpress_defconfig
sh                         ecovec24_defconfig
sh                   secureedge5410_defconfig
mips                    maltaup_xpa_defconfig
ia64                            zx1_defconfig
arm                          pxa910_defconfig
mips                 decstation_r4k_defconfig
arm                     eseries_pxa_defconfig
m68k                        mvme16x_defconfig
x86_64                           alldefconfig
mips                           ip32_defconfig
sh                            migor_defconfig
powerpc                         wii_defconfig
ia64                         bigsur_defconfig
alpha                            alldefconfig
sh                               j2_defconfig
powerpc                     tqm8555_defconfig
sh                              ul2_defconfig
mips                          ath79_defconfig
sh                          r7780mp_defconfig
m68k                        m5407c3_defconfig
arm                           spitz_defconfig
arm                         shannon_defconfig
powerpc                    ge_imp3a_defconfig
sh                            titan_defconfig
sh                   sh7770_generic_defconfig
x86_64                            allnoconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210511
i386                 randconfig-a001-20210511
i386                 randconfig-a005-20210511
i386                 randconfig-a004-20210511
i386                 randconfig-a002-20210511
i386                 randconfig-a006-20210511
i386                 randconfig-a003-20210512
i386                 randconfig-a001-20210512
i386                 randconfig-a005-20210512
i386                 randconfig-a004-20210512
i386                 randconfig-a002-20210512
i386                 randconfig-a006-20210512
x86_64               randconfig-a012-20210511
x86_64               randconfig-a015-20210511
x86_64               randconfig-a011-20210511
x86_64               randconfig-a013-20210511
x86_64               randconfig-a016-20210511
x86_64               randconfig-a014-20210511
i386                 randconfig-a016-20210511
i386                 randconfig-a014-20210511
i386                 randconfig-a011-20210511
i386                 randconfig-a015-20210511
i386                 randconfig-a012-20210511
i386                 randconfig-a013-20210511
x86_64               randconfig-a003-20210512
x86_64               randconfig-a004-20210512
x86_64               randconfig-a001-20210512
x86_64               randconfig-a005-20210512
x86_64               randconfig-a002-20210512
x86_64               randconfig-a006-20210512
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
x86_64               randconfig-a003-20210511
x86_64               randconfig-a004-20210511
x86_64               randconfig-a001-20210511
x86_64               randconfig-a005-20210511
x86_64               randconfig-a002-20210511
x86_64               randconfig-a006-20210511

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

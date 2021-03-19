Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B102341635
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 08:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhCSG7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 02:59:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:6645 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234068AbhCSG7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 02:59:15 -0400
IronPort-SDR: DkqkTlWqPpuRP43/Kt5BxOShAWCM6SnUeVUsi2X5Ztpha8LU0ebtEYz0Ur/aaGLUH+KWo2wG5O
 a23pmKb08uig==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="187487547"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="187487547"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 23:59:14 -0700
IronPort-SDR: vSGUdxkTEkAatYKHMDTMEZGi1z3cH1u0S2mcjW2VTP/9Ld5Oh58Rd8qK2JmXMDRNtKgpNAoeOq
 ppm+YTqnweeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="606507680"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2021 23:59:13 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lN96H-0001eK-0t; Fri, 19 Mar 2021 06:59:13 +0000
Date:   Fri, 19 Mar 2021 14:58:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.03.15a] BUILD SUCCESS
 7c9e50cc94bafe0ddfa28bb96b009f24c17ad149
Message-ID: <60544ba5.7UETvAS0MmDMhRn/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.03.15a
branch HEAD: 7c9e50cc94bafe0ddfa28bb96b009f24c17ad149  fixup! torture: Add prototype kvm-remote.sh script

elapsed time: 726m

configs tested: 143
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
riscv                            allyesconfig
i386                             allyesconfig
arc                          axs101_defconfig
sh                                  defconfig
ia64                        generic_defconfig
m68k                        mvme147_defconfig
riscv                    nommu_k210_defconfig
arc                                 defconfig
h8300                    h8300h-sim_defconfig
powerpc                     tqm8560_defconfig
mips                        nlm_xlp_defconfig
mips                     loongson1b_defconfig
m68k                        m5407c3_defconfig
sh                           se7712_defconfig
m68k                       m5275evb_defconfig
arm                           sunxi_defconfig
ia64                             allmodconfig
s390                          debug_defconfig
mips                         bigsur_defconfig
powerpc                         wii_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                            mps2_defconfig
powerpc                 linkstation_defconfig
xtensa                  audio_kc705_defconfig
mips                        vocore2_defconfig
powerpc                    ge_imp3a_defconfig
arm                          exynos_defconfig
powerpc                     tqm8548_defconfig
arm                         at91_dt_defconfig
sh                          r7780mp_defconfig
powerpc                      ppc6xx_defconfig
mips                          rb532_defconfig
openrisc                 simple_smp_defconfig
riscv                          rv32_defconfig
sh                          urquell_defconfig
arm                        mvebu_v5_defconfig
mips                       capcella_defconfig
powerpc                 mpc834x_mds_defconfig
mips                 decstation_r4k_defconfig
sh                          lboxre2_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                       maple_defconfig
powerpc                    adder875_defconfig
sh                          kfr2r09_defconfig
arm                         lpc32xx_defconfig
s390                             alldefconfig
xtensa                         virt_defconfig
powerpc                 mpc832x_rdb_defconfig
csky                             alldefconfig
sh                   sh7724_generic_defconfig
mips                malta_qemu_32r6_defconfig
sh                           se7721_defconfig
sh                     magicpanelr2_defconfig
powerpc                    amigaone_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                      makalu_defconfig
powerpc                  mpc885_ads_defconfig
m68k                        m5307c3_defconfig
arm                        shmobile_defconfig
mips                      pic32mzda_defconfig
m68k                       m5249evb_defconfig
um                             i386_defconfig
arm                          pxa3xx_defconfig
m68k                       m5208evb_defconfig
m68k                       bvme6000_defconfig
powerpc                     kmeter1_defconfig
sh                        edosk7760_defconfig
mips                            ar7_defconfig
sh                             espt_defconfig
ia64                             alldefconfig
powerpc                      tqm8xx_defconfig
arm                         socfpga_defconfig
mips                          ath79_defconfig
xtensa                  cadence_csp_defconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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

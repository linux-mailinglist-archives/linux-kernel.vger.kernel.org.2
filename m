Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD31390167
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhEYM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:57:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:5855 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232917AbhEYM5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:57:33 -0400
IronPort-SDR: 7OuGPvAjNtjFNtkv8Ac8yCronbHAViwV3ZR2Y04fkMDLP4HA48mf1qvyFXEYHXQiJqc0h736PJ
 xE9HkAtCCRWw==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="223349895"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="223349895"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 05:56:01 -0700
IronPort-SDR: nkPCBeiuvpWLnkz8RfLBY6KAIT6onm3tKQsxAUzacDBEKmwxWZKSTnYhHrPQ56A2osYTloBxr1
 IzbYBX7Rt59w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="442536242"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 May 2021 05:55:59 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1llWbG-0001eJ-SU; Tue, 25 May 2021 12:55:58 +0000
Date:   Tue, 25 May 2021 20:55:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.05.21a] BUILD SUCCESS
 59762df2e8e299ef73d7c5df00023de22d822131
Message-ID: <60acf3a8.dO8QKpA3PrSryHjo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.05.21a
branch HEAD: 59762df2e8e299ef73d7c5df00023de22d822131  rcu-tasks: Mark ->trc_reader_special.b.need_qs data races

i386-tinyconfig vmlinux size:

+-------+-----------------------------------+------------------------------------------+
| DELTA |              SYMBOL               |                  COMMIT                  |
+-------+-----------------------------------+------------------------------------------+
|  +538 | TOTAL                             | 6efb943b8616..59762df2e8e2 (ALL COMMITS) |
|  +392 | TEXT                              | 6efb943b8616..59762df2e8e2 (ALL COMMITS) |
|   +90 | DATA                              | 6efb943b8616..59762df2e8e2 (ALL COMMITS) |
|  +193 | clocksource_watchdog()            | 6efb943b8616..59762df2e8e2 (ALL COMMITS) |
|   +68 | clocksource_verify_percpu()       | 6efb943b8616..59762df2e8e2 (ALL COMMITS) |
|   +66 | __clocksource_update_freq_scale() | 6efb943b8616..59762df2e8e2 (ALL COMMITS) |
+-------+-----------------------------------+------------------------------------------+

elapsed time: 722m

configs tested: 204
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
mips                     loongson2k_defconfig
m68k                       m5249evb_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          collie_defconfig
mips                        qi_lb60_defconfig
arm                            hisi_defconfig
x86_64                              defconfig
powerpc                         wii_defconfig
arm                       spear13xx_defconfig
s390                                defconfig
xtensa                generic_kc705_defconfig
powerpc                      ep88xc_defconfig
sh                               j2_defconfig
powerpc                 mpc834x_mds_defconfig
mips                       lemote2f_defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
sh                         apsh4a3a_defconfig
arm                           spitz_defconfig
powerpc                      makalu_defconfig
sh                           se7206_defconfig
sh                            titan_defconfig
openrisc                    or1ksim_defconfig
m68k                        mvme16x_defconfig
x86_64                           alldefconfig
riscv                    nommu_virt_defconfig
arm                  colibri_pxa270_defconfig
mips                         cobalt_defconfig
mips                        omega2p_defconfig
mips                          malta_defconfig
mips                          rb532_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                          rsk7201_defconfig
mips                           rs90_defconfig
powerpc                      ppc6xx_defconfig
mips                       bmips_be_defconfig
arm                           tegra_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                    mvme5100_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
powerpc                      pasemi_defconfig
csky                             alldefconfig
powerpc                       holly_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      katmai_defconfig
arm                        spear3xx_defconfig
mips                      fuloong2e_defconfig
sparc                            alldefconfig
arm                          iop32x_defconfig
sh                           se7705_defconfig
arm                        vexpress_defconfig
arm                         assabet_defconfig
sh                         ap325rxa_defconfig
mips                  cavium_octeon_defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
sparc                               defconfig
h8300                    h8300h-sim_defconfig
sh                   sh7724_generic_defconfig
powerpc                    adder875_defconfig
sh                        edosk7760_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
um                            kunit_defconfig
powerpc                   motionpro_defconfig
arc                     haps_hs_smp_defconfig
arm                           stm32_defconfig
arm                    vt8500_v6_v7_defconfig
arm                       aspeed_g5_defconfig
powerpc                      arches_defconfig
sh                              ul2_defconfig
arm                              alldefconfig
powerpc64                           defconfig
powerpc                 mpc8560_ads_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
arc                           tb10x_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                    ge_imp3a_defconfig
sh                               alldefconfig
sparc64                             defconfig
mips                         tb0226_defconfig
arm                          lpd270_defconfig
sh                   rts7751r2dplus_defconfig
arm                          gemini_defconfig
powerpc                  mpc885_ads_defconfig
m68k                             alldefconfig
sh                        sh7763rdp_defconfig
powerpc                      pcm030_defconfig
xtensa                    xip_kc705_defconfig
parisc                           alldefconfig
m68k                          sun3x_defconfig
mips                   sb1250_swarm_defconfig
m68k                       m5208evb_defconfig
arm                            xcep_defconfig
arm                         lpc32xx_defconfig
xtensa                         virt_defconfig
alpha                            alldefconfig
arc                 nsimosci_hs_smp_defconfig
arm                          badge4_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210524
x86_64               randconfig-a001-20210524
x86_64               randconfig-a006-20210524
x86_64               randconfig-a003-20210524
x86_64               randconfig-a004-20210524
x86_64               randconfig-a002-20210524
i386                 randconfig-a001-20210525
i386                 randconfig-a002-20210525
i386                 randconfig-a005-20210525
i386                 randconfig-a006-20210525
i386                 randconfig-a003-20210525
i386                 randconfig-a004-20210525
i386                 randconfig-a001-20210524
i386                 randconfig-a002-20210524
i386                 randconfig-a005-20210524
i386                 randconfig-a006-20210524
i386                 randconfig-a004-20210524
i386                 randconfig-a003-20210524
x86_64               randconfig-a013-20210525
x86_64               randconfig-a012-20210525
x86_64               randconfig-a014-20210525
x86_64               randconfig-a016-20210525
x86_64               randconfig-a015-20210525
x86_64               randconfig-a011-20210525
i386                 randconfig-a011-20210525
i386                 randconfig-a016-20210525
i386                 randconfig-a015-20210525
i386                 randconfig-a012-20210525
i386                 randconfig-a014-20210525
i386                 randconfig-a013-20210525
i386                 randconfig-a011-20210524
i386                 randconfig-a016-20210524
i386                 randconfig-a015-20210524
i386                 randconfig-a012-20210524
i386                 randconfig-a014-20210524
i386                 randconfig-a013-20210524
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210525
x86_64               randconfig-b001-20210524
x86_64               randconfig-a005-20210525
x86_64               randconfig-a006-20210525
x86_64               randconfig-a001-20210525
x86_64               randconfig-a003-20210525
x86_64               randconfig-a004-20210525
x86_64               randconfig-a002-20210525
x86_64               randconfig-a013-20210524
x86_64               randconfig-a012-20210524
x86_64               randconfig-a014-20210524
x86_64               randconfig-a016-20210524
x86_64               randconfig-a015-20210524
x86_64               randconfig-a011-20210524

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED643FF5D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhJ2PYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:24:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:29206 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhJ2PYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:24:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="316878773"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="316878773"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 08:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="530422049"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2021 08:00:59 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mgTNL-0000PE-9H; Fri, 29 Oct 2021 15:00:59 +0000
Date:   Fri, 29 Oct 2021 23:00:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 a01016aa420e33f0c5f2b8d88f99966aba83ca0b
Message-ID: <617c0c8e.tu8un4hn4Elu+Pok%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: a01016aa420e33f0c5f2b8d88f99966aba83ca0b  refscale: Always log the error message

elapsed time: 2696m

configs tested: 188
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211027
i386                 randconfig-c001-20211028
powerpc              randconfig-c003-20211028
m68k                            q40_defconfig
powerpc                          g5_defconfig
m68k                         amcore_defconfig
sh                            hp6xx_defconfig
mips                 decstation_r4k_defconfig
sh                      rts7751r2d1_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
powerpc                     skiroot_defconfig
arm                           sama7_defconfig
powerpc                      ppc64e_defconfig
arm                            hisi_defconfig
powerpc                      ppc40x_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
sh                             shx3_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                         apsh4a3a_defconfig
mips                           rs90_defconfig
powerpc                     mpc83xx_defconfig
mips                            gpr_defconfig
arm                          collie_defconfig
arm                              alldefconfig
arm                         shannon_defconfig
mips                         tb0287_defconfig
sh                                  defconfig
arc                              alldefconfig
mips                           ip32_defconfig
mips                      loongson3_defconfig
arm                         socfpga_defconfig
arm                            pleb_defconfig
openrisc                    or1ksim_defconfig
powerpc                      pasemi_defconfig
arc                     haps_hs_smp_defconfig
riscv                            alldefconfig
arc                          axs101_defconfig
powerpc                      pcm030_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     rainier_defconfig
arm                             rpc_defconfig
powerpc                      ppc6xx_defconfig
arm                         at91_dt_defconfig
mips                  maltasmvp_eva_defconfig
m68k                          amiga_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          multi_defconfig
powerpc                    amigaone_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     decstation_defconfig
arc                           tb10x_defconfig
sh                             sh03_defconfig
powerpc                    mvme5100_defconfig
arm                      integrator_defconfig
arc                          axs103_defconfig
mips                         rt305x_defconfig
mips                         tb0219_defconfig
arm                          ep93xx_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc834x_itx_defconfig
microblaze                      mmu_defconfig
arm                        mvebu_v5_defconfig
arm                   milbeaut_m10v_defconfig
arm                  randconfig-c002-20211028
arm                  randconfig-c002-20211027
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211028
x86_64               randconfig-a004-20211028
x86_64               randconfig-a005-20211028
x86_64               randconfig-a001-20211028
x86_64               randconfig-a006-20211028
x86_64               randconfig-a003-20211028
i386                 randconfig-a004-20211028
i386                 randconfig-a003-20211028
i386                 randconfig-a002-20211028
i386                 randconfig-a006-20211028
i386                 randconfig-a001-20211028
i386                 randconfig-a005-20211028
x86_64               randconfig-a013-20211027
x86_64               randconfig-a015-20211027
x86_64               randconfig-a011-20211027
x86_64               randconfig-a014-20211027
x86_64               randconfig-a016-20211027
x86_64               randconfig-a012-20211027
i386                 randconfig-a012-20211027
i386                 randconfig-a013-20211027
i386                 randconfig-a011-20211027
i386                 randconfig-a016-20211027
i386                 randconfig-a015-20211027
i386                 randconfig-a014-20211027
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20211027
powerpc              randconfig-c003-20211027
arm                  randconfig-c002-20211027
mips                 randconfig-c004-20211027
x86_64               randconfig-c007-20211027
i386                 randconfig-c001-20211027
s390                 randconfig-c005-20211027
arm                  randconfig-c002-20211028
powerpc              randconfig-c003-20211028
riscv                randconfig-c006-20211028
x86_64               randconfig-c007-20211028
mips                 randconfig-c004-20211028
s390                 randconfig-c005-20211028
i386                 randconfig-c001-20211028
x86_64               randconfig-a002-20211027
x86_64               randconfig-a004-20211027
x86_64               randconfig-a005-20211027
x86_64               randconfig-a006-20211027
x86_64               randconfig-a001-20211027
x86_64               randconfig-a003-20211027
i386                 randconfig-a003-20211027
i386                 randconfig-a004-20211027
i386                 randconfig-a002-20211027
i386                 randconfig-a005-20211027
i386                 randconfig-a001-20211027
i386                 randconfig-a006-20211027
x86_64               randconfig-a015-20211028
x86_64               randconfig-a013-20211028
x86_64               randconfig-a011-20211028
x86_64               randconfig-a014-20211028
x86_64               randconfig-a012-20211028
x86_64               randconfig-a016-20211028
i386                 randconfig-a012-20211028
i386                 randconfig-a013-20211028
i386                 randconfig-a011-20211028
i386                 randconfig-a015-20211028
i386                 randconfig-a016-20211028
i386                 randconfig-a014-20211028
hexagon              randconfig-r045-20211028
riscv                randconfig-r042-20211028
s390                 randconfig-r044-20211028
hexagon              randconfig-r041-20211028
hexagon              randconfig-r045-20211027
hexagon              randconfig-r041-20211027

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

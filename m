Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A18E3A41E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhFKMZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:25:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:62505 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhFKMZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:25:15 -0400
IronPort-SDR: 8AA9EcqBoX6889u+41EH/xMY4OjtQxIvFK2I1/peQrSzUEjBPjBvYsuwKl2HyHEBaMZeLv7iza
 XQMTQwqZOh9w==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="269362654"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="269362654"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 05:23:15 -0700
IronPort-SDR: VHLR3GKvVueNFS7ASlT2bVthLdJl1tBQG3MAMRQUjwZH8odNL3E15YLaBsa0eqMWFCHw8hafeZ
 TZdpr+FFBmuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="450747359"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2021 05:23:14 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrgBu-0000a9-HI; Fri, 11 Jun 2021 12:23:14 +0000
Date:   Fri, 11 Jun 2021 20:22:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.06.09a] BUILD SUCCESS
 f21b8fbdf9a59553da825265e92cedb639b4ba3c
Message-ID: <60c35596.eaJQNBGKWjS6t+/k%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.06.09a
branch HEAD: f21b8fbdf9a59553da825265e92cedb639b4ba3c  rcu/doc: Add a quick quiz to explain further why we need smp_mb__after_unlock_lock()

elapsed time: 724m

configs tested: 169
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc832x_mds_defconfig
mips                        vocore2_defconfig
arc                        nsimosci_defconfig
arm                              alldefconfig
nds32                            alldefconfig
powerpc                 mpc8313_rdb_defconfig
arm                       aspeed_g5_defconfig
arm                         s5pv210_defconfig
mips                         tb0226_defconfig
ia64                                defconfig
riscv             nommu_k210_sdcard_defconfig
arm                        multi_v5_defconfig
powerpc                     kilauea_defconfig
mips                   sb1250_swarm_defconfig
arm                        spear6xx_defconfig
arm                           stm32_defconfig
sh                   sh7770_generic_defconfig
sh                          rsk7201_defconfig
arm                        shmobile_defconfig
m68k                          sun3x_defconfig
x86_64                              defconfig
alpha                            allyesconfig
arm                          pxa910_defconfig
sh                   rts7751r2dplus_defconfig
arm                         hackkit_defconfig
sh                          kfr2r09_defconfig
mips                        jmr3927_defconfig
arm                     am200epdkit_defconfig
mips                           ip22_defconfig
m68k                        m5407c3_defconfig
arm                             mxs_defconfig
arm                            pleb_defconfig
arm                         palmz72_defconfig
sh                          polaris_defconfig
arm                            qcom_defconfig
m68k                       m5249evb_defconfig
sparc                            alldefconfig
arm                           spitz_defconfig
powerpc                     stx_gp3_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
arm                        mini2440_defconfig
riscv                    nommu_k210_defconfig
arm                       mainstone_defconfig
powerpc                      ep88xc_defconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8540_defconfig
h8300                     edosk2674_defconfig
arm                         at91_dt_defconfig
sh                               alldefconfig
powerpc                 mpc8272_ads_defconfig
h8300                               defconfig
sh                           se7619_defconfig
powerpc                    ge_imp3a_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
parisc                           alldefconfig
mips                            gpr_defconfig
nios2                               defconfig
sh                          sdk7780_defconfig
sparc64                             defconfig
sh                            shmin_defconfig
h8300                            alldefconfig
mips                        workpad_defconfig
openrisc                  or1klitex_defconfig
sh                           se7721_defconfig
mips                         rt305x_defconfig
powerpc                      tqm8xx_defconfig
nios2                         3c120_defconfig
microblaze                      mmu_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          sdk7786_defconfig
i386                                defconfig
sh                              ul2_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc6xx_defconfig
um                               alldefconfig
powerpc                 mpc836x_mds_defconfig
arc                          axs103_defconfig
mips                        omega2p_defconfig
sh                           se7712_defconfig
powerpc                     kmeter1_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210611
x86_64               randconfig-a001-20210611
x86_64               randconfig-a004-20210611
x86_64               randconfig-a003-20210611
x86_64               randconfig-a006-20210611
x86_64               randconfig-a005-20210611
i386                 randconfig-a002-20210611
i386                 randconfig-a006-20210611
i386                 randconfig-a004-20210611
i386                 randconfig-a001-20210611
i386                 randconfig-a005-20210611
i386                 randconfig-a003-20210611
i386                 randconfig-a002-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a005-20210610
i386                 randconfig-a003-20210610
x86_64               randconfig-a015-20210610
x86_64               randconfig-a011-20210610
x86_64               randconfig-a012-20210610
x86_64               randconfig-a014-20210610
x86_64               randconfig-a016-20210610
x86_64               randconfig-a013-20210610
i386                 randconfig-a015-20210611
i386                 randconfig-a013-20210611
i386                 randconfig-a016-20210611
i386                 randconfig-a014-20210611
i386                 randconfig-a012-20210611
i386                 randconfig-a011-20210611
i386                 randconfig-a015-20210610
i386                 randconfig-a013-20210610
i386                 randconfig-a016-20210610
i386                 randconfig-a014-20210610
i386                 randconfig-a012-20210610
i386                 randconfig-a011-20210610
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

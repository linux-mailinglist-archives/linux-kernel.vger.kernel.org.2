Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E146A3793EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhEJQen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:34:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:37969 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231646AbhEJQek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:34:40 -0400
IronPort-SDR: /b7imksNxqCy3WIULxd+u5oAdtC971x4ToarFBS+GQR7lCPOQmR5Wp3GdtJ5Oe3B6YNIZ/L2Jo
 aRcFjZlOSVEQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199304314"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="199304314"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 09:33:35 -0700
IronPort-SDR: 7Rlc+pS/DDh1li5lJ+cy0O0hzfVYUHZcU3XV1UR5eEYzcOWLdbgKtcJDqHtxVzaLdwtjbXG7ft
 Cam/d4RaqSxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="391041718"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 May 2021 09:33:33 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lg8qa-0000Gg-CP; Mon, 10 May 2021 16:33:32 +0000
Date:   Tue, 11 May 2021 00:33:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 2349a35d39e7af5eef9064cbd0e42309040551da
Message-ID: <6099603c.9wryziReCMGQg1vJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 2349a35d39e7af5eef9064cbd0e42309040551da  kvfree_rcu: Refactor kfree_rcu_monitor()

elapsed time: 721m

configs tested: 183
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
powerpc                     mpc5200_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        nlm_xlr_defconfig
powerpc                     kmeter1_defconfig
sh                          urquell_defconfig
arm                         at91_dt_defconfig
arc                         haps_hs_defconfig
mips                       capcella_defconfig
arc                     haps_hs_smp_defconfig
mips                      pic32mzda_defconfig
mips                malta_qemu_32r6_defconfig
arm                        mvebu_v5_defconfig
arm                         vf610m4_defconfig
h8300                            alldefconfig
powerpc                      ppc64e_defconfig
powerpc                  storcenter_defconfig
arm                         palmz72_defconfig
xtensa                          iss_defconfig
riscv                               defconfig
openrisc                  or1klitex_defconfig
ia64                          tiger_defconfig
s390                             alldefconfig
sh                           se7619_defconfig
arm                         nhk8815_defconfig
m68k                        mvme16x_defconfig
mips                           xway_defconfig
mips                           ip32_defconfig
riscv                    nommu_k210_defconfig
mips                     cu1830-neo_defconfig
ia64                        generic_defconfig
sh                   sh7770_generic_defconfig
mips                       lemote2f_defconfig
sh                               alldefconfig
arm                            lart_defconfig
openrisc                            defconfig
arm                            pleb_defconfig
powerpc                     tqm8555_defconfig
powerpc                 mpc837x_mds_defconfig
s390                       zfcpdump_defconfig
xtensa                         virt_defconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
mips                          rm200_defconfig
arm                             ezx_defconfig
powerpc                 mpc834x_mds_defconfig
mips                        bcm63xx_defconfig
mips                      maltaaprp_defconfig
mips                         rt305x_defconfig
arm                     eseries_pxa_defconfig
powerpc                    amigaone_defconfig
mips                  cavium_octeon_defconfig
powerpc                        warp_defconfig
powerpc                     tqm8548_defconfig
arm                            mps2_defconfig
arm                      jornada720_defconfig
arm                            zeus_defconfig
sh                        edosk7760_defconfig
xtensa                  audio_kc705_defconfig
arc                              alldefconfig
xtensa                  cadence_csp_defconfig
x86_64                           alldefconfig
mips                        bcm47xx_defconfig
mips                         tb0226_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     decstation_defconfig
mips                        omega2p_defconfig
arm                         mv78xx0_defconfig
ia64                             alldefconfig
powerpc                       maple_defconfig
mips                        workpad_defconfig
sh                               j2_defconfig
sh                         microdev_defconfig
xtensa                           alldefconfig
sh                            hp6xx_defconfig
powerpc                    klondike_defconfig
arm                           u8500_defconfig
sh                              ul2_defconfig
powerpc                      pmac32_defconfig
mips                         tb0287_defconfig
sh                          sdk7786_defconfig
mips                        qi_lb60_defconfig
sh                           se7724_defconfig
mips                        maltaup_defconfig
powerpc                        icon_defconfig
arm                        multi_v7_defconfig
nios2                         10m50_defconfig
arm                      pxa255-idp_defconfig
arm                           h5000_defconfig
arm                         hackkit_defconfig
powerpc64                        alldefconfig
arc                     nsimosci_hs_defconfig
arm                         cm_x300_defconfig
arc                      axs103_smp_defconfig
sh                         apsh4a3a_defconfig
s390                             allyesconfig
arm                        multi_v5_defconfig
sh                           se7780_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 linkstation_defconfig
mips                      bmips_stb_defconfig
mips                             allmodconfig
powerpc                    gamecube_defconfig
powerpc                   motionpro_defconfig
nios2                            alldefconfig
x86_64                              defconfig
h8300                    h8300h-sim_defconfig
mips                          ath25_defconfig
arm                          ixp4xx_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210510
x86_64               randconfig-a004-20210510
x86_64               randconfig-a001-20210510
x86_64               randconfig-a005-20210510
x86_64               randconfig-a002-20210510
x86_64               randconfig-a006-20210510
i386                 randconfig-a003-20210510
i386                 randconfig-a001-20210510
i386                 randconfig-a005-20210510
i386                 randconfig-a004-20210510
i386                 randconfig-a002-20210510
i386                 randconfig-a006-20210510
i386                 randconfig-a016-20210510
i386                 randconfig-a014-20210510
i386                 randconfig-a011-20210510
i386                 randconfig-a015-20210510
i386                 randconfig-a012-20210510
i386                 randconfig-a013-20210510
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210510
x86_64               randconfig-a012-20210510
x86_64               randconfig-a011-20210510
x86_64               randconfig-a013-20210510
x86_64               randconfig-a016-20210510
x86_64               randconfig-a014-20210510

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

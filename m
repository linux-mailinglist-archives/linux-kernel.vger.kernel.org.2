Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE038BF58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhEUGbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:31:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:14210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232484AbhEUGa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:30:59 -0400
IronPort-SDR: fUqKmbdChAed2yfWV4YRMvxceUP9ZC12wekj2fHifVArxwF2dJeQ/U81Nnq76KZOd2Zb+eeK8B
 hs2lXQOXUClQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="262635136"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262635136"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 23:28:55 -0700
IronPort-SDR: k2bDR7eETLuzfe4AsIqP95gVR+kpACt1eY0wvJ4gC7Lu5M9i/GQSBBDO7/59cuBXmlbC4EF0Y5
 Ptnlam8ulpUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="412478263"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 May 2021 23:28:54 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljyeT-0000yk-MP; Fri, 21 May 2021 06:28:53 +0000
Date:   Fri, 21 May 2021 14:28:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.05.18a] BUILD REGRESSION
 086e6d19878e9b3c6b3b97599229b4b7bdfe1876
Message-ID: <60a75320.HyMBMHRxwDY6Gr8l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.05.18a
branch HEAD: 086e6d19878e9b3c6b3b97599229b4b7bdfe1876  Documentation/RCU: Fix emphasis markers

Error/Warning reports:

https://lore.kernel.org/lkml/202105211023.BuU7Y7IQ-lkp@intel.com

Error/Warning in current branch:

arch/powerpc/include/asm/kvm_para.h:27:40: error: 'KVM_HC_FEATURES' undeclared (first use in this function)

possible Error/Warning in current branch:

kernel/rcu/tree_nocb.h:1004:32: sparse: sparse: context imbalance in 'rcu_nocb_rdp_deoffload' - different lock contexts for basic block
kernel/rcu/tree_nocb.h:1006:32: sparse: sparse: context imbalance in 'rcu_nocb_rdp_deoffload' - different lock contexts for basic block
kernel/rcu/tree_nocb.h:130:16: sparse: sparse: context imbalance in 'rcu_nocb_bypass_trylock' - wrong count at exit
kernel/rcu/tree_nocb.h:132:16: sparse: sparse: context imbalance in 'rcu_nocb_bypass_trylock' - wrong count at exit
kernel/rcu/tree_nocb.h:147:13: sparse: sparse: context imbalance in 'rcu_nocb_lock' - wrong count at exit
kernel/rcu/tree_nocb.h:149:13: sparse: sparse: context imbalance in 'rcu_nocb_lock' - wrong count at exit
kernel/rcu/tree_nocb.h:331:13: sparse: sparse: context imbalance in 'rcu_nocb_flush_bypass' - wrong count at exit
kernel/rcu/tree_nocb.h:333:13: sparse: sparse: context imbalance in 'rcu_nocb_flush_bypass' - wrong count at exit
kernel/rcu/tree_nocb.h:493:13: sparse: sparse: context imbalance in '__call_rcu_nocb_wake' - wrong count at exit
kernel/rcu/tree_nocb.h:495:13: sparse: sparse: context imbalance in '__call_rcu_nocb_wake' - wrong count at exit
kernel/rcu/tree_nocb.h:627:9: sparse: sparse: context imbalance in 'nocb_gp_wait' - different lock contexts for basic block
kernel/rcu/tree_nocb.h:629:9: sparse: sparse: context imbalance in 'nocb_gp_wait' - different lock contexts for basic block
kernel/rcu/tree_nocb.h:843:9: sparse: sparse: context imbalance in 'nocb_cb_wait' - wrong count at exit
kernel/rcu/tree_nocb.h:845:9: sparse: sparse: context imbalance in 'nocb_cb_wait' - wrong count at exit
kernel/rcu/tree_nocb.h:966:9: sparse: sparse: context imbalance in 'rdp_offload_toggle' - wrong count at exit
kernel/rcu/tree_nocb.h:968:9: sparse: sparse: context imbalance in 'rdp_offload_toggle' - wrong count at exit

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- ia64-randconfig-s032-20210520
|   |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-__call_rcu_nocb_wake-wrong-count-at-exit
|   |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-nocb_cb_wait-wrong-count-at-exit
|   |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-nocb_gp_wait-different-lock-contexts-for-basic-block
|   |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-rcu_nocb_bypass_trylock-wrong-count-at-exit
|   |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-rcu_nocb_flush_bypass-wrong-count-at-exit
|   |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-rcu_nocb_lock-wrong-count-at-exit
|   |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-rcu_nocb_rdp_deoffload-different-lock-contexts-for-basic-block
|   `-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-rdp_offload_toggle-wrong-count-at-exit
|-- powerpc-allyesconfig
|   `-- arch-powerpc-include-asm-kvm_para.h:error:KVM_HC_FEATURES-undeclared-(first-use-in-this-function)
`-- x86_64-randconfig-s021-20210520
    |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-__call_rcu_nocb_wake-wrong-count-at-exit
    |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-nocb_cb_wait-wrong-count-at-exit
    |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-nocb_gp_wait-different-lock-contexts-for-basic-block
    |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-rcu_nocb_bypass_trylock-wrong-count-at-exit
    |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-rcu_nocb_flush_bypass-wrong-count-at-exit
    |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-rcu_nocb_lock-wrong-count-at-exit
    |-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-rcu_nocb_rdp_deoffload-different-lock-contexts-for-basic-block
    `-- kernel-rcu-tree_nocb.h:sparse:sparse:context-imbalance-in-rdp_offload_toggle-wrong-count-at-exit

elapsed time: 725m

configs tested: 168
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc885_ads_defconfig
mips                           gcw0_defconfig
powerpc                 mpc834x_itx_defconfig
arm                           sunxi_defconfig
openrisc                  or1klitex_defconfig
arc                     haps_hs_smp_defconfig
arm                        mvebu_v5_defconfig
arm                     am200epdkit_defconfig
mips                          rb532_defconfig
sh                           se7343_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm5200_defconfig
m68k                       m5275evb_defconfig
sh                          lboxre2_defconfig
arm                            qcom_defconfig
powerpc                    klondike_defconfig
arm                        realview_defconfig
mips                        qi_lb60_defconfig
mips                           rs90_defconfig
sh                           se7721_defconfig
arm                          moxart_defconfig
m68k                       m5208evb_defconfig
mips                malta_qemu_32r6_defconfig
sh                   secureedge5410_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     skiroot_defconfig
mips                           ip27_defconfig
powerpc                      ep88xc_defconfig
arm                        spear6xx_defconfig
arm                       aspeed_g5_defconfig
um                                  defconfig
arm                         shannon_defconfig
powerpc                       maple_defconfig
mips                        jmr3927_defconfig
mips                       capcella_defconfig
powerpc                     tqm8560_defconfig
ia64                             allmodconfig
powerpc                     tqm8541_defconfig
powerpc                      pcm030_defconfig
m68k                       m5475evb_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    mvme5100_defconfig
powerpc                     pq2fads_defconfig
xtensa                    xip_kc705_defconfig
sparc                       sparc64_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7722_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                         apsh4a3a_defconfig
arm                       omap2plus_defconfig
arc                         haps_hs_defconfig
m68k                          sun3x_defconfig
powerpc                     tqm8555_defconfig
arc                        nsimosci_defconfig
arm                         cm_x300_defconfig
mips                           ip28_defconfig
powerpc                     asp8347_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      makalu_defconfig
powerpc                     rainier_defconfig
arm                         lubbock_defconfig
mips                         tb0287_defconfig
arm                       aspeed_g4_defconfig
mips                      malta_kvm_defconfig
arm                       netwinder_defconfig
arm                         palmz72_defconfig
arm                        vexpress_defconfig
arm                         mv78xx0_defconfig
powerpc                     mpc83xx_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      chrp32_defconfig
nios2                         3c120_defconfig
nds32                             allnoconfig
sh                               j2_defconfig
sh                             espt_defconfig
s390                       zfcpdump_defconfig
powerpc                        warp_defconfig
powerpc                     tqm8548_defconfig
mips                            gpr_defconfig
powerpc                      walnut_defconfig
arc                    vdk_hs38_smp_defconfig
openrisc                 simple_smp_defconfig
mips                        vocore2_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
x86_64               randconfig-a001-20210520
x86_64               randconfig-a006-20210520
x86_64               randconfig-a005-20210520
x86_64               randconfig-a003-20210520
x86_64               randconfig-a004-20210520
x86_64               randconfig-a002-20210520
i386                 randconfig-a001-20210520
i386                 randconfig-a005-20210520
i386                 randconfig-a002-20210520
i386                 randconfig-a006-20210520
i386                 randconfig-a004-20210520
i386                 randconfig-a003-20210520
i386                 randconfig-a001-20210521
i386                 randconfig-a005-20210521
i386                 randconfig-a002-20210521
i386                 randconfig-a006-20210521
i386                 randconfig-a003-20210521
i386                 randconfig-a004-20210521
i386                 randconfig-a016-20210520
i386                 randconfig-a011-20210520
i386                 randconfig-a015-20210520
i386                 randconfig-a012-20210520
i386                 randconfig-a014-20210520
i386                 randconfig-a013-20210520
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
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210521
x86_64               randconfig-b001-20210520
x86_64               randconfig-a013-20210520
x86_64               randconfig-a014-20210520
x86_64               randconfig-a012-20210520
x86_64               randconfig-a016-20210520
x86_64               randconfig-a015-20210520
x86_64               randconfig-a011-20210520

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

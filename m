Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACDC32C406
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378747AbhCDAKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:10:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:36579 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1391856AbhCCWvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:51:18 -0500
IronPort-SDR: QriaMfydYinrvhJVsBvfD/prUF3pOeoVB+ptiCatDgR6DlbR5+9Auv4AiNPP/D5RmNJoXaoWex
 vTxQA8AlcvpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="187408850"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="187408850"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 14:32:29 -0800
IronPort-SDR: ptIcPbOqGAYyN0M4xD+jUZn6UdffAovz15GWKamewMzigZcNskzXRS76qzyEgSjoaxBwTrmCm2
 J8gY57bKKu6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="406622452"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2021 14:32:28 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHa2d-0001nw-QK; Wed, 03 Mar 2021 22:32:27 +0000
Date:   Thu, 04 Mar 2021 06:32:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 8b89220650146d59e9a8af2e5f12fc582539609e
Message-ID: <60400e76.dkVbul+NnwIOqNyr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 8b89220650146d59e9a8af2e5f12fc582539609e  cpu/hotplug: Add cpuhp_invoke_callback_range()

elapsed time: 720m

configs tested: 130
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         at91_dt_defconfig
powerpc                 mpc832x_mds_defconfig
sh                              ul2_defconfig
powerpc                  mpc885_ads_defconfig
i386                             alldefconfig
powerpc                    klondike_defconfig
sparc                       sparc64_defconfig
powerpc                       eiger_defconfig
powerpc                       maple_defconfig
xtensa                         virt_defconfig
sh                          rsk7203_defconfig
csky                             alldefconfig
powerpc                  iss476-smp_defconfig
sh                         apsh4a3a_defconfig
mips                      bmips_stb_defconfig
arm                         lubbock_defconfig
arm                           tegra_defconfig
powerpc                     mpc5200_defconfig
powerpc                      tqm8xx_defconfig
sh                           se7751_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      cm5200_defconfig
powerpc                     tqm8555_defconfig
mips                  maltasmvp_eva_defconfig
sh                        edosk7760_defconfig
arm                        mvebu_v5_defconfig
arm                       netwinder_defconfig
mips                     loongson1b_defconfig
arm                             mxs_defconfig
sh                        sh7763rdp_defconfig
riscv                            allmodconfig
sh                           se7705_defconfig
h8300                     edosk2674_defconfig
arm                          pxa910_defconfig
mips                        nlm_xlp_defconfig
arm                        shmobile_defconfig
nds32                             allnoconfig
arm                          exynos_defconfig
microblaze                      mmu_defconfig
arm                        oxnas_v6_defconfig
mips                malta_kvm_guest_defconfig
arm                      footbridge_defconfig
alpha                            allyesconfig
powerpc                        cell_defconfig
arm                         orion5x_defconfig
arc                          axs101_defconfig
arm                          pxa3xx_defconfig
mips                     cu1830-neo_defconfig
arc                        vdk_hs38_defconfig
nds32                               defconfig
c6x                              allyesconfig
xtensa                           allyesconfig
sh                         ap325rxa_defconfig
powerpc                     ep8248e_defconfig
arm                        multi_v5_defconfig
arm                        trizeps4_defconfig
alpha                            alldefconfig
powerpc                  storcenter_defconfig
m68k                           sun3_defconfig
arm                          collie_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210303
i386                 randconfig-a003-20210303
i386                 randconfig-a002-20210303
i386                 randconfig-a004-20210303
i386                 randconfig-a006-20210303
i386                 randconfig-a001-20210303
x86_64               randconfig-a013-20210303
x86_64               randconfig-a016-20210303
x86_64               randconfig-a015-20210303
x86_64               randconfig-a014-20210303
x86_64               randconfig-a012-20210303
x86_64               randconfig-a011-20210303
i386                 randconfig-a016-20210303
i386                 randconfig-a012-20210303
i386                 randconfig-a014-20210303
i386                 randconfig-a013-20210303
i386                 randconfig-a011-20210303
i386                 randconfig-a015-20210303
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210303
x86_64               randconfig-a001-20210303
x86_64               randconfig-a004-20210303
x86_64               randconfig-a002-20210303
x86_64               randconfig-a005-20210303
x86_64               randconfig-a003-20210303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

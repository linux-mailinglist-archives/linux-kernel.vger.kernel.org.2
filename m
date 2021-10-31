Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E63441094
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 20:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhJaTvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 15:51:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:51555 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhJaTvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 15:51:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="217821686"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="217821686"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 12:48:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="488344681"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 31 Oct 2021 12:48:33 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mhGoi-0002kC-Nb; Sun, 31 Oct 2021 19:48:32 +0000
Date:   Mon, 01 Nov 2021 03:48:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 f98a3dccfcb0b9b9c3bef8df9edd61cda80ad937
Message-ID: <617ef2ff.WizD7po+y80VmiFi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: f98a3dccfcb0b9b9c3bef8df9edd61cda80ad937  locking: Remove spin_lock_flags() etc

elapsed time: 1690m

configs tested: 155
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0287_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        m5407c3_defconfig
arc                        nsimosci_defconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
arm                     am200epdkit_defconfig
powerpc                     mpc83xx_defconfig
xtensa                  cadence_csp_defconfig
arm                         axm55xx_defconfig
sparc                       sparc64_defconfig
sh                   sh7770_generic_defconfig
xtensa                           alldefconfig
arm                          pxa168_defconfig
mips                           ci20_defconfig
sh                   secureedge5410_defconfig
arm                            mps2_defconfig
mips                     loongson1b_defconfig
arc                        nsim_700_defconfig
mips                            e55_defconfig
sh                           se7750_defconfig
mips                        workpad_defconfig
powerpc                      ppc64e_defconfig
arm                        keystone_defconfig
mips                        vocore2_defconfig
mips                      maltasmvp_defconfig
xtensa                generic_kc705_defconfig
sh                          rsk7269_defconfig
m68k                       m5208evb_defconfig
sh                        edosk7760_defconfig
s390                             alldefconfig
h8300                     edosk2674_defconfig
powerpc                   lite5200b_defconfig
riscv                    nommu_virt_defconfig
xtensa                              defconfig
riscv                          rv32_defconfig
arm                         hackkit_defconfig
um                             i386_defconfig
arm                           omap1_defconfig
powerpc                    socrates_defconfig
powerpc                     rainier_defconfig
sh                           se7619_defconfig
csky                                defconfig
powerpc                 mpc8313_rdb_defconfig
mips                        omega2p_defconfig
arm                          pcm027_defconfig
arm                        realview_defconfig
sh                         ecovec24_defconfig
arm                        mvebu_v5_defconfig
mips                             allmodconfig
riscv             nommu_k210_sdcard_defconfig
mips                  decstation_64_defconfig
powerpc                      arches_defconfig
xtensa                    smp_lx200_defconfig
powerpc                      katmai_defconfig
powerpc                        warp_defconfig
arm                        oxnas_v6_defconfig
mips                         db1xxx_defconfig
sh                          r7785rp_defconfig
arm                        multi_v5_defconfig
ia64                             alldefconfig
arm                        spear6xx_defconfig
mips                       capcella_defconfig
mips                          ath25_defconfig
m68k                         apollo_defconfig
sh                            titan_defconfig
mips                        maltaup_defconfig
arm                          iop32x_defconfig
mips                   sb1250_swarm_defconfig
arm                             pxa_defconfig
mips                         tb0219_defconfig
arc                                 defconfig
arm                           sama5_defconfig
sh                        sh7763rdp_defconfig
mips                             allyesconfig
arm                             rpc_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20211031
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20211031
i386                 randconfig-a006-20211031
i386                 randconfig-a002-20211031
i386                 randconfig-a005-20211031
i386                 randconfig-a001-20211031
i386                 randconfig-a004-20211031
x86_64               randconfig-a005-20211031
x86_64               randconfig-a004-20211031
x86_64               randconfig-a002-20211031
x86_64               randconfig-a003-20211031
x86_64               randconfig-a001-20211031
x86_64               randconfig-a006-20211031
arc                  randconfig-r043-20211031
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
powerpc              randconfig-c003-20211031
riscv                randconfig-c006-20211031
x86_64               randconfig-c007-20211031
mips                 randconfig-c004-20211031
s390                 randconfig-c005-20211031
arm                  randconfig-c002-20211031
i386                 randconfig-c001-20211031
x86_64               randconfig-a013-20211031
x86_64               randconfig-a015-20211031
x86_64               randconfig-a014-20211031
x86_64               randconfig-a011-20211031
x86_64               randconfig-a016-20211031
x86_64               randconfig-a012-20211031
i386                 randconfig-a013-20211031
i386                 randconfig-a012-20211031
i386                 randconfig-a014-20211031
i386                 randconfig-a015-20211031
i386                 randconfig-a011-20211031
i386                 randconfig-a016-20211031

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

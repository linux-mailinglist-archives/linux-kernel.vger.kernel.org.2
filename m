Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A11375EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 03:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhEGB6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 21:58:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:19934 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234076AbhEGB6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 21:58:32 -0400
IronPort-SDR: i79PeAEOz9OsL/VNlwyJkPdynEXjfcGpeyaJIL+/Qx6r+LSD+tzkQVgsyvPnQFRaVrs50YE2ca
 InQYOZxkgIZQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="259902153"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="259902153"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 18:57:32 -0700
IronPort-SDR: pFpii8y9CMroj9xkQ0TwjlllZ9mcsb/2NkhMBsRbKjLTWQ4lz2eaUNuSdZXVS4CLdthqvUHV8a
 dFY378Odq5Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="431032651"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 May 2021 18:57:30 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lepkA-000AyU-B8; Fri, 07 May 2021 01:57:30 +0000
Date:   Fri, 07 May 2021 09:57:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 e10de314287c2c14b0e6f0e3e961975ce2f4a83d
Message-ID: <60949e87.zdt/zY44OpApar7U%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/urgent
branch HEAD: e10de314287c2c14b0e6f0e3e961975ce2f4a83d  x86/events/amd/iommu: Fix invalid Perf result due to IOMMU PMC power-gating

elapsed time: 725m

configs tested: 150
configs skipped: 67

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
mips                          rb532_defconfig
arm                             ezx_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      maltasmvp_defconfig
ia64                             allmodconfig
arm                         cm_x300_defconfig
arm                         hackkit_defconfig
arm                     eseries_pxa_defconfig
sparc                               defconfig
powerpc                        fsp2_defconfig
arm                            zeus_defconfig
openrisc                  or1klitex_defconfig
arm                        spear6xx_defconfig
powerpc                     ep8248e_defconfig
arm                         orion5x_defconfig
arm                        multi_v7_defconfig
mips                         bigsur_defconfig
arm                           sama5_defconfig
m68k                       m5249evb_defconfig
arm                      integrator_defconfig
sh                      rts7751r2d1_defconfig
mips                     loongson1c_defconfig
sparc64                          alldefconfig
mips                           gcw0_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
sh                   sh7724_generic_defconfig
mips                           jazz_defconfig
m68k                         amcore_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
arm                         nhk8815_defconfig
arm                        shmobile_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                             allyesconfig
powerpc                     redwood_defconfig
mips                      malta_kvm_defconfig
arm                       cns3420vb_defconfig
arm                         mv78xx0_defconfig
sparc                       sparc32_defconfig
arm                          exynos_defconfig
ia64                        generic_defconfig
mips                        bcm47xx_defconfig
m68k                                defconfig
powerpc                    ge_imp3a_defconfig
x86_64                              defconfig
mips                       bmips_be_defconfig
arc                              alldefconfig
m68k                        m5272c3_defconfig
arc                        nsimosci_defconfig
mips                     cu1830-neo_defconfig
arc                            hsdk_defconfig
arm                        realview_defconfig
m68k                       m5275evb_defconfig
arm                       multi_v4t_defconfig
um                               allmodconfig
powerpc                     akebono_defconfig
arm                       aspeed_g5_defconfig
arm                        keystone_defconfig
arm                        mvebu_v7_defconfig
arm                          simpad_defconfig
arm                      jornada720_defconfig
riscv                    nommu_k210_defconfig
sh                           se7751_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                    sam440ep_defconfig
sh                 kfr2r09-romimage_defconfig
mips                         cobalt_defconfig
mips                           ip22_defconfig
arm                              alldefconfig
s390                          debug_defconfig
powerpc                     rainier_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc837x_mds_defconfig
sh                              ul2_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210506
i386                 randconfig-a006-20210506
i386                 randconfig-a001-20210506
i386                 randconfig-a005-20210506
i386                 randconfig-a004-20210506
i386                 randconfig-a002-20210506
x86_64               randconfig-a014-20210506
x86_64               randconfig-a015-20210506
x86_64               randconfig-a012-20210506
x86_64               randconfig-a013-20210506
x86_64               randconfig-a011-20210506
x86_64               randconfig-a016-20210506
i386                 randconfig-a015-20210506
i386                 randconfig-a013-20210506
i386                 randconfig-a016-20210506
i386                 randconfig-a014-20210506
i386                 randconfig-a012-20210506
i386                 randconfig-a011-20210506
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210506
x86_64               randconfig-a003-20210506
x86_64               randconfig-a005-20210506
x86_64               randconfig-a002-20210506
x86_64               randconfig-a006-20210506
x86_64               randconfig-a004-20210506

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

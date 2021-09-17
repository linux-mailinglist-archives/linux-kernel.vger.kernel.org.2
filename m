Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF30840F90B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhIQN13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:27:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:10102 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhIQN12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:27:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="220912666"
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="220912666"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 06:26:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="699488379"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Sep 2021 06:26:04 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mRDsS-0004AA-BE; Fri, 17 Sep 2021 13:26:04 +0000
Date:   Fri, 17 Sep 2021 21:25:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 1c1046581f1a3809e075669a3df0191869d96dd1
Message-ID: <61449751.Th1ytMGwMSvSts6p%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 1c1046581f1a3809e075669a3df0191869d96dd1  x86/setup: Call early_reserve_memory() earlier

elapsed time: 1510m

configs tested: 170
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20210916
sh                          rsk7269_defconfig
riscv                    nommu_virt_defconfig
powerpc                     ep8248e_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                    mvme5100_defconfig
arm                             rpc_defconfig
riscv                               defconfig
um                               alldefconfig
sh                          landisk_defconfig
um                           x86_64_defconfig
arm                        mvebu_v7_defconfig
arc                        nsimosci_defconfig
mips                     loongson1b_defconfig
sh                           se7712_defconfig
powerpc                        warp_defconfig
arm                      integrator_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                          moxart_defconfig
powerpc                        fsp2_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
s390                          debug_defconfig
powerpc                 mpc8272_ads_defconfig
mips                         db1xxx_defconfig
powerpc                     tqm8555_defconfig
arm                          pxa910_defconfig
powerpc                     tqm8541_defconfig
powerpc                     tqm8548_defconfig
powerpc                     kmeter1_defconfig
riscv                          rv32_defconfig
powerpc                    klondike_defconfig
arm                            lart_defconfig
arm                           stm32_defconfig
arm                          ep93xx_defconfig
arm                         vf610m4_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                  mpc885_ads_defconfig
arm                         cm_x300_defconfig
sh                               alldefconfig
m68k                         amcore_defconfig
arm                        oxnas_v6_defconfig
mips                         rt305x_defconfig
arm                       mainstone_defconfig
arm                       cns3420vb_defconfig
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
m68k                       m5275evb_defconfig
mips                        workpad_defconfig
arm                     eseries_pxa_defconfig
sh                           se7343_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         lpc18xx_defconfig
nds32                             allnoconfig
mips                           jazz_defconfig
powerpc                   currituck_defconfig
arm                          imote2_defconfig
ia64                          tiger_defconfig
powerpc                      katmai_defconfig
arm                        mini2440_defconfig
arm                        trizeps4_defconfig
xtensa                  cadence_csp_defconfig
arm                              alldefconfig
powerpc                     powernv_defconfig
mips                          rm200_defconfig
mips                     cu1000-neo_defconfig
xtensa                  audio_kc705_defconfig
xtensa                          iss_defconfig
sh                                  defconfig
x86_64                           allyesconfig
powerpc                  storcenter_defconfig
arm                        keystone_defconfig
arm                             ezx_defconfig
powerpc                      chrp32_defconfig
openrisc                         alldefconfig
m68k                       m5475evb_defconfig
powerpc                     pseries_defconfig
mips                           ip27_defconfig
arm                       imx_v6_v7_defconfig
arm                     am200epdkit_defconfig
m68k                            mac_defconfig
mips                        nlm_xlr_defconfig
h8300                       h8s-sim_defconfig
xtensa                generic_kc705_defconfig
arm                        realview_defconfig
mips                         tb0226_defconfig
powerpc                 canyonlands_defconfig
powerpc                     kilauea_defconfig
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
i386                 randconfig-a016-20210916
i386                 randconfig-a015-20210916
i386                 randconfig-a011-20210916
i386                 randconfig-a012-20210916
i386                 randconfig-a013-20210916
i386                 randconfig-a014-20210916
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210916
x86_64               randconfig-c007-20210916
mips                 randconfig-c004-20210916
powerpc              randconfig-c003-20210916
arm                  randconfig-c002-20210916
i386                 randconfig-c001-20210916
s390                 randconfig-c005-20210916
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916
hexagon              randconfig-r045-20210916
hexagon              randconfig-r041-20210916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

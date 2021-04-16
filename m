Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8DA362C27
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 02:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhDQAAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 20:00:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:21566 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235055AbhDQAAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:00:51 -0400
IronPort-SDR: 4v8g+3ANTPxSSZX1LORF0t+XnO8UnQU+6vUglfd+09e22KwDR/cl+77ASOigYZISds0i7q7vLY
 0FOAJpw+t91A==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="182258476"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="182258476"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 17:00:04 -0700
IronPort-SDR: 8Vphna+LqBWqK0S71fC0pUg+mxqEp2wGu07WLtJGGjAqirTVmATl5RqJgeSLYpmRF+3vxEOTqF
 vcTKjr4uyHew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="400055438"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Apr 2021 17:00:03 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXYNW-0000aj-GG; Sat, 17 Apr 2021 00:00:02 +0000
Date:   Sat, 17 Apr 2021 07:59:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 0b45143b4b9440579e7fa889708cfc4bc7fdb9a3
Message-ID: <607a24fa.FGCePCQ3mk1YZPdJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: 0b45143b4b9440579e7fa889708cfc4bc7fdb9a3  x86/platform/uv: Add more to secondary CPU kdump info

elapsed time: 722m

configs tested: 163
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
powerpc                       ebony_defconfig
powerpc                     ksi8560_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        clps711x_defconfig
arm                         at91_dt_defconfig
arc                      axs103_smp_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                          sdk7786_defconfig
m68k                         amcore_defconfig
m68k                       bvme6000_defconfig
mips                       capcella_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
mips                         bigsur_defconfig
h8300                    h8300h-sim_defconfig
arm                          lpd270_defconfig
arc                        nsimosci_defconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        magician_defconfig
xtensa                       common_defconfig
sh                     magicpanelr2_defconfig
powerpc                      arches_defconfig
arm                        vexpress_defconfig
powerpc                       eiger_defconfig
sh                            hp6xx_defconfig
arm                        trizeps4_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      pcm030_defconfig
sh                          sdk7780_defconfig
arm                       aspeed_g5_defconfig
m68k                        mvme147_defconfig
sh                           se7751_defconfig
arm                            pleb_defconfig
arm                        mini2440_defconfig
sparc                       sparc32_defconfig
mips                           ip22_defconfig
arm                           sama5_defconfig
ia64                        generic_defconfig
csky                                defconfig
mips                           ip32_defconfig
sh                             shx3_defconfig
powerpc                     mpc512x_defconfig
powerpc                       holly_defconfig
um                               alldefconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
arm                        multi_v7_defconfig
arm                         socfpga_defconfig
sh                ecovec24-romimage_defconfig
xtensa                    xip_kc705_defconfig
arm                        spear6xx_defconfig
mips                            e55_defconfig
m68k                          multi_defconfig
m68k                            q40_defconfig
arc                         haps_hs_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc8315_rdb_defconfig
sparc                       sparc64_defconfig
sh                        sh7757lcr_defconfig
arm                              alldefconfig
powerpc                    ge_imp3a_defconfig
powerpc                     powernv_defconfig
sh                             espt_defconfig
powerpc                     taishan_defconfig
arm                          iop32x_defconfig
powerpc                        cell_defconfig
powerpc                 canyonlands_defconfig
sh                        sh7785lcr_defconfig
mips                malta_kvm_guest_defconfig
m68k                         apollo_defconfig
ia64                         bigsur_defconfig
h8300                               defconfig
h8300                            alldefconfig
s390                          debug_defconfig
openrisc                  or1klitex_defconfig
arm64                            alldefconfig
sh                          r7785rp_defconfig
powerpc                          g5_defconfig
mips                        maltaup_defconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210416
i386                 randconfig-a006-20210416
i386                 randconfig-a001-20210416
i386                 randconfig-a005-20210416
i386                 randconfig-a004-20210416
i386                 randconfig-a002-20210416
x86_64               randconfig-a014-20210416
x86_64               randconfig-a015-20210416
x86_64               randconfig-a011-20210416
x86_64               randconfig-a013-20210416
x86_64               randconfig-a012-20210416
x86_64               randconfig-a016-20210416
i386                 randconfig-a015-20210416
i386                 randconfig-a014-20210416
i386                 randconfig-a013-20210416
i386                 randconfig-a012-20210416
i386                 randconfig-a016-20210416
i386                 randconfig-a011-20210416
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210416
x86_64               randconfig-a002-20210416
x86_64               randconfig-a005-20210416
x86_64               randconfig-a001-20210416
x86_64               randconfig-a006-20210416
x86_64               randconfig-a004-20210416

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

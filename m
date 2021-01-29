Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1030855E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 06:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhA2FzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 00:55:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:58467 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhA2FzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 00:55:08 -0500
IronPort-SDR: 3XwgFbjJ++7a1ZI/Yf8i4gPZPWwFGX+cBJ8zP8+NrYbxNlBhCd8tAgPBtf+fae6DJINHZcvbcR
 TWd7MB7BzD8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="168038957"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="168038957"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 21:54:27 -0800
IronPort-SDR: ccH3zmb5QTBRurnREJRsnMMBdKhcTyowPB5qT4O0I5lizW8+SgOJLs1RLWCTk3V/GioYd+OHRq
 qzO9Q8OAafZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="403814496"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2021 21:54:25 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5Mjh-0003XP-9u; Fri, 29 Jan 2021 05:54:25 +0000
Date:   Fri, 29 Jan 2021 13:54:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 fb35d30fe5b06cc24444f0405da8fbe0be5330d1
Message-ID: <6013a306.Vx/Qn62PIc8jxXWF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: fb35d30fe5b06cc24444f0405da8fbe0be5330d1  x86/cpufeatures: Assign dedicated feature word for CPUID_0x8000001F[EAX]

elapsed time: 724m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                         ps3_defconfig
arm                          pxa3xx_defconfig
riscv                    nommu_virt_defconfig
m68k                           sun3_defconfig
mips                malta_kvm_guest_defconfig
nds32                               defconfig
arm                       imx_v6_v7_defconfig
powerpc                     pseries_defconfig
sparc64                             defconfig
powerpc                     tqm8540_defconfig
arm                     eseries_pxa_defconfig
arm                            pleb_defconfig
powerpc                     rainier_defconfig
arm                          badge4_defconfig
arm                        spear3xx_defconfig
powerpc64                           defconfig
mips                         db1xxx_defconfig
arm                           stm32_defconfig
m68k                       bvme6000_defconfig
ia64                            zx1_defconfig
mips                           ip28_defconfig
powerpc                    ge_imp3a_defconfig
mips                     cu1830-neo_defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
mips                  decstation_64_defconfig
sh                          kfr2r09_defconfig
ia64                                defconfig
mips                       bmips_be_defconfig
powerpc                 mpc837x_mds_defconfig
mips                      maltasmvp_defconfig
arm                          simpad_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        shmobile_defconfig
arm                           u8500_defconfig
powerpc                     akebono_defconfig
sh                           se7751_defconfig
sh                             espt_defconfig
m68k                        stmark2_defconfig
arm                         socfpga_defconfig
nios2                            allyesconfig
arm                        keystone_defconfig
arm                        magician_defconfig
m68k                        m5307c3_defconfig
arm                           h3600_defconfig
arc                        nsimosci_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a001-20210128
i386                 randconfig-a002-20210128
i386                 randconfig-a004-20210128
i386                 randconfig-a005-20210128
i386                 randconfig-a003-20210128
i386                 randconfig-a006-20210128
x86_64               randconfig-a012-20210128
x86_64               randconfig-a015-20210128
x86_64               randconfig-a016-20210128
x86_64               randconfig-a011-20210128
x86_64               randconfig-a013-20210128
x86_64               randconfig-a014-20210128
i386                 randconfig-a013-20210128
i386                 randconfig-a011-20210128
i386                 randconfig-a012-20210128
i386                 randconfig-a016-20210128
i386                 randconfig-a014-20210128
i386                 randconfig-a015-20210128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210128
x86_64               randconfig-a003-20210128
x86_64               randconfig-a001-20210128
x86_64               randconfig-a005-20210128
x86_64               randconfig-a006-20210128
x86_64               randconfig-a004-20210128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

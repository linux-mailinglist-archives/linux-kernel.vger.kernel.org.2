Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FAD37F39A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhEMHj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:39:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:12054 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230443AbhEMHjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:39:23 -0400
IronPort-SDR: wrf6HB7z9Lh6LZbHr+D8WcWiW81DJmuj4jOuTEvZ8/Cqj8DxnbeoWgsk3+97bC2gnZcy1EW77p
 t+jRPLqQ+AmQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="199946309"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="199946309"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 00:38:12 -0700
IronPort-SDR: h054T5oskAPSIwTYyuDJVcIFklKSbpXD8Cad4UFUk9sqBlV7Pj5gvLztJgQIQsRPHm5omOynCG
 61LZXNgHSdrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="456140338"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 May 2021 00:38:10 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lh5v8-00008b-9D; Thu, 13 May 2021 07:38:10 +0000
Date:   Thu, 13 May 2021 15:37:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 f66c05d6baf36069c01a02f869bebb75586f2318
Message-ID: <609cd733.RV1JsbYJVYDno0kI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: f66c05d6baf36069c01a02f869bebb75586f2318  objtool/x86: Fix elf_add_alternative() endianness

elapsed time: 726m

configs tested: 148
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      mgcoge_defconfig
powerpc                   lite5200b_defconfig
sparc64                          alldefconfig
arm                       imx_v6_v7_defconfig
mips                          rm200_defconfig
riscv                             allnoconfig
mips                         tb0226_defconfig
m68k                          multi_defconfig
arm                         nhk8815_defconfig
sparc64                             defconfig
powerpc                     tqm8555_defconfig
arm                         vf610m4_defconfig
nds32                               defconfig
arc                     haps_hs_smp_defconfig
powerpc                      cm5200_defconfig
powerpc                      katmai_defconfig
sh                          lboxre2_defconfig
arm                           h5000_defconfig
h8300                               defconfig
powerpc                     tqm8541_defconfig
powerpc                    socrates_defconfig
mips                       rbtx49xx_defconfig
xtensa                generic_kc705_defconfig
arm                            lart_defconfig
mips                             allyesconfig
parisc                generic-64bit_defconfig
arm                          simpad_defconfig
powerpc                     powernv_defconfig
sparc                       sparc64_defconfig
m68k                            mac_defconfig
powerpc                     kmeter1_defconfig
nios2                         3c120_defconfig
arc                              allyesconfig
arm                      tct_hammer_defconfig
sh                         apsh4a3a_defconfig
mips                       bmips_be_defconfig
m68k                        mvme147_defconfig
mips                  decstation_64_defconfig
mips                           gcw0_defconfig
arm                          ixp4xx_defconfig
sh                        sh7785lcr_defconfig
mips                           ci20_defconfig
mips                           ip27_defconfig
sh                           se7751_defconfig
arm                       spear13xx_defconfig
arc                          axs103_defconfig
sh                           se7722_defconfig
sh                          polaris_defconfig
alpha                               defconfig
arm                         assabet_defconfig
mips                        bcm47xx_defconfig
arm                       mainstone_defconfig
arm                             mxs_defconfig
arc                         haps_hs_defconfig
sparc                       sparc32_defconfig
x86_64                           allyesconfig
sh                           se7343_defconfig
mips                      maltasmvp_defconfig
mips                         tb0219_defconfig
arm                         palmz72_defconfig
arm                          pxa910_defconfig
powerpc                 mpc836x_mds_defconfig
i386                             alldefconfig
sh                         ap325rxa_defconfig
sh                          sdk7780_defconfig
mips                           xway_defconfig
arm                         s5pv210_defconfig
powerpc                     mpc83xx_defconfig
ia64                          tiger_defconfig
powerpc                       holly_defconfig
arm                   milbeaut_m10v_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
i386                 randconfig-a006-20210513
x86_64               randconfig-a012-20210513
x86_64               randconfig-a015-20210513
x86_64               randconfig-a011-20210513
x86_64               randconfig-a013-20210513
x86_64               randconfig-a016-20210513
x86_64               randconfig-a014-20210513
i386                 randconfig-a016-20210513
i386                 randconfig-a014-20210513
i386                 randconfig-a011-20210513
i386                 randconfig-a015-20210513
i386                 randconfig-a012-20210513
i386                 randconfig-a013-20210513
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
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
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

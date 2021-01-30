Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3896F3090D9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 01:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhA3AKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 19:10:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:20313 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232062AbhA3AKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 19:10:23 -0500
IronPort-SDR: XLm8G1ol8A+4gDilW88R2u320xD3YbTXK1OQ+IjE1JMq76thwplwOYsi9i/TIpT2ovggk2JL8a
 bDFRV8HFc7XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="177937915"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="177937915"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:09:36 -0800
IronPort-SDR: lnAP9u7aDsrEfNyV7WOrsh76wYB+HC1HxEvGUp/DKR21INU0FxvH+edDhQHiJhV5C5uAtisnRZ
 SIFbLIZoluKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="574277282"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 29 Jan 2021 16:09:34 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5dpV-000499-Ey; Sat, 30 Jan 2021 00:09:33 +0000
Date:   Sat, 30 Jan 2021 08:08:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 0a74d61c7d842b583f33f74d7a9e93201826f4c5
Message-ID: <6014a390.DF7ueIs7zT/b72Pf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 0a74d61c7d842b583f33f74d7a9e93201826f4c5  x86/fpu/xstate: Use sizeof() instead of a constant

elapsed time: 725m

configs tested: 103
configs skipped: 29

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           gcw0_defconfig
mips                         tb0219_defconfig
s390                             allyesconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
ia64                            zx1_defconfig
powerpc                      chrp32_defconfig
mips                     loongson1c_defconfig
sh                   secureedge5410_defconfig
powerpc                     sbc8548_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                      bamboo_defconfig
sparc                       sparc64_defconfig
c6x                        evmc6472_defconfig
arm                      integrator_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7780_defconfig
sh                          polaris_defconfig
sh                ecovec24-romimage_defconfig
mips                      bmips_stb_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
mips                         tb0226_defconfig
powerpc                     powernv_defconfig
m68k                       m5475evb_defconfig
arm                          ixp4xx_defconfig
arm                          collie_defconfig
openrisc                    or1ksim_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210129
i386                 randconfig-a002-20210129
i386                 randconfig-a004-20210129
i386                 randconfig-a005-20210129
i386                 randconfig-a003-20210129
i386                 randconfig-a006-20210129
i386                 randconfig-a013-20210129
i386                 randconfig-a011-20210129
i386                 randconfig-a012-20210129
i386                 randconfig-a016-20210129
i386                 randconfig-a014-20210129
i386                 randconfig-a015-20210129
x86_64               randconfig-a002-20210129
x86_64               randconfig-a003-20210129
x86_64               randconfig-a001-20210129
x86_64               randconfig-a005-20210129
x86_64               randconfig-a006-20210129
x86_64               randconfig-a004-20210129
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a012-20210129
x86_64               randconfig-a015-20210129
x86_64               randconfig-a016-20210129
x86_64               randconfig-a011-20210129
x86_64               randconfig-a013-20210129
x86_64               randconfig-a014-20210129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

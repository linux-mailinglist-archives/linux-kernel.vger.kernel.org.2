Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9922D351019
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhDAHbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:31:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:10004 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233371AbhDAHbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:31:34 -0400
IronPort-SDR: FYfRS/rOy3b7UFY6sWYSmr+t7re3V4kIggSYRZ1jvrvlbwHf+5Pj2Pqt/cWJtMvE9qQLLSfW3J
 gAT0bNiKsNqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192198437"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192198437"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 00:31:30 -0700
IronPort-SDR: Tdg5L3w7UTYkXJXRhFtTTdqAh2UxD8bFBcsE8EE7GySm5X52cXhiu6mYKd3rKN95FHk9vzKH5H
 KCEmuF8/0jhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="416557583"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Apr 2021 00:31:29 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRrnc-0006Le-Oz; Thu, 01 Apr 2021 07:31:28 +0000
Date:   Thu, 01 Apr 2021 15:30:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD REGRESSION
 a0af5201360a0e33399d2b65b3874c27ac29432b
Message-ID: <60657693.IXofALejSEQRK+yC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a0af5201360a0e33399d2b65b3874c27ac29432b  Merge branch 'linus'

possible Error/Warning in current branch:

arch/x86/net/bpf_jit_comp.c:2015:16: error: 'ideal_nops' undeclared (first use in this function)
arch/x86/net/bpf_jit_comp.c:2015:16: error: use of undeclared identifier 'ideal_nops'
arch/x86/net/bpf_jit_comp.c:2015:27: error: 'NOP_ATOMIC5' undeclared (first use in this function); did you mean 'GFP_ATOMIC'?
arch/x86/net/bpf_jit_comp.c:2015:27: error: use of undeclared identifier 'NOP_ATOMIC5'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- x86_64-rhel-8.3-kbuiltin
|   |-- arch-x86-net-bpf_jit_comp.c:error:NOP_ATOMIC5-undeclared-(first-use-in-this-function)
|   `-- arch-x86-net-bpf_jit_comp.c:error:ideal_nops-undeclared-(first-use-in-this-function)
`-- x86_64-rhel-8.3-kselftests
    |-- arch-x86-net-bpf_jit_comp.c:error:NOP_ATOMIC5-undeclared-(first-use-in-this-function)
    `-- arch-x86-net-bpf_jit_comp.c:error:ideal_nops-undeclared-(first-use-in-this-function)

clang_recent_errors
`-- x86_64-randconfig-a016-20210330
    |-- arch-x86-net-bpf_jit_comp.c:error:use-of-undeclared-identifier-NOP_ATOMIC5
    `-- arch-x86-net-bpf_jit_comp.c:error:use-of-undeclared-identifier-ideal_nops

elapsed time: 724m

configs tested: 107
configs skipped: 2

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
sh                          rsk7264_defconfig
sh                             espt_defconfig
powerpc                      ppc6xx_defconfig
arm                          simpad_defconfig
powerpc                    mvme5100_defconfig
arc                            hsdk_defconfig
sparc                       sparc64_defconfig
powerpc                     ksi8560_defconfig
sh                          rsk7201_defconfig
powerpc                       ebony_defconfig
arm                           stm32_defconfig
sh                ecovec24-romimage_defconfig
arm                          pcm027_defconfig
sh                            shmin_defconfig
riscv                             allnoconfig
mips                          ath25_defconfig
powerpc                     ppa8548_defconfig
mips                           gcw0_defconfig
powerpc                        fsp2_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
mips                        jmr3927_defconfig
powerpc                     sequoia_defconfig
powerpc                        cell_defconfig
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
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

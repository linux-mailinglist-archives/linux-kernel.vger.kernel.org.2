Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D322645DA34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354655AbhKYMlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:41:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:4086 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352314AbhKYMjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:39:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235329862"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235329862"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 04:30:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="475629448"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 25 Nov 2021 04:30:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqDtb-0006LM-6T; Thu, 25 Nov 2021 12:30:35 +0000
Date:   Thu, 25 Nov 2021 20:30:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD REGRESSION
 3297481d688a5cc2973ea58bd78e66b8639748b1
Message-ID: <619f81c9.6/xwdTcZcEe7c0nC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 3297481d688a5cc2973ea58bd78e66b8639748b1  futex: Remove futex_cmpxchg detection

possible Error/Warning in current branch (please contact us if interested):

include/asm-generic/futex.h:17:9: error: implicit declaration of function 'futex_atomic_cmpxchg_inatomic_local_generic'; did you mean 'futex_atomic_cmpxchg_inatomic_local'? [-Werror=implicit-function-declaration]
include/asm-generic/futex.h:19:9: error: implicit declaration of function 'arch_futex_atomic_op_inuser_local_generic'; did you mean 'futex_atomic_op_inuser_local'? [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- h8300-allyesconfig
|   |-- include-asm-generic-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local_generic
|   `-- include-asm-generic-futex.h:error:implicit-declaration-of-function-futex_atomic_cmpxchg_inatomic_local_generic
|-- h8300-buildonly-randconfig-r001-20211125
|   |-- include-asm-generic-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local_generic
|   `-- include-asm-generic-futex.h:error:implicit-declaration-of-function-futex_atomic_cmpxchg_inatomic_local_generic
|-- m68k-allmodconfig
|   |-- include-asm-generic-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local_generic
|   `-- include-asm-generic-futex.h:error:implicit-declaration-of-function-futex_atomic_cmpxchg_inatomic_local_generic
|-- m68k-allyesconfig
|   |-- include-asm-generic-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local_generic
|   `-- include-asm-generic-futex.h:error:implicit-declaration-of-function-futex_atomic_cmpxchg_inatomic_local_generic
|-- m68k-defconfig
|   |-- include-asm-generic-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local_generic
|   `-- include-asm-generic-futex.h:error:implicit-declaration-of-function-futex_atomic_cmpxchg_inatomic_local_generic
|-- m68k-randconfig-c003-20211125
|   |-- include-asm-generic-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local_generic
|   `-- include-asm-generic-futex.h:error:implicit-declaration-of-function-futex_atomic_cmpxchg_inatomic_local_generic
|-- nios2-allyesconfig
|   |-- include-asm-generic-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local_generic
|   `-- include-asm-generic-futex.h:error:implicit-declaration-of-function-futex_atomic_cmpxchg_inatomic_local_generic
|-- nios2-defconfig
|   |-- include-asm-generic-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local_generic
|   `-- include-asm-generic-futex.h:error:implicit-declaration-of-function-futex_atomic_cmpxchg_inatomic_local_generic
|-- nios2-randconfig-c023-20211125
|   |-- include-asm-generic-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local_generic
|   `-- include-asm-generic-futex.h:error:implicit-declaration-of-function-futex_atomic_cmpxchg_inatomic_local_generic
`-- sparc-defconfig
    |-- include-asm-generic-futex.h:error:implicit-declaration-of-function-arch_futex_atomic_op_inuser_local_generic
    `-- include-asm-generic-futex.h:error:implicit-declaration-of-function-futex_atomic_cmpxchg_inatomic_local_generic

elapsed time: 721m

configs tested: 54
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211125
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
nds32                               defconfig
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
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

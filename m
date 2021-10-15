Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6EF42EEF8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhJOKmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:42:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:9749 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhJOKmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:42:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="227784963"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="227784963"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 03:40:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="660479009"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2021 03:40:29 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbKdZ-0007j3-5p; Fri, 15 Oct 2021 10:40:29 +0000
Date:   Fri, 15 Oct 2021 18:39:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/cast-function] BUILD REGRESSION
 21078041965eb5a2e83d296690a93243611a3c27
Message-ID: <61695a68.dTkSxVbzWHsyzpFH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/cast-function
branch HEAD: 21078041965eb5a2e83d296690a93243611a3c27  Makefile: Enable -Wcast-function-type

Error/Warning in current branch:

include/linux/ftrace.h:49:41: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
include/linux/ftrace.h:49:62: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
kernel/trace/ftrace.c:7029:6: error: conflicting types for 'arch_ftrace_ops_list_func'

possible Error/Warning in current branch (please contact us if interested):

kernel/bpf/hashtab.c:671:26: warning: cast from 'void *(*)(struct bpf_map *, void *)' to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12472:16: warning: cast from 'unsigned int (*)(const void *, const struct bpf_insn *)' to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12953:17: warning: cast from 'void *(*)(struct bpf_map *, void *)' to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12957:17: warning: cast from 'int (*)(struct bpf_map *, void *, void *, u64)' (aka 'int (*)(struct bpf_map *, void *, void *, unsigned long long)') to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12961:17: warning: cast from 'int (*)(struct bpf_map *, void *)' to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12965:17: warning: cast from 'int (*)(struct bpf_map *, void *, u64)' (aka 'int (*)(struct bpf_map *, void *, unsigned long long)') to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]
kernel/bpf/verifier.c:12977:17: warning: cast from 'int (*)(struct bpf_map *, u32, u64)' (aka 'int (*)(struct bpf_map *, unsigned int, unsigned long long)') to 'u64 (*)(u64, u64, u64, u64, u64)' (aka 'unsigned long long (*)(unsigned long long, unsigned long long, unsigned long long, unsigned long long, unsigned long long)') converts to incompatible function type [-Wcast-function-type]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-debian-10.3
|   `-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-a001-20211014
|   |-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- kernel-trace-ftrace.c:error:conflicting-types-for-arch_ftrace_ops_list_func
|-- i386-randconfig-a005-20211014
|   |-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- kernel-trace-ftrace.c:error:conflicting-types-for-arch_ftrace_ops_list_func
|-- i386-randconfig-c001-20211014
|   `-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-c021-20211014
|   `-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-c023-20211014
|   `-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-r001-20211014
|   |-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- kernel-trace-ftrace.c:error:conflicting-types-for-arch_ftrace_ops_list_func
|-- i386-randconfig-r035-20211014
|   |-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- kernel-trace-ftrace.c:error:conflicting-types-for-arch_ftrace_ops_list_func
|-- i386-randconfig-s001-20211014
|   `-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- i386-randconfig-s002-20211014
|   `-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- parisc-allyesconfig
|   `-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- riscv-randconfig-r034-20211014
|   `-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
`-- s390-randconfig-r032-20211014
    `-- include-linux-ftrace.h:warning:struct-ftrace_regs-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration

clang_recent_errors
|-- hexagon-randconfig-r041-20211014
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
|-- hexagon-randconfig-r045-20211014
|   |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
|   |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
|   |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
|   `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon
`-- riscv-randconfig-r042-20211014
    |-- kernel-bpf-hashtab.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
    |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-u32-u64)-(aka-int-(-)(struct-bpf_map-unsigned-int-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsig
    |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-long
    |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-u64)-(aka-int-(-)(struct-bpf_map-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-lon
    |-- kernel-bpf-verifier.c:warning:cast-from-int-(-)(struct-bpf_map-void-void-u64)-(aka-int-(-)(struct-bpf_map-void-void-unsigned-long-long)-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(un
    |-- kernel-bpf-verifier.c:warning:cast-from-unsigned-int-(-)(const-void-const-struct-bpf_insn-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-l
    `-- kernel-bpf-verifier.c:warning:cast-from-void-(-)(struct-bpf_map-void-)-to-u64-(-)(u64-u64-u64-u64-u64)-(aka-unsigned-long-long-(-)(unsigned-long-long-unsigned-long-long-unsigned-long-long-unsigned-lon

elapsed time: 841m

configs tested: 115
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211014
sh                          polaris_defconfig
powerpc                     rainier_defconfig
arm                             ezx_defconfig
s390                             alldefconfig
mips                 decstation_r4k_defconfig
arm                          collie_defconfig
s390                       zfcpdump_defconfig
mips                        qi_lb60_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     tqm8560_defconfig
xtensa                         virt_defconfig
mips                         bigsur_defconfig
arc                              alldefconfig
riscv                    nommu_k210_defconfig
sh                           se7206_defconfig
sh                           se7722_defconfig
arm                         s3c6400_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
powerpc                     tqm8541_defconfig
nios2                         3c120_defconfig
mips                      fuloong2e_defconfig
powerpc                   lite5200b_defconfig
powerpc                        warp_defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        vexpress_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                  randconfig-c002-20211014
x86_64               randconfig-c001-20211014
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211014
x86_64               randconfig-a004-20211014
x86_64               randconfig-a001-20211014
x86_64               randconfig-a005-20211014
x86_64               randconfig-a002-20211014
x86_64               randconfig-a003-20211014
i386                 randconfig-a003-20211014
i386                 randconfig-a001-20211014
i386                 randconfig-a005-20211014
i386                 randconfig-a004-20211014
i386                 randconfig-a002-20211014
i386                 randconfig-a006-20211014
arc                  randconfig-r043-20211014
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211014
i386                 randconfig-c001-20211014
s390                 randconfig-c005-20211014
x86_64               randconfig-c007-20211014
powerpc              randconfig-c003-20211014
riscv                randconfig-c006-20211014
x86_64               randconfig-a012-20211014
x86_64               randconfig-a015-20211014
x86_64               randconfig-a016-20211014
x86_64               randconfig-a014-20211014
x86_64               randconfig-a011-20211014
x86_64               randconfig-a013-20211014
i386                 randconfig-a016-20211014
i386                 randconfig-a014-20211014
i386                 randconfig-a011-20211014
i386                 randconfig-a015-20211014
i386                 randconfig-a012-20211014
i386                 randconfig-a013-20211014
hexagon              randconfig-r041-20211014
s390                 randconfig-r044-20211014
riscv                randconfig-r042-20211014
hexagon              randconfig-r045-20211014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

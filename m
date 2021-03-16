Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE2A33CDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhCPGHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:07:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:59707 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232758AbhCPGHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:07:03 -0400
IronPort-SDR: A5h4EWnHrtQImweDR5dVCF10H9Vt0nh+aRtOU4upV1pdL7iRwFLB5V8L9cd90ttebmZULI4RpO
 JqzvI+vpJaWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="188566542"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="188566542"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 23:07:02 -0700
IronPort-SDR: 0pW2axrl9/64iVIxB+a18pXTTtwt35AKPGfce7WeB/RttvfFIR+aPnexhDysI4x3ysOZ29aqHy
 RCP1c1Z2whbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="522396371"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2021 23:07:01 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lM2r6-00001N-TM; Tue, 16 Mar 2021 06:07:00 +0000
Date:   Tue, 16 Mar 2021 14:06:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS WITH WARNING
 301cddc21a157a3072d789a3097857202e550a24
Message-ID: <60504ad7.XwOc1tp4b8vMwg3W%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 301cddc21a157a3072d789a3097857202e550a24  objtool/x86: Use asm/nops.h

Warning reports:

https://lore.kernel.org/lkml/202103160701.3uXlWiWM-lkp@intel.com

Warning in current branch:

arch/x86/kernel/alternative.c:96:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+10' is out of bounds. [pointerOutOfBounds]
arch/x86/kernel/ftrace.c:304:7: warning: union member 'ftrace_op_code_union::code' is never used. [unusedStructMember]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-p002-20210315
    |-- arch-x86-kernel-alternative.c:warning:Undefined-behaviour-pointer-arithmetic-x86nops-is-out-of-bounds.-pointerOutOfBounds
    `-- arch-x86-kernel-ftrace.c:warning:union-member-ftrace_op_code_union::code-is-never-used.-unusedStructMember

elapsed time: 723m

configs tested: 135
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
mips                      malta_kvm_defconfig
arm                          exynos_defconfig
ia64                         bigsur_defconfig
arm                            dove_defconfig
arm                       mainstone_defconfig
m68k                        mvme16x_defconfig
arm                         mv78xx0_defconfig
mips                       rbtx49xx_defconfig
h8300                    h8300h-sim_defconfig
h8300                               defconfig
arm                            zeus_defconfig
powerpc                    socrates_defconfig
arc                           tb10x_defconfig
powerpc                      chrp32_defconfig
openrisc                         alldefconfig
arm                     am200epdkit_defconfig
arm                         palmz72_defconfig
arm                       versatile_defconfig
openrisc                 simple_smp_defconfig
arm                        realview_defconfig
s390                             alldefconfig
powerpc                     stx_gp3_defconfig
mips                malta_kvm_guest_defconfig
sh                         ap325rxa_defconfig
mips                     cu1000-neo_defconfig
mips                           xway_defconfig
arm                         lpc32xx_defconfig
sh                            shmin_defconfig
mips                           ip32_defconfig
parisc                           alldefconfig
ia64                                defconfig
sh                           se7712_defconfig
arm                         lubbock_defconfig
x86_64                              defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      tqm8xx_defconfig
xtensa                         virt_defconfig
sh                           se7722_defconfig
arm                     eseries_pxa_defconfig
m68k                       bvme6000_defconfig
powerpc                     rainier_defconfig
parisc                generic-32bit_defconfig
arm                        mini2440_defconfig
i386                                defconfig
mips                         rt305x_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     mpc512x_defconfig
ia64                             alldefconfig
csky                                defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      cm5200_defconfig
arm                            xcep_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                   motionpro_defconfig
arm                           h3600_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          g5_defconfig
arm                         orion5x_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      arches_defconfig
arm                          pcm027_defconfig
xtensa                           alldefconfig
mips                          ath79_defconfig
mips                       lemote2f_defconfig
ia64                             allmodconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210315
x86_64               randconfig-a001-20210315
x86_64               randconfig-a005-20210315
x86_64               randconfig-a004-20210315
x86_64               randconfig-a002-20210315
x86_64               randconfig-a003-20210315
i386                 randconfig-a001-20210315
i386                 randconfig-a005-20210315
i386                 randconfig-a003-20210315
i386                 randconfig-a002-20210315
i386                 randconfig-a004-20210315
i386                 randconfig-a006-20210315
i386                 randconfig-a013-20210315
i386                 randconfig-a016-20210315
i386                 randconfig-a011-20210315
i386                 randconfig-a012-20210315
i386                 randconfig-a014-20210315
i386                 randconfig-a015-20210315
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210315
x86_64               randconfig-a016-20210315
x86_64               randconfig-a013-20210315
x86_64               randconfig-a015-20210315
x86_64               randconfig-a014-20210315
x86_64               randconfig-a012-20210315

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

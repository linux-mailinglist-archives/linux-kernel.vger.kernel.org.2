Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2919D37F1B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhEMDfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:35:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:25906 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhEMDfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:35:33 -0400
IronPort-SDR: owwGcxQbekFJxRNJEoLCkFPY0kbaUeL8J5iWg3bCeoOtsry4tf3ym0b7RM7zsdIOZ1TAuQMqNp
 HCMU4TxRWNvg==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="199916767"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="199916767"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 20:34:05 -0700
IronPort-SDR: XQ8ft79zDk86rfuHKUf/7QTRhcxqW/rhCubE51EognYXbFaF7WCjtstydCfhbQpf5F8PyCoEKk
 8Xl/Mo5vzj5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="542328994"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2021 20:34:04 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lh26t-00005I-Ow; Thu, 13 May 2021 03:34:03 +0000
Date:   Thu, 13 May 2021 11:33:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 9ddcb87b9218dec760e8d8a780bc8ad514c3d36a
Message-ID: <609c9e21.uOZVFUiWRXMzoiIe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/asm
branch HEAD: 9ddcb87b9218dec760e8d8a780bc8ad514c3d36a  x86/regs: Syscall_get_nr() returns -1 for a non-system call

elapsed time: 1075m

configs tested: 116
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    sam440ep_defconfig
arm                       mainstone_defconfig
mips                           jazz_defconfig
powerpc                        warp_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    socrates_defconfig
arm                         s5pv210_defconfig
arm                        magician_defconfig
arm                         mv78xx0_defconfig
mips                        workpad_defconfig
arm                         bcm2835_defconfig
x86_64                           allyesconfig
arm                        spear6xx_defconfig
sh                          rsk7203_defconfig
powerpc                    klondike_defconfig
powerpc                     sequoia_defconfig
arm                            dove_defconfig
mips                      maltasmvp_defconfig
mips                        nlm_xlp_defconfig
arc                      axs103_smp_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     asp8347_defconfig
powerpc                     tqm8560_defconfig
arm                          pxa910_defconfig
mips                           ip27_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        keystone_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      tqm8xx_defconfig
mips                      bmips_stb_defconfig
arm                            xcep_defconfig
arm                        vexpress_defconfig
sh                         ecovec24_defconfig
mips                  cavium_octeon_defconfig
openrisc                    or1ksim_defconfig
powerpc                         ps3_defconfig
powerpc                      chrp32_defconfig
sh                           se7343_defconfig
x86_64                            allnoconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210512
x86_64               randconfig-a004-20210512
x86_64               randconfig-a001-20210512
x86_64               randconfig-a005-20210512
x86_64               randconfig-a002-20210512
x86_64               randconfig-a006-20210512
i386                 randconfig-a003-20210512
i386                 randconfig-a001-20210512
i386                 randconfig-a005-20210512
i386                 randconfig-a004-20210512
i386                 randconfig-a002-20210512
i386                 randconfig-a006-20210512
i386                 randconfig-a016-20210512
i386                 randconfig-a014-20210512
i386                 randconfig-a011-20210512
i386                 randconfig-a015-20210512
i386                 randconfig-a012-20210512
i386                 randconfig-a013-20210512
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
x86_64               randconfig-a015-20210512
x86_64               randconfig-a012-20210512
x86_64               randconfig-a011-20210512
x86_64               randconfig-a013-20210512
x86_64               randconfig-a016-20210512
x86_64               randconfig-a014-20210512

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

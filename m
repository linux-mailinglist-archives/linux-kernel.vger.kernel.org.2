Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0819531D4AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 05:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhBQEj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 23:39:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:22493 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhBQEh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 23:37:27 -0500
IronPort-SDR: wMWPiHPZO64ngmvTBMQB2THa4/bxH080XZ8GcAADkjE04rL9XSRlUU8RZ6U3RcI7Zw18+Ftx04
 31AOVANz0y4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="183231464"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="183231464"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 20:36:16 -0800
IronPort-SDR: 7mhsnJ+GgrsaWTDIG5Ygst2S2FsXqpX7tIYQ0V9Dw5wtMzNtvd4eMYgmk+Cfnu9glag4lnhBuu
 UAymFM1/nofw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="364337504"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2021 20:36:15 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lCEZS-0008hu-F7; Wed, 17 Feb 2021 04:36:14 +0000
Date:   Wed, 17 Feb 2021 12:35:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 3aac798a917be3b8f2f647b834bb06bf2f8df4f1
Message-ID: <602c9d18.otep89HBThs4QI54%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
branch HEAD: 3aac798a917be3b8f2f647b834bb06bf2f8df4f1  um: Enforce the usage of asm-generic/softirq_stack.h

elapsed time: 725m

configs tested: 122
configs skipped: 117

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7780mp_defconfig
powerpc                       ebony_defconfig
m68k                       m5249evb_defconfig
powerpc                    klondike_defconfig
arm                           stm32_defconfig
m68k                        m5272c3_defconfig
arc                     haps_hs_smp_defconfig
powerpc                      walnut_defconfig
sh                        edosk7760_defconfig
arm                      footbridge_defconfig
sh                          rsk7264_defconfig
nds32                             allnoconfig
powerpc                   lite5200b_defconfig
powerpc                     mpc83xx_defconfig
arm                              alldefconfig
xtensa                           allyesconfig
mips                         tb0287_defconfig
arm                     eseries_pxa_defconfig
arm                             rpc_defconfig
powerpc                     sbc8548_defconfig
sh                        apsh4ad0a_defconfig
m68k                          hp300_defconfig
ia64                                defconfig
powerpc                      ppc64e_defconfig
sh                            shmin_defconfig
mips                         cobalt_defconfig
xtensa                  cadence_csp_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc832x_mds_defconfig
um                            kunit_defconfig
mips                           ci20_defconfig
mips                      maltaaprp_defconfig
mips                  cavium_octeon_defconfig
mips                      fuloong2e_defconfig
arc                              alldefconfig
arm                            mps2_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210216
x86_64               randconfig-a002-20210216
x86_64               randconfig-a004-20210216
x86_64               randconfig-a001-20210216
x86_64               randconfig-a005-20210216
x86_64               randconfig-a006-20210216
i386                 randconfig-a003-20210216
i386                 randconfig-a005-20210216
i386                 randconfig-a002-20210216
i386                 randconfig-a006-20210216
i386                 randconfig-a001-20210216
i386                 randconfig-a004-20210216
x86_64               randconfig-a016-20210215
x86_64               randconfig-a013-20210215
x86_64               randconfig-a012-20210215
x86_64               randconfig-a015-20210215
x86_64               randconfig-a014-20210215
x86_64               randconfig-a011-20210215
i386                 randconfig-a016-20210215
i386                 randconfig-a014-20210215
i386                 randconfig-a012-20210215
i386                 randconfig-a013-20210215
i386                 randconfig-a011-20210215
i386                 randconfig-a015-20210215
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
x86_64               randconfig-a003-20210215
x86_64               randconfig-a002-20210215
x86_64               randconfig-a001-20210215
x86_64               randconfig-a004-20210215
x86_64               randconfig-a005-20210215
x86_64               randconfig-a006-20210215
x86_64               randconfig-a013-20210216
x86_64               randconfig-a016-20210216
x86_64               randconfig-a012-20210216
x86_64               randconfig-a015-20210216
x86_64               randconfig-a014-20210216
x86_64               randconfig-a011-20210216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

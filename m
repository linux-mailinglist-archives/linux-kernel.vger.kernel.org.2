Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B723E8775
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhHKA4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:56:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:23454 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231423AbhHKA4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:56:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="202209309"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="202209309"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 17:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="506664260"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2021 17:56:09 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mDcXQ-000L6K-Bb; Wed, 11 Aug 2021 00:56:08 +0000
Date:   Wed, 11 Aug 2021 08:55:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 8ae9e3f63865bc067c144817da9df025dbb667f2
Message-ID: <61131ff2.vgqQfA95qPx69m/g%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 8ae9e3f63865bc067c144817da9df025dbb667f2  x86/mce/inject: Replace deprecated CPU-hotplug functions.

elapsed time: 723m

configs tested: 122
configs skipped: 64

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210810
arm                            zeus_defconfig
arm                             rpc_defconfig
powerpc                     sbc8548_defconfig
mips                          rb532_defconfig
powerpc                 mpc836x_mds_defconfig
mips                           ip28_defconfig
powerpc                     tqm8541_defconfig
i386                             alldefconfig
powerpc                      bamboo_defconfig
arm                          pxa910_defconfig
powerpc                      ep88xc_defconfig
mips                    maltaup_xpa_defconfig
arm                       versatile_defconfig
powerpc                 mpc837x_mds_defconfig
mips                            e55_defconfig
powerpc                          g5_defconfig
arm                      footbridge_defconfig
csky                                defconfig
xtensa                          iss_defconfig
xtensa                    xip_kc705_defconfig
arc                      axs103_smp_defconfig
arm                            lart_defconfig
mips                      maltasmvp_defconfig
xtensa                  cadence_csp_defconfig
powerpc                     mpc83xx_defconfig
mips                      loongson3_defconfig
microblaze                      mmu_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210810
x86_64               randconfig-a006-20210810
x86_64               randconfig-a003-20210810
x86_64               randconfig-a005-20210810
x86_64               randconfig-a002-20210810
x86_64               randconfig-a001-20210810
i386                 randconfig-a004-20210809
i386                 randconfig-a005-20210809
i386                 randconfig-a006-20210809
i386                 randconfig-a002-20210809
i386                 randconfig-a001-20210809
i386                 randconfig-a003-20210809
i386                 randconfig-a004-20210810
i386                 randconfig-a002-20210810
i386                 randconfig-a001-20210810
i386                 randconfig-a003-20210810
i386                 randconfig-a006-20210810
i386                 randconfig-a005-20210810
i386                 randconfig-a004-20210808
i386                 randconfig-a005-20210808
i386                 randconfig-a006-20210808
i386                 randconfig-a002-20210808
i386                 randconfig-a001-20210808
i386                 randconfig-a003-20210808
i386                 randconfig-a011-20210810
i386                 randconfig-a015-20210810
i386                 randconfig-a013-20210810
i386                 randconfig-a014-20210810
i386                 randconfig-a016-20210810
i386                 randconfig-a012-20210810
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210810
x86_64               randconfig-a013-20210810
x86_64               randconfig-a011-20210810
x86_64               randconfig-a012-20210810
x86_64               randconfig-a016-20210810
x86_64               randconfig-a014-20210810
x86_64               randconfig-a015-20210810
x86_64               randconfig-a016-20210809
x86_64               randconfig-a012-20210809
x86_64               randconfig-a013-20210809
x86_64               randconfig-a011-20210809
x86_64               randconfig-a014-20210809
x86_64               randconfig-a015-20210809

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

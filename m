Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18A335B84D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 03:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhDLBuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 21:50:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:52378 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236212AbhDLBuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 21:50:17 -0400
IronPort-SDR: eu0exGnbdiVuYoZVCJ/CgiBgOyOtjVsUR/VbnjxBiy4Ii2snRuLLaCTFunOVnnRf4ljTTj3NkX
 ZUMF7ZL9VIhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="258069100"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="258069100"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 18:49:59 -0700
IronPort-SDR: V63bzwrm3eRon4MzOeie72LRxElYQMESHpdQx1N7wzaKQR7kDmeK+583xsnHOCJvrZcXWZsfRN
 3fxxQd98pkDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="420232918"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Apr 2021 18:49:58 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVli9-00005e-RJ; Mon, 12 Apr 2021 01:49:57 +0000
Date:   Mon, 12 Apr 2021 09:49:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 3f29baf9d62e86e5af51c8d1087ec78bf436e923
Message-ID: <6073a710.FtYfD+l/ZmtsRTI3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 3f29baf9d62e86e5af51c8d1087ec78bf436e923  Merge branch 'core/rcu'

elapsed time: 723m

configs tested: 106
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

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
sh                   sh7724_generic_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      ppc64e_defconfig
arm                            hisi_defconfig
xtensa                          iss_defconfig
xtensa                generic_kc705_defconfig
mips                         db1xxx_defconfig
arm                       netwinder_defconfig
openrisc                 simple_smp_defconfig
sh                         ecovec24_defconfig
mips                  cavium_octeon_defconfig
m68k                        m5307c3_defconfig
mips                        omega2p_defconfig
parisc                generic-64bit_defconfig
powerpc                      katmai_defconfig
mips                          ath79_defconfig
h8300                       h8s-sim_defconfig
arm                         hackkit_defconfig
sh                          urquell_defconfig
mips                  maltasmvp_eva_defconfig
x86_64                           alldefconfig
powerpc                 canyonlands_defconfig
powerpc                         ps3_defconfig
powerpc                     redwood_defconfig
arm                             rpc_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      mgcoge_defconfig
mips                            ar7_defconfig
parisc                           allyesconfig
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
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210411
i386                 randconfig-a001-20210411
i386                 randconfig-a006-20210411
i386                 randconfig-a005-20210411
i386                 randconfig-a004-20210411
i386                 randconfig-a002-20210411
i386                 randconfig-a015-20210411
i386                 randconfig-a014-20210411
i386                 randconfig-a013-20210411
i386                 randconfig-a012-20210411
i386                 randconfig-a016-20210411
i386                 randconfig-a011-20210411
x86_64               randconfig-a003-20210411
x86_64               randconfig-a002-20210411
x86_64               randconfig-a001-20210411
x86_64               randconfig-a005-20210411
x86_64               randconfig-a006-20210411
x86_64               randconfig-a004-20210411
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
x86_64               randconfig-a014-20210411
x86_64               randconfig-a015-20210411
x86_64               randconfig-a011-20210411
x86_64               randconfig-a013-20210411
x86_64               randconfig-a012-20210411
x86_64               randconfig-a016-20210411

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

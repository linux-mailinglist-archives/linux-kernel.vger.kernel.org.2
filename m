Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8063C3F367C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhHTWhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:37:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:3508 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhHTWhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:37:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="277870276"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="277870276"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 15:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="682642855"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Aug 2021 15:36:48 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mHD83-000VG6-Kr; Fri, 20 Aug 2021 22:36:47 +0000
Date:   Sat, 21 Aug 2021 06:36:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 b857174e68e26f9c4f0796971e11eb63ad5a3eb6
Message-ID: <61202e53.p7NDOnAbPWbrXtv/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: b857174e68e26f9c4f0796971e11eb63ad5a3eb6  locking/ww_mutex: Initialize waiter.ww_ctx properly

elapsed time: 722m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210820
arm                         hackkit_defconfig
arm                             ezx_defconfig
mips                  decstation_64_defconfig
arm                        trizeps4_defconfig
m68k                          multi_defconfig
sh                          r7780mp_defconfig
sh                           se7724_defconfig
arc                    vdk_hs38_smp_defconfig
sparc                            alldefconfig
arm                          iop32x_defconfig
sh                              ul2_defconfig
sh                          landisk_defconfig
mips                  maltasmvp_eva_defconfig
xtensa                    smp_lx200_defconfig
arm                          badge4_defconfig
mips                        nlm_xlr_defconfig
arm                           sama5_defconfig
powerpc                     ep8248e_defconfig
arm                       netwinder_defconfig
xtensa                          iss_defconfig
arm                          collie_defconfig
m68k                                defconfig
i386                             alldefconfig
arm                       mainstone_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           u8500_defconfig
arm                            dove_defconfig
arm                            qcom_defconfig
arm                          pxa910_defconfig
sh                                  defconfig
openrisc                  or1klitex_defconfig
sh                        sh7763rdp_defconfig
powerpc                       ppc64_defconfig
sh                   rts7751r2dplus_defconfig
mips                        bcm63xx_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
i386                 randconfig-a006-20210820
i386                 randconfig-a001-20210820
i386                 randconfig-a002-20210820
i386                 randconfig-a005-20210820
i386                 randconfig-a003-20210820
i386                 randconfig-a004-20210820
i386                 randconfig-a015-20210819
i386                 randconfig-a011-20210819
i386                 randconfig-a014-20210819
i386                 randconfig-a013-20210819
i386                 randconfig-a016-20210819
i386                 randconfig-a012-20210819
i386                 randconfig-a011-20210821
i386                 randconfig-a016-20210821
i386                 randconfig-a012-20210821
i386                 randconfig-a014-20210821
i386                 randconfig-a013-20210821
i386                 randconfig-a015-20210821
x86_64               randconfig-a004-20210818
x86_64               randconfig-a006-20210818
x86_64               randconfig-a003-20210818
x86_64               randconfig-a005-20210818
x86_64               randconfig-a002-20210818
x86_64               randconfig-a001-20210818
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210820
x86_64               randconfig-a014-20210820
x86_64               randconfig-a016-20210820
x86_64               randconfig-a015-20210820
x86_64               randconfig-a013-20210820
x86_64               randconfig-a012-20210820
x86_64               randconfig-a011-20210820
i386                 randconfig-a011-20210820
i386                 randconfig-a016-20210820
i386                 randconfig-a012-20210820
i386                 randconfig-a014-20210820
i386                 randconfig-a013-20210820
i386                 randconfig-a015-20210820

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F537A67F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhEKMYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:24:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:12233 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhEKMYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:24:36 -0400
IronPort-SDR: pXP3nI/pQdI0FubtSdfjhHMctdIV/2ECJUumK8eM3sr5Mv2zpp9AaEHFoSJNw+0hk8YtTW1iJ8
 XUnO5t3a/WIA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="260689422"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="260689422"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:23:29 -0700
IronPort-SDR: T5Aa5jTGUmndWECq5KkOSf64HkMW3PPabHL46jAP1+1FPhDpBTHibBjXKxZVC0UZrRVrqlMw6X
 rDqmHNZb5ndQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="399292177"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 May 2021 05:23:28 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgRQ8-0000hE-4k; Tue, 11 May 2021 12:23:28 +0000
Date:   Tue, 11 May 2021 20:22:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:lkmm] BUILD SUCCESS d25fba0e34742f19b5ca307c60c4d260ca5a754a
Message-ID: <609a7720.MGwlD0jchIc/71eu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm
branch HEAD: d25fba0e34742f19b5ca307c60c4d260ca5a754a  tools/memory-model: Fix smp_mb__after_spinlock() spelling

elapsed time: 728m

configs tested: 110
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
arm                            qcom_defconfig
sh                          urquell_defconfig
arm                          exynos_defconfig
sparc                       sparc32_defconfig
riscv                             allnoconfig
arc                                 defconfig
riscv                            alldefconfig
arm                         lpc32xx_defconfig
mips                      maltaaprp_defconfig
sh                     magicpanelr2_defconfig
sh                          polaris_defconfig
sparc                            allyesconfig
mips                     loongson1c_defconfig
mips                       capcella_defconfig
arm                           sunxi_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                      chrp32_defconfig
arm                         s3c6400_defconfig
um                             i386_defconfig
arc                        nsim_700_defconfig
arm                             ezx_defconfig
arm                          pxa3xx_defconfig
powerpc                 mpc834x_itx_defconfig
mips                     decstation_defconfig
i386                                defconfig
arm                        magician_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          kfr2r09_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                          rb532_defconfig
mips                           ci20_defconfig
arc                     nsimosci_hs_defconfig
riscv                    nommu_k210_defconfig
mips                           rs90_defconfig
powerpc                    gamecube_defconfig
sh                     sh7710voipgw_defconfig
x86_64                            allnoconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210511
i386                 randconfig-a001-20210511
i386                 randconfig-a005-20210511
i386                 randconfig-a004-20210511
i386                 randconfig-a002-20210511
i386                 randconfig-a006-20210511
x86_64               randconfig-a012-20210511
x86_64               randconfig-a015-20210511
x86_64               randconfig-a011-20210511
x86_64               randconfig-a013-20210511
x86_64               randconfig-a016-20210511
x86_64               randconfig-a014-20210511
x86_64               randconfig-a003-20210510
x86_64               randconfig-a004-20210510
x86_64               randconfig-a001-20210510
x86_64               randconfig-a005-20210510
x86_64               randconfig-a002-20210510
x86_64               randconfig-a006-20210510
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
x86_64               randconfig-a003-20210511
x86_64               randconfig-a004-20210511
x86_64               randconfig-a001-20210511
x86_64               randconfig-a005-20210511
x86_64               randconfig-a002-20210511
x86_64               randconfig-a006-20210511

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

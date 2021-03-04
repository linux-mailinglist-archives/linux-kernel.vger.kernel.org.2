Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AC032DDEF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 00:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhCDXkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 18:40:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:36422 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230527AbhCDXky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:40:54 -0500
IronPort-SDR: LHhzhypB8hEoQvPrRjtq3bCzHa1cyxKl0t3GeGxVm2JXOAmxVhyBvIoa1iGncwacDDtZLQDnDu
 qMBcVae8PtcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="251567133"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="251567133"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 15:40:53 -0800
IronPort-SDR: mYuGjV/vP6g7Jqmf1Hzbb/JiAJ5ZnKHgY87gDWbzjWdRe4f8fe4KCm0xO9iUUHNWRdkD39eOO2
 9OR7GevaxEDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="384675551"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 04 Mar 2021 15:40:51 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHxaN-0002SS-16; Thu, 04 Mar 2021 23:40:51 +0000
Date:   Fri, 05 Mar 2021 07:40:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/vdso] BUILD SUCCESS
 6bdbe1760651484b0fe6f6d0cc3a2fe8741e6f87
Message-ID: <60416fd7.GswkRetgPW+vmAjQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vdso
branch HEAD: 6bdbe1760651484b0fe6f6d0cc3a2fe8741e6f87  x86/vdso: Use proper modifier for len's format specifier in extract()

elapsed time: 724m

configs tested: 99
configs skipped: 38

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         axm55xx_defconfig
arm                        mvebu_v5_defconfig
powerpc                      acadia_defconfig
arc                        nsimosci_defconfig
mips                         tb0287_defconfig
m68k                        m5307c3_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          imote2_defconfig
s390                          debug_defconfig
mips                         bigsur_defconfig
arc                            hsdk_defconfig
sparc64                             defconfig
powerpc                  storcenter_defconfig
powerpc                     akebono_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                        vocore2_defconfig
x86_64                           alldefconfig
m68k                       m5275evb_defconfig
mips                        bcm47xx_defconfig
arm                         nhk8815_defconfig
m68k                        m5407c3_defconfig
arm64                            alldefconfig
mips                          rb532_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc8315_rdb_defconfig
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
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210304
i386                 randconfig-a003-20210304
i386                 randconfig-a002-20210304
i386                 randconfig-a004-20210304
i386                 randconfig-a006-20210304
i386                 randconfig-a001-20210304
i386                 randconfig-a016-20210304
i386                 randconfig-a012-20210304
i386                 randconfig-a013-20210304
i386                 randconfig-a014-20210304
i386                 randconfig-a011-20210304
i386                 randconfig-a015-20210304
x86_64               randconfig-a006-20210304
x86_64               randconfig-a001-20210304
x86_64               randconfig-a004-20210304
x86_64               randconfig-a005-20210304
x86_64               randconfig-a002-20210304
x86_64               randconfig-a003-20210304
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210304
x86_64               randconfig-a016-20210304
x86_64               randconfig-a015-20210304
x86_64               randconfig-a014-20210304
x86_64               randconfig-a012-20210304
x86_64               randconfig-a011-20210304

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

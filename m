Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CBB36616F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhDTVP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:15:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:24336 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234026AbhDTVPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:15:48 -0400
IronPort-SDR: Jh09jHu+tISKfcj3KPtS8a+TTtecoyh0XZEZGnar5Gq1oNKVMsepXwCUrSQzHr1qOW0XlCaURW
 dq1M38uEptmA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175079547"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="175079547"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 14:15:14 -0700
IronPort-SDR: 34eO/FfBvOEYYpZuALUxhnCBZxHbS2boPxPvWI3eJxr/TdMT0VhNAWiggPChnOJ3WoKXAkUJ+K
 CXJRlwdk6V+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="384212255"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2021 14:15:12 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYxiB-0002yb-SE; Tue, 20 Apr 2021 21:15:11 +0000
Date:   Wed, 21 Apr 2021 05:14:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 3f5ad91488e813026f8c5f46b839e91a83912703
Message-ID: <607f444b.7YPjy47kvyPSWFH8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 3f5ad91488e813026f8c5f46b839e91a83912703  sched/fair: Move update_nohz_stats() to the CONFIG_NO_HZ_COMMON block to simplify the code & fix an unused function warning

elapsed time: 724m

configs tested: 126
configs skipped: 3

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
sh                        edosk7760_defconfig
arm                        mvebu_v5_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      bamboo_defconfig
arm                        magician_defconfig
xtensa                       common_defconfig
um                            kunit_defconfig
riscv                    nommu_k210_defconfig
powerpc                       eiger_defconfig
powerpc                     tqm8548_defconfig
arm                           viper_defconfig
sh                        edosk7705_defconfig
arm                        spear3xx_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      tqm8xx_defconfig
arm                          moxart_defconfig
m68k                       m5208evb_defconfig
openrisc                  or1klitex_defconfig
mips                     decstation_defconfig
powerpc64                           defconfig
riscv                          rv32_defconfig
powerpc                       maple_defconfig
um                           x86_64_defconfig
sh                          r7780mp_defconfig
mips                     loongson1b_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           corgi_defconfig
arm                             mxs_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                       ppc64_defconfig
arm                       multi_v4t_defconfig
nios2                            alldefconfig
powerpc                      mgcoge_defconfig
sh                           se7724_defconfig
sh                          sdk7786_defconfig
arm                            dove_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc832x_rdb_defconfig
parisc                generic-32bit_defconfig
sh                             shx3_defconfig
mips                           ip22_defconfig
sh                        sh7763rdp_defconfig
powerpc                      pmac32_defconfig
powerpc                  mpc885_ads_defconfig
arm                       aspeed_g4_defconfig
arm                         s3c2410_defconfig
sh                            hp6xx_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210420
i386                 randconfig-a002-20210420
i386                 randconfig-a001-20210420
i386                 randconfig-a006-20210420
i386                 randconfig-a004-20210420
i386                 randconfig-a003-20210420
x86_64               randconfig-a015-20210420
x86_64               randconfig-a016-20210420
x86_64               randconfig-a011-20210420
x86_64               randconfig-a014-20210420
x86_64               randconfig-a013-20210420
x86_64               randconfig-a012-20210420
i386                 randconfig-a012-20210420
i386                 randconfig-a014-20210420
i386                 randconfig-a011-20210420
i386                 randconfig-a013-20210420
i386                 randconfig-a015-20210420
i386                 randconfig-a016-20210420
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a004-20210420
x86_64               randconfig-a002-20210420
x86_64               randconfig-a001-20210420
x86_64               randconfig-a005-20210420
x86_64               randconfig-a006-20210420
x86_64               randconfig-a003-20210420

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5A236616E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhDTVPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:15:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:58069 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234027AbhDTVPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:15:45 -0400
IronPort-SDR: jBVkCtN2D13Tcr8DRUYU3yg5PXu54bR5RoD96szBbBxDveFI98hMUeFzV4DrFIpLIRfM+gp8MR
 vQuHlpe2J/KA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="256906699"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="256906699"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 14:15:13 -0700
IronPort-SDR: 4C3NJv0Lz8hnVU6MgCpyv4vTxC19paFfRYzzFQiMliUXHmhHHo0v/xdkEn/eSjXE+lERwlX5Xw
 dKwkGYyZAD2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="463314733"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Apr 2021 14:15:12 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYxiB-0002yY-Od; Tue, 20 Apr 2021 21:15:11 +0000
Date:   Wed, 21 Apr 2021 05:14:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 27743f01e391ee1d80e3be2a09237507b965f91b
Message-ID: <607f4449.zs3w32DT/0ASOTLl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: 27743f01e391ee1d80e3be2a09237507b965f91b  x86/platform/uv: Remove dead !CONFIG_KEXEC_CORE code

elapsed time: 724m

configs tested: 144
configs skipped: 71

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
sh                           se7705_defconfig
powerpc                     tqm8541_defconfig
m68k                        m5307c3_defconfig
powerpc                     rainier_defconfig
powerpc                  storcenter_defconfig
mips                          ath79_defconfig
sh                        edosk7760_defconfig
arm                        mvebu_v5_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
mips                           gcw0_defconfig
mips                     decstation_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      bamboo_defconfig
arm                        magician_defconfig
xtensa                       common_defconfig
um                            kunit_defconfig
nios2                         10m50_defconfig
sh                            titan_defconfig
arm                        mvebu_v7_defconfig
mips                        bcm47xx_defconfig
arm                        oxnas_v6_defconfig
mips                        bcm63xx_defconfig
arm                            zeus_defconfig
arm                         axm55xx_defconfig
arm                          moxart_defconfig
arm                       multi_v4t_defconfig
arm                       spear13xx_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      tqm8xx_defconfig
m68k                       m5208evb_defconfig
openrisc                  or1klitex_defconfig
powerpc64                           defconfig
riscv                          rv32_defconfig
sh                           se7724_defconfig
mips                           xway_defconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
arm                             mxs_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                       ppc64_defconfig
nios2                            alldefconfig
powerpc                      mgcoge_defconfig
sh                          sdk7786_defconfig
arm                            dove_defconfig
powerpc                     ppa8548_defconfig
xtensa                generic_kc705_defconfig
arm                      pxa255-idp_defconfig
m68k                       m5275evb_defconfig
riscv                               defconfig
sh                           se7780_defconfig
mips                malta_qemu_32r6_defconfig
openrisc                            defconfig
sparc                       sparc64_defconfig
mips                             allmodconfig
h8300                    h8300h-sim_defconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                    nommu_k210_defconfig
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

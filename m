Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDDB36E1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhD1WYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:24:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:64028 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232310AbhD1WYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:24:03 -0400
IronPort-SDR: THUWRL8s2cRdysCe/qHiTkjVE1lhX8lVVeuzw6AOxwOdZbXVtJld98BBBnNQKtx5UlCjIxrn9j
 inORt2NiApXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="196975479"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="196975479"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 15:23:17 -0700
IronPort-SDR: nwryRTKNLV+dk9dH427XcYxgnZClrDC7ta6qMUFJtJAYLGFY2SGbn5RdGJjhDQiN2NxZS1vRtv
 KqhrV1+sAuTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="537137059"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Apr 2021 15:23:16 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lbsaR-0007KJ-PP; Wed, 28 Apr 2021 22:23:15 +0000
Date:   Thu, 29 Apr 2021 06:23:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 24b57391e41080c72ee7d927672c2a0727e71387
Message-ID: <6089e04a.tutsoxmc+4P9z38i%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 24b57391e41080c72ee7d927672c2a0727e71387  Merge branch 'core/rcu'

elapsed time: 725m

configs tested: 119
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
riscv                            allyesconfig
powerpc                      pcm030_defconfig
arm                     eseries_pxa_defconfig
mips                          ath25_defconfig
m68k                           sun3_defconfig
ia64                      gensparse_defconfig
mips                       lemote2f_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
mips                       rbtx49xx_defconfig
arm                           h5000_defconfig
arm                            mps2_defconfig
sh                        sh7757lcr_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      arches_defconfig
arm                       aspeed_g4_defconfig
m68k                        mvme16x_defconfig
arm                           sama5_defconfig
arm                             rpc_defconfig
arm                        mvebu_v7_defconfig
sh                           se7780_defconfig
parisc                           alldefconfig
sh                          sdk7780_defconfig
mips                         tb0226_defconfig
arm                         orion5x_defconfig
powerpc                 mpc85xx_cds_defconfig
arc                      axs103_smp_defconfig
mips                      pic32mzda_defconfig
mips                       bmips_be_defconfig
arm                          pxa168_defconfig
openrisc                    or1ksim_defconfig
um                                allnoconfig
powerpc                      walnut_defconfig
m68k                          atari_defconfig
i386                                defconfig
powerpc                     mpc83xx_defconfig
arm                       spear13xx_defconfig
arm                       omap2plus_defconfig
mips                        jmr3927_defconfig
arm                      pxa255-idp_defconfig
s390                          debug_defconfig
sh                                  defconfig
arm                            qcom_defconfig
arm                            dove_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210428
i386                 randconfig-a002-20210428
i386                 randconfig-a001-20210428
i386                 randconfig-a006-20210428
i386                 randconfig-a003-20210428
i386                 randconfig-a004-20210428
x86_64               randconfig-a015-20210428
x86_64               randconfig-a016-20210428
x86_64               randconfig-a011-20210428
x86_64               randconfig-a014-20210428
x86_64               randconfig-a013-20210428
x86_64               randconfig-a012-20210428
i386                 randconfig-a012-20210428
i386                 randconfig-a014-20210428
i386                 randconfig-a013-20210428
i386                 randconfig-a011-20210428
i386                 randconfig-a015-20210428
i386                 randconfig-a016-20210428
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210428
x86_64               randconfig-a002-20210428
x86_64               randconfig-a005-20210428
x86_64               randconfig-a006-20210428
x86_64               randconfig-a001-20210428
x86_64               randconfig-a003-20210428

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

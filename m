Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D478E3B10F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 02:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFWAO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 20:14:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:14549 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhFWAOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 20:14:47 -0400
IronPort-SDR: BQbknBC9U/vaMdVbkPFfdYho8Z5EHPP/ZNtyWpZSqRwTVkgrWKADkny9nXT45QZprsrnd2BN0U
 HyoFjaLVQymg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="206981808"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="206981808"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 17:12:27 -0700
IronPort-SDR: OLwecRqyndbH+QXPmSUo3RBQ14NyQ7pNtzXut4pyLTW0Gi4oCdkMCfkOulwOlZx40L5sTcdXWv
 otIVXyRJ7Nhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="487099601"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2021 17:12:25 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lvqVF-0005Xu-5Q; Wed, 23 Jun 2021 00:12:25 +0000
Date:   Wed, 23 Jun 2021 08:12:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 f10bd30916ba18da9085350f175605c756f40dcb
Message-ID: <60d27c59.NhftTulXIUVGqs3N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: f10bd30916ba18da9085350f175605c756f40dcb  Merge branch 'efi/core'

elapsed time: 2112m

configs tested: 150
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm                       versatile_defconfig
arm                         s3c2410_defconfig
powerpc                      chrp32_defconfig
m68k                        mvme16x_defconfig
openrisc                            defconfig
powerpc                   motionpro_defconfig
arc                        vdk_hs38_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     tqm5200_defconfig
powerpc                    gamecube_defconfig
powerpc                    sam440ep_defconfig
sh                           se7705_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                          malta_defconfig
xtensa                           alldefconfig
powerpc                      makalu_defconfig
h8300                       h8s-sim_defconfig
sh                         ap325rxa_defconfig
arm                           h5000_defconfig
ia64                             alldefconfig
arm                            zeus_defconfig
mips                           mtx1_defconfig
arc                    vdk_hs38_smp_defconfig
mips                     cu1830-neo_defconfig
powerpc                      pcm030_defconfig
arm                           sama5_defconfig
arm                       cns3420vb_defconfig
mips                   sb1250_swarm_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     stx_gp3_defconfig
arm                       imx_v4_v5_defconfig
arm                      tct_hammer_defconfig
sh                           se7712_defconfig
arm                             ezx_defconfig
sh                 kfr2r09-romimage_defconfig
alpha                            alldefconfig
mips                        omega2p_defconfig
m68k                         amcore_defconfig
xtensa                  nommu_kc705_defconfig
mips                       bmips_be_defconfig
m68k                            mac_defconfig
m68k                           sun3_defconfig
arm                             rpc_defconfig
powerpc                     sequoia_defconfig
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
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
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
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
x86_64               randconfig-a002-20210621
x86_64               randconfig-a001-20210621
x86_64               randconfig-a005-20210621
x86_64               randconfig-a003-20210621
x86_64               randconfig-a004-20210621
x86_64               randconfig-a006-20210621
i386                 randconfig-a002-20210621
i386                 randconfig-a001-20210621
i386                 randconfig-a003-20210621
i386                 randconfig-a006-20210621
i386                 randconfig-a005-20210621
i386                 randconfig-a004-20210621
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
x86_64               randconfig-a012-20210622
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
i386                 randconfig-a011-20210621
i386                 randconfig-a014-20210621
i386                 randconfig-a013-20210621
i386                 randconfig-a015-20210621
i386                 randconfig-a012-20210621
i386                 randconfig-a016-20210621
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210621
x86_64               randconfig-b001-20210622
x86_64               randconfig-a012-20210621
x86_64               randconfig-a016-20210621
x86_64               randconfig-a015-20210621
x86_64               randconfig-a014-20210621
x86_64               randconfig-a013-20210621
x86_64               randconfig-a011-20210621
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

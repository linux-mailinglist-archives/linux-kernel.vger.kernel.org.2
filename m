Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360FB3B248B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 03:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFXBiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 21:38:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:47616 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhFXBiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 21:38:18 -0400
IronPort-SDR: g54nqxrVxcN6HZ7D2wjaKMCfNjNiAWP1tpez7iHdSMMLFC6grCTB55SEYqjHYsN8uEjkw1b6xg
 xcB8NerQGRFA==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="204368392"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="204368392"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 18:35:59 -0700
IronPort-SDR: 7Bn10WbuZDedbTPhBQN/2UUTEv7hDs8fgJCLBvRis8V91Xy5smgzJzMJQRO15KEUSmhNvkaqSQ
 D6wfDBJP4pHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="556328043"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Jun 2021 18:35:57 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwEHd-0006IB-8N; Thu, 24 Jun 2021 01:35:57 +0000
Date:   Thu, 24 Jun 2021 09:35:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 8d9d46bbf3b6b7ff8edcac33603ab45c29e0e07f
Message-ID: <60d3e159.Hq5TII+TIcxvrqHx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 8d9d46bbf3b6b7ff8edcac33603ab45c29e0e07f  x86/sev: Use "SEV: " prefix for messages from sev.c

elapsed time: 720m

configs tested: 182
configs skipped: 79

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                            defconfig
arm                        mvebu_v5_defconfig
mips                        vocore2_defconfig
arm                         axm55xx_defconfig
nios2                         10m50_defconfig
riscv                            allyesconfig
powerpc                       holly_defconfig
powerpc                      makalu_defconfig
arc                        nsimosci_defconfig
sparc64                          alldefconfig
arm                        keystone_defconfig
mips                          ath79_defconfig
sh                          rsk7203_defconfig
sh                        edosk7760_defconfig
m68k                          atari_defconfig
arm                         lpc32xx_defconfig
arm                          lpd270_defconfig
um                             i386_defconfig
arm                             pxa_defconfig
arm                           corgi_defconfig
arm                      pxa255-idp_defconfig
arm                             ezx_defconfig
mips                          ath25_defconfig
mips                       capcella_defconfig
arm                        mini2440_defconfig
arm                            hisi_defconfig
arm                        neponset_defconfig
mips                        bcm63xx_defconfig
arm                       aspeed_g4_defconfig
powerpc                     tqm8540_defconfig
ia64                      gensparse_defconfig
arm                       spear13xx_defconfig
nds32                             allnoconfig
sparc                            alldefconfig
arm                           omap1_defconfig
powerpc                     tqm8555_defconfig
mips                       rbtx49xx_defconfig
mips                   sb1250_swarm_defconfig
mips                         tb0287_defconfig
xtensa                         virt_defconfig
arc                        nsim_700_defconfig
mips                          rb532_defconfig
powerpc                      ppc44x_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     pseries_defconfig
mips                        jmr3927_defconfig
arm                      footbridge_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                     davinci_all_defconfig
powerpc                      ppc64e_defconfig
m68k                           sun3_defconfig
powerpc                     ppa8548_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7722_defconfig
powerpc                 mpc834x_itx_defconfig
sh                               allmodconfig
powerpc                     ep8248e_defconfig
sh                           se7724_defconfig
sh                             sh03_defconfig
m68k                          sun3x_defconfig
mips                             allmodconfig
powerpc                 canyonlands_defconfig
um                            kunit_defconfig
powerpc                  storcenter_defconfig
powerpc                         wii_defconfig
xtensa                          iss_defconfig
openrisc                    or1ksim_defconfig
parisc                              defconfig
arm                         lubbock_defconfig
mips                           ip22_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
mips                           gcw0_defconfig
arc                        vdk_hs38_defconfig
powerpc                       maple_defconfig
arm                       aspeed_g5_defconfig
arm                          ep93xx_defconfig
arm                       cns3420vb_defconfig
powerpc                     sequoia_defconfig
m68k                        mvme147_defconfig
mips                      maltasmvp_defconfig
arc                              allyesconfig
m68k                       m5249evb_defconfig
mips                        omega2p_defconfig
arm                        magician_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210623
x86_64               randconfig-a001-20210623
x86_64               randconfig-a005-20210623
x86_64               randconfig-a003-20210623
x86_64               randconfig-a004-20210623
x86_64               randconfig-a006-20210623
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
i386                 randconfig-a002-20210623
i386                 randconfig-a001-20210623
i386                 randconfig-a003-20210623
i386                 randconfig-a006-20210623
i386                 randconfig-a005-20210623
i386                 randconfig-a004-20210623
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210623
i386                 randconfig-a014-20210623
i386                 randconfig-a013-20210623
i386                 randconfig-a015-20210623
i386                 randconfig-a012-20210623
i386                 randconfig-a016-20210623
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
i386                 randconfig-a011-20210624
i386                 randconfig-a014-20210624
i386                 randconfig-a013-20210624
i386                 randconfig-a015-20210624
i386                 randconfig-a012-20210624
i386                 randconfig-a016-20210624
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-b001-20210623
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

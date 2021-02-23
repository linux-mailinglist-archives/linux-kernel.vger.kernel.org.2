Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875F032316A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhBWTZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:25:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:39674 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhBWTZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:25:36 -0500
IronPort-SDR: y6mTW4NBH1t/Mx3YAF9NmhtLh5VtbCK8fH+/V3TFYf4uOGffTs5gQNR5iY24ctX4ZKSyJBgCM7
 GASx0gAyuTnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="172058656"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="172058656"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:24:56 -0800
IronPort-SDR: GEl0wsisH1P5GcIckXWDSAyyHKDp31FAGFPsB7Os6hwNHZEaDPEevYXBJpfW89OgRvcNXpU3GI
 2UxxfMSht7eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="515306479"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Feb 2021 11:24:55 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lEdIk-0001V0-FY; Tue, 23 Feb 2021 19:24:54 +0000
Date:   Wed, 24 Feb 2021 03:23:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f1bc6ab4a2b38f3dcf24dc29fb79d5a520f4845d
Message-ID: <6035564e.da+81e+gDTyDnqeh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f1bc6ab4a2b38f3dcf24dc29fb79d5a520f4845d  Merge branch 'timers/urgent'

elapsed time: 725m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          hp300_defconfig
arc                         haps_hs_defconfig
arm64                            alldefconfig
powerpc                     rainier_defconfig
arc                    vdk_hs38_smp_defconfig
arm                      pxa255-idp_defconfig
arc                          axs101_defconfig
arm                         s3c6400_defconfig
mips                           jazz_defconfig
arm                            pleb_defconfig
xtensa                           alldefconfig
arm                          moxart_defconfig
sh                          r7785rp_defconfig
mips                           xway_defconfig
mips                        qi_lb60_defconfig
arm                          pxa910_defconfig
arc                          axs103_defconfig
powerpc                    klondike_defconfig
m68k                          amiga_defconfig
arc                        nsim_700_defconfig
arc                              alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                          malta_defconfig
sh                          rsk7203_defconfig
powerpc                    amigaone_defconfig
mips                      fuloong2e_defconfig
arm                        spear6xx_defconfig
mips                        vocore2_defconfig
s390                          debug_defconfig
powerpc                      pcm030_defconfig
powerpc                 mpc8560_ads_defconfig
h8300                            alldefconfig
arm                        multi_v7_defconfig
openrisc                         alldefconfig
m68k                        m5307c3_defconfig
sh                             espt_defconfig
powerpc                         wii_defconfig
m68k                                defconfig
xtensa                generic_kc705_defconfig
arm                         lpc18xx_defconfig
arc                      axs103_smp_defconfig
x86_64                           alldefconfig
ia64                      gensparse_defconfig
arm                        oxnas_v6_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      walnut_defconfig
mips                           ip32_defconfig
microblaze                      mmu_defconfig
sh                        edosk7705_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210223
i386                 randconfig-a006-20210223
i386                 randconfig-a004-20210223
i386                 randconfig-a003-20210223
i386                 randconfig-a001-20210223
i386                 randconfig-a002-20210223
x86_64               randconfig-a015-20210223
x86_64               randconfig-a011-20210223
x86_64               randconfig-a012-20210223
x86_64               randconfig-a016-20210223
x86_64               randconfig-a014-20210223
x86_64               randconfig-a013-20210223
i386                 randconfig-a013-20210223
i386                 randconfig-a012-20210223
i386                 randconfig-a011-20210223
i386                 randconfig-a014-20210223
i386                 randconfig-a016-20210223
i386                 randconfig-a015-20210223
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
x86_64               randconfig-a001-20210223
x86_64               randconfig-a002-20210223
x86_64               randconfig-a003-20210223
x86_64               randconfig-a005-20210223
x86_64               randconfig-a006-20210223
x86_64               randconfig-a004-20210223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

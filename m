Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D85358D84
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhDHTgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:36:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:16165 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhDHTgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:36:07 -0400
IronPort-SDR: cKgmZ2MJHKtquSjfxmhpbmeARPVeW5BDL9ZlpuID112fKZdG0yW3Gpho23OMWGuz6Wd2Jm7aRf
 lEIptKMINJww==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193162031"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="193162031"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 12:35:56 -0700
IronPort-SDR: 9bf4ej8A0diW3/HRe3uwzhn0oZWE3KN5R8Kov9UaXL+1E6a6jcOSFJspNFaJC7TgLYknwPd281
 pHH27mfoyYLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="448783121"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2021 12:35:55 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUaRW-000FZA-CI; Thu, 08 Apr 2021 19:35:54 +0000
Date:   Fri, 09 Apr 2021 03:35:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1dabdd67370e1fec904b39f82401a16f678df565
Message-ID: <606f5aef.w9rvfKFerpkiizqu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1dabdd67370e1fec904b39f82401a16f678df565  Merge remote-tracking branch 'tip/x86/urgent' into tip-master

elapsed time: 725m

configs tested: 160
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
riscv                            allyesconfig
i386                             allyesconfig
arm                         lpc18xx_defconfig
arc                         haps_hs_defconfig
riscv                            alldefconfig
powerpc                     mpc83xx_defconfig
openrisc                 simple_smp_defconfig
m68k                        m5307c3_defconfig
m68k                       m5208evb_defconfig
mips                malta_qemu_32r6_defconfig
sh                           se7712_defconfig
riscv                    nommu_virt_defconfig
mips                           ci20_defconfig
arm                        clps711x_defconfig
openrisc                  or1klitex_defconfig
powerpc                    amigaone_defconfig
sh                ecovec24-romimage_defconfig
mips                         cobalt_defconfig
m68k                        m5407c3_defconfig
arm                            lart_defconfig
arm                           spitz_defconfig
arm                         palmz72_defconfig
arm                         lpc32xx_defconfig
ia64                             alldefconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
arm                       imx_v6_v7_defconfig
mips                           jazz_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      ppc6xx_defconfig
sh                   sh7770_generic_defconfig
sh                           sh2007_defconfig
xtensa                  cadence_csp_defconfig
xtensa                    xip_kc705_defconfig
sh                             sh03_defconfig
arm                           omap1_defconfig
arm                     am200epdkit_defconfig
sh                     sh7710voipgw_defconfig
m68k                          multi_defconfig
sh                      rts7751r2d1_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                            mac_defconfig
um                            kunit_defconfig
mips                      maltasmvp_defconfig
mips                           gcw0_defconfig
arm                          moxart_defconfig
m68k                       m5475evb_defconfig
arm                           viper_defconfig
m68k                             alldefconfig
arm                          gemini_defconfig
mips                           mtx1_defconfig
arm                         lubbock_defconfig
arc                           tb10x_defconfig
mips                            gpr_defconfig
m68k                          hp300_defconfig
s390                          debug_defconfig
sh                 kfr2r09-romimage_defconfig
arm                             mxs_defconfig
mips                          malta_defconfig
arm                           u8500_defconfig
powerpc                    socrates_defconfig
mips                            ar7_defconfig
sh                          sdk7786_defconfig
sh                            shmin_defconfig
arm                           sunxi_defconfig
arm                            zeus_defconfig
arm                      footbridge_defconfig
powerpc                        warp_defconfig
mips                           ip22_defconfig
sh                          lboxre2_defconfig
arm                         hackkit_defconfig
nios2                            alldefconfig
powerpc                     mpc5200_defconfig
powerpc                      ep88xc_defconfig
m68k                          amiga_defconfig
arm                  colibri_pxa270_defconfig
mips                         rt305x_defconfig
arm                            xcep_defconfig
ia64                            zx1_defconfig
sh                  sh7785lcr_32bit_defconfig
um                               allmodconfig
powerpc                      pasemi_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          ep93xx_defconfig
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
x86_64               randconfig-a004-20210408
x86_64               randconfig-a005-20210408
x86_64               randconfig-a003-20210408
x86_64               randconfig-a001-20210408
x86_64               randconfig-a002-20210408
x86_64               randconfig-a006-20210408
i386                 randconfig-a006-20210408
i386                 randconfig-a003-20210408
i386                 randconfig-a001-20210408
i386                 randconfig-a004-20210408
i386                 randconfig-a005-20210408
i386                 randconfig-a002-20210408
i386                 randconfig-a014-20210408
i386                 randconfig-a016-20210408
i386                 randconfig-a011-20210408
i386                 randconfig-a012-20210408
i386                 randconfig-a013-20210408
i386                 randconfig-a015-20210408
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210408
x86_64               randconfig-a015-20210408
x86_64               randconfig-a012-20210408
x86_64               randconfig-a011-20210408
x86_64               randconfig-a013-20210408
x86_64               randconfig-a016-20210408

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

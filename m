Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F009A33FEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCRFTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:19:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:20445 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhCRFSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:18:45 -0400
IronPort-SDR: s7kyncFxt9Y2qrXJC7EFzzd5kOYZ7uEeLDiFvrHnOJFNmlMFRIEUjs9s6X459kBuqs5JVDXLdr
 YV1Mwmmp5PXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="189648736"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="189648736"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 22:18:45 -0700
IronPort-SDR: 1EcvLX+puQ92SaGZ1qa7s5YHroXIBiqmtEEZqLYHMtojf3K+WmJ1NIkDKv67aYwfJXLab4k9DX
 TiD7MlamL3qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="379600409"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 17 Mar 2021 22:18:43 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMl3T-00012F-5o; Thu, 18 Mar 2021 05:18:43 +0000
Date:   Thu, 18 Mar 2021 13:18:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 bee645788e07eea63055d261d2884ea45c2ba857
Message-ID: <6052e2a8.AgRRycYAegn3qHXZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: bee645788e07eea63055d261d2884ea45c2ba857  locking/ww_mutex: Fix acquire/release imbalance in ww_acquire_init()/ww_acquire_fini()

elapsed time: 723m

configs tested: 161
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
powerpc                 mpc8540_ads_defconfig
arm                         at91_dt_defconfig
arc                            hsdk_defconfig
mips                        nlm_xlr_defconfig
sh                              ul2_defconfig
mips                        workpad_defconfig
arm                         hackkit_defconfig
arm                         lpc18xx_defconfig
powerpc                      pcm030_defconfig
m68k                             allmodconfig
powerpc                     taishan_defconfig
h8300                     edosk2674_defconfig
powerpc                     redwood_defconfig
mips                        qi_lb60_defconfig
mips                            gpr_defconfig
m68k                       bvme6000_defconfig
powerpc                      acadia_defconfig
arm                          pxa910_defconfig
sh                         ecovec24_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                            mmp2_defconfig
arm                         palmz72_defconfig
arm                          iop32x_defconfig
arm                        neponset_defconfig
powerpc                     kilauea_defconfig
sh                          landisk_defconfig
powerpc                    mvme5100_defconfig
m68k                       m5249evb_defconfig
sh                            titan_defconfig
powerpc                      walnut_defconfig
powerpc                     rainier_defconfig
powerpc                    gamecube_defconfig
sh                            shmin_defconfig
openrisc                 simple_smp_defconfig
mips                           gcw0_defconfig
sh                         apsh4a3a_defconfig
powerpc                         wii_defconfig
powerpc                       eiger_defconfig
mips                       bmips_be_defconfig
m68k                        stmark2_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
arm                         assabet_defconfig
arc                              alldefconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                          moxart_defconfig
powerpc                          allyesconfig
mips                           ip32_defconfig
ia64                         bigsur_defconfig
arm                        multi_v7_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   lite5200b_defconfig
csky                             alldefconfig
arm                       imx_v4_v5_defconfig
mips                     loongson1b_defconfig
h8300                    h8300h-sim_defconfig
sh                        sh7757lcr_defconfig
arm                     eseries_pxa_defconfig
arm                            lart_defconfig
mips                      bmips_stb_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     skiroot_defconfig
sh                     sh7710voipgw_defconfig
powerpc                       ebony_defconfig
arm                      footbridge_defconfig
mips                        bcm47xx_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
arm                         lpc32xx_defconfig
sh                          lboxre2_defconfig
arm                           sama5_defconfig
mips                        nlm_xlp_defconfig
sh                             espt_defconfig
sh                   secureedge5410_defconfig
riscv                             allnoconfig
arc                        nsimosci_defconfig
powerpc                    sam440ep_defconfig
arm                         bcm2835_defconfig
arm                          ixp4xx_defconfig
mips                        vocore2_defconfig
xtensa                       common_defconfig
m68k                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210317
x86_64               randconfig-a001-20210317
x86_64               randconfig-a005-20210317
x86_64               randconfig-a004-20210317
x86_64               randconfig-a003-20210317
x86_64               randconfig-a002-20210317
i386                 randconfig-a001-20210317
i386                 randconfig-a005-20210317
i386                 randconfig-a002-20210317
i386                 randconfig-a003-20210317
i386                 randconfig-a004-20210317
i386                 randconfig-a006-20210317
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
i386                 randconfig-a013-20210317
i386                 randconfig-a016-20210317
i386                 randconfig-a011-20210317
i386                 randconfig-a012-20210317
i386                 randconfig-a015-20210317
i386                 randconfig-a014-20210317
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210317
x86_64               randconfig-a016-20210317
x86_64               randconfig-a013-20210317
x86_64               randconfig-a014-20210317
x86_64               randconfig-a015-20210317
x86_64               randconfig-a012-20210317

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

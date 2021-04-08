Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B105357D69
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhDHHdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:33:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:7693 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDHHdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:33:45 -0400
IronPort-SDR: 4ny5d8iQbijkWBBwY3SyFzIEwNDXiMZB4O4KJNAVCOo9CtKebkwFFMedwJRmS9k96XFCvHIaTc
 dTmwwJfeEb3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="180612784"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="180612784"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 00:33:34 -0700
IronPort-SDR: hIwAG84niNW+mOQPyjXxmOMzGikvopSpOS9sS+m6y6iHilwvRGY520IPYcGI3MWCMIDvBi0Ul8
 CrtsTC1b4VlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="530508991"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2021 00:33:32 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUPAS-000ESK-3b; Thu, 08 Apr 2021 07:33:32 +0000
Date:   Thu, 08 Apr 2021 15:32:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 dda451f391eee5d68db3ca87fd8b2a42c8c2b507
Message-ID: <606eb195.aFzq+FpYIFK6cssx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: dda451f391eee5d68db3ca87fd8b2a42c8c2b507  x86/cacheinfo: Remove unneeded dead-store initialization

elapsed time: 723m

configs tested: 151
configs skipped: 62

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
arm                         hackkit_defconfig
arm                           u8500_defconfig
mips                       bmips_be_defconfig
arm                           h5000_defconfig
mips                      loongson3_defconfig
powerpc                    amigaone_defconfig
arc                      axs103_smp_defconfig
mips                        bcm47xx_defconfig
arc                          axs101_defconfig
powerpc                      chrp32_defconfig
arm                        keystone_defconfig
alpha                            allyesconfig
sh                            shmin_defconfig
mips                           ci20_defconfig
arm                        oxnas_v6_defconfig
powerpc                      ppc44x_defconfig
arm                  colibri_pxa300_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         socfpga_defconfig
mips                      malta_kvm_defconfig
i386                                defconfig
mips                             allyesconfig
s390                       zfcpdump_defconfig
nios2                         3c120_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
arm                     eseries_pxa_defconfig
arm                           sama5_defconfig
xtensa                           alldefconfig
m68k                        stmark2_defconfig
arm                        spear3xx_defconfig
arm                            zeus_defconfig
openrisc                  or1klitex_defconfig
arm                         at91_dt_defconfig
sh                   rts7751r2dplus_defconfig
sh                          kfr2r09_defconfig
arm                      footbridge_defconfig
arm                          iop32x_defconfig
powerpc                       maple_defconfig
arc                                 defconfig
arm                        shmobile_defconfig
mips                        maltaup_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                            q40_defconfig
sparc                       sparc32_defconfig
mips                        nlm_xlr_defconfig
sh                          rsk7201_defconfig
arm                         cm_x300_defconfig
sh                          urquell_defconfig
arm                         bcm2835_defconfig
alpha                            alldefconfig
m68k                        m5307c3_defconfig
arm                      tct_hammer_defconfig
mips                           gcw0_defconfig
sh                               alldefconfig
m68k                       m5249evb_defconfig
sh                        sh7763rdp_defconfig
h8300                               defconfig
powerpc                         ps3_defconfig
x86_64                           alldefconfig
arm                            xcep_defconfig
arm                     davinci_all_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      mgcoge_defconfig
powerpc                         wii_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8541_defconfig
mips                            ar7_defconfig
powerpc                        fsp2_defconfig
um                               allyesconfig
arm                       omap2plus_defconfig
powerpc                      ppc40x_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      bamboo_defconfig
mips                      pistachio_defconfig
arm                        trizeps4_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210407
i386                 randconfig-a003-20210407
i386                 randconfig-a001-20210407
i386                 randconfig-a004-20210407
i386                 randconfig-a002-20210407
i386                 randconfig-a005-20210407
x86_64               randconfig-a014-20210407
x86_64               randconfig-a015-20210407
x86_64               randconfig-a013-20210407
x86_64               randconfig-a011-20210407
x86_64               randconfig-a012-20210407
x86_64               randconfig-a016-20210407
i386                 randconfig-a014-20210407
i386                 randconfig-a011-20210407
i386                 randconfig-a016-20210407
i386                 randconfig-a012-20210407
i386                 randconfig-a015-20210407
i386                 randconfig-a013-20210407
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210407
x86_64               randconfig-a003-20210407
x86_64               randconfig-a005-20210407
x86_64               randconfig-a001-20210407
x86_64               randconfig-a002-20210407
x86_64               randconfig-a006-20210407

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

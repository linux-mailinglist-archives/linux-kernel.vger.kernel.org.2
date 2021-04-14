Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28C635FD0D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhDNVSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:18:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:3308 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhDNVSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:18:17 -0400
IronPort-SDR: imFYD4WBkXKQJ5radlh5gEOlC/zdBqbG1ZgN7dY35NGQdRZT6eVRpvl1gPi1CiJVIHSPJ89UZU
 GZK8ODNfLJrg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="192612689"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="192612689"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 14:17:55 -0700
IronPort-SDR: F/U4HWW85KTcEpzp7R4/RbhFmEDHeO/3iCupC/+2iBDx/DNyHEbvV4VetK0JLOaM4R75cDHH3q
 Abj5i/skx+7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="418488968"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2021 14:17:54 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWmtV-0000Kp-HW; Wed, 14 Apr 2021 21:17:53 +0000
Date:   Thu, 15 Apr 2021 05:17:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 c361e5d4d07d63768880e1994c7ed999b3a94cd9
Message-ID: <60775bdc.qJKsJPYg/0FDbXKu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: c361e5d4d07d63768880e1994c7ed999b3a94cd9  x86/setup: Move trim_snb_memory() later in setup_arch() to fix boot hangs

elapsed time: 729m

configs tested: 160
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                           ip28_defconfig
powerpc                     asp8347_defconfig
ia64                        generic_defconfig
arc                     nsimosci_hs_defconfig
arm                           corgi_defconfig
arm                       versatile_defconfig
m68k                          sun3x_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     mpc83xx_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc8272_ads_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      cm5200_defconfig
mips                        maltaup_defconfig
xtensa                    smp_lx200_defconfig
mips                           rs90_defconfig
arc                          axs101_defconfig
mips                  cavium_octeon_defconfig
mips                        jmr3927_defconfig
xtensa                           alldefconfig
xtensa                  cadence_csp_defconfig
powerpc                       maple_defconfig
arm                          ep93xx_defconfig
mips                            e55_defconfig
ia64                      gensparse_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
powerpc                      obs600_defconfig
arm                            mmp2_defconfig
arc                        nsim_700_defconfig
sh                          urquell_defconfig
arm                       cns3420vb_defconfig
powerpc                          g5_defconfig
arm                         palmz72_defconfig
sh                          rsk7264_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        spear6xx_defconfig
mips                      bmips_stb_defconfig
mips                          malta_defconfig
arm                            zeus_defconfig
mips                     cu1830-neo_defconfig
arm                          gemini_defconfig
microblaze                          defconfig
riscv                          rv32_defconfig
arc                        vdk_hs38_defconfig
arm                         s3c6400_defconfig
arm                          pcm027_defconfig
arm                            mps2_defconfig
arm                          simpad_defconfig
arm                      tct_hammer_defconfig
sh                           se7751_defconfig
mips                      malta_kvm_defconfig
openrisc                    or1ksim_defconfig
arm                         axm55xx_defconfig
sh                           se7722_defconfig
m68k                       m5475evb_defconfig
mips                      fuloong2e_defconfig
mips                     decstation_defconfig
powerpc                     tqm8548_defconfig
arm                         at91_dt_defconfig
sparc                            alldefconfig
arm                        realview_defconfig
m68k                       m5275evb_defconfig
arc                           tb10x_defconfig
powerpc                 mpc8540_ads_defconfig
arm                          collie_defconfig
mips                        bcm63xx_defconfig
nios2                            allyesconfig
powerpc                   motionpro_defconfig
m68k                          hp300_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
sparc                            allyesconfig
powerpc                      acadia_defconfig
powerpc                    socrates_defconfig
mips                           jazz_defconfig
sh                        apsh4ad0a_defconfig
um                            kunit_defconfig
mips                         cobalt_defconfig
powerpc                    sam440ep_defconfig
arm                             pxa_defconfig
arm                         hackkit_defconfig
mips                     loongson1c_defconfig
powerpc                     tqm8555_defconfig
arc                        nsimosci_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210414
i386                 randconfig-a006-20210414
i386                 randconfig-a001-20210414
i386                 randconfig-a005-20210414
i386                 randconfig-a004-20210414
i386                 randconfig-a002-20210414
x86_64               randconfig-a014-20210414
x86_64               randconfig-a015-20210414
x86_64               randconfig-a011-20210414
x86_64               randconfig-a013-20210414
x86_64               randconfig-a012-20210414
x86_64               randconfig-a016-20210414
i386                 randconfig-a015-20210414
i386                 randconfig-a014-20210414
i386                 randconfig-a013-20210414
i386                 randconfig-a012-20210414
i386                 randconfig-a016-20210414
i386                 randconfig-a011-20210414
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a003-20210414
x86_64               randconfig-a002-20210414
x86_64               randconfig-a005-20210414
x86_64               randconfig-a001-20210414
x86_64               randconfig-a006-20210414
x86_64               randconfig-a004-20210414

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

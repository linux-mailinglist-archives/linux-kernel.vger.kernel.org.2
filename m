Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADC835FD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhDNVST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:18:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:21136 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhDNVSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:18:17 -0400
IronPort-SDR: jx9r/j6nRv7AgzzVQoY0UjD/YxwRZnUOD15bX6zZq2lyMveUc/xRleidnkmA7P+Lk6Ew6OZzOu
 qjwrGUJMir5A==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174236545"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="174236545"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 14:17:55 -0700
IronPort-SDR: ZOtcfsai3EFKRmMbSrXh28LlnXx+3kkgAap8KAK2gUGmy7gm7LxYNDtkV/bb3H+PH2o+TKUvz8
 MICFSBWf/dYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="532912219"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2021 14:17:54 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWmtV-0000Ka-AJ; Wed, 14 Apr 2021 21:17:53 +0000
Date:   Thu, 15 Apr 2021 05:17:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 16854b567dff767e5ec5e6dc23021271136733a5
Message-ID: <60775bdf.LO5VqtJtw/FAPOdK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 16854b567dff767e5ec5e6dc23021271136733a5  x86/pat: Do not compile stubbed functions when X86_PAT is off

elapsed time: 729m

configs tested: 185
configs skipped: 136

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
arc                        vdk_hs38_defconfig
sparc                            alldefconfig
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
arm                           corgi_defconfig
sh                           se7724_defconfig
powerpc                      obs600_defconfig
arm                            mmp2_defconfig
arc                        nsim_700_defconfig
sh                          urquell_defconfig
arm                       cns3420vb_defconfig
powerpc                          g5_defconfig
arm                         palmz72_defconfig
mips                         tb0287_defconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
powerpc                     ep8248e_defconfig
sh                         ap325rxa_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
arm                         s3c2410_defconfig
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
riscv                            alldefconfig
arm                          exynos_defconfig
xtensa                          iss_defconfig
powerpc                     ksi8560_defconfig
powerpc                     ppa8548_defconfig
arm                           h3600_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                              defconfig
sh                   rts7751r2dplus_defconfig
arm                      jornada720_defconfig
alpha                            alldefconfig
powerpc                   currituck_defconfig
mips                          ath25_defconfig
mips                            gpr_defconfig
mips                           ci20_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    sam440ep_defconfig
sh                          rsk7203_defconfig
sh                            hp6xx_defconfig
powerpc64                           defconfig
powerpc                      arches_defconfig
h8300                            alldefconfig
powerpc                 mpc837x_rdb_defconfig
arm                      tct_hammer_defconfig
sh                           se7751_defconfig
openrisc                    or1ksim_defconfig
arm                         axm55xx_defconfig
m68k                       m5475evb_defconfig
mips                     decstation_defconfig
powerpc                     tqm8548_defconfig
openrisc                  or1klitex_defconfig
powerpc                      ppc64e_defconfig
arm                          badge4_defconfig
arm                         at91_dt_defconfig
arm                        realview_defconfig
m68k                       m5275evb_defconfig
arc                           tb10x_defconfig
powerpc                   motionpro_defconfig
m68k                          hp300_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
sparc                            allyesconfig
powerpc                      acadia_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                            q40_defconfig
m68k                       m5249evb_defconfig
powerpc                     tqm8555_defconfig
powerpc                     tqm8540_defconfig
powerpc                    socrates_defconfig
mips                           jazz_defconfig
sh                        apsh4ad0a_defconfig
um                            kunit_defconfig
mips                         cobalt_defconfig
powerpc                         ps3_defconfig
powerpc                       eiger_defconfig
powerpc                     mpc512x_defconfig
arm                             pxa_defconfig
arm                         hackkit_defconfig
mips                     loongson1c_defconfig
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

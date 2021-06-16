Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B163A94CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhFPIOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:14:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:32050 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhFPIOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:14:46 -0400
IronPort-SDR: d7Wo5wPfZm8s8GWa2+ybJXBddNgu8pMIpyNmjpi45ebc3hVn9JGLr598aw5bbLXBr3NdC+meYH
 YEEP86VgHaPQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="205953999"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="205953999"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 01:12:40 -0700
IronPort-SDR: vlVW7clY1i+PiZUtXCit4U9PEMAuDU+jtogZwTvBdz6tKokcyhIW0Kcu4XWEAuLlBhIo5NIrNK
 mJyGmj0wA5Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="421410209"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Jun 2021 01:12:38 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltQf7-000128-DP; Wed, 16 Jun 2021 08:12:37 +0000
Date:   Wed, 16 Jun 2021 16:12:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.06.11a] BUILD SUCCESS
 7895adfcd6ecd084515d0d9e69c439d90187acb0
Message-ID: <60c9b26b.TvowrQvySaE95i4w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.06.11a
branch HEAD: 7895adfcd6ecd084515d0d9e69c439d90187acb0  kcsan: Make strict mode imply interruptible watchers

elapsed time: 721m

configs tested: 142
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc866_ads_defconfig
mips                     cu1000-neo_defconfig
ia64                        generic_defconfig
arm                       versatile_defconfig
arm                         lpc32xx_defconfig
powerpc                      chrp32_defconfig
xtensa                    smp_lx200_defconfig
mips                          ath79_defconfig
powerpc                  iss476-smp_defconfig
sh                 kfr2r09-romimage_defconfig
mips                        omega2p_defconfig
powerpc                   currituck_defconfig
um                               alldefconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
arm                        multi_v7_defconfig
nds32                               defconfig
powerpc                          g5_defconfig
arm                            hisi_defconfig
xtensa                          iss_defconfig
powerpc                     kmeter1_defconfig
powerpc                   lite5200b_defconfig
arm                        neponset_defconfig
m68k                         apollo_defconfig
mips                          rm200_defconfig
sh                          sdk7786_defconfig
powerpc                      arches_defconfig
alpha                               defconfig
arm                         s3c2410_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
mips                      bmips_stb_defconfig
um                            kunit_defconfig
arm                            zeus_defconfig
m68k                          atari_defconfig
arm                        mvebu_v5_defconfig
ia64                            zx1_defconfig
powerpc                     ksi8560_defconfig
ia64                             alldefconfig
h8300                       h8s-sim_defconfig
arm                           u8500_defconfig
powerpc                       holly_defconfig
sh                        sh7785lcr_defconfig
m68k                       m5275evb_defconfig
arm                        keystone_defconfig
arm                         palmz72_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                        fsp2_defconfig
powerpc                     sbc8548_defconfig
s390                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                        warp_defconfig
powerpc                     tqm8560_defconfig
powerpc                      ppc44x_defconfig
m68k                          sun3x_defconfig
i386                                defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
arm                              alldefconfig
s390                          debug_defconfig
powerpc                 mpc832x_mds_defconfig
sparc                       sparc64_defconfig
riscv                          rv32_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7751_defconfig
x86_64                           alldefconfig
mips                       bmips_be_defconfig
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
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210615
i386                 randconfig-a006-20210615
i386                 randconfig-a004-20210615
i386                 randconfig-a001-20210615
i386                 randconfig-a005-20210615
i386                 randconfig-a003-20210615
x86_64               randconfig-a001-20210615
x86_64               randconfig-a004-20210615
x86_64               randconfig-a002-20210615
x86_64               randconfig-a003-20210615
x86_64               randconfig-a006-20210615
x86_64               randconfig-a005-20210615
i386                 randconfig-a015-20210615
i386                 randconfig-a013-20210615
i386                 randconfig-a016-20210615
i386                 randconfig-a012-20210615
i386                 randconfig-a014-20210615
i386                 randconfig-a011-20210615
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210615
x86_64               randconfig-a015-20210615
x86_64               randconfig-a011-20210615
x86_64               randconfig-a012-20210615
x86_64               randconfig-a014-20210615
x86_64               randconfig-a016-20210615
x86_64               randconfig-a013-20210615

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

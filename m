Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D11305B32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhA0MYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:24:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:65042 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S314070AbhAZW4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:56:20 -0500
IronPort-SDR: 4FABT/06W0fbaMXYp47jXyupq6mFdRMM4OTWk65CWonhqSuqris4LPrMjAwGTSP882tmdb26JL
 QzOQkdpqbJGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="179202834"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="179202834"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 14:48:14 -0800
IronPort-SDR: tZfdh69tYWlg1KdFKdDdhap0Mrv80RmijKkEHTYxR1YeOgxup5BcjF7XYYZEBQm1MAeH2XgTYt
 5yhmQMZ4W6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="362161864"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2021 14:48:13 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l4X88-00017V-IQ; Tue, 26 Jan 2021 22:48:12 +0000
Date:   Wed, 27 Jan 2021 06:47:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d38edbe14262950938ee5c2ade4b8894ab1292de
Message-ID: <60109c0f.2uWQkXyWRE7r67W9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: d38edbe14262950938ee5c2ade4b8894ab1292de  Merge branch 'locking/core'

elapsed time: 727m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc885_ads_defconfig
s390                          debug_defconfig
mips                        omega2p_defconfig
arm                           stm32_defconfig
mips                  decstation_64_defconfig
microblaze                      mmu_defconfig
xtensa                         virt_defconfig
arc                         haps_hs_defconfig
arm                          prima2_defconfig
mips                           rs90_defconfig
arm                            xcep_defconfig
sh                          rsk7203_defconfig
m68k                            q40_defconfig
sh                          sdk7780_defconfig
sh                   secureedge5410_defconfig
arm                        trizeps4_defconfig
arm                          moxart_defconfig
mips                           ip27_defconfig
mips                           jazz_defconfig
arm                           omap1_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                    adder875_defconfig
m68k                        mvme16x_defconfig
mips                           ci20_defconfig
sh                                  defconfig
arm                       cns3420vb_defconfig
arm                             ezx_defconfig
m68k                        mvme147_defconfig
xtensa                    xip_kc705_defconfig
arm                       imx_v6_v7_defconfig
arm                        realview_defconfig
arm                         vf610m4_defconfig
alpha                               defconfig
arm                  colibri_pxa300_defconfig
c6x                                 defconfig
powerpc                     taishan_defconfig
arm                            hisi_defconfig
um                            kunit_defconfig
sh                        edosk7705_defconfig
powerpc                     mpc5200_defconfig
powerpc                     redwood_defconfig
powerpc                      ppc64e_defconfig
arm                   milbeaut_m10v_defconfig
xtensa                          iss_defconfig
arm                      jornada720_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                        spear6xx_defconfig
arm                            lart_defconfig
arm                        spear3xx_defconfig
mips                      fuloong2e_defconfig
powerpc                    klondike_defconfig
arm                              zx_defconfig
sh                               allmodconfig
arm                        mvebu_v7_defconfig
arm                            qcom_defconfig
arm                        shmobile_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     pseries_defconfig
arm                          lpd270_defconfig
mips                           ip28_defconfig
powerpc                   bluestone_defconfig
sh                           se7751_defconfig
mips                        qi_lb60_defconfig
powerpc                        icon_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a001-20210126
i386                 randconfig-a002-20210126
i386                 randconfig-a004-20210126
i386                 randconfig-a006-20210126
i386                 randconfig-a003-20210126
i386                 randconfig-a005-20210126
x86_64               randconfig-a012-20210126
x86_64               randconfig-a016-20210126
x86_64               randconfig-a015-20210126
x86_64               randconfig-a011-20210126
x86_64               randconfig-a013-20210126
x86_64               randconfig-a014-20210126
i386                 randconfig-a013-20210126
i386                 randconfig-a011-20210126
i386                 randconfig-a012-20210126
i386                 randconfig-a015-20210126
i386                 randconfig-a014-20210126
i386                 randconfig-a016-20210126
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210126
x86_64               randconfig-a002-20210126
x86_64               randconfig-a001-20210126
x86_64               randconfig-a005-20210126
x86_64               randconfig-a006-20210126
x86_64               randconfig-a004-20210126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

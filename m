Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50521345223
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhCVV5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:57:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:43647 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhCVV4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:56:50 -0400
IronPort-SDR: is0bOTkUMeCY0qgwURyx0YATkSzpZbOdEtzqoG5gog1/G1SDpPmodZDXlEAC1Zyan8YGWy8LnV
 dr0lqfM8WIBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189756041"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="189756041"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 14:56:50 -0700
IronPort-SDR: DdgA66AeDLbjEGAV/+BJeYN4P+uR0BP51z2AbNEShko3NUKb4RQmwnKWXuyqwFRTPqyW73oMFK
 XBsHxgkE98yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="407997761"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Mar 2021 14:56:48 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lOSXX-0000Fx-0U; Mon, 22 Mar 2021 21:56:47 +0000
Date:   Tue, 23 Mar 2021 05:56:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/entry] BUILD SUCCESS
 97258ce902d1e1c396a4d7c38f6ae7085adb73c5
Message-ID: <60591288.3TX3iA9NDceZuYr7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
branch HEAD: 97258ce902d1e1c396a4d7c38f6ae7085adb73c5  entry: Fix typos in comments

elapsed time: 972m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                              allyesconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                         socfpga_defconfig
m68k                         apollo_defconfig
parisc                generic-64bit_defconfig
xtensa                       common_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                       m5208evb_defconfig
arc                         haps_hs_defconfig
sh                   rts7751r2dplus_defconfig
sh                                  defconfig
sh                          urquell_defconfig
xtensa                    xip_kc705_defconfig
sh                        sh7757lcr_defconfig
m68k                        m5407c3_defconfig
sh                          polaris_defconfig
powerpc                      mgcoge_defconfig
mips                      pic32mzda_defconfig
powerpc                      arches_defconfig
arm                            mmp2_defconfig
m68k                       m5475evb_defconfig
mips                          rm200_defconfig
alpha                            allyesconfig
powerpc                     skiroot_defconfig
arc                          axs103_defconfig
nds32                            alldefconfig
arm                          pcm027_defconfig
powerpc                       ppc64_defconfig
mips                       lemote2f_defconfig
mips                           ip28_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
powerpc                      katmai_defconfig
sh                        edosk7705_defconfig
arm                     eseries_pxa_defconfig
arm                      tct_hammer_defconfig
powerpc                      walnut_defconfig
arm                      footbridge_defconfig
mips                   sb1250_swarm_defconfig
sh                               alldefconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     ep8248e_defconfig
sh                     magicpanelr2_defconfig
powerpc                    klondike_defconfig
sh                        dreamcast_defconfig
powerpc                     kilauea_defconfig
powerpc                    sam440ep_defconfig
m68k                          hp300_defconfig
powerpc                   bluestone_defconfig
m68k                       m5275evb_defconfig
i386                                defconfig
sh                          rsk7201_defconfig
powerpc                  iss476-smp_defconfig
mips                           ip27_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     kmeter1_defconfig
ia64                          tiger_defconfig
arm                        vexpress_defconfig
ia64                      gensparse_defconfig
mips                         db1xxx_defconfig
arm                       versatile_defconfig
arm                            dove_defconfig
mips                        vocore2_defconfig
arm                          simpad_defconfig
powerpc                 mpc836x_rdk_defconfig
openrisc                         alldefconfig
m68k                       m5249evb_defconfig
mips                        maltaup_defconfig
arm                           omap1_defconfig
powerpc                 mpc8272_ads_defconfig
mips                            gpr_defconfig
sh                           se7619_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc8315_rdb_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210322
i386                 randconfig-a003-20210322
i386                 randconfig-a001-20210322
i386                 randconfig-a002-20210322
i386                 randconfig-a006-20210322
i386                 randconfig-a005-20210322
x86_64               randconfig-a012-20210322
x86_64               randconfig-a015-20210322
x86_64               randconfig-a013-20210322
x86_64               randconfig-a014-20210322
x86_64               randconfig-a016-20210322
x86_64               randconfig-a011-20210322
i386                 randconfig-a014-20210322
i386                 randconfig-a011-20210322
i386                 randconfig-a015-20210322
i386                 randconfig-a016-20210322
i386                 randconfig-a012-20210322
i386                 randconfig-a013-20210322
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210322
x86_64               randconfig-a003-20210322
x86_64               randconfig-a001-20210322
x86_64               randconfig-a006-20210322
x86_64               randconfig-a004-20210322
x86_64               randconfig-a005-20210322

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

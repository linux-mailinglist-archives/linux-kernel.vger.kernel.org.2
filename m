Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C694C336A85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 04:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCKDSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 22:18:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:44098 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhCKDRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 22:17:54 -0500
IronPort-SDR: Qj3vshhmFLf0jrzemF8M0Kw/LGojW6UnIpgiaH4dsGqk7rlhhYlQu3D52dpbg+u1WuTckHSyit
 KSDdcGS5bwKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="185249564"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="185249564"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 19:17:54 -0800
IronPort-SDR: e9LwpeyRJS/tdW/2TjhMNtF1jBgiCNsxsoblgAjm6r3Z1p0pAh7qgvwznoJRrRt0mU9hRcAYzJ
 JfHR7l66dwvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="431449739"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2021 19:17:53 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKBpg-0000Xh-Ep; Thu, 11 Mar 2021 03:17:52 +0000
Date:   Thu, 11 Mar 2021 11:17:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 b18adee4ce4443399963826b5d28d9e63d40740c
Message-ID: <60498baf.3mDQRchwcVzmqvAW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: b18adee4ce4443399963826b5d28d9e63d40740c  stacktrace: Move documentation for arch_stack_walk_reliable() to header

elapsed time: 726m

configs tested: 162
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sparc                            allyesconfig
mips                         db1xxx_defconfig
powerpc                     tqm8540_defconfig
powerpc                      ppc44x_defconfig
h8300                       h8s-sim_defconfig
arm                         cm_x300_defconfig
m68k                             alldefconfig
sh                          rsk7264_defconfig
sh                         microdev_defconfig
arm                       imx_v4_v5_defconfig
csky                                defconfig
arm                         s5pv210_defconfig
arm                           h5000_defconfig
ia64                         bigsur_defconfig
powerpc                   motionpro_defconfig
nios2                            alldefconfig
arm                     eseries_pxa_defconfig
powerpc                     sbc8548_defconfig
sh                        dreamcast_defconfig
parisc                           alldefconfig
arm                             mxs_defconfig
sh                          r7785rp_defconfig
sh                            titan_defconfig
sh                           se7712_defconfig
powerpc                mpc7448_hpc2_defconfig
sparc                            alldefconfig
m68k                         amcore_defconfig
m68k                          multi_defconfig
sh                           se7721_defconfig
powerpc                    sam440ep_defconfig
powerpc                     akebono_defconfig
mips                        jmr3927_defconfig
mips                        nlm_xlp_defconfig
sh                                  defconfig
powerpc                 mpc832x_rdb_defconfig
arm                       cns3420vb_defconfig
m68k                       m5275evb_defconfig
h8300                               defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
xtensa                  cadence_csp_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc8540_ads_defconfig
arc                         haps_hs_defconfig
powerpc                     skiroot_defconfig
x86_64                              defconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
s390                             allmodconfig
powerpc                       eiger_defconfig
powerpc                      ep88xc_defconfig
mips                           jazz_defconfig
powerpc                  storcenter_defconfig
arm                       versatile_defconfig
mips                        bcm47xx_defconfig
powerpc                      pmac32_defconfig
s390                       zfcpdump_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      mgcoge_defconfig
sh                            shmin_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    klondike_defconfig
arm                           spitz_defconfig
sh                           se7780_defconfig
arm                          imote2_defconfig
powerpc                      cm5200_defconfig
arm                        mvebu_v7_defconfig
ia64                            zx1_defconfig
powerpc                        cell_defconfig
sh                          lboxre2_defconfig
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
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210308
x86_64               randconfig-a001-20210308
x86_64               randconfig-a004-20210308
x86_64               randconfig-a002-20210308
x86_64               randconfig-a005-20210308
x86_64               randconfig-a003-20210308
i386                 randconfig-a005-20210308
i386                 randconfig-a003-20210308
i386                 randconfig-a002-20210308
i386                 randconfig-a006-20210308
i386                 randconfig-a004-20210308
i386                 randconfig-a001-20210308
i386                 randconfig-a005-20210309
i386                 randconfig-a003-20210309
i386                 randconfig-a002-20210309
i386                 randconfig-a006-20210309
i386                 randconfig-a004-20210309
i386                 randconfig-a001-20210309
x86_64               randconfig-a013-20210309
x86_64               randconfig-a016-20210309
x86_64               randconfig-a015-20210309
x86_64               randconfig-a014-20210309
x86_64               randconfig-a011-20210309
x86_64               randconfig-a012-20210309
x86_64               randconfig-a011-20210310
x86_64               randconfig-a016-20210310
x86_64               randconfig-a013-20210310
x86_64               randconfig-a015-20210310
x86_64               randconfig-a014-20210310
x86_64               randconfig-a012-20210310
i386                 randconfig-a016-20210309
i386                 randconfig-a012-20210309
i386                 randconfig-a014-20210309
i386                 randconfig-a013-20210309
i386                 randconfig-a011-20210309
i386                 randconfig-a015-20210309
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210309
x86_64               randconfig-a001-20210309
x86_64               randconfig-a004-20210309
x86_64               randconfig-a002-20210309
x86_64               randconfig-a005-20210309
x86_64               randconfig-a003-20210309

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EC7389B65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 04:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhETCea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 22:34:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:4824 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhETCe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 22:34:26 -0400
IronPort-SDR: kSYEZWfiQ7qZrk9JQAXTOFQztNPUI8ANtvSRtNStOs8x06Za3TNlJO8+inuubWO/Fcg5Snr7HD
 Owom89JU55/g==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="188255736"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188255736"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 19:32:44 -0700
IronPort-SDR: 76zkQgW04vxf7FnrOiuph11Ov4/lyYBTzBBER9nQuxpFemZisD0RdgmHEozv0uDIauOJdQjn+m
 PbkaoSJK13Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543117297"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2021 19:32:43 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljYUM-0000Oi-P5; Thu, 20 May 2021 02:32:42 +0000
Date:   Thu, 20 May 2021 10:32:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 8919f07276991c7bf0d0802f0356331c5c62f7a2
Message-ID: <60a5ca2c.uvIbQW+eEfUb6amu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 8919f07276991c7bf0d0802f0356331c5c62f7a2  selftest/x86/signal: Include test cases for validating sigaltstack

elapsed time: 720m

configs tested: 189
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
arm64                            alldefconfig
arm                        trizeps4_defconfig
arc                        nsimosci_defconfig
arm                         socfpga_defconfig
arm                         bcm2835_defconfig
arc                            hsdk_defconfig
powerpc                        icon_defconfig
powerpc                    amigaone_defconfig
arm                             mxs_defconfig
powerpc                      katmai_defconfig
powerpc                       eiger_defconfig
mips                         tb0226_defconfig
arm                        clps711x_defconfig
sh                          sdk7780_defconfig
xtensa                       common_defconfig
sh                              ul2_defconfig
arm                         shannon_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      pasemi_defconfig
powerpc                     powernv_defconfig
mips                        qi_lb60_defconfig
arm                          badge4_defconfig
m68k                       m5208evb_defconfig
arm                          pcm027_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       bvme6000_defconfig
m68k                       m5275evb_defconfig
mips                    maltaup_xpa_defconfig
h8300                            alldefconfig
mips                           ip27_defconfig
sh                          rsk7264_defconfig
ia64                                defconfig
m68k                          sun3x_defconfig
arc                          axs103_defconfig
mips                         tb0287_defconfig
powerpc                 canyonlands_defconfig
sh                               allmodconfig
arm                    vt8500_v6_v7_defconfig
powerpc                    adder875_defconfig
ia64                          tiger_defconfig
powerpc                mpc7448_hpc2_defconfig
riscv                            allyesconfig
arm                             pxa_defconfig
sh                          kfr2r09_defconfig
mips                           jazz_defconfig
arm                   milbeaut_m10v_defconfig
sh                            hp6xx_defconfig
mips                        workpad_defconfig
powerpc                 mpc834x_itx_defconfig
arm                      tct_hammer_defconfig
powerpc                      pcm030_defconfig
mips                     cu1000-neo_defconfig
mips                            gpr_defconfig
arm                         s3c2410_defconfig
arm                        spear3xx_defconfig
powerpc                      arches_defconfig
mips                          malta_defconfig
powerpc                  storcenter_defconfig
powerpc                       ppc64_defconfig
mips                             allyesconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                      ep88xc_defconfig
arm                             rpc_defconfig
arm                         assabet_defconfig
mips                           ci20_defconfig
m68k                        mvme147_defconfig
mips                         cobalt_defconfig
sh                           se7705_defconfig
s390                             alldefconfig
m68k                          multi_defconfig
arm                       omap2plus_defconfig
arm                             ezx_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                   bluestone_defconfig
mips                         tb0219_defconfig
mips                           xway_defconfig
xtensa                  cadence_csp_defconfig
arm                       mainstone_defconfig
m68k                        m5307c3_defconfig
arm                       netwinder_defconfig
mips                   sb1250_swarm_defconfig
arc                      axs103_smp_defconfig
arm                           h3600_defconfig
ia64                        generic_defconfig
arm                            hisi_defconfig
powerpc                      ppc40x_defconfig
m68k                            q40_defconfig
powerpc                 mpc8272_ads_defconfig
s390                             allyesconfig
powerpc                   currituck_defconfig
powerpc                     mpc5200_defconfig
xtensa                    xip_kc705_defconfig
mips                         bigsur_defconfig
m68k                             allyesconfig
arm                  colibri_pxa300_defconfig
powerpc                     tqm8541_defconfig
arc                              alldefconfig
powerpc                 mpc834x_mds_defconfig
arc                     haps_hs_smp_defconfig
sh                        apsh4ad0a_defconfig
arm                           viper_defconfig
mips                      bmips_stb_defconfig
sh                             espt_defconfig
arm                        mvebu_v7_defconfig
sh                            shmin_defconfig
arm                         lpc18xx_defconfig
sh                           se7712_defconfig
powerpc                     taishan_defconfig
sh                        dreamcast_defconfig
arm                        oxnas_v6_defconfig
arc                          axs101_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     stx_gp3_defconfig
arm                           sunxi_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210519
i386                 randconfig-a001-20210519
i386                 randconfig-a005-20210519
i386                 randconfig-a004-20210519
i386                 randconfig-a002-20210519
i386                 randconfig-a006-20210519
x86_64               randconfig-a012-20210519
x86_64               randconfig-a015-20210519
x86_64               randconfig-a013-20210519
x86_64               randconfig-a011-20210519
x86_64               randconfig-a016-20210519
x86_64               randconfig-a014-20210519
i386                 randconfig-a014-20210519
i386                 randconfig-a016-20210519
i386                 randconfig-a011-20210519
i386                 randconfig-a015-20210519
i386                 randconfig-a012-20210519
i386                 randconfig-a013-20210519
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210519
x86_64               randconfig-a003-20210519
x86_64               randconfig-a004-20210519
x86_64               randconfig-a005-20210519
x86_64               randconfig-a001-20210519
x86_64               randconfig-a002-20210519
x86_64               randconfig-a006-20210519

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

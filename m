Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496FA331BDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhCIAnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:43:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:55544 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhCIAnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:43:42 -0500
IronPort-SDR: 06o+ORTrUfFA6cRc+TlfeifY2Epuj/Bj+c6zkkk1DthF1XCh/U+KUqL32KMxBk2kJsg3LpwZNo
 KeK4Bjb6tN6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="249510096"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="249510096"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 16:43:41 -0800
IronPort-SDR: itquM/X4pgjxm/D5ewqo61PTqDc5kc3MeU5NgVxdcasIYPMtgbqdtN74xdDCVmVaLBdXwRqlNR
 ctMp6kOw22nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="447315620"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2021 16:43:40 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lJQTL-0001Fr-MZ; Tue, 09 Mar 2021 00:43:39 +0000
Date:   Tue, 09 Mar 2021 08:43:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 09141ec0e4efede4fb5e2aa68cb819fba974325c
Message-ID: <6046c49b.+3hJvZgQhPHqGv/b%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 09141ec0e4efede4fb5e2aa68cb819fba974325c  x86: Remove duplicate TSC DEADLINE MSR definitions

elapsed time: 728m

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
mips                        workpad_defconfig
nds32                               defconfig
sh                           se7724_defconfig
mips                         bigsur_defconfig
mips                          ath25_defconfig
m68k                           sun3_defconfig
powerpc                     akebono_defconfig
sh                          polaris_defconfig
sh                          rsk7264_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
mips                           gcw0_defconfig
arm                            lart_defconfig
sh                        edosk7705_defconfig
sh                          sdk7780_defconfig
sh                        edosk7760_defconfig
powerpc                          g5_defconfig
csky                             alldefconfig
sh                         ap325rxa_defconfig
m68k                       m5208evb_defconfig
powerpc                       ppc64_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           ci20_defconfig
sh                          rsk7201_defconfig
powerpc                  mpc885_ads_defconfig
nds32                            alldefconfig
parisc                generic-32bit_defconfig
sh                          lboxre2_defconfig
arm                         socfpga_defconfig
powerpc                     pseries_defconfig
arm                         s5pv210_defconfig
mips                    maltaup_xpa_defconfig
mips                        vocore2_defconfig
sh                          rsk7203_defconfig
sh                           se7619_defconfig
powerpc                        cell_defconfig
arm                          pxa3xx_defconfig
arm                           spitz_defconfig
mips                      maltaaprp_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
arm                             rpc_defconfig
arm                        mvebu_v7_defconfig
powerpc                     stx_gp3_defconfig
sparc                            allyesconfig
sh                             espt_defconfig
m68k                          sun3x_defconfig
sparc                       sparc64_defconfig
mips                  maltasmvp_eva_defconfig
arm                       imx_v6_v7_defconfig
arm                             ezx_defconfig
arm                        trizeps4_defconfig
arm                             mxs_defconfig
arm                        cerfcube_defconfig
sh                           se7343_defconfig
sh                        sh7785lcr_defconfig
h8300                       h8s-sim_defconfig
powerpc                      mgcoge_defconfig
sh                             sh03_defconfig
mips                       capcella_defconfig
xtensa                  audio_kc705_defconfig
arc                          axs101_defconfig
powerpc                    ge_imp3a_defconfig
mips                           jazz_defconfig
ia64                        generic_defconfig
mips                         tb0226_defconfig
sh                           se7705_defconfig
arm                         bcm2835_defconfig
arm                        keystone_defconfig
mips                            gpr_defconfig
arm                        neponset_defconfig
arm                       aspeed_g5_defconfig
sh                          sdk7786_defconfig
arm                           u8500_defconfig
mips                         mpc30x_defconfig
mips                  decstation_64_defconfig
sh                           se7721_defconfig
m68k                        mvme16x_defconfig
arc                           tb10x_defconfig
mips                         tb0219_defconfig
powerpc                 mpc8272_ads_defconfig
sh                ecovec24-romimage_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
mips                           ip28_defconfig
powerpc                     redwood_defconfig
powerpc                     tqm5200_defconfig
sh                              ul2_defconfig
sh                   rts7751r2dplus_defconfig
arm                        oxnas_v6_defconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
i386                 randconfig-a016-20210308
i386                 randconfig-a012-20210308
i386                 randconfig-a014-20210308
i386                 randconfig-a013-20210308
i386                 randconfig-a011-20210308
i386                 randconfig-a015-20210308
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
x86_64                              defconfig
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
x86_64               randconfig-a013-20210308
x86_64               randconfig-a016-20210308
x86_64               randconfig-a015-20210308
x86_64               randconfig-a014-20210308
x86_64               randconfig-a011-20210308
x86_64               randconfig-a012-20210308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

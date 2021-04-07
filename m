Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8939B35761E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhDGUdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:33:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:2811 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236354AbhDGUcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:32:55 -0400
IronPort-SDR: yMAtkAeQCtB/HLTQMkxo7Wek3oPAwmatJwr2zYyoknA7bnElDsZYul0vyng0LmzTeFlFSmpBa9
 S7b+h15eVRng==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="254731711"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="254731711"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 13:32:45 -0700
IronPort-SDR: 9MPV4pFglu3gOrjkH0iUNWGEgFK9htNbfFIg1LYQaewGOSiQQeVAOu9Pkue0wi9WQHuvL0sV5y
 CIjGwH+j5l9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="387129643"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Apr 2021 13:32:43 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUEqx-000Dmq-7A; Wed, 07 Apr 2021 20:32:43 +0000
Date:   Thu, 08 Apr 2021 04:32:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0dbed2a2774fedaf52e1fc6ddb4106f9e53bc7f3
Message-ID: <606e16cf.QTTvMzhs6HoAySt2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 0dbed2a2774fedaf52e1fc6ddb4106f9e53bc7f3  Merge branch 'linus'

elapsed time: 727m

configs tested: 188
configs skipped: 3

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
riscv                            allyesconfig
i386                             allyesconfig
nios2                               defconfig
arc                          axs101_defconfig
alpha                            alldefconfig
s390                                defconfig
mips                        nlm_xlp_defconfig
m68k                                defconfig
powerpc                    amigaone_defconfig
arc                      axs103_smp_defconfig
mips                             allyesconfig
mips                        bcm47xx_defconfig
powerpc                 mpc834x_itx_defconfig
mips                  maltasmvp_eva_defconfig
arm                       netwinder_defconfig
arm                     am200epdkit_defconfig
mips                          rb532_defconfig
arm                            qcom_defconfig
powerpc                    mvme5100_defconfig
s390                             allyesconfig
m68k                       m5275evb_defconfig
arc                        nsimosci_defconfig
sh                          lboxre2_defconfig
mips                         tb0287_defconfig
arm                         lpc18xx_defconfig
powerpc                      ep88xc_defconfig
arm                     eseries_pxa_defconfig
sparc                            alldefconfig
sparc                       sparc32_defconfig
mips                           ip28_defconfig
sh                               alldefconfig
powerpc               mpc834x_itxgp_defconfig
sh                             espt_defconfig
powerpc64                           defconfig
m68k                          sun3x_defconfig
arm                         mv78xx0_defconfig
powerpc                   motionpro_defconfig
arm                             pxa_defconfig
arm                          iop32x_defconfig
sh                           sh2007_defconfig
mips                           ip27_defconfig
powerpc                           allnoconfig
sh                      rts7751r2d1_defconfig
sh                          rsk7264_defconfig
powerpc                          allyesconfig
mips                     loongson1c_defconfig
sh                           se7780_defconfig
s390                       zfcpdump_defconfig
nios2                         3c120_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
powerpc                      ppc44x_defconfig
nds32                               defconfig
m68k                       m5208evb_defconfig
mips                          malta_defconfig
sh                            hp6xx_defconfig
m68k                        stmark2_defconfig
sh                          sdk7780_defconfig
powerpc                      arches_defconfig
csky                             alldefconfig
arc                     nsimosci_hs_defconfig
powerpc                     pq2fads_defconfig
m68k                        mvme16x_defconfig
mips                           rs90_defconfig
sh                             shx3_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
arm                        neponset_defconfig
mips                           ci20_defconfig
arm                  colibri_pxa300_defconfig
arm                         axm55xx_defconfig
mips                      malta_kvm_defconfig
arm                      footbridge_defconfig
arm                            zeus_defconfig
openrisc                  or1klitex_defconfig
arm                         at91_dt_defconfig
sh                   rts7751r2dplus_defconfig
arm                          badge4_defconfig
ia64                             allyesconfig
arm                          pxa910_defconfig
sh                          kfr2r09_defconfig
xtensa                           alldefconfig
mips                      loongson3_defconfig
h8300                     edosk2674_defconfig
arm                       versatile_defconfig
mips                      pistachio_defconfig
sh                          rsk7201_defconfig
powerpc                       maple_defconfig
arm                        shmobile_defconfig
mips                        maltaup_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc8313_rdb_defconfig
ia64                        generic_defconfig
sh                              ul2_defconfig
arm                             rpc_defconfig
arm                        vexpress_defconfig
powerpc                   currituck_defconfig
powerpc                          allmodconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7721_defconfig
arm                         cm_x300_defconfig
sh                          urquell_defconfig
arm                         bcm2835_defconfig
m68k                        m5307c3_defconfig
arm                      tct_hammer_defconfig
arc                                 defconfig
powerpc                   lite5200b_defconfig
ia64                          tiger_defconfig
mips                        jmr3927_defconfig
mips                            gpr_defconfig
powerpc                      katmai_defconfig
arm                        mini2440_defconfig
powerpc                      acadia_defconfig
powerpc                         ps3_defconfig
x86_64                           alldefconfig
arm                            xcep_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          landisk_defconfig
x86_64                              defconfig
powerpc                       eiger_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
powerpc                      mgcoge_defconfig
powerpc                         wii_defconfig
powerpc                     stx_gp3_defconfig
sh                          rsk7203_defconfig
powerpc                      pcm030_defconfig
arm                       multi_v4t_defconfig
arm                       spear13xx_defconfig
riscv                          rv32_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
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
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

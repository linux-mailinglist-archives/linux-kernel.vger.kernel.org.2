Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2EA357767
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 00:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhDGWLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 18:11:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:12757 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231134AbhDGWK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:10:59 -0400
IronPort-SDR: AaMe0T9nIXQbw5ua8/MjFyunLDi79ZY/l6YFoqBxYNn1m9s6UpIgBTP12nov4ycwh4oRckupvQ
 v65mdnX8Gebg==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="190202009"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="190202009"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:10:49 -0700
IronPort-SDR: pywDF5qc97l2fyhs8VUJPAjcA86REQJgk3+YlclLzmHzLDoxWoenUfBDmifIUWdN5BDbne3DVE
 nUO32JKxHiHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="613092217"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2021 15:10:47 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUGNr-000Dq8-57; Wed, 07 Apr 2021 22:10:47 +0000
Date:   Thu, 08 Apr 2021 06:10:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 b3754e5d3da320af2bebb7a690002685c7f5c15c
Message-ID: <606e2dd6.UT7OZc0X4hpHnd4G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: b3754e5d3da320af2bebb7a690002685c7f5c15c  x86/sgx: Move provisioning device creation out of SGX driver

elapsed time: 721m

configs tested: 222
configs skipped: 5

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
riscv                            allyesconfig
i386                             allyesconfig
nds32                            alldefconfig
powerpc                   motionpro_defconfig
powerpc                 linkstation_defconfig
mips                       capcella_defconfig
arm                          pxa168_defconfig
nios2                               defconfig
arc                          axs101_defconfig
alpha                            alldefconfig
s390                                defconfig
mips                        nlm_xlp_defconfig
powerpc                    amigaone_defconfig
arc                      axs103_smp_defconfig
mips                             allyesconfig
mips                        bcm47xx_defconfig
powerpc                 mpc834x_itx_defconfig
mips                  maltasmvp_eva_defconfig
arm                       netwinder_defconfig
arm                     am200epdkit_defconfig
mips                          rb532_defconfig
powerpc                   currituck_defconfig
xtensa                         virt_defconfig
arm                         lubbock_defconfig
powerpc                     tqm8555_defconfig
s390                             alldefconfig
sh                           se7619_defconfig
powerpc                 mpc836x_mds_defconfig
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
powerpc                    mvme5100_defconfig
m68k                          sun3x_defconfig
arm                         mv78xx0_defconfig
m68k                         amcore_defconfig
sh                            hp6xx_defconfig
arc                     nsimosci_hs_defconfig
alpha                            allyesconfig
arm                             pxa_defconfig
mips                           ip27_defconfig
arm                          iop32x_defconfig
sh                           sh2007_defconfig
powerpc                           allnoconfig
powerpc                 mpc836x_rdk_defconfig
arm                         socfpga_defconfig
mips                      malta_kvm_defconfig
sh                      rts7751r2d1_defconfig
sh                          rsk7264_defconfig
powerpc                          allyesconfig
mips                     loongson1c_defconfig
sh                           se7780_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8272_ads_defconfig
sh                   sh7770_generic_defconfig
arm                          collie_defconfig
m68k                        m5407c3_defconfig
arm                           sama5_defconfig
xtensa                           alldefconfig
mips                      loongson3_defconfig
sh                          sdk7780_defconfig
powerpc                      arches_defconfig
csky                             alldefconfig
powerpc                     mpc5200_defconfig
arm                       omap2plus_defconfig
arm                        mvebu_v7_defconfig
arm                        neponset_defconfig
powerpc                        fsp2_defconfig
arm                           sunxi_defconfig
powerpc                     pq2fads_defconfig
m68k                        mvme16x_defconfig
mips                           rs90_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
arm                        spear3xx_defconfig
arm                  colibri_pxa300_defconfig
arm                         axm55xx_defconfig
arm                      footbridge_defconfig
arm                            zeus_defconfig
openrisc                  or1klitex_defconfig
sh                   rts7751r2dplus_defconfig
sh                          kfr2r09_defconfig
h8300                     edosk2674_defconfig
arm                       versatile_defconfig
mips                      pistachio_defconfig
parisc                           allyesconfig
sh                          rsk7201_defconfig
powerpc                      chrp32_defconfig
mips                      fuloong2e_defconfig
arm                            pleb_defconfig
sh                        sh7757lcr_defconfig
sh                               j2_defconfig
sh                            titan_defconfig
arm                           omap1_defconfig
powerpc                      ppc44x_defconfig
powerpc                       maple_defconfig
arm                        shmobile_defconfig
mips                        maltaup_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc8313_rdb_defconfig
ia64                        generic_defconfig
sh                              ul2_defconfig
xtensa                generic_kc705_defconfig
powerpc                    adder875_defconfig
mips                        jmr3927_defconfig
m68k                            q40_defconfig
mips                        nlm_xlr_defconfig
arm                             rpc_defconfig
arm                        vexpress_defconfig
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
mips                            gpr_defconfig
powerpc                      katmai_defconfig
arm                        mini2440_defconfig
powerpc                      acadia_defconfig
powerpc                         ps3_defconfig
x86_64                           alldefconfig
arm                            xcep_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          landisk_defconfig
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
powerpc                      tqm8xx_defconfig
powerpc                     tqm8541_defconfig
mips                            ar7_defconfig
arc                        nsim_700_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      bamboo_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                 randconfig-a006-20210408
i386                 randconfig-a003-20210408
i386                 randconfig-a001-20210408
i386                 randconfig-a004-20210408
i386                 randconfig-a005-20210408
i386                 randconfig-a002-20210408
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

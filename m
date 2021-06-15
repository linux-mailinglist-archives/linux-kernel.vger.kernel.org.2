Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3F3A795E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhFOIvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:51:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:6935 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhFOIvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:51:51 -0400
IronPort-SDR: QUclSmPZWMESoXFrpyRelj4UqpNKVvoM4vt+HCvb9LCk5HQ0tznqlLeY12gkPa+MmANeD3m4zF
 sLKTYBDRmniQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="227415106"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="227415106"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 01:49:45 -0700
IronPort-SDR: JjwfIJYkGED7vy5B6rDgnQxL6q4UmEvMeNQhLc1O40gMrUyGeBeK536fmDiNACXNS3A44AJWym
 yL7EEbYFJkaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="484392886"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2021 01:49:40 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lt4lP-0000Ic-Jx; Tue, 15 Jun 2021 08:49:39 +0000
Date:   Tue, 15 Jun 2021 16:48:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 1d3156396cf6ea0873145092f4e040374ff1d862
Message-ID: <60c8697a.GmMDfUd1Ia8b+/md%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 1d3156396cf6ea0873145092f4e040374ff1d862  x86/sgx: Correct kernel-doc's arg name in sgx_encl_release()

elapsed time: 5752m

configs tested: 262
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    amigaone_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc64e_defconfig
powerpc                      katmai_defconfig
arc                              allyesconfig
sh                          kfr2r09_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                        spear3xx_defconfig
arm                          moxart_defconfig
powerpc                      bamboo_defconfig
powerpc                      ppc6xx_defconfig
mips                          ath25_defconfig
powerpc                     kmeter1_defconfig
sh                          sdk7786_defconfig
m68k                         amcore_defconfig
arm                        mini2440_defconfig
x86_64                            allnoconfig
arm                          collie_defconfig
m68k                        m5307c3_defconfig
powerpc                      acadia_defconfig
sh                     sh7710voipgw_defconfig
riscv                               defconfig
arm                          pxa3xx_defconfig
arm64                            alldefconfig
powerpc                      cm5200_defconfig
m68k                            mac_defconfig
arc                     nsimosci_hs_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     sequoia_defconfig
arm                      jornada720_defconfig
powerpc                    klondike_defconfig
csky                             alldefconfig
powerpc                 mpc837x_mds_defconfig
arm                       spear13xx_defconfig
arm                          pxa910_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      chrp32_defconfig
nios2                         10m50_defconfig
arm                           omap1_defconfig
csky                                defconfig
sh                     magicpanelr2_defconfig
sh                         ap325rxa_defconfig
powerpc                      ep88xc_defconfig
m68k                       m5475evb_defconfig
powerpc                       ppc64_defconfig
sh                         ecovec24_defconfig
mips                      maltasmvp_defconfig
sh                      rts7751r2d1_defconfig
powerpc64                           defconfig
arm                            hisi_defconfig
ia64                      gensparse_defconfig
sh                           se7721_defconfig
m68k                        m5407c3_defconfig
arm                             mxs_defconfig
arm                            pleb_defconfig
arm                         palmz72_defconfig
sh                          polaris_defconfig
arm                            qcom_defconfig
m68k                       m5249evb_defconfig
sparc                            alldefconfig
arm                           spitz_defconfig
powerpc                     stx_gp3_defconfig
mips                  maltasmvp_eva_defconfig
mips                malta_qemu_32r6_defconfig
mips                      loongson3_defconfig
mips                           ci20_defconfig
arc                          axs103_defconfig
arm                             pxa_defconfig
arm                      tct_hammer_defconfig
m68k                          sun3x_defconfig
mips                            gpr_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                generic_kc705_defconfig
arm                        shmobile_defconfig
arm                       imx_v6_v7_defconfig
ia64                          tiger_defconfig
mips                         tb0226_defconfig
arm                           sunxi_defconfig
s390                       zfcpdump_defconfig
sparc                               defconfig
microblaze                          defconfig
arm                      footbridge_defconfig
arm                        multi_v7_defconfig
sh                           se7780_defconfig
sh                                  defconfig
sh                          rsk7203_defconfig
mips                      fuloong2e_defconfig
sh                        edosk7760_defconfig
sh                   rts7751r2dplus_defconfig
xtensa                  nommu_kc705_defconfig
x86_64                           alldefconfig
mips                        bcm47xx_defconfig
sh                           se7619_defconfig
powerpc                     ppa8548_defconfig
mips                         bigsur_defconfig
sh                             sh03_defconfig
powerpc                     taishan_defconfig
arm                          ixp4xx_defconfig
mips                        nlm_xlp_defconfig
sh                          rsk7269_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     eseries_pxa_defconfig
mips                  decstation_64_defconfig
arm                      integrator_defconfig
arm                  colibri_pxa300_defconfig
powerpc                          g5_defconfig
mips                           rs90_defconfig
arm                            mps2_defconfig
mips                      malta_kvm_defconfig
arm                          pcm027_defconfig
powerpc                      ppc40x_defconfig
arm                          simpad_defconfig
sh                          rsk7201_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      walnut_defconfig
m68k                        mvme16x_defconfig
arm                         mv78xx0_defconfig
arm                            dove_defconfig
arm                        spear6xx_defconfig
mips                           jazz_defconfig
arm                        trizeps4_defconfig
powerpc                    ge_imp3a_defconfig
mips                        omega2p_defconfig
xtensa                       common_defconfig
sh                        dreamcast_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210611
x86_64               randconfig-a001-20210611
x86_64               randconfig-a004-20210611
x86_64               randconfig-a003-20210611
x86_64               randconfig-a006-20210611
x86_64               randconfig-a005-20210611
i386                 randconfig-a002-20210611
i386                 randconfig-a006-20210611
i386                 randconfig-a004-20210611
i386                 randconfig-a001-20210611
i386                 randconfig-a005-20210611
i386                 randconfig-a003-20210611
i386                 randconfig-a002-20210613
i386                 randconfig-a006-20210613
i386                 randconfig-a001-20210613
i386                 randconfig-a004-20210613
i386                 randconfig-a005-20210613
i386                 randconfig-a003-20210613
i386                 randconfig-a002-20210612
i386                 randconfig-a006-20210612
i386                 randconfig-a001-20210612
i386                 randconfig-a004-20210612
i386                 randconfig-a005-20210612
i386                 randconfig-a003-20210612
i386                 randconfig-a002-20210614
i386                 randconfig-a006-20210614
i386                 randconfig-a004-20210614
i386                 randconfig-a001-20210614
i386                 randconfig-a005-20210614
i386                 randconfig-a003-20210614
x86_64               randconfig-a015-20210612
x86_64               randconfig-a011-20210612
x86_64               randconfig-a014-20210612
x86_64               randconfig-a012-20210612
x86_64               randconfig-a013-20210612
x86_64               randconfig-a016-20210612
i386                 randconfig-a015-20210611
i386                 randconfig-a013-20210611
i386                 randconfig-a016-20210611
i386                 randconfig-a014-20210611
i386                 randconfig-a012-20210611
i386                 randconfig-a011-20210611
i386                 randconfig-a015-20210612
i386                 randconfig-a013-20210612
i386                 randconfig-a016-20210612
i386                 randconfig-a014-20210612
i386                 randconfig-a012-20210612
i386                 randconfig-a011-20210612
i386                 randconfig-a015-20210613
i386                 randconfig-a013-20210613
i386                 randconfig-a016-20210613
i386                 randconfig-a014-20210613
i386                 randconfig-a012-20210613
i386                 randconfig-a011-20210613
i386                 randconfig-a015-20210614
i386                 randconfig-a013-20210614
i386                 randconfig-a016-20210614
i386                 randconfig-a012-20210614
i386                 randconfig-a014-20210614
i386                 randconfig-a011-20210614
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                      rhel-8.3-kbuiltin
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210611
x86_64               randconfig-b001-20210614
x86_64               randconfig-b001-20210610
x86_64               randconfig-b001-20210612
x86_64               randconfig-a001-20210614
x86_64               randconfig-a004-20210614
x86_64               randconfig-a002-20210614
x86_64               randconfig-a003-20210614
x86_64               randconfig-a006-20210614
x86_64               randconfig-a005-20210614
x86_64               randconfig-a015-20210611
x86_64               randconfig-a011-20210611
x86_64               randconfig-a012-20210611
x86_64               randconfig-a014-20210611
x86_64               randconfig-a016-20210611
x86_64               randconfig-a013-20210611
x86_64               randconfig-a015-20210613
x86_64               randconfig-a011-20210613
x86_64               randconfig-a014-20210613
x86_64               randconfig-a012-20210613
x86_64               randconfig-a013-20210613
x86_64               randconfig-a016-20210613
x86_64               randconfig-a002-20210612
x86_64               randconfig-a004-20210612
x86_64               randconfig-a001-20210612
x86_64               randconfig-a003-20210612
x86_64               randconfig-a006-20210612
x86_64               randconfig-a005-20210612

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

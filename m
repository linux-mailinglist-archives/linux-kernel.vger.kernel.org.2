Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054D738D7F6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 02:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhEWALv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 20:11:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:60253 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231446AbhEWALt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 20:11:49 -0400
IronPort-SDR: pCj4THHiO0Hgc0CZap2oF0Z9HVRNmot/mT/sUY4C+CvLAq7RhP8l0Gy7iIcirSsgNyrRRzNJsa
 Q7AsStvMJxUA==
X-IronPort-AV: E=McAfee;i="6200,9189,9992"; a="198640513"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198640513"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2021 17:10:24 -0700
IronPort-SDR: MtMNSZA5CrTmdfB14eL6h5rYl3QTl/oNaknUZL9lPuQFnIjvqEjq4YQ6M19lEdF8vIym3UXGt4
 5NVR70nxQzuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="442064081"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2021 17:10:22 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lkbhG-0000a5-9d; Sun, 23 May 2021 00:10:22 +0000
Date:   Sun, 23 May 2021 08:09:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 d06aca989c243dd9e5d3e20aa4e5c2ecfdd07050
Message-ID: <60a99d38.IY8LzaOtpK0R17UM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: d06aca989c243dd9e5d3e20aa4e5c2ecfdd07050  x86/elf: Use _BITUL() macro in UAPI headers

elapsed time: 757m

configs tested: 221
configs skipped: 80

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                         alldefconfig
powerpc                 xes_mpc85xx_defconfig
i386                                defconfig
mips                          ath79_defconfig
sh                        sh7785lcr_defconfig
mips                     cu1830-neo_defconfig
mips                       bmips_be_defconfig
powerpc                     tqm8560_defconfig
sh                               j2_defconfig
arm                            pleb_defconfig
arm                         lubbock_defconfig
arm                        mvebu_v7_defconfig
sh                           se7619_defconfig
arm                             pxa_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8272_ads_defconfig
m68k                          amiga_defconfig
powerpc                     ppa8548_defconfig
arm                  colibri_pxa300_defconfig
mips                         tb0287_defconfig
openrisc                  or1klitex_defconfig
openrisc                            defconfig
arm                     am200epdkit_defconfig
powerpc                     tqm8541_defconfig
xtensa                         virt_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                    xip_kc705_defconfig
mips                           rs90_defconfig
powerpc                     sbc8548_defconfig
mips                            e55_defconfig
arm                          collie_defconfig
powerpc                      makalu_defconfig
sh                          rsk7264_defconfig
x86_64                           alldefconfig
powerpc                     pseries_defconfig
ia64                            zx1_defconfig
ia64                      gensparse_defconfig
powerpc                     mpc512x_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      ppc6xx_defconfig
arm                           h5000_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     skiroot_defconfig
um                           x86_64_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                         bigsur_defconfig
mips                          ath25_defconfig
arm                              alldefconfig
mips                  decstation_64_defconfig
sh                        sh7757lcr_defconfig
powerpc                       ebony_defconfig
sh                        edosk7760_defconfig
powerpc                      cm5200_defconfig
s390                             allmodconfig
powerpc                        cell_defconfig
xtensa                generic_kc705_defconfig
ia64                          tiger_defconfig
arm                             ezx_defconfig
arm                         lpc32xx_defconfig
powerpc                 mpc85xx_cds_defconfig
arc                          axs101_defconfig
sh                          urquell_defconfig
sparc64                             defconfig
mips                          rb532_defconfig
mips                         tb0226_defconfig
sh                             shx3_defconfig
mips                           ip27_defconfig
sh                          kfr2r09_defconfig
mips                malta_qemu_32r6_defconfig
arm64                            alldefconfig
arm                          pxa3xx_defconfig
sh                          rsk7203_defconfig
sh                         apsh4a3a_defconfig
arm                             rpc_defconfig
arm                           sunxi_defconfig
powerpc                         ps3_defconfig
m68k                            q40_defconfig
mips                      bmips_stb_defconfig
ia64                        generic_defconfig
powerpc                    ge_imp3a_defconfig
arm                            lart_defconfig
mips                          rm200_defconfig
powerpc                     tqm8555_defconfig
um                             i386_defconfig
arm                         palmz72_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                 decstation_r4k_defconfig
mips                      maltaaprp_defconfig
mips                         rt305x_defconfig
sh                          landisk_defconfig
powerpc                     powernv_defconfig
sh                          r7780mp_defconfig
sh                           se7705_defconfig
powerpc                       holly_defconfig
powerpc                     taishan_defconfig
powerpc                         wii_defconfig
sh                              ul2_defconfig
m68k                          sun3x_defconfig
m68k                           sun3_defconfig
arm                        neponset_defconfig
powerpc                      pasemi_defconfig
powerpc                      obs600_defconfig
arc                     haps_hs_smp_defconfig
arm                         vf610m4_defconfig
h8300                               defconfig
mips                     loongson2k_defconfig
mips                      loongson3_defconfig
sh                      rts7751r2d1_defconfig
mips                         tb0219_defconfig
arm                          gemini_defconfig
sh                ecovec24-romimage_defconfig
mips                            gpr_defconfig
arc                          axs103_defconfig
sh                           se7750_defconfig
arm                           corgi_defconfig
mips                          malta_defconfig
mips                         mpc30x_defconfig
m68k                            mac_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210522
x86_64               randconfig-a006-20210522
x86_64               randconfig-a005-20210522
x86_64               randconfig-a003-20210522
x86_64               randconfig-a004-20210522
x86_64               randconfig-a002-20210522
i386                 randconfig-a001-20210523
i386                 randconfig-a005-20210523
i386                 randconfig-a002-20210523
i386                 randconfig-a003-20210523
i386                 randconfig-a004-20210523
i386                 randconfig-a006-20210523
i386                 randconfig-a001-20210522
i386                 randconfig-a005-20210522
i386                 randconfig-a002-20210522
i386                 randconfig-a004-20210522
i386                 randconfig-a003-20210522
i386                 randconfig-a006-20210522
x86_64               randconfig-a013-20210523
x86_64               randconfig-a014-20210523
x86_64               randconfig-a012-20210523
x86_64               randconfig-a016-20210523
x86_64               randconfig-a015-20210523
x86_64               randconfig-a011-20210523
i386                 randconfig-a016-20210523
i386                 randconfig-a011-20210523
i386                 randconfig-a015-20210523
i386                 randconfig-a012-20210523
i386                 randconfig-a014-20210523
i386                 randconfig-a013-20210523
i386                 randconfig-a016-20210522
i386                 randconfig-a011-20210522
i386                 randconfig-a015-20210522
i386                 randconfig-a012-20210522
i386                 randconfig-a014-20210522
i386                 randconfig-a013-20210522
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-b001-20210522
x86_64               randconfig-b001-20210523
x86_64               randconfig-a006-20210523
x86_64               randconfig-a001-20210523
x86_64               randconfig-a005-20210523
x86_64               randconfig-a003-20210523
x86_64               randconfig-a004-20210523
x86_64               randconfig-a002-20210523
x86_64               randconfig-a013-20210522
x86_64               randconfig-a014-20210522
x86_64               randconfig-a012-20210522
x86_64               randconfig-a016-20210522
x86_64               randconfig-a015-20210522
x86_64               randconfig-a011-20210522

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

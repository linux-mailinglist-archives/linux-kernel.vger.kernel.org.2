Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74DF387E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346735AbhERRoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:44:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:50088 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237923AbhERRob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:44:31 -0400
IronPort-SDR: Qmu6mU4t5SrYdPx66kCZdt9+PXhY+7JxpllJG9f8fggAnitoD4H4KUlfjJWvOaJ5vYGG+KYqT8
 nrZ4tmaOHtDA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="286305617"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="286305617"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 10:43:13 -0700
IronPort-SDR: UwY/ueovT3tJPP9ZW0f7Qu+dVS0HmZxT/uV4I9+pf31ftQpc5Md/fHIt2/L2SO4JheXsFdMJFv
 Bp0TkKTLqNYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="411370253"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2021 10:43:11 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lj3kM-0002Hj-Sv; Tue, 18 May 2021 17:43:10 +0000
Date:   Wed, 19 May 2021 01:42:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 a50c5bebc99c525e7fbc059988c6a5ab8680cb76
Message-ID: <60a3fc76.59+NGSvl+9HPCpVC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: a50c5bebc99c525e7fbc059988c6a5ab8680cb76  x86/sev-es: Invalidate the GHCB after completing VMGEXIT

elapsed time: 724m

configs tested: 202
configs skipped: 70

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0219_defconfig
arm                          moxart_defconfig
parisc                              defconfig
openrisc                            defconfig
m68k                          multi_defconfig
powerpc64                           defconfig
m68k                          atari_defconfig
powerpc                     ep8248e_defconfig
arm                          lpd270_defconfig
alpha                               defconfig
xtensa                         virt_defconfig
powerpc                     powernv_defconfig
arm                           omap1_defconfig
sh                           se7619_defconfig
powerpc                      ppc44x_defconfig
sh                     magicpanelr2_defconfig
sh                          landisk_defconfig
arc                      axs103_smp_defconfig
mips                           xway_defconfig
csky                             alldefconfig
powerpc                     tqm8555_defconfig
sh                           se7722_defconfig
mips                         mpc30x_defconfig
um                            kunit_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          hp300_defconfig
powerpc                     pq2fads_defconfig
powerpc                    socrates_defconfig
arm                       imx_v6_v7_defconfig
arm64                            alldefconfig
arm                          gemini_defconfig
sh                             espt_defconfig
sh                        apsh4ad0a_defconfig
sparc                       sparc32_defconfig
sh                              ul2_defconfig
powerpc                       maple_defconfig
arm                        shmobile_defconfig
sh                ecovec24-romimage_defconfig
m68k                          sun3x_defconfig
arm                       netwinder_defconfig
alpha                            allyesconfig
mips                           ip28_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      cm5200_defconfig
mips                           rs90_defconfig
arm                           viper_defconfig
arc                        nsimosci_defconfig
i386                             alldefconfig
openrisc                  or1klitex_defconfig
sh                          kfr2r09_defconfig
mips                      malta_kvm_defconfig
arm                             rpc_defconfig
powerpc                     akebono_defconfig
nios2                         3c120_defconfig
powerpc                       ppc64_defconfig
microblaze                          defconfig
powerpc                   lite5200b_defconfig
arm                          iop32x_defconfig
ia64                            zx1_defconfig
powerpc                 mpc834x_mds_defconfig
mips                   sb1250_swarm_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
arm                             ezx_defconfig
mips                        nlm_xlr_defconfig
mips                            gpr_defconfig
mips                        vocore2_defconfig
ia64                                defconfig
m68k                       m5249evb_defconfig
sparc                            alldefconfig
x86_64                            allnoconfig
powerpc                     kmeter1_defconfig
arm                       imx_v4_v5_defconfig
sh                          r7780mp_defconfig
sh                            titan_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                           tegra_defconfig
m68k                         apollo_defconfig
arm                           h3600_defconfig
arm                      footbridge_defconfig
arm                            hisi_defconfig
arm                          exynos_defconfig
arm                         axm55xx_defconfig
arc                         haps_hs_defconfig
arm                           u8500_defconfig
powerpc                      ppc6xx_defconfig
powerpc                         wii_defconfig
arm                          simpad_defconfig
powerpc                     tqm8541_defconfig
xtensa                    smp_lx200_defconfig
mips                        qi_lb60_defconfig
m68k                           sun3_defconfig
arm                        clps711x_defconfig
mips                           mtx1_defconfig
arm                          ixp4xx_defconfig
arm                          pxa168_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                        cell_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7785lcr_defconfig
arm                         nhk8815_defconfig
parisc                generic-64bit_defconfig
x86_64                              defconfig
arm                       multi_v4t_defconfig
arm                      integrator_defconfig
mips                     loongson2k_defconfig
sparc                               defconfig
arm                          ep93xx_defconfig
arm                           h5000_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7206_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                       eiger_defconfig
powerpc                        icon_defconfig
x86_64                           allyesconfig
mips                        workpad_defconfig
sh                          rsk7269_defconfig
sh                         apsh4a3a_defconfig
powerpc                      bamboo_defconfig
powerpc                     mpc83xx_defconfig
riscv                             allnoconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
powerpc                    klondike_defconfig
powerpc                     tqm8560_defconfig
powerpc                 mpc834x_itx_defconfig
nds32                               defconfig
s390                             allyesconfig
arm                         assabet_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
x86_64               randconfig-a003-20210518
x86_64               randconfig-a004-20210518
x86_64               randconfig-a005-20210518
x86_64               randconfig-a001-20210518
x86_64               randconfig-a002-20210518
x86_64               randconfig-a006-20210518
i386                 randconfig-a003-20210518
i386                 randconfig-a001-20210518
i386                 randconfig-a005-20210518
i386                 randconfig-a004-20210518
i386                 randconfig-a002-20210518
i386                 randconfig-a006-20210518
i386                 randconfig-a014-20210518
i386                 randconfig-a016-20210518
i386                 randconfig-a011-20210518
i386                 randconfig-a015-20210518
i386                 randconfig-a012-20210518
i386                 randconfig-a013-20210518
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210518
x86_64               randconfig-b001-20210519
x86_64               randconfig-a015-20210518
x86_64               randconfig-a012-20210518
x86_64               randconfig-a013-20210518
x86_64               randconfig-a011-20210518
x86_64               randconfig-a016-20210518
x86_64               randconfig-a014-20210518

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

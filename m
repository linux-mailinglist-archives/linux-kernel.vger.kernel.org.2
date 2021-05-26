Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32746390DED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 03:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhEZBbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 21:31:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:31786 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhEZBbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 21:31:43 -0400
IronPort-SDR: 4ePGy1Ri89I+8LGp2sZD6/6lB7qF0PXPF1jn+J7KCONLjfG1A8zZPiBSGz7ErF37pXrmXbjk95
 vy3Yq4L4fk0A==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="182675515"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="182675515"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 18:30:13 -0700
IronPort-SDR: 60j4EKwfQbmAXNCxNJlpG71OV0MAIsP1UXmXSnqMXgw3GLu8Yphg81BuG3fKoeUpNHcHcrtGCF
 aiJBOcJd9NYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="397624225"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2021 18:30:11 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lliN9-0001vA-36; Wed, 26 May 2021 01:30:11 +0000
Date:   Wed, 26 May 2021 09:29:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 2ade8fc65076095460e3ea1ca65a8f619d7d9a3a
Message-ID: <60ada48b.bBRI5KQtuuYUNWhO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 2ade8fc65076095460e3ea1ca65a8f619d7d9a3a  x86/amd_nb: Add AMD family 19h model 50h PCI ids

elapsed time: 730m

configs tested: 212
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
parisc                generic-64bit_defconfig
mips                     loongson1c_defconfig
arm                   milbeaut_m10v_defconfig
sh                        apsh4ad0a_defconfig
mips                          ath79_defconfig
arm                         cm_x300_defconfig
sh                   sh7724_generic_defconfig
sh                             sh03_defconfig
openrisc                            defconfig
x86_64                           alldefconfig
powerpc                     mpc83xx_defconfig
sh                         microdev_defconfig
arm                          ep93xx_defconfig
x86_64                            allnoconfig
mips                      maltasmvp_defconfig
powerpc                      ppc44x_defconfig
powerpc                      ppc40x_defconfig
sh                        dreamcast_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     mpc512x_defconfig
powerpc                     ksi8560_defconfig
xtensa                generic_kc705_defconfig
arm                            mmp2_defconfig
powerpc                       ppc64_defconfig
um                               alldefconfig
mips                      loongson3_defconfig
mips                        nlm_xlp_defconfig
openrisc                  or1klitex_defconfig
powerpc                      walnut_defconfig
mips                         db1xxx_defconfig
mips                        maltaup_defconfig
arm                           spitz_defconfig
arm                            lart_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     tqm8555_defconfig
arm                          simpad_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     pq2fads_defconfig
arm                         at91_dt_defconfig
powerpc                       holly_defconfig
alpha                            alldefconfig
um                           x86_64_defconfig
arm                         s3c6400_defconfig
sh                            titan_defconfig
arc                        vdk_hs38_defconfig
arc                     haps_hs_smp_defconfig
arm                          pcm027_defconfig
arm                        mvebu_v5_defconfig
powerpc                       eiger_defconfig
powerpc                  mpc866_ads_defconfig
sh                          sdk7780_defconfig
arm                          pxa168_defconfig
sh                          lboxre2_defconfig
powerpc                      chrp32_defconfig
m68k                          sun3x_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                        omega2p_defconfig
mips                          ath25_defconfig
um                            kunit_defconfig
arm                          collie_defconfig
powerpc                   motionpro_defconfig
powerpc64                           defconfig
um                             i386_defconfig
sparc64                             defconfig
arm                        multi_v7_defconfig
arm                            pleb_defconfig
arm                       multi_v4t_defconfig
powerpc                     ppa8548_defconfig
arm                    vt8500_v6_v7_defconfig
nds32                            alldefconfig
xtensa                         virt_defconfig
mips                     cu1830-neo_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     taishan_defconfig
riscv                    nommu_k210_defconfig
powerpc                     tqm8541_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                       capcella_defconfig
arm                            mps2_defconfig
nds32                               defconfig
powerpc                      obs600_defconfig
powerpc                      bamboo_defconfig
mips                        bcm47xx_defconfig
arm                         axm55xx_defconfig
sh                          landisk_defconfig
openrisc                    or1ksim_defconfig
mips                      maltaaprp_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc6xx_defconfig
arm                     am200epdkit_defconfig
arm                         hackkit_defconfig
mips                           mtx1_defconfig
mips                         tb0219_defconfig
mips                            ar7_defconfig
m68k                       m5249evb_defconfig
arm                           tegra_defconfig
riscv                             allnoconfig
arm                     davinci_all_defconfig
powerpc                      mgcoge_defconfig
nds32                             allnoconfig
powerpc                          g5_defconfig
arm                           u8500_defconfig
m68k                            q40_defconfig
powerpc                    klondike_defconfig
microblaze                          defconfig
sh                           se7705_defconfig
m68k                        mvme16x_defconfig
arm                             rpc_defconfig
arc                            hsdk_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                            e55_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                        fsp2_defconfig
mips                          malta_defconfig
powerpc                         wii_defconfig
sh                               j2_defconfig
arm64                            alldefconfig
sh                   secureedge5410_defconfig
mips                         mpc30x_defconfig
sh                        edosk7705_defconfig
powerpc                      tqm8xx_defconfig
powerpc                   currituck_defconfig
m68k                         apollo_defconfig
arm                      pxa255-idp_defconfig
powerpc                 canyonlands_defconfig
powerpc                      pasemi_defconfig
arc                        nsim_700_defconfig
arm                            dove_defconfig
arc                     nsimosci_hs_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210525
i386                 randconfig-a002-20210525
i386                 randconfig-a005-20210525
i386                 randconfig-a006-20210525
i386                 randconfig-a003-20210525
i386                 randconfig-a004-20210525
i386                 randconfig-a001-20210526
i386                 randconfig-a002-20210526
i386                 randconfig-a005-20210526
i386                 randconfig-a004-20210526
i386                 randconfig-a003-20210526
i386                 randconfig-a006-20210526
x86_64               randconfig-a013-20210525
x86_64               randconfig-a012-20210525
x86_64               randconfig-a014-20210525
x86_64               randconfig-a016-20210525
x86_64               randconfig-a015-20210525
x86_64               randconfig-a011-20210525
i386                 randconfig-a011-20210525
i386                 randconfig-a016-20210525
i386                 randconfig-a015-20210525
i386                 randconfig-a012-20210525
i386                 randconfig-a014-20210525
i386                 randconfig-a013-20210525
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-b001-20210525
x86_64               randconfig-b001-20210526
x86_64               randconfig-a005-20210525
x86_64               randconfig-a006-20210525
x86_64               randconfig-a001-20210525
x86_64               randconfig-a003-20210525
x86_64               randconfig-a004-20210525
x86_64               randconfig-a002-20210525

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

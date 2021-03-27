Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A475434B380
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 02:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhC0BTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 21:19:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:59961 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhC0BTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 21:19:36 -0400
IronPort-SDR: TNp43qEqQ1ji77UZgywHYesy0MsetzasDGYpLc6F/Vb3gpYBNT0wZgB2FdfFfTnygxIbepqs0i
 H5WxerkpcwnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191341277"
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="191341277"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 18:19:35 -0700
IronPort-SDR: sFY3wiggcCu9Da8YRTM6t+7pDOkJhAVhcjXr9kYv+n76AbrAi7RKuGYBHKijDLyQlnPo4Sq2/K
 C4AnsKRu5Psw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="377434530"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2021 18:19:33 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPxbw-00038l-5W; Sat, 27 Mar 2021 01:19:32 +0000
Date:   Sat, 27 Mar 2021 09:18:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 58d746c119dfa28e72fc35aacaf3d2a3ac625cd0
Message-ID: <605e8802.4mBd8+oAXHL90AcV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 58d746c119dfa28e72fc35aacaf3d2a3ac625cd0  efi/libstub: Add $(CLANG_FLAGS) to x86 flags

elapsed time: 724m

configs tested: 190
configs skipped: 2

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
i386                             allyesconfig
riscv                            allyesconfig
powerpc                     mpc5200_defconfig
arm                        shmobile_defconfig
powerpc                     ep8248e_defconfig
powerpc                     ksi8560_defconfig
sh                ecovec24-romimage_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                         amcore_defconfig
m68k                           sun3_defconfig
powerpc                      pmac32_defconfig
powerpc                  mpc866_ads_defconfig
arm                          gemini_defconfig
powerpc                        icon_defconfig
powerpc                    sam440ep_defconfig
sh                           se7750_defconfig
arm                        clps711x_defconfig
sh                               alldefconfig
mips                        nlm_xlr_defconfig
arm                       spear13xx_defconfig
arm                         hackkit_defconfig
arm                         lpc18xx_defconfig
sh                          kfr2r09_defconfig
sh                           se7780_defconfig
arm                          moxart_defconfig
openrisc                            defconfig
sh                         microdev_defconfig
arm                          ixp4xx_defconfig
powerpc                          allmodconfig
nios2                         10m50_defconfig
powerpc                       holly_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                         orion5x_defconfig
powerpc                      pasemi_defconfig
ia64                          tiger_defconfig
powerpc                         wii_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       ebony_defconfig
sparc                               defconfig
arm                            pleb_defconfig
m68k                        mvme147_defconfig
microblaze                          defconfig
powerpc                      cm5200_defconfig
parisc                generic-64bit_defconfig
mips                             allmodconfig
mips                            ar7_defconfig
powerpc                          g5_defconfig
ia64                            zx1_defconfig
arc                          axs101_defconfig
arm                       imx_v4_v5_defconfig
m68k                       m5249evb_defconfig
arm                        mini2440_defconfig
ia64                             allyesconfig
arm                          pxa3xx_defconfig
arm                       aspeed_g5_defconfig
mips                     loongson1c_defconfig
sparc                            alldefconfig
mips                           rs90_defconfig
powerpc                      pcm030_defconfig
xtensa                  audio_kc705_defconfig
arm                          pxa168_defconfig
arm                           sunxi_defconfig
powerpc                          allyesconfig
sh                             sh03_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v7_defconfig
powerpc                   bluestone_defconfig
xtensa                generic_kc705_defconfig
powerpc                      acadia_defconfig
arm                       multi_v4t_defconfig
arm                            mps2_defconfig
arm                          pxa910_defconfig
arm                       cns3420vb_defconfig
powerpc                     asp8347_defconfig
mips                          ath25_defconfig
mips                  decstation_64_defconfig
um                            kunit_defconfig
sh                      rts7751r2d1_defconfig
alpha                            alldefconfig
arm                         s3c2410_defconfig
sh                            migor_defconfig
mips                     cu1830-neo_defconfig
mips                         db1xxx_defconfig
m68k                       bvme6000_defconfig
mips                    maltaup_xpa_defconfig
mips                          rb532_defconfig
mips                 decstation_r4k_defconfig
sh                          polaris_defconfig
powerpc                      walnut_defconfig
arm                         s3c6400_defconfig
m68k                             allmodconfig
arm                     eseries_pxa_defconfig
sh                            titan_defconfig
arm                          imote2_defconfig
mips                           mtx1_defconfig
sh                             shx3_defconfig
xtensa                  cadence_csp_defconfig
arm                         palmz72_defconfig
arm                         mv78xx0_defconfig
mips                            gpr_defconfig
alpha                            allyesconfig
powerpc                     powernv_defconfig
powerpc                     tqm5200_defconfig
um                               allyesconfig
powerpc                       maple_defconfig
powerpc                    socrates_defconfig
powerpc                      bamboo_defconfig
m68k                                defconfig
sh                           se7206_defconfig
sh                           sh2007_defconfig
powerpc                 mpc834x_mds_defconfig
nios2                            alldefconfig
mips                       capcella_defconfig
i386                             alldefconfig
mips                           ip22_defconfig
arm                        trizeps4_defconfig
powerpc                  mpc885_ads_defconfig
mips                        omega2p_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210326
i386                 randconfig-a003-20210326
i386                 randconfig-a001-20210326
i386                 randconfig-a002-20210326
i386                 randconfig-a006-20210326
i386                 randconfig-a005-20210326
x86_64               randconfig-a012-20210326
x86_64               randconfig-a015-20210326
x86_64               randconfig-a014-20210326
x86_64               randconfig-a013-20210326
x86_64               randconfig-a016-20210326
x86_64               randconfig-a011-20210326
i386                 randconfig-a014-20210326
i386                 randconfig-a011-20210326
i386                 randconfig-a015-20210326
i386                 randconfig-a016-20210326
i386                 randconfig-a012-20210326
i386                 randconfig-a013-20210326
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210326
x86_64               randconfig-a003-20210326
x86_64               randconfig-a001-20210326
x86_64               randconfig-a006-20210326
x86_64               randconfig-a004-20210326
x86_64               randconfig-a005-20210326

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

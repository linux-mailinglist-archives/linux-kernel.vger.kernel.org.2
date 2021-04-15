Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C1B36161E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 01:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhDOXYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 19:24:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:61805 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234985AbhDOXY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 19:24:29 -0400
IronPort-SDR: lyjq/Wa8J5lzX6Q61OPWXEPOcFSRGMexyqhFpTPfhLhQsc1SPS2V/HLBoE9anVPN7TRduFleY9
 ZAo304whGHzA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="215477986"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="215477986"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:24:05 -0700
IronPort-SDR: SIhy0ac3/SoV9/imzjG00FJI5BVH5Drt4n0goyt5+DAMVSMOOB4g6lDBBGlTEF9deV4tCRBn2o
 6sl2pqNAuGbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="533292728"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2021 16:24:04 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXBL9-0001AG-OU; Thu, 15 Apr 2021 23:24:03 +0000
Date:   Fri, 16 Apr 2021 07:23:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8b1fdf97491f0d457998ecc43eef92d490f310af
Message-ID: <6078cb0f.D611gxub+8w9kBqh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8b1fdf97491f0d457998ecc43eef92d490f310af  Merge branch 'core/entry'

elapsed time: 723m

configs tested: 187
configs skipped: 3

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
i386                             allyesconfig
riscv                            allyesconfig
arm                       aspeed_g4_defconfig
xtensa                         virt_defconfig
arm                          gemini_defconfig
h8300                            alldefconfig
arm                         socfpga_defconfig
arm                           sama5_defconfig
riscv                               defconfig
m68k                             alldefconfig
arc                         haps_hs_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      makalu_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     mpc5200_defconfig
sh                         apsh4a3a_defconfig
powerpc                     taishan_defconfig
s390                             alldefconfig
arm                          pxa168_defconfig
sh                          rsk7269_defconfig
arm                        realview_defconfig
mips                      maltaaprp_defconfig
h8300                       h8s-sim_defconfig
powerpc                 mpc8272_ads_defconfig
arm                      tct_hammer_defconfig
mips                           jazz_defconfig
arm                   milbeaut_m10v_defconfig
arm                         shannon_defconfig
arm                         lpc32xx_defconfig
m68k                           sun3_defconfig
powerpc                      ppc44x_defconfig
um                                allnoconfig
sh                          polaris_defconfig
m68k                        m5307c3_defconfig
ia64                            zx1_defconfig
sh                           se7619_defconfig
arm                       spear13xx_defconfig
arm                           corgi_defconfig
powerpc                     ep8248e_defconfig
arm                       netwinder_defconfig
powerpc                      katmai_defconfig
arm                       multi_v4t_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     tqm8555_defconfig
arm                          iop32x_defconfig
sh                           sh2007_defconfig
powerpc                     stx_gp3_defconfig
sh                          rsk7203_defconfig
arm                        vexpress_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                            mps2_defconfig
arm                        trizeps4_defconfig
sh                           se7705_defconfig
mips                        maltaup_defconfig
ia64                         bigsur_defconfig
um                               alldefconfig
powerpc                      obs600_defconfig
arm                            lart_defconfig
arm                        cerfcube_defconfig
mips                         tb0226_defconfig
arm                         cm_x300_defconfig
arm                          pxa910_defconfig
arm                           sunxi_defconfig
alpha                            alldefconfig
arm                            pleb_defconfig
arm                           stm32_defconfig
arm                        keystone_defconfig
mips                        nlm_xlr_defconfig
arm                          moxart_defconfig
powerpc                     redwood_defconfig
powerpc                      arches_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                            titan_defconfig
arm                        magician_defconfig
powerpc                     skiroot_defconfig
sh                        sh7757lcr_defconfig
nios2                         3c120_defconfig
powerpc                        fsp2_defconfig
m68k                       m5275evb_defconfig
arm                         palmz72_defconfig
powerpc                   bluestone_defconfig
i386                                defconfig
arm                          lpd270_defconfig
mips                        nlm_xlp_defconfig
powerpc                    sam440ep_defconfig
powerpc                       ebony_defconfig
mips                           ip32_defconfig
mips                  decstation_64_defconfig
powerpc                        cell_defconfig
sh                     sh7710voipgw_defconfig
sh                         ap325rxa_defconfig
powerpc                       ppc64_defconfig
arm                           h3600_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
arc                           tb10x_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                  colibri_pxa270_defconfig
arm                      jornada720_defconfig
mips                            e55_defconfig
ia64                             alldefconfig
powerpc                     kilauea_defconfig
m68k                          multi_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc834x_itx_defconfig
mips                         db1xxx_defconfig
sh                   rts7751r2dplus_defconfig
mips                        workpad_defconfig
arm                         s3c6400_defconfig
i386                             alldefconfig
powerpc                    mvme5100_defconfig
sh                             shx3_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210415
x86_64               randconfig-a002-20210415
x86_64               randconfig-a005-20210415
x86_64               randconfig-a001-20210415
x86_64               randconfig-a006-20210415
x86_64               randconfig-a004-20210415
i386                 randconfig-a003-20210415
i386                 randconfig-a006-20210415
i386                 randconfig-a001-20210415
i386                 randconfig-a005-20210415
i386                 randconfig-a004-20210415
i386                 randconfig-a002-20210415
i386                 randconfig-a015-20210415
i386                 randconfig-a014-20210415
i386                 randconfig-a013-20210415
i386                 randconfig-a012-20210415
i386                 randconfig-a016-20210415
i386                 randconfig-a011-20210415
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210415
x86_64               randconfig-a015-20210415
x86_64               randconfig-a011-20210415
x86_64               randconfig-a013-20210415
x86_64               randconfig-a012-20210415
x86_64               randconfig-a016-20210415

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

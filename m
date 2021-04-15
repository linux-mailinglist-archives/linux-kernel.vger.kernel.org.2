Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CDE36144B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhDOVoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:44:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:44073 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236019AbhDOVoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:44:23 -0400
IronPort-SDR: tIeiopAGSUGZhTWOUT8W69vME3yb+u/xxBFL3tZDbkC5K8NSpOHUDZ+OVuiZRaMVJ7jo46oGt2
 /vnfJ/hZHFBw==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="192821202"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="192821202"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 14:44:00 -0700
IronPort-SDR: E9r2uBu6RgE0OExOLYCv9M/QQEBSjIrRLU13ymrBz/BmZDZfSQ2MZQ+ae/P4X9lsD1R4i92j9D
 amH5NFphgAPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="453095149"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Apr 2021 14:43:58 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lX9mI-00017w-1a; Thu, 15 Apr 2021 21:43:58 +0000
Date:   Fri, 16 Apr 2021 05:43:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 9f8614f5567eb4e38579422d38a1bdfeeb648ffc
Message-ID: <6078b386.Ms/stxP+5SpkfCLS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 9f8614f5567eb4e38579422d38a1bdfeeb648ffc  x86/dma: Tear down DMA ops on driver unbind

elapsed time: 732m

configs tested: 210
configs skipped: 79

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
powerpc                    amigaone_defconfig
mips                        qi_lb60_defconfig
powerpc                 canyonlands_defconfig
arm                       aspeed_g4_defconfig
xtensa                         virt_defconfig
arm                          gemini_defconfig
h8300                            alldefconfig
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
h8300                     edosk2674_defconfig
powerpc                     tqm5200_defconfig
powerpc                    klondike_defconfig
mips                     cu1000-neo_defconfig
powerpc                 mpc832x_mds_defconfig
sparc64                          alldefconfig
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
powerpc                   lite5200b_defconfig
arm                         vf610m4_defconfig
sh                            shmin_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ebony_defconfig
arm                           sama5_defconfig
mips                            ar7_defconfig
m68k                        m5272c3_defconfig
powerpc                     tqm8560_defconfig
mips                  cavium_octeon_defconfig
powerpc                     tqm8541_defconfig
xtensa                  audio_kc705_defconfig
sh                              ul2_defconfig
powerpc                     redwood_defconfig
powerpc                        fsp2_defconfig
arm                       versatile_defconfig
mips                           ci20_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     tqm8555_defconfig
arm                          iop32x_defconfig
sh                           sh2007_defconfig
powerpc                     stx_gp3_defconfig
riscv                          rv32_defconfig
m68k                        m5407c3_defconfig
sh                        apsh4ad0a_defconfig
powerpc                 mpc836x_mds_defconfig
arm                              alldefconfig
mips                   sb1250_swarm_defconfig
sh                           se7705_defconfig
mips                        maltaup_defconfig
ia64                         bigsur_defconfig
um                               alldefconfig
arm                        realview_defconfig
arm                        clps711x_defconfig
riscv                            alldefconfig
arm                       cns3420vb_defconfig
mips                       bmips_be_defconfig
riscv                             allnoconfig
arm                       mainstone_defconfig
sh                          sdk7786_defconfig
arm                        neponset_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      arches_defconfig
powerpc                        icon_defconfig
arm                         cm_x300_defconfig
sh                          rsk7203_defconfig
arm                          pxa910_defconfig
arm                           sunxi_defconfig
arm                          moxart_defconfig
powerpc                 mpc8272_ads_defconfig
sh                            titan_defconfig
arm                        magician_defconfig
powerpc                     skiroot_defconfig
sh                        sh7757lcr_defconfig
nios2                         3c120_defconfig
m68k                       m5275evb_defconfig
arm                         palmz72_defconfig
arm                            mps2_defconfig
powerpc                    sam440ep_defconfig
mips                           ip28_defconfig
arm                          pcm027_defconfig
m68k                       bvme6000_defconfig
powerpc                       eiger_defconfig
powerpc                   bluestone_defconfig
arm                          lpd270_defconfig
mips                        nlm_xlp_defconfig
i386                                defconfig
mips                           ip32_defconfig
mips                  decstation_64_defconfig
powerpc                        cell_defconfig
sh                     sh7710voipgw_defconfig
arm                           h3600_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
arc                           tb10x_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                        nlm_xlr_defconfig
arm                  colibri_pxa270_defconfig
arm                      jornada720_defconfig
arc                        vdk_hs38_defconfig
powerpc                    mvme5100_defconfig
mips                       capcella_defconfig
arm                          ixp4xx_defconfig
sh                        edosk7705_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc834x_itx_defconfig
mips                         db1xxx_defconfig
sh                   rts7751r2dplus_defconfig
mips                        workpad_defconfig
arm                         s3c6400_defconfig
i386                             alldefconfig
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
riscv                               defconfig
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

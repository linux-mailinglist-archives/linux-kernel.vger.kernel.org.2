Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104E23593A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhDIEOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:14:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:42540 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhDIEN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:13:59 -0400
IronPort-SDR: i+KGp3ljo+jtcuuwrYlk58y9/1DaH4HlAghKuGDCxmhT2N7624kJ5ZUU1Pkv0FMaK6wwUWHGv2
 3bEgSw8C9kzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193724733"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="193724733"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 21:13:47 -0700
IronPort-SDR: q1kee135D5AHCobJZuxoZY9Ai5iXYgpgHOglKBwnpVtnrVpHqhDmuZM1OzJ1lc8lJxxrgjI9aA
 gGQcVGomGA8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="381966709"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Apr 2021 21:13:46 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUiWf-000GAY-A9; Fri, 09 Apr 2021 04:13:45 +0000
Date:   Fri, 09 Apr 2021 12:13:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 ae40aaf6bdbf0354a75b8284a0de453fcf5f4d32
Message-ID: <606fd453.pshbfzi23MoSPjyE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: ae40aaf6bdbf0354a75b8284a0de453fcf5f4d32  x86/sgx: Do not update sgx_nr_free_pages in sgx_setup_epc_section()

elapsed time: 721m

configs tested: 142
configs skipped: 2

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
mips                         rt305x_defconfig
sh                          urquell_defconfig
sh                            titan_defconfig
arm                             ezx_defconfig
arm                        oxnas_v6_defconfig
powerpc                     akebono_defconfig
arm                     eseries_pxa_defconfig
arm                            pleb_defconfig
m68k                         amcore_defconfig
sparc                       sparc32_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      ppc6xx_defconfig
sh                   sh7770_generic_defconfig
sh                           sh2007_defconfig
xtensa                  cadence_csp_defconfig
mips                           ip28_defconfig
sh                          r7780mp_defconfig
m68k                        mvme16x_defconfig
arm                        multi_v5_defconfig
powerpc                     kmeter1_defconfig
arc                     nsimosci_hs_defconfig
arm                        clps711x_defconfig
xtensa                    xip_kc705_defconfig
m68k                       bvme6000_defconfig
h8300                            alldefconfig
powerpc                      ppc64e_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          landisk_defconfig
powerpc                      arches_defconfig
riscv                               defconfig
parisc                           allyesconfig
sh                           se7722_defconfig
mips                  maltasmvp_eva_defconfig
arm                         s5pv210_defconfig
sh                             shx3_defconfig
sh                   rts7751r2dplus_defconfig
arm                            zeus_defconfig
arm                      footbridge_defconfig
powerpc                        warp_defconfig
mips                           ip22_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
s390                          debug_defconfig
arc                        vdk_hs38_defconfig
sh                           se7751_defconfig
mips                      pic32mzda_defconfig
arm                   milbeaut_m10v_defconfig
arm                           h5000_defconfig
powerpc                     mpc5200_defconfig
powerpc                      ep88xc_defconfig
m68k                          amiga_defconfig
arm                  colibri_pxa270_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     mpc83xx_defconfig
arm                            dove_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         shannon_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         at91_dt_defconfig
mips                  decstation_64_defconfig
alpha                            allyesconfig
powerpc                         ps3_defconfig
arm                          gemini_defconfig
arm                        realview_defconfig
arm                          iop32x_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210408
x86_64               randconfig-a005-20210408
x86_64               randconfig-a003-20210408
x86_64               randconfig-a001-20210408
x86_64               randconfig-a002-20210408
x86_64               randconfig-a006-20210408
i386                 randconfig-a006-20210408
i386                 randconfig-a003-20210408
i386                 randconfig-a004-20210408
i386                 randconfig-a005-20210408
i386                 randconfig-a002-20210408
i386                 randconfig-a001-20210408
i386                 randconfig-a014-20210408
i386                 randconfig-a016-20210408
i386                 randconfig-a011-20210408
i386                 randconfig-a012-20210408
i386                 randconfig-a013-20210408
i386                 randconfig-a015-20210408
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210408
x86_64               randconfig-a015-20210408
x86_64               randconfig-a012-20210408
x86_64               randconfig-a011-20210408
x86_64               randconfig-a013-20210408
x86_64               randconfig-a016-20210408

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

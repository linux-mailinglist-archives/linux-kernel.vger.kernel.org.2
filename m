Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8575C3590EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 02:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhDIAbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 20:31:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:37864 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232967AbhDIAbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 20:31:32 -0400
IronPort-SDR: PYCeeFGL5V6TzF7Knabzdz8CLEbiaeXGX1KfFhHV0tTV/qlYff93E/PejS4fLV9ISEy8gok7Gf
 lyaCyUFFCPKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193204768"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="193204768"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 17:31:20 -0700
IronPort-SDR: qMNrifIBkpk+Wl7JJ2E6o+ymAhrhU6r7zDVL3uS5VFCXjA7PtvZ3YhpufqBC0fHJjvylConsk4
 HWzKaN2y73jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="381916600"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Apr 2021 17:31:18 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUf3O-000FtK-AO; Fri, 09 Apr 2021 00:31:18 +0000
Date:   Fri, 09 Apr 2021 08:30:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 53375a5a218e7ea0ac18087946b5391f749b764f
Message-ID: <606fa02c.7bqgMX08lFMDcHbS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 53375a5a218e7ea0ac18087946b5391f749b764f  x86/cpu: Resort and comment Intel models

elapsed time: 720m

configs tested: 196
configs skipped: 85

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
um                                allnoconfig
sh                          urquell_defconfig
sh                            titan_defconfig
arm                             ezx_defconfig
arm                        oxnas_v6_defconfig
mips                        maltaup_defconfig
mips                         mpc30x_defconfig
arm                        cerfcube_defconfig
xtensa                  cadence_csp_defconfig
m68k                             allyesconfig
powerpc                     akebono_defconfig
arm                     eseries_pxa_defconfig
arm                            pleb_defconfig
m68k                         amcore_defconfig
sparc                       sparc32_defconfig
powerpc                     ppa8548_defconfig
x86_64                           alldefconfig
mips                    maltaup_xpa_defconfig
powerpc                           allnoconfig
m68k                         apollo_defconfig
sh                          r7785rp_defconfig
powerpc                      pmac32_defconfig
openrisc                 simple_smp_defconfig
mips                       lemote2f_defconfig
powerpc                      mgcoge_defconfig
powerpc                 linkstation_defconfig
sh                            migor_defconfig
sh                               j2_defconfig
i386                                defconfig
powerpc                      ppc40x_defconfig
powerpc                     tqm8548_defconfig
m68k                        m5407c3_defconfig
arm                            lart_defconfig
arm                           spitz_defconfig
arm                         palmz72_defconfig
arm                         lpc32xx_defconfig
ia64                             alldefconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      ppc6xx_defconfig
sh                   sh7770_generic_defconfig
sh                           sh2007_defconfig
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
sh                      rts7751r2d1_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                            mac_defconfig
um                            kunit_defconfig
mips                      maltasmvp_defconfig
m68k                                defconfig
powerpc                    socrates_defconfig
sh                            shmin_defconfig
riscv                    nommu_k210_defconfig
mips                     loongson1b_defconfig
mips                  decstation_64_defconfig
powerpc                      ppc64e_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                       maple_defconfig
powerpc64                           defconfig
mips                     cu1000-neo_defconfig
sh                   secureedge5410_defconfig
arm                         nhk8815_defconfig
sh                          landisk_defconfig
powerpc                      arches_defconfig
parisc                           allyesconfig
riscv                               defconfig
m68k                          hp300_defconfig
s390                          debug_defconfig
sh                 kfr2r09-romimage_defconfig
arm                             mxs_defconfig
mips                          malta_defconfig
arm                           u8500_defconfig
openrisc                         alldefconfig
mips                           ip27_defconfig
arm                         s3c6400_defconfig
arm                         orion5x_defconfig
sh                           se7206_defconfig
nios2                            alldefconfig
arc                        vdk_hs38_defconfig
sh                          sdk7786_defconfig
powerpc                     mpc83xx_defconfig
arm                          pxa3xx_defconfig
um                           x86_64_defconfig
sh                   sh7724_generic_defconfig
sh                          rsk7269_defconfig
mips                        bcm47xx_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                            zeus_defconfig
arm                      footbridge_defconfig
powerpc                        warp_defconfig
mips                           ip22_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
arm64                            alldefconfig
powerpc                     mpc5200_defconfig
powerpc                      ep88xc_defconfig
m68k                          amiga_defconfig
arm                  colibri_pxa270_defconfig
powerpc                    mvme5100_defconfig
arm                        trizeps4_defconfig
arm                            xcep_defconfig
ia64                            zx1_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          ep93xx_defconfig
arm                            dove_defconfig
powerpc                 mpc85xx_cds_defconfig
arc                    vdk_hs38_smp_defconfig
mips                           ip32_defconfig
arm                        realview_defconfig
arm                        mvebu_v7_defconfig
arm                          collie_defconfig
powerpc                         ps3_defconfig
arm                          gemini_defconfig
arm                          iop32x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210408
x86_64               randconfig-a005-20210408
x86_64               randconfig-a003-20210408
x86_64               randconfig-a001-20210408
x86_64               randconfig-a002-20210408
x86_64               randconfig-a006-20210408
i386                 randconfig-a006-20210408
i386                 randconfig-a003-20210408
i386                 randconfig-a001-20210408
i386                 randconfig-a004-20210408
i386                 randconfig-a005-20210408
i386                 randconfig-a002-20210408
i386                 randconfig-a014-20210408
i386                 randconfig-a016-20210408
i386                 randconfig-a011-20210408
i386                 randconfig-a012-20210408
i386                 randconfig-a013-20210408
i386                 randconfig-a015-20210408
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
x86_64               randconfig-a014-20210408
x86_64               randconfig-a015-20210408
x86_64               randconfig-a012-20210408
x86_64               randconfig-a011-20210408
x86_64               randconfig-a013-20210408
x86_64               randconfig-a016-20210408

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

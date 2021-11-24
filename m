Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72A745D156
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 00:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhKXXrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 18:47:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:4104 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231135AbhKXXrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:47:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235644499"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="235644499"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 15:44:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="607366764"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 24 Nov 2021 15:44:10 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq1vt-0005Up-Tm; Wed, 24 Nov 2021 23:44:09 +0000
Date:   Thu, 25 Nov 2021 07:43:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 dce1ca0525bfdc8a69a9343bc714fbc19a2f04b3
Message-ID: <619ece33.ajL8kyi+KtkS3I+r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
branch HEAD: dce1ca0525bfdc8a69a9343bc714fbc19a2f04b3  sched/scs: Reset task stack state in bringup_cpu()

elapsed time: 728m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211124
m68k                          hp300_defconfig
mips                      pic32mzda_defconfig
arm                       cns3420vb_defconfig
m68k                          sun3x_defconfig
arm                          simpad_defconfig
sparc                               defconfig
arm                            qcom_defconfig
m68k                       m5275evb_defconfig
powerpc                   currituck_defconfig
ia64                             alldefconfig
sh                           se7721_defconfig
arm                        spear3xx_defconfig
s390                       zfcpdump_defconfig
arm                  colibri_pxa300_defconfig
mips                         bigsur_defconfig
sh                             espt_defconfig
um                                  defconfig
sh                          lboxre2_defconfig
mips                  cavium_octeon_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                         wii_defconfig
arm                          ixp4xx_defconfig
sh                     magicpanelr2_defconfig
powerpc                     tqm8541_defconfig
powerpc                    socrates_defconfig
arm                        realview_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
xtensa                         virt_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                         rt305x_defconfig
arm                         axm55xx_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     taishan_defconfig
arm                     am200epdkit_defconfig
xtensa                  nommu_kc705_defconfig
mips                      bmips_stb_defconfig
arm                            mmp2_defconfig
nios2                               defconfig
arm                        neponset_defconfig
sh                            hp6xx_defconfig
sh                        sh7785lcr_defconfig
powerpc                      mgcoge_defconfig
powerpc                       ebony_defconfig
mips                      malta_kvm_defconfig
mips                        qi_lb60_defconfig
arm                        magician_defconfig
arm                        multi_v7_defconfig
powerpc               mpc834x_itxgp_defconfig
nios2                            allyesconfig
sh                          sdk7786_defconfig
mips                         tb0226_defconfig
mips                           ip22_defconfig
sh                          rsk7264_defconfig
powerpc64                           defconfig
sh                            shmin_defconfig
arm                          lpd270_defconfig
arm                          collie_defconfig
powerpc                    sam440ep_defconfig
ia64                                defconfig
sh                ecovec24-romimage_defconfig
arm                            xcep_defconfig
arm                         lpc32xx_defconfig
x86_64                           allyesconfig
sh                           se7724_defconfig
mips                      loongson3_defconfig
arm                            mps2_defconfig
arm                      jornada720_defconfig
arm                           omap1_defconfig
mips                    maltaup_xpa_defconfig
sh                        dreamcast_defconfig
arm                         socfpga_defconfig
mips                  maltasmvp_eva_defconfig
sparc64                             defconfig
powerpc                 canyonlands_defconfig
arc                        vdk_hs38_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   secureedge5410_defconfig
powerpc                        fsp2_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                            mac_defconfig
powerpc                     mpc83xx_defconfig
m68k                        m5307c3_defconfig
mips                     loongson1b_defconfig
powerpc                   microwatt_defconfig
m68k                        stmark2_defconfig
arm                  randconfig-c002-20211124
arm                  randconfig-c002-20211125
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
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
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a011-20211124
x86_64               randconfig-a014-20211124
x86_64               randconfig-a012-20211124
x86_64               randconfig-a016-20211124
x86_64               randconfig-a013-20211124
x86_64               randconfig-a015-20211124
i386                 randconfig-a016-20211124
i386                 randconfig-a015-20211124
i386                 randconfig-a012-20211124
i386                 randconfig-a013-20211124
i386                 randconfig-a014-20211124
i386                 randconfig-a011-20211124
arc                  randconfig-r043-20211124
s390                 randconfig-r044-20211124
riscv                randconfig-r042-20211124
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211124
i386                 randconfig-c001-20211124
powerpc              randconfig-c003-20211124
riscv                randconfig-c006-20211124
arm                  randconfig-c002-20211124
x86_64               randconfig-c007-20211124
mips                 randconfig-c004-20211124
x86_64               randconfig-a001-20211124
x86_64               randconfig-a006-20211124
x86_64               randconfig-a003-20211124
x86_64               randconfig-a004-20211124
x86_64               randconfig-a005-20211124
x86_64               randconfig-a002-20211124
i386                 randconfig-a002-20211124
i386                 randconfig-a001-20211124
i386                 randconfig-a005-20211124
i386                 randconfig-a006-20211124
i386                 randconfig-a004-20211124
i386                 randconfig-a003-20211124
hexagon              randconfig-r045-20211124
hexagon              randconfig-r041-20211124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

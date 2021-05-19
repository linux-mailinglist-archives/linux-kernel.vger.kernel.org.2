Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B103899E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhESXd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:33:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:50930 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhESXd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:33:57 -0400
IronPort-SDR: uTy8Ber4R2AQ0RMhADTPPWaZ1UbWnrjRDyKIKFSF/oyUwzCIaLQ887uJWbkq2t9yGHqzXZfHtM
 YW+5K8pyDsAg==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="181381537"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181381537"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 16:32:37 -0700
IronPort-SDR: bxQtWKhv+1I2/kz0LcprqxK0NsaEKeLnoU8D68AkI8ieIRNpCZhOumqBYVXCEe2fKy3PuraAha
 EUXMf1qnQTHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="461494713"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2021 16:32:36 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljVg3-0000J9-G6; Wed, 19 May 2021 23:32:35 +0000
Date:   Thu, 20 May 2021 07:31:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d4c72bb806d93c512f86d6b80c7a253f25ca8dbd
Message-ID: <60a59fec.2I6nqer4GGG2jxgj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: d4c72bb806d93c512f86d6b80c7a253f25ca8dbd  Merge branch 'sched/core'

elapsed time: 721m

configs tested: 169
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
arm64                            alldefconfig
arm                        trizeps4_defconfig
arc                        nsimosci_defconfig
arm                         socfpga_defconfig
arm                         bcm2835_defconfig
arc                            hsdk_defconfig
powerpc                        icon_defconfig
arm                          pxa3xx_defconfig
arm                         axm55xx_defconfig
powerpc                      arches_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
arc                              alldefconfig
sh                           se7724_defconfig
mips                    maltaup_xpa_defconfig
i386                                defconfig
arm                        magician_defconfig
sparc                       sparc32_defconfig
mips                      loongson3_defconfig
mips                           ip27_defconfig
sh                          rsk7264_defconfig
ia64                                defconfig
arm                          pcm027_defconfig
m68k                          sun3x_defconfig
arc                          axs103_defconfig
arm                         shannon_defconfig
mips                         tb0287_defconfig
sh                               allmodconfig
powerpc                 canyonlands_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                    adder875_defconfig
ia64                          tiger_defconfig
powerpc                mpc7448_hpc2_defconfig
riscv                            allyesconfig
arm                             pxa_defconfig
sh                          kfr2r09_defconfig
mips                           jazz_defconfig
arm                   milbeaut_m10v_defconfig
sh                            hp6xx_defconfig
powerpc                      pcm030_defconfig
mips                     cu1000-neo_defconfig
mips                            gpr_defconfig
arm                         s3c2410_defconfig
arm                        spear3xx_defconfig
m68k                        mvme147_defconfig
mips                         cobalt_defconfig
arm                        clps711x_defconfig
sh                          sdk7786_defconfig
sh                          r7785rp_defconfig
powerpc                     asp8347_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7705_defconfig
s390                             alldefconfig
mips                         tb0226_defconfig
m68k                          multi_defconfig
powerpc                   bluestone_defconfig
mips                         tb0219_defconfig
mips                           xway_defconfig
xtensa                  cadence_csp_defconfig
arm                       mainstone_defconfig
m68k                        m5307c3_defconfig
arm                       netwinder_defconfig
powerpc                       ppc64_defconfig
mips                   sb1250_swarm_defconfig
arc                      axs103_smp_defconfig
arm                           h3600_defconfig
mips                             allyesconfig
ia64                        generic_defconfig
arm                            hisi_defconfig
powerpc                      ppc40x_defconfig
powerpc                      pasemi_defconfig
m68k                            q40_defconfig
powerpc                 mpc8272_ads_defconfig
s390                             allyesconfig
powerpc                   currituck_defconfig
powerpc                     mpc5200_defconfig
xtensa                    xip_kc705_defconfig
mips                         bigsur_defconfig
m68k                             allyesconfig
sh                      rts7751r2d1_defconfig
x86_64                           allyesconfig
m68k                         amcore_defconfig
arm                          ep93xx_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                          allyesconfig
powerpc                 mpc837x_mds_defconfig
arc                              allyesconfig
powerpc                      ep88xc_defconfig
arm                             mxs_defconfig
powerpc                        fsp2_defconfig
powerpc                     tqm8540_defconfig
ia64                      gensparse_defconfig
arm                       omap2plus_defconfig
arm                        shmobile_defconfig
mips                            ar7_defconfig
mips                  decstation_64_defconfig
m68k                        stmark2_defconfig
openrisc                    or1ksim_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210519
i386                 randconfig-a001-20210519
i386                 randconfig-a005-20210519
i386                 randconfig-a004-20210519
i386                 randconfig-a002-20210519
i386                 randconfig-a006-20210519
x86_64               randconfig-a012-20210519
x86_64               randconfig-a015-20210519
x86_64               randconfig-a013-20210519
x86_64               randconfig-a011-20210519
x86_64               randconfig-a016-20210519
x86_64               randconfig-a014-20210519
i386                 randconfig-a014-20210519
i386                 randconfig-a016-20210519
i386                 randconfig-a011-20210519
i386                 randconfig-a015-20210519
i386                 randconfig-a012-20210519
i386                 randconfig-a013-20210519
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
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
x86_64               randconfig-b001-20210519
x86_64               randconfig-a003-20210519
x86_64               randconfig-a004-20210519
x86_64               randconfig-a005-20210519
x86_64               randconfig-a001-20210519
x86_64               randconfig-a002-20210519
x86_64               randconfig-a006-20210519

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

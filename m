Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89A3EDCAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhHPR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:56:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:49694 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhHPR4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:56:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="196173739"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="196173739"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 10:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="592849064"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2021 10:55:37 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mFgpk-000Qo3-In; Mon, 16 Aug 2021 17:55:36 +0000
Date:   Tue, 17 Aug 2021 01:55:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7bdb387be29ced4ead26ad2eff9d085cd5c7ac16
Message-ID: <611aa68e.xuoR5xVZ7gKEMn6w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7bdb387be29ced4ead26ad2eff9d085cd5c7ac16  Merge branch 'core/debugobjects'

elapsed time: 723m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
sh                           se7712_defconfig
arm                         lubbock_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         lpc18xx_defconfig
openrisc                            defconfig
mips                           ci20_defconfig
powerpc                         ps3_defconfig
powerpc                  mpc866_ads_defconfig
arm                        shmobile_defconfig
m68k                          atari_defconfig
sh                          r7785rp_defconfig
arm                            dove_defconfig
xtensa                  cadence_csp_defconfig
um                           x86_64_defconfig
powerpc                 mpc832x_mds_defconfig
arm                     am200epdkit_defconfig
mips                         tb0226_defconfig
powerpc                     skiroot_defconfig
mips                       lemote2f_defconfig
m68k                          hp300_defconfig
powerpc                       ebony_defconfig
arm                            pleb_defconfig
arm                            mmp2_defconfig
arc                            hsdk_defconfig
arm                      footbridge_defconfig
s390                       zfcpdump_defconfig
powerpc                    mvme5100_defconfig
powerpc                     sbc8548_defconfig
riscv                            allmodconfig
xtensa                         virt_defconfig
ia64                        generic_defconfig
arm                       versatile_defconfig
sh                        dreamcast_defconfig
arm                         nhk8815_defconfig
parisc                           alldefconfig
powerpc                     sequoia_defconfig
mips                           ip32_defconfig
arm                          lpd270_defconfig
sh                                  defconfig
arm                           corgi_defconfig
arm                           omap1_defconfig
sh                           sh2007_defconfig
powerpc                      ppc44x_defconfig
h8300                    h8300h-sim_defconfig
h8300                               defconfig
mips                      loongson3_defconfig
mips                        bcm63xx_defconfig
mips                      fuloong2e_defconfig
ia64                            zx1_defconfig
arc                          axs103_defconfig
arm                     davinci_all_defconfig
mips                         bigsur_defconfig
arm                             rpc_defconfig
m68k                        mvme16x_defconfig
sh                        apsh4ad0a_defconfig
sh                            hp6xx_defconfig
arm                        keystone_defconfig
mips                          rb532_defconfig
ia64                      gensparse_defconfig
sh                         ecovec24_defconfig
arm                            zeus_defconfig
i386                             alldefconfig
powerpc                      pcm030_defconfig
arm                           tegra_defconfig
arm                         s3c2410_defconfig
arm                         shannon_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                       netwinder_defconfig
mips                         rt305x_defconfig
powerpc                     tqm8541_defconfig
riscv                            alldefconfig
arm                        mini2440_defconfig
microblaze                          defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210816
x86_64               randconfig-a004-20210816
x86_64               randconfig-a003-20210816
x86_64               randconfig-a001-20210816
x86_64               randconfig-a005-20210816
x86_64               randconfig-a002-20210816
i386                 randconfig-a004-20210816
i386                 randconfig-a003-20210816
i386                 randconfig-a002-20210816
i386                 randconfig-a001-20210816
i386                 randconfig-a006-20210816
i386                 randconfig-a005-20210816
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210816
x86_64               randconfig-a011-20210816
x86_64               randconfig-a013-20210816
x86_64               randconfig-a016-20210816
x86_64               randconfig-a012-20210816
x86_64               randconfig-a015-20210816
x86_64               randconfig-a014-20210816
i386                 randconfig-a011-20210816
i386                 randconfig-a015-20210816
i386                 randconfig-a013-20210816
i386                 randconfig-a014-20210816
i386                 randconfig-a016-20210816
i386                 randconfig-a012-20210816

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06333B10F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 02:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhFWAOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 20:14:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:14549 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhFWAOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 20:14:46 -0400
IronPort-SDR: cIn45IWPEa5hPHbsDlKHyCkSQR49o6iYEhQSS7oG+Qv6j+LR8cnZHMrJfGNb2o23jiDSyv+5ZF
 2DlYBN9l0NuA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="206981807"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="206981807"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 17:12:27 -0700
IronPort-SDR: +q2C2/JT+03D1y8oQPTnm3APVXiyOTF6+hAyIHxT+SNJqWt19wOM2jRRHCOLj83fYXrM91TsrI
 h1N6l47BLrOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="556790728"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2021 17:12:25 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lvqVF-0005Xw-6H; Wed, 23 Jun 2021 00:12:25 +0000
Date:   Wed, 23 Jun 2021 08:12:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 49faa77759b211fff344898edc23bb780707fff5
Message-ID: <60d27c54.NjjZp1sP6wul0hx7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: 49faa77759b211fff344898edc23bb780707fff5  locking/lockdep: Improve noinstr vs errors

elapsed time: 723m

configs tested: 148
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   motionpro_defconfig
arc                        vdk_hs38_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     tqm5200_defconfig
powerpc                    gamecube_defconfig
powerpc                    sam440ep_defconfig
sh                           se7705_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                          malta_defconfig
xtensa                           alldefconfig
powerpc                      makalu_defconfig
powerpc                  mpc866_ads_defconfig
mips                     cu1830-neo_defconfig
i386                                defconfig
powerpc                      acadia_defconfig
arc                     nsimosci_hs_defconfig
arm                         cm_x300_defconfig
sh                   secureedge5410_defconfig
mips                  decstation_64_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         hackkit_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5475evb_defconfig
arm                       netwinder_defconfig
um                            kunit_defconfig
sh                          polaris_defconfig
m68k                         apollo_defconfig
powerpc                      katmai_defconfig
h8300                            alldefconfig
um                           x86_64_defconfig
sh                          r7785rp_defconfig
mips                      bmips_stb_defconfig
sh                        edosk7705_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      pcm030_defconfig
arm                           sama5_defconfig
arm                       cns3420vb_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                 kfr2r09-romimage_defconfig
sh                           se7724_defconfig
m68k                          atari_defconfig
powerpc                     tqm8555_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                       imx_v4_v5_defconfig
arm                      tct_hammer_defconfig
sh                           se7712_defconfig
arm                             ezx_defconfig
mips                         rt305x_defconfig
arm                     eseries_pxa_defconfig
powerpc                     ep8248e_defconfig
mips                           xway_defconfig
arm                        realview_defconfig
arm                      jornada720_defconfig
sh                                  defconfig
arm                        mvebu_v5_defconfig
sh                   sh7770_generic_defconfig
powerpc                     kmeter1_defconfig
microblaze                          defconfig
arm                         orion5x_defconfig
arm                        shmobile_defconfig
sh                            titan_defconfig
mips                            gpr_defconfig
h8300                               defconfig
arm                       aspeed_g4_defconfig
parisc                generic-64bit_defconfig
powerpc                     sbc8548_defconfig
powerpc                   currituck_defconfig
um                               alldefconfig
arm                             rpc_defconfig
powerpc                     sequoia_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
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
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

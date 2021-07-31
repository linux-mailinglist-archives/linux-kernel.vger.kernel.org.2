Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBD3DC58F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 12:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhGaKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 06:19:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:27549 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232294AbhGaKTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 06:19:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="211349698"
X-IronPort-AV: E=Sophos;i="5.84,284,1620716400"; 
   d="scan'208";a="211349698"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2021 03:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,284,1620716400"; 
   d="scan'208";a="665435089"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jul 2021 03:19:26 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9m5V-000B0W-Q9; Sat, 31 Jul 2021 10:19:25 +0000
Date:   Sat, 31 Jul 2021 18:19:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 d92df42d7685445a2b6c815d9230d9699d9d400b
Message-ID: <6105239e.NMzlfMUWjd2dFr/5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: d92df42d7685445a2b6c815d9230d9699d9d400b  genirq: Improve "hwirq" output in /proc and /sys/

elapsed time: 725m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210730
powerpc                 mpc834x_itx_defconfig
sh                         apsh4a3a_defconfig
openrisc                            defconfig
mips                       capcella_defconfig
powerpc                      ppc44x_defconfig
m68k                             allyesconfig
mips                      pic32mzda_defconfig
mips                          malta_defconfig
h8300                            alldefconfig
arm                          collie_defconfig
powerpc                     ppa8548_defconfig
arm                           sunxi_defconfig
arm                     eseries_pxa_defconfig
m68k                           sun3_defconfig
parisc                           allyesconfig
arm                          simpad_defconfig
mips                   sb1250_swarm_defconfig
h8300                     edosk2674_defconfig
arm                       mainstone_defconfig
arm                            dove_defconfig
sh                        edosk7705_defconfig
m68k                       bvme6000_defconfig
arm                         assabet_defconfig
arm                           viper_defconfig
m68k                            q40_defconfig
m68k                        m5307c3_defconfig
arm                         s3c6400_defconfig
arm                        keystone_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      walnut_defconfig
arm                       netwinder_defconfig
sh                              ul2_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                   secureedge5410_defconfig
csky                             alldefconfig
powerpc                     sbc8548_defconfig
riscv                    nommu_virt_defconfig
s390                       zfcpdump_defconfig
arm                  colibri_pxa300_defconfig
arc                              allyesconfig
xtensa                  audio_kc705_defconfig
powerpc                    gamecube_defconfig
sh                           se7705_defconfig
mips                           mtx1_defconfig
x86_64                           alldefconfig
powerpc                   currituck_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
i386                 randconfig-a005-20210730
i386                 randconfig-a004-20210730
i386                 randconfig-a003-20210730
i386                 randconfig-a002-20210730
i386                 randconfig-a006-20210730
i386                 randconfig-a001-20210730
x86_64               randconfig-a015-20210730
x86_64               randconfig-a014-20210730
x86_64               randconfig-a013-20210730
x86_64               randconfig-a011-20210730
x86_64               randconfig-a012-20210730
x86_64               randconfig-a016-20210730
i386                 randconfig-a013-20210730
i386                 randconfig-a016-20210730
i386                 randconfig-a012-20210730
i386                 randconfig-a011-20210730
i386                 randconfig-a014-20210730
i386                 randconfig-a015-20210730
x86_64               randconfig-a001-20210731
x86_64               randconfig-a006-20210731
x86_64               randconfig-a005-20210731
x86_64               randconfig-a004-20210731
x86_64               randconfig-a002-20210731
x86_64               randconfig-a003-20210731
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210730
x86_64               randconfig-c001-20210731
x86_64               randconfig-a001-20210730
x86_64               randconfig-a006-20210730
x86_64               randconfig-a005-20210730
x86_64               randconfig-a004-20210730
x86_64               randconfig-a002-20210730
x86_64               randconfig-a003-20210730

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

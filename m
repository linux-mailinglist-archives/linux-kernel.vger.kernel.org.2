Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0AE32269D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhBWHsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:48:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:61446 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbhBWHri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:47:38 -0500
IronPort-SDR: obVid+bny4GWe3jN4UTvVoIr0jMl76GaZLf5bdZg+kX5clqrn3gnYT5Tb1TmJYkr5W60OVOrQJ
 EqzKava1yCOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="204146347"
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="204146347"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 23:46:57 -0800
IronPort-SDR: SY+27Y1zVgcTPl3/yjEUDq0suGZxeJD9C7SRZz9K9uHFlc9sLJKyf1rfps4ptMTTT4Otw2NcfN
 A6Rdd2rnOFZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="499017124"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2021 23:46:55 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lESPG-000119-Pk; Tue, 23 Feb 2021 07:46:54 +0000
Date:   Tue, 23 Feb 2021 15:46:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 724c8a23d589d8a002d2e39633c2f9a5a429616f
Message-ID: <6034b2bc.fgx+OiNr905AiC60%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
branch HEAD: 724c8a23d589d8a002d2e39633c2f9a5a429616f  objtool: Fix stack-swizzle for FRAME_POINTER=y

elapsed time: 726m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     akebono_defconfig
x86_64                           alldefconfig
mips                            gpr_defconfig
powerpc                 mpc836x_mds_defconfig
sh                         ap325rxa_defconfig
mips                           ip27_defconfig
sh                   rts7751r2dplus_defconfig
mips                        bcm63xx_defconfig
m68k                       m5475evb_defconfig
powerpc                      mgcoge_defconfig
m68k                          sun3x_defconfig
arm                        multi_v5_defconfig
arm                          simpad_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                        clps711x_defconfig
powerpc                      ep88xc_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                  mpc885_ads_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5307c3_defconfig
mips                        omega2p_defconfig
powerpc                     sbc8548_defconfig
powerpc                        warp_defconfig
powerpc                      bamboo_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         tb0226_defconfig
arm                       multi_v4t_defconfig
openrisc                 simple_smp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210222
x86_64               randconfig-a002-20210222
x86_64               randconfig-a003-20210222
x86_64               randconfig-a005-20210222
x86_64               randconfig-a006-20210222
x86_64               randconfig-a004-20210222
i386                 randconfig-a005-20210222
i386                 randconfig-a006-20210222
i386                 randconfig-a004-20210222
i386                 randconfig-a003-20210222
i386                 randconfig-a001-20210222
i386                 randconfig-a002-20210222
i386                 randconfig-a013-20210222
i386                 randconfig-a012-20210222
i386                 randconfig-a011-20210222
i386                 randconfig-a014-20210222
i386                 randconfig-a016-20210222
i386                 randconfig-a015-20210222
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210222
x86_64               randconfig-a011-20210222
x86_64               randconfig-a012-20210222
x86_64               randconfig-a016-20210222
x86_64               randconfig-a014-20210222
x86_64               randconfig-a013-20210222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

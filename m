Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B9E3228F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhBWKox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:44:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:10454 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhBWKou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:44:50 -0500
IronPort-SDR: zXLgVFGf10avaI2EtNjMITsHBRIFHDykI6FwzMaD8jlpPCoZiwa5S6QCOqqdXuyioJG4bCMNaD
 hn7gd+CDyFZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="204188353"
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="204188353"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 02:44:09 -0800
IronPort-SDR: oC+zZ0eh/wgz/S89n67BvGZNrZe0sSsnCfbHVwHcIL1kGUHzrlowszOqaveXZW9o2Iu3dzRFkr
 CnQPJm1s/+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="515156690"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Feb 2021 02:44:08 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lEVAl-000173-NM; Tue, 23 Feb 2021 10:44:07 +0000
Date:   Tue, 23 Feb 2021 18:43:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/xfs] BUILD SUCCESS
 fca71389c6700c11aa3fd9e05349460039719ce5
Message-ID: <6034dc50.jb/TLt5gCAcxb6uY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/xfs
branch HEAD: fca71389c6700c11aa3fd9e05349460039719ce5  xfs: Replace one-element arrays with flexible-array members

elapsed time: 723m

configs tested: 98
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         hackkit_defconfig
powerpc                     pq2fads_defconfig
powerpc                     redwood_defconfig
powerpc64                           defconfig
mips                          rb532_defconfig
mips                            e55_defconfig
arm                       imx_v4_v5_defconfig
mips                           ip28_defconfig
sh                          sdk7786_defconfig
powerpc                  storcenter_defconfig
arm                          pxa910_defconfig
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

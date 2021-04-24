Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4350F369E74
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 04:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhDXCKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 22:10:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:8664 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhDXCKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 22:10:45 -0400
IronPort-SDR: dCBYndwa4jDAHzNxgNo8lNKN87WRuoLh+QEoAqflxQ0hSAD8ib8d46y5lv+ImxyHJWL9Wi4ulk
 0fRJCOtZHtqg==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="260109033"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="260109033"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 19:10:06 -0700
IronPort-SDR: YgQXfy9Bhb9YSXD3QNAcBDEa6SKBVYdoerPMUWycraphkv4LBJqyLBM6sLic5q5xWqmMtN8vY0
 JxdHepO+nDtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="428606193"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Apr 2021 19:10:04 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1la7kC-0004wd-6e; Sat, 24 Apr 2021 02:10:04 +0000
Date:   Sat, 24 Apr 2021 10:09:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/Warray-bounds] BUILD SUCCESS
 abe4e8233c005b4b0b394128ac03403543d336d3
Message-ID: <60837dc6.uV4wFBGRsfZYndXM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/Warray-bounds
branch HEAD: abe4e8233c005b4b0b394128ac03403543d336d3  scsi: aacraid: Replace one-element array with flexible-array member

elapsed time: 722m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                         amcore_defconfig
mips                           ip22_defconfig
sh                         apsh4a3a_defconfig
powerpc                    klondike_defconfig
m68k                             alldefconfig
sh                          kfr2r09_defconfig
mips                      pistachio_defconfig
mips                          ath25_defconfig
microblaze                          defconfig
openrisc                    or1ksim_defconfig
arm                           sama5_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          exynos_defconfig
ia64                             alldefconfig
arm                             rpc_defconfig
powerpc                 canyonlands_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      ppc44x_defconfig
mips                      maltaaprp_defconfig
powerpc                  mpc885_ads_defconfig
arc                      axs103_smp_defconfig
arm                        cerfcube_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5272c3_defconfig
powerpc                 linkstation_defconfig
arm                         vf610m4_defconfig
arm                        oxnas_v6_defconfig
sh                        sh7757lcr_defconfig
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
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210423
x86_64               randconfig-a004-20210423
x86_64               randconfig-a001-20210423
x86_64               randconfig-a005-20210423
x86_64               randconfig-a006-20210423
x86_64               randconfig-a003-20210423
i386                 randconfig-a005-20210423
i386                 randconfig-a002-20210423
i386                 randconfig-a001-20210423
i386                 randconfig-a006-20210423
i386                 randconfig-a004-20210423
i386                 randconfig-a003-20210423
i386                 randconfig-a014-20210423
i386                 randconfig-a012-20210423
i386                 randconfig-a011-20210423
i386                 randconfig-a013-20210423
i386                 randconfig-a015-20210423
i386                 randconfig-a016-20210423
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210423
x86_64               randconfig-a016-20210423
x86_64               randconfig-a011-20210423
x86_64               randconfig-a014-20210423
x86_64               randconfig-a012-20210423
x86_64               randconfig-a013-20210423

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

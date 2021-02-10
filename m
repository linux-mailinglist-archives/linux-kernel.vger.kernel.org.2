Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FF531702E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhBJTdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:33:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:21226 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhBJTdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:33:04 -0500
IronPort-SDR: eowUcbRyjntZ72SROjPzPYz85GbXRzzPnMsTiuRXr4c4IpRIwiQr242v6aqXPUvRUo59br0Ux2
 MmU0wUit8cqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="243627433"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="243627433"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 11:32:20 -0800
IronPort-SDR: Xs8JK/nXaFOxEe4gZMETyM3g39dh7L1oFWGTkrpZT1toOHOT0jrmyCI2Ge+DNhjg/wMbpddNWD
 t0m26ni8y12w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="375589550"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2021 11:32:18 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9vDl-0003E6-Ry; Wed, 10 Feb 2021 19:32:17 +0000
Date:   Thu, 11 Feb 2021 03:32:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/staging/rt8723bs] BUILD SUCCESS
 5504ec1949f6c217e76b1d1229df9f87a03cefe4
Message-ID: <602434b8.jc5DoXJ0bmHoxgIL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/staging/rt8723bs
branch HEAD: 5504ec1949f6c217e76b1d1229df9f87a03cefe4  staging: rtl8723bs: Replace one-element array with flexible-array in struct ndis_80211_var_ie

elapsed time: 1376m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7785rp_defconfig
sparc64                             defconfig
arm                     am200epdkit_defconfig
sh                            shmin_defconfig
powerpc                     tqm8540_defconfig
mips                           ci20_defconfig
nios2                         3c120_defconfig
arc                        vdk_hs38_defconfig
arm                         s3c6400_defconfig
arm                         vf610m4_defconfig
arc                              alldefconfig
arm                           sama5_defconfig
sh                        sh7763rdp_defconfig
mips                        bcm47xx_defconfig
openrisc                    or1ksim_defconfig
arm                          pxa3xx_defconfig
powerpc                    socrates_defconfig
xtensa                    smp_lx200_defconfig
mips                        jmr3927_defconfig
powerpc                       ppc64_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

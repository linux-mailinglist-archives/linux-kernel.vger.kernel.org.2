Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D243651BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 07:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhDTFLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 01:11:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:47721 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhDTFLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 01:11:43 -0400
IronPort-SDR: e9C4bZMptWMbjLRfJEwTTFRVinOXpLswki12tr0VhtyCOv/YRsg9pQddjFWLS8UEDeaIZDNrMT
 G+LhpUrId7jA==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="182937512"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="182937512"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 22:11:11 -0700
IronPort-SDR: YjWhUwJGn1bjWbhmquYHTiQLrcH3nmvkovi1g/O3b0qxjgOcjWlh/VshL13j1o4r5O2dMeCOEx
 fd76u34GqiTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="452378567"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2021 22:11:10 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYifF-00029W-Nu; Tue, 20 Apr 2021 05:11:09 +0000
Date:   Tue, 20 Apr 2021 13:10:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 75ce17f4d207d047b991e28cd5243f2345889c0c
Message-ID: <607e6231.Exh37mkvf9fEUdWT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 75ce17f4d207d047b991e28cd5243f2345889c0c  Merge branch 'x86/build'

elapsed time: 722m

configs tested: 117
configs skipped: 3

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
powerpc                   motionpro_defconfig
sh                         ap325rxa_defconfig
mips                      pic32mzda_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                        mvme16x_defconfig
arm                       versatile_defconfig
s390                             alldefconfig
mips                      pistachio_defconfig
arm                        spear3xx_defconfig
sh                          rsk7203_defconfig
powerpc                 mpc8272_ads_defconfig
mips                          rb532_defconfig
sh                        edosk7705_defconfig
powerpc                     asp8347_defconfig
arm                        realview_defconfig
sparc                       sparc32_defconfig
um                               alldefconfig
sh                   rts7751r2dplus_defconfig
sh                           se7705_defconfig
powerpc                     redwood_defconfig
powerpc                      katmai_defconfig
sh                         ecovec24_defconfig
sh                          rsk7201_defconfig
ia64                             allmodconfig
ia64                                defconfig
parisc                           alldefconfig
powerpc                       holly_defconfig
sh                        sh7785lcr_defconfig
m68k                          multi_defconfig
arm                       omap2plus_defconfig
sh                   sh7724_generic_defconfig
mips                     loongson1b_defconfig
powerpc                          g5_defconfig
arm                      footbridge_defconfig
powerpc                     sequoia_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210419
x86_64               randconfig-a001-20210419
x86_64               randconfig-a005-20210419
x86_64               randconfig-a002-20210419
x86_64               randconfig-a006-20210419
x86_64               randconfig-a004-20210419
i386                 randconfig-a003-20210419
i386                 randconfig-a001-20210419
i386                 randconfig-a006-20210419
i386                 randconfig-a005-20210419
i386                 randconfig-a004-20210419
i386                 randconfig-a002-20210419
i386                 randconfig-a012-20210420
i386                 randconfig-a014-20210420
i386                 randconfig-a011-20210420
i386                 randconfig-a013-20210420
i386                 randconfig-a015-20210420
i386                 randconfig-a016-20210420
i386                 randconfig-a015-20210419
i386                 randconfig-a013-20210419
i386                 randconfig-a014-20210419
i386                 randconfig-a016-20210419
i386                 randconfig-a012-20210419
i386                 randconfig-a011-20210419
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-a014-20210419
x86_64               randconfig-a015-20210419
x86_64               randconfig-a013-20210419
x86_64               randconfig-a011-20210419
x86_64               randconfig-a012-20210419
x86_64               randconfig-a016-20210419

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

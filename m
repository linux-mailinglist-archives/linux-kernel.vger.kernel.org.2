Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3E3093EB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhA3KDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:03:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:5808 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhA3KCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 05:02:55 -0500
IronPort-SDR: qNYoAdVva9xhHuFa3EnjJKpF3pJ03MXDBLDOCWrpMuvhvRFrF666zr8jx/RhhlkzTLuHHnazld
 G6aGYAlihufg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="265348090"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="265348090"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 22:28:53 -0800
IronPort-SDR: F7RuMjm0sfGdvjwwVvg1ItyJm431TjivoAy7LvVpVUPSlunr02iPe0HERD1tsLqCkqc22j3Uml
 R5j/xyaB8/ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="389672321"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 29 Jan 2021 22:28:52 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5jkZ-0004Kw-Cc; Sat, 30 Jan 2021 06:28:51 +0000
Date:   Sat, 30 Jan 2021 14:28:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 20bf2b378729c4a0366a53e2018a0b70ace94bcd
Message-ID: <6014fc74.SGNRXNFOwsdrLAj3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 20bf2b378729c4a0366a53e2018a0b70ace94bcd  x86/build: Disable CET instrumentation in the kernel

elapsed time: 720m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v4_v5_defconfig
riscv                             allnoconfig
m68k                           sun3_defconfig
riscv                            allmodconfig
mips                           ip27_defconfig
arm                       imx_v6_v7_defconfig
powerpc                        fsp2_defconfig
arm                       netwinder_defconfig
powerpc                 mpc837x_rdb_defconfig
h8300                       h8s-sim_defconfig
powerpc                     tqm8548_defconfig
sh                           sh2007_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
x86_64               randconfig-a004-20210130
x86_64               randconfig-a002-20210130
x86_64               randconfig-a001-20210130
x86_64               randconfig-a005-20210130
x86_64               randconfig-a006-20210130
x86_64               randconfig-a003-20210130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210129
x86_64               randconfig-a015-20210129
x86_64               randconfig-a016-20210129
x86_64               randconfig-a011-20210129
x86_64               randconfig-a013-20210129
x86_64               randconfig-a014-20210129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

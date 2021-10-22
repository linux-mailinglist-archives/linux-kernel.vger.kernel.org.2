Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9664375E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 13:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhJVLV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 07:21:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:57257 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232539AbhJVLVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:21:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="229228049"
X-IronPort-AV: E=Sophos;i="5.87,172,1631602800"; 
   d="scan'208";a="229228049"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 04:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,172,1631602800"; 
   d="scan'208";a="495644530"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2021 04:19:06 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mdsZm-000Fg6-7I; Fri, 22 Oct 2021 11:19:06 +0000
Date:   Fri, 22 Oct 2021 19:18:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 415de44076640483648d6c0f6d645a9ee61328ad
Message-ID: <61729e1c.pFdU/paPvG3r+SKn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/cpu
branch HEAD: 415de44076640483648d6c0f6d645a9ee61328ad  x86/cpu: Fix migration safety with X86_BUG_NULL_SEL

elapsed time: 839m

configs tested: 68
configs skipped: 79

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                             pxa_defconfig
powerpc                   bluestone_defconfig
powerpc                     ep8248e_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
powerpc                      tqm8xx_defconfig
sh                         ap325rxa_defconfig
powerpc                          allyesconfig
arm                            mps2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
arc                              allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211022
x86_64               randconfig-a004-20211022
x86_64               randconfig-a005-20211022
x86_64               randconfig-a001-20211022
x86_64               randconfig-a006-20211022
x86_64               randconfig-a003-20211022
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a013-20211022
x86_64               randconfig-a015-20211022
x86_64               randconfig-a011-20211022
x86_64               randconfig-a014-20211022
x86_64               randconfig-a016-20211022
x86_64               randconfig-a012-20211022
i386                 randconfig-a012-20211022
i386                 randconfig-a013-20211022
i386                 randconfig-a011-20211022
i386                 randconfig-a016-20211022
i386                 randconfig-a015-20211022
i386                 randconfig-a014-20211022
riscv                randconfig-r042-20211022
s390                 randconfig-r044-20211022
hexagon              randconfig-r045-20211022
hexagon              randconfig-r041-20211022

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C66E32A053
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbhCBEOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:14:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:12463 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344579AbhCAXgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:36:53 -0500
IronPort-SDR: BVFMOM+vfQug8wJPM0U6Zg2/vQGGCe5WFMU8ZZlhUbAGHxR0AD28uF97PXt8ss1bfspPIsEMFe
 cPco1gyg5XVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="174260598"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="174260598"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 15:36:08 -0800
IronPort-SDR: 9o608PooB6gsHbCugDp7hlpWTR7tVRsTPAvpH2PPaShmR42wnGFu+roZUSpP+SULUESulJiZTK
 g7/JhF8tvYDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="595591135"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Mar 2021 15:36:07 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lGs58-0004nF-QG; Mon, 01 Mar 2021 23:36:06 +0000
Date:   Tue, 02 Mar 2021 07:35:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 8b97c027dfe4ba195be08fd0e18f716005763b8a
Message-ID: <603d7a34.cuNwNV4TsCJ1tzxi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/urgent
branch HEAD: 8b97c027dfe4ba195be08fd0e18f716005763b8a  static_call: Fix the module key fixup

elapsed time: 722m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          moxart_defconfig
m68k                            q40_defconfig
powerpc                      katmai_defconfig
alpha                               defconfig
ia64                             alldefconfig
powerpc                      makalu_defconfig
powerpc                      chrp32_defconfig
i386                             allyesconfig
mips                        jmr3927_defconfig
arc                        nsim_700_defconfig
arm                         nhk8815_defconfig
arm                            zeus_defconfig
mips                     cu1830-neo_defconfig
sh                          rsk7269_defconfig
mips                         mpc30x_defconfig
arm                       versatile_defconfig
sparc                               defconfig
sparc64                             defconfig
sh                        apsh4ad0a_defconfig
powerpc                 canyonlands_defconfig
sh                     sh7710voipgw_defconfig
mips                 decstation_r4k_defconfig
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
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210228
i386                 randconfig-a005-20210228
i386                 randconfig-a004-20210228
i386                 randconfig-a003-20210228
i386                 randconfig-a001-20210228
i386                 randconfig-a002-20210228
x86_64               randconfig-a013-20210301
x86_64               randconfig-a016-20210301
x86_64               randconfig-a015-20210301
x86_64               randconfig-a014-20210301
x86_64               randconfig-a012-20210301
x86_64               randconfig-a011-20210301
i386                 randconfig-a016-20210301
i386                 randconfig-a012-20210301
i386                 randconfig-a014-20210301
i386                 randconfig-a013-20210301
i386                 randconfig-a011-20210301
i386                 randconfig-a015-20210301
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
x86_64               randconfig-a006-20210301
x86_64               randconfig-a001-20210301
x86_64               randconfig-a004-20210301
x86_64               randconfig-a002-20210301
x86_64               randconfig-a005-20210301
x86_64               randconfig-a003-20210301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

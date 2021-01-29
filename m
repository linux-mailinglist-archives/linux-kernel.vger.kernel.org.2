Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F130823C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhA2ALV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:11:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:24761 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhA2ALT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:11:19 -0500
IronPort-SDR: xlbDKpuN1+iITHLfArnNwQLWDHF+gVyZiRVyeQ4+eGeqX938L38gi261mRckDQBURKnZuv/U9Y
 2GwOj1JZMj8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="179554049"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="179554049"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 16:10:38 -0800
IronPort-SDR: nBFmdgJr+2/VRvEq70chfjJTx1RfnSk+rlpFtPguUyijh5DcB9xHpi7DAVDmJZkjrLbgAfQ3sZ
 ZYlBojUOXPig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="474324801"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2021 16:10:37 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5HMy-0003Do-St; Fri, 29 Jan 2021 00:10:36 +0000
Date:   Fri, 29 Jan 2021 08:09:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 bb73d07148c405c293e576b40af37737faf23a6a
Message-ID: <60135244.XTtQEDnQXSvMoymH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: bb73d07148c405c293e576b40af37737faf23a6a  x86/build: Treat R_386_PLT32 relocation as R_386_PC32

elapsed time: 723m

configs tested: 104
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  colibri_pxa300_defconfig
powerpc                   bluestone_defconfig
nios2                         3c120_defconfig
arc                        vdk_hs38_defconfig
sh                           se7724_defconfig
mips                malta_qemu_32r6_defconfig
xtensa                           allyesconfig
mips                      pic32mzda_defconfig
powerpc                     pseries_defconfig
arm                          ep93xx_defconfig
openrisc                    or1ksim_defconfig
sh                         apsh4a3a_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v5_defconfig
m68k                       m5275evb_defconfig
powerpc                      ppc44x_defconfig
sh                          kfr2r09_defconfig
ia64                                defconfig
powerpc                 mpc837x_mds_defconfig
mips                      maltasmvp_defconfig
arm                          simpad_defconfig
arm                         socfpga_defconfig
nios2                            allyesconfig
arm                        keystone_defconfig
arm                        magician_defconfig
mips                       bmips_be_defconfig
c6x                        evmc6678_defconfig
m68k                        mvme16x_defconfig
arc                         haps_hs_defconfig
sparc64                          alldefconfig
arm                  colibri_pxa270_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
i386                 randconfig-a001-20210128
i386                 randconfig-a002-20210128
i386                 randconfig-a004-20210128
i386                 randconfig-a005-20210128
i386                 randconfig-a003-20210128
i386                 randconfig-a006-20210128
x86_64               randconfig-a012-20210128
x86_64               randconfig-a015-20210128
x86_64               randconfig-a016-20210128
x86_64               randconfig-a011-20210128
x86_64               randconfig-a013-20210128
x86_64               randconfig-a014-20210128
i386                 randconfig-a013-20210128
i386                 randconfig-a011-20210128
i386                 randconfig-a012-20210128
i386                 randconfig-a016-20210128
i386                 randconfig-a014-20210128
i386                 randconfig-a015-20210128
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
x86_64               randconfig-a002-20210128
x86_64               randconfig-a003-20210128
x86_64               randconfig-a001-20210128
x86_64               randconfig-a005-20210128
x86_64               randconfig-a006-20210128
x86_64               randconfig-a004-20210128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

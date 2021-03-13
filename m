Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF30433A1F6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 00:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbhCMXrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 18:47:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:52902 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234788AbhCMXrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 18:47:16 -0500
IronPort-SDR: B02n8+RR+EZJFwOQFOo+5K9lGnG3vQ1+5Yfn9Gi182/nYw+j++0Djdj1+G5NU344nfFykTebVz
 24BjklL66ACg==
X-IronPort-AV: E=McAfee;i="6000,8403,9922"; a="252977897"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="252977897"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2021 15:47:14 -0800
IronPort-SDR: 7S5sUAVc0oiQwsZGtnHbuJ8zaqklA/NgR5dGQrq1RJaOJV5UXtVcjJir7YmdR4kiDAYaOVJn9b
 WMB9Bb+dh5VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="601004541"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Mar 2021 15:47:12 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lLDyS-0002Jd-4Q; Sat, 13 Mar 2021 23:47:12 +0000
Date:   Sun, 14 Mar 2021 07:46:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f34bf80037a1e8a00b948cbd5fac8e9d3c9b0b0f
Message-ID: <604d4ed0.e/i+URIOG+8iu2F3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f34bf80037a1e8a00b948cbd5fac8e9d3c9b0b0f  Merge branch 'linus'

elapsed time: 722m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7751_defconfig
mips                        maltaup_defconfig
sh                   sh7770_generic_defconfig
riscv                               defconfig
sh                        edosk7705_defconfig
arc                          axs103_defconfig
sh                                  defconfig
powerpc64                           defconfig
arm                             mxs_defconfig
xtensa                          iss_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
sh                           se7705_defconfig
sh                 kfr2r09-romimage_defconfig
arm                       cns3420vb_defconfig
arm                        mini2440_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc836x_mds_defconfig
sh                         microdev_defconfig
mips                        omega2p_defconfig
powerpc                       ppc64_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            shmin_defconfig
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
i386                 randconfig-a001-20210313
i386                 randconfig-a005-20210313
i386                 randconfig-a002-20210313
i386                 randconfig-a003-20210313
i386                 randconfig-a004-20210313
i386                 randconfig-a006-20210313
i386                 randconfig-a013-20210313
i386                 randconfig-a016-20210313
i386                 randconfig-a011-20210313
i386                 randconfig-a015-20210313
i386                 randconfig-a014-20210313
i386                 randconfig-a012-20210313
x86_64               randconfig-a006-20210313
x86_64               randconfig-a001-20210313
x86_64               randconfig-a005-20210313
x86_64               randconfig-a003-20210313
x86_64               randconfig-a002-20210313
x86_64               randconfig-a004-20210313
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210313
x86_64               randconfig-a016-20210313
x86_64               randconfig-a013-20210313
x86_64               randconfig-a014-20210313
x86_64               randconfig-a015-20210313
x86_64               randconfig-a012-20210313

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

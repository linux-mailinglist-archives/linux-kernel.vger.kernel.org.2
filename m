Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA2332A0D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576724AbhCBEcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:32:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:23438 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444059AbhCBCjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:39:16 -0500
IronPort-SDR: 2BPF5kkcLNzUlhNxnq9uIWwgef91geM3GGorrZJ8cOzNg/quZoDMoDf0TITu/0QB7vgjTtzNTa
 yX/aa1b88A4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186719522"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="186719522"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 18:38:34 -0800
IronPort-SDR: Jo07MNHNQKDQJ98SaZk2Bkv3NPf3y9DeZuEn7H8IEeAX4mEzjAUKG95oizCEnQzvGG+gwmX7H9
 ePUtqRbJTcjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="398026381"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2021 18:38:32 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lGuvf-0004wy-Uw; Tue, 02 Mar 2021 02:38:31 +0000
Date:   Tue, 02 Mar 2021 10:37:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 87246c319da5db38d74d239c3cffce49942dd5a8
Message-ID: <603da4fa.vxASeJ6IzNVh7DlF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 87246c319da5db38d74d239c3cffce49942dd5a8  Merge branch 'locking/core'

elapsed time: 723m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7724_defconfig
mips                           xway_defconfig
arm                        realview_defconfig
mips                        vocore2_defconfig
s390                       zfcpdump_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      katmai_defconfig
sparc                       sparc32_defconfig
arm                            zeus_defconfig
arc                         haps_hs_defconfig
arm                       cns3420vb_defconfig
powerpc                     tqm8555_defconfig
mips                      fuloong2e_defconfig
sh                        edosk7760_defconfig
riscv                    nommu_virt_defconfig
mips                         rt305x_defconfig
arm                         axm55xx_defconfig
sparc                            alldefconfig
arm                            hisi_defconfig
m68k                        stmark2_defconfig
sh                           se7750_defconfig
ia64                                defconfig
sh                   sh7770_generic_defconfig
arm                              alldefconfig
sparc                               defconfig
sparc64                             defconfig
sh                        apsh4ad0a_defconfig
powerpc                 canyonlands_defconfig
sh                     sh7710voipgw_defconfig
mips                 decstation_r4k_defconfig
ia64                             allmodconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210301
i386                 randconfig-a003-20210301
i386                 randconfig-a002-20210301
i386                 randconfig-a004-20210301
i386                 randconfig-a006-20210301
i386                 randconfig-a001-20210301
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

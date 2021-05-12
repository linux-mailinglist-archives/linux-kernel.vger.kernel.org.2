Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119D737ECCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbhELUAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:00:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:39791 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353798AbhELSMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:12:46 -0400
IronPort-SDR: H0malZIzDX5+FdQ+i+zPMqYXiGSUcC4Cj0zDvZnGDi80nto/HcpKEnu+8LGbofuiLHA8U/LdS/
 OcRU7D4VWq3w==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="179368067"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="179368067"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 11:11:36 -0700
IronPort-SDR: cBYKzJw1qCwlG20Y/VdCFTcIS9oozhCEOIajXljuTpIpTsJqrVo3rG/oUJVa9+y1OvESq8FZ2Y
 /NvlUqvG3tXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="625524898"
Received: from lkp-server01.sh.intel.com (HELO 1e931876798f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 May 2021 11:11:35 -0700
Received: from kbuild by 1e931876798f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgtKY-0000Qd-Oz; Wed, 12 May 2021 18:11:34 +0000
Date:   Thu, 13 May 2021 02:11:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 e09784a8a751e539dffc94d43bc917b0ac1e934a
Message-ID: <609c1a51.KFZMcvP3Fs1Iq3KM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: e09784a8a751e539dffc94d43bc917b0ac1e934a  alarmtimer: Check RTC features instead of ops

elapsed time: 735m

configs tested: 141
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0287_defconfig
m68k                          sun3x_defconfig
mips                          rb532_defconfig
arm                      jornada720_defconfig
arm                          imote2_defconfig
um                               allmodconfig
sh                          landisk_defconfig
arm                         at91_dt_defconfig
powerpc                     tqm8555_defconfig
powerpc                 mpc836x_mds_defconfig
openrisc                  or1klitex_defconfig
m68k                          amiga_defconfig
mips                           xway_defconfig
sh                           se7712_defconfig
arm                          collie_defconfig
powerpc                     ppa8548_defconfig
powerpc                      obs600_defconfig
mips                     decstation_defconfig
arm                           sunxi_defconfig
powerpc                    sam440ep_defconfig
mips                           jazz_defconfig
powerpc                        warp_defconfig
s390                       zfcpdump_defconfig
xtensa                         virt_defconfig
sh                        sh7763rdp_defconfig
csky                                defconfig
arm                        mini2440_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    socrates_defconfig
arm                         s5pv210_defconfig
arm                        magician_defconfig
arm                         mv78xx0_defconfig
arm                       aspeed_g4_defconfig
mips                      malta_kvm_defconfig
parisc                generic-32bit_defconfig
powerpc                     sequoia_defconfig
sh                           se7619_defconfig
riscv                    nommu_k210_defconfig
powerpc                     powernv_defconfig
arc                            hsdk_defconfig
arm                          iop32x_defconfig
mips                        workpad_defconfig
arm                         bcm2835_defconfig
arm                        spear6xx_defconfig
sh                          rsk7264_defconfig
powerpc                       holly_defconfig
mips                         mpc30x_defconfig
mips                  decstation_64_defconfig
mips                           ip27_defconfig
ia64                                defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        keystone_defconfig
parisc                           alldefconfig
powerpc                        fsp2_defconfig
m68k                       m5275evb_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
h8300                     edosk2674_defconfig
arm                         lpc18xx_defconfig
arm                       mainstone_defconfig
sparc64                             defconfig
sh                            hp6xx_defconfig
arm                         shannon_defconfig
powerpc                    ge_imp3a_defconfig
sh                            titan_defconfig
sh                   sh7770_generic_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210512
x86_64               randconfig-a004-20210512
x86_64               randconfig-a001-20210512
x86_64               randconfig-a005-20210512
x86_64               randconfig-a002-20210512
x86_64               randconfig-a006-20210512
i386                 randconfig-a003-20210512
i386                 randconfig-a001-20210512
i386                 randconfig-a005-20210512
i386                 randconfig-a004-20210512
i386                 randconfig-a002-20210512
i386                 randconfig-a006-20210512
i386                 randconfig-a016-20210512
i386                 randconfig-a014-20210512
i386                 randconfig-a011-20210512
i386                 randconfig-a015-20210512
i386                 randconfig-a012-20210512
i386                 randconfig-a013-20210512
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
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
x86_64               randconfig-a015-20210512
x86_64               randconfig-a012-20210512
x86_64               randconfig-a011-20210512
x86_64               randconfig-a013-20210512
x86_64               randconfig-a016-20210512
x86_64               randconfig-a014-20210512

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

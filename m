Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C04331950
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCHVWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:22:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:33154 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhCHVWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:22:32 -0500
IronPort-SDR: +Ejz+xpUqFd2sh/pXx2SM/FF5CvewwKZfXPAtrrKG1Cnw+gFjOGATvU8mMOvzZXmhLGdC7acaF
 IViJRoZY8gWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="167377835"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="167377835"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 13:22:31 -0800
IronPort-SDR: 6GaLPoDb4h3USdnz4nDE11Yw8im0W3DAGc6+6cjzqRl6Y9WmJ3HVppqOHrqOVWULsfp2bJTrjT
 1zoxhmC3eZlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="588190546"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2021 13:22:30 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lJNKf-0001A1-Bu; Mon, 08 Mar 2021 21:22:29 +0000
Date:   Tue, 09 Mar 2021 05:22:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 46eb1701c046cc18c032fa68f3c8ccbf24483ee4
Message-ID: <6046958e.g6/0xR163yCpblDx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 46eb1701c046cc18c032fa68f3c8ccbf24483ee4  hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()

elapsed time: 725m

configs tested: 156
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
sh                           se7724_defconfig
mips                         bigsur_defconfig
mips                          ath25_defconfig
m68k                           sun3_defconfig
nds32                               defconfig
sh                         ap325rxa_defconfig
m68k                       m5208evb_defconfig
powerpc                       ppc64_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           ci20_defconfig
sh                          rsk7201_defconfig
mips                         tb0219_defconfig
xtensa                  audio_kc705_defconfig
sparc                       sparc32_defconfig
h8300                               defconfig
powerpc                       maple_defconfig
arm                       omap2plus_defconfig
sh                   sh7770_generic_defconfig
sh                           se7343_defconfig
arm                          simpad_defconfig
arm                         socfpga_defconfig
arm                          pcm027_defconfig
powerpc                     pseries_defconfig
arm                         s5pv210_defconfig
mips                    maltaup_xpa_defconfig
mips                        vocore2_defconfig
arm                          pxa3xx_defconfig
arm                           spitz_defconfig
mips                      maltaaprp_defconfig
m68k                          hp300_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                             espt_defconfig
mips                  decstation_64_defconfig
sh                              ul2_defconfig
sparc                            allyesconfig
m68k                          sun3x_defconfig
sparc                       sparc64_defconfig
arm                         cm_x300_defconfig
arc                        vdk_hs38_defconfig
sh                          polaris_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     tqm8555_defconfig
mips                       rbtx49xx_defconfig
arm                             mxs_defconfig
arm                        cerfcube_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc834x_itx_defconfig
parisc                           alldefconfig
mips                           rs90_defconfig
sparc64                             defconfig
m68k                            mac_defconfig
sh                           se7721_defconfig
arc                          axs101_defconfig
powerpc                    ge_imp3a_defconfig
arm                     eseries_pxa_defconfig
mips                           jazz_defconfig
ia64                        generic_defconfig
mips                         tb0226_defconfig
m68k                        mvme16x_defconfig
arm                       aspeed_g5_defconfig
arc                           tb10x_defconfig
powerpc                   bluestone_defconfig
mips                           ip27_defconfig
xtensa                          iss_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210308
x86_64               randconfig-a001-20210308
x86_64               randconfig-a004-20210308
x86_64               randconfig-a002-20210308
x86_64               randconfig-a005-20210308
x86_64               randconfig-a003-20210308
i386                 randconfig-a003-20210308
i386                 randconfig-a002-20210308
i386                 randconfig-a006-20210308
i386                 randconfig-a004-20210308
i386                 randconfig-a001-20210308
i386                 randconfig-a005-20210308
x86_64               randconfig-a013-20210309
x86_64               randconfig-a016-20210309
x86_64               randconfig-a015-20210309
x86_64               randconfig-a014-20210309
x86_64               randconfig-a011-20210309
x86_64               randconfig-a012-20210309
i386                 randconfig-a016-20210308
i386                 randconfig-a012-20210308
i386                 randconfig-a014-20210308
i386                 randconfig-a013-20210308
i386                 randconfig-a011-20210308
i386                 randconfig-a015-20210308
i386                 randconfig-a016-20210309
i386                 randconfig-a012-20210309
i386                 randconfig-a014-20210309
i386                 randconfig-a013-20210309
i386                 randconfig-a011-20210309
i386                 randconfig-a015-20210309
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
x86_64               randconfig-a006-20210309
x86_64               randconfig-a001-20210309
x86_64               randconfig-a004-20210309
x86_64               randconfig-a002-20210309
x86_64               randconfig-a005-20210309
x86_64               randconfig-a003-20210309
x86_64               randconfig-a013-20210308
x86_64               randconfig-a016-20210308
x86_64               randconfig-a015-20210308
x86_64               randconfig-a014-20210308
x86_64               randconfig-a011-20210308
x86_64               randconfig-a012-20210308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

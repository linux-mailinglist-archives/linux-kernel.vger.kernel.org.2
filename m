Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869C33512D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhDAJ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:56:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:4985 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233780AbhDAJzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:55:41 -0400
IronPort-SDR: 62veesw9jF5pR/LupZGLkI3WJWhfsGzZ15DGGjtcxBxpb9nw4V9SEvXYQBqNXSIIWtF0+65reV
 5owlMWt4plYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="277395666"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="277395666"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 02:55:39 -0700
IronPort-SDR: KHtNyQsJHnrWk3qSk+slxb/piq3ZtbVk1Mq3lpC0uGG51Z8Y1Y5uoRWSFKah3AmMjLhVn/g4k4
 AMfBlTTrYYcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="455912332"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2021 02:55:37 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRu36-0006QY-LD; Thu, 01 Apr 2021 09:55:36 +0000
Date:   Thu, 01 Apr 2021 17:55:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/wab/scsi-mpt3sas] BUILD SUCCESS
 63989acb44df37062aef784ba4ea4da82a3ec78b
Message-ID: <60659889.bJJILx2THu3hlpxW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wab/scsi-mpt3sas
branch HEAD: 63989acb44df37062aef784ba4ea4da82a3ec78b  scsi: mpt3sas: Fix out-of-bounds warnings in _ctl_addnl_diag_query

elapsed time: 722m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
h8300                            allyesconfig
powerpc                   bluestone_defconfig
sh                         microdev_defconfig
m68k                        stmark2_defconfig
powerpc                      cm5200_defconfig
arc                            hsdk_defconfig
openrisc                 simple_smp_defconfig
powerpc                        icon_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                ecovec24-romimage_defconfig
arm                          pcm027_defconfig
sh                            shmin_defconfig
mips                          ath25_defconfig
powerpc                     ppa8548_defconfig
um                               allmodconfig
powerpc                     powernv_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          hp300_defconfig
powerpc                   currituck_defconfig
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
i386                 randconfig-a004-20210331
i386                 randconfig-a006-20210331
i386                 randconfig-a003-20210331
i386                 randconfig-a002-20210331
i386                 randconfig-a001-20210331
i386                 randconfig-a005-20210331
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

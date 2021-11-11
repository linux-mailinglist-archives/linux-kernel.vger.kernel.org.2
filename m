Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4623944DDDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 23:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhKKW0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 17:26:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:25622 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233901AbhKKW0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 17:26:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="231748801"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="231748801"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 14:23:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="492714436"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 14:23:57 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mlIU8-000H9q-CY; Thu, 11 Nov 2021 22:23:56 +0000
Date:   Fri, 12 Nov 2021 06:23:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 3735459037114d31e5acd9894fad9aed104231a0
Message-ID: <618d97c6.kXQa0jma6bsq9RUT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 3735459037114d31e5acd9894fad9aed104231a0  PCI/MSI: Destroy sysfs before freeing entries

elapsed time: 733m

configs tested: 53
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                              allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

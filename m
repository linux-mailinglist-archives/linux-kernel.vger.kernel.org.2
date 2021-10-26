Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EFA43AD55
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhJZHj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:39:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:44103 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhJZHj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:39:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="253379381"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="253379381"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 00:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="572271794"
Received: from lkp-server01.sh.intel.com (HELO b2dc61ad31c3) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Oct 2021 00:36:54 -0700
Received: from kbuild by b2dc61ad31c3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfH0v-0000D4-Hf; Tue, 26 Oct 2021 07:36:53 +0000
Date:   Tue, 26 Oct 2021 15:36:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 c341f1fe1543dfaf94916cef298aa60be545235f
Message-ID: <6177b004.8fOS+Mg+8sQKV7hr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: c341f1fe1543dfaf94916cef298aa60be545235f  x86/fpu: Remove old KVM FPU interface

elapsed time: 1335m

configs tested: 21
configs skipped: 71

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
x86_64               randconfig-a002-20211024
x86_64               randconfig-a004-20211024
x86_64               randconfig-a005-20211024
x86_64               randconfig-a006-20211024
x86_64               randconfig-a001-20211024
x86_64               randconfig-a003-20211024
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

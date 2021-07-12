Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4493C5A19
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357055AbhGLJai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:30:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:55241 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356641AbhGLJah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:30:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209924172"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209924172"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 02:27:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="459125160"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 02:27:46 -0700
Date:   Mon, 12 Jul 2021 17:27:44 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Andreas Oetken <andreas.oetken@siemens.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: arch/nios2/kernel/setup.c:152:6: warning: Unused variable:
 dram_start [unusedVariable]
Message-ID: <20210712092743.GR2022171@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1e16624d7b4376797ede36e3c955375cf0f23298
commit: 7f7bc20bc41a4fbcd2db75b375ac95e5faf958ae nios2: Don't use _end for calculating min_low_pfn
date:   5 months ago
compiler: nios2-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> arch/nios2/kernel/setup.c:152:6: warning: Unused variable: dram_start [unusedVariable]
    int dram_start;
        ^
   arch/nios2/kernel/setup.c:131:6: warning: Uninitialized variable: cmdline_passed [uninitvar]
    if (cmdline_passed[0])
        ^

vim +152 arch/nios2/kernel/setup.c

7f7bc20bc41a4f Andreas Oetken 2021-02-19  149  
27d22413e60009 Ley Foon Tan   2014-11-06  150  void __init setup_arch(char **cmdline_p)
27d22413e60009 Ley Foon Tan   2014-11-06  151  {
0042379279bcac Mike Rapoport  2018-10-26 @152  	int dram_start;

:::::: The code at line 152 was first introduced by commit
:::::: 0042379279bcac871d2a60172f942a3a255ec611 nios2: switch to NO_BOOTMEM

:::::: TO: Mike Rapoport <rppt@linux.vnet.ibm.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

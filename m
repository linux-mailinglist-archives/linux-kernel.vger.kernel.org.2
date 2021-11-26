Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D8C45EAEF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376520AbhKZKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:04:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:36697 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376643AbhKZKCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:02:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235881215"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="235881215"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 01:56:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="457619479"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2021 01:56:23 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqXxv-0007vz-3M; Fri, 26 Nov 2021 09:56:23 +0000
Date:   Fri, 26 Nov 2021 17:55:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [atishp04:sparse_hartid_support 3/9]
 arch/riscv/kernel/cpu_ops_sbi.c:24: warning: This comment starts with '/**',
 but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202111261703.e95Tql2Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux sparse_hartid_support
head:   b85b7fd1f4028c3e1a895cfe163555241ae742fa
commit: b9432952c1b228a156c1a5959bce4c23c834f1f5 [3/9] RISC-V: Avoid using per cpu array for ordered booting
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20211126/202111261703.e95Tql2Z-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/b9432952c1b228a156c1a5959bce4c23c834f1f5
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 sparse_hartid_support
        git checkout b9432952c1b228a156c1a5959bce4c23c834f1f5
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/cpu_ops_sbi.c:24: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Ordered booting via HSM brings one cpu at a time. Per cpu data strucutre is


vim +24 arch/riscv/kernel/cpu_ops_sbi.c

    22	
    23	/**
  > 24	 * Ordered booting via HSM brings one cpu at a time. Per cpu data strucutre is
    25	 * not required.
    26	 */
    27	static struct sbi_sec_boot_data bdata __section(".data");
    28	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

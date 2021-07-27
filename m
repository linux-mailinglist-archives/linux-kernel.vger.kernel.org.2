Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4385D3D7F76
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhG0Usf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:48:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:30056 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231834AbhG0Usd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:48:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="209415891"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="gz'50?scan'50,208,50";a="209415891"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 13:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="gz'50?scan'50,208,50";a="498945867"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2021 13:48:31 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m8U06-0007Gm-DF; Tue, 27 Jul 2021 20:48:30 +0000
Date:   Wed, 28 Jul 2021 04:47:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Liu Shaohua <liush@allwinnertech.com>
Subject: [csky-linux:v5.14-rc2-of-delay-cpu-available 1/5]
 arch/riscv/mm/dma-mapping.c:56:10: warning: no previous prototype for
 'phys_mem_access_prot'
Message-ID: <202107280437.bpB3hM1m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/c-sky/csky-linux v5.14-rc2-of-delay-cpu-available
head:   f6c22a2278708ce7227c42294e351ff53e8b279a
commit: cf49643a9a30e90e8f914729124a420a4ccfa356 [1/5] riscv: cmo: RFC Add dma-noncoherency support
config: riscv-nommu_k210_defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/cf49643a9a30e90e8f914729124a420a4ccfa356
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux v5.14-rc2-of-delay-cpu-available
        git checkout cf49643a9a30e90e8f914729124a420a4ccfa356
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> arch/riscv/mm/dma-mapping.c:56:10: warning: no previous prototype for 'phys_mem_access_prot' [-Wmissing-prototypes]
      56 | pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
         |          ^~~~~~~~~~~~~~~~~~~~
--
   kernel/dma/pool.c: In function 'atomic_pool_expand':
>> kernel/dma/pool.c:105:9: error: implicit declaration of function 'pgprot_dmacoherent' [-Werror=implicit-function-declaration]
     105 |         pgprot_dmacoherent(PAGE_KERNEL),
         |         ^~~~~~~~~~~~~~~~~~
>> kernel/dma/pool.c:105:9: error: incompatible type for argument 3 of 'dma_common_contiguous_remap'
     105 |         pgprot_dmacoherent(PAGE_KERNEL),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         |
         |         int
   In file included from kernel/dma/pool.c:8:
   include/linux/dma-map-ops.h:232:76: note: expected 'pgprot_t' but argument is of type 'int'
     232 | void *dma_common_contiguous_remap(struct page *page, size_t size, pgprot_t prot,
         |                                                                   ~~~~~~~~~^~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DMA_REMAP
   Depends on MMU
   Selected by
   - DMA_DIRECT_REMAP


vim +/phys_mem_access_prot +56 arch/riscv/mm/dma-mapping.c

    55	
  > 56	pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--8t9RHnE3ZwKMSgU+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
eaPR+fE/RQADi+mBAAA=

--8t9RHnE3ZwKMSgU+--

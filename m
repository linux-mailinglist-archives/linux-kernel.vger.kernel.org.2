Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C31045F747
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 00:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbhKZX6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 18:58:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:55867 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhKZX4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 18:56:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="321959809"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="321959809"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 15:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="675678816"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Nov 2021 15:53:21 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mql1s-0008n6-NE; Fri, 26 Nov 2021 23:53:20 +0000
Date:   Sat, 27 Nov 2021 07:53:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 3/28] arch/riscv/kernel/smp.c:176:50:
 sparse: sparse: incorrect type in argument 4 (different address spaces)
Message-ID: <202111270742.xpkU8cDl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   d3147cebc4aa570424c3bc2ac18831bc3d3bd2d6
commit: 9779a6720c22960d01ea1622f1f433e7dcb473f8 [3/28] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-s032-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270742.xpkU8cDl-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/avpatel/linux/commit/9779a6720c22960d01ea1622f1f433e7dcb473f8
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout 9779a6720c22960d01ea1622f1f433e7dcb473f8
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/smp.c:176:50: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __percpu *percpu_dev_id @@     got int * @@
   arch/riscv/kernel/smp.c:176:50: sparse:     expected void [noderef] __percpu *percpu_dev_id
   arch/riscv/kernel/smp.c:176:50: sparse:     got int *

vim +176 arch/riscv/kernel/smp.c

   161	
   162	void riscv_ipi_set_virq_range(int virq, int nr)
   163	{
   164		int i, err;
   165	
   166		if (WARN_ON(ipi_virq_base))
   167			return;
   168	
   169		WARN_ON(nr < IPI_MAX);
   170		nr_ipi = min(nr, IPI_MAX);
   171		ipi_virq_base = virq;
   172	
   173		/* Request IPIs */
   174		for (i = 0; i < nr_ipi; i++) {
   175			err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
 > 176						 "IPI", &ipi_virq_base);
   177			WARN_ON(err);
   178	
   179			ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
   180			irq_set_status_flags(ipi_virq_base + i, IRQ_HIDDEN);
   181		}
   182	
   183		/* Enabled IPIs for boot CPU immediately */
   184		riscv_ipi_enable();
   185	}
   186	EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
   187	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

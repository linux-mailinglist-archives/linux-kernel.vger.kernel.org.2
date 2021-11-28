Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70111460701
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 15:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358074AbhK1O4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 09:56:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:47788 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238011AbhK1Oyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 09:54:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="234566159"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="234566159"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 06:51:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="608384485"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2021 06:51:24 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrLWV-000AlJ-Qs; Sun, 28 Nov 2021 14:51:23 +0000
Date:   Sun, 28 Nov 2021 22:50:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap-fast6 5/9] drivers/infiniband/sw/siw/siw_main.c:196:6:
 warning: variable 'num_cpus' is used uninitialized whenever 'if' condition
 is false
Message-ID: <202111282209.RD5WM62X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-fast6
head:   a24f3834dc8fc58441c4219de9be07bce33b56fb
commit: de4cae808c1983b730d4e53057fa40af17133ffe [5/9] lib/cpumask: add cpumask_weight_{eq,gt,le}
config: arm-randconfig-r016-20211128 (https://download.01.org/0day-ci/archive/20211128/202111282209.RD5WM62X-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5c64d8ef8cc0c0ed3e0f2ae693d99e7f70f20a84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/norov/linux/commit/de4cae808c1983b730d4e53057fa40af17133ffe
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-fast6
        git checkout de4cae808c1983b730d4e53057fa40af17133ffe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/infiniband/sw/siw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/sw/siw/siw_main.c:196:6: warning: variable 'num_cpus' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (cpumask_empty(tx_cpumask)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/sw/siw/siw_main.c:201:7: note: uninitialized use occurs here
           if (!num_cpus)
                ^~~~~~~~
   drivers/infiniband/sw/siw/siw_main.c:196:2: note: remove the 'if' if its condition is always true
           if (cpumask_empty(tx_cpumask)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/sw/siw/siw_main.c:189:17: note: initialize the variable 'num_cpus' to silence this warning
           int i, num_cpus, cpu, min_use, node = sdev->numa_node, tx_cpu = -1;
                          ^
                           = 0
   1 warning generated.


vim +196 drivers/infiniband/sw/siw/siw_main.c

   181	
   182	/*
   183	 * Choose CPU with least number of active QP's from NUMA node of
   184	 * TX interface.
   185	 */
   186	int siw_get_tx_cpu(struct siw_device *sdev)
   187	{
   188		const struct cpumask *tx_cpumask;
   189		int i, num_cpus, cpu, min_use, node = sdev->numa_node, tx_cpu = -1;
   190	
   191		if (node < 0)
   192			tx_cpumask = cpu_online_mask;
   193		else
   194			tx_cpumask = siw_cpu_info.tx_valid_cpus[node];
   195	
 > 196		if (cpumask_empty(tx_cpumask)) {
   197			/* no CPU on this NUMA node */
   198			tx_cpumask = cpu_online_mask;
   199			num_cpus = cpumask_weight(tx_cpumask);
   200		}
   201		if (!num_cpus)
   202			goto out;
   203	
   204		cpu = cpumask_first(tx_cpumask);
   205	
   206		for (i = 0, min_use = SIW_MAX_QP; i < num_cpus;
   207		     i++, cpu = cpumask_next(cpu, tx_cpumask)) {
   208			int usage;
   209	
   210			/* Skip any cores which have no TX thread */
   211			if (!siw_tx_thread[cpu])
   212				continue;
   213	
   214			usage = atomic_read(&per_cpu(siw_use_cnt, cpu));
   215			if (usage <= min_use) {
   216				tx_cpu = cpu;
   217				min_use = usage;
   218			}
   219		}
   220		siw_dbg(&sdev->base_dev,
   221			"tx cpu %d, node %d, %d qp's\n", tx_cpu, node, min_use);
   222	
   223	out:
   224		if (tx_cpu >= 0)
   225			atomic_inc(&per_cpu(siw_use_cnt, tx_cpu));
   226		else
   227			pr_warn("siw: no tx cpu found\n");
   228	
   229		return tx_cpu;
   230	}
   231	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

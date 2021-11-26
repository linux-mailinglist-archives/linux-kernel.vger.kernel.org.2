Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA645E6AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 04:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357946AbhKZD5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 22:57:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:37776 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237257AbhKZDzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 22:55:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="233095783"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="233095783"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 19:52:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="475785786"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 25 Nov 2021 19:52:04 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqSHL-0007R0-Sp; Fri, 26 Nov 2021 03:52:03 +0000
Date:   Fri, 26 Nov 2021 11:51:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xin Hao <xhao@linux.alibaba.com>, sj@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/2] mm/damon/dbgfs: Modify Damon dbfs interface
 dependency in Kconfig
Message-ID: <202111261116.0jysSfsO-lkp@intel.com>
References: <fbf27c39e8f23d12d5474b9b659d3d45f8dd38ca.1637429074.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf27c39e8f23d12d5474b9b659d3d45f8dd38ca.1637429074.git.xhao@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Xin-Hao/mm-damon-dbgfs-Modify-Damon-dbfs-interface-dependency-in-Kconfig/20211121-012819
base:   https://github.com/hnaz/linux-mm master
config: riscv-randconfig-c006-20211121 (https://download.01.org/0day-ci/archive/20211126/202111261116.0jysSfsO-lkp@intel.com/config)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/496f4e2cc535ba7b71a6ff2b82840693d413ae02
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Xin-Hao/mm-damon-dbgfs-Modify-Damon-dbfs-interface-dependency-in-Kconfig/20211121-012819
        git checkout 496f4e2cc535ba7b71a6ff2b82840693d413ae02
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/damon/dbgfs.c:409:3: error: implicit declaration of function 'damon_pa_set_primitives' [-Werror,-Wimplicit-function-declaration]
                   damon_pa_set_primitives(ctx);
                   ^
   mm/damon/dbgfs.c:409:3: note: did you mean 'damon_va_set_primitives'?
   include/linux/damon.h:476:6: note: 'damon_va_set_primitives' declared here
   void damon_va_set_primitives(struct damon_ctx *ctx);
        ^
   1 error generated.


vim +/damon_pa_set_primitives +409 mm/damon/dbgfs.c

4bc05954d00766 SeongJae Park 2021-09-07  353  
4bc05954d00766 SeongJae Park 2021-09-07  354  static ssize_t dbgfs_target_ids_write(struct file *file,
4bc05954d00766 SeongJae Park 2021-09-07  355  		const char __user *buf, size_t count, loff_t *ppos)
4bc05954d00766 SeongJae Park 2021-09-07  356  {
4bc05954d00766 SeongJae Park 2021-09-07  357  	struct damon_ctx *ctx = file->private_data;
2ba00bca84ef3f SeongJae Park 2021-10-28  358  	bool id_is_pid = true;
4bc05954d00766 SeongJae Park 2021-09-07  359  	char *kbuf, *nrs;
4bc05954d00766 SeongJae Park 2021-09-07  360  	unsigned long *targets;
4bc05954d00766 SeongJae Park 2021-09-07  361  	ssize_t nr_targets;
4f521143b7d82a Rongwei Wang  2021-10-28  362  	ssize_t ret;
4bc05954d00766 SeongJae Park 2021-09-07  363  	int i;
4bc05954d00766 SeongJae Park 2021-09-07  364  
4bc05954d00766 SeongJae Park 2021-09-07  365  	kbuf = user_input_str(buf, count, ppos);
4bc05954d00766 SeongJae Park 2021-09-07  366  	if (IS_ERR(kbuf))
4bc05954d00766 SeongJae Park 2021-09-07  367  		return PTR_ERR(kbuf);
4bc05954d00766 SeongJae Park 2021-09-07  368  
4bc05954d00766 SeongJae Park 2021-09-07  369  	nrs = kbuf;
2ba00bca84ef3f SeongJae Park 2021-10-28  370  	if (!strncmp(kbuf, "paddr\n", count)) {
2ba00bca84ef3f SeongJae Park 2021-10-28  371  		id_is_pid = false;
2ba00bca84ef3f SeongJae Park 2021-10-28  372  		/* target id is meaningless here, but we set it just for fun */
2ba00bca84ef3f SeongJae Park 2021-10-28  373  		scnprintf(kbuf, count, "42    ");
2ba00bca84ef3f SeongJae Park 2021-10-28  374  	}
4bc05954d00766 SeongJae Park 2021-09-07  375  
4f521143b7d82a Rongwei Wang  2021-10-28  376  	targets = str_to_target_ids(nrs, count, &nr_targets);
4bc05954d00766 SeongJae Park 2021-09-07  377  	if (!targets) {
4bc05954d00766 SeongJae Park 2021-09-07  378  		ret = -ENOMEM;
4bc05954d00766 SeongJae Park 2021-09-07  379  		goto out;
4bc05954d00766 SeongJae Park 2021-09-07  380  	}
4bc05954d00766 SeongJae Park 2021-09-07  381  
2ba00bca84ef3f SeongJae Park 2021-10-28  382  	if (id_is_pid) {
4bc05954d00766 SeongJae Park 2021-09-07  383  		for (i = 0; i < nr_targets; i++) {
4bc05954d00766 SeongJae Park 2021-09-07  384  			targets[i] = (unsigned long)find_get_pid(
4bc05954d00766 SeongJae Park 2021-09-07  385  					(int)targets[i]);
4bc05954d00766 SeongJae Park 2021-09-07  386  			if (!targets[i]) {
4bc05954d00766 SeongJae Park 2021-09-07  387  				dbgfs_put_pids(targets, i);
4bc05954d00766 SeongJae Park 2021-09-07  388  				ret = -EINVAL;
4bc05954d00766 SeongJae Park 2021-09-07  389  				goto free_targets_out;
4bc05954d00766 SeongJae Park 2021-09-07  390  			}
4bc05954d00766 SeongJae Park 2021-09-07  391  		}
4bc05954d00766 SeongJae Park 2021-09-07  392  	}
4bc05954d00766 SeongJae Park 2021-09-07  393  
4bc05954d00766 SeongJae Park 2021-09-07  394  	mutex_lock(&ctx->kdamond_lock);
4bc05954d00766 SeongJae Park 2021-09-07  395  	if (ctx->kdamond) {
2ba00bca84ef3f SeongJae Park 2021-10-28  396  		if (id_is_pid)
4bc05954d00766 SeongJae Park 2021-09-07  397  			dbgfs_put_pids(targets, nr_targets);
4bc05954d00766 SeongJae Park 2021-09-07  398  		ret = -EBUSY;
4bc05954d00766 SeongJae Park 2021-09-07  399  		goto unlock_out;
4bc05954d00766 SeongJae Park 2021-09-07  400  	}
4bc05954d00766 SeongJae Park 2021-09-07  401  
2ba00bca84ef3f SeongJae Park 2021-10-28  402  	/* remove targets with previously-set primitive */
2ba00bca84ef3f SeongJae Park 2021-10-28  403  	damon_set_targets(ctx, NULL, 0);
2ba00bca84ef3f SeongJae Park 2021-10-28  404  
2ba00bca84ef3f SeongJae Park 2021-10-28  405  	/* Configure the context for the address space type */
2ba00bca84ef3f SeongJae Park 2021-10-28  406  	if (id_is_pid)
2ba00bca84ef3f SeongJae Park 2021-10-28  407  		damon_va_set_primitives(ctx);
2ba00bca84ef3f SeongJae Park 2021-10-28  408  	else
2ba00bca84ef3f SeongJae Park 2021-10-28 @409  		damon_pa_set_primitives(ctx);
2ba00bca84ef3f SeongJae Park 2021-10-28  410  
4f521143b7d82a Rongwei Wang  2021-10-28  411  	ret = damon_set_targets(ctx, targets, nr_targets);
4f521143b7d82a Rongwei Wang  2021-10-28  412  	if (ret) {
2ba00bca84ef3f SeongJae Park 2021-10-28  413  		if (id_is_pid)
4bc05954d00766 SeongJae Park 2021-09-07  414  			dbgfs_put_pids(targets, nr_targets);
4f521143b7d82a Rongwei Wang  2021-10-28  415  	} else {
4f521143b7d82a Rongwei Wang  2021-10-28  416  		ret = count;
4bc05954d00766 SeongJae Park 2021-09-07  417  	}
4bc05954d00766 SeongJae Park 2021-09-07  418  
4bc05954d00766 SeongJae Park 2021-09-07  419  unlock_out:
4bc05954d00766 SeongJae Park 2021-09-07  420  	mutex_unlock(&ctx->kdamond_lock);
4bc05954d00766 SeongJae Park 2021-09-07  421  free_targets_out:
4bc05954d00766 SeongJae Park 2021-09-07  422  	kfree(targets);
4bc05954d00766 SeongJae Park 2021-09-07  423  out:
4bc05954d00766 SeongJae Park 2021-09-07  424  	kfree(kbuf);
4bc05954d00766 SeongJae Park 2021-09-07  425  	return ret;
4bc05954d00766 SeongJae Park 2021-09-07  426  }
4bc05954d00766 SeongJae Park 2021-09-07  427  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D3A3E7DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 18:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhHJQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 12:56:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:26471 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231699AbhHJQzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:55:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="202126578"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="gz'50?scan'50,208,50";a="202126578"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 09:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="gz'50?scan'50,208,50";a="515911500"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2021 09:54:57 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mDV1k-000Km9-Q7; Tue, 10 Aug 2021 16:54:56 +0000
Date:   Wed, 11 Aug 2021 00:54:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tanner Love <tannerlove@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [tip:irq/core 14/15] kernel/irq/manage.c:1324:7: error:
 'force_irqthreads' undeclared; did you mean 'force_irqthreads_key'?
Message-ID: <202108110016.UvLAF7dZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
head:   1d07a835819e2d3c85af8f093a02c2e6bca422d6
commit: af5b7fe6bb77ac775d446e2f25f013d5df551e9a [14/15] genirq: Change force_irqthreads to a static key
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=af5b7fe6bb77ac775d446e2f25f013d5df551e9a
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip irq/core
        git checkout af5b7fe6bb77ac775d446e2f25f013d5df551e9a
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/irq/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/irq/manage.c: In function 'irq_setup_forced_threading':
>> kernel/irq/manage.c:1324:7: error: 'force_irqthreads' undeclared (first use in this function); did you mean 'force_irqthreads_key'?
    1324 |  if (!force_irqthreads)
         |       ^~~~~~~~~~~~~~~~
         |       force_irqthreads_key
   kernel/irq/manage.c:1324:7: note: each undeclared identifier is reported only once for each function it appears in


vim +1324 kernel/irq/manage.c

a92444c6b2225a Thomas Gleixner 2014-02-15  1321  
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1322  static int irq_setup_forced_threading(struct irqaction *new)
8d32a307e4faa8 Thomas Gleixner 2011-02-23  1323  {
8d32a307e4faa8 Thomas Gleixner 2011-02-23 @1324  	if (!force_irqthreads)
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1325  		return 0;
8d32a307e4faa8 Thomas Gleixner 2011-02-23  1326  	if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1327  		return 0;
8d32a307e4faa8 Thomas Gleixner 2011-02-23  1328  
d1f0301b3333ee Thomas Gleixner 2018-08-03  1329  	/*
d1f0301b3333ee Thomas Gleixner 2018-08-03  1330  	 * No further action required for interrupts which are requested as
d1f0301b3333ee Thomas Gleixner 2018-08-03  1331  	 * threaded interrupts already
d1f0301b3333ee Thomas Gleixner 2018-08-03  1332  	 */
d1f0301b3333ee Thomas Gleixner 2018-08-03  1333  	if (new->handler == irq_default_primary_handler)
d1f0301b3333ee Thomas Gleixner 2018-08-03  1334  		return 0;
d1f0301b3333ee Thomas Gleixner 2018-08-03  1335  
8d32a307e4faa8 Thomas Gleixner 2011-02-23  1336  	new->flags |= IRQF_ONESHOT;
8d32a307e4faa8 Thomas Gleixner 2011-02-23  1337  
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1338  	/*
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1339  	 * Handle the case where we have a real primary handler and a
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1340  	 * thread handler. We force thread them as well by creating a
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1341  	 * secondary action.
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1342  	 */
d1f0301b3333ee Thomas Gleixner 2018-08-03  1343  	if (new->handler && new->thread_fn) {
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1344  		/* Allocate the secondary action */
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1345  		new->secondary = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1346  		if (!new->secondary)
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1347  			return -ENOMEM;
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1348  		new->secondary->handler = irq_forced_secondary_handler;
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1349  		new->secondary->thread_fn = new->thread_fn;
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1350  		new->secondary->dev_id = new->dev_id;
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1351  		new->secondary->irq = new->irq;
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1352  		new->secondary->name = new->name;
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1353  	}
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1354  	/* Deal with the primary handler */
8d32a307e4faa8 Thomas Gleixner 2011-02-23  1355  	set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
8d32a307e4faa8 Thomas Gleixner 2011-02-23  1356  	new->thread_fn = new->handler;
8d32a307e4faa8 Thomas Gleixner 2011-02-23  1357  	new->handler = irq_default_primary_handler;
2a1d3ab8986d1b Thomas Gleixner 2015-09-21  1358  	return 0;
8d32a307e4faa8 Thomas Gleixner 2011-02-23  1359  }
8d32a307e4faa8 Thomas Gleixner 2011-02-23  1360  

:::::: The code at line 1324 was first introduced by commit
:::::: 8d32a307e4faa8b123dc8a9cd56d1a7525f69ad3 genirq: Provide forced interrupt threading

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--XsQoSWH+UP9D9v3l
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--XsQoSWH+UP9D9v3l--

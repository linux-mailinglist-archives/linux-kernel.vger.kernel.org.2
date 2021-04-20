Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619303652AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 08:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhDTG5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 02:57:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:12313 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhDTG5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 02:57:49 -0400
IronPort-SDR: Cd1ScbYY4CO+TxV9mYpSnVaL59odkx6ea68ZOVh64v4rW3NzuZ4LN8z2j1zqS0A7WbpP/mcE6c
 xHR0pcuW0zsA==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="195569210"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="gz'50?scan'50,208,50";a="195569210"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 23:57:18 -0700
IronPort-SDR: AxYnYwz4kbgGat0JIYIWMGO11LEBBxT/7+VAnQDSUhepwDAkjFNLTlmE5R0BLc/+ruWmSzTUpX
 tNu9CHRx5Jhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="gz'50?scan'50,208,50";a="383975930"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2021 23:57:16 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYkJw-0002D0-7b; Tue, 20 Apr 2021 06:57:16 +0000
Date:   Tue, 20 Apr 2021 14:56:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: kernel/rcu/tasks.h:1031:6: warning: no previous prototype for
 'show_rcu_tasks_gp_kthreads'
Message-ID: <202104201428.oLpgo4lI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7af08140979a6e7e12b78c93b8625c8d25b084e2
commit: e21408ceec2de5be418efa39feb1e2c00f824a72 rcu-tasks: Add RCU tasks to rcutorture writer stall output
date:   12 months ago
config: h8300-allnoconfig (attached as .config)
compiler: h8300-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e21408ceec2de5be418efa39feb1e2c00f824a72
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e21408ceec2de5be418efa39feb1e2c00f824a72
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/rcu/update.c:587:
>> kernel/rcu/tasks.h:1031:6: warning: no previous prototype for 'show_rcu_tasks_gp_kthreads' [-Wmissing-prototypes]
    1031 | void show_rcu_tasks_gp_kthreads(void) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/show_rcu_tasks_gp_kthreads +1031 kernel/rcu/tasks.h

  1028	
  1029	#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
  1030	static inline void rcu_tasks_bootup_oddness(void) {}
> 1031	void show_rcu_tasks_gp_kthreads(void) {}

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Rnp224OUXqcI/wF69yTcuEEAAA==

--RnlQjJ0d97Da+TV1--

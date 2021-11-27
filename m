Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E54B45FEDB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245353AbhK0NdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 08:33:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:47388 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239495AbhK0NbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 08:31:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235697120"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="235697120"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 05:27:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="608117170"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 27 Nov 2021 05:27:52 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqxk8-0009aO-8S; Sat, 27 Nov 2021 13:27:52 +0000
Date:   Sat, 27 Nov 2021 21:27:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap-tmp 7/8] arch/x86/kernel/cpu/resctrl/rdtgroup.c:446:1:
 error: function definition is not allowed here
Message-ID: <202111272119.P7YNVN8n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-tmp
head:   75ee333c81c999b29a49810611fb160cec32217d
commit: 29f49f10b3fbef5a88db0a7e370984297616f0fa [7/8] lib/cpumask: replace cpumask_weight with cpumask_{empty,gt,le,eq}
config: i386-randconfig-a002-20211126 (https://download.01.org/0day-ci/archive/20211127/202111272119.P7YNVN8n-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/29f49f10b3fbef5a88db0a7e370984297616f0fa
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-tmp
        git checkout 29f49f10b3fbef5a88db0a7e370984297616f0fa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:446:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:526:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:532:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:542:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:551:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:598:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:604:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:616:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:636:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:658:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:687:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:717:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:730:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:779:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:832:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:847:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:856:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:866:1: error: function definition is not allowed here
   {
   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:876:1: error: function definition is not allowed here
   {
   ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +446 arch/x86/kernel/cpu/resctrl/rdtgroup.c

b09d981b3f3466 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  443  
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  444  static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  445  				   char *buf, size_t nbytes, loff_t off)
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28 @446  {
a9fcf8627dc010 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  447  	cpumask_var_t tmpmask, newmask, tmpmask1;
b09d981b3f3466 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  448  	struct rdtgroup *rdtgrp;
f410770293a1fb arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Fenghua Yu      2016-11-11  449  	int ret;
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  450  
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  451  	if (!buf)
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  452  		return -EINVAL;
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  453  
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  454  	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  455  		return -ENOMEM;
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  456  	if (!zalloc_cpumask_var(&newmask, GFP_KERNEL)) {
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  457  		free_cpumask_var(tmpmask);
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  458  		return -ENOMEM;
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  459  	}
a9fcf8627dc010 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  460  	if (!zalloc_cpumask_var(&tmpmask1, GFP_KERNEL)) {
a9fcf8627dc010 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  461  		free_cpumask_var(tmpmask);
a9fcf8627dc010 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  462  		free_cpumask_var(newmask);
a9fcf8627dc010 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  463  		return -ENOMEM;
a9fcf8627dc010 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  464  	}
a2584e1d5a74e8 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Thomas Gleixner 2016-11-15  465  
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  466  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  467  	if (!rdtgrp) {
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  468  		ret = -ENOENT;
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  469  		goto unlock;
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  470  	}
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  471  
c966dac8a5ede5 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  472  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
c966dac8a5ede5 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  473  	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
c966dac8a5ede5 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  474  		ret = -EINVAL;
723f1a0dd8e26a arch/x86/kernel/cpu/resctrl/rdtgroup.c   Babu Moger      2018-11-21  475  		rdt_last_cmd_puts("Pseudo-locking in progress\n");
c966dac8a5ede5 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  476  		goto unlock;
c966dac8a5ede5 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  477  	}
c966dac8a5ede5 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Reinette Chatre 2018-06-22  478  
4ffa3c977b5da2 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Jiri Olsa       2017-04-10  479  	if (is_cpu_list(of))
4ffa3c977b5da2 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Jiri Olsa       2017-04-10  480  		ret = cpulist_parse(buf, newmask);
4ffa3c977b5da2 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Jiri Olsa       2017-04-10  481  	else
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  482  		ret = cpumask_parse(buf, newmask);
4ffa3c977b5da2 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Jiri Olsa       2017-04-10  483  
94457b36e8a502 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2017-09-25  484  	if (ret) {
723f1a0dd8e26a arch/x86/kernel/cpu/resctrl/rdtgroup.c   Babu Moger      2018-11-21  485  		rdt_last_cmd_puts("Bad CPU list/mask\n");
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  486  		goto unlock;
94457b36e8a502 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2017-09-25  487  	}
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  488  
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  489  	/* check that user didn't specify any offline cpus */
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  490  	cpumask_andnot(tmpmask, newmask, cpu_online_mask);
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  491  	if (cpumask_weight(tmpmask)) {
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  492  		ret = -EINVAL;
723f1a0dd8e26a arch/x86/kernel/cpu/resctrl/rdtgroup.c   Babu Moger      2018-11-21  493  		rdt_last_cmd_puts("Can only assign online CPUs\n");
a2584e1d5a74e8 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Thomas Gleixner 2016-11-15  494  		goto unlock;
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  495  	}
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  496  
b09d981b3f3466 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  497  	if (rdtgrp->type == RDTCTRL_GROUP)
a9fcf8627dc010 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  498  		ret = cpus_ctrl_write(rdtgrp, newmask, tmpmask, tmpmask1);
a9fcf8627dc010 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  499  	else if (rdtgrp->type == RDTMON_GROUP)
a9fcf8627dc010 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  500  		ret = cpus_mon_write(rdtgrp, newmask, tmpmask);
b09d981b3f3466 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  501  	else
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  502  		ret = -EINVAL;
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  503  
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  504  unlock:
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  505  	rdtgroup_kn_unlock(of->kn);
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  506  	free_cpumask_var(tmpmask);
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  507  	free_cpumask_var(newmask);
a9fcf8627dc010 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  508  	free_cpumask_var(tmpmask1);
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  509  
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  510  	return ret ?: nbytes;
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  511  }
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  512  

:::::: The code at line 446 was first introduced by commit
:::::: 12e0110c11a460b890ed7e1071198ced732152c9 x86/intel_rdt: Add cpus file

:::::: TO: Tony Luck <tony.luck@intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

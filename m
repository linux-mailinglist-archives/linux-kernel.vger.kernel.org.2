Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3831845CABF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhKXRX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:23:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:58334 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234401AbhKXRXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:23:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="296135238"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="296135238"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 09:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="457106953"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Nov 2021 09:14:56 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpvrE-000563-2i; Wed, 24 Nov 2021 17:14:56 +0000
Date:   Thu, 25 Nov 2021 01:14:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap-20211123 6/6]
 arch/x86/kernel/cpu/resctrl/rdtgroup.c:444:1: warning: ISO C90 forbids mixed
 declarations and code
Message-ID: <202111250149.3ztPvkO5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-20211123
head:   160c7117e01f07ec3e2762d05fd94479a4d0a06f
commit: 160c7117e01f07ec3e2762d05fd94479a4d0a06f [6/6] lib/cpumask: replace cpumask_weight with cpumask_{empty,gt,le,eq}
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211125/202111250149.3ztPvkO5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/norov/linux/commit/160c7117e01f07ec3e2762d05fd94479a4d0a06f
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-20211123
        git checkout 160c7117e01f07ec3e2762d05fd94479a4d0a06f
        # save the config file to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kernel/cpu/resctrl/rdtgroup.c: In function 'cpus_ctrl_write':
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:444:16: error: invalid storage class for function 'rdtgroup_cpus_write'
     444 | static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
         |                ^~~~~~~~~~~~~~~~~~~
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:444:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     444 | static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
         | ^~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:525:13: error: invalid storage class for function 'rdtgroup_remove'
     525 | static void rdtgroup_remove(struct rdtgroup *rdtgrp)
         |             ^~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:531:13: error: invalid storage class for function '_update_task_closid_rmid'
     531 | static void _update_task_closid_rmid(void *task)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:541:13: error: invalid storage class for function 'update_task_closid_rmid'
     541 | static void update_task_closid_rmid(struct task_struct *t)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:549:12: error: invalid storage class for function '__rdtgroup_move_task'
     549 | static int __rdtgroup_move_task(struct task_struct *tsk,
         |            ^~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:597:13: error: invalid storage class for function 'is_closid_match'
     597 | static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
         |             ^~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:603:13: error: invalid storage class for function 'is_rmid_match'
     603 | static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
         |             ^~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:634:12: error: invalid storage class for function 'rdtgroup_task_write_permission'
     634 | static int rdtgroup_task_write_permission(struct task_struct *task,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:656:12: error: invalid storage class for function 'rdtgroup_move_task'
     656 | static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
         |            ^~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:685:16: error: invalid storage class for function 'rdtgroup_tasks_write'
     685 | static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
         |                ^~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:716:13: error: invalid storage class for function 'show_rdt_tasks'
     716 | static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
         |             ^~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:728:12: error: invalid storage class for function 'rdtgroup_tasks_show'
     728 | static int rdtgroup_tasks_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:830:12: error: invalid storage class for function 'rdt_last_cmd_status_show'
     830 | static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:845:12: error: invalid storage class for function 'rdt_num_closids_show'
     845 | static int rdt_num_closids_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:854:12: error: invalid storage class for function 'rdt_default_ctrl_show'
     854 | static int rdt_default_ctrl_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:864:12: error: invalid storage class for function 'rdt_min_cbm_bits_show'
     864 | static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:874:12: error: invalid storage class for function 'rdt_shareable_bits_show'
     874 | static int rdt_shareable_bits_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:898:12: error: invalid storage class for function 'rdt_bit_usage_show'
     898 | static int rdt_bit_usage_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:978:12: error: invalid storage class for function 'rdt_min_bw_show'
     978 | static int rdt_min_bw_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:988:12: error: invalid storage class for function 'rdt_num_rmids_show'
     988 | static int rdt_num_rmids_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:998:12: error: invalid storage class for function 'rdt_mon_features_show'
     998 | static int rdt_mon_features_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1010:12: error: invalid storage class for function 'rdt_bw_gran_show'
    1010 | static int rdt_bw_gran_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1020:12: error: invalid storage class for function 'rdt_delay_linear_show'
    1020 | static int rdt_delay_linear_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1030:12: error: invalid storage class for function 'max_threshold_occ_show'
    1030 | static int max_threshold_occ_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1041:12: error: invalid storage class for function 'rdt_thread_throttle_mode_show'
    1041 | static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1055:16: error: invalid storage class for function 'max_threshold_occ_write'
    1055 | static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1078:12: error: invalid storage class for function 'rdtgroup_mode_show'
    1078 | static int rdtgroup_mode_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1095:31: error: invalid storage class for function 'resctrl_peer_type'
    1095 | static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
         |                               ^~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1128:13: error: invalid storage class for function '__rdtgroup_cbm_overlaps'
    1128 | static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1210:13: error: invalid storage class for function 'rdtgroup_mode_test_exclusive'
    1210 | static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1246:16: error: invalid storage class for function 'rdtgroup_mode_write'
    1246 | static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
         |                ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1355:12: error: invalid storage class for function 'rdtgroup_size_show'
    1355 | static int rdtgroup_size_show(struct kernfs_open_file *of,
         |            ^~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1425:15: error: initializer element is not constant
    1425 |   .seq_show = rdt_last_cmd_status_show,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1425:15: note: (near initialization for 'res_common_files[0].seq_show')
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1432:15: error: initializer element is not constant


vim +444 arch/x86/kernel/cpu/resctrl/rdtgroup.c

b09d981b3f3466 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Vikas Shivappa  2017-07-25  443  
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28 @444  static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  445  				   char *buf, size_t nbytes, loff_t off)
12e0110c11a460 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c Tony Luck       2016-10-28  446  {
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

:::::: The code at line 444 was first introduced by commit
:::::: 12e0110c11a460b890ed7e1071198ced732152c9 x86/intel_rdt: Add cpus file

:::::: TO: Tony Luck <tony.luck@intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

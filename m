Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF9931B383
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 00:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBNX5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 18:57:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:59869 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhBNX5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 18:57:31 -0500
IronPort-SDR: ubAF6a4Z+FSnad71eI0RHQUQYWT9UFEDOfl+8ajMjqNl4WVv0HJhfRoN8IZqRFhYMhiQobhP0t
 A5DN1uhywd6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="161746897"
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400"; 
   d="gz'50?scan'50,208,50";a="161746897"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2021 15:56:49 -0800
IronPort-SDR: FEbd6uOWsQ84xm7oL5aKIFgyQXAh6Q5VsvWmJGWzfvNY+RUbUomXbYGlHlUF1Vi21CWD+gjfjx
 RaaYoBsUOrOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400"; 
   d="gz'50?scan'50,208,50";a="383143378"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2021 15:56:46 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lBRFu-0006zt-9L; Sun, 14 Feb 2021 23:56:46 +0000
Date:   Mon, 15 Feb 2021 07:56:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/net/bonding/bond_main.c:4877:3: warning: 'strncpy' specified
 bound 16 equals destination size
Message-ID: <202102150705.fdR6obB0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   358feceebbf68f33c44c6650d14455389e65282d
commit: 8d58f222e85f01da0c0e1fc1e77986c86de889e2 ubsan: disable UBSAN_ALIGNMENT under COMPILE_TEST
date:   9 months ago
config: s390-randconfig-r014-20210215 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d58f222e85f01da0c0e1fc1e77986c86de889e2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8d58f222e85f01da0c0e1fc1e77986c86de889e2
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

         |                            ^~~~~~~~~~~~
   include/net/sch_generic.h:868:2: note: in expansion of macro 'this_cpu_inc'
     868 |  this_cpu_inc(sch->cpu_qstats->qlen);
         |  ^~~~~~~~~~~~
   include/net/sch_generic.h: In function 'qdisc_qstats_cpu_qlen_dec':
   arch/s390/include/asm/percpu.h:74:21: warning: comparison is always true due to limited range of data type [-Wtype-limits]
      74 |      ((szcast)val__ > -129) && ((szcast)val__ < 128)) {  \
         |                     ^
   arch/s390/include/asm/percpu.h:91:34: note: in expansion of macro 'arch_this_cpu_add'
      91 | #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
         |                                  ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:11: note: in expansion of macro 'this_cpu_add_8'
     380 |   case 8: stem##8(variable, __VA_ARGS__);break;  \
         |           ^~~~
   include/linux/percpu-defs.h:509:33: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)  __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:519:33: note: in expansion of macro 'this_cpu_add'
     519 | #define this_cpu_sub(pcp, val)  this_cpu_add(pcp, -(typeof(pcp))(val))
         |                                 ^~~~~~~~~~~~
   include/linux/percpu-defs.h:521:28: note: in expansion of macro 'this_cpu_sub'
     521 | #define this_cpu_dec(pcp)  this_cpu_sub(pcp, 1)
         |                            ^~~~~~~~~~~~
   include/net/sch_generic.h:873:2: note: in expansion of macro 'this_cpu_dec'
     873 |  this_cpu_dec(sch->cpu_qstats->qlen);
         |  ^~~~~~~~~~~~
   include/net/sch_generic.h: In function 'qdisc_qstats_cpu_requeues_inc':
   arch/s390/include/asm/percpu.h:74:21: warning: comparison is always true due to limited range of data type [-Wtype-limits]
      74 |      ((szcast)val__ > -129) && ((szcast)val__ < 128)) {  \
         |                     ^
   arch/s390/include/asm/percpu.h:91:34: note: in expansion of macro 'arch_this_cpu_add'
      91 | #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
         |                                  ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:11: note: in expansion of macro 'this_cpu_add_8'
     380 |   case 8: stem##8(variable, __VA_ARGS__);break;  \
         |           ^~~~
   include/linux/percpu-defs.h:509:33: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)  __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:520:28: note: in expansion of macro 'this_cpu_add'
     520 | #define this_cpu_inc(pcp)  this_cpu_add(pcp, 1)
         |                            ^~~~~~~~~~~~
   include/net/sch_generic.h:878:2: note: in expansion of macro 'this_cpu_inc'
     878 |  this_cpu_inc(sch->cpu_qstats->requeues);
         |  ^~~~~~~~~~~~
   include/net/sch_generic.h: In function 'qdisc_qstats_cpu_drop':
   arch/s390/include/asm/percpu.h:74:21: warning: comparison is always true due to limited range of data type [-Wtype-limits]
      74 |      ((szcast)val__ > -129) && ((szcast)val__ < 128)) {  \
         |                     ^
   arch/s390/include/asm/percpu.h:91:34: note: in expansion of macro 'arch_this_cpu_add'
      91 | #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
         |                                  ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:11: note: in expansion of macro 'this_cpu_add_8'
     380 |   case 8: stem##8(variable, __VA_ARGS__);break;  \
         |           ^~~~
   include/linux/percpu-defs.h:509:33: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)  __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:520:28: note: in expansion of macro 'this_cpu_add'
     520 | #define this_cpu_inc(pcp)  this_cpu_add(pcp, 1)
         |                            ^~~~~~~~~~~~
   include/net/sch_generic.h:903:2: note: in expansion of macro 'this_cpu_inc'
     903 |  this_cpu_inc(sch->cpu_qstats->drops);
         |  ^~~~~~~~~~~~
   include/net/sch_generic.h: In function 'qdisc_update_stats_at_enqueue':
   arch/s390/include/asm/percpu.h:74:21: warning: comparison is always true due to limited range of data type [-Wtype-limits]
      74 |      ((szcast)val__ > -129) && ((szcast)val__ < 128)) {  \
         |                     ^
   arch/s390/include/asm/percpu.h:91:34: note: in expansion of macro 'arch_this_cpu_add'
      91 | #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
         |                                  ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:11: note: in expansion of macro 'this_cpu_add_8'
     380 |   case 8: stem##8(variable, __VA_ARGS__);break;  \
         |           ^~~~
   include/linux/percpu-defs.h:509:33: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)  __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                 ^~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1102:3: note: in expansion of macro 'this_cpu_add'
    1102 |   this_cpu_add(sch->cpu_qstats->backlog, pkt_len);
         |   ^~~~~~~~~~~~
   include/net/sch_generic.h: In function 'mini_qdisc_qstats_cpu_drop':
   arch/s390/include/asm/percpu.h:74:21: warning: comparison is always true due to limited range of data type [-Wtype-limits]
      74 |      ((szcast)val__ > -129) && ((szcast)val__ < 128)) {  \
         |                     ^
   arch/s390/include/asm/percpu.h:91:34: note: in expansion of macro 'arch_this_cpu_add'
      91 | #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
         |                                  ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:11: note: in expansion of macro 'this_cpu_add_8'
     380 |   case 8: stem##8(variable, __VA_ARGS__);break;  \
         |           ^~~~
   include/linux/percpu-defs.h:509:33: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)  __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:520:28: note: in expansion of macro 'this_cpu_add'
     520 | #define this_cpu_inc(pcp)  this_cpu_add(pcp, 1)
         |                            ^~~~~~~~~~~~
   include/net/sch_generic.h:1271:2: note: in expansion of macro 'this_cpu_inc'
    1271 |  this_cpu_inc(miniq->cpu_qstats->drops);
         |  ^~~~~~~~~~~~
   drivers/net/bonding/bond_main.c: In function 'bond_check_params.constprop':
>> drivers/net/bonding/bond_main.c:4877:3: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
    4877 |   strncpy(params->primary, primary, IFNAMSIZ);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +4877 drivers/net/bonding/bond_main.c

^1da177e4c3f41 Linus Torvalds       2005-04-16  4499  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4500  static int bond_check_params(struct bond_params *params)
^1da177e4c3f41 Linus Torvalds       2005-04-16  4501  {
5a5c5fd48e3bcd nikolay@redhat.com   2013-05-18  4502  	int arp_validate_value, fail_over_mac_value, primary_reselect_value, i;
f3253339a47ff3 stephen hemminger    2014-03-04  4503  	struct bond_opt_value newval;
f3253339a47ff3 stephen hemminger    2014-03-04  4504  	const struct bond_opt_value *valptr;
72ccc471e13b82 Jarod Wilson         2017-05-19  4505  	int arp_all_targets_value = 0;
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4506  	u16 ad_actor_sys_prio = 0;
d22a5fc0c32edc Mahesh Bandewar      2015-05-09  4507  	u16 ad_user_port_key = 0;
72ccc471e13b82 Jarod Wilson         2017-05-19  4508  	__be32 arp_target[BOND_MAX_ARP_TARGETS] = { 0 };
dc9c4d0fe023b5 Mahesh Bandewar      2017-03-08  4509  	int arp_ip_count;
dc9c4d0fe023b5 Mahesh Bandewar      2017-03-08  4510  	int bond_mode	= BOND_MODE_ROUNDROBIN;
dc9c4d0fe023b5 Mahesh Bandewar      2017-03-08  4511  	int xmit_hashtype = BOND_XMIT_POLICY_LAYER2;
dc9c4d0fe023b5 Mahesh Bandewar      2017-03-08  4512  	int lacp_fast = 0;
f13ad104b4e886 Nikolay Aleksandrov  2017-09-12  4513  	int tlb_dynamic_lb;
f5b2b966f032f2 Jay Vosburgh         2006-09-22  4514  
547942cace50e5 Nikolay Aleksandrov  2014-09-15  4515  	/* Convert string parameters. */
^1da177e4c3f41 Linus Torvalds       2005-04-16  4516  	if (mode) {
2b3798d5e1377c Nikolay Aleksandrov  2014-01-22  4517  		bond_opt_initstr(&newval, mode);
2b3798d5e1377c Nikolay Aleksandrov  2014-01-22  4518  		valptr = bond_opt_parse(bond_opt_get(BOND_OPT_MODE), &newval);
2b3798d5e1377c Nikolay Aleksandrov  2014-01-22  4519  		if (!valptr) {
2b3798d5e1377c Nikolay Aleksandrov  2014-01-22  4520  			pr_err("Error: Invalid bonding mode \"%s\"\n", mode);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4521  			return -EINVAL;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4522  		}
2b3798d5e1377c Nikolay Aleksandrov  2014-01-22  4523  		bond_mode = valptr->value;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4524  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4525  
169a3e66637c66 Jay Vosburgh         2005-06-26  4526  	if (xmit_hash_policy) {
e79c1055749e31 Debabrata Banerjee   2018-05-14  4527  		if (bond_mode == BOND_MODE_ROUNDROBIN ||
e79c1055749e31 Debabrata Banerjee   2018-05-14  4528  		    bond_mode == BOND_MODE_ACTIVEBACKUP ||
e79c1055749e31 Debabrata Banerjee   2018-05-14  4529  		    bond_mode == BOND_MODE_BROADCAST) {
a4aee5c808fc5b Joe Perches          2009-12-13  4530  			pr_info("xmit_hash_policy param is irrelevant in mode %s\n",
169a3e66637c66 Jay Vosburgh         2005-06-26  4531  				bond_mode_name(bond_mode));
169a3e66637c66 Jay Vosburgh         2005-06-26  4532  		} else {
a4b32ce7f891d5 Nikolay Aleksandrov  2014-01-22  4533  			bond_opt_initstr(&newval, xmit_hash_policy);
a4b32ce7f891d5 Nikolay Aleksandrov  2014-01-22  4534  			valptr = bond_opt_parse(bond_opt_get(BOND_OPT_XMIT_HASH),
a4b32ce7f891d5 Nikolay Aleksandrov  2014-01-22  4535  						&newval);
a4b32ce7f891d5 Nikolay Aleksandrov  2014-01-22  4536  			if (!valptr) {
a4aee5c808fc5b Joe Perches          2009-12-13  4537  				pr_err("Error: Invalid xmit_hash_policy \"%s\"\n",
169a3e66637c66 Jay Vosburgh         2005-06-26  4538  				       xmit_hash_policy);
169a3e66637c66 Jay Vosburgh         2005-06-26  4539  				return -EINVAL;
169a3e66637c66 Jay Vosburgh         2005-06-26  4540  			}
a4b32ce7f891d5 Nikolay Aleksandrov  2014-01-22  4541  			xmit_hashtype = valptr->value;
169a3e66637c66 Jay Vosburgh         2005-06-26  4542  		}
169a3e66637c66 Jay Vosburgh         2005-06-26  4543  	}
169a3e66637c66 Jay Vosburgh         2005-06-26  4544  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4545  	if (lacp_rate) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  4546  		if (bond_mode != BOND_MODE_8023AD) {
a4aee5c808fc5b Joe Perches          2009-12-13  4547  			pr_info("lacp_rate param is irrelevant in mode %s\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  4548  				bond_mode_name(bond_mode));
^1da177e4c3f41 Linus Torvalds       2005-04-16  4549  		} else {
d3131de76b1b1a Nikolay Aleksandrov  2014-01-22  4550  			bond_opt_initstr(&newval, lacp_rate);
d3131de76b1b1a Nikolay Aleksandrov  2014-01-22  4551  			valptr = bond_opt_parse(bond_opt_get(BOND_OPT_LACP_RATE),
d3131de76b1b1a Nikolay Aleksandrov  2014-01-22  4552  						&newval);
d3131de76b1b1a Nikolay Aleksandrov  2014-01-22  4553  			if (!valptr) {
a4aee5c808fc5b Joe Perches          2009-12-13  4554  				pr_err("Error: Invalid lacp rate \"%s\"\n",
d3131de76b1b1a Nikolay Aleksandrov  2014-01-22  4555  				       lacp_rate);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4556  				return -EINVAL;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4557  			}
d3131de76b1b1a Nikolay Aleksandrov  2014-01-22  4558  			lacp_fast = valptr->value;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4559  		}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4560  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4561  
fd989c83325cb3 Jay Vosburgh         2008-11-04  4562  	if (ad_select) {
548d28bd0eac84 Nikolay Aleksandrov  2014-07-13  4563  		bond_opt_initstr(&newval, ad_select);
9e5f5eebe765b3 Nikolay Aleksandrov  2014-01-22  4564  		valptr = bond_opt_parse(bond_opt_get(BOND_OPT_AD_SELECT),
9e5f5eebe765b3 Nikolay Aleksandrov  2014-01-22  4565  					&newval);
9e5f5eebe765b3 Nikolay Aleksandrov  2014-01-22  4566  		if (!valptr) {
9e5f5eebe765b3 Nikolay Aleksandrov  2014-01-22  4567  			pr_err("Error: Invalid ad_select \"%s\"\n", ad_select);
fd989c83325cb3 Jay Vosburgh         2008-11-04  4568  			return -EINVAL;
fd989c83325cb3 Jay Vosburgh         2008-11-04  4569  		}
9e5f5eebe765b3 Nikolay Aleksandrov  2014-01-22  4570  		params->ad_select = valptr->value;
9e5f5eebe765b3 Nikolay Aleksandrov  2014-01-22  4571  		if (bond_mode != BOND_MODE_8023AD)
91565ebbcc5aea Joe Perches          2014-02-15  4572  			pr_warn("ad_select param only affects 802.3ad mode\n");
fd989c83325cb3 Jay Vosburgh         2008-11-04  4573  	} else {
fd989c83325cb3 Jay Vosburgh         2008-11-04  4574  		params->ad_select = BOND_AD_STABLE;
fd989c83325cb3 Jay Vosburgh         2008-11-04  4575  	}
fd989c83325cb3 Jay Vosburgh         2008-11-04  4576  
f584130616dfae Nicolas de Pesloüan  2009-08-28  4577  	if (max_bonds < 0) {
91565ebbcc5aea Joe Perches          2014-02-15  4578  		pr_warn("Warning: max_bonds (%d) not in range %d-%d, so it was reset to BOND_DEFAULT_MAX_BONDS (%d)\n",
b8a9787eddb0e4 Jay Vosburgh         2008-06-13  4579  			max_bonds, 0, INT_MAX, BOND_DEFAULT_MAX_BONDS);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4580  		max_bonds = BOND_DEFAULT_MAX_BONDS;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4581  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4582  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4583  	if (miimon < 0) {
91565ebbcc5aea Joe Perches          2014-02-15  4584  		pr_warn("Warning: miimon module parameter (%d), not in range 0-%d, so it was reset to 0\n",
b98d9c66e1c382 Nikolay Aleksandrov  2014-01-22  4585  			miimon, INT_MAX);
b98d9c66e1c382 Nikolay Aleksandrov  2014-01-22  4586  		miimon = 0;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4587  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4588  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4589  	if (updelay < 0) {
91565ebbcc5aea Joe Perches          2014-02-15  4590  		pr_warn("Warning: updelay module parameter (%d), not in range 0-%d, so it was reset to 0\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  4591  			updelay, INT_MAX);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4592  		updelay = 0;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4593  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4594  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4595  	if (downdelay < 0) {
91565ebbcc5aea Joe Perches          2014-02-15  4596  		pr_warn("Warning: downdelay module parameter (%d), not in range 0-%d, so it was reset to 0\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  4597  			downdelay, INT_MAX);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4598  		downdelay = 0;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4599  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4600  
b3c898e20b1881 Debabrata Banerjee   2018-05-16  4601  	if ((use_carrier != 0) && (use_carrier != 1)) {
b3c898e20b1881 Debabrata Banerjee   2018-05-16  4602  		pr_warn("Warning: use_carrier module parameter (%d), not of valid value (0/1), so it was set to 1\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  4603  			use_carrier);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4604  		use_carrier = 1;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4605  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4606  
ad246c992bea6d Ben Hutchings        2011-04-26  4607  	if (num_peer_notif < 0 || num_peer_notif > 255) {
91565ebbcc5aea Joe Perches          2014-02-15  4608  		pr_warn("Warning: num_grat_arp/num_unsol_na (%d) not in range 0-255 so it was reset to 1\n",
ad246c992bea6d Ben Hutchings        2011-04-26  4609  			num_peer_notif);
ad246c992bea6d Ben Hutchings        2011-04-26  4610  		num_peer_notif = 1;
ad246c992bea6d Ben Hutchings        2011-04-26  4611  	}
ad246c992bea6d Ben Hutchings        2011-04-26  4612  
834db4bcdf937b dingtianhong         2013-12-21  4613  	/* reset values for 802.3ad/TLB/ALB */
267bed777a5f8a Veaceslav Falico     2014-05-15  4614  	if (!bond_mode_uses_arp(bond_mode)) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  4615  		if (!miimon) {
91565ebbcc5aea Joe Perches          2014-02-15  4616  			pr_warn("Warning: miimon must be specified, otherwise bonding will not detect link failure, speed and duplex which are essential for 802.3ad operation\n");
91565ebbcc5aea Joe Perches          2014-02-15  4617  			pr_warn("Forcing miimon to 100msec\n");
fe9d04afe9bee0 dingtianhong         2013-11-22  4618  			miimon = BOND_DEFAULT_MIIMON;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4619  		}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4620  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4621  
bb1d912323d5dd Andy Gospodarek      2010-06-02  4622  	if (tx_queues < 1 || tx_queues > 255) {
91565ebbcc5aea Joe Perches          2014-02-15  4623  		pr_warn("Warning: tx_queues (%d) should be between 1 and 255, resetting to %d\n",
bb1d912323d5dd Andy Gospodarek      2010-06-02  4624  			tx_queues, BOND_DEFAULT_TX_QUEUES);
bb1d912323d5dd Andy Gospodarek      2010-06-02  4625  		tx_queues = BOND_DEFAULT_TX_QUEUES;
bb1d912323d5dd Andy Gospodarek      2010-06-02  4626  	}
bb1d912323d5dd Andy Gospodarek      2010-06-02  4627  
ebd8e4977a87cb Andy Gospodarek      2010-06-02  4628  	if ((all_slaves_active != 0) && (all_slaves_active != 1)) {
91565ebbcc5aea Joe Perches          2014-02-15  4629  		pr_warn("Warning: all_slaves_active module parameter (%d), not of valid value (0/1), so it was set to 0\n",
91565ebbcc5aea Joe Perches          2014-02-15  4630  			all_slaves_active);
ebd8e4977a87cb Andy Gospodarek      2010-06-02  4631  		all_slaves_active = 0;
ebd8e4977a87cb Andy Gospodarek      2010-06-02  4632  	}
ebd8e4977a87cb Andy Gospodarek      2010-06-02  4633  
c2952c314b4fe6 Flavio Leitner       2010-10-05  4634  	if (resend_igmp < 0 || resend_igmp > 255) {
91565ebbcc5aea Joe Perches          2014-02-15  4635  		pr_warn("Warning: resend_igmp (%d) should be between 0 and 255, resetting to %d\n",
c2952c314b4fe6 Flavio Leitner       2010-10-05  4636  			resend_igmp, BOND_DEFAULT_RESEND_IGMP);
c2952c314b4fe6 Flavio Leitner       2010-10-05  4637  		resend_igmp = BOND_DEFAULT_RESEND_IGMP;
c2952c314b4fe6 Flavio Leitner       2010-10-05  4638  	}
c2952c314b4fe6 Flavio Leitner       2010-10-05  4639  
aa59d8517d1017 Nikolay Aleksandrov  2014-01-22  4640  	bond_opt_initval(&newval, packets_per_slave);
aa59d8517d1017 Nikolay Aleksandrov  2014-01-22  4641  	if (!bond_opt_parse(bond_opt_get(BOND_OPT_PACKETS_PER_SLAVE), &newval)) {
73958329ea1fe0 Nikolay Aleksandrov  2013-11-05  4642  		pr_warn("Warning: packets_per_slave (%d) should be between 0 and %u resetting to 1\n",
73958329ea1fe0 Nikolay Aleksandrov  2013-11-05  4643  			packets_per_slave, USHRT_MAX);
73958329ea1fe0 Nikolay Aleksandrov  2013-11-05  4644  		packets_per_slave = 1;
73958329ea1fe0 Nikolay Aleksandrov  2013-11-05  4645  	}
73958329ea1fe0 Nikolay Aleksandrov  2013-11-05  4646  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4647  	if (bond_mode == BOND_MODE_ALB) {
a4aee5c808fc5b Joe Perches          2009-12-13  4648  		pr_notice("In ALB mode you might experience client disconnections upon reconnection of a link if the bonding module updelay parameter (%d msec) is incompatible with the forwarding delay time of the switch\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  4649  			  updelay);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4650  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4651  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4652  	if (!miimon) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  4653  		if (updelay || downdelay) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  4654  			/* just warn the user the up/down delay will have
^1da177e4c3f41 Linus Torvalds       2005-04-16  4655  			 * no effect since miimon is zero...
^1da177e4c3f41 Linus Torvalds       2005-04-16  4656  			 */
91565ebbcc5aea Joe Perches          2014-02-15  4657  			pr_warn("Warning: miimon module parameter not set and updelay (%d) or downdelay (%d) module parameter is set; updelay and downdelay have no effect unless miimon is set\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  4658  				updelay, downdelay);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4659  		}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4660  	} else {
^1da177e4c3f41 Linus Torvalds       2005-04-16  4661  		/* don't allow arp monitoring */
^1da177e4c3f41 Linus Torvalds       2005-04-16  4662  		if (arp_interval) {
91565ebbcc5aea Joe Perches          2014-02-15  4663  			pr_warn("Warning: miimon (%d) and arp_interval (%d) can't be used simultaneously, disabling ARP monitoring\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  4664  				miimon, arp_interval);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4665  			arp_interval = 0;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4666  		}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4667  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4668  		if ((updelay % miimon) != 0) {
91565ebbcc5aea Joe Perches          2014-02-15  4669  			pr_warn("Warning: updelay (%d) is not a multiple of miimon (%d), updelay rounded to %d ms\n",
91565ebbcc5aea Joe Perches          2014-02-15  4670  				updelay, miimon, (updelay / miimon) * miimon);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4671  		}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4672  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4673  		updelay /= miimon;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4674  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4675  		if ((downdelay % miimon) != 0) {
91565ebbcc5aea Joe Perches          2014-02-15  4676  			pr_warn("Warning: downdelay (%d) is not a multiple of miimon (%d), downdelay rounded to %d ms\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  4677  				downdelay, miimon,
^1da177e4c3f41 Linus Torvalds       2005-04-16  4678  				(downdelay / miimon) * miimon);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4679  		}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4680  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4681  		downdelay /= miimon;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4682  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4683  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4684  	if (arp_interval < 0) {
91565ebbcc5aea Joe Perches          2014-02-15  4685  		pr_warn("Warning: arp_interval module parameter (%d), not in range 0-%d, so it was reset to 0\n",
7bdb04ed0dbf9f Nikolay Aleksandrov  2014-01-22  4686  			arp_interval, INT_MAX);
7bdb04ed0dbf9f Nikolay Aleksandrov  2014-01-22  4687  		arp_interval = 0;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4688  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4689  
5a5c5fd48e3bcd nikolay@redhat.com   2013-05-18  4690  	for (arp_ip_count = 0, i = 0;
5a5c5fd48e3bcd nikolay@redhat.com   2013-05-18  4691  	     (arp_ip_count < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
89015c18ff34a3 dingtianhong         2013-12-04  4692  		__be32 ip;
547942cace50e5 Nikolay Aleksandrov  2014-09-15  4693  
547942cace50e5 Nikolay Aleksandrov  2014-09-15  4694  		/* not a complete check, but good enough to catch mistakes */
89015c18ff34a3 dingtianhong         2013-12-04  4695  		if (!in4_pton(arp_ip_target[i], -1, (u8 *)&ip, -1, NULL) ||
2807a9feb23936 Veaceslav Falico     2014-05-15  4696  		    !bond_is_ip_target_ok(ip)) {
91565ebbcc5aea Joe Perches          2014-02-15  4697  			pr_warn("Warning: bad arp_ip_target module parameter (%s), ARP monitoring will not be performed\n",
5a5c5fd48e3bcd nikolay@redhat.com   2013-05-18  4698  				arp_ip_target[i]);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4699  			arp_interval = 0;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4700  		} else {
0afee4e8b9fe4b Veaceslav Falico     2013-06-24  4701  			if (bond_get_targets_ip(arp_target, ip) == -1)
5a5c5fd48e3bcd nikolay@redhat.com   2013-05-18  4702  				arp_target[arp_ip_count++] = ip;
0afee4e8b9fe4b Veaceslav Falico     2013-06-24  4703  			else
91565ebbcc5aea Joe Perches          2014-02-15  4704  				pr_warn("Warning: duplicate address %pI4 in arp_ip_target, skipping\n",
0afee4e8b9fe4b Veaceslav Falico     2013-06-24  4705  					&ip);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4706  		}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4707  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4708  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4709  	if (arp_interval && !arp_ip_count) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  4710  		/* don't allow arping if no arp_ip_target given... */
91565ebbcc5aea Joe Perches          2014-02-15  4711  		pr_warn("Warning: arp_interval module parameter (%d) specified without providing an arp_ip_target parameter, arp_interval was reset to 0\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  4712  			arp_interval);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4713  		arp_interval = 0;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4714  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4715  
f5b2b966f032f2 Jay Vosburgh         2006-09-22  4716  	if (arp_validate) {
f5b2b966f032f2 Jay Vosburgh         2006-09-22  4717  		if (!arp_interval) {
a4aee5c808fc5b Joe Perches          2009-12-13  4718  			pr_err("arp_validate requires arp_interval\n");
f5b2b966f032f2 Jay Vosburgh         2006-09-22  4719  			return -EINVAL;
f5b2b966f032f2 Jay Vosburgh         2006-09-22  4720  		}
f5b2b966f032f2 Jay Vosburgh         2006-09-22  4721  
162288810c9ebd Nikolay Aleksandrov  2014-01-22  4722  		bond_opt_initstr(&newval, arp_validate);
162288810c9ebd Nikolay Aleksandrov  2014-01-22  4723  		valptr = bond_opt_parse(bond_opt_get(BOND_OPT_ARP_VALIDATE),
162288810c9ebd Nikolay Aleksandrov  2014-01-22  4724  					&newval);
162288810c9ebd Nikolay Aleksandrov  2014-01-22  4725  		if (!valptr) {
a4aee5c808fc5b Joe Perches          2009-12-13  4726  			pr_err("Error: invalid arp_validate \"%s\"\n",
162288810c9ebd Nikolay Aleksandrov  2014-01-22  4727  			       arp_validate);
f5b2b966f032f2 Jay Vosburgh         2006-09-22  4728  			return -EINVAL;
f5b2b966f032f2 Jay Vosburgh         2006-09-22  4729  		}
162288810c9ebd Nikolay Aleksandrov  2014-01-22  4730  		arp_validate_value = valptr->value;
162288810c9ebd Nikolay Aleksandrov  2014-01-22  4731  	} else {
f5b2b966f032f2 Jay Vosburgh         2006-09-22  4732  		arp_validate_value = 0;
162288810c9ebd Nikolay Aleksandrov  2014-01-22  4733  	}
f5b2b966f032f2 Jay Vosburgh         2006-09-22  4734  
8599b52e14a161 Veaceslav Falico     2013-06-24  4735  	if (arp_all_targets) {
edf36b24c58dbb Nikolay Aleksandrov  2014-01-22  4736  		bond_opt_initstr(&newval, arp_all_targets);
edf36b24c58dbb Nikolay Aleksandrov  2014-01-22  4737  		valptr = bond_opt_parse(bond_opt_get(BOND_OPT_ARP_ALL_TARGETS),
edf36b24c58dbb Nikolay Aleksandrov  2014-01-22  4738  					&newval);
edf36b24c58dbb Nikolay Aleksandrov  2014-01-22  4739  		if (!valptr) {
8599b52e14a161 Veaceslav Falico     2013-06-24  4740  			pr_err("Error: invalid arp_all_targets_value \"%s\"\n",
8599b52e14a161 Veaceslav Falico     2013-06-24  4741  			       arp_all_targets);
8599b52e14a161 Veaceslav Falico     2013-06-24  4742  			arp_all_targets_value = 0;
edf36b24c58dbb Nikolay Aleksandrov  2014-01-22  4743  		} else {
edf36b24c58dbb Nikolay Aleksandrov  2014-01-22  4744  			arp_all_targets_value = valptr->value;
8599b52e14a161 Veaceslav Falico     2013-06-24  4745  		}
8599b52e14a161 Veaceslav Falico     2013-06-24  4746  	}
8599b52e14a161 Veaceslav Falico     2013-06-24  4747  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4748  	if (miimon) {
a4aee5c808fc5b Joe Perches          2009-12-13  4749  		pr_info("MII link monitoring set to %d ms\n", miimon);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4750  	} else if (arp_interval) {
162288810c9ebd Nikolay Aleksandrov  2014-01-22  4751  		valptr = bond_opt_get_val(BOND_OPT_ARP_VALIDATE,
162288810c9ebd Nikolay Aleksandrov  2014-01-22  4752  					  arp_validate_value);
a4aee5c808fc5b Joe Perches          2009-12-13  4753  		pr_info("ARP monitoring set to %d ms, validate %s, with %d target(s):",
162288810c9ebd Nikolay Aleksandrov  2014-01-22  4754  			arp_interval, valptr->string, arp_ip_count);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4755  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4756  		for (i = 0; i < arp_ip_count; i++)
90194264ceffdf Joe Perches          2014-02-15  4757  			pr_cont(" %s", arp_ip_target[i]);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4758  
90194264ceffdf Joe Perches          2014-02-15  4759  		pr_cont("\n");
^1da177e4c3f41 Linus Torvalds       2005-04-16  4760  
b8a9787eddb0e4 Jay Vosburgh         2008-06-13  4761  	} else if (max_bonds) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  4762  		/* miimon and arp_interval not set, we need one so things
^1da177e4c3f41 Linus Torvalds       2005-04-16  4763  		 * work as expected, see bonding.txt for details
^1da177e4c3f41 Linus Torvalds       2005-04-16  4764  		 */
90194264ceffdf Joe Perches          2014-02-15  4765  		pr_debug("Warning: either miimon or arp_interval and arp_ip_target module parameters must be specified, otherwise bonding will not detect link failures! see bonding.txt for details\n");
^1da177e4c3f41 Linus Torvalds       2005-04-16  4766  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4767  
ec0865a94991d1 Veaceslav Falico     2014-05-15  4768  	if (primary && !bond_mode_uses_primary(bond_mode)) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  4769  		/* currently, using a primary only makes sense
^1da177e4c3f41 Linus Torvalds       2005-04-16  4770  		 * in active backup, TLB or ALB modes
^1da177e4c3f41 Linus Torvalds       2005-04-16  4771  		 */
91565ebbcc5aea Joe Perches          2014-02-15  4772  		pr_warn("Warning: %s primary device specified but has no effect in %s mode\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  4773  			primary, bond_mode_name(bond_mode));
^1da177e4c3f41 Linus Torvalds       2005-04-16  4774  		primary = NULL;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4775  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4776  
a549952ad323d6 Jiri Pirko           2009-09-25  4777  	if (primary && primary_reselect) {
388d3a6d4aa356 Nikolay Aleksandrov  2014-01-22  4778  		bond_opt_initstr(&newval, primary_reselect);
388d3a6d4aa356 Nikolay Aleksandrov  2014-01-22  4779  		valptr = bond_opt_parse(bond_opt_get(BOND_OPT_PRIMARY_RESELECT),
388d3a6d4aa356 Nikolay Aleksandrov  2014-01-22  4780  					&newval);
388d3a6d4aa356 Nikolay Aleksandrov  2014-01-22  4781  		if (!valptr) {
a4aee5c808fc5b Joe Perches          2009-12-13  4782  			pr_err("Error: Invalid primary_reselect \"%s\"\n",
388d3a6d4aa356 Nikolay Aleksandrov  2014-01-22  4783  			       primary_reselect);
a549952ad323d6 Jiri Pirko           2009-09-25  4784  			return -EINVAL;
a549952ad323d6 Jiri Pirko           2009-09-25  4785  		}
388d3a6d4aa356 Nikolay Aleksandrov  2014-01-22  4786  		primary_reselect_value = valptr->value;
a549952ad323d6 Jiri Pirko           2009-09-25  4787  	} else {
a549952ad323d6 Jiri Pirko           2009-09-25  4788  		primary_reselect_value = BOND_PRI_RESELECT_ALWAYS;
a549952ad323d6 Jiri Pirko           2009-09-25  4789  	}
a549952ad323d6 Jiri Pirko           2009-09-25  4790  
3915c1e8634a32 Jay Vosburgh         2008-05-17  4791  	if (fail_over_mac) {
1df6b6aa334c99 Nikolay Aleksandrov  2014-01-22  4792  		bond_opt_initstr(&newval, fail_over_mac);
1df6b6aa334c99 Nikolay Aleksandrov  2014-01-22  4793  		valptr = bond_opt_parse(bond_opt_get(BOND_OPT_FAIL_OVER_MAC),
1df6b6aa334c99 Nikolay Aleksandrov  2014-01-22  4794  					&newval);
1df6b6aa334c99 Nikolay Aleksandrov  2014-01-22  4795  		if (!valptr) {
a4aee5c808fc5b Joe Perches          2009-12-13  4796  			pr_err("Error: invalid fail_over_mac \"%s\"\n",
1df6b6aa334c99 Nikolay Aleksandrov  2014-01-22  4797  			       fail_over_mac);
3915c1e8634a32 Jay Vosburgh         2008-05-17  4798  			return -EINVAL;
3915c1e8634a32 Jay Vosburgh         2008-05-17  4799  		}
1df6b6aa334c99 Nikolay Aleksandrov  2014-01-22  4800  		fail_over_mac_value = valptr->value;
3915c1e8634a32 Jay Vosburgh         2008-05-17  4801  		if (bond_mode != BOND_MODE_ACTIVEBACKUP)
91565ebbcc5aea Joe Perches          2014-02-15  4802  			pr_warn("Warning: fail_over_mac only affects active-backup mode\n");
3915c1e8634a32 Jay Vosburgh         2008-05-17  4803  	} else {
3915c1e8634a32 Jay Vosburgh         2008-05-17  4804  		fail_over_mac_value = BOND_FOM_NONE;
3915c1e8634a32 Jay Vosburgh         2008-05-17  4805  	}
dd957c57c52a39 Jay Vosburgh         2007-10-09  4806  
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4807  	bond_opt_initstr(&newval, "default");
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4808  	valptr = bond_opt_parse(
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4809  			bond_opt_get(BOND_OPT_AD_ACTOR_SYS_PRIO),
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4810  				     &newval);
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4811  	if (!valptr) {
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4812  		pr_err("Error: No ad_actor_sys_prio default value");
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4813  		return -EINVAL;
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4814  	}
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4815  	ad_actor_sys_prio = valptr->value;
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4816  
d22a5fc0c32edc Mahesh Bandewar      2015-05-09  4817  	valptr = bond_opt_parse(bond_opt_get(BOND_OPT_AD_USER_PORT_KEY),
d22a5fc0c32edc Mahesh Bandewar      2015-05-09  4818  				&newval);
d22a5fc0c32edc Mahesh Bandewar      2015-05-09  4819  	if (!valptr) {
d22a5fc0c32edc Mahesh Bandewar      2015-05-09  4820  		pr_err("Error: No ad_user_port_key default value");
d22a5fc0c32edc Mahesh Bandewar      2015-05-09  4821  		return -EINVAL;
d22a5fc0c32edc Mahesh Bandewar      2015-05-09  4822  	}
d22a5fc0c32edc Mahesh Bandewar      2015-05-09  4823  	ad_user_port_key = valptr->value;
d22a5fc0c32edc Mahesh Bandewar      2015-05-09  4824  
8b426dc54cf405 Mahesh Bandewar      2017-03-08  4825  	bond_opt_initstr(&newval, "default");
f13ad104b4e886 Nikolay Aleksandrov  2017-09-12  4826  	valptr = bond_opt_parse(bond_opt_get(BOND_OPT_TLB_DYNAMIC_LB), &newval);
8b426dc54cf405 Mahesh Bandewar      2017-03-08  4827  	if (!valptr) {
8b426dc54cf405 Mahesh Bandewar      2017-03-08  4828  		pr_err("Error: No tlb_dynamic_lb default value");
8b426dc54cf405 Mahesh Bandewar      2017-03-08  4829  		return -EINVAL;
8b426dc54cf405 Mahesh Bandewar      2017-03-08  4830  	}
8b426dc54cf405 Mahesh Bandewar      2017-03-08  4831  	tlb_dynamic_lb = valptr->value;
8b426dc54cf405 Mahesh Bandewar      2017-03-08  4832  
3a7129e52766f0 dingtianhong         2013-12-21  4833  	if (lp_interval == 0) {
91565ebbcc5aea Joe Perches          2014-02-15  4834  		pr_warn("Warning: ip_interval must be between 1 and %d, so it was reset to %d\n",
3a7129e52766f0 dingtianhong         2013-12-21  4835  			INT_MAX, BOND_ALB_DEFAULT_LP_INTERVAL);
3a7129e52766f0 dingtianhong         2013-12-21  4836  		lp_interval = BOND_ALB_DEFAULT_LP_INTERVAL;
3a7129e52766f0 dingtianhong         2013-12-21  4837  	}
3a7129e52766f0 dingtianhong         2013-12-21  4838  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4839  	/* fill params struct with the proper values */
^1da177e4c3f41 Linus Torvalds       2005-04-16  4840  	params->mode = bond_mode;
169a3e66637c66 Jay Vosburgh         2005-06-26  4841  	params->xmit_policy = xmit_hashtype;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4842  	params->miimon = miimon;
ad246c992bea6d Ben Hutchings        2011-04-26  4843  	params->num_peer_notif = num_peer_notif;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4844  	params->arp_interval = arp_interval;
f5b2b966f032f2 Jay Vosburgh         2006-09-22  4845  	params->arp_validate = arp_validate_value;
8599b52e14a161 Veaceslav Falico     2013-06-24  4846  	params->arp_all_targets = arp_all_targets_value;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4847  	params->updelay = updelay;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4848  	params->downdelay = downdelay;
07a4ddec3ce9b0 Vincent Bernat       2019-07-02  4849  	params->peer_notif_delay = 0;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4850  	params->use_carrier = use_carrier;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4851  	params->lacp_fast = lacp_fast;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4852  	params->primary[0] = 0;
a549952ad323d6 Jiri Pirko           2009-09-25  4853  	params->primary_reselect = primary_reselect_value;
3915c1e8634a32 Jay Vosburgh         2008-05-17  4854  	params->fail_over_mac = fail_over_mac_value;
bb1d912323d5dd Andy Gospodarek      2010-06-02  4855  	params->tx_queues = tx_queues;
ebd8e4977a87cb Andy Gospodarek      2010-06-02  4856  	params->all_slaves_active = all_slaves_active;
c2952c314b4fe6 Flavio Leitner       2010-10-05  4857  	params->resend_igmp = resend_igmp;
655f8919d549ad stephen hemminger    2011-06-22  4858  	params->min_links = min_links;
3a7129e52766f0 dingtianhong         2013-12-21  4859  	params->lp_interval = lp_interval;
73958329ea1fe0 Nikolay Aleksandrov  2013-11-05  4860  	params->packets_per_slave = packets_per_slave;
8b426dc54cf405 Mahesh Bandewar      2017-03-08  4861  	params->tlb_dynamic_lb = tlb_dynamic_lb;
6791e4661c4bd3 Mahesh Bandewar      2015-05-09  4862  	params->ad_actor_sys_prio = ad_actor_sys_prio;
74514957552edd Mahesh Bandewar      2015-05-09  4863  	eth_zero_addr(params->ad_actor_system);
d22a5fc0c32edc Mahesh Bandewar      2015-05-09  4864  	params->ad_user_port_key = ad_user_port_key;
809fa972fd90ff Hannes Frederic Sowa 2014-01-22  4865  	if (packets_per_slave > 0) {
809fa972fd90ff Hannes Frederic Sowa 2014-01-22  4866  		params->reciprocal_packets_per_slave =
809fa972fd90ff Hannes Frederic Sowa 2014-01-22  4867  			reciprocal_value(packets_per_slave);
809fa972fd90ff Hannes Frederic Sowa 2014-01-22  4868  	} else {
809fa972fd90ff Hannes Frederic Sowa 2014-01-22  4869  		/* reciprocal_packets_per_slave is unused if
809fa972fd90ff Hannes Frederic Sowa 2014-01-22  4870  		 * packets_per_slave is 0 or 1, just initialize it
809fa972fd90ff Hannes Frederic Sowa 2014-01-22  4871  		 */
809fa972fd90ff Hannes Frederic Sowa 2014-01-22  4872  		params->reciprocal_packets_per_slave =
809fa972fd90ff Hannes Frederic Sowa 2014-01-22  4873  			(struct reciprocal_value) { 0 };
809fa972fd90ff Hannes Frederic Sowa 2014-01-22  4874  	}
809fa972fd90ff Hannes Frederic Sowa 2014-01-22  4875  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4876  	if (primary) {
^1da177e4c3f41 Linus Torvalds       2005-04-16 @4877  		strncpy(params->primary, primary, IFNAMSIZ);
^1da177e4c3f41 Linus Torvalds       2005-04-16  4878  		params->primary[IFNAMSIZ - 1] = 0;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4879  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  4880  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4881  	memcpy(params->arp_targets, arp_target, sizeof(arp_target));
^1da177e4c3f41 Linus Torvalds       2005-04-16  4882  
^1da177e4c3f41 Linus Torvalds       2005-04-16  4883  	return 0;
^1da177e4c3f41 Linus Torvalds       2005-04-16  4884  }
^1da177e4c3f41 Linus Torvalds       2005-04-16  4885  

:::::: The code at line 4877 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--r5Pyd7+fXNt84Ff3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICCe2KWAAAy5jb25maWcAjDzbctw2su/5iqnkZfchiW5Woj2lBwwJzsBDEjQAzkUvLFke
O6rIkksa5azP159ugBcAbI68teWI3Q2g0Wj0DcD88tMvM/Z6ePp6e7i/u314+D77sn/cP98e
9p9mn+8f9v8zS+WslGbGU2F+A+L8/vH1v7+/nF+dzN799sdvJ78+313MVvvnx/3DLHl6/Hz/
5RVa3z89/vTLT/D/XwD49Rt09PyfGTb69QHb//rl7m72r0WS/Ht29dv5bydAmMgyE4smSRqh
G8Bcf+9A8NGsudJCltdXJ+cnJx0iT3v42fnFif1f30/OykWPPvG6XzLdMF00C2nkMIiHEGUu
Sj5CbZgqm4Lt5rypS1EKI1gubnjqEcpSG1UnRio9QIX60GykWg2QeS3y1IiCN4bNc95oqcyA
NUvFWQpcZBL+ARKNTa0oF3ZpHmYv+8Prt0FmyEzDy3XDFAhFFMJcn5+h5Du2ikrAMIZrM7t/
mT0+HbCHXooyYXknqJ9/Htr5iIbVRhKN7VQazXKDTVvgkq15s+Kq5HmzuBHVMDcfMwfMGY3K
bwpGY7Y3Uy3kFOKCRtQlykVxre0S9rP2+PbnG+Mt98cIcA7H8Nub460paQdzipv4EyLapjxj
dW6apdSmZAW//vlfj0+P+3/3q6Z3ei0qb99VUottU3yoee3vBiW1bgpeSLVrmDEsWfrM1Jrn
Yk6Mz2owINFSMJUsHQIGB2XLB3wEteoPO2n28vrx5fvLYf91UP8FL7kSid1oonzPE4Oa/J1C
J0tfGxGSyoKJMoRpUVBEzVJwhSzvxp0XWiDlJGI0jq6Y0pxuY+n5vF5k2op2//hp9vQ5mn7c
yNqT9UiOHTqB3bzia14a3YnT3H/dP79QEl3eNBW0kqlI/LUtJWJEmnNSdS2axCzFYtmAZlom
lQ5p2tmNuBmag1LzojIwQEmP3BGsZV6XhqkdoX8tjafebaNEQpsR2KmQc2BV/bu5ffl7dgAW
Z7fA7svh9vAyu727e3p9PNw/fhkktxYKeqzqhiW2X1Euhq4JZFMyI9bcl7JOljwFL8BVwfLG
buha0fOe6xQIZAIk2KchidCBaMOMpoSihT80fPZ2IhUanVNKLtYPiMTzPzBjoWXOUKh+d1a6
KqlneqyCBpahAdx4vQIgfDR8C8rqraAOKGxHEQglMu4HhJTn6C0L33wgpuSwIpovknkutAlx
GStlba4vL8bAJucsu/Y8MaLmUpJu2I4jkzmKy9/1oXxCvzsX5VmwQ8XK/UH0L1ZLCCu46re/
vvtr/+kVArPZ5/3t4fV5/2LB7bAEtjfNaLV1XVUQtuimrAvWzBmEW0mg7G3UJEpzevanB14o
WVdeeFSxBXd7kKsBCv4lWUSfzQr+E/fktssAzZhQTYgZFDHTwGmZbkRqltQSmIbssx2pEqke
AVVqQ5VhDAfOQOtuuCI3JCyw5uR2bBunfC0STvQKLeNtHhLMq4xoZn0J0UiDS+hpmAnmgSEC
+CgwLdRoS56sKglri1Ydwl3CgGHAaLsmZQB+ChYj5bCpE2bIgEXxnHmedp6vUDA22FXe4thv
VkBvWtYKxDbEoSqNwk8AdFHnsCfT6VANcBNhmm1FhWgW4YWcsN3RxeDfwd6Q4GIKSB+aTCp0
tvCfArZQuOoRmYY/qGUEn29yMIMJt34LTB5LvIjNKUX7ERvLAmy9AH1UwQouuCnASDZtOHFk
CQmKbicuYavlHh8unnQhQOB1FCjSinZwod4OcAaxU1ZPcJbVhm9JDK/k1GzEomR5ltIuFHnO
KCW1EVUWWBm9BDNFBcDCS1GEbGoV2EuWrgVMqpWnDmzfnCklfPO4QpJdoceQJoj+eqgVGO6o
NtoYVKMZh95o3zcMNncXCyDZexu9+3G+ssgJkUFw+4GSVzHnaeobV5sI4AZo+ui004vk9OSi
81ZthaHaP39+ev56+3i3n/F/9o8QczBwWAlGHRA+unitbT70ScYwP9jj0OG6cN113krT1h2S
MAYiUytqq+ZsHuhKXs9pdcwllURhe1AIBS6zXRsv7EEc+h2MURoFm0963lIv6yzLuXO3sNyQ
24Pd9qMrmYk80EhrRqyVD9KQsAjRa2nhRVM3EKg3qZ/DYww4x/UvU8G86AqzEvACXTjh8QuJ
5cpyMMZ1Oc1ywyGxIBBgNnplb+wMuF+RCQMY6x2tXKxYohTUEg8wyHGExHZNwarAiCWi+VAL
taL8ZThgDbKec48ffX514n1Z9ykLGDsDx9ZPwFurhasb5aCOYCneBVsphzmDAlqm7Xaonp/u
9i8vT8+zw/dvLlj3Aj6/aWH5vLk6OWkyzgxkHTrapx3F1ZsUzenJ1Rs0p291cnp1+QYFT07P
3urk/C2Ci7cI3vkE/YoP0iJ38CCqo2iU0zGC06PNQULH0Cieo83Pj2IvCFXuZeI5qEEpTF0G
EQx+d5aK9qxIEMswxNm9ETeYFJvDT0itRU4IzWEnZdY2pkXWIi+OId8Rc7y8mId+1bkPyvQX
XiBbKptFeFnnUpoqrxdt9tiR1b4NLmXKIWBbisxcn4bWRhcmNkBFEkMglF3FsFSxjW+a2uIF
mMhcLrzofXkDKxYsJEDO3tHLBKjziV3l+qG0ZXlzfTqU/1d8y70J2M8GHByPvACmqA5Z1WqB
LnHnM2lpnCs9Vq0t5ZxOcyDalniYQKc36IPRkAfpiB0MI34M2cjA5ZhBtxa/2H99ev4enxI4
J2TLjhBSgiduh6bRo/DC4l2jrvrb6txbNAr+WscjtVS6ysHPVUXaVAZjAS+Rl5DMgW3Z2mhC
qhTU7GowOdumWu40cgobSF9fXHquGCIHFz/QARomr2N8i7WnPOkO0l+IIyyRH/sEknU16d8l
VUH9kPrRPgYHsGWzurS1aXDZp2eDp9EQUoSVjaVOcCf52wrmWQfuh7O0QCJyjusMEowk2ZD6
E7JsZ5G+fv0GsG/fnp4P3lmcYnrZpHVR+TIIaIeMdtPFG+v758Pr7cP9/3WngEOEaXgCub6t
g9Z4eGYrgs2i5n5RrYoULymKwEAWRSPqZE2HzRBJNctdBYlpRgVi7gBoHXQYcjPdrWWTFGg0
Y1dd2z98PuxfDl6MZXupy40osZiYZ8ZNeyi59U2Cw77b57u/7g/7O9zgv37afwNqyFJmT99w
sJd4tRJXjAnsXgiTLtT3IFYqY/B7WPgGkgru5YZYSIaNseI77c/B74hnmUgE5kk1ZNSQVmMx
KMEadWQCIIW0dUwjymauN2x0ThjHyQ6quKERDtqARmVRBcTiy0JEEMuFJV0Grs0iIX3Buo0R
i1rW3lhdjgH+2B6FtOe1hF8BC2ZEtuvqUmMCzU1rJonkW/dWyNhKjD1Yjiegi6aQaXtGGwtE
8YVuGCobmrF2DRpWxWLAVJ3Kx7E9BcfUv+2ztQ0joVKqQ2GJkgQkkg044iWM4bIcTGlJNFbM
3yCBdM39NZK+U4hGs4yDSam2yXIRsdpC3TH4BC6V9diJ2tKJqCCksEd83dE6IQjNE4z3MDAJ
Ery2dm5l3JpNqezxV9TL0eOmQc9gArAJgQ4LWW93gTo+sVVKjBBwby/rBcecmZyWzPD8SJld
hAVd7eIMnohMeBEaoOocdi8aBbArVjGIqVhUFyLFiyKrXXd7wuTj3ZALF3L0lQVP4DlWLOaA
AP+fau9agsTrDWKha2C5TM9HCNadNscFoPMzCExs5XDKD9lJrQtWeXFG55N66FQ1wekHGCLT
BaFqs/Xt9CQqbu4k39L4lz9WfrlrsqyBPbl4MlE7e77qvFci179+vH3Zf5r97Qpt356fPt8/
BKelSNTySPBnsa1XasuaPXsxjuDOktiyumkumj+CEtYR5oIlwqtHGOKKUoej92AyIPhB192n
ArAIWLL2XZot2OoCp33qZeZul1B5ebt/7HFnDu6sDspTc1xPagl1eRqJ3l1/gi2Kl4/ULozK
pyia+fII0Rt9/FgH4V2JSRLNRrmGT1aXbzDjCI6z09IcZ2ggGs7ICFpnro7J2VL8AHqS54Fi
kuOAZFqEluyYCD2C4+y8JcKI6KgIN0oYflyGjuRH8JNseySTXIc003J0dMcE6VO8wdJbooyp
RrLE64xv7JC+eM2MxJhUFRvPd6Pxco0h+Jab0o9l1EaDd5hAWpYmcIOfcgdUMA9WVZbCehj+
3/3d6+H248PeXlSd2VMcP9+aizIrDIYMUacDwuYzniQAFCZLLalOlPDvDrXgQujg+gW2xZCY
dApT/Polm+L28fbL/iuZ3/W1Ga+ih/dS7AluBW7Q1vfiiMtVYfAWEfdvOXl1oC0WaDiFWsM/
GIjEpaIRxXhQ628sR80RPJZwCHzGtIF0u4qWbcV51bf1hIAXUDoc3pr1FHOiThXC2/n4CxkR
dOegspwo5rVlLFvCcpXZiyggTOLiQou053GK4+ZywfvAg1ioUUmia4WCY2kKOVJfQvayn1JC
4inCM/2Vpg6lu5nZdQbp2U6vL06uvHoaFfZTl0JyzsqEJcvwDsPE1YqbSkoqaruZ18Fp+o2N
gWRCdgLcc6Wwfm2zYydMvBBC3X9Ku9NPjP1XQaa0LCCPFkr5B6Lu7G1tUy+vOMUV5kr2Pl0Q
EeLlGwiBlwUjD357Y1YZ7rIfll+PC4vE/h/2ur99V3PcuLzs8n5rRMr94X+fnv+GKHZsPbAo
yoOTBgeBPI1Rd4PAJ3g5A35hEdJvb2ETrV36NWhQrttLTfT5CKCNpHRqmynP3OFXI7Msl369
xUJZvpARqL3U4oPsOWrGwls2FqPreYOl+oS6Omop3HbkcY8V7m7fImPStRsBxs2xhukZuKz9
HmqORUKxklb22hb3L0p4QLsg3iCB1ojKOYuE6RDK0jXePUobJWsTmg2B1Yk57BnBm6lbpF2/
6IRsQUZHPdhuWxpGXr3ridZczWVojAFXlRXRCGUrKhGJX1QLhYeORb2NEXgSF+SaPT3VxVyB
nrWy8pkpLKfkRawSjL1cCd8Nu/7WRoSgOqW5yWQ9Agyc63BpGxbcvbcgrilRCcdGqKwWaNU4
5sRiSOBYvxqTVBQYZ0iAFdt04JBxBMKygSmXO9pMwDjw56JXV8rwdDRJPffLS52f6/DXP9+9
fry/+9lvV6TvtH9LD1btMvxq9weGUxmFacLwwyLcDT6NVfOUpaEwLt0CBhBYPwI0NnsONVpS
HLIQVcy48Ktprunkwl8OUE/toRNQYnLrAkoLE40IkOYyuKiJ0DKFkNnGhWZX8Qg5YgaBwea0
kGCLdBC68VGzhEzWcyyY0De5XA9Tm92154vLJt+QY1scxAMJBQ/uZDoFqnKiJ1iOrow+BIYV
aCttDvGdGVaVMQoJzUhlKnwTp7XIghPurhFElLZYCTa+gHyMcupA2heq/fYOSO7K9gHg8x5j
E8h6Dvvn0SNBoisYH589HOPBSkaU4SxbVMYKke/Afot0wSmCti2kn4EZKjO0DaWND6mxM2ww
PBDw2yECeoUgh2441r8eaPcc/aCmJxl37REZTIEWnMoTEDm6W49AN3MfYJ8NBqCRLgJMzt8H
tg9hH2ppWAhSHJ9hhdM103dbEAnB8TLsBOKOuAe0WRPtXQAUzaBScrujNGDbL4jVwK3Ny19m
d09fP94/7j/Nvj7h4wcvfvabNu32Cpoebp+/7A8vtEJDG8PUglvB08tI0JZZRH2Edtj0R7sE
y1GEGyuYxNfbw91fR6Zt8L0eZIih8SaIXCztZzhHrUAQX+mJ7QCo9Zh1Uf3niHEZdhJEAIpZ
W3vhK0mrN2O40x0C3m7aCN7pPIFIITccQzGqbqHEhmeKtPAZ2Zm1PtBiBBsRhjz6kgWkqNzg
9KWRI2Ju1+Gfyx9biUHilxMSv5wwlIA5KpXLicnG/bWyoTqD0MmXhe+kLcKpNzZ2z6lCMVoS
txem+y5Yucj5qGcIjP39clyeY4UcebvMtLCm4KF9tvOP6VtawPL52Fu1WEBhWhRFRBSVmRZD
QFUyM+IBMX+enDXnJIYV0q/d+Bh/C3hwMQW+JOGRK/QwYVjlIaqVaU0iJQttqM3sEaxz/058
OCPFq3w30XFaMtpURjw3lNP1aBRPhYocts9/SXptX2SSXhHrwTxMFd90AMuTJkmckyKoSxLd
/TQAzJJEpC/T4WPbVYNkZ+M3byTdOWnrJkcbeGkfjyxv7/4OTrS7zu3w/namWnmNdGKC81r8
7pNWV1OwuQQmqfQVtakGeslOqVrFFH14y8SSReOP+PyB4eyyujGj3F+lVJxvgl8iwC+wYtC0
sTHhGFynVQS3txFkBAzrEcwUwQckSL6p6CD20UdSRBjYsjyEFJVkIWSuzi7/vKBgsObxVsjP
TBV+eT8C4EPX5xFAxO248e+OmpH5I/a5WBSghaWUcfI33EmBGaNZPqXedaU8CUqN7nuoJ3bc
5UnwEbzEZIblVN61PfMeG+SsCrKCaimj9KlFXOZyU7EgT2tBnVjJWXY05ZI+chCccxTCO/qq
v1PzZfxsvpNKQj3qSkuNz2gl/tZKsDKgLgxPZKicUla8XOuNMOHPb3hgrJwcb9ist4HjCRrz
kvun1+tR1XlNl5x7cA66NI/vNQllhOxpCPYiCirbbpP3iaOHosqj6itCmoWWIbT0082lViHW
SQFy7hCcn4M/1ZjpjFBlov0SL3w1koMBKdIGE6+gDqT8B/Aqsz/e4GfaWx/fPtC2RRxlb5UP
h2sDytV2qJKo3YdbvD6+w7TMG2b+wf/Ap6BGcVa4e4uRQMCRb/rIyD9tmuGV5cAHWg+uZNXA
wgl3eta7wVGjCOGfXfUCCHcxfGKsTN/tB9w8od9qIG6xIQSEiPenV+dX3cwAMEv3/9zf7Wfp
8/0/7l2pR7xO/F1jIVuCSZ1jR/R4Tn0C8oTlCT5mwHIxWX9Doizn29HoC0WM/p6VN+C2WHk+
0dVqzfAib5UIHj5gtsw007wnyR9/nIwaILARmj7tHSiqnBm8lDfRt8gE/jdLwxkWzWjSFtR3
R+EM/HOxfbcNcRVnq2HS/nK9Z/i0KATyQiMxBSwSwUJ49ufp5clpLJlBzpOi6XiaEEqVb8dM
tOyiyGmEJ5pQLWVmIgXrtV5XwAO+e/58e7ePtH4pzk9Pt3FvRVKdvTvdknE00WM/Uq3n4UhB
r3/iLz1YkgmJ4RJEeB+rU8SexcwuRo2olTpGUiRzdpTALuU0Z3W3Uz0RRaII+3Ovk93hOV2Z
IaxVH29mYPmVH0l3kKhaMoDt72eB79ZB+t/jp35KRG1XwRuIrFkl/utz2rFgDUzVUalhIwq2
pYbIVsL3Xu67yXmqR0BRVrUZQReViIKAqyDpcpA2BJnwpFd+btevk8io9ebVElxmEK52MDxC
NGY3Jc6eDK/DT8WHZUaHqJVmEPJQsZ89BM68qG584NRBwhOqVEOE0V7taUEQegCbeRxs2d+U
KfQihIL+hoc1GRO5jOYDWYuRMu8CvJGBmnLJ7mWKbx/jj/bX18JfHQEXgLeuIC6iLlgBlumq
CLqxEO9lZNCXxVVywxVe+6QXJiDDO5U/RDz8OMwEo01lQkbxV+dGAPJn6KxwWn32QNrU8xAS
3XdCkJBUYoIYiFPD1hWD2NQLt9t7dcE6ecAmmcToZRVcuQxw5+Fje/fzB+BW754eD89PD/hr
Vp9i7cGGmYF/o/fJCMffSuwefE0uUrPF383YEur6cv/lcXP7vLc82PMPHT+xtB2km1DNAGCH
HkN5NYahn6ehE51YFB/9ekUBJqYkPcyxmbjbq08fQar3D4jexzMd7rhNUzn/f/tpj7/CYtHD
kr2MH6bamST/z9nTNLmN4/pX+vRq9zBvLPlLPryDLMk2Y31Fom05F1Vvktp0bU+S6u6pnf33
C5CURVCgO/UOmWkD4IdIkARAAIzTrLSDeGwo9+kDajKIA4IZSRt1r057TIdz+d3PuQV08yx6
Y9/s+5efP0BCoEyblanKDEJX2gA1Oads45FCg5bnxp2SJm6Nvv776e3zN37pEL5pL0ZbllnC
ss/92sbeJbHtLuIK2Pp3j04wfSJs/RiK6dho0/ffPj++fHn4x8vTl3/aMuw1K+1rEPWzr4iM
qGGw2Cs+rFrjJS/IG2TVHsSW14LqdLUON8yeKaJwtgntb8WPQlOsjre1+9jEtUipeDKGCz99
NsfjQ3VzAB0dNnU41yHLa09mOjimZVF7LGPQlTKN84p1gAZxRlW+E01xiRsd2JsOc7J7evnj
37h9PP+ARfEyzsnuoiaUyIQDSDnrplARyV4mm/jWiJXqbSylolP1N9rDxhKAGJLnW97bYyww
pNW114z7RUMpkzbrfAsFsGTiHE0oPM4HVbJ/I872AN00ApKwRkNxaZsCvZt24ZYJFmM9T7JS
4dI8+nzK4Ue8hYNNEmfGJtsTd339uxdhMoG1uSi2p0lZjPZgYMUUWBS2tD60ZAe5DKWrE+Z0
tP3EBuq57QJYxHg70Wie2lH2QORO7eQqMtQf1TddYYrDt3++PnxR8ilZckXVSY83Q3EQvSN7
3lqya7N0hwoEc3RH54IdSzu8Hn/1wObCDlxWwEIeeUQrmh2POW27CaKQt7VdP768PeFIPPx8
fHl1zgeg6+NmjYofa+1FfFKkKvhI0ZAm+mp3g5IqYQ5VXsVJteOZM+mV6tYJ/gQ5RPn2qDRv
8uXx++uzut17yB//QyRD1YOqnrSOrQoMzMDgG2UNnmzGTVz83lTF77vnx1c49b49/ZwKnurb
d8Kt/UOWZolam57xgoXaO2vXVIVXBcrftConnUZ0WWGWBd80AMEW9u0rBihcaHKzAZ9b+DvV
7LOqyCTNpIM4XJLbuDz2KgFrz90TMmThO9XwFzEMYfRr7QUrOrAOeh5Ox10E3GgJT+6tAe3v
uEL7ulvZ93k36lJmOZyODE8UoLynXP/gQI/vzOJJinyy8GLOcKswVeESx1uMOWOX5531oRWK
x58/8SrAADFWTlM9fsbUR84iqtDc0eFE4eWls4eoNEFTdjZgxieRJat275KgdUk5x3lGiKi0
GmAkXFqdlnNjEP6uRcUaJ5BMTXh/xqwQzaQKUEacmRqVsHdG9pa85jeU1R+VMyTUaY4jTgdQ
LRbJculbz5haeJcT904CNgGqILNo32SWZsL1RXKow/kxXDrLtW1luJwwbpv7Wbc+AM6pXKYu
DH6DcC/jXKXh1SFyFAsSE8bsIzYII2MEeHr912/V998SHOKJAYt0Ma2SPe+P8v502H0vMeUL
jWJV20aZIcYdGAM2o6+nwrfxGFIjKbLVm3limwg7PLf2E84k+8tF9d/TA5Ade/MRavTyGpfb
/+j/h6D6FQ9/6EA69rRVZLTbH9UzK8Nxehvx9yt22As7VvFKFeJPW+5uBzGHK+ghRE5OpTW0
FcnnDfLQqRTS85ALYGGtSEmS4QDwWG0/EIBJLERguHGRFE0AI8I2/CYeHvC7IEnOqt1gpSYw
tPLqRN6jHhw3aHmdSE3lucg4wxGB6/Ph6fWzJW8PGla6DJddn9YVsc5aYNRUmJGzKYh+AvpY
cTXjYLmcgJJXcbuJFLvCWXoKtO46K8uGSNrNPGwXMwsGqkde4TsPKGqrux7L/AmKTG4NdFyn
7SaahTEJB2vzcDObzV1ISIyacCC3VdP2EnBLT/bFgWZ7CNbr+ySqJ5sZd1tzKJLVfGnJSmkb
rCLrN3KqQGtcUs8nCdJbsvsSu9bNemWQ2vrat+ku46a2PtdxafN6EppkwjqJQAZrv5haGDW8
j2VouW+NQOIDZ8B5to/Z8FGDL+JuFa2Xk+o286RbMdCuW6yYZkAI7aPNoc5abtgNUZYFs9nC
3tGcD72NxnYdzByW1TDnVsAC9nHbnoqbmqHfkvn61+Prg/j++vby5x8qifbrt8cXOKzeUMHC
Jh+e4fB6+AIL9+kn/mk99YGiqN3X/0dlU97MRTvv1e3zHQZWRJ49Ab3zYhSS6/EBou9vX58f
YOuEo+Hl67N6JO3V2q9M0XNVe1X7e1VYppjLR2qagd+3C30QNJoK7TsJ7q3X8XGzLDnYyQ8w
0i7Ok6oxoud4IiEGNOfO65QwUvBX2YcYNCIQUkm1+DYFbzkh27WWMJNWDELMZPEhEhMa2TzB
FbCse6eWe1sGnfUegvlm8fC33dPL1wv8+/u0uZ1oMmo+GiB9daAjd0P4QrZGgqq98gxwr09D
B3S8Fz0GCuGEEDuZSqoyJUkN1Nk1/sRe7U/ExH4DTa+0s48qJSbrv69ifrO4oL1BCE4ajZtm
CRo02IHIZV9EOhRO9nqKxWQa5wzttnaOEEqDtlv9Ko0tB8cJdbVHgIxp/Cy6uebz1oXZo4Px
3KwFxHGodJ0ot3GTaU/lW1V7NjYA+tVm9O2tTMJfIF5x0rk8WY2S7wFMf1bMop5to7mGzxkb
i29cMEuaLqLMC092VKz+3HAeEHFDvYL17z4IqZfUAJ6xKqTB6vAYCkvsTx1gVbGZ/fUXU7/B
sK4dQyMCDliuynCmJSkeQXV7F5lQVxpZGAs9f82SYbpK7/aSppwicRA1saoD7zfoxdFwMJC8
8P2IxjGVgCw/PjxkA4lyoiFJgXqIdmkdzwyFEhJOBtYv19TV67wMTjENVzaUd8qqewHYt6a9
1FgT8d2R16SQIonP4lRMmj4IOGx2GXyMr2FRf4xmq8WkZNEmCe7KHnVWkZz581Mhq0Rmdl5Q
BZQH2Bvp3YSCd3XC+qkcrrkdEtFeavt5Qkz7KRux3+N1mkJo9UmIB/g5Nerc9CFRGvqRbwtl
6uLWDpwVpRRxT5qOuyhab1ZbCgXWAWWomwCjNQPUPs/OF+rTBWTcSRWLKAooNBFJnDr9SlSm
JQeYAm+MdY63QnU0j8LQ/W6Cl0kUBJ6RUeUXEVvtan2v0GpDO7gTXZZSkEjqHJiewpRVsLvE
VwrPgcczGcyCIHE7k3fS+31F3JyzPPd0dMAGsz1tDaTbJsunsAqf3/SBZcBg2qwQFFyqlFix
U3vZQQUf4iBwuSiW0WzuwD5Oa20yFPeP7tg0cH63cev5fuj4cfpFLWwLDkSCNtbZhzIoFsDa
ImndBs9C4vutngaNqruH5Rs2eyIPmiE/ttFms7QffajrmvzANyNNypDRoFGrUDBQLzyuaHXt
j+ZEZFHb4eAKgtswdfkDcKUjruyK2bRPdS1prysaHIUtxO21TCgIIb20sw63JKCrzQ8JxfX8
G8AK1QJ/sw9xIFLJmPjXathT29/R++y7iW/wm8sTmbApDIAfSEYo4KM9D9FpeYlydK/toTic
RCY0QwkfRHMDVBJL7gRE1DG+kIgyhNXZPm5tyQCBjcyjYDnjgCEFgpi8jrqOAuGfI3QOfcbD
JFhzBg9KsemDdRTTWpUsliYZTQNuYfrMzqloI0on45lBHU4wIGKguNMppCi2gqk9LTYr2/43
wNtms6Z+iBYmYh8+uRHAxrNedh1bGHAbwN0pvs9X4SzmCpd4ckT3msaDaMsVLZJ2Hc3vFW0w
I5DjWWcPX3vaYpp8NwXllMRtHtTXvliu5qGn8bgM1+FkpLdZfhRc4Isq0hSwpZ0crs3qtirD
KIrcuo5JGGzuffun+NScJgtRfVYXhfNg1vMK2kB1jPNCMNz+EY63y4WqrIg7tJxwPZQC2WEZ
dA5PivowWfqtyJomprcBCD/nq9mMmaLDJuTg8cckCIJh+8y+q8yolyd0/v/bNBrs7w9vP6DX
Xx/evg1UzOZ6YYOWzkUHDVqmcW1eIc98qxi30SndmPt+/vnmtVINMQajVQABKh6Bc/FTyN0O
U4vmGY2u0DiMzfMl+dEUOk/psWBND5qkiEHc7476wvvm8vKMbwTx0TamWHWCI/Bu4x+q632C
7MxnPxqw2sJkDazPn18XOGbXbUXMVQME1JOEhdbLJV3RFBdxHhUOyYYvLo9b7k7yRvARdkj7
3COINY8IgxWHSE1wa7OKlgw6P0JX2E56dGeCV0yWcWMqk3i1CFZszYCLFsHd0dN8x5bOi2ge
ckGIhGI+ZzoFq3w9X244TNJy0LoJwoBBlNlF2qr2DYEhz2hHbfkhrfJ0J9oD84yoS9rK6hJf
7AeLR9Sp9M1ZK4uaE4BvBOJjuwr5ca1gkXMv9I3TVoS9rE7JgSQkHdGXfDGbcyzYSd1fF57E
NWpY061LbR/39w5MgMi52WoClXCGbKYaoo/dJAM1njN7WjSiBv3NU8FeJhXbO4vmEJcX3nBl
ER0xM46lx42YiThscNpxEs4lUDSsm0Tz1Tg5LShu9nMrFhD9EvC1ZkHZ06aIUxCwFp73DAnd
Olqvf43M87AiIeNUBULRBLMwoI7BBC8LUFeLTno/7ASblegSwemcNuH2FAazYO6rR6FZp3ub
CtV4fAFGJGU0DyK+z8k1SmSxD4KZDy9lW7v3/1MCPShsbw2F79pySrpQzb3zdWm8mS1DX5vo
DQKM9m6Dh7io24N4t7Uss3PdEsw+zuPuHm7iaExIumROArRt5O70Qcj2xCP3VZUKT8MHkWY0
GMrGilwA/3B6k03VrtrrehV4Gj+VnzwMkR3lLgzCta/1LI/5KxdKxB37NoXaffoLqI+eLmqC
O3wJB3EQRDPueoaQJe3SO0NF0QbBwttClu/wJSHBnmmEUv3g2xBFtzrlvWw9244os46m0CA1
H9e+t1/tTTkrC0yp+f7EpCDwy2U34/LM2YTq74Y+ZT3BX0Tp67dEL9/5fNnhh7/T1inZBgtq
YSAfN9lyWbJLKpXFnnedIJQg2wWepXcpNuvuDm629HUTsQGn2U+I5nz1yuJVFXXVCulZnEUS
zNeR92BRqr/atN4dLSUgxOUH8T7PIOmcdS1ziAS1pE56Jk/N9v09XUlHuD/9EmVaJMhhvseV
3R42CvJrtKk2wP9ah9H/FISqX69+X8mK05ldug8YzeHZOtSo2m54E2ToOfYQ+ekqm6oU3g1W
zxnmZ10sfeklXHq1l/3CV2Vxe72zZ6q/BaijXlaX+BwtHMzvNQZ04WzW3ZGANMXiHnJ5D+k9
KQ26F+92siZOAzYG06F7Be1W5FnMZ/WiZO0vbIqtDEI7joTiip0dB+XgaJJJgjyppy0mTm8c
aRetlt6jWNbtajljre022adMrsLQs79+Us83e8a5OhRGLveUBq13aR8MRssU9rGuYVFUFxGw
XFUSJVcjQZsJFpNqNNSVdgjOJ38bokZ8qsoYBOIa7/DuUSotBxhuslURsm0R61sT16I272Yw
UFJ6HG/MsLRFfxbbJuYjAwe7YLderzZz0+nJ0MZdtNmsfVh9Evb1pdG9mRAUcbTgvmBfh3wo
9IBGzw0Qv/l0uSNNmiUViRK2cOrbXUyCy5x0eDI1QkXIyoyX+G5GyLbGfGOK0tvHYyc/bNwu
qCQfBX3zRSGucNaRm1HT5SKYTSpBB70cZ9YzNQ0c9P55USs5DCI/RdzVISyfmtpOTGltIBoL
+803hnKYCqeik/rfnWGuk91ytpoDhxUnbyNAFC3XEyNKfSkMCzEm9YtZGt5Km2M0W+IX6u2D
48+mknFzRQ99ZME7X6HVbL0VeRtEotWc36+0rNxz7IrsfG+jSbt8vuAlUU0hVM4y/+gmRUyV
awKmhhzzJc05XAHvmG2QRa+W99FrH7qVdSGSwB2nphCLQbwYvTQQyB+6CqUjOih5W3BuWQq1
s4MoBoiWfxx4mBpHcpc+CCaQ0IXMZ5NO7eZ8SKhGLkniX3WPcnh8+aKyEIjfqwe8nbKfC6Qd
Vj/xvyb6YfR1UIg6EXXL74SaIBdbh4Cgh+TlBGhc6O+VA1zhJFMyZZvELehS1G6PHAJ94cE2
fhpG51ZkHxeZG5R086/gxnl06GcuCfUN27fHl8fPmLt9EqlEnFTOltqfaB9f/eZeHkv6rPtZ
DgQj7HCxYKMjkbQQ+FxlyueUxEfcNnA+yCuRfHUsiwKzA5yrZ3wwiwT6WU/4sv368vT4PPUr
NNbwLG7ya6K2OR339eP7b1G4nEEFqpyK8GDiKkxxEFbmwcwXmWSR8PuhITnFjcz5YEdDQdUY
C8gNuEF/YF9ZNMhW7MhT9wR8p9I2ScqO3/5vFMFKtGvWwcOQmMX4Qcbo8j9ZcVOKoUP32jVF
Th5PKU0kdt2qs+86Ddy4s9Vtbzp0Dz1l/KELTcLB7tH3ZdOr12ztp7UNuql9mxUgd23e57Vn
+EYkN3IuF4HyrlLFiL1IYBE1DKO5JHc4pECVK5gv2d3LWY1OOzrJUJmSq/ZGZV82R8WwNV2T
PE7pVVRy/YR+I2zIe9XF2h81t88hBVaudXT/Rd89lIrdx3MddL9n3/YkqZf7Q2qnGb9d4pJN
14bqDYkbXkwZynrrVZ8qO2VNecpzU/+oUmMiGZMBnVOlFbolisDhnIzpfm4VIRT9/vzshOmD
iJu+BU9ko7rmnvv43XUDE8TdypoQEGZEBMhleFma5j5ZuC62JpBgfG+TaQKOJzfK5wZSL5HB
Aa0fOx4H4oafpuhkiNx0gIYgruscnb3/75YwDBMuPHz2n9Y35qORHJijCxO0L2aew2gkWHAd
aZMmJOaJGgOycifTlLd7QzEYa2ecAHIEENMkYOiihpncJ4csOeoht8wxCfyr+cmxwYpOtK7N
T0MJvxlCj3XKYEGM11aTaQuIEgApSdCEjS1P50q6yLPEHJrmHbBpb+R8/qkOJ/qDn9Dpv+X7
607RVP6R5Ty0vYH0b7oxGZiduM+AmNWImGDJjGeSsGJhm+Q1NsdyI6DOMgyd/ljwqexZ4H51
doirHfEFxWWIQWm8IHEu8mrfpPxeci7Yhw6LqmwymjUOQCp1RTNp+VycuO0XpIv8SvbMAaIS
OzJgk4phyO44XY+jvmbWSXNqZY+JqnQiuQnbIM9N3QqJpg1crXxvnIdFw8QkrnFgByC1HyZA
oI630nE/fz6/Pf18/voXdBsbV1lJuB6AlLTV+hNUmedZab8UZSp10imPUCfAa0DkMlnM2bvQ
gaJO4s1yEXCFNeqve4VFiUcdV7jJONUHseqV4HtFi7xL6jxl5aq7o2m3YpINorpEx6ulGfLU
wOf7irznPgBhBIZpxMZuKinmihun0JxoD1AzwL/9eH27m/xWVy6C5XzptgjA1ZwBdnN3nOIi
XS998wrIKLDtIWobj2aTWQaFkrWQA6oWolvQGkp1vxA6wLPAt4D29ckZZtEul5ul2yKAV6xv
ukFuVhM+PguPOVvjHDeacZH/5/Xt6x8P/8C0fibv0t/+gLl5/s/D1z/+8fXLl69fHn43VL+B
MowJmf5OvHRxceMm5HHy1Lzcin2pkm+6FjIHfecNBpfSjmtF3HTNq11CPyOlk8fbugwSHLOi
zlMKqwafS3uWk5h5zkHPRSFpNDRCPWmXs79gU/4O+g7Q/K6XweOXx59vPvZPRYUR36dw0kCa
l5wuiKim2lZyd/r0qa9Ae6e9lXHV9iCTOVBRXnsdJaG6Wb1909uG6aPFG7R/u1bY54537ZMB
y+PzhAEU0CQI8c48pvegotwIx11oylWI8Sa7sA64W312Ts4Ec9sDxORRHBHphQWT5DyYdMnJ
UoIgpkyvBWQtq4H8Vjy+micVh52RycmF5bR9g9dIEd0J9X84HwWbFheRJiSaCCa1GDJHewqN
a9Athwm82ZdCDJKmTVVA4GO3FuAq71dhMCW+M+NNngI07j7kVJ57xHzEVnox0D7WXRzaN74I
G+IrKbRNggg27lnogF3bGs56Rx0uENbhg1KenukdxS3x6Vp+LOp+/5GV/JGbLDlgmssE+zFK
YEhfv/x4+/H5x7Nhw1dKDP+cx4EQKvNsFXasFollzHp3QUqpc6vSmPYKqwSTVZWyqXK23oJc
mxxabkJr+6Uq+DHNJFLKGhGTkUPY5+cnnd5nkuAdagKVGzNKHx3F1EIpKzSLMcfUraF/Yure
x7cfL1NZSdbQjR+f/8V0AnoeLKMIKq2S23vPJlBJh6U/YGCN9wl1K2Lp8csXlY4WziXV2uv/
kjTqpCVM8RSF9XzOLrAprfve1WA4mHzZ7cNu8q4BDLmfDaJXz4rZEyvKwg57s+hRSN6doNh/
Gbuy5rhxJP1X9LSxEzETy6N4PewDimRVsUWQFME65BeGxpa7FeuWHLLdM/PvFwnwwJGg/dBt
VX6JkwkgAWQm9JsKyIn/hRehAXIFsao0V4WwMAkChA4X15q3zoJQzFdgRsX9K5IfvGMUMi+1
EVZNz/VaJbGbH6G2wQvDQA83O0dx6WyT27ys2wGpGmweiU3P2S6pQyQjAaQuIAuwtpQPZz77
7fvqjM2OMJ60KAwTgSt+bODb0NP0NFzkBzNHezCUxTlJ1T9Ms7pyYAUy4NBthYLJpyv1RETQ
rDiUgip8hrx1yyvDNv759PUrV7JFEYjfoEiZ7G4yuoirElIbMMqznqGQBitX451KqSYP8I/n
Y/O42iT07S7J0G/10qm+FkZF6vZY5Zfcyoju05gl+A2ZZCibD36QOD8IoSQqAi4/7f5s5S5X
Y3fmrGqxcTN/6lw3gRDka15kLhMHwWDvB7RvR4vxML2VOe/f3aKx7NwE9fnfX/k8j4kM4ldo
MjT4hYb8mvAYC25UqMiyU1oEHNywARDczKiV8jYcjlFCZydJExszw6Gr8iD1PXMbYvSNHG6H
wu4zq8fUUEqSKk3qDOq+SLwoSG2qnwap1bZ9kUWJT6/YPYkck7MbjEaUyrFKEi8nDkNtlSB3
su7PVXdp4u7cZRo3hoLDBXDqejDFTGPri0i7Loycxvb34+TMN/t8IputHx7ozS5w8RXUKz95
E7i7RJo04cdntqgsj8/8ZNjthxS96p6EuBrhhZRR92adsVKCAeZmIu29ijwMpocOlRdssKqC
Nr8p7XxJ8fXIUfMQDf3M3xAVGPe+ObDzMExT8zN2FWvV12vlXNgT/l1CtQ1IXaV/ONtj3T2l
QlC9Tq0ehO+6OPT7//jXy3REYe1zrv78jC74Dbc3Nf3ywC4LdpnnQtRIsiriXykGTJrI8hVW
hB0rVDqR6qvNYl+e/nrWWzTtuE6lvmwvCDOu5GwOaJiH3eboHKnWQhWAOEbF9OYyxqF6w+hJ
Y7TKAKGu2yqHpstqSfUJQ4cwVzKdw1XXMBxz1eZDBx2dE3k3HEhSzwX4OJCWqgODjviJOuR0
WVF0bvH8H7mgAd0E1pdMja6hENcNkZGdRJ3nMiYT/DngZjsqaz3kQRY5i/u1TGyNzkYlqT3g
7yxMPH0pnn2B4EsoGwQKpy4urWh27rr60exhSbXPMDT0dKWoKfSsu5Mih6fbh7JXo69K014z
ZulEFvmrBYp3nAQVNyw4QQjHXihTXowNpakC0g5+LW8mg3yrFlkqPXXRfQddk44ZqctjO5YX
/AxjZpIOgBvVZ3v1obep1RqRkoZYxDn5/iGAaINY/SbIYTdscp2KB6Txhj4514/TDXcOJYUf
Yer88kGFOb5d1EJfspwN900ZUeA0HQ/nsh6P5Kxe3855gk9v4u3Qik4Ybl2rMQWoFjO3Zzbs
tzupYh2UYAPCFcVDUljxKmYA1G7hQ23Q9eOHNX8hMGqrl4yGMEZD0Cp183dRgpRVlIO4+pIs
cRRj+U9eNptDmkvczo/wba7GkzlsjhSeIMK27ypHoh4fKUCUZkhHM7oPd0jjp+1IYsuYED25
iOyQ6WM2wrORfog8TGz6IdtFEda555z5nodL7NIyuaFErdGoajgkfo4X7c1aQZpuyOT5lTRe
fvr+8hdi67O8kVAkoa/IuULfOekpRqcQUsMFaH2iQ3h0EJ0HC5ChcYSOkv0kcZScBbjV28Ix
JDffw3IdeI85gJ2PvmchIf8nDeU8MW7dq3Ak7gISTDdfOLhehidleRIH2LSycNyq8UCa+TIG
aTnrSjVq00Ifbp2PlVmwONh+ugOe4wi2O2zyZzKCvVhsVXQ/EtSdZuY4JD7fJBzs+gOQBocj
1oRDEoVJhKnIM8fslqiFA1uSD3x7dx7IUDIbPNaRnzKKFcuhwHMY8U8cXHMiSJ6Jeq2wUKV1
RGMjp+oU+yEqMRUc5Tq0zIVnSNGB91u+2xJxri/0foA/CgOvMPKlcSO1nMgjuzESQCs0QQ5F
y+QyfLU0GLXmVTj4uolMUgAEPl7nXRAg30wAO3RCFVC8PbIkz9Z4F9FUfHTgAhR78dZEI1j8
zJk6xo+jVZ4M0wsUhtA3tpg6hhpNKSxxjK1TAggzB7BDPoQAImQlEECGipus4aao0LwL0ZV0
yKVXvDX355ppwvydaRyiMkKTTUGlSYhllmAiSlVdU6Ei+kFNU6SnILQeSkVLw6eUmm6PPJph
g4hmjt7JoiDEDl81jh06OiQUbcp3l6dJGG9VGDh2AdKxzZDL87uKDfqrigtHPvDxhZ2IqRxJ
gk4eHOKb663ZGTgyDxHBphNx821A3NhkWmd11DLHMhNdKaxJGxVhpwGbMjk5QD8MB0LMOFfB
c2TAIYaZi/JBSz7RbM1TJV//dx4i3RwIfA+VPg7F1wCNY7XUibJ8l1CsthOCibvE9mGGiBXL
T1F8g7AoVNtkaHiADj0BhZht7cIxDCzB1j1GKZ880dnMD9Ii9VOsQBFPMNheQQRP8hNlm3d0
uqn0Vg0JPGQ1ADom6ZweBrj0DXmyNaEMJ5pjq8hAO99DvqWgI3Il6GivcWS3KVTAgK44tIt8
pKhLReI0RrTMy+AHPpLRZYCA0VjdrmmYJCFmAK9ypH7hSpz5mD2NxhEgexMBIE0TdHTISwRm
JrBI2S6zTtJID9ajg7Hu7Yxx8SF3wh4t0lnKE7JvsYKawaJBtAvjiQTvxw0VM+PEGEwlLftj
2YDH9XQKPhZlTR5Hyv7Xs/N07Q1mXH80dKaCfwwEJYUHYTp8gZhZi1IadB/bC7xe0Y3XiqFh
HxH+A6l6Pt8blqsYJzjhQ0xr1Ah2TvDzLH+1ksAHhrjjZI2LwGuNlJOn7rz1fUt6lm76mx1q
WhUtDA9tXz3MbCiHNFjbZIEHFNscY5kY1KuJtS0TeCVDfirao00xLMEXctNeyWOrBz9fQOkb
Ktyepqj92PSxsEMAZmE1Cfl5FjzbfYmjtuvT949/fHr7/a57f/7+8ufz24/vd8e3v57fX9+0
2+U5cdeXU87wdZGG6Ax8eCPdYjI1bdv9nKsjRrA3jFEdDJDtVj85ks3l6P3jiqzO2sOgfu91
WlQBpSz8/F+eoi78TrGNApRHFewQEb9J4m1AWpRsk8G//8SVhWrISa0/A142H7w426rSdB2H
9dAUjWCzzR+qqoer4I0SJmtBtIjiupWyb6Ih9lOk/XP0JSxP2CmHN7zec8YQQsrOdY7AYyOk
rmjiez5EAV2pVRx6Xsn2OlWaTE009VOMJBAZ4MJTkSNcX2G1nm2E/vHPp2/Pn1aZz5/eP2mW
QhDSJt/8Xrx4w5VitohxZT4l5Bxr1kqXQZzPlrFKe6qEsb3OwsADx0iVV/AECp56Rk0i+IVv
ppoZjOKLqt1INsM6VUYlgJqIACh4Up1Jm19W1GG/us8pQbIFsv5rlHXPK5V7nZtUDlcxAucr
ppHxWn0rR3aoCcPcE9WER0ryMacNnq1pgiQxuE6yBFA4lHz+8foRPAaczuT0UFiOfkAj+ZBm
uwiLeSZgFibqDmKmaUb2VCgL1nsagpcMQZp4rrjjgkWEPQQXolwV9BU61bl6Zg8A744o89SN
n6DONp1GLsY1+UrT3aeBblrPrzQXr3kILToaLOdRT/sFVa9SF2IaoTmhB2orqtvbwMeANRE1
LV1Q3UgH8pqWYNwTS2EwImEuiKu1pgvFQgstmvYYmKBp5raiz3M/vJnffSLq/n4qgNT5VMV8
jy06BLvgHXKuLLEqVyoJNJ6R5p1ad5ymhsoFAlMJUNbyLIdCE2bDOW0LLdwNB0wHWKDJuKUe
RrQkRpBj1NFECu1ilKAlkyE/HdeAK0P0M4YUvz9eGTLsPHSB012I1CzNPNwOYsEDl/hNVhRo
phl+ciXwIQ4dthcCLptD4O8pJjvlh5sRNlgM1YmkZXOpurIXERsctQdtS89HsZFRdJcpICb+
0sYC6yYukzW2sW0TpS42zSpxtrHQWtDn0RChR9wCvU9V+1NBkoqpmQ8r8601glW7JDZDRQuA
Rp6PkIy2Cvr9Y8pF35r44DAW/dBkf4u8zaVrjrAszbsH+vLx/e35y/PH7+9vry8fv91Ja/1q
fkoL2WIBg76ySNK8qMzm2L+et1a/2ZRSoWnh/+VluNYddRdmO9wQT8Jp4nBhmXKv9aisGtyR
mhLHaVLHYt9z2DJJzwbUE2qOP220cnWF0Osn6M4F1bZNmhslnDWs3CQQoTewSn4pUjnN82Kh
ao4XCjXAqdjKtmDupZyz8OVENdKZd4X2CJsRci6MtzCudeztNsfHtfaDJET1zpqGkcNnVZSa
h1GauRYx0+tEzKW3NLIWw7rNTw05EjTkHKiBpieRQrQVvhmw9AyhhwU7nXilkXZhMNPML3yl
0wJl0lKLtjN1APNoeaVhkjEhLk/9mSXynPGtlrphNyhiehfR2sHnylTSZkT30dLTmMh0qmAS
NTdZUSXp7ae2VxytTO8r6U1R4/G4tk3raccUUHstb42xbUSTWAH5/PalrQeimtKuDBCQ7iyj
NrIz1c1LVy44XxbHywsf+k3WBFz1O/JpBT21UXh0VXKFYCuYqpeAClREoSqPCjKNibpofbwZ
Mwf/kmATv1k7c7upI7qViYKJzdxmxsqGEcnAbemp8egCakDuvBFHQ4QvN4N22/JmWJDrSOxG
QgcS6OaRBobdUCoyTpoojCJUWszDixWpWJ2FqNOSxhMHiU+wnEE5SVD5EIhDPoTJN65Y6Ezo
nllnwVtcy/XKBcVJjNds3o1tFgtMkbrcaVAa79ByBRQ7PrDY/kSYcYnBk6Cys26qMEhs8lBs
2o7rSoaOJ6kzaZqhIk7zzuc6HY51kfFMqYqlaYRZMusssWNc0+4hyQJMkVR4+C7Sd0yLzhj9
KovcuG2W0R3OH0rfc3zo7pKmHmrfZPCkWxmg+rLCo7pRruQHeCbODAyzwmJzuJnvule0Ia4z
oHTDE2BFlO2fjdVHrqvhq6KlgygQz9GL0YmKQ6kWrnWFuPId+XGIVgR09yCM0YrIrUsQ4r25
8QyPyYRPJQLz3dXSt0UWlm5UK9j9QrW0/ZCBabsiC3NV2djiKJjpG6RoZmZoxxWyndMxFk1F
z6dTDZ3StEN1qAytz338UUKUQtCcZCje9cz/z+dPL093H9/en7Hw9zJdTqg4o5bJcZ1eMJKG
1C3f1F1+gRdijA/wpNqvMPcEHOh/zseKHuPSW8N7b+2JCbpURQmRIi6mQi4BqYzTqoHZgTTH
cjEQoKL/kPgusjDxeP1PKgQXS2uFlgygnnNQlulGxw5pxeQ3e/50R2n+P3CRNoce1CqTP3Z9
yRhvR08hwpt9/yOa8fT68eXLl6f3/6wxI7//eOX//p1zvn57gz9ego/819eXv999fn97/c43
Qt/+Nke2krnA1pColViCn1iorOOPb9/f/nz59nxXXPZ3hznXOdPh7e3LNwhsxbdXz1/evt69
Pv9rLVstwJWR4Dm+P339A868rKBbhRr8kf+AF0GrsdhXGJVpCxHQi24k59scCBezOgAm4cRF
qZVY0FlZH8D/1pH4nrIpoKteI5mYl08ZvOzctXzwPfKZ5MDMYg57iMuOGg4pXBAzeOQiWSxy
YpTXgVDqtGGgFmEs4GKVb1vHrlV9iwC+9ISijYF0GP0IIePgBhXBoGNcGKRjJ3DOxlCWn4R3
0xJ15/n149un5/e7t/e7P56/fOV/QURUbRBBOhnyOPHQoMIzA6tqGYLDoEOUw4Fvi7L0tgFG
VtQbV91E5UhPlfDxSzqVrBbFZ1ItmPlKE0cF3WB0FKGFFtx2pY32UJiAvMIC/CsMa0lY8iO8
ZyFk+2BPeCTv7v6b/Pj08naXv3Xvb7x9fF76GwTW/Pzy+4/3JziJMb8aRGIiuaEpzx31SxmK
HIuXb1+/PP3nrnz9/eX12SrSKFA/FV+p46kwqzLziPF8X/ZNWY+mC9xU3c066MU17flSEvwc
XQzFIx6wHyA+svRvfi6MgUxUew0xPx7JMVAVFyDmVd+f2fjApx6zN/qc9GCAdCoodsS8sNSX
wprPHm4Oy0WO7dv8hFm+inbJRyYsie5IIwzxtM/cPb0+f/mmf1jBOBLIii/HfDKtSyQnXody
PFWwww2SrDBrv/IMF9/zr2f+rWrXhCKZsU6QCKto53gxZ2Uq66og430RRoPvODBfmQ9ldaua
8R7srSoa7InDxVlL8QhmrodHL/GCXVEFMQk9PGzVmqqCt5Du+T9ZGGCnCAhnlaWpn2M9XjVN
W0NgdS/JPuQEY/mtqMZ64DWkpae/Gb7y3FfNsahYB5bQ94WXJYW3w/jgZVaoUj3c86xOhZ8G
GcbHCGXnBl6vymTcAzsnDu69MHrwAvwDA8NxFyXYDn7lamBPUKfeLj3V+mmBwtNeCFS6GcIo
Qu/BUN7M82Os5m1d0fI21nkBfzZnLjQtytdXDGIVnMZ2gGPjDP06LSvgPy50QxClyRiFg0Pi
+f8Jg5eNx8vl5nsHL9w1joBga6KesG5f9v0jRLZd333d7IOePBYVH5w9jRM/87FaKyxpoJ+f
KExtfi/a/9vJixJe1+zn1W2bfTv2ey6tBer7aIsYiws/LhxVWJnK8ER+Np4V7jj8zbt527Kn
sVNUyhWWNCUeXwrZLgrKg4f2qspNCJ5hWd234y68Xg7+0dFmrpF3Y/3ARar32c3D3YcsfuaF
ySUprqh3DcK9Cwe/Lh0NqcQb3LeRDUniOYalxpRmri3ExNw2j1yXue2CHbnv0DInjiiOyL21
4ZA8Q9dyZdML0oHL5XY7J9ZdSIeSoI0UHN1Ru5NU0P5cP8opJ0vG68PtSPA68emjK/lHv3Wd
F0V5kASbCtC0OqsF7vuqOOLr8YxoC/xq97B/f/n0+7Ox1otI8diGb1ofOKkREVhc2ym+Zo/w
gquxYFF46fBUdeBJV3Q3OMzmW6V9GnmXcDxcdWbYFnRDE+5iq3dBbR87lsaqHaUBmWsO35rw
/yqexgKqzAtuNjEId2YHSJVj6lRH44dT1UBoujwOeT/4XmDlMrTsVO2JvKVPYuwyGGFL9Boa
aGoVwmf7Q7dzLnbgx9LEEf/KupnHnLYr/IB5qBWmUILFgRcfuqS5xaHuwG/iCR5AUmMrOjMH
8aBJcUkiM9SIMRxsWdbzKYeGXCr8/lBUoc+7I/ZWr9hLUz84h6rIQDh9QE63NIySwgZAVwuC
CAdC3ddahXYO27+Zh1Z81gof8EPAmakvO4I/8D1z8Kk20r+4giRhhN+Si1Et3indnDK5wlM2
gzhpGR/OVX+/nBYe3p/+fL7754/Pn+EBCPPRt8N+zGkBMTHWbuM0cdT7qJLUes9HNeLgBqkW
z6BQLZ/5b+EodSkZsc9BoQr8v0NV1z2f2ywgb7tHXhixAL7ZOZb7utKTsEeG5wUAmhcAeF6H
ti+rYzOWTVERLbSfaNJwmhD0ywEL/8fmWHFe3sBntSV7oxWtGp0eOrU8cHWyLEbVRBCYL0ei
xS2Hokl+X1fHk94giBY4HU7pWcOuEprPRfKISs4f82ssyLkzfA+x6cZb2dFAK4v/5l/o0MKq
Ni1o+rd95Fpz4OmqrUoH6cKLInyx4V2p51dRNgxGXuCQJ17ncX065hfi0hcvR77BZOQ5PcyE
h4BZcSvu4gotH81Vq766YB4P0MhEXXfhU88xZ9X0kshnNHjtDA+Cr3A9sqF6OJdItuMRI2qG
Z0o+5FLq0m2eCC4kK4uJrEqz1h8SthxMVB4yPPqojYzEtOL479GQRiDNnqV832ljN4uEjz0W
Gj+nSVKTOnLBYxMBVulDlv8eQ2uQCCqqPICYlS2f5yq9i+8fe306CYuDKTdA4gp+XuJnYDOH
y/yO45e2LdoW0/sBHLh2qHfPwDW9sjG/N+mxY14xp+jJc9JTuahpM4ik8nWTcPXkgnoRazz5
mQ2qcw908GS5rXU6Zfn54JgrtGNMGKl7rt3chl3k6QPWDhMIPSMt7sxhXML2raUOSYFXD7To
EitN3PwdjcV5xszBJ5Vus62MT4weZvkjOiLxA/UuAdU+xNqxf/r4f19efv/j+91/3fFxZb4t
rywvcNqT14Sx6cFdpOhlxGmMa2NW3HpO4/8Zu7bmtnFk/Vf0dmYeZlckRYraU3mASEpizFsI
SqLyovIkSta1tpW1narJv180AJK4NOR5iaP+GlcCjQbQ6J4gzRxkIpvmaxPCDUWORaadtk6w
8+J9YrHiBGhQHEduSHfDp7TCbXwzMRVlEAVzgufAwRU6kRWmJg7D241rIEBo6yhkMGt5p5jB
guMdNmF/ebM2+sMKpSEH9gGWRYNh6zTy5kv0E7RJn1QVmqEcD3IGvDPOh/RMhQMnGsqY5WYA
uMIG9xeDlpZcn1+vj0wvk7syoZ8hV877sjzZwW01Mvtb7MuKfojnON7WR/rBDxWBwKQkW3w3
TDHF4sFP9+S3a6lM9npbozlYl+lDDWm9r1TPLMYPM+QzkJqktAjnrEhtYp4lqzDW6WlJRCg8
O5/dMc0andSSY8mUO534UfNeP1DOedVwzwd6YLQKTqkp3KSjs2CoKm+nkyM9VQQeUXKDEtTf
JGOSe7MzW4nOpDHqfIAnXzST4dTNGloqmJpyDFaoJaEZUy6rBN00A142+8XcO++JulvkvdEU
wVnb8PBSeptGktXSPA/jtRW2LQYRhrpZSVLgLit4BbuGWJ9KBqXfe1GIOsGeWoZUVbpg1+Pc
2eDgHGNyJSIGgfHFSOrFqnGvaA8NVMVD0PJwEZr16fK8bzAa30UaA5/s49gzs2U0H6EZ7kCB
ekT9xQHyuQsCPQwOkNdd7IjqBGhC5t7c4Q8Y4DJ3xJaEsdWfmIpgjyRBN+uR0IUfoy6xBBjp
1vUTlanix3NKXSMr6fpNbk0x0hbE5fCW4VvubMyRY0FOkNgY8TzHhVkQz2jhLEdk5cbLunIE
EwUwxzawgGTJrg62Zl3yKs23mCuFCdSN9id6+vGdZL3eG0Mqg8wErze/88wyJNk9CrOKegHu
JHNEjTmXUW8VWIMdqBG2gQVwU8amJNmxcTVoB+n1+f/eZt+uL98vb2DQdv/1K9PGHx7f/nh4
nn17eHmCM51XYJhBMrkuawFiZY6os2DotSTzBqXfJKPhh0RXd1kR95YgGOiuwu7qduv5dmlF
XbiGFVusKdstBWaSgS4W3RvjtScO+0+Aq9IP3ZKmSfqda3Vr86ZjGp6hLJRZYDWOEVfuMjiK
PongqxFcWh/ydUbNXOUG27Vk5yT2beElyWIFcFaJb1pr6pq1h153SMxIp3IjVi8+8nbpH9w6
SnlvzAchMcc5EQPGrCUAXBNzVADwNhMELEtQwtaZqcjpGO+CD57J0IC7HG7VaOs7gHNdBAIY
FV125+zAiVNc0/wNRppvS7Z9QB0KaowH/dxSBx2GUTqTOOu1O0eidZX12hGsgbPF2dQUdNSe
ASZ+Y+VUWLmps6sgmgdzzQ2yRKfzgXHnMQ5HO6c2w/IvG9YHWA808OGLGkr/nH2IFpZIhIad
sYFpegxnJAha5lgT8jY75mbdBqrUbXTVAj9WEYoPvx/WxTQ1D6nNcmpxA6Urbdm6fq/K3EZ/
Pu8dVe8ITUjpAMtadToxQBvNz6HcLCXmwDj0TZ3cZZ1Z5ybl78cT1IUml6/GzgJcFHJtfW1O
EUCGg+QbW0iegTAexYHkM9Pblr63KvsV3ISylUx13GKwtl0YLUKER/goQutf5ndtDRu9uqt1
dJ2U3NFa7tPzcZfTruBiTrwLuCYzYdQK2sTm5XJ5/XLPtvxJsx8N65Pr09P1WWG9/gAr0lck
yb906Q/1gojrhLaJ+ZEGjBJHKHc1/Z6JOOzcSsuIWrNthJo0d0TvUriyv1MVth3f5C6BDUx5
2fP67rUwjTf7WZMoPsRfiHwP3sVbs1EU4Nqy82HQ3bGNVnKgKZaW1ht4AFBkB33RueFTJPBn
LOXsnldePei96S0ETWXWVToudLRTonwqw6VuyePv3Gi6TMA/tj0/+m7TbIkszOxSMJ4YBbZU
pNmCg4TOUaUFckbBMSZ+zvsuL5CSAPOWpvI/Ib0TiW4gpv8FC8e9c6hsy/ncxwtYep61u1Ex
prW9lzdwuap4t/Dmrh3HwODFSNXuFgvzkE/SQ1NHkPTIszYUA4JHJhkZwkA3AlGQMHS4JB9Y
iiSM0EiVA8c69eVNmpV43Z1p4lLJgcHy9DQCNAiLAD+p13luVU1wIL0pgNAFRBiw8IsFMsY4
YB5kKYBr5Aj4vRYCD+qkXuVYop0PEB7uRGFYzvGKm6cEE93wwKRjiMo4oH0fuyLVTFyBF+AV
MkypNASNsDUyhEGB5tn786Xf2wDXcwIHfYXQyxzpD9jUuARsRpceNigZ3V8g/Z7ROPCQIQl0
HxEhgu4adxJ1ObYZtcaujBymxOOyU1X1ub0L5ngYhWFFJ0xlnMdIPTnClEnigMI50kkcUc0j
NWDlu5BgiXxTkRkyOkpaxisvAmc5cjuMdaXKJd/53ugIpnV7UYx8XwCW5pm5AuAzjoMr67RE
gd6ZbgMXNS9dBlB7ZW4A7joB6MoymGOdLQFnlhx0SBaAWa9aFlBuxtu6BGMLPf8vtB4AuGbV
AN/OnU0WdMa2ReQHyMhoOyYP2VxNrd2wQMPIuzX1gAHPFvZnrixjHwq82Zltx/Qtk8vm8dCy
GVm2CIGQJZmT8RR02xX6E6cRgaMpcSbtQPDhNqJtxv6DJudG4YT9OzgmsDjajVT7HQuAQ8Wn
tPSDOdIDAESYfisB1+QY4NtygHEtwmiJZtCRwL+1cQWG0DpRF0jO9saOaEmSpyPUD99RgTgP
HltS4Vgu0UowCFx43E4cLj1EznHAd+XKFG73XRTnYerCwrulmXQbsoqXiNTvikPgz0me+MiK
pYAuUaSy3BZHI2fg2cfuOsOtQSC50qT3FshU7GhAfH+ZoQVQoRreyh1YQuu+EKB9SrwAj3gm
ObizuwAVdccyxh8HqgzYJ+B0tD6AxO9kiQpFoGPrAtAxAc7piKYDdEyDBDo+TTlyawsFDNgm
gdMRpRToMSKqGD3G9DlBx4WxxBzSDXwrzvFHvhrLzfHBGDCVhNOtK4EBwWNiqQz4t1zFiHA/
UhLHmAT6zA+PVlFjXlwNmusyRKQHuNHCdqOcjinhXRRhPVCRfRxi07kazS6svuEQ+sZZ50An
T9cQiNpqPtocbLm08ywtW7EgJ6RN0VOrCdYBsUJvW9LsDFQ5ShdXg3lqm7btcu2Ekv0cI2zT
rs2qbbdDhyZjbAmmN+13Wkxslt90LSTON39cvjzcP/LqWAd7wE8W8PpWz4MkyZ6/AzbJ7b43
68+J5w127cDhplGN+EZS3hpEqt5CcMoe7qB02jor7vLKpHV1wypgUPPtOqsscrKDZ84mLWe/
TmbDkrqlJMft1AS+N9zeanBJIODNyYk3bZ3md9kJs3Dj2Q+XgnqhrE+6HByvrufhArew4XzC
p5EjbzaYtnUFL8/V/Ceq8Tm1nLOSur92VhDj62RFpgWdELTabFf2mXWFI9NtVq7z1po4202L
GV9wqKjbvDYH1K6Gq2yFxn9bQ2TbRXFgjE5WuWE+aHW4O2GXkYDsE3i0mOjZHEnR1Y2ZySHP
jtz6wdWaU8ufy+l55RC6yCB1mZn3R7JucRMnQLtjXu3QJ1+i0RXNmUiqKzPXIuEWfo50hpm5
IFX1AY+4xmHWVSCFHBnylyAl+55W80rWoS3qskmgJx4nRu+lNhMDXaeWedLWEHbLKqKumHx2
Ds5yX3Q5IiurLjcJrXpVDqS61ccjSAVSQUA4Nn61PlTI7snXZBXrJPU2X1A7UpwqS243TOiB
lbcjLzaR+cP7xJhETQueW8weZayp9XHaOkkIdvcOIBOtVuOlZwODKETzsAbD+31zxtImy+Bl
qJldl5HSImUF2L1mRrNYuU1hCoxWd6zJ5yL4xSAUNQ3k+ZSk7T7WJz0zlWrVnolzSxwyKUEz
NFAfR3dsWhot63btnna2+bJKdw+dPagX50Z9+MXJ/uZzpr65EkLMEujHPC/rzpBGfc6Go06C
zGTPjBUcaO7KfT6lTMkwJ6yI/Xne7dcoXbyHkr8MxaJoqNnhZcIUZh9/RY6pUENgMlzNA8eG
iKrXoG+QJfNgSy8LNfMefbGhBcJd7lCg4htN4x2NhNRclTrUuyR3vfNVPDXqxDGG8thQoLIV
AKz2cGswYNgXTX52hcUW+VaVKzQZ4Dyq4I7Q80596LhXQ7vtRaQ2nUCqionIJBNWzfzt1eSt
8uH1y+Xx8f75cv35yj+AtPlQjUwhkyHgIzx1ySlucsn5nC8ZNLa624KJSpcVtzIDrnXB3+7Q
Doa9o2dY31Pe+dus5YHxrG9GmG7PtG22XKQirO0HX4XF95wG+PX1DR7FvL1cHx/haZy5ieCf
K1r287n1Mc49jCmcmq63WgifEbC+maBKZ5/mUMtkCY7eqPu97813jayEljSnjedF/Y3UG9bp
YJRitYAtgQEEt7KAemqw/vUk3QyDhzNR1GBOz8fRH/vb/UGL2POwCo4A6xbXpBM8CTXTtjGJ
InBg4y4XMpaxA7WkSGstHJx/ciNWy3gHxqeMrZo83r++2jtcPt5VwzUuFeBdkHoIv+dhMg2u
rhw30RVb3P41413Q1S28e/56+QHeU2dgIpbQfPbnz7fZurgDkXKm6ezp/tdgSHb/+Hqd/XmZ
PV8uXy9f/59V/qLltLs8/uD2UU/gZvjh+dt1SAmty5/uvz88f9ecWKrjME3iOXZ2yMC8Mcw+
Be2ATcmJfgZ5QT/ECFix1ZZ9fE+rAgMhfKOzCobHYC4s0kpVNEbSWYa51FvIR0Ha4vd0XMoe
E+woUkK+XhBQhnKE59v7r98vb/9Mf94//vEC7/6erl8vs5fLf38+wHMD+AaCZVgz4W0C+5yX
5/s/Hy9f9ZHGc7fkF6ci/cDp8q2a2WyOdS08tStzSjPQgzfYdl4vAJakvE7Vfecg6ZbqeZ1C
tGXYCEBYzla8wRwHJO8CxLMGH9L8QRk6S/W11ZE+K3P0zkZifqTXk6T7bt/rNJodaGb0c5Ft
6w72qwbZbPfgBzo5LZPIHKAnHqfbWkJSvi11js1Nl+b8UMTJwQ/DpNMslIkznMtNft4wJR4c
KaNuF3iLjAax8cNUnUO+bmWAHb3u9ZG0bLRg23ieOqOG4pDtaNYJcbzJ+25vCBdpbK066QLq
ifEZXyn7zDun963lYL+Gv37o9TfWBMp0KvafIERd76ksi0i9PeB9xLaJ8C6MKUeygbreuSM1
xY+i+NfqrCHAN5/8AMCRJunhiNRapzOyLTKWnyNVz/4RpY1zqPn3r9eHL2wjUtz/YooYutY1
O2WzXNWNyCvJ8oNZAR6l+7BGXeF0ZHeodW16JAmxsD6NLzst2RFIrxPKTsZRdaNGJN1mDt9V
pybDjse49gHPvekx77SgoKUiAptjS7NPTIQgRNtzBPiJ5095kfJYDsOwEVsG7ldeuJZ3K8pj
1pDc9fwYMJru1MVjJLG5yn2aULaX1bSviQN/J6rgRbcp8aT15kz4KEa7XufrVtgb0olHxlPH
2rCBv6pR3QSVebHO2LZEx0iR6FKL936+KUHDclV18E3iqmVj9W+bJ/XurJ5zAT1ZL/XrKiAe
eBSFEg1KyvH9WnuyDLQ93SUmJd3lERu2BmfyaaeHugbijn5ytnXw7+faUwBP2WF+aKau77NK
i185fW3NkGWikzJSLY3LrKRdrvoIGCijyiOjHzD99hd9e/jyHyR09pBkX1Gyyc5sGd6XGZb0
3d3omBUfKKqj7hH5yM96q3MQ6+EmB7wNV5gWAicGsLmecuRbbe7GBaOdjbNnjqxbWCIrUDN2
R1htqu3kap9x2H3DkxHSef5qbmRGqmDuhyttUyUAGkR4xHFRCXgbo1oOTNQwtjJzhU0TYDuf
ewvPWxiZZYUX+vNAs7LiAI9KiRJ9mxgtMOLK761KAn2OurDhMGvCKtRf66l066RJ53KcQ4mC
IZir2XoghlbVmzDkobnkiZmJ+R5GDOymMnKEmz9JPA5R97wDqtmuTt0Q2r0q6Tc7AHiioDdy
HAJhdqTTj3s5KhwVuZuQksTzF3QeY4boolTVAxKnqIEk9dzgqYHDS7voki4IV7hJiJhNwvWR
qypWTDVxApcQiBZlUoskXBlmUyITEe/N+dXYBAn/slLddakfocKKwzkNvE0ReCu7PAkZRlSG
FOLHEn8+Pjz/5zfvd67Htds1x1man88QdQM5G5/9Nt1R/G7IsTWo3+aXM2Moiw4p+lbdyHEi
hMYwE8NB8km/+BRdzeMky+mGNrJ7efj+3Za18uzUHrXDoarlvgZjqpmM39WdM5Oyw47KNJZd
xpRQphd15iCSOOpqUONIGsxprcZCki4/5N3JmcetuT/wDAfi08nxw483OB95nb2JTp5GTHV5
+/bw+AZxWnh4jtlv8C3e7sHvgzlcxh5nG1maaw+V9XbyGFwOsCGVeh6iYVXWiXsXPCFY5pgD
c+w4Ga1ZYkI9z9cQjUHrTOJ5J7bsE3BkiTmekmw5+7diypzqE2qi8ZHPhIR2bGvCogqoHFNY
SZrKDr1ZCzZAdwlxFMexG74sW4hx1PZYOzlE8yPayrypVW82JnJOSkeFBOyuECtUXvZYkoBB
6/1GueoZtoGnKgH3vOqT7COnTgSR9lzWh8xyRCyxIXoVtRA2vRsHFURil5XqLtqo5jjs9r08
PFJ7ZpcuFssYtw7KS5aKJnl+dtz+d150pwZ4hCMncGy4LtgOcKMWoyL4CZfCwbVhbAuvO8XZ
gwF8jl0FA9Kk7QEs3PL2k5kohWhWAnIkJlliJmLTJqkpeooEpYEHStMLIwBMbPQ6pWn3lJq5
l5sI9Stz2DAwZwvTnh9sKHofIGounLOqOS/awZwB3/tzqNTE20ia3E5OOeUQWMqOpKfAqryT
wYLKrNpbxEbfxk5UxD+4ybUGtxOoRY9k4I5N7HqURsdN5MFt+BmRABN/2mDbpQM/7EobZREQ
JNnuKT2nVo7jK4EeaJ1gm3GBgvkRlRfvsp/GDTC8NX+9fnub7X79uLz8cZh9/3l5fcMepr/H
OpS5bbOT5vdBEs4Z1Q2YO7JlihxSa9sJ7EA5N3mjGwMdmZZWFUbrxcHY45Xt6un158uXi733
TYo72ibDx5VEvnuHEBGsnC5arFUpiWanbPHZKryusV2imI2aJ0FBMsKCbi/Pl5eHLzMxI5t7
prSAnjOEmlQ/xXusikjmJSFB3QxcWh0QSrtdW++3St/XG8GlLFbBao7SkuQ40nl928vT9e3y
4+X6xf4CbQaGPU1ba35mkBQipx9Pr9+x2522KekwKVEbGz3lWF9wmCn9w0jPHUyJPD68XJT4
ANNYHbi5u1trqLHZN/uN/np9uzzN6udZ8u+HH7/PXmH/8o19pekgSUTSe3q8fmdkcGGhtmeI
i4fAIh3L8PLVmcxGhYfhl+v91y/XJ1c6FBc3033zz8mxxqfrS/7Jlcl7rEJv/0fZuzKwMA5+
+nn/yKrmrDuKqx8NznStj9U/sG3nX0aeMol0eXFI9uqYxFKMFlx/69NPlWogfOhh02aYKpH1
XTJtdLK/3tg+ZrBCsI4jBTNTupPBk+pYyAC1+WfDDaHOsKFktYiVIxtJl26CzfxuBLyfOIIg
DK0MeWD5eBFggB6MXtKbrgo9/YWQRNoOAtvjhseShZZhOMeOLiQ+3FFpB7i1arufq2AOugP3
7ovRzskaJcMZLNuS7Usz2R0P+8C4dLLc/GUpWpb474aiaSxWXiqFG/uRxVdZ6NFyDi7JaI5T
1bKD2CkLgfTly+Xx8nJ9urxpA5OwbYMX+apTloG00ravaV8Ei9D5UnrA8TeDHF36VoZL/3YC
85XiuiSeYz/DIN/hapRBC9Q6Zl0mbNyKMAFT+1Wq/rRMQ7QrpJT46tRMSaC+1GObtjad67GT
OAn3Wc4x9HWhYtgqKhGkxqjoBoD0OXVgYCV6C4ezNAO/62m6Mn7qPSBIWnfd9clHCJCpSJIy
CXz97o8sF6oMkgTzww9kfLQAKt6hqQniBepkkiGrMPQGoyg1BdCdKdRW9AkbUKFGiPxQfyma
ELj2QLKj3V0ceOqzPEZYEz2ksTFfxRx+vmfqBo/y/fD94e3+EY7O2DpjzmjxDh1sOjuiTuvl
fOW1oUbx/IX+e+Vrv/0o0n+vPOO3wb+Ktd+LpTbqGSWaR+ccXNzxCGxF4QjQoXG63I0wJvbd
UfHBgPjsGWUv0fe1AKws1hV2GsCAOF5qLVypr3zh92Kl/14pRwSkb/x5D2qAVhyjxjFQkSL5
tZtMMUqXFYih7f8oe5bmxnEe7/srXH3areqpz5Ll16EPsiTbmugVSXacXFTuxNNxTWJnbae+
6e/XL0BKMkFC7t7DTNoARFF8gACIR6a140eJrbdyPW6TdRClGaq/ZVdBvmUIx76yQJYbEnAc
lZ7tjHWAGpYqAFMy5RLEiSEoofTVlCsIsCxycS4gEwoYqE5ZGMo6UjsZe9nAVtMxIsBRo2AR
MKXlX0GNr56szjlI3BUsHaUJUUdjjdKcfo0nMEUWh1Wozc4Vs+bfciUAvDKoeTIsR9ZEXzWF
L8TJOPXlfRfLaWKYcLJ2StF6nxQIbmD0YrSBOkXf5riixFu2NZjoTVn9SWGp49XQTgpZmER7
iTWyipHdVdMOKKA1tkKQRI5lOXgCmwzU29gaNproXS3k/SKFxiAWG5sUCx1GnjN0+LRG5UPk
9Ad9tM1zcwvoEaKNPbuej6x+x7KrFZxN80hzNNw6BtSDYn46Hi694PBC1GM86vMAjqeOwhfm
w7Um/PEGapJ21EwGI7Lbl7Hn2EO+3WsDsjuvu3fhC1bsDucjabaMXBCIl0bUziwORqqYJX/r
MpqAaWH/nldM2HIroXtPvaOzuBj3+zQnGgZA5liosFhkbKHhIitUqWb9NJmSDJjGt8rQ8P1L
DejBpNSpRmlUdi3sSVWBchoNfVUGrhE+bPuqyBcXdRNFPYjSQlJkzXNtn8jyAYL6OS3+5Kpp
G01okiZ9LY8j8qWGqyetLlUrtwFmi5eLl5eLhv0RkXaGAyozIqRDuwCUw3JBRDhERoLfRAIY
Dqc2XtIWgQHVXj6cDjgujpi+o9GObCe/IRcNR5PRTfR01JHYB5DjIRES4fdEe/t41DEWY22E
x+N+TgGaADmgWw04yqSrBnWWYmkrrs9+4TiqIAsyh6XpAyiGjDpSQsYjezBgVQV3M7RIbiOE
TPT4wKtc4Yxt7phCzNSm5yF8SX9io2+LDh4OVRlLwsZEn6xhI1pWQB4l2ggpNXBvbBIZVQg8
4uXz/b2pdWTsepkMQxSdYV9hNFAX5dz97+fu8PyzV/w8XF535/1/0DvE94t/ZVHU5lkWFnth
K99ejqd/+fvz5bT//onXnGpHXH86tAfs6282IdrIXrfn3R8RkO1eetHx+NH7b+jC//T+art4
VrpIXzsHyZjXHgAzJp7O/9/XXEvP3Rwpwut+/Dwdz8/Hjx30pTk+ld6iBaffoe0gjmTKbEAj
HWSPCNUmL5whOX4X1sj4rR/HAqYdx/ONW9gg6bMcSDnYFo95SmwccbYa9NU+1ADdXlCfFvJ5
NGVwR3+5AE2BaN3doysP7N327fKqCCwN9HTp5dvLrhcfD/uLPhnzwHHYCAWJcTT+MuhbrNmg
RpFiheyrFaTaW9nXz/f9y/7yk101sc3X4fSXJVWXliji97n7MxKRjVXE1HKly7KwVe9G+Zuu
lxpGjv5lubJpAtcQRDQ2OS0gbDKjxgdLVgc84oL+au+77fnztHvfgaz7CQNoWEadvrFRnJEJ
olJpqG2LkNkW4XVbtJsiLSZjUmOzhmh1Lhsotb/FGzVLdpiscW+MxN4gBnIVQYQvBcFJXlER
j/xi0wVnJbkGd6O9KhwQ7ebG1KgN4LjTmlcq9GqWl15+oprh2dAz/D9htQ4szfazQrNEhxgY
4RbsQmEeOx6X+cV00O94EJHTEWufXlpa5jWEsGzdiwe2peaHRQBV6AEyYHNxe+g0PSSPjkZD
MiqLzHazPntPI1Hw6f2+ektyDxq9hcXbdE1KSP1FZE/7FlsiipDQQmoCZrEilmoZV7N4KfBM
qy79Z+FiZSbOOS3L+9QPu8y1GrrRGhaC43HnCjBqYOuaGQshilqQpK4ls3W2LaZZCUuEFy0z
6Klwo2crt4WWNaAKK0Aclj+Wd4MBqWVTVqt1WNhDBqSl1WvB2lleesXAsTj/JoEZq4buem5L
mMehasUTgAn5BgSNx9zsAMYZDshsrIqhNbE5N7a1l0R0MiRENXOug1hYZ3SImrlwHY0slck/
wXTZNo1wo2xGuuxsfxx2F2nFZxjQHaYDVA4T/E0WhXvXn075OrHyLip2FyTthgLuUPBUChoG
5S4GpNCRsneQOijTOMD0MQPifhrH3mBoOxxTqjm9eBV/4dT08xaauY5qFtIy9obkplpDaEtY
Q9JE0zUyjwcWrVFOMV35cClRs0cadyxuGcgF8vl22X+87f4htgphm6FFVAhhLcQ8v+0Pxtq6
SmmKgSjxojBpp+82/5S3zVWelk26MeVwZl4p3tk40ff+6J0v28MLaJiHHf2gZS485vlra5GJ
IV9lJTFkKQQlerhjadOGoGu9PRbzgrOG8T2s5YMDCNKgF7/Afz8+3+DfH8fzHhVHbmDF2eZU
War5ELZs4NetEV3u43gBIWfP3M0PbZV9+gWwIHr3MXTUeCkBUIUACVCvWLzM6ZMLFQBYlJki
CPhrhx3D6tN4yDKLUCu5aXPQPpD9eJgTVfqO4mxq9XntjD4iNfvT7ozSIsNjZ1l/1I+VEJJZ
nNlUXsffunwuYPSOP1rCoaAoo35WDDr4pcggoGAydd5CL8NRJFpsZKnZy+Vv2qUaRll2Fg3o
g8VwpF1tCUgH16qRtE2ADcb69gNmbGSSvK6BIa/gLjO7PyJ6+VPmglQ6YleLMYdX2f2AuU/M
qS0G0zo9s3oCE+J6dRz/2b+jFoib8mWP+/+ZWStCvhyqvjBR6Ls5ZsMKqjURpuOZZbM2wyxU
M9flc388dvrUlzaf9zvyf2/g7R3lcuEhvtbOOhoOor5Rr0EZ1psfX7t+no9vGOn1S98Cu5hq
NnO7sGy9061/6M1m5cGxe/9Agx27eQWn7buYbCIm+TLRnDudcGsOWF4YVyJLR+qlKy2oX9mi
2CRvx4020/7I4qdIItmZL2PQkBQbmvhNNlIJhxMrwguETcUqdzOwJnqp1uYsYwbt+mhScmmj
1nGg5iWGn73Zaf/yg/FWRNISlAhHOSgQNnfvAvL8cXt64R4PkRoU1aFK3eUbSWI44Yc8wilI
S5uDICxINy+1R0UU6oSI0KJFvAjnNSvAlg+8D0qNqyKaEkEKX/l97/l1/8Hk4Mvv0Stdkeqh
n2rkCMYg5W7VxK40opXeYNtehtl/ZjR8dpZixuoy80Jj77UCqajqHmapx1eWAW4elOiAWOZp
FKnymMTMci8uyll9V6xjZfHPBSktIjFYukFEchpjli0fe8Xn97NwwL0OWFNikuQsUYBVHIIG
4BP0zIuruzRxRZaY+snrvMEzdQKKqkzznC8arFLRxlVMEYJY6lIcrrww3kzi+zo3CnlzHG6C
6NrnjjdnG7eyJ0ksUtTQ5lsUfpvxXcIdaMUmhhNvd7NsmSZBFfvxaKTKGIhNvSBK8RI199XM
p4iqk66yL5WTHWgJL64nDJnXtlFMtURS+8Wq9y38oCmyEBBlRFrIXTNOzz28nI77F2K4Tvw8
DX22bw15K7OpSWsTYEux9lPnPjUQ3XIK320T8SwfepfT9lmIGjoHKFSuBD9kXVK8AibFvloE
vLEqKUJcshGhAYBFuso9NniUI2vDhjlFSUxoSfJYN7COMLIWvSiVeJMWWnQ0BovqVmNZGbKP
MSGcjUHfHPimVaxxqbLdEtlsBtqvngHPQIk0ile8KJYZL/KWsDAusDQKb83LEi1dW5+Tv5Jv
6UDzdvodbq4tEdbG3aS2dn2A2Fke+gvzS+d5EDwFBrbuVIY6v5SVcq29PFiQjOPpnIcLoD+P
jDECWDWP+cXaErhzPqqxJeCX5JwWvYWfTTrXKtHSRCokdQ5kGlOgIEgmYQUucyPpLyy0ECOK
nAUYP8BJqZguHMZ7c72kUAw8TGacFTqkLcZTW1nhNbCwHNWDDaFawARA2sBI05xkhluF1FCO
v1EA6coBUERhrMknCJIOjV6Zc9KHsPfAv5PAUzaeh3nLqe0HRLzqfuX6Ppv4K25SRTYmAipj
SgeE/RtIyeJwUoVUF3U70OvmBXoik4wSCEqLEEbXUwSfYIMRgOrZ0ECqGQY1Vqkax40h4xWC
pT6oyPWJj+6aj4SCXasVSCD5Y0Zz/gN4DZKReq/agloxWVmFDWq2CmHJJegbnriYs4+7upgX
Rvh6C1CYtACJZANcG675SAOrcxNgsAums4QP4w0K96u05EKhMGXxvHAqdRIkTIKuL1xh9Qru
E1MYj8h91OivUKwLEOawKiu/o+gHR+tGDy6c4nOQpFO++p3yVJj4weZXRBsYZvFtvyKMg9L1
0uzRkJS87fPrTlnxc5DjvWVAl4cA3Thu60ak/H7efb4ce3/Bfrpup6ugmKceP+QCAzpR5IMo
fp24uyBP1IlsBK+rsr5aBGU0Y9tsE38vwoWblKgpuOrRJv9c10UjqpqfoGzNsJCpHmTaBe61
SVA+pPmdSqX2OBEv5J6bF4rhEH9V64H2JIKQ43B3rLkImBBJXRXjFPAO/We1dsh7DLdREPLz
TBFDvSBbapuhBomlwV0XSzTHIhtUEXgrwXUidxYQocAL2fHxUt+lu7qZOuW3wd0kkdFPgpf5
cKE7Rcpv52nWMWXqNTL8aBNdftmfj5PJcPqH9UWZv6gQBRtxFVbOgIt3ICSkAhvFjIcdmInq
+KRh7E4MMYZouF92c0K9KDUcZ8rSSDr7pV7/ahinE3PjW9g4II1k2tHwVHV9o5jOIZ8Ouj6N
RADRHoy1TwuLFFdSNel4wLKH3eMPyK4JEIld9Aebl/EuBioFm/ZQwQ/4r+j4OGPSGkTXjDX4
Md/elAdbHb2ynM6BGHaOxF0aTiqeX7RoTrFFJGhnVZ7Gat2MBuwFIIN5HBzE3pVaYaXF5Klb
hmxbj3kYRVxrCzeQcNJngQE9kEs90uBB+4xI6qkWkazCkmtRfGjI1o5qSEDYvCMJQhCxKufK
ovejmPww0qQnoZeqZa5qAOh5eQyC/JO4qW6TLCn2ibR6IGZWogzIaIfd8+cJr0eM1E9YlU0V
Vx5R4LtfYd5rQ5Kqa4DAPCJhDiI9m1AZi/AEvtZyLeYbcPhV+UtQKwJZ+EtzpaqPWD8OCmF7
LfPQ44w9DaUiAzTPPsD/3RmoIcs0vStMgjkDa2QgBkOSl5k9bYSnDV+xraXLXNXEFBUxRuBm
WD5FZC37NhoOB6MGvXTX0H0394MkkAnQUBiuMH2Qp6eBNMh4zR10OtRVpB2tw8zmliKzON4y
+cEyiDJWF2o/CVYmbKENOyw1rpqlaYkxsTfHpiH2wwIn7maDfiBCPn+nOXctyjGX3Hw3NLDi
vTvYAGi0RPV5FXzrdxIXoQ8rCyX0ZTULod3pLVIbFq/cU/DrKfhmD0cmeawlzqAYNG4lixVv
htNIYSGCAF/+YsoEqZuJ+jhCa4640SnTOH1MOxF4jye03qyEfV7mj9/svjO5SbzywxJL4X2z
+rbTRZnGQITrr8hQNYhSvFTq7kWYCEhwNQMEZUluqtsn4ItdWNVcYw1KTOuv8GZieJNOY/Md
BCDOwIeWPPvTSIEZFiAcdZQObx56dGPeU/c6++4cb7P0WwWdTOhc6UOCXIqlRDvXAkl5LCZB
lBOD6QvxVro+IZAZcK74dfKnW4zFpMGVzL7fIJXL5fdom5H/PWo+cguG7dsXjNt5Of778PXn
9n379e24ffnYH76et3/tgHL/8nV/uOx+4BH99bx72x8+//l6ft8+//31cnw//jx+3X58bE/v
x9PX7x9/fZFn+t3udNi99V63p5edcAe5nu1KKvHe/rBHV/P9f7Z1mFE7abC5gB0iq0gTwmQF
CtP14PmiJDztmHxJjOb3TtrGIMt3qUF3f1EbcqnLMa1ujcJF2piZvdPPj8ux94xVho6n3uvu
7UOEehFi+LwFSYJGwLYJD1yfBZqkxZ0XZkuVV2kI8xHKbRSgSZqrLO0KYwlNBtV0vLMnblfn
77LMpAag2YKXxgwpCNHugmm3hpsP0BTIlLoRDiot4WhNtZhb9iReRQYiWUU8kIYRSHgm/nKm
HIkXf5hFsSqXQdKGGmef39/2z3/8vfvZexYL88dp+/H6U7UrNhNWcAbhGumb6yPwPAbGEuZ+
4RpgYFvrwB4OrWnTV/fz8op+h8/by+6lFxxEh9Gp89/7y2vPPZ+Pz3uB8reXrbGjPLX6WDMT
DMxbghjk2v0sjR7rEAF9Wy3CwlLT9jcbKLgP18znLV3gQ+vmK2YiShKrW53NPs7MMfPmMxNW
5syK8ErWstd0Y8Y8EuVcMfMamTJvzmQX9XY2t14NatRD7ppbMVl2jzFm3yxX5uxgbud2KJfb
82vXSMKRa7IsDrjhBn0tKRtH2d35Yr4h9wY2M10INl+yYXnoLHLvAtscZQk3OQc0Xlp9P5yb
K5ltv3N8Y99hYENmZuMQ1q/wp2GT49S8IfYtGimkIEa8f9SVwh5yhqgrfmD3zb22dC0OCG1x
4KHFsVBAsOFYNTYemE2VIEnMUvOMKxe5TN2kv+MhG9IQJ8la9x+vNMNqw1vMSQdYRb00GkSy
mrGBtQ0+9xzmsVmUPnRU5mmWmRsHURQyPNlF04t2oaHguAWE8Bvz6zNfPBd/mbbulu6Ty2sE
zQSBkuiyNSI09s5w78A8LeGQz0i6+3ZtmPunDFymy+VDqg+2XAHH9w/0tyZybzsm88hVyzg3
3PopNWATh1t10RPvPXtFL29s56eibGvh5NvDy/G9l3y+f9+dmuB+rtNYGaDyMk4A9PPZQstQ
rWJqtqx3UuL4ZOUqiTwMTYQB/DPEOgJoBEizRwMrU/czMneD4MXgFtspV7cUOXVE0NEort9c
2mge6h4LofKHyVxXNN72309bUGxOx8/L/sAclRiuy/EdAZcsxETUJ5SZlt2kYXFyG958XJLw
qFY2vN2CKkKaaI71ILw5NUHkRVuYdYvk1us7T9/r190QM5Go40BbEq/fp18oAnhUiozTHedl
Jw4Ork7coLr15KDqfBYGvUEY51mN4oyCmDCb5S1C8OlqUQhjXW22HVpjOUk91aiB5fSZKxaH
su+Yq1X4woWljHzuQlVekmBNKo4JAhGXrtukQoPZxuvI5qjQeR6IML8icuMoXYRetdh0ZIcs
HuM4wAsPcUmC1RPMEw7zCPwltLWzqGB03v84yJCJ59fd89/7ww/FZVf4ciiF1etLHMU2qVOI
icd/ffvyRfGX+Y23Nk3OwsTNH2UZ6vm3NleBwS+vl0xul7PYDCYywJINyqnduNAnQVmtylC1
XjeoeZj48L8cK3nS+z0vzX1W5BaON+hd5cXZxltKt5M8ICqBB7MMhx0BWSNKYSoSXhWWq4o+
pWUwkPupvuXrWESCJAq9YPbI5RcgBA7Tups/gPBzo3EYqS7siAuD97RDzFOrgYUzU5HzFN1e
19xyN/HTWBmFKwpEMRSOtdBDhKJ3rw5/QgYP5zWV9J7kwdRAr0xewOdR6bFW3KeUeTNCuTeD
9Mf3CMQ+phkB5ug3TwhWeykh1WbCCfw1UoQlqA5QNTx0Rw7Tlpvzdv0rulyuYr5IcU1TZG7O
pneU6Jn3J/NefYHX2Os4VIsnNchIQcwAYbMYGHmTB6g3pc0iC0Sh8SglipYKxTtrdUcTHLxR
xQlX37UbVai8XsFuUaRe6JbhOoBhzF01UZBbYBLsKyARzYvM2FUUJCQEQeAQgXfEKKSq70Bm
hThZ7aoaOZLNqWh82TzFiAkkXCXtbbwyhIAQdXGIh2/xEKZlRMxa4lUY+NNR3LdYRHK8ldER
RT3kDbLCBLJVlZPKq/69YptdRCl5L/5m+WIzRrCfiZoSPVWlqybPye9RXlReEWchSa/jhzH5
DT/mvjKWaeiLqICiVHPzixEWNykPbqS6DCDIDzJaGQ9dGJJFB4NvQ3y185Fe+DTnuoB+nPaH
y98y7vV9d/5hunh4MpYGr1sjvC1v7wTGnRT3qzAov7UXs/WFo9mCo3zXYzxL4cSpgjxPXD0a
ov6wzs62+vr+bffHZf9eSxJnQfos4Sfl05Q7OLwRRZ2MWRJBIq4I4hWaVPBm/zo58xz6WD24
eUIvq2F2Mti2GCKlFtTNQXEUbQFK2cMB3kijszPMtbqwZK+KwBMuO3FYxC4p2a1jREeqNIke
9Tbkrn0I3DtRPQH2zDfF0+e3R+y/1II+9ULyd98/f/zAe7bwcL6cPjELFS3h7aJ8CkIhW2as
7l/BsJrVrHATkDJA9AbtriJDI3DqhpDEZc4W3pXIGVa7KbQ2hCuzDrvxTgCFiySWpiajctHN
MaGfjD7dgTHZdW/Uq9e2MSUOGLdRsCkx26567sg2ENuwTm2Ft6hmUddbkD2UxVvS/6vsWHaj
hoG/0iMHVLUIcc8mThM2j23ibcppVcEKIQRUtEV8PvNwHI89CXBbeSZeP8Yz43l56ozutybw
oa/HvtM17eUvT0Lr5fahLzKbnaRixqB+9x4oe0yH7wBb/FsilixHV7qhIit6/INExFisf0Ab
8iMd5r8OC84giq0lh0fFklu0WDccW2hCqUSxXY6wWtM2cNLjbv/Wjq/FwH72DQcWXb+7urqK
Z+pxvYu+LDcWxqNjdga+86A7/92EKIrgiCJCjyQB3ls4LAw0Ila80d+dFh02h77guzgUdKCc
EWaQqCRpRjxaaeJR+2wMo00jAHqmpP6S58TWGJqYo7iZpgdbHQc7LEwgWbYqer+RXWGIf9H/
eHx6fYHlVV8emaVXD98/hwUF8KVXjLvohb4mml0A27UE4tnpj3aJa+PHEk4VZkbbbBRkxrTi
Qf7j6zf+cx/SF6Ad5Du0qyjxCKdbkIQgD4temHGRY9AdPA598xlxW2vGEbAgHT+9oEgMufIS
WKKAJeXhzPfGyNInju6AV7UH/wwRjiAQJK+eHr98R4c0DO7by/P59xl+nJ8/Xl5ehm8AY3Id
dXdD6qF/ii/MPbrbyqWjHvBukPBrCxqQNfehKdZRoHuqMJFlOvo0MQQ4WD/JAFb3T9No2uQz
Glh0oiimzBw0VKUZbm4taiKN0T/BFSP/QPoALf05XPwwGzASWct0FjPDooL/xyYKhd9iGlPw
J6jYweTh0oXeL+CDbN1IudeepccKQ/jK+smnh+eHC1RMPqK5LeAHbjHqVCYftMYxIWJKXqz5
LfD52KJIg6suSvu8p8plUa20zbHFE8wHmH9n66xJKx6AANbUpWjjfIcor4Hbl4kJQWCEXysH
BlFQXJDu7jnbm+sQPu+m6NfcjhvZhHIq8SIAh2OVfkieLF+MbDCoCjhmw7LVmrmCiXbrpWJx
MMghkmflseM7xjb0BvTuSscpPsA9Dg2oEUkrwNNU2wqvxmP8PwxuSWECBDS5RihYSIU2ADFB
K+1s0gkHFctGnDh3uwB4GhRhHI2Zh5FLZkcX8fhxO3pRjvAFp8cdAL0dDSJ4X4sXLOiKWN0E
iKFlI+lvtkzFHTnEQADMF9aEFFGqItXO3+iB/pIM1iL9kUmuIzgBhwYUWp6Vh9eH2xG0yn/o
SEERqmJCjlOT2aTV0ZajnzEhg7EDPbCS1pcI5FVG3C01lwX/YQcsG/YcBHCJxSSEaiJghkJp
9exgAmddhxUnMfaZvjPiquSx4DTM8JVBEbktXcjB+IVakkLQmePqRa6Ut6OZMvHXXSyIQiQ6
oqedgX9qs0FkK4SnwCOsLqtBeykaNOXL8zd5f+eXIuY9854njoEZYDPg+YdEYCynWuLosiOY
xhryTK8ZvhcRGkypYRbmwvDHkKouhkxPn3cYh7ooV0LyGeFuO1u8MFTOpx6ZE8l6HpxB5XAS
MfyEblxNDtPCwQEvm+xm1LRT9h7b4thq58hkQ+OcgPtQf4j+LzRz2vPTM2peqMfnP36dfz58
PofGqf2xW/FRzZoMWiKpLux7trbp/JEuOCpOvK57IMzkTghXP6RXXiBZ2QnxNbUDRBZxbaAo
JDQZtNPsCyuUQ7774PkdYcm1w4QImDdWGSFxjPtEcKtZQaUTtKoY7dCLEWnLwvsRJSCGzo/k
6LHy/u7ttk+ThluZ+5iAJIIznrMnQeWNDmvMw/Ajat1Ds5VFX6idXdNrfe1qyy4K+RE0A4k1
msGI4MdjXUT/fz87gGRPWOWijApqhPABfaPW5cGJxWKfqeytLvScH3KCw6B1tiz7KOuhhWuL
bsvh2RWmybSqb0yLps1BXCe0aMmzH/qmZvTYnANNq76RTfaQZJKwq+QPIOcV2WnwAQA=

--r5Pyd7+fXNt84Ff3--

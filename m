Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C606447125
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 02:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhKGBeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 21:34:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:45919 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhKGBeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 21:34:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10160"; a="318278492"
X-IronPort-AV: E=Sophos;i="5.87,215,1631602800"; 
   d="gz'50?scan'50,208,50";a="318278492"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2021 18:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,215,1631602800"; 
   d="gz'50?scan'50,208,50";a="668628504"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 06 Nov 2021 18:31:36 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mjX20-0009wk-4L; Sun, 07 Nov 2021 01:31:36 +0000
Date:   Sun, 7 Nov 2021 09:30:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [vbabka:slab-struct_slab-v1r8 33/33] mm/slub.c:5274:49: error:
 'struct slab' has no member named 'slabs'
Message-ID: <202111070918.sn3oMhm2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git slab-struct_slab-v1r8
head:   1992ba7f38390cfa8290baf300243b7cf3bb6b44
commit: 1992ba7f38390cfa8290baf300243b7cf3bb6b44 [33/33] mm/sl*b: Differentiate struct slab fields by sl*b implementations
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/commit/?id=1992ba7f38390cfa8290baf300243b7cf3bb6b44
        git remote add vbabka https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git
        git fetch --no-tags vbabka slab-struct_slab-v1r8
        git checkout 1992ba7f38390cfa8290baf300243b7cf3bb6b44
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/slub.c: In function 'show_slab_objects':
>> mm/slub.c:5274:49: error: 'struct slab' has no member named 'slabs'
    5274 |                                         x = slab->slabs;
         |                                                 ^~
   mm/slub.c: In function 'slabs_cpu_partial_show':
   mm/slub.c:5481:38: error: 'struct slab' has no member named 'slabs'
    5481 |                         slabs += slab->slabs;
         |                                      ^~
>> mm/slub.c:5482:42: error: 'struct slab' has no member named 'pobjects'; did you mean 'objects'?
    5482 |                         objects += slab->pobjects;
         |                                          ^~~~~~~~
         |                                          objects


vim +5274 mm/slub.c

81819f0fc8285a Christoph Lameter 2007-05-06  5230  
62e5c4b4d63517 Cyrill Gorcunov   2008-03-02  5231  static ssize_t show_slab_objects(struct kmem_cache *s,
81819f0fc8285a Christoph Lameter 2007-05-06  5232  				 char *buf, unsigned long flags)
81819f0fc8285a Christoph Lameter 2007-05-06  5233  {
81819f0fc8285a Christoph Lameter 2007-05-06  5234  	unsigned long total = 0;
81819f0fc8285a Christoph Lameter 2007-05-06  5235  	int node;
81819f0fc8285a Christoph Lameter 2007-05-06  5236  	int x;
81819f0fc8285a Christoph Lameter 2007-05-06  5237  	unsigned long *nodes;
bf16d19aabd8f5 Joe Perches       2020-12-14  5238  	int len = 0;
81819f0fc8285a Christoph Lameter 2007-05-06  5239  
6396bb221514d2 Kees Cook         2018-06-12  5240  	nodes = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
62e5c4b4d63517 Cyrill Gorcunov   2008-03-02  5241  	if (!nodes)
62e5c4b4d63517 Cyrill Gorcunov   2008-03-02  5242  		return -ENOMEM;
81819f0fc8285a Christoph Lameter 2007-05-06  5243  
205ab99dd103e3 Christoph Lameter 2008-04-14  5244  	if (flags & SO_CPU) {
205ab99dd103e3 Christoph Lameter 2008-04-14  5245  		int cpu;
205ab99dd103e3 Christoph Lameter 2008-04-14  5246  
81819f0fc8285a Christoph Lameter 2007-05-06  5247  		for_each_possible_cpu(cpu) {
d0e0ac9772f8ec Chen Gang         2013-07-15  5248  			struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab,
d0e0ac9772f8ec Chen Gang         2013-07-15  5249  							       cpu);
ec3ab083a7a004 Christoph Lameter 2012-05-09  5250  			int node;
184d9494c1a4f5 Vlastimil Babka   2021-11-03  5251  			struct slab *slab;slab = READ_ONCE(c->slab);
184d9494c1a4f5 Vlastimil Babka   2021-11-03  5252  			if (!slab)
ec3ab083a7a004 Christoph Lameter 2012-05-09  5253  				continue;
ec3ab083a7a004 Christoph Lameter 2012-05-09  5254  
184d9494c1a4f5 Vlastimil Babka   2021-11-03  5255  			node = slab_nid(slab);
205ab99dd103e3 Christoph Lameter 2008-04-14  5256  			if (flags & SO_TOTAL)
184d9494c1a4f5 Vlastimil Babka   2021-11-03  5257  				x = slab->objects;
205ab99dd103e3 Christoph Lameter 2008-04-14  5258  			else if (flags & SO_OBJECTS)
184d9494c1a4f5 Vlastimil Babka   2021-11-03  5259  				x = slab->inuse;
81819f0fc8285a Christoph Lameter 2007-05-06  5260  			else
81819f0fc8285a Christoph Lameter 2007-05-06  5261  				x = 1;
205ab99dd103e3 Christoph Lameter 2008-04-14  5262  
81819f0fc8285a Christoph Lameter 2007-05-06  5263  			total += x;
bc6697d8a506de Eric Dumazet      2011-11-22  5264  			nodes[node] += x;
49e2258586b423 Christoph Lameter 2011-08-09  5265  
184d9494c1a4f5 Vlastimil Babka   2021-11-03  5266  			slab = slub_percpu_partial_read_once(c);
184d9494c1a4f5 Vlastimil Babka   2021-11-03  5267  			if (slab) {
184d9494c1a4f5 Vlastimil Babka   2021-11-03  5268  				node = slab_nid(slab);
8afb1474db4701 Li Zefan          2013-09-10  5269  				if (flags & SO_TOTAL)
8afb1474db4701 Li Zefan          2013-09-10  5270  					WARN_ON_ONCE(1);
8afb1474db4701 Li Zefan          2013-09-10  5271  				else if (flags & SO_OBJECTS)
8afb1474db4701 Li Zefan          2013-09-10  5272  					WARN_ON_ONCE(1);
8afb1474db4701 Li Zefan          2013-09-10  5273  				else
184d9494c1a4f5 Vlastimil Babka   2021-11-03 @5274  					x = slab->slabs;
49e2258586b423 Christoph Lameter 2011-08-09  5275  				total += x;
bc6697d8a506de Eric Dumazet      2011-11-22  5276  				nodes[node] += x;
49e2258586b423 Christoph Lameter 2011-08-09  5277  			}
81819f0fc8285a Christoph Lameter 2007-05-06  5278  		}
81819f0fc8285a Christoph Lameter 2007-05-06  5279  	}
81819f0fc8285a Christoph Lameter 2007-05-06  5280  
e4f8e513c3d353 Qian Cai          2019-10-14  5281  	/*
e4f8e513c3d353 Qian Cai          2019-10-14  5282  	 * It is impossible to take "mem_hotplug_lock" here with "kernfs_mutex"
e4f8e513c3d353 Qian Cai          2019-10-14  5283  	 * already held which will conflict with an existing lock order:
e4f8e513c3d353 Qian Cai          2019-10-14  5284  	 *
e4f8e513c3d353 Qian Cai          2019-10-14  5285  	 * mem_hotplug_lock->slab_mutex->kernfs_mutex
e4f8e513c3d353 Qian Cai          2019-10-14  5286  	 *
e4f8e513c3d353 Qian Cai          2019-10-14  5287  	 * We don't really need mem_hotplug_lock (to hold off
e4f8e513c3d353 Qian Cai          2019-10-14  5288  	 * slab_mem_going_offline_callback) here because slab's memory hot
e4f8e513c3d353 Qian Cai          2019-10-14  5289  	 * unplug code doesn't destroy the kmem_cache->node[] data.
e4f8e513c3d353 Qian Cai          2019-10-14  5290  	 */
e4f8e513c3d353 Qian Cai          2019-10-14  5291  

:::::: The code at line 5274 was first introduced by commit
:::::: 184d9494c1a4f53fc10a008317b03911a85597c3 mm/slub: mass conversion of struct page to struct slab by spatch

:::::: TO: Vlastimil Babka <vbabka@suse.cz>
:::::: CC: Vlastimil Babka <vbabka@suse.cz>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tThc/1wpZn/ma/RB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
3vNdVubj/wOlDpw+dawAAA==

--tThc/1wpZn/ma/RB--

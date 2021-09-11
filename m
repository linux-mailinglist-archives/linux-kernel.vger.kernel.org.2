Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F62D407A72
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 23:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhIKVKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 17:10:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:23173 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhIKVKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 17:10:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10104"; a="243669985"
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="gz'50?scan'50,208,50";a="243669985"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2021 14:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="gz'50?scan'50,208,50";a="608134085"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2021 14:09:23 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mPAFW-0005qZ-7L; Sat, 11 Sep 2021 21:09:22 +0000
Date:   Sun, 12 Sep 2021 05:08:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <cong.wang@bytedance.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 3/3] kernel/bpf/priority_queue_map.c:77:11: error:
 'struct bpf_priority_queue' has no member named 'size'
Message-ID: <202109120530.ra4FQyh9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/congwang/linux.git sch_bpf
head:   f69c4127564dd6abacf52f9e5e2479de874493d9
commit: f69c4127564dd6abacf52f9e5e2479de874493d9 [3/3] bpf: introduce priority queue based map
config: powerpc-ppc64_defconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/f69c4127564dd6abacf52f9e5e2479de874493d9
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout f69c4127564dd6abacf52f9e5e2479de874493d9
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/priority_queue_map.c: In function 'priority_queue_map_alloc':
>> kernel/bpf/priority_queue_map.c:77:11: error: 'struct bpf_priority_queue' has no member named 'size'
      77 |         pq->size = (u64) attr->max_entries + 1;
         |           ^~
>> kernel/bpf/priority_queue_map.c:80:11: error: 'struct bpf_priority_queue' has no member named 'elem_size'
      80 |         pq->elem_size = sizeof(struct bpf_priority_queue_node ) +
         |           ^~
   kernel/bpf/priority_queue_map.c: In function 'priority_queue_map_peek':
>> kernel/bpf/priority_queue_map.c:111:9: error: 'ptr' undeclared (first use in this function)
     111 |         ptr = n->key + pq->map.key_size;
         |         ^~~
   kernel/bpf/priority_queue_map.c:111:9: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/bpf/priority_queue_map.c:100:13: error: unused variable 'key_size' [-Werror=unused-variable]
     100 |         u32 key_size = map->key_size;
         |             ^~~~~~~~
   kernel/bpf/priority_queue_map.c: In function 'priority_queue_map_pop_elem':
   kernel/bpf/priority_queue_map.c:133:9: error: 'ptr' undeclared (first use in this function)
     133 |         ptr = n->key + pq->map.key_size;
         |         ^~~
   kernel/bpf/priority_queue_map.c:122:13: error: unused variable 'key_size' [-Werror=unused-variable]
     122 |         u32 key_size = map->key_size;
         |             ^~~~~~~~
   kernel/bpf/priority_queue_map.c: At top level:
>> kernel/bpf/priority_queue_map.c:152:33: error: no previous prototype for 'alloc_priority_queue_node' [-Werror=missing-prototypes]
     152 | struct bpf_priority_queue_node *alloc_priority_queue_node(struct bpf_priority_queue *pq)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/priority_queue_map.c: In function 'alloc_priority_queue_node':
   kernel/bpf/priority_queue_map.c:154:49: error: 'struct bpf_priority_queue' has no member named 'elem_size'
     154 |         return bpf_map_kmalloc_node(&pq->map, pq->elem_size,
         |                                                 ^~
   kernel/bpf/priority_queue_map.c: In function 'priority_queue_map_update_elem':
>> kernel/bpf/priority_queue_map.c:166:23: error: 'flags' redeclared as different kind of symbol
     166 |         unsigned long flags;
         |                       ^~~~~
   kernel/bpf/priority_queue_map.c:161:57: note: previous definition of 'flags' with type 'u64' {aka 'long long unsigned int'}
     161 |                                        void *value, u64 flags)
         |                                                     ~~~~^~~~~
   kernel/bpf/priority_queue_map.c:165:13: error: unused variable 'key_size' [-Werror=unused-variable]
     165 |         u32 key_size = map->key_size;
         |             ^~~~~~~~
   kernel/bpf/priority_queue_map.c: In function 'alloc_priority_queue_node':
   kernel/bpf/priority_queue_map.c:157:1: error: control reaches end of non-void function [-Werror=return-type]
     157 | }
         | ^
   cc1: all warnings being treated as errors


vim +77 kernel/bpf/priority_queue_map.c

    63	
    64	static struct bpf_map *priority_queue_map_alloc(union bpf_attr *attr)
    65	{
    66		int numa_node = bpf_map_attr_numa_node(attr);
    67		struct bpf_priority_queue *pq;
    68		u64 size, queue_size;
    69	
    70		queue_size = sizeof(*pq) + size * attr->value_size;
    71		pq = bpf_map_area_alloc(queue_size, numa_node);
    72		if (!pq)
    73			return ERR_PTR(-ENOMEM);
    74	
    75		memset(pq, 0, sizeof(*pq));
    76		bpf_map_init_from_attr(&pq->map, attr);
  > 77		pq->size = (u64) attr->max_entries + 1;
    78		raw_spin_lock_init(&pq->lock);
    79		pq_root_init(&pq->root, bpf_priority_queue_cmp);
  > 80		pq->elem_size = sizeof(struct bpf_priority_queue_node ) +
    81				  round_up(pq->map.key_size, 8) +
    82				  round_up(pq->map.value_size, 8);
    83		return &pq->map;
    84	}
    85	
    86	/* Called when map->refcnt goes to zero, either from workqueue or from syscall */
    87	static void priority_queue_map_free(struct bpf_map *map)
    88	{
    89		struct bpf_priority_queue *pq = bpf_priority_queue(map);
    90	
    91		pq_flush(&pq->root, NULL);
    92		bpf_map_area_free(pq);
    93	}
    94	
    95	/* Called from syscall or from eBPF program */
    96	static int priority_queue_map_peek(struct bpf_map *map, void *value)
    97	{
    98		struct bpf_priority_queue *pq = bpf_priority_queue(map);
    99		struct bpf_priority_queue_node *n;
 > 100		u32 key_size = map->key_size;
   101		struct pq_node *node;
   102		unsigned long flags;
   103	
   104		raw_spin_lock_irqsave(&pq->lock, flags);
   105		node = pq_top(&pq->root);
   106		if (!node) {
   107			raw_spin_unlock_irqrestore(&pq->lock, flags);
   108			return -ENOENT;
   109		}
   110		n = container_of(node, struct bpf_priority_queue_node, node);
 > 111		ptr = n->key + pq->map.key_size;
   112		memcpy(value, ptr, pq->map.value_size);
   113		raw_spin_unlock_irqrestore(&pq->lock, flags);
   114		return 0;
   115	}
   116	
   117	/* Called from syscall or from eBPF program */
   118	static int priority_queue_map_pop_elem(struct bpf_map *map, void *value)
   119	{
   120		struct bpf_priority_queue *pq = bpf_priority_queue(map);
   121		struct bpf_priority_queue_node *n;
   122		u32 key_size = map->key_size;
   123		struct pq_node *node;
   124		unsigned long flags;
   125	
   126		raw_spin_lock_irqsave(&pq->lock, flags);
   127		node = pq_pop(&pq->root);
   128		if (!node) {
   129			raw_spin_unlock_irqrestore(&pq->lock, flags);
   130			return -ENOENT;
   131		}
   132		n = container_of(node, struct bpf_priority_queue_node, node);
   133		ptr = n->key + pq->map.key_size;
   134		memcpy(value, ptr, pq->map.value_size);
   135		raw_spin_unlock_irqrestore(&pq->lock, flags);
   136		return 0;
   137	}
   138	
   139	/* Called from syscall or from eBPF program */
   140	static int priority_queue_map_push_elem(struct bpf_map *map, void *value,
   141					     u64 flags)
   142	{
   143		return -EINVAL;
   144	}
   145	
   146	/* Called from syscall or from eBPF program */
   147	static void *priority_queue_map_lookup_elem(struct bpf_map *map, void *key)
   148	{
   149		return NULL;
   150	}
   151	
 > 152	struct bpf_priority_queue_node *alloc_priority_queue_node(struct bpf_priority_queue *pq)
   153	{
   154		return bpf_map_kmalloc_node(&pq->map, pq->elem_size,
   155					     GFP_ATOMIC | __GFP_NOWARN,
   156					     pq->map.numa_node);
   157	}
   158	
   159	/* Called from syscall or from eBPF program */
   160	static int priority_queue_map_update_elem(struct bpf_map *map, void *key,
   161					       void *value, u64 flags)
   162	{
   163		struct bpf_priority_queue *pq = bpf_priority_queue(map);
   164		struct bpf_priority_queue_node *n;
   165		u32 key_size = map->key_size;
 > 166		unsigned long flags;
   167	
   168		n = alloc_priority_queue_node(pq);
   169		if (!n)
   170			return -ENOMEM;
   171		raw_spin_lock_irqsave(&pq->lock, flags);
   172		pq_push(&pq->root, &n->node);
   173		raw_spin_unlock_irqrestore(&pq->lock, flags);
   174		return 0;
   175	}
   176	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2oS5YaxWCcQjTEyO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
vegB53mZs5XK/wZTcHWRvwEA

--2oS5YaxWCcQjTEyO--

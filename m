Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FC630CEF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhBBWdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:33:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:44009 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhBBWdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:33:24 -0500
IronPort-SDR: bNm2Er4FMwHoQAuLLq7X+vLvB/wK1T0NOjjzeDtewxVa+MPUnPdoGjqDaoOLf8d1nTps0zo+zZ
 TqJQ6lGOogMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="168053025"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="gz'50?scan'50,208,50";a="168053025"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 14:32:40 -0800
IronPort-SDR: tgRyAT69UKc7m7leRBssdEodvF8OiHZb4rs5IudUOTPiPYGoL9oScZ9cxz0QsdZoy85Vv591jy
 SaDOUAJQdjPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="gz'50?scan'50,208,50";a="370982353"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2021 14:32:38 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l74Dt-0009ii-L9; Tue, 02 Feb 2021 22:32:37 +0000
Date:   Wed, 3 Feb 2021 06:31:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [rcu:willy-maple 125/202] include/linux/maple_tree.h:79:22: error:
 'MAPLE_RANGE64_SLOTS' undeclared here (not in a function)
Message-ID: <202102030655.arrcFfTg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git willy-maple
head:   7e346d2845b4bd77663394f39fa70456e0084c86
commit: 824aa5e4af0be646da193e90e3383651b93f1c8d [125/202] Maple Tree: Add new data structure
config: m68k-randconfig-r006-20210202 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=824aa5e4af0be646da193e90e3383651b93f1c8d
        git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags rcu willy-maple
        git checkout 824aa5e4af0be646da193e90e3383651b93f1c8d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from lib/maple_tree.c:9:
>> include/linux/maple_tree.h:79:22: error: 'MAPLE_RANGE64_SLOTS' undeclared here (not in a function)
      79 |  unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
         |                      ^~~~~~~~~~~~~~~~~~~
>> include/linux/maple_tree.h:85:22: error: 'MAPLE_ARANGE64_SLOTS' undeclared here (not in a function)
      85 |  unsigned long pivot[MAPLE_ARANGE64_SLOTS - 1];
         |                      ^~~~~~~~~~~~~~~~~~~~
>> include/linux/maple_tree.h:91:28: error: 'MAPLE_NODE_SLOTS' undeclared here (not in a function); did you mean 'MAPLE_ALLOC_SLOTS'?
      91 | #define MAPLE_ALLOC_SLOTS (MAPLE_NODE_SLOTS - 1)
         |                            ^~~~~~~~~~~~~~~~
   include/linux/maple_tree.h:96:27: note: in expansion of macro 'MAPLE_ALLOC_SLOTS'
      96 |  struct maple_alloc *slot[MAPLE_ALLOC_SLOTS];
         |                           ^~~~~~~~~~~~~~~~~
   lib/maple_tree.c:40:19: warning: initialization of 'unsigned char' from 'const long unsigned int *' makes integer from pointer without a cast [-Wint-conversion]
      40 |  [maple_dense]  = MAPLE_NODE_SLOTS,
         |                   ^~~~~~~~~~~~~~~~
   lib/maple_tree.c:40:19: note: (near initialization for 'mt_slots[0]')
   lib/maple_tree.c:40:19: error: initializer element is not constant
   lib/maple_tree.c:40:19: note: (near initialization for 'mt_slots[0]')
   lib/maple_tree.c:41:21: warning: initialization of 'unsigned char' from 'const long unsigned int *' makes integer from pointer without a cast [-Wint-conversion]
      41 |  [maple_leaf_64]  = MAPLE_RANGE64_SLOTS,
         |                     ^~~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:41:21: note: (near initialization for 'mt_slots[1]')
   lib/maple_tree.c:41:21: error: initializer element is not constant
   lib/maple_tree.c:41:21: note: (near initialization for 'mt_slots[1]')
   lib/maple_tree.c:42:21: warning: initialization of 'unsigned char' from 'const long unsigned int *' makes integer from pointer without a cast [-Wint-conversion]
      42 |  [maple_range_64] = MAPLE_RANGE64_SLOTS,
         |                     ^~~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:42:21: note: (near initialization for 'mt_slots[2]')
   lib/maple_tree.c:42:21: error: initializer element is not constant
   lib/maple_tree.c:42:21: note: (near initialization for 'mt_slots[2]')
   lib/maple_tree.c:43:22: warning: initialization of 'unsigned char' from 'const long unsigned int *' makes integer from pointer without a cast [-Wint-conversion]
      43 |  [maple_arange_64] = MAPLE_ARANGE64_SLOTS,
         |                      ^~~~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:43:22: note: (near initialization for 'mt_slots[3]')
   lib/maple_tree.c:43:22: error: initializer element is not constant
   lib/maple_tree.c:43:22: note: (near initialization for 'mt_slots[3]')
   lib/maple_tree.c:49:21: warning: initialization of 'unsigned char' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
      49 |  [maple_leaf_64]  = MAPLE_RANGE64_SLOTS - 1,
         |                     ^~~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:49:21: note: (near initialization for 'mt_pivots[1]')
   lib/maple_tree.c:49:21: error: initializer element is not constant
   lib/maple_tree.c:49:21: note: (near initialization for 'mt_pivots[1]')
   lib/maple_tree.c:50:21: warning: initialization of 'unsigned char' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
      50 |  [maple_range_64] = MAPLE_RANGE64_SLOTS - 1,
         |                     ^~~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:50:21: note: (near initialization for 'mt_pivots[2]')
   lib/maple_tree.c:50:21: error: initializer element is not constant
   lib/maple_tree.c:50:21: note: (near initialization for 'mt_pivots[2]')
   lib/maple_tree.c:51:22: warning: initialization of 'unsigned char' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
      51 |  [maple_arange_64] = MAPLE_ARANGE64_SLOTS - 1,
         |                      ^~~~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:51:22: note: (near initialization for 'mt_pivots[3]')
   lib/maple_tree.c:51:22: error: initializer element is not constant
   lib/maple_tree.c:51:22: note: (near initialization for 'mt_pivots[3]')
   lib/maple_tree.c:56:36: error: invalid operands to binary / (have 'const unsigned char *' and 'int')
      56 |  [maple_dense]  = MAPLE_NODE_SLOTS / 2,
         |                   ~~~~~~~~~~~~~~~~ ^
         |                   |
         |                   const unsigned char *
   lib/maple_tree.c:56:19: warning: initialization of 'unsigned char' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
      56 |  [maple_dense]  = MAPLE_NODE_SLOTS / 2,
         |                   ^~~~~~~~~~~~~~~~
   lib/maple_tree.c:56:19: note: (near initialization for 'mt_min_slots[0]')
   lib/maple_tree.c:56:19: error: initializer element is not constant
   lib/maple_tree.c:56:19: note: (near initialization for 'mt_min_slots[0]')
   lib/maple_tree.c:57:42: error: invalid operands to binary / (have 'const unsigned char *' and 'int')
      57 |  [maple_leaf_64]  = (MAPLE_RANGE64_SLOTS / 2) - 2,
         |                      ~~~~~~~~~~~~~~~~~~~ ^
         |                      |
         |                      const unsigned char *
   lib/maple_tree.c:57:21: warning: initialization of 'unsigned char' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
      57 |  [maple_leaf_64]  = (MAPLE_RANGE64_SLOTS / 2) - 2,
         |                     ^
   lib/maple_tree.c:57:21: note: (near initialization for 'mt_min_slots[1]')
   lib/maple_tree.c:57:21: error: initializer element is not constant
   lib/maple_tree.c:57:21: note: (near initialization for 'mt_min_slots[1]')
   lib/maple_tree.c:58:42: error: invalid operands to binary / (have 'const unsigned char *' and 'int')
      58 |  [maple_range_64] = (MAPLE_RANGE64_SLOTS / 2) - 2,
         |                      ~~~~~~~~~~~~~~~~~~~ ^
         |                      |
         |                      const unsigned char *
   lib/maple_tree.c:58:21: warning: initialization of 'unsigned char' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
      58 |  [maple_range_64] = (MAPLE_RANGE64_SLOTS / 2) - 2,
         |                     ^
   lib/maple_tree.c:58:21: note: (near initialization for 'mt_min_slots[2]')
   lib/maple_tree.c:58:21: error: initializer element is not constant
   lib/maple_tree.c:58:21: note: (near initialization for 'mt_min_slots[2]')
   lib/maple_tree.c:59:44: error: invalid operands to binary / (have 'const unsigned char *' and 'int')
      59 |  [maple_arange_64] = (MAPLE_ARANGE64_SLOTS / 2) - 1,
         |                       ~~~~~~~~~~~~~~~~~~~~ ^
         |                       |
         |                       const unsigned char *
   lib/maple_tree.c:59:22: warning: initialization of 'unsigned char' from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
      59 |  [maple_arange_64] = (MAPLE_ARANGE64_SLOTS / 2) - 1,
         |                      ^
   lib/maple_tree.c:59:22: note: (near initialization for 'mt_min_slots[3]')
   lib/maple_tree.c:59:22: error: initializer element is not constant
   lib/maple_tree.c:59:22: note: (near initialization for 'mt_min_slots[3]')
   lib/maple_tree.c:63:51: error: invalid operands to binary * (have 'const unsigned char *' and 'int')
      63 | #define MAPLE_BIG_NODE_SLOTS (MAPLE_RANGE64_SLOTS * 2 + 2)
         |                               ~~~~~~~~~~~~~~~~~~~ ^
         |                               |
         |                               const unsigned char *
   lib/maple_tree.c:67:27: note: in expansion of macro 'MAPLE_BIG_NODE_SLOTS'
      67 |  struct maple_enode *slot[MAPLE_BIG_NODE_SLOTS];
         |                           ^~~~~~~~~~~~~~~~~~~~
   lib/maple_tree.c:67:22: error: size of array 'slot' has non-integer type


vim +/MAPLE_RANGE64_SLOTS +79 include/linux/maple_tree.h

    40	
    41	
    42	/**
    43	 * maple_tree node explained
    44	 *
    45	 * Each node type has a number of slots for entries and a number of slots for
    46	 * pivots.  In the case of dense nodes, the pivots are implied by the position
    47	 * and are simply the slot index + the minimum of the node.
    48	 *
    49	 * In regular B-Tree terms, pivots are called keys.  The term pivot is used to
    50	 * indicate that the tree is specifying ranges,  Pivots may appear in the
    51	 * subtree with an entry attached to the value where as keys are unique to a
    52	 * specific position of a B-tree.  Pivot values are inclusive of the slot with
    53	 * the same index.
    54	 *
    55	 *
    56	 * The following illustrates the layout of a range64 nodes slots and pivots.
    57	 *
    58	 *           _________________________________
    59	 *  Slots -> | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
    60	 *           ┬   ┬   ┬   ┬   ┬   ┬   ┬   ┬   ┬
    61	 *           │   │   │   │   │   │   │   │   └─ Implied maximum
    62	 *           │   │   │   │   │   │   │   └─ Pivot 6
    63	 *           │   │   │   │   │   │   └─ Pivot 5
    64	 *           │   │   │   │   │   └─ Pivot 4
    65	 *           │   │   │   │   └─ Pivot 3
    66	 *           │   │   │   └─ Pivot 2
    67	 *           │   │   └─ Pivot 1
    68	 *           │   └─ Pivot 0
    69	 *           └─  Implied minimum
    70	 *
    71	 * Slot contents:
    72	 *  Internal (non-leaf) nodes contain pointers to other nodes.
    73	 *  Leaf nodes contain entries.
    74	 *
    75	 *
    76	 */
    77	struct maple_range_64 {
    78		struct maple_pnode *parent;
  > 79		unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
    80		void __rcu *slot[MAPLE_RANGE64_SLOTS];
    81	};
    82	
    83	struct maple_arange_64 {
    84		struct maple_pnode *parent;
  > 85		unsigned long pivot[MAPLE_ARANGE64_SLOTS - 1];
    86		void __rcu *slot[MAPLE_ARANGE64_SLOTS];
    87		unsigned long gap[MAPLE_ARANGE64_SLOTS];
    88		unsigned char meta;
    89	};
    90	
  > 91	#define MAPLE_ALLOC_SLOTS (MAPLE_NODE_SLOTS - 1)
    92	struct maple_alloc {
    93		unsigned long total;
    94		unsigned char node_count;
    95		unsigned int request_count;
    96		struct maple_alloc *slot[MAPLE_ALLOC_SLOTS];
    97	};
    98	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--xHFwDpU9dbj6ez1V
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
we5pOssKAQA=

--xHFwDpU9dbj6ez1V--

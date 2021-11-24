Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EA845C010
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 14:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344825AbhKXNEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 08:04:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:38728 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343755AbhKXNC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 08:02:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="215979369"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="215979369"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 04:59:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="497665357"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2021 04:59:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mprsI-0004nF-GP; Wed, 24 Nov 2021 12:59:46 +0000
Date:   Wed, 24 Nov 2021 20:59:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/mctp/test/route-test.c:186:1: warning: the frame size of 1184
 bytes is larger than 1024 bytes
Message-ID: <202111242036.yDuA29vn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5d9f4cf36721aba199975a9be7863a3ff5cd4b59
commit: 161eba50e183ed4ca20f6d8dec19bdc526d2b2b9 mctp: Add initial test structure and fragmentation test
date:   7 weeks ago
config: powerpc64-randconfig-r023-20211124 (https://download.01.org/0day-ci/archive/20211124/202111242036.yDuA29vn-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=161eba50e183ed4ca20f6d8dec19bdc526d2b2b9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 161eba50e183ed4ca20f6d8dec19bdc526d2b2b9
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/mctp/route.c:1234:
   net/mctp/test/route-test.c: In function 'mctp_test_fragment':
>> net/mctp/test/route-test.c:186:1: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     186 | }
         | ^


vim +186 net/mctp/test/route-test.c

   101	
   102	static void mctp_test_fragment(struct kunit *test)
   103	{
   104		const struct mctp_frag_test *params;
   105		int rc, i, n, mtu, msgsize;
   106		struct mctp_test_route *rt;
   107		struct sk_buff *skb;
   108		struct mctp_hdr hdr;
   109		u8 seq;
   110	
   111		params = test->param_value;
   112		mtu = params->mtu;
   113		msgsize = params->msgsize;
   114	
   115		hdr.ver = 1;
   116		hdr.src = 8;
   117		hdr.dest = 10;
   118		hdr.flags_seq_tag = MCTP_HDR_FLAG_TO;
   119	
   120		skb = mctp_test_create_skb(&hdr, msgsize);
   121		KUNIT_ASSERT_TRUE(test, skb);
   122	
   123		rt = mctp_test_create_route(&init_net, 10, mtu);
   124		KUNIT_ASSERT_TRUE(test, rt);
   125	
   126		/* The refcount would usually be incremented as part of a route lookup,
   127		 * but we're setting the route directly here.
   128		 */
   129		refcount_inc(&rt->rt.refs);
   130	
   131		rc = mctp_do_fragment_route(&rt->rt, skb, mtu, MCTP_TAG_OWNER);
   132		KUNIT_EXPECT_FALSE(test, rc);
   133	
   134		n = rt->pkts.qlen;
   135	
   136		KUNIT_EXPECT_EQ(test, n, params->n_frags);
   137	
   138		for (i = 0;; i++) {
   139			struct mctp_hdr *hdr2;
   140			struct sk_buff *skb2;
   141			u8 tag_mask, seq2;
   142			bool first, last;
   143	
   144			first = i == 0;
   145			last = i == (n - 1);
   146	
   147			skb2 = skb_dequeue(&rt->pkts);
   148	
   149			if (!skb2)
   150				break;
   151	
   152			hdr2 = mctp_hdr(skb2);
   153	
   154			tag_mask = MCTP_HDR_TAG_MASK | MCTP_HDR_FLAG_TO;
   155	
   156			KUNIT_EXPECT_EQ(test, hdr2->ver, hdr.ver);
   157			KUNIT_EXPECT_EQ(test, hdr2->src, hdr.src);
   158			KUNIT_EXPECT_EQ(test, hdr2->dest, hdr.dest);
   159			KUNIT_EXPECT_EQ(test, hdr2->flags_seq_tag & tag_mask,
   160					hdr.flags_seq_tag & tag_mask);
   161	
   162			KUNIT_EXPECT_EQ(test,
   163					!!(hdr2->flags_seq_tag & MCTP_HDR_FLAG_SOM), first);
   164			KUNIT_EXPECT_EQ(test,
   165					!!(hdr2->flags_seq_tag & MCTP_HDR_FLAG_EOM), last);
   166	
   167			seq2 = (hdr2->flags_seq_tag >> MCTP_HDR_SEQ_SHIFT) &
   168				MCTP_HDR_SEQ_MASK;
   169	
   170			if (first) {
   171				seq = seq2;
   172			} else {
   173				seq++;
   174				KUNIT_EXPECT_EQ(test, seq2, seq & MCTP_HDR_SEQ_MASK);
   175			}
   176	
   177			if (!last)
   178				KUNIT_EXPECT_EQ(test, skb2->len, mtu);
   179			else
   180				KUNIT_EXPECT_LE(test, skb2->len, mtu);
   181	
   182			kfree_skb(skb2);
   183		}
   184	
   185		mctp_test_route_destroy(test, rt);
 > 186	}
   187	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

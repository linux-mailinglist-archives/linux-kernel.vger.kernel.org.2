Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33C2460297
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 01:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356736AbhK1Aj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 19:39:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:9092 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245259AbhK1Ah0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 19:37:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="322029301"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="322029301"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 16:34:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="608270973"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 27 Nov 2021 16:34:10 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mr88v-000AAs-Ne; Sun, 28 Nov 2021 00:34:09 +0000
Date:   Sun, 28 Nov 2021 08:33:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikolay Aleksandrov <nikolay@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/bridge/br_private.h:901 br_multicast_rport_from_node_skb() warn:
 inconsistent indenting
Message-ID: <202111280833.ZMtzx8zW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f0dda359c4563cbb1b0f97b0dbbcdc553156541
commit: 9632233e7de8da43711bb7cd3e054af32fedcc38 net: bridge: multicast: factor out port multicast context
date:   4 months ago
config: x86_64-randconfig-m031-20211124 (https://download.01.org/0day-ci/archive/20211128/202111280833.ZMtzx8zW-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
net/bridge/br_private.h:901 br_multicast_rport_from_node_skb() warn: inconsistent indenting

Old smatch warnings:
net/bridge/br_forward.c:317 br_multicast_flood() error: we previously assumed 'p' could be null (see line 293)

vim +901 net/bridge/br_private.h

   890	
   891	static inline struct net_bridge_port *
   892	br_multicast_rport_from_node_skb(struct hlist_node *rp, struct sk_buff *skb) {
   893		struct net_bridge_mcast_port *mctx;
   894	
   895	#if IS_ENABLED(CONFIG_IPV6)
   896		if (skb->protocol == htons(ETH_P_IPV6))
   897			mctx = hlist_entry_safe(rp, struct net_bridge_mcast_port,
   898						ip6_rlist);
   899		else
   900	#endif
 > 901			mctx = hlist_entry_safe(rp, struct net_bridge_mcast_port,
   902						ip4_rlist);
   903	
   904		if (mctx)
   905			return mctx->port;
   906		else
   907			return NULL;
   908	}
   909	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

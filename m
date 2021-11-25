Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C97A45E301
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 23:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbhKYWjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 17:39:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:11018 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233653AbhKYWhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 17:37:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235514981"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235514981"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 14:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="675368246"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2021 14:33:54 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqNJR-00071I-MI; Thu, 25 Nov 2021 22:33:53 +0000
Date:   Fri, 26 Nov 2021 06:33:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: net/netfilter/nfnetlink_queue.c:601:36: warning: variable 'ctinfo'
 is uninitialized when used here
Message-ID: <202111260603.LXLENUG7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ced7ca3570333998ad2088d5a6275701970e28e
commit: 83ace77f51175023c3757e2d08a92565f9b1c7f3 netfilter: ctnetlink: remove get_ct indirection
date:   10 months ago
config: arm64-buildonly-randconfig-r006-20211116 (https://download.01.org/0day-ci/archive/20211126/202111260603.LXLENUG7-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=83ace77f51175023c3757e2d08a92565f9b1c7f3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 83ace77f51175023c3757e2d08a92565f9b1c7f3
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/netfilter/nfnetlink_queue.c:601:36: warning: variable 'ctinfo' is uninitialized when used here [-Wuninitialized]
           if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
                                             ^~~~~~
   net/netfilter/nfnetlink_queue.c:391:2: note: variable 'ctinfo' is declared here
           enum ip_conntrack_info ctinfo;
           ^
   1 warning generated.
--
>> net/netfilter/nfnetlink_log.c:800:18: warning: variable 'ctinfo' is uninitialized when used here [-Wuninitialized]
                                   nfnl_ct, ct, ctinfo);
                                                ^~~~~~
   net/netfilter/nfnetlink_log.c:695:2: note: variable 'ctinfo' is declared here
           enum ip_conntrack_info ctinfo;
           ^
   1 warning generated.


vim +/ctinfo +601 net/netfilter/nfnetlink_queue.c

7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  456  
08c0cad69f32ad net/netfilter/nfnetlink_queue_core.c Valentina Giusti      2013-12-20  457  	if (queue->flags & NFQA_CFG_F_UID_GID) {
08c0cad69f32ad net/netfilter/nfnetlink_queue_core.c Valentina Giusti      2013-12-20  458  		size += (nla_total_size(sizeof(u_int32_t))	/* uid */
08c0cad69f32ad net/netfilter/nfnetlink_queue_core.c Valentina Giusti      2013-12-20  459  			+ nla_total_size(sizeof(u_int32_t)));	/* gid */
08c0cad69f32ad net/netfilter/nfnetlink_queue_core.c Valentina Giusti      2013-12-20  460  	}
08c0cad69f32ad net/netfilter/nfnetlink_queue_core.c Valentina Giusti      2013-12-20  461  
ef493bd930ae48 net/netfilter/nfnetlink_queue_core.c Roman Kubiak          2015-06-12  462  	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
ef493bd930ae48 net/netfilter/nfnetlink_queue_core.c Roman Kubiak          2015-06-12  463  		seclen = nfqnl_get_sk_secctx(entskb, &secdata);
ef493bd930ae48 net/netfilter/nfnetlink_queue_core.c Roman Kubiak          2015-06-12  464  		if (seclen)
ef493bd930ae48 net/netfilter/nfnetlink_queue_core.c Roman Kubiak          2015-06-12  465  			size += nla_total_size(seclen);
ef493bd930ae48 net/netfilter/nfnetlink_queue_core.c Roman Kubiak          2015-06-12  466  	}
ef493bd930ae48 net/netfilter/nfnetlink_queue_core.c Roman Kubiak          2015-06-12  467  
c5b0db3263b925 net/netfilter/nfnetlink_queue.c      Florian Westphal      2016-02-18  468  	skb = alloc_skb(size, GFP_ATOMIC);
36d5fe6a000790 net/netfilter/nfnetlink_queue_core.c Zoltan Kiss           2014-03-26  469  	if (!skb) {
36d5fe6a000790 net/netfilter/nfnetlink_queue_core.c Zoltan Kiss           2014-03-26  470  		skb_tx_error(entskb);
77c1c03c5b8ef2 net/netfilter/nfnetlink_queue.c      Liping Zhang          2017-03-28  471  		goto nlmsg_failure;
36d5fe6a000790 net/netfilter/nfnetlink_queue_core.c Zoltan Kiss           2014-03-26  472  	}
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  473  
3da07c0c2b5a13 net/netfilter/nfnetlink_queue_core.c David S. Miller       2012-06-26  474  	nlh = nlmsg_put(skb, 0, 0,
dedb67c4b4e5fa net/netfilter/nfnetlink_queue.c      Pablo Neira Ayuso     2017-03-28  475  			nfnl_msg_type(NFNL_SUBSYS_QUEUE, NFQNL_MSG_PACKET),
3da07c0c2b5a13 net/netfilter/nfnetlink_queue_core.c David S. Miller       2012-06-26  476  			sizeof(struct nfgenmsg), 0);
3da07c0c2b5a13 net/netfilter/nfnetlink_queue_core.c David S. Miller       2012-06-26  477  	if (!nlh) {
36d5fe6a000790 net/netfilter/nfnetlink_queue_core.c Zoltan Kiss           2014-03-26  478  		skb_tx_error(entskb);
3da07c0c2b5a13 net/netfilter/nfnetlink_queue_core.c David S. Miller       2012-06-26  479  		kfree_skb(skb);
77c1c03c5b8ef2 net/netfilter/nfnetlink_queue.c      Liping Zhang          2017-03-28  480  		goto nlmsg_failure;
3da07c0c2b5a13 net/netfilter/nfnetlink_queue_core.c David S. Miller       2012-06-26  481  	}
3da07c0c2b5a13 net/netfilter/nfnetlink_queue_core.c David S. Miller       2012-06-26  482  	nfmsg = nlmsg_data(nlh);
1d1de89b9a4746 net/netfilter/nfnetlink_queue_core.c David S. Miller       2015-04-03  483  	nfmsg->nfgen_family = entry->state.pf;
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  484  	nfmsg->version = NFNETLINK_V0;
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  485  	nfmsg->res_id = htons(queue->queue_num);
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  486  
5863702a3421b0 net/netfilter/nfnetlink_queue.c      Eric Dumazet          2011-07-19  487  	nla = __nla_reserve(skb, NFQA_PACKET_HDR, sizeof(*pmsg));
5863702a3421b0 net/netfilter/nfnetlink_queue.c      Eric Dumazet          2011-07-19  488  	pmsg = nla_data(nla);
5863702a3421b0 net/netfilter/nfnetlink_queue.c      Eric Dumazet          2011-07-19  489  	pmsg->hw_protocol	= entskb->protocol;
1d1de89b9a4746 net/netfilter/nfnetlink_queue_core.c David S. Miller       2015-04-03  490  	pmsg->hook		= entry->state.hook;
5863702a3421b0 net/netfilter/nfnetlink_queue.c      Eric Dumazet          2011-07-19  491  	*packet_id_ptr		= &pmsg->packet_id;
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  492  
1d1de89b9a4746 net/netfilter/nfnetlink_queue_core.c David S. Miller       2015-04-03  493  	indev = entry->state.in;
3e4ead4fe5d0d9 net/netfilter/nfnetlink_queue.c      Jesper Juhl           2006-01-05  494  	if (indev) {
1109a90c01177e net/netfilter/nfnetlink_queue_core.c Pablo Neira Ayuso     2014-10-01  495  #if !IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  496  		if (nla_put_be32(skb, NFQA_IFINDEX_INDEV, htonl(indev->ifindex)))
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  497  			goto nla_put_failure;
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  498  #else
1d1de89b9a4746 net/netfilter/nfnetlink_queue_core.c David S. Miller       2015-04-03  499  		if (entry->state.pf == PF_BRIDGE) {
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  500  			/* Case 1: indev is physical input device, we need to
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  501  			 * look for bridge group (when called from
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  502  			 * netfilter_bridge) */
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  503  			if (nla_put_be32(skb, NFQA_IFINDEX_PHYSINDEV,
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  504  					 htonl(indev->ifindex)) ||
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  505  			/* this is the bridge group "brX" */
f350a0a8737441 net/netfilter/nfnetlink_queue.c      Jiri Pirko            2010-06-15  506  			/* rcu_read_lock()ed by __nf_queue */
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  507  			    nla_put_be32(skb, NFQA_IFINDEX_INDEV,
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  508  					 htonl(br_port_get_rcu(indev)->br->dev->ifindex)))
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  509  				goto nla_put_failure;
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  510  		} else {
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  511  			int physinif;
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  512  
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  513  			/* Case 2: indev is bridge group, we need to look for
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  514  			 * physical device (when called from ipv4) */
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  515  			if (nla_put_be32(skb, NFQA_IFINDEX_INDEV,
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  516  					 htonl(indev->ifindex)))
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  517  				goto nla_put_failure;
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  518  
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  519  			physinif = nf_bridge_get_physinif(entskb);
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  520  			if (physinif &&
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  521  			    nla_put_be32(skb, NFQA_IFINDEX_PHYSINDEV,
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  522  					 htonl(physinif)))
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  523  				goto nla_put_failure;
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  524  		}
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  525  #endif
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  526  	}
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  527  
3e4ead4fe5d0d9 net/netfilter/nfnetlink_queue.c      Jesper Juhl           2006-01-05  528  	if (outdev) {
1109a90c01177e net/netfilter/nfnetlink_queue_core.c Pablo Neira Ayuso     2014-10-01  529  #if !IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  530  		if (nla_put_be32(skb, NFQA_IFINDEX_OUTDEV, htonl(outdev->ifindex)))
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  531  			goto nla_put_failure;
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  532  #else
1d1de89b9a4746 net/netfilter/nfnetlink_queue_core.c David S. Miller       2015-04-03  533  		if (entry->state.pf == PF_BRIDGE) {
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  534  			/* Case 1: outdev is physical output device, we need to
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  535  			 * look for bridge group (when called from
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  536  			 * netfilter_bridge) */
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  537  			if (nla_put_be32(skb, NFQA_IFINDEX_PHYSOUTDEV,
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  538  					 htonl(outdev->ifindex)) ||
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  539  			/* this is the bridge group "brX" */
f350a0a8737441 net/netfilter/nfnetlink_queue.c      Jiri Pirko            2010-06-15  540  			/* rcu_read_lock()ed by __nf_queue */
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  541  			    nla_put_be32(skb, NFQA_IFINDEX_OUTDEV,
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  542  					 htonl(br_port_get_rcu(outdev)->br->dev->ifindex)))
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  543  				goto nla_put_failure;
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  544  		} else {
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  545  			int physoutif;
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  546  
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  547  			/* Case 2: outdev is bridge group, we need to look for
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  548  			 * physical output device (when called from ipv4) */
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  549  			if (nla_put_be32(skb, NFQA_IFINDEX_OUTDEV,
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  550  					 htonl(outdev->ifindex)))
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  551  				goto nla_put_failure;
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  552  
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  553  			physoutif = nf_bridge_get_physoutif(entskb);
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  554  			if (physoutif &&
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  555  			    nla_put_be32(skb, NFQA_IFINDEX_PHYSOUTDEV,
c737b7c4510026 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2015-04-02  556  					 htonl(physoutif)))
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  557  				goto nla_put_failure;
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  558  		}
fbcd923c3e0c8e net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  559  #endif
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  560  	}
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  561  
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  562  	if (entskb->mark &&
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  563  	    nla_put_be32(skb, NFQA_MARK, htonl(entskb->mark)))
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  564  		goto nla_put_failure;
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  565  
2c38de4c1f8da7 net/netfilter/nfnetlink_queue.c      Nicolas Cavallari     2011-06-16  566  	if (indev && entskb->dev &&
2c38de4c1f8da7 net/netfilter/nfnetlink_queue.c      Nicolas Cavallari     2011-06-16  567  	    entskb->mac_header != entskb->network_header) {
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  568  		struct nfqnl_msg_packet_hw phw;
e4d091d7bf787c net/netfilter/nfnetlink_queue_core.c Dan Carpenter         2013-08-01  569  		int len;
e4d091d7bf787c net/netfilter/nfnetlink_queue_core.c Dan Carpenter         2013-08-01  570  
e4d091d7bf787c net/netfilter/nfnetlink_queue_core.c Dan Carpenter         2013-08-01  571  		memset(&phw, 0, sizeof(phw));
e4d091d7bf787c net/netfilter/nfnetlink_queue_core.c Dan Carpenter         2013-08-01  572  		len = dev_parse_header(entskb, phw.hw_addr);
b95cce3576813a net/netfilter/nfnetlink_queue.c      Stephen Hemminger     2007-09-26  573  		if (len) {
98a4a86128d717 net/netfilter/nfnetlink_queue.c      Al Viro               2006-11-08  574  			phw.hw_addrlen = htons(len);
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  575  			if (nla_put(skb, NFQA_HWADDR, sizeof(phw), &phw))
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  576  				goto nla_put_failure;
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  577  		}
b95cce3576813a net/netfilter/nfnetlink_queue.c      Stephen Hemminger     2007-09-26  578  	}
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  579  
15824ab29f364a net/netfilter/nfnetlink_queue.c      Stephane Bryant       2016-03-26  580  	if (nfqnl_put_bridge(entry, skb) < 0)
15824ab29f364a net/netfilter/nfnetlink_queue.c      Stephane Bryant       2016-03-26  581  		goto nla_put_failure;
15824ab29f364a net/netfilter/nfnetlink_queue.c      Stephane Bryant       2016-03-26  582  
916f6efae62305 net/netfilter/nfnetlink_queue.c      Florian Westphal      2019-04-17  583  	if (entry->state.hook <= NF_INET_FORWARD && entskb->tstamp) {
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  584  		struct nfqnl_msg_packet_timestamp ts;
a7f1884554b81b net/netfilter/nfnetlink_queue.c      Florian Westphal      2016-05-12  585  		struct timespec64 kts = ktime_to_timespec64(entskb->tstamp);
b28b1e826f818c net/netfilter/nfnetlink_queue.c      Pablo Neira Ayuso     2015-10-04  586  
b28b1e826f818c net/netfilter/nfnetlink_queue.c      Pablo Neira Ayuso     2015-10-04  587  		ts.sec = cpu_to_be64(kts.tv_sec);
b28b1e826f818c net/netfilter/nfnetlink_queue.c      Pablo Neira Ayuso     2015-10-04  588  		ts.usec = cpu_to_be64(kts.tv_nsec / NSEC_PER_USEC);
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  589  
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  590  		if (nla_put(skb, NFQA_TIMESTAMP, sizeof(ts), &ts))
a447189e073bf6 net/netfilter/nfnetlink_queue.c      David S. Miller       2012-03-29  591  			goto nla_put_failure;
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  592  	}
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  593  
08c0cad69f32ad net/netfilter/nfnetlink_queue_core.c Valentina Giusti      2013-12-20  594  	if ((queue->flags & NFQA_CFG_F_UID_GID) && entskb->sk &&
08c0cad69f32ad net/netfilter/nfnetlink_queue_core.c Valentina Giusti      2013-12-20  595  	    nfqnl_put_sk_uidgid(skb, entskb->sk) < 0)
08c0cad69f32ad net/netfilter/nfnetlink_queue_core.c Valentina Giusti      2013-12-20  596  		goto nla_put_failure;
08c0cad69f32ad net/netfilter/nfnetlink_queue_core.c Valentina Giusti      2013-12-20  597  
ef493bd930ae48 net/netfilter/nfnetlink_queue_core.c Roman Kubiak          2015-06-12  598  	if (seclen && nla_put(skb, NFQA_SECCTX, seclen, secdata))
ef493bd930ae48 net/netfilter/nfnetlink_queue_core.c Roman Kubiak          2015-06-12  599  		goto nla_put_failure;
ef493bd930ae48 net/netfilter/nfnetlink_queue_core.c Roman Kubiak          2015-06-12  600  
a4b4766c3cebb4 net/netfilter/nfnetlink_queue.c      Ken-ichirou MATSUZAWA 2015-10-05 @601  	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
ae08ce0021087a net/netfilter/nfnetlink_queue_core.c Eric Dumazet          2013-03-17  602  		goto nla_put_failure;
ae08ce0021087a net/netfilter/nfnetlink_queue_core.c Eric Dumazet          2013-03-17  603  
7f87712c015251 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2013-06-04  604  	if (cap_len > data_len &&
7f87712c015251 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2013-06-04  605  	    nla_put_be32(skb, NFQA_CAP_LEN, htonl(cap_len)))
ae08ce0021087a net/netfilter/nfnetlink_queue_core.c Eric Dumazet          2013-03-17  606  		goto nla_put_failure;
ae08ce0021087a net/netfilter/nfnetlink_queue_core.c Eric Dumazet          2013-03-17  607  
496e4ae7dc944f net/netfilter/nfnetlink_queue_core.c Florian Westphal      2013-06-29  608  	if (nfqnl_put_packet_info(skb, entskb, csum_verify))
7237190df8c412 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2013-04-19  609  		goto nla_put_failure;
7237190df8c412 net/netfilter/nfnetlink_queue_core.c Florian Westphal      2013-04-19  610  
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  611  	if (data_len) {
df6fb868d61186 net/netfilter/nfnetlink_queue.c      Patrick McHardy       2007-09-28  612  		struct nlattr *nla;
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  613  
ae08ce0021087a net/netfilter/nfnetlink_queue_core.c Eric Dumazet          2013-03-17  614  		if (skb_tailroom(skb) < sizeof(*nla) + hlen)
ae08ce0021087a net/netfilter/nfnetlink_queue_core.c Eric Dumazet          2013-03-17  615  			goto nla_put_failure;
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  616  
4df864c1d9afb4 net/netfilter/nfnetlink_queue.c      Johannes Berg         2017-06-16  617  		nla = skb_put(skb, sizeof(*nla));
df6fb868d61186 net/netfilter/nfnetlink_queue.c      Patrick McHardy       2007-09-28  618  		nla->nla_type = NFQA_PAYLOAD;
ae08ce0021087a net/netfilter/nfnetlink_queue_core.c Eric Dumazet          2013-03-17  619  		nla->nla_len = nla_attr_size(data_len);
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  620  
36d5fe6a000790 net/netfilter/nfnetlink_queue_core.c Zoltan Kiss           2014-03-26  621  		if (skb_zerocopy(skb, entskb, data_len, hlen))
36d5fe6a000790 net/netfilter/nfnetlink_queue_core.c Zoltan Kiss           2014-03-26  622  			goto nla_put_failure;
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  623  	}
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  624  
ae08ce0021087a net/netfilter/nfnetlink_queue_core.c Eric Dumazet          2013-03-17  625  	nlh->nlmsg_len = skb->len;
77c1c03c5b8ef2 net/netfilter/nfnetlink_queue.c      Liping Zhang          2017-03-28  626  	if (seclen)
77c1c03c5b8ef2 net/netfilter/nfnetlink_queue.c      Liping Zhang          2017-03-28  627  		security_release_secctx(secdata, seclen);
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  628  	return skb;
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  629  
df6fb868d61186 net/netfilter/nfnetlink_queue.c      Patrick McHardy       2007-09-28  630  nla_put_failure:
36d5fe6a000790 net/netfilter/nfnetlink_queue_core.c Zoltan Kiss           2014-03-26  631  	skb_tx_error(entskb);
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  632  	kfree_skb(skb);
e87cc4728f0e2f net/netfilter/nfnetlink_queue.c      Joe Perches           2012-05-13  633  	net_err_ratelimited("nf_queue: error creating packet message\n");
77c1c03c5b8ef2 net/netfilter/nfnetlink_queue.c      Liping Zhang          2017-03-28  634  nlmsg_failure:
77c1c03c5b8ef2 net/netfilter/nfnetlink_queue.c      Liping Zhang          2017-03-28  635  	if (seclen)
77c1c03c5b8ef2 net/netfilter/nfnetlink_queue.c      Liping Zhang          2017-03-28  636  		security_release_secctx(secdata, seclen);
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  637  	return NULL;
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  638  }
7af4cc3fa158ff net/netfilter/nfnetlink_queue.c      Harald Welte          2005-08-09  639  

:::::: The code at line 601 was first introduced by commit
:::::: a4b4766c3cebb4018167e06b863d8e95b7274757 netfilter: nfnetlink_queue: rename related to nfqueue attaching conntrack info

:::::: TO: Ken-ichirou MATSUZAWA <chamaken@gmail.com>
:::::: CC: Pablo Neira Ayuso <pablo@netfilter.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

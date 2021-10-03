Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B541420197
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 14:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhJCMsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 08:48:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:41043 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhJCMs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:48:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10125"; a="205978415"
X-IronPort-AV: E=Sophos;i="5.85,343,1624345200"; 
   d="gz'50?scan'50,208,50";a="205978415"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 05:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,343,1624345200"; 
   d="gz'50?scan'50,208,50";a="620964819"
Received: from lkp-server01.sh.intel.com (HELO 72c3bd3cf19c) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2021 05:46:39 -0700
Received: from kbuild by 72c3bd3cf19c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mX0t5-0003C1-1Y; Sun, 03 Oct 2021 12:46:39 +0000
Date:   Sun, 3 Oct 2021 20:46:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: net/netfilter/nfnetlink_queue.c:601:36: warning: variable 'ctinfo'
 is uninitialized when used here
Message-ID: <202110032014.m2OBk4Fd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   02d5e016800d082058b3d3b7c3ede136cdc6ddcb
commit: 83ace77f51175023c3757e2d08a92565f9b1c7f3 netfilter: ctnetlink: remove get_ct indirection
date:   8 months ago
config: arm-randconfig-c002-20210930 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 28981015526f2192440c18f18e8a20cd11b0779c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=83ace77f51175023c3757e2d08a92565f9b1c7f3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 83ace77f51175023c3757e2d08a92565f9b1c7f3
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 

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

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HcAYCG3uE/tztfnV--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E6644ACC4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbhKILnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:43:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:56805 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237819AbhKILnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:43:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="293261935"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="gz'50?scan'50,208,50";a="293261935"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 03:40:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="gz'50?scan'50,208,50";a="669373092"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Nov 2021 03:40:36 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mkPUS-000DOs-2j; Tue, 09 Nov 2021 11:40:36 +0000
Date:   Tue, 9 Nov 2021 19:40:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kris Van Hees <kris.van.hees@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Tomas Jedlicka <tomas.jedlicka@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        David Mc Lean <david.mclean@oracle.com>,
        Vincent Lim <vincent.lim@oracle.com>
Subject: [oracle-dtrace:v1/5.15 30/35] net/ipv6/ip6_output.c:69:21: warning:
 variable 'dropreason' set but not used
Message-ID: <202111091903.szcR5o5V-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/oracle/dtrace-linux-kernel v1/5.15
head:   0fee66d7ce96317146609675767971d0f35c3e74
commit: 7ed2333cfd691c676b0adfe951d92244f1ef5128 [30/35] dtrace: add SDT probes
config: csky-defconfig (attached as .config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/oracle/dtrace-linux-kernel/commit/7ed2333cfd691c676b0adfe951d92244f1ef5128
        git remote add oracle-dtrace https://github.com/oracle/dtrace-linux-kernel
        git fetch --no-tags oracle-dtrace v1/5.15
        git checkout 7ed2333cfd691c676b0adfe951d92244f1ef5128
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=csky 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/ipv6/ip6_output.c: In function 'ip6_finish_output2':
>> net/ipv6/ip6_output.c:69:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
      69 |         const char *dropreason;
         |                     ^~~~~~~~~~
   net/ipv6/ip6_output.c: In function 'ip6_xmit':
   net/ipv6/ip6_output.c:291:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
     291 |         const char *dropreason;
         |                     ^~~~~~~~~~
   net/ipv6/ip6_output.c: In function 'ip6_forward':
>> net/ipv6/ip6_output.c:536:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
     536 |         int err = -EINVAL;
         |             ^~~
   net/ipv6/ip6_output.c:535:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
     535 |         const char *dropreason;
         |                     ^~~~~~~~~~
   net/ipv6/ip6_output.c: In function '__ip6_append_data':
   net/ipv6/ip6_output.c:1547:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
    1547 |         const char *dropreason;
         |                     ^~~~~~~~~~
--
   net/ipv6/ip6_input.c: In function 'ip6_rcv_core':
>> net/ipv6/ip6_input.c:152:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
     152 |         const char *dropreason;
         |                     ^~~~~~~~~~
   net/ipv6/ip6_input.c: In function 'ip6_protocol_deliver_rcu':
   net/ipv6/ip6_input.c:389:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
     389 |         const char *dropreason;
         |                     ^~~~~~~~~~
   net/ipv6/ip6_input.c: In function 'ip6_input':
   net/ipv6/ip6_input.c:526:25: warning: unused variable 'hdr' [-Wunused-variable]
     526 |         struct ipv6hdr *hdr = ipv6_hdr(skb);
         |                         ^~~
--
   net/ipv6/raw.c: In function 'rawv6_send_hdrinc':
>> net/ipv6/raw.c:631:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
     631 |         const char *dropreason;
         |                     ^~~~~~~~~~
--
   net/ipv6/mcast.c: In function 'mld_sendpack':
>> net/ipv6/mcast.c:1796:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
    1796 |         const char *dropreason;
         |                     ^~~~~~~~~~
   net/ipv6/mcast.c: In function 'igmp6_send':
   net/ipv6/mcast.c:2167:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
    2167 |         const char *dropreason;
         |                     ^~~~~~~~~~


vim +/dropreason +69 net/ipv6/ip6_output.c

    59	
    60	static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
    61	{
    62		struct dst_entry *dst = skb_dst(skb);
    63		struct net_device *dev = dst->dev;
    64		struct inet6_dev *idev = ip6_dst_idev(dst);
    65		unsigned int hh_len = LL_RESERVED_SPACE(dev);
    66		const struct in6_addr *daddr, *nexthop;
    67		struct ipv6hdr *hdr;
    68		struct neighbour *neigh;
  > 69		const char *dropreason;
    70		int ret = 0;
    71	
    72		/* Be paranoid, rather than too clever. */
    73		if (unlikely(hh_len > skb_headroom(skb)) && dev->header_ops) {
    74			skb = skb_expand_head(skb, hh_len);
    75			if (!skb)
    76				goto oom;
    77		}
    78	
    79		hdr = ipv6_hdr(skb);
    80		daddr = &hdr->daddr;
    81		if (ipv6_addr_is_multicast(daddr)) {
    82			if (!(dev->flags & IFF_LOOPBACK) && sk_mc_loop(sk) &&
    83			    ((mroute6_is_socket(net, skb) &&
    84			     !(IP6CB(skb)->flags & IP6SKB_FORWARDED)) ||
    85			     ipv6_chk_mcast_addr(dev, daddr, &hdr->saddr))) {
    86				struct sk_buff *newskb = skb_clone(skb, GFP_ATOMIC);
    87	
    88				/* Do not check for IFF_ALLMULTI; multicast routing
    89				   is not supported in any case.
    90				 */
    91				if (newskb)
    92					NF_HOOK(NFPROTO_IPV6, NF_INET_POST_ROUTING,
    93						net, sk, newskb, NULL, newskb->dev,
    94						dev_loopback_xmit);
    95	
    96				if (hdr->hop_limit == 0) {
    97					dropreason = "hoplimit exceeded";
    98	
    99					IP6_INC_STATS(net, idev,
   100						      IPSTATS_MIB_OUTDISCARDS);
   101					goto drop;
   102				}
   103			}
   104	
   105			IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUTMCAST, skb->len);
   106			if (IPV6_ADDR_MC_SCOPE(daddr) <= IPV6_ADDR_SCOPE_NODELOCAL &&
   107			    !(dev->flags & IFF_LOOPBACK)) {
   108				dropreason = "invalid scope";
   109				goto drop;
   110			}
   111		}
   112	
   113		if (lwtunnel_xmit_redirect(dst->lwtstate)) {
   114			int res = lwtunnel_xmit(skb);
   115	
   116			if (res < 0 || res == LWTUNNEL_XMIT_DONE)
   117				return res;
   118		}
   119	
   120		rcu_read_lock_bh();
   121		nexthop = rt6_nexthop((struct rt6_info *)dst, daddr);
   122		neigh = __ipv6_neigh_lookup_noref(dev, nexthop);
   123		if (unlikely(!neigh))
   124			neigh = __neigh_create(&nd_tbl, nexthop, dev, false);
   125		if (!IS_ERR(neigh)) {
   126			sock_confirm_neigh(skb, neigh);
   127			ret = neigh_output(neigh, skb, false);
   128			rcu_read_unlock_bh();
   129			return ret;
   130		}
   131		rcu_read_unlock_bh();
   132	
   133		dropreason = "no route to host";
   134		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTNOROUTES);
   135		ret = -EINVAL;
   136	drop:
   137		DTRACE_IP(drop__out,
   138			  struct sk_buff * : pktinfo_t *, skb,
   139			  struct sock * : csinfo_t *, skb->sk,
   140			  void_ip_t * : ipinfo_t *, ipv6_hdr(skb),
   141			  struct net_device * : ifinfo_t *, skb->dev,
   142			  struct iphdr * : ipv4info_t *, NULL,
   143			  struct ipv6hdr * : ipv6info_t *, ipv6_hdr(skb),
   144			  const char * : string, dropreason);
   145		kfree_skb(skb);
   146		return ret;
   147	oom:
   148		DTRACE_IP(drop__out,
   149			  struct sk_buff * : pktinfo_t *, NULL,
   150			  struct sock * : csinfo_t *, NULL,
   151			  void_ip_t * : ipinfo_t *, NULL,
   152			  struct net_device * : ifinfo_t *, NULL,
   153			  struct iphdr * : ipv4info_t *, NULL,
   154			  struct ipv6hdr * : ipv6info_t *, NULL,
   155			  const char * : string, "out of memory");
   156		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
   157		return -ENOMEM;
   158	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--azLHFNyN32YCQGCU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--azLHFNyN32YCQGCU--

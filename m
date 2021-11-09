Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79F544A52E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 04:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbhKIDKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 22:10:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:18415 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238738AbhKIDKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 22:10:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232316760"
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="gz'50?scan'50,208,50";a="232316760"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 19:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="gz'50?scan'50,208,50";a="451722911"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2021 19:05:24 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mkHRr-000Cyg-Ci; Tue, 09 Nov 2021 03:05:23 +0000
Date:   Tue, 9 Nov 2021 11:04:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kris Van Hees <kris.van.hees@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Tomas Jedlicka <tomas.jedlicka@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        David Mc Lean <david.mclean@oracle.com>,
        Vincent Lim <vincent.lim@oracle.com>
Subject: [oracle-dtrace:v1/5.15 30/35] net/ipv4/raw.c:358:21: warning:
 variable 'dropreason' set but not used
Message-ID: <202111091129.rfKm9SZb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/oracle/dtrace-linux-kernel v1/5.15
head:   0fee66d7ce96317146609675767971d0f35c3e74
commit: 7ed2333cfd691c676b0adfe951d92244f1ef5128 [30/35] dtrace: add SDT probes
config: ia64-defconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/oracle/dtrace-linux-kernel/commit/7ed2333cfd691c676b0adfe951d92244f1ef5128
        git remote add oracle-dtrace https://github.com/oracle/dtrace-linux-kernel
        git fetch --no-tags oracle-dtrace v1/5.15
        git checkout 7ed2333cfd691c676b0adfe951d92244f1ef5128
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/ipv4/raw.c: In function 'raw_send_hdrinc':
>> net/ipv4/raw.c:358:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
     358 |         const char *dropreason;
         |                     ^~~~~~~~~~
--
   net/ipv4/ip_input.c: In function 'ip_rcv_options':
>> net/ipv4/ip_input.c:273:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
     273 |         const char *dropreason;
         |                     ^~~~~~~~~~
   net/ipv4/ip_input.c: In function 'ip_rcv_core':
   net/ipv4/ip_input.c:468:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
     468 |         const char *dropreason = "header invalid";
         |                     ^~~~~~~~~~
--
   net/ipv4/ip_output.c: In function '__ip_append_data':
>> net/ipv4/ip_output.c:979:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
     979 |         const char *dropreason;
         |                     ^~~~~~~~~~
   net/ipv4/ip_output.c: In function 'ip_append_page':
   net/ipv4/ip_output.c:1366:21: warning: variable 'dropreason' set but not used [-Wunused-but-set-variable]
    1366 |         const char *dropreason;
         |                     ^~~~~~~~~~
>> net/ipv4/ip_output.c:1365:23: warning: variable 'iph' set but not used [-Wunused-but-set-variable]
    1365 |         struct iphdr *iph;
         |                       ^~~


vim +/dropreason +358 net/ipv4/raw.c

   344	
   345	static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
   346				   struct msghdr *msg, size_t length,
   347				   struct rtable **rtp, unsigned int flags,
   348				   const struct sockcm_cookie *sockc)
   349	{
   350		struct inet_sock *inet = inet_sk(sk);
   351		struct net *net = sock_net(sk);
   352		struct iphdr *iph;
   353		struct sk_buff *skb = NULL;
   354		unsigned int iphlen;
   355		int err;
   356		struct rtable *rt = *rtp;
   357		int hlen, tlen;
 > 358		const char *dropreason;
   359	
   360		if (length > rt->dst.dev->mtu) {
   361			ip_local_error(sk, EMSGSIZE, fl4->daddr, inet->inet_dport,
   362				       rt->dst.dev->mtu);
   363			dropreason = "packet too big";
   364			err = -EMSGSIZE;
   365			goto trace_drop;
   366		}
   367		if (length < sizeof(struct iphdr)) {
   368			dropreason = "packet too short";
   369			err = -EINVAL;
   370			goto trace_drop;
   371		}
   372	
   373		if (flags&MSG_PROBE)
   374			goto out;
   375	
   376		hlen = LL_RESERVED_SPACE(rt->dst.dev);
   377		tlen = rt->dst.dev->needed_tailroom;
   378		skb = sock_alloc_send_skb(sk,
   379					  length + hlen + tlen + 15,
   380					  flags & MSG_DONTWAIT, &err);
   381		if (!skb) {
   382			dropreason = "out of memory";
   383			goto error;
   384		}
   385		skb_reserve(skb, hlen);
   386	
   387		skb->priority = sk->sk_priority;
   388		skb->mark = sockc->mark;
   389		skb->tstamp = sockc->transmit_time;
   390		skb_dst_set(skb, &rt->dst);
   391		*rtp = NULL;
   392	
   393		skb_reset_network_header(skb);
   394		iph = ip_hdr(skb);
   395		skb_put(skb, length);
   396	
   397		skb->ip_summed = CHECKSUM_NONE;
   398	
   399		skb_setup_tx_timestamp(skb, sockc->tsflags);
   400	
   401		if (flags & MSG_CONFIRM)
   402			skb_set_dst_pending_confirm(skb, 1);
   403	
   404		skb->transport_header = skb->network_header;
   405		err = -EFAULT;
   406		if (memcpy_from_msg(iph, msg, length)) {
   407			dropreason = "could not copy msg";
   408			goto error_free;
   409		}
   410	
   411		iphlen = iph->ihl * 4;
   412	
   413		/*
   414		 * We don't want to modify the ip header, but we do need to
   415		 * be sure that it won't cause problems later along the network
   416		 * stack.  Specifically we want to make sure that iph->ihl is a
   417		 * sane value.  If ihl points beyond the length of the buffer passed
   418		 * in, reject the frame as invalid
   419		 */
   420		err = -EINVAL;
   421		if (iphlen > length) {
   422			dropreason = "IP header too big";
   423			goto error_free;
   424		}
   425	
   426		if (iphlen >= sizeof(*iph)) {
   427			if (!iph->saddr)
   428				iph->saddr = fl4->saddr;
   429			iph->check   = 0;
   430			iph->tot_len = htons(length);
   431			if (!iph->id)
   432				ip_select_ident(net, skb, NULL);
   433	
   434			iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
   435			skb->transport_header += iphlen;
   436			if (iph->protocol == IPPROTO_ICMP &&
   437			    length >= iphlen + sizeof(struct icmphdr))
   438				icmp_out_count(net, ((struct icmphdr *)
   439					skb_transport_header(skb))->type);
   440		}
   441	
   442		DTRACE_IP(send,
   443			  struct sk_buff * :  pktinfo_t *, skb,
   444			  struct sock * : csinfo_t *, sk,
   445			  void_ip_t * : ipinfo_t *, iph,
   446			  struct net_device * : ifinfo_t *, skb->dev,
   447			  struct iphdr * : ipv4info_t *, iph,
   448			  struct ipv6hdr * : ipv6info_t *, NULL);
   449	
   450		err = NF_HOOK(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
   451			      net, sk, skb, NULL, rt->dst.dev,
   452			      dst_output);
   453		if (err > 0)
   454			err = net_xmit_errno(err);
   455		if (err) {
   456			dropreason = "device dropping packets of this priority";
   457			goto error;
   458		}
   459	out:
   460		return 0;
   461	
   462	error_free:
   463		kfree_skb(skb);
   464		skb = NULL;
   465	error:
   466		IP_INC_STATS(net, IPSTATS_MIB_OUTDISCARDS);
   467	trace_drop:
   468		DTRACE_IP(drop__out,
   469			  struct sk_buff * : pktinfo_t *, skb,
   470			  struct sock * : csinfo_t *, skb ? skb->sk : NULL,
   471			  void_ip_t * : ipinfo_t *, skb ? ip_hdr(skb) : NULL,
   472			  struct net_device * : ifinfo_t *, skb ? skb->dev : NULL,
   473			  struct iphdr * : ipv4info_t *, skb ? ip_hdr(skb) : NULL,
   474			  struct ipv6hdr * : ipv6info_t *, NULL,
   475			  const char * : string, dropreason);
   476		if (err == -ENOBUFS && !inet->recverr)
   477			err = 0;
   478		return err;
   479	}
   480	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--envbJBWh7q8WU6mo
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--envbJBWh7q8WU6mo--

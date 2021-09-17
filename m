Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B398440EFC2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 04:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbhIQChs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 22:37:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:58471 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243428AbhIQCgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 22:36:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202204702"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="gz'50?scan'50,208,50";a="202204702"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 19:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="gz'50?scan'50,208,50";a="471899597"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Sep 2021 19:35:05 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mR3iS-0001dq-EV; Fri, 17 Sep 2021 02:35:04 +0000
Date:   Fri, 17 Sep 2021 10:34:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [dborkman-bpf:pr/bpf-tstamp 3/3] include/net/tcp.h:812:25: error:
 'const struct sk_buff' has no member named 'skb_mstamp_ns'
Message-ID: <202109171005.nsrajlbo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git pr/bpf-tstamp
head:   f7d619a946e981177777983af26e9e31163ffb38
commit: f7d619a946e981177777983af26e9e31163ffb38 [3/3] net: skb clock bases
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git/commit/?id=f7d619a946e981177777983af26e9e31163ffb38
        git remote add dborkman-bpf https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git
        git fetch --no-tags dborkman-bpf pr/bpf-tstamp
        git checkout f7d619a946e981177777983af26e9e31163ffb38
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from net/core/sock.c:139:
   include/net/tcp.h: In function 'tcp_skb_timestamp':
>> include/net/tcp.h:812:25: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     812 |  return tcp_ns_to_ts(skb->skb_mstamp_ns);
         |                         ^~
   include/net/tcp.h: In function 'tcp_skb_timestamp_us':
   include/net/tcp.h:818:20: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     818 |  return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
         |                    ^~
   include/net/tcp.h: In function 'tcp_add_tx_delay':
>> include/net/tcp.h:2367:6: error: 'struct sk_buff' has no member named 'skb_mstamp_ns'
    2367 |   skb->skb_mstamp_ns += (u64)tp->tcp_tx_delay * NSEC_PER_USEC;
         |      ^~
--
   In file included from net/ipv4/route.c:101:
   include/net/tcp.h: In function 'tcp_skb_timestamp':
>> include/net/tcp.h:812:25: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     812 |  return tcp_ns_to_ts(skb->skb_mstamp_ns);
         |                         ^~
   include/net/tcp.h: In function 'tcp_skb_timestamp_us':
   include/net/tcp.h:818:20: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     818 |  return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
         |                    ^~
   include/net/tcp.h: In function 'tcp_add_tx_delay':
>> include/net/tcp.h:2367:6: error: 'struct sk_buff' has no member named 'skb_mstamp_ns'
    2367 |   skb->skb_mstamp_ns += (u64)tp->tcp_tx_delay * NSEC_PER_USEC;
         |      ^~
   net/ipv4/route.c: In function 'ip_rt_send_redirect':
   net/ipv4/route.c:877:6: warning: variable 'log_martians' set but not used [-Wunused-but-set-variable]
     877 |  int log_martians;
         |      ^~~~~~~~~~~~
--
   In file included from net/ipv4/tcp.c:274:
   include/net/tcp.h: In function 'tcp_skb_timestamp':
>> include/net/tcp.h:812:25: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     812 |  return tcp_ns_to_ts(skb->skb_mstamp_ns);
         |                         ^~
   include/net/tcp.h: In function 'tcp_skb_timestamp_us':
   include/net/tcp.h:818:20: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     818 |  return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
         |                    ^~
   include/net/tcp.h: In function 'tcp_add_tx_delay':
>> include/net/tcp.h:2367:6: error: 'struct sk_buff' has no member named 'skb_mstamp_ns'
    2367 |   skb->skb_mstamp_ns += (u64)tp->tcp_tx_delay * NSEC_PER_USEC;
         |      ^~
   net/ipv4/tcp.c: In function 'tcp_get_timestamping_opt_stats':
>> net/ipv4/tcp.c:3901:48: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
    3901 |  nla_put_u64_64bit(stats, TCP_NLA_EDT, orig_skb->skb_mstamp_ns,
         |                                                ^~
--
   In file included from net/ipv4/tcp_input.c:74:
   include/net/tcp.h: In function 'tcp_skb_timestamp':
>> include/net/tcp.h:812:25: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     812 |  return tcp_ns_to_ts(skb->skb_mstamp_ns);
         |                         ^~
   include/net/tcp.h: In function 'tcp_skb_timestamp_us':
   include/net/tcp.h:818:20: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     818 |  return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
         |                    ^~
   include/net/tcp.h: In function 'tcp_add_tx_delay':
>> include/net/tcp.h:2367:6: error: 'struct sk_buff' has no member named 'skb_mstamp_ns'
    2367 |   skb->skb_mstamp_ns += (u64)tp->tcp_tx_delay * NSEC_PER_USEC;
         |      ^~
   include/net/tcp.h: In function 'tcp_skb_timestamp_us':
   include/net/tcp.h:819:1: error: control reaches end of non-void function [-Werror=return-type]
     819 | }
         | ^
   include/net/tcp.h: In function 'tcp_skb_timestamp':
   include/net/tcp.h:813:1: error: control reaches end of non-void function [-Werror=return-type]
     813 | }
         | ^
   cc1: some warnings being treated as errors
--
   In file included from net/ipv4/tcp_output.c:40:
   include/net/tcp.h: In function 'tcp_skb_timestamp':
>> include/net/tcp.h:812:25: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     812 |  return tcp_ns_to_ts(skb->skb_mstamp_ns);
         |                         ^~
   include/net/tcp.h: In function 'tcp_skb_timestamp_us':
   include/net/tcp.h:818:20: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     818 |  return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
         |                    ^~
   include/net/tcp.h: In function 'tcp_add_tx_delay':
>> include/net/tcp.h:2367:6: error: 'struct sk_buff' has no member named 'skb_mstamp_ns'
    2367 |   skb->skb_mstamp_ns += (u64)tp->tcp_tx_delay * NSEC_PER_USEC;
         |      ^~
   net/ipv4/tcp_output.c: In function 'tcp_make_synack':
>> net/ipv4/tcp_output.c:3564:32: error: expected ';' before 'if'
    3564 |   skb_set_tstamp_mono(skb, now)
         |                                ^
         |                                ;
    3565 |   if (!tcp_rsk(req)->snt_synack) /* Timestamp first SYNACK */
         |   ~~                            
   net/ipv4/tcp_output.c: In function 'tcp_send_syn_data':
>> net/ipv4/tcp_output.c:3790:35: error: 'struct sk_buff' has no member named 'skb_mstamp_ns'
    3790 |  skb_set_tstamp_mono(syn, syn_data->skb_mstamp_ns);
         |                                   ^~
   In file included from net/ipv4/tcp_output.c:40:
   include/net/tcp.h: In function 'tcp_skb_timestamp':
   include/net/tcp.h:813:1: error: control reaches end of non-void function [-Werror=return-type]
     813 | }
         | ^
   include/net/tcp.h: In function 'tcp_skb_timestamp_us':
   include/net/tcp.h:819:1: error: control reaches end of non-void function [-Werror=return-type]
     819 | }
         | ^
   cc1: some warnings being treated as errors
--
   In file included from net/ipv4/tcp_ipv4.c:64:
   include/net/tcp.h: In function 'tcp_skb_timestamp':
>> include/net/tcp.h:812:25: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     812 |  return tcp_ns_to_ts(skb->skb_mstamp_ns);
         |                         ^~
   include/net/tcp.h: In function 'tcp_skb_timestamp_us':
   include/net/tcp.h:818:20: error: 'const struct sk_buff' has no member named 'skb_mstamp_ns'
     818 |  return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
         |                    ^~
   include/net/tcp.h: In function 'tcp_add_tx_delay':
>> include/net/tcp.h:2367:6: error: 'struct sk_buff' has no member named 'skb_mstamp_ns'
    2367 |   skb->skb_mstamp_ns += (u64)tp->tcp_tx_delay * NSEC_PER_USEC;
         |      ^~
   include/net/tcp.h: In function 'tcp_skb_timestamp_us':
   include/net/tcp.h:819:1: error: control reaches end of non-void function [-Werror=return-type]
     819 | }
         | ^
   cc1: some warnings being treated as errors


vim +812 include/net/tcp.h

^1da177e4c3f415 Linus Torvalds 2005-04-16  809  
7faee5c0d514162 Eric Dumazet   2014-09-05  810  static inline u32 tcp_skb_timestamp(const struct sk_buff *skb)
7faee5c0d514162 Eric Dumazet   2014-09-05  811  {
200ecef67b8d09d Eric Dumazet   2019-11-07 @812  	return tcp_ns_to_ts(skb->skb_mstamp_ns);
7faee5c0d514162 Eric Dumazet   2014-09-05  813  }
7faee5c0d514162 Eric Dumazet   2014-09-05  814  

:::::: The code at line 812 was first introduced by commit
:::::: 200ecef67b8d09d16ec55f91c92751dcc7a38d40 tcp: Remove one extra ktime_get_ns() from cookie_init_timestamp

:::::: TO: Eric Dumazet <edumazet@google.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--7AUc2qLy4jB3hD7Z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ObwXSS1VJIhpPdemlqfMiuSC1lA+zIdnFl0lpqX/nNk442/57mIXRl44MqBVtPCEMpFeookE
H4f+NSbk2Mos9bePL3kvjg7DVvzSiURnnkTXpOXt3SsHKPR+gl5UecwlXrCYBB/egNka6SBw
GTT+hJXnAm4DCsiTOtq8o5QLmfgeOynDm9S6GVAKU7YoIycJfnAJMFKNv3xHttjUqzDVpcpy
IyO645bN/yq1ZYgF86z0ZIDOrMvt/1V2bc1t6zj4fX+F5zydM5O2cZKmyUMfZF1iNbZk62I7
ffG4jk7iaRJnfNk92V+/BChKpARQ3pm2aQSI4hUEQeCDOAxMOHCdnPHKmwUcAUI3pVsO5XRU
Hg7HfmRAcc28CaV9zMAk3GbGp5wfq6TKW1M5PcoDcmvQxpv1brvf/n3oDT/ei92nWe/pWOwP
lLLbxaodEsRuwZ2MhbLjM+qFELN3nHu19LARM4+RcnOIkYLTU6uFLp5y0u1xR18lkXRtLTnh
aBBTOm4oqpRrsCOGEx4Se5PVUyEDjVLi8NDBKqHcitftoQBgCqruBFW+9f66fyJfMAhS84/d
3p8p4rf14ree+7x5/6tXoS40fAyd15ftk3icbl2qeIosPcl229XjevvKvUjSpWPRYvIl2BXF
fr0SfTPd7sIpV0gXK/JuPo8XXAEtmn78Hm0OhaQOjpuXR7isUp1EFHX6S/jW9Lh6Ec1n+4ek
aysndpemqoUvLyDW+h+uTIpabUonTQrtaA9wAbMg8RkHrQU4fTAHcMDjpC2pjHidzMetpoJr
2FrUkhJcLZpuOEjRxQfUwNGIMJVNhg8GlGIt40q3SmAgKzl8QBjZLHGi1PXbbqHKEGN8QHsf
ThAucxuUOO3t13l73G03j3odnchL4pAOOFXs2v7JqLDgpdfu8OEcXNLW4MxOWOPSZqSJ0mfa
b9UvofMaaRfyGdS9MGbCvUbhmNuA8NbVlQ6pzFaDQGC0CmFeYJWezWKhy/EztB5xjg49gJ0K
MHY5JV2uBU3If8dwJRar5QIiE5mVdNmg1ZQrAyYDH8ClBwD1QZmNb1xhxRAgz3Fpo5viSn03
Z8PfkYm7Xv8x8Izvwu8sM/iZD5Q/drVCQ8COS2XTtIVbPkaARsYoWLIA5KgY9oCWJtoHlgtw
RSS5fiADSVrwpLsgZUdykCX8i1E4srwaXPBvApCkQ6kr/gL0FLMX1TMJnrCMJ6SPPEBWA11i
CupfomP+dQ4h9kLSRSVIpa6v3XU0H4TywbKEfqyLddrHhJI0zePMcA/AB1WYFK79wHEpCxGC
Qpb8cyeJGq2VBP70MYXY81nfQrvg6mvgn8E9VZDiSn41n8lHdS/g0qYnATgsiNNMgyyF02r9
bLoGBCkR7a2UY8kt2b1PSTz+4s08FHm1xFPDlca319fnRs1/xKPQjBb+KdiYWude0GqQqgf9
bXnujNMvgZN98Rfwb5Q1aldrGogiwXx7Jt7lZa6FGGXEWlS7ha1mUr3YF8fHLcIQtPoTxVZg
wJaKB/cmZAI+a4Gnw0MMmxdnpjCLjdWDRHcYjrzEp0ybAPmmfxWhVutfVYBQvTljfJB9H5E8
vHSVdAQZur4i6iQUkMAT51nfMU248gc/AET3VkXCpTCINtG+zDfhTmOhs935vIx1PAst4GlD
KwnsS+xmYanNgCdZ3nITZ8yQ0mnupENuoVi2O8B7XLAyaWxp/YSnTaPFlZV6zVMT20cnFjjn
h3TGvZZbujuJW0QlJsobW2bGRRZVIEgZdG+IYORGN+TGdjzAIBnmdsKNPYef2VzbdEhh8UsF
efvHZr+9ufl6+6mvRfABg/iMj/Lp6vIb3Wid6dtJTN/oMHCD6ebr+SlMdAh6g+mkz51Q8Zvr
U+p0TWsWDaZTKn5N28AbTEwAvMl0Shdc05gNDabbbqbbyxNKuj1lgG8vT+in26sT6nTzje8n
oefA3F/SwL9GMf2LU6otuPhJ4KRuyICXaHXh31ccfM8oDn76KI7uPuEnjuLgx1px8EtLcfAD
WPVHd2P63a3p8825j8ObJRPgpcg0rgyQx44LWxgTs6U4XB/AdzpYxMEnT+gDcMWUxE4Wdn3s
IQlHnCOnYrpzWF/PiiXxmStNxRG64FtKb30VT5SHtBHH6L6uRmV5ch8yWBjAk2cBvYrzKITl
SeyJYbycT3W/PcNKJA3vxfq42xw+qBuze/+B2b9LS8zSG/sp2i+zJGQMWVarjSKSOzqiciq4
eTx/u/HkoYaVN1wBmmz05ySiNfBA2IgFgkCiBNXtdLTAuVE6/v4HeLnDnc0Z/AMhrmcfq9fV
GQS6vm/ezvarvwtR4ObxDDzhn6CHz369//2HkU/gebV7LN5MzC4d/m3ztjlsVi+b/zayomGq
LYmG3cTVRJIE7RQHLNUOxjKimAFGj+U10ciaVWrkOyBaVBnzmxNNtUaGmaurK3f38X7Y9tbb
XdHb7nrPxcu7jtMgmUXz7hw90YXx+KL1HOA8yIeGVbB8Lpaq2OgYzVSyNPHKyAKWXpgi/Dig
JKTEh8C91/YV/MFo3WV782zoM8FZJQuCzjXNL5Pjr5fN+tPv4qO3xv5+AhfCD33tl68nDLhS
SfZocVVSfbeTbi/ed5MOjnRM6wqqC3NxyLj4+rV/2+oD53h4Lt4gayHkKvTfsCMAq/M/m8Nz
z9nvt+sNkrzVYUX0jMvA15TkOzvZHTriz8X5JB499C/P6b1bjbJ/F6b9C1r4q37wpyEdD1N1
5dAR633W6ocB3jy/bh9Ne5yq58A6u9yAdsJVZMbSUpE5q0BZZWvho4R2Ny3Jsb1qk46WLex1
E1vjPOHgJ8thA4+HLLdOA3BzaQ/JcLV/5kdE6Aq2Iocd9EVHw2eN96V1c/NU7A8tMewm7uWF
S4g2JFhrsRg6jK5TcgxGzr1/YR1DyWIdJ1GRrH/ucfBL5Vrtqsspq3Ts0Tp6Rba/HYr16Y/g
p40tGXt95qSuBMHQoc9XNf3iK32uqTm+9q2DJzjoI0sllO3kTOgbA8aJvuSZTxp1kCth8/6s
/AeaMtI6DRzMCWmfS/E84NRvNZmcsS+OHdYNCfBHrSMNDNb+9+xNCfDnKXuLfb9IJuI4Zh9F
64TO5nFXf5UsZTaa9mhuX993xX4vddt2N/Dh8GoH+MkA1UnyzZV1Fo9+WtsnyEPrWmxCzEuf
J3Es2L72ouPrr2JX5g440A10ojRcupOE8zUruyEZ3KHfnY3pRwgRGj74jzAnH01xXQoVedkl
8SrG9N4NJ8NudRiZO9pS8Tm+0+66UvN/2fzarcRJY7c9HjZv5BY4CgenyH5gk2uhk4tUE9t8
ah+AQPOf/neADyRKO2W3qOtG64CNPX1eHY+K3QG8n4Rmukf8gv3m6Q2TQ/XWz8X6dyP5xSns
yD+y9PqkDXpdUgZhBnB7iR5MrFySEA44C3WrvCIFIaSTCROIDzSRxN04aST/rWuRQL6mKB8P
fAanyYUQK1csBbIjXTPtIzBbNQN3GWb5kinrsnFwFA+ESB0FzdOWyTAKXX/wcEO8KimcPEIW
J5nz4hA4BowRSlAZQ7qgsATasCmmrdT5uNfoQ4oMCWX6qOJa/ARQXqL7ohjcqjXvBEgLI56w
gPRIE3KGc/Hxpjrsz6hMg17bRZIpQrISb6biS8pRqlxjraVjmnjUmsSn77vN2+E3Rk8+vhb7
J8rqVuYVbubKadIhjIwRy1o+QplFnYy/c2VYMETsy+Rw6sLsG8sxzcGP4qq+EE9TuBNolXBV
1wUTvpZV9tjMsd5D5AjV1+ZXr3Nw6Gnpw3gQi7W09JME88BrIczwmvgrpNUgTg2oTXZQKi1l
81J8wmzXKDT3yLqWz3fUEMqvNZ29SmKQiJqhc8/3/vnFlT5sCYDUp2NoB3OVLDZOtCk5TMoF
+G7qY6IHcC4YQ7yqHppvUrAWyzgaaf5OsnoItmA6PJW5CjDB0Nx37lXmBtJceHKvGf7q5aLx
il/HpyewImoQhP/SkHqrHIF1io4IuuX7+T99ikvGymvIEi0aGFByH/IM6zivVXoG0uw+SBkg
l5OaY46ZTHHYnK+YReTDsAlXhZk7tFiF/iKDWEDG1isLBEY+0QUWE88jLmwdyGJiQHAko+jJ
r8SDHz5n2ymn6MihEtaixb/sEMSoce7bM1BRbMWjbTwH4UQLSEyRI7kgtR3vvinLm/GLTXqO
oyldszDL/O33jpghWoyzSQVPDEw+FQuuMINk1rCfqfhe0+5eD3urrcMGIKk02AB/L96+7896
o+369/Fdrr/h6u2podxFYikImRDTfpcGHbyJc79OYiaJsFPFeabDZEP8JjhrYkL1jAfdlcTl
MI8AGDOlx2A+tcfdIwqx/Bq5HO19IW/BVNYjY30ZswV728AzgcetbC/1fQdRZHPsoOfufb+Z
zkFq5GCWrUXHn/v3zRsiKJz1Xo+H4p9C/Kc4rD9//vxXXVV0oMWyIYZJCwvStAeIcCsdaWkd
D8qAdlkWRJ3lzrYKiWCoBkt3IfO5ZBIiI55D6jVbreapz2yckgGbxsu/mgk6D0+/pb5KF4rF
iamdAegvq9bWLbApv6kbdBflpp786NwJM0pZUirp/zF3WlpLmf+aUq8qvdLEPkvwvnGZRxD9
Cul1+FzipQiXO4R9BzCUNU2olVkcH1eHVQ+203Urz3U5jiHTi+VW2EFn8vVJIrp+h9xBFPfA
aOkBlrXQVJOccE43ZBPTpOZX3UR0L4C7mtk0pOHJzWndQBDE5HJGlmkFLJ1zD5gSPziprKTh
3G5Q/SkBrlPHBhrtaEmDaamAJoTqqValTEvYgHhQe4WomikZldrbmtdiIYhtLJCtYQ5auDNY
GIZzURsbQ5xGQqHybSyII9RRjFR/6+xGyMnk5UHaMo2cSTqMqTU4EOtXnA3EToFBF00XA/Xc
icQqEH3tlS8wYrxiB/R7G2OV5jK2TKD0IcqGS0zxYGkenl6WAzENhs2MS1q9MNlsiIcICFPg
RTOm22gvueMrpS34TjJ6KE+8uiJncOsmgkxmaEGVxN3+u9itngrDCyePOPeiUgrBcReRPH/4
fIo/OTNIHt2sgnqrG89a6qpQUsVj2b/LiXHpB/xEeQnkCx5LWQFrrhk9jnobZCCAYHles0tb
idl1qhfOGOvWoDKCwMZrkVgDuI+y0CFLYRqPYgj9ZrnwuCzU46W9sDJJIEt3sngcutdXdmUB
Wz70F5D+g7EAJSjlOgspGaUnFLOiSr7UZe4WkOFecGRMICQy4Iqgja3yC64TWcjS7sbT87wZ
YqpTF06SMKYnpEOoUiAUTJ4jgRsThGW0jAh3qYLU0OPiSuH4ck/rS6rtcRNNQqfPLMkrZeek
mIDGNn6Dia3zR2ItDWPcYWgvEzTpQ4pvu9DF0lRKHctcwFAiS3t4S2I5W9HPj/VflDN2HFtm
jDjXu2LPtcmlDO9FGNmsCrEzoOcd2FXoM6R1h2i53klL8/8AOZYfh5KVAAA=

--7AUc2qLy4jB3hD7Z--

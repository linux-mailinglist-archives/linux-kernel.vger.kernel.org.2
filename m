Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8CB35FFA2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 03:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhDOBc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 21:32:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:42279 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhDOBc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 21:32:57 -0400
IronPort-SDR: S+HrzGR7r9xz545T5SJoU+Vq4JiTmCiwNDcYY8paOglWc8YZenR516DrC+BP/Ty36E5RX96DDA
 iAmUvT8nw0tw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="256091473"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="gz'50?scan'50,208,50";a="256091473"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 18:32:34 -0700
IronPort-SDR: bxYg9FT1o2T3K2qAq+36bl2bq+T0rUX2VzygDZ734fc4xjTonYQJAkB7kQbHJdoFgrGpYcqvgP
 ez2J5HwQUTaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="gz'50?scan'50,208,50";a="399395389"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2021 18:32:31 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWqru-0000Yi-Ac; Thu, 15 Apr 2021 01:32:30 +0000
Date:   Thu, 15 Apr 2021 09:32:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds 1/10]
 net/core/flow_dissector.c:835:3: warning: 'memcpy' offset [33, 48] from the
 object at 'flow_keys' is out of the bounds of referenced subobject
 'ipv6_src' with type '__u32[4]' {aka 'unsigned int[4]'} at offset 16
Message-ID: <202104150913.hupgUSHL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
head:   4695107c157dd670a5fc1b1d3ccbfdc440caca24
commit: 06f7d86a7f517e6ce30162d18a7eef3ed192282a [1/10] Makefile: Enable -Warray-bounds
config: x86_64-randconfig-r026-20210414 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=06f7d86a7f517e6ce30162d18a7eef3ed192282a
        git remote add gustavoars-linux https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars-linux testing/warray-bounds
        git checkout 06f7d86a7f517e6ce30162d18a7eef3ed192282a
        # save the attached .config to linux build tree
        make W=1 W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In function '__skb_flow_bpf_to_target',
       inlined from '__skb_flow_dissect' at net/core/flow_dissector.c:1014:4:
>> net/core/flow_dissector.c:835:3: warning: 'memcpy' offset [33, 48] from the object at 'flow_keys' is out of the bounds of referenced subobject 'ipv6_src' with type '__u32[4]' {aka 'unsigned int[4]'} at offset 16 [-Warray-bounds]
     835 |   memcpy(&key_addrs->v6addrs, &flow_keys->ipv6_src,
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     836 |          sizeof(key_addrs->v6addrs));
         |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   net/ethtool/ioctl.c: In function 'store_link_ksettings_for_user.constprop':
>> net/ethtool/ioctl.c:492:2: warning: 'memcpy' offset [49, 84] from the object at 'link_usettings' is out of the bounds of referenced subobject 'base' with type 'struct ethtool_link_settings' at offset 0 [-Warray-bounds]
     492 |  memcpy(&link_usettings.base, &from->base, sizeof(link_usettings));
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +835 net/core/flow_dissector.c

1eed4dfb81b193 Tom Herbert        2017-09-01   793  
d58e468b1112dc Petar Penkov       2018-09-14   794  static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
d58e468b1112dc Petar Penkov       2018-09-14   795  				     struct flow_dissector *flow_dissector,
d58e468b1112dc Petar Penkov       2018-09-14   796  				     void *target_container)
d58e468b1112dc Petar Penkov       2018-09-14   797  {
59fb9b62fb6c92 Yoshiki Komachi    2020-01-17   798  	struct flow_dissector_key_ports *key_ports = NULL;
d58e468b1112dc Petar Penkov       2018-09-14   799  	struct flow_dissector_key_control *key_control;
d58e468b1112dc Petar Penkov       2018-09-14   800  	struct flow_dissector_key_basic *key_basic;
d58e468b1112dc Petar Penkov       2018-09-14   801  	struct flow_dissector_key_addrs *key_addrs;
71c99e32b92615 Stanislav Fomichev 2019-07-25   802  	struct flow_dissector_key_tags *key_tags;
d58e468b1112dc Petar Penkov       2018-09-14   803  
d58e468b1112dc Petar Penkov       2018-09-14   804  	key_control = skb_flow_dissector_target(flow_dissector,
d58e468b1112dc Petar Penkov       2018-09-14   805  						FLOW_DISSECTOR_KEY_CONTROL,
d58e468b1112dc Petar Penkov       2018-09-14   806  						target_container);
d58e468b1112dc Petar Penkov       2018-09-14   807  	key_control->thoff = flow_keys->thoff;
d58e468b1112dc Petar Penkov       2018-09-14   808  	if (flow_keys->is_frag)
d58e468b1112dc Petar Penkov       2018-09-14   809  		key_control->flags |= FLOW_DIS_IS_FRAGMENT;
d58e468b1112dc Petar Penkov       2018-09-14   810  	if (flow_keys->is_first_frag)
d58e468b1112dc Petar Penkov       2018-09-14   811  		key_control->flags |= FLOW_DIS_FIRST_FRAG;
d58e468b1112dc Petar Penkov       2018-09-14   812  	if (flow_keys->is_encap)
d58e468b1112dc Petar Penkov       2018-09-14   813  		key_control->flags |= FLOW_DIS_ENCAPSULATION;
d58e468b1112dc Petar Penkov       2018-09-14   814  
d58e468b1112dc Petar Penkov       2018-09-14   815  	key_basic = skb_flow_dissector_target(flow_dissector,
d58e468b1112dc Petar Penkov       2018-09-14   816  					      FLOW_DISSECTOR_KEY_BASIC,
d58e468b1112dc Petar Penkov       2018-09-14   817  					      target_container);
d58e468b1112dc Petar Penkov       2018-09-14   818  	key_basic->n_proto = flow_keys->n_proto;
d58e468b1112dc Petar Penkov       2018-09-14   819  	key_basic->ip_proto = flow_keys->ip_proto;
d58e468b1112dc Petar Penkov       2018-09-14   820  
d58e468b1112dc Petar Penkov       2018-09-14   821  	if (flow_keys->addr_proto == ETH_P_IP &&
d58e468b1112dc Petar Penkov       2018-09-14   822  	    dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
d58e468b1112dc Petar Penkov       2018-09-14   823  		key_addrs = skb_flow_dissector_target(flow_dissector,
d58e468b1112dc Petar Penkov       2018-09-14   824  						      FLOW_DISSECTOR_KEY_IPV4_ADDRS,
d58e468b1112dc Petar Penkov       2018-09-14   825  						      target_container);
d58e468b1112dc Petar Penkov       2018-09-14   826  		key_addrs->v4addrs.src = flow_keys->ipv4_src;
d58e468b1112dc Petar Penkov       2018-09-14   827  		key_addrs->v4addrs.dst = flow_keys->ipv4_dst;
d58e468b1112dc Petar Penkov       2018-09-14   828  		key_control->addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
d58e468b1112dc Petar Penkov       2018-09-14   829  	} else if (flow_keys->addr_proto == ETH_P_IPV6 &&
d58e468b1112dc Petar Penkov       2018-09-14   830  		   dissector_uses_key(flow_dissector,
d58e468b1112dc Petar Penkov       2018-09-14   831  				      FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
d58e468b1112dc Petar Penkov       2018-09-14   832  		key_addrs = skb_flow_dissector_target(flow_dissector,
d58e468b1112dc Petar Penkov       2018-09-14   833  						      FLOW_DISSECTOR_KEY_IPV6_ADDRS,
d58e468b1112dc Petar Penkov       2018-09-14   834  						      target_container);
d58e468b1112dc Petar Penkov       2018-09-14  @835  		memcpy(&key_addrs->v6addrs, &flow_keys->ipv6_src,
d58e468b1112dc Petar Penkov       2018-09-14   836  		       sizeof(key_addrs->v6addrs));
d58e468b1112dc Petar Penkov       2018-09-14   837  		key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
d58e468b1112dc Petar Penkov       2018-09-14   838  	}
d58e468b1112dc Petar Penkov       2018-09-14   839  
59fb9b62fb6c92 Yoshiki Komachi    2020-01-17   840  	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
d58e468b1112dc Petar Penkov       2018-09-14   841  		key_ports = skb_flow_dissector_target(flow_dissector,
d58e468b1112dc Petar Penkov       2018-09-14   842  						      FLOW_DISSECTOR_KEY_PORTS,
d58e468b1112dc Petar Penkov       2018-09-14   843  						      target_container);
59fb9b62fb6c92 Yoshiki Komachi    2020-01-17   844  	else if (dissector_uses_key(flow_dissector,
59fb9b62fb6c92 Yoshiki Komachi    2020-01-17   845  				    FLOW_DISSECTOR_KEY_PORTS_RANGE))
59fb9b62fb6c92 Yoshiki Komachi    2020-01-17   846  		key_ports = skb_flow_dissector_target(flow_dissector,
59fb9b62fb6c92 Yoshiki Komachi    2020-01-17   847  						      FLOW_DISSECTOR_KEY_PORTS_RANGE,
59fb9b62fb6c92 Yoshiki Komachi    2020-01-17   848  						      target_container);
59fb9b62fb6c92 Yoshiki Komachi    2020-01-17   849  
59fb9b62fb6c92 Yoshiki Komachi    2020-01-17   850  	if (key_ports) {
d58e468b1112dc Petar Penkov       2018-09-14   851  		key_ports->src = flow_keys->sport;
d58e468b1112dc Petar Penkov       2018-09-14   852  		key_ports->dst = flow_keys->dport;
d58e468b1112dc Petar Penkov       2018-09-14   853  	}
71c99e32b92615 Stanislav Fomichev 2019-07-25   854  
71c99e32b92615 Stanislav Fomichev 2019-07-25   855  	if (dissector_uses_key(flow_dissector,
71c99e32b92615 Stanislav Fomichev 2019-07-25   856  			       FLOW_DISSECTOR_KEY_FLOW_LABEL)) {
71c99e32b92615 Stanislav Fomichev 2019-07-25   857  		key_tags = skb_flow_dissector_target(flow_dissector,
71c99e32b92615 Stanislav Fomichev 2019-07-25   858  						     FLOW_DISSECTOR_KEY_FLOW_LABEL,
71c99e32b92615 Stanislav Fomichev 2019-07-25   859  						     target_container);
71c99e32b92615 Stanislav Fomichev 2019-07-25   860  		key_tags->flow_label = ntohl(flow_keys->flow_label);
71c99e32b92615 Stanislav Fomichev 2019-07-25   861  	}
d58e468b1112dc Petar Penkov       2018-09-14   862  }
d58e468b1112dc Petar Penkov       2018-09-14   863  
089b19a9204fc0 Stanislav Fomichev 2019-04-22   864  bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
086f95682114fd Stanislav Fomichev 2019-07-25   865  		      __be16 proto, int nhoff, int hlen, unsigned int flags)
089b19a9204fc0 Stanislav Fomichev 2019-04-22   866  {
089b19a9204fc0 Stanislav Fomichev 2019-04-22   867  	struct bpf_flow_keys *flow_keys = ctx->flow_keys;
089b19a9204fc0 Stanislav Fomichev 2019-04-22   868  	u32 result;
c8aa703822bf81 Stanislav Fomichev 2019-01-28   869  
c8aa703822bf81 Stanislav Fomichev 2019-01-28   870  	/* Pass parameters to the BPF program */
c8aa703822bf81 Stanislav Fomichev 2019-01-28   871  	memset(flow_keys, 0, sizeof(*flow_keys));
089b19a9204fc0 Stanislav Fomichev 2019-04-22   872  	flow_keys->n_proto = proto;
089b19a9204fc0 Stanislav Fomichev 2019-04-22   873  	flow_keys->nhoff = nhoff;
c8aa703822bf81 Stanislav Fomichev 2019-01-28   874  	flow_keys->thoff = flow_keys->nhoff;
c8aa703822bf81 Stanislav Fomichev 2019-01-28   875  
086f95682114fd Stanislav Fomichev 2019-07-25   876  	BUILD_BUG_ON((int)BPF_FLOW_DISSECTOR_F_PARSE_1ST_FRAG !=
086f95682114fd Stanislav Fomichev 2019-07-25   877  		     (int)FLOW_DISSECTOR_F_PARSE_1ST_FRAG);
086f95682114fd Stanislav Fomichev 2019-07-25   878  	BUILD_BUG_ON((int)BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL !=
086f95682114fd Stanislav Fomichev 2019-07-25   879  		     (int)FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
086f95682114fd Stanislav Fomichev 2019-07-25   880  	BUILD_BUG_ON((int)BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP !=
086f95682114fd Stanislav Fomichev 2019-07-25   881  		     (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
086f95682114fd Stanislav Fomichev 2019-07-25   882  	flow_keys->flags = flags;
086f95682114fd Stanislav Fomichev 2019-07-25   883  
3d9f773cf2876c David Miller       2020-02-24   884  	result = bpf_prog_run_pin_on_cpu(prog, ctx);
c8aa703822bf81 Stanislav Fomichev 2019-01-28   885  
089b19a9204fc0 Stanislav Fomichev 2019-04-22   886  	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
c8aa703822bf81 Stanislav Fomichev 2019-01-28   887  	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
089b19a9204fc0 Stanislav Fomichev 2019-04-22   888  				   flow_keys->nhoff, hlen);
c8aa703822bf81 Stanislav Fomichev 2019-01-28   889  
c8aa703822bf81 Stanislav Fomichev 2019-01-28   890  	return result == BPF_OK;
c8aa703822bf81 Stanislav Fomichev 2019-01-28   891  }
c8aa703822bf81 Stanislav Fomichev 2019-01-28   892  
453a940ea725d6 WANG Cong          2014-08-25   893  /**
453a940ea725d6 WANG Cong          2014-08-25   894   * __skb_flow_dissect - extract the flow_keys struct and return it
3cbf4ffba5eeec Stanislav Fomichev 2019-04-22   895   * @net: associated network namespace, derived from @skb if NULL
453a940ea725d6 WANG Cong          2014-08-25   896   * @skb: sk_buff to extract the flow from, can be NULL if the rest are specified
06635a35d13d42 Jiri Pirko         2015-05-12   897   * @flow_dissector: list of keys to dissect
06635a35d13d42 Jiri Pirko         2015-05-12   898   * @target_container: target structure to put dissected values into
453a940ea725d6 WANG Cong          2014-08-25   899   * @data: raw buffer pointer to the packet, if NULL use skb->data
453a940ea725d6 WANG Cong          2014-08-25   900   * @proto: protocol for which to get the flow, if @data is NULL use skb->protocol
453a940ea725d6 WANG Cong          2014-08-25   901   * @nhoff: network header offset, if @data is NULL use skb_network_offset(skb)
453a940ea725d6 WANG Cong          2014-08-25   902   * @hlen: packet header length, if @data is NULL use skb_headlen(skb)
d79b3bafabc27c Bart Van Assche    2019-03-25   903   * @flags: flags that control the dissection process, e.g.
1cc26450a855aa Stanislav Fomichev 2019-05-31   904   *         FLOW_DISSECTOR_F_STOP_AT_ENCAP.
453a940ea725d6 WANG Cong          2014-08-25   905   *
06635a35d13d42 Jiri Pirko         2015-05-12   906   * The function will try to retrieve individual keys into target specified
06635a35d13d42 Jiri Pirko         2015-05-12   907   * by flow_dissector from either the skbuff or a raw buffer specified by the
06635a35d13d42 Jiri Pirko         2015-05-12   908   * rest parameters.
06635a35d13d42 Jiri Pirko         2015-05-12   909   *
06635a35d13d42 Jiri Pirko         2015-05-12   910   * Caller must take care of zeroing target container memory.
453a940ea725d6 WANG Cong          2014-08-25   911   */
3cbf4ffba5eeec Stanislav Fomichev 2019-04-22   912  bool __skb_flow_dissect(const struct net *net,
3cbf4ffba5eeec Stanislav Fomichev 2019-04-22   913  			const struct sk_buff *skb,
06635a35d13d42 Jiri Pirko         2015-05-12   914  			struct flow_dissector *flow_dissector,
f96533cded173b Alexander Lobakin  2021-03-14   915  			void *target_container, const void *data,
f96533cded173b Alexander Lobakin  2021-03-14   916  			__be16 proto, int nhoff, int hlen, unsigned int flags)
0744dd00c1b1be Eric Dumazet       2011-11-28   917  {
42aecaa9bb2bd5 Tom Herbert        2015-06-04   918  	struct flow_dissector_key_control *key_control;
06635a35d13d42 Jiri Pirko         2015-05-12   919  	struct flow_dissector_key_basic *key_basic;
06635a35d13d42 Jiri Pirko         2015-05-12   920  	struct flow_dissector_key_addrs *key_addrs;
d34af823ff401c Tom Herbert        2015-06-04   921  	struct flow_dissector_key_tags *key_tags;
f6a66927692e30 Hadar Hen Zion     2016-08-17   922  	struct flow_dissector_key_vlan *key_vlan;
3a1214e8b06317 Tom Herbert        2017-09-01   923  	enum flow_dissect_ret fdret;
24c590e3b0f9ee Jianbo Liu         2018-07-06   924  	enum flow_dissector_key_id dissector_vlan = FLOW_DISSECTOR_KEY_MAX;
58cff782cc55eb Guillaume Nault    2020-05-26   925  	bool mpls_el = false;
58cff782cc55eb Guillaume Nault    2020-05-26   926  	int mpls_lse = 0;
1eed4dfb81b193 Tom Herbert        2017-09-01   927  	int num_hdrs = 0;
8e690ffdbcc7b5 Geert Uytterhoeven 2015-06-25   928  	u8 ip_proto = 0;
34fad54c2537f7 Eric Dumazet       2016-11-09   929  	bool ret;
0744dd00c1b1be Eric Dumazet       2011-11-28   930  
690e36e726d00d David S. Miller    2014-08-23   931  	if (!data) {
690e36e726d00d David S. Miller    2014-08-23   932  		data = skb->data;
d5709f7ab77679 Hadar Hen Zion     2016-08-17   933  		proto = skb_vlan_tag_present(skb) ?
d5709f7ab77679 Hadar Hen Zion     2016-08-17   934  			 skb->vlan_proto : skb->protocol;
453a940ea725d6 WANG Cong          2014-08-25   935  		nhoff = skb_network_offset(skb);
690e36e726d00d David S. Miller    2014-08-23   936  		hlen = skb_headlen(skb);
2d5716456404a1 John Crispin       2017-08-10   937  #if IS_ENABLED(CONFIG_NET_DSA)
8bef0af09a5415 Alexander Lobakin  2019-12-05   938  		if (unlikely(skb->dev && netdev_uses_dsa(skb->dev) &&
8bef0af09a5415 Alexander Lobakin  2019-12-05   939  			     proto == htons(ETH_P_XDSA))) {
43e665287f931a John Crispin       2017-08-09   940  			const struct dsa_device_ops *ops;
8bef0af09a5415 Alexander Lobakin  2019-12-05   941  			int offset = 0;
43e665287f931a John Crispin       2017-08-09   942  
43e665287f931a John Crispin       2017-08-09   943  			ops = skb->dev->dsa_ptr->tag_ops;
54fec33582aa60 Vladimir Oltean    2020-09-26   944  			/* Tail taggers don't break flow dissection */
54fec33582aa60 Vladimir Oltean    2020-09-26   945  			if (!ops->tail_tag) {
54fec33582aa60 Vladimir Oltean    2020-09-26   946  				if (ops->flow_dissect)
2e8cb1b3db3843 Vladimir Oltean    2020-09-26   947  					ops->flow_dissect(skb, &proto, &offset);
54fec33582aa60 Vladimir Oltean    2020-09-26   948  				else
54fec33582aa60 Vladimir Oltean    2020-09-26   949  					dsa_tag_generic_flow_dissect(skb,
54fec33582aa60 Vladimir Oltean    2020-09-26   950  								     &proto,
54fec33582aa60 Vladimir Oltean    2020-09-26   951  								     &offset);
43e665287f931a John Crispin       2017-08-09   952  				hlen -= offset;
43e665287f931a John Crispin       2017-08-09   953  				nhoff += offset;
43e665287f931a John Crispin       2017-08-09   954  			}
43e665287f931a John Crispin       2017-08-09   955  		}
2d5716456404a1 John Crispin       2017-08-10   956  #endif
690e36e726d00d David S. Miller    2014-08-23   957  	}
690e36e726d00d David S. Miller    2014-08-23   958  
42aecaa9bb2bd5 Tom Herbert        2015-06-04   959  	/* It is ensured by skb_flow_dissector_init() that control key will
42aecaa9bb2bd5 Tom Herbert        2015-06-04   960  	 * be always present.
42aecaa9bb2bd5 Tom Herbert        2015-06-04   961  	 */
42aecaa9bb2bd5 Tom Herbert        2015-06-04   962  	key_control = skb_flow_dissector_target(flow_dissector,
42aecaa9bb2bd5 Tom Herbert        2015-06-04   963  						FLOW_DISSECTOR_KEY_CONTROL,
42aecaa9bb2bd5 Tom Herbert        2015-06-04   964  						target_container);
42aecaa9bb2bd5 Tom Herbert        2015-06-04   965  
06635a35d13d42 Jiri Pirko         2015-05-12   966  	/* It is ensured by skb_flow_dissector_init() that basic key will
06635a35d13d42 Jiri Pirko         2015-05-12   967  	 * be always present.
06635a35d13d42 Jiri Pirko         2015-05-12   968  	 */
06635a35d13d42 Jiri Pirko         2015-05-12   969  	key_basic = skb_flow_dissector_target(flow_dissector,
06635a35d13d42 Jiri Pirko         2015-05-12   970  					      FLOW_DISSECTOR_KEY_BASIC,
06635a35d13d42 Jiri Pirko         2015-05-12   971  					      target_container);
0744dd00c1b1be Eric Dumazet       2011-11-28   972  
d0e13a1488ad30 Willem de Bruijn   2018-09-24   973  	if (skb) {
3cbf4ffba5eeec Stanislav Fomichev 2019-04-22   974  		if (!net) {
d0e13a1488ad30 Willem de Bruijn   2018-09-24   975  			if (skb->dev)
3cbf4ffba5eeec Stanislav Fomichev 2019-04-22   976  				net = dev_net(skb->dev);
d0e13a1488ad30 Willem de Bruijn   2018-09-24   977  			else if (skb->sk)
3cbf4ffba5eeec Stanislav Fomichev 2019-04-22   978  				net = sock_net(skb->sk);
9b52e3f267a683 Stanislav Fomichev 2019-04-22   979  		}
3cbf4ffba5eeec Stanislav Fomichev 2019-04-22   980  	}
3cbf4ffba5eeec Stanislav Fomichev 2019-04-22   981  
9b52e3f267a683 Stanislav Fomichev 2019-04-22   982  	WARN_ON_ONCE(!net);
9b52e3f267a683 Stanislav Fomichev 2019-04-22   983  	if (net) {
a3fd7ceee05431 Jakub Sitnicki     2020-05-31   984  		enum netns_bpf_attach_type type = NETNS_BPF_FLOW_DISSECTOR;
695c12147a4018 Jakub Sitnicki     2020-06-25   985  		struct bpf_prog_array *run_array;
a3fd7ceee05431 Jakub Sitnicki     2020-05-31   986  
9b52e3f267a683 Stanislav Fomichev 2019-04-22   987  		rcu_read_lock();
695c12147a4018 Jakub Sitnicki     2020-06-25   988  		run_array = rcu_dereference(init_net.bpf.run_array[type]);
695c12147a4018 Jakub Sitnicki     2020-06-25   989  		if (!run_array)
695c12147a4018 Jakub Sitnicki     2020-06-25   990  			run_array = rcu_dereference(net->bpf.run_array[type]);
a11c397c43d5b2 Stanislav Fomichev 2019-10-07   991  
695c12147a4018 Jakub Sitnicki     2020-06-25   992  		if (run_array) {
9b52e3f267a683 Stanislav Fomichev 2019-04-22   993  			struct bpf_flow_keys flow_keys;
9b52e3f267a683 Stanislav Fomichev 2019-04-22   994  			struct bpf_flow_dissector ctx = {
9b52e3f267a683 Stanislav Fomichev 2019-04-22   995  				.flow_keys = &flow_keys,
9b52e3f267a683 Stanislav Fomichev 2019-04-22   996  				.data = data,
9b52e3f267a683 Stanislav Fomichev 2019-04-22   997  				.data_end = data + hlen,
9b52e3f267a683 Stanislav Fomichev 2019-04-22   998  			};
9b52e3f267a683 Stanislav Fomichev 2019-04-22   999  			__be16 n_proto = proto;
695c12147a4018 Jakub Sitnicki     2020-06-25  1000  			struct bpf_prog *prog;
9b52e3f267a683 Stanislav Fomichev 2019-04-22  1001  
9b52e3f267a683 Stanislav Fomichev 2019-04-22  1002  			if (skb) {
9b52e3f267a683 Stanislav Fomichev 2019-04-22  1003  				ctx.skb = skb;
9b52e3f267a683 Stanislav Fomichev 2019-04-22  1004  				/* we can't use 'proto' in the skb case
9b52e3f267a683 Stanislav Fomichev 2019-04-22  1005  				 * because it might be set to skb->vlan_proto
9b52e3f267a683 Stanislav Fomichev 2019-04-22  1006  				 * which has been pulled from the data
9b52e3f267a683 Stanislav Fomichev 2019-04-22  1007  				 */
9b52e3f267a683 Stanislav Fomichev 2019-04-22  1008  				n_proto = skb->protocol;
9b52e3f267a683 Stanislav Fomichev 2019-04-22  1009  			}
9b52e3f267a683 Stanislav Fomichev 2019-04-22  1010  
695c12147a4018 Jakub Sitnicki     2020-06-25  1011  			prog = READ_ONCE(run_array->items[0].prog);
695c12147a4018 Jakub Sitnicki     2020-06-25  1012  			ret = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
086f95682114fd Stanislav Fomichev 2019-07-25  1013  					       hlen, flags);
d58e468b1112dc Petar Penkov       2018-09-14 @1014  			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
d58e468b1112dc Petar Penkov       2018-09-14  1015  						 target_container);
d58e468b1112dc Petar Penkov       2018-09-14  1016  			rcu_read_unlock();
c8aa703822bf81 Stanislav Fomichev 2019-01-28  1017  			return ret;
d58e468b1112dc Petar Penkov       2018-09-14  1018  		}
d58e468b1112dc Petar Penkov       2018-09-14  1019  		rcu_read_unlock();
c8aa703822bf81 Stanislav Fomichev 2019-01-28  1020  	}
d58e468b1112dc Petar Penkov       2018-09-14  1021  
20a17bf6c04e3e David S. Miller    2015-09-01  1022  	if (dissector_uses_key(flow_dissector,
67a900cc0436d7 Jiri Pirko         2015-05-12  1023  			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
67a900cc0436d7 Jiri Pirko         2015-05-12  1024  		struct ethhdr *eth = eth_hdr(skb);
67a900cc0436d7 Jiri Pirko         2015-05-12  1025  		struct flow_dissector_key_eth_addrs *key_eth_addrs;
67a900cc0436d7 Jiri Pirko         2015-05-12  1026  
67a900cc0436d7 Jiri Pirko         2015-05-12  1027  		key_eth_addrs = skb_flow_dissector_target(flow_dissector,
67a900cc0436d7 Jiri Pirko         2015-05-12  1028  							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
67a900cc0436d7 Jiri Pirko         2015-05-12  1029  							  target_container);
67a900cc0436d7 Jiri Pirko         2015-05-12  1030  		memcpy(key_eth_addrs, &eth->h_dest, sizeof(*key_eth_addrs));
67a900cc0436d7 Jiri Pirko         2015-05-12  1031  	}
67a900cc0436d7 Jiri Pirko         2015-05-12  1032  
c5ef188e931869 Jiri Pirko         2017-03-06  1033  proto_again:
3a1214e8b06317 Tom Herbert        2017-09-01  1034  	fdret = FLOW_DISSECT_RET_CONTINUE;
3a1214e8b06317 Tom Herbert        2017-09-01  1035  
0744dd00c1b1be Eric Dumazet       2011-11-28  1036  	switch (proto) {
2b8837aeaaa0bb Joe Perches        2014-03-12  1037  	case htons(ETH_P_IP): {
0744dd00c1b1be Eric Dumazet       2011-11-28  1038  		const struct iphdr *iph;
0744dd00c1b1be Eric Dumazet       2011-11-28  1039  		struct iphdr _iph;
3a1214e8b06317 Tom Herbert        2017-09-01  1040  
690e36e726d00d David S. Miller    2014-08-23  1041  		iph = __skb_header_pointer(skb, nhoff, sizeof(_iph), data, hlen, &_iph);
3a1214e8b06317 Tom Herbert        2017-09-01  1042  		if (!iph || iph->ihl < 5) {
3a1214e8b06317 Tom Herbert        2017-09-01  1043  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert        2017-09-01  1044  			break;
3a1214e8b06317 Tom Herbert        2017-09-01  1045  		}
3a1214e8b06317 Tom Herbert        2017-09-01  1046  
3797d3e8462efd Eric Dumazet       2013-11-07  1047  		nhoff += iph->ihl * 4;
0744dd00c1b1be Eric Dumazet       2011-11-28  1048  
3797d3e8462efd Eric Dumazet       2013-11-07  1049  		ip_proto = iph->protocol;
3797d3e8462efd Eric Dumazet       2013-11-07  1050  
918c023f29ab2d Alexander Duyck    2016-02-24  1051  		if (dissector_uses_key(flow_dissector,
918c023f29ab2d Alexander Duyck    2016-02-24  1052  				       FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
06635a35d13d42 Jiri Pirko         2015-05-12  1053  			key_addrs = skb_flow_dissector_target(flow_dissector,
918c023f29ab2d Alexander Duyck    2016-02-24  1054  							      FLOW_DISSECTOR_KEY_IPV4_ADDRS,
918c023f29ab2d Alexander Duyck    2016-02-24  1055  							      target_container);
918c023f29ab2d Alexander Duyck    2016-02-24  1056  
c3f8324188fa80 Tom Herbert        2015-06-04  1057  			memcpy(&key_addrs->v4addrs, &iph->saddr,
c3f8324188fa80 Tom Herbert        2015-06-04  1058  			       sizeof(key_addrs->v4addrs));
c3f8324188fa80 Tom Herbert        2015-06-04  1059  			key_control->addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
918c023f29ab2d Alexander Duyck    2016-02-24  1060  		}
807e165dc44fd9 Tom Herbert        2015-09-01  1061  
d2126838050ccd Davide Caratti     2021-02-12  1062  		__skb_flow_dissect_ipv4(skb, flow_dissector,
d2126838050ccd Davide Caratti     2021-02-12  1063  					target_container, data, iph);
d2126838050ccd Davide Caratti     2021-02-12  1064  
807e165dc44fd9 Tom Herbert        2015-09-01  1065  		if (ip_is_fragment(iph)) {
4b36993d3df083 David S. Miller    2015-09-01  1066  			key_control->flags |= FLOW_DIS_IS_FRAGMENT;
807e165dc44fd9 Tom Herbert        2015-09-01  1067  
807e165dc44fd9 Tom Herbert        2015-09-01  1068  			if (iph->frag_off & htons(IP_OFFSET)) {
3a1214e8b06317 Tom Herbert        2017-09-01  1069  				fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert        2017-09-01  1070  				break;
807e165dc44fd9 Tom Herbert        2015-09-01  1071  			} else {
4b36993d3df083 David S. Miller    2015-09-01  1072  				key_control->flags |= FLOW_DIS_FIRST_FRAG;
3a1214e8b06317 Tom Herbert        2017-09-01  1073  				if (!(flags &
3a1214e8b06317 Tom Herbert        2017-09-01  1074  				      FLOW_DISSECTOR_F_PARSE_1ST_FRAG)) {
3a1214e8b06317 Tom Herbert        2017-09-01  1075  					fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert        2017-09-01  1076  					break;
3a1214e8b06317 Tom Herbert        2017-09-01  1077  				}
807e165dc44fd9 Tom Herbert        2015-09-01  1078  			}
807e165dc44fd9 Tom Herbert        2015-09-01  1079  		}
807e165dc44fd9 Tom Herbert        2015-09-01  1080  
0744dd00c1b1be Eric Dumazet       2011-11-28  1081  		break;
0744dd00c1b1be Eric Dumazet       2011-11-28  1082  	}
2b8837aeaaa0bb Joe Perches        2014-03-12  1083  	case htons(ETH_P_IPV6): {
0744dd00c1b1be Eric Dumazet       2011-11-28  1084  		const struct ipv6hdr *iph;
0744dd00c1b1be Eric Dumazet       2011-11-28  1085  		struct ipv6hdr _iph;
19469a873bafd4 Tom Herbert        2014-07-01  1086  
690e36e726d00d David S. Miller    2014-08-23  1087  		iph = __skb_header_pointer(skb, nhoff, sizeof(_iph), data, hlen, &_iph);
3a1214e8b06317 Tom Herbert        2017-09-01  1088  		if (!iph) {
3a1214e8b06317 Tom Herbert        2017-09-01  1089  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert        2017-09-01  1090  			break;
3a1214e8b06317 Tom Herbert        2017-09-01  1091  		}
0744dd00c1b1be Eric Dumazet       2011-11-28  1092  
0744dd00c1b1be Eric Dumazet       2011-11-28  1093  		ip_proto = iph->nexthdr;
0744dd00c1b1be Eric Dumazet       2011-11-28  1094  		nhoff += sizeof(struct ipv6hdr);
19469a873bafd4 Tom Herbert        2014-07-01  1095  
20a17bf6c04e3e David S. Miller    2015-09-01  1096  		if (dissector_uses_key(flow_dissector,
b924933cbbfbdc Jiri Pirko         2015-05-12  1097  				       FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
b3c3106ce3f464 Alexander Duyck    2016-02-24  1098  			key_addrs = skb_flow_dissector_target(flow_dissector,
b924933cbbfbdc Jiri Pirko         2015-05-12  1099  							      FLOW_DISSECTOR_KEY_IPV6_ADDRS,
b924933cbbfbdc Jiri Pirko         2015-05-12  1100  							      target_container);
b924933cbbfbdc Jiri Pirko         2015-05-12  1101  
b3c3106ce3f464 Alexander Duyck    2016-02-24  1102  			memcpy(&key_addrs->v6addrs, &iph->saddr,
b3c3106ce3f464 Alexander Duyck    2016-02-24  1103  			       sizeof(key_addrs->v6addrs));
c3f8324188fa80 Tom Herbert        2015-06-04  1104  			key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
b924933cbbfbdc Jiri Pirko         2015-05-12  1105  		}
87ee9e52ffeb16 Tom Herbert        2015-06-04  1106  
461547f3158978 Alexander Duyck    2016-02-09  1107  		if ((dissector_uses_key(flow_dissector,
461547f3158978 Alexander Duyck    2016-02-09  1108  					FLOW_DISSECTOR_KEY_FLOW_LABEL) ||
461547f3158978 Alexander Duyck    2016-02-09  1109  		     (flags & FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL)) &&
461547f3158978 Alexander Duyck    2016-02-09  1110  		    ip6_flowlabel(iph)) {
461547f3158978 Alexander Duyck    2016-02-09  1111  			__be32 flow_label = ip6_flowlabel(iph);
461547f3158978 Alexander Duyck    2016-02-09  1112  
20a17bf6c04e3e David S. Miller    2015-09-01  1113  			if (dissector_uses_key(flow_dissector,
87ee9e52ffeb16 Tom Herbert        2015-06-04  1114  					       FLOW_DISSECTOR_KEY_FLOW_LABEL)) {
87ee9e52ffeb16 Tom Herbert        2015-06-04  1115  				key_tags = skb_flow_dissector_target(flow_dissector,
87ee9e52ffeb16 Tom Herbert        2015-06-04  1116  								     FLOW_DISSECTOR_KEY_FLOW_LABEL,
06635a35d13d42 Jiri Pirko         2015-05-12  1117  								     target_container);
87ee9e52ffeb16 Tom Herbert        2015-06-04  1118  				key_tags->flow_label = ntohl(flow_label);
12c227ec89a70c Jiri Pirko         2015-05-22  1119  			}
3a1214e8b06317 Tom Herbert        2017-09-01  1120  			if (flags & FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL) {
3a1214e8b06317 Tom Herbert        2017-09-01  1121  				fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert        2017-09-01  1122  				break;
3a1214e8b06317 Tom Herbert        2017-09-01  1123  			}
19469a873bafd4 Tom Herbert        2014-07-01  1124  		}
19469a873bafd4 Tom Herbert        2014-07-01  1125  
518d8a2e9bad83 Or Gerlitz         2017-06-01  1126  		__skb_flow_dissect_ipv6(skb, flow_dissector,
518d8a2e9bad83 Or Gerlitz         2017-06-01  1127  					target_container, data, iph);
518d8a2e9bad83 Or Gerlitz         2017-06-01  1128  
0744dd00c1b1be Eric Dumazet       2011-11-28  1129  		break;
0744dd00c1b1be Eric Dumazet       2011-11-28  1130  	}
2b8837aeaaa0bb Joe Perches        2014-03-12  1131  	case htons(ETH_P_8021AD):
2b8837aeaaa0bb Joe Perches        2014-03-12  1132  	case htons(ETH_P_8021Q): {
24c590e3b0f9ee Jianbo Liu         2018-07-06  1133  		const struct vlan_hdr *vlan = NULL;
bc72f3dd89e087 Arnd Bergmann      2016-10-24  1134  		struct vlan_hdr _vlan;
2064c3d4c02026 Jianbo Liu         2018-07-06  1135  		__be16 saved_vlan_tpid = proto;
d5709f7ab77679 Hadar Hen Zion     2016-08-17  1136  
24c590e3b0f9ee Jianbo Liu         2018-07-06  1137  		if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX &&
24c590e3b0f9ee Jianbo Liu         2018-07-06  1138  		    skb && skb_vlan_tag_present(skb)) {
d5709f7ab77679 Hadar Hen Zion     2016-08-17  1139  			proto = skb->protocol;
24c590e3b0f9ee Jianbo Liu         2018-07-06  1140  		} else {
d5709f7ab77679 Hadar Hen Zion     2016-08-17  1141  			vlan = __skb_header_pointer(skb, nhoff, sizeof(_vlan),
d5709f7ab77679 Hadar Hen Zion     2016-08-17  1142  						    data, hlen, &_vlan);
3a1214e8b06317 Tom Herbert        2017-09-01  1143  			if (!vlan) {
3a1214e8b06317 Tom Herbert        2017-09-01  1144  				fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert        2017-09-01  1145  				break;
3a1214e8b06317 Tom Herbert        2017-09-01  1146  			}
3a1214e8b06317 Tom Herbert        2017-09-01  1147  
d5709f7ab77679 Hadar Hen Zion     2016-08-17  1148  			proto = vlan->h_vlan_encapsulated_proto;
d5709f7ab77679 Hadar Hen Zion     2016-08-17  1149  			nhoff += sizeof(*vlan);
24c590e3b0f9ee Jianbo Liu         2018-07-06  1150  		}
24c590e3b0f9ee Jianbo Liu         2018-07-06  1151  
24c590e3b0f9ee Jianbo Liu         2018-07-06  1152  		if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX) {
24c590e3b0f9ee Jianbo Liu         2018-07-06  1153  			dissector_vlan = FLOW_DISSECTOR_KEY_VLAN;
24c590e3b0f9ee Jianbo Liu         2018-07-06  1154  		} else if (dissector_vlan == FLOW_DISSECTOR_KEY_VLAN) {
24c590e3b0f9ee Jianbo Liu         2018-07-06  1155  			dissector_vlan = FLOW_DISSECTOR_KEY_CVLAN;
24c590e3b0f9ee Jianbo Liu         2018-07-06  1156  		} else {
3a1214e8b06317 Tom Herbert        2017-09-01  1157  			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert        2017-09-01  1158  			break;
3a1214e8b06317 Tom Herbert        2017-09-01  1159  		}
0744dd00c1b1be Eric Dumazet       2011-11-28  1160  
24c590e3b0f9ee Jianbo Liu         2018-07-06  1161  		if (dissector_uses_key(flow_dissector, dissector_vlan)) {
f6a66927692e30 Hadar Hen Zion     2016-08-17  1162  			key_vlan = skb_flow_dissector_target(flow_dissector,
24c590e3b0f9ee Jianbo Liu         2018-07-06  1163  							     dissector_vlan,
d34af823ff401c Tom Herbert        2015-06-04  1164  							     target_container);
d34af823ff401c Tom Herbert        2015-06-04  1165  
24c590e3b0f9ee Jianbo Liu         2018-07-06  1166  			if (!vlan) {
f6a66927692e30 Hadar Hen Zion     2016-08-17  1167  				key_vlan->vlan_id = skb_vlan_tag_get_id(skb);
9b319148cb34ec Michał Mirosław    2018-11-07  1168  				key_vlan->vlan_priority = skb_vlan_tag_get_prio(skb);
f6a66927692e30 Hadar Hen Zion     2016-08-17  1169  			} else {
f6a66927692e30 Hadar Hen Zion     2016-08-17  1170  				key_vlan->vlan_id = ntohs(vlan->h_vlan_TCI) &
d5709f7ab77679 Hadar Hen Zion     2016-08-17  1171  					VLAN_VID_MASK;
f6a66927692e30 Hadar Hen Zion     2016-08-17  1172  				key_vlan->vlan_priority =
f6a66927692e30 Hadar Hen Zion     2016-08-17  1173  					(ntohs(vlan->h_vlan_TCI) &
f6a66927692e30 Hadar Hen Zion     2016-08-17  1174  					 VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
f6a66927692e30 Hadar Hen Zion     2016-08-17  1175  			}
2064c3d4c02026 Jianbo Liu         2018-07-06  1176  			key_vlan->vlan_tpid = saved_vlan_tpid;
d34af823ff401c Tom Herbert        2015-06-04  1177  		}
d34af823ff401c Tom Herbert        2015-06-04  1178  
3a1214e8b06317 Tom Herbert        2017-09-01  1179  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert        2017-09-01  1180  		break;
0744dd00c1b1be Eric Dumazet       2011-11-28  1181  	}
2b8837aeaaa0bb Joe Perches        2014-03-12  1182  	case htons(ETH_P_PPP_SES): {
0744dd00c1b1be Eric Dumazet       2011-11-28  1183  		struct {
0744dd00c1b1be Eric Dumazet       2011-11-28  1184  			struct pppoe_hdr hdr;
0744dd00c1b1be Eric Dumazet       2011-11-28  1185  			__be16 proto;
0744dd00c1b1be Eric Dumazet       2011-11-28  1186  		} *hdr, _hdr;
690e36e726d00d David S. Miller    2014-08-23  1187  		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen, &_hdr);
3a1214e8b06317 Tom Herbert        2017-09-01  1188  		if (!hdr) {
3a1214e8b06317 Tom Herbert        2017-09-01  1189  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert        2017-09-01  1190  			break;
3a1214e8b06317 Tom Herbert        2017-09-01  1191  		}
3a1214e8b06317 Tom Herbert        2017-09-01  1192  
0744dd00c1b1be Eric Dumazet       2011-11-28  1193  		proto = hdr->proto;
0744dd00c1b1be Eric Dumazet       2011-11-28  1194  		nhoff += PPPOE_SES_HLEN;
0744dd00c1b1be Eric Dumazet       2011-11-28  1195  		switch (proto) {
2b8837aeaaa0bb Joe Perches        2014-03-12  1196  		case htons(PPP_IP):
3a1214e8b06317 Tom Herbert        2017-09-01  1197  			proto = htons(ETH_P_IP);
3a1214e8b06317 Tom Herbert        2017-09-01  1198  			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert        2017-09-01  1199  			break;
2b8837aeaaa0bb Joe Perches        2014-03-12  1200  		case htons(PPP_IPV6):
3a1214e8b06317 Tom Herbert        2017-09-01  1201  			proto = htons(ETH_P_IPV6);
3a1214e8b06317 Tom Herbert        2017-09-01  1202  			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert        2017-09-01  1203  			break;
0744dd00c1b1be Eric Dumazet       2011-11-28  1204  		default:
3a1214e8b06317 Tom Herbert        2017-09-01  1205  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert        2017-09-01  1206  			break;
0744dd00c1b1be Eric Dumazet       2011-11-28  1207  		}
3a1214e8b06317 Tom Herbert        2017-09-01  1208  		break;
0744dd00c1b1be Eric Dumazet       2011-11-28  1209  	}
08bfc9cb76e26d Erik Hugne         2015-01-22  1210  	case htons(ETH_P_TIPC): {
8d6e79d3ce13e3 Jon Maloy          2017-11-08  1211  		struct tipc_basic_hdr *hdr, _hdr;
8d6e79d3ce13e3 Jon Maloy          2017-11-08  1212  
8d6e79d3ce13e3 Jon Maloy          2017-11-08  1213  		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr),
8d6e79d3ce13e3 Jon Maloy          2017-11-08  1214  					   data, hlen, &_hdr);
3a1214e8b06317 Tom Herbert        2017-09-01  1215  		if (!hdr) {
3a1214e8b06317 Tom Herbert        2017-09-01  1216  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert        2017-09-01  1217  			break;
3a1214e8b06317 Tom Herbert        2017-09-01  1218  		}
06635a35d13d42 Jiri Pirko         2015-05-12  1219  
20a17bf6c04e3e David S. Miller    2015-09-01  1220  		if (dissector_uses_key(flow_dissector,
8d6e79d3ce13e3 Jon Maloy          2017-11-08  1221  				       FLOW_DISSECTOR_KEY_TIPC)) {
06635a35d13d42 Jiri Pirko         2015-05-12  1222  			key_addrs = skb_flow_dissector_target(flow_dissector,
8d6e79d3ce13e3 Jon Maloy          2017-11-08  1223  							      FLOW_DISSECTOR_KEY_TIPC,
06635a35d13d42 Jiri Pirko         2015-05-12  1224  							      target_container);
8d6e79d3ce13e3 Jon Maloy          2017-11-08  1225  			key_addrs->tipckey.key = tipc_hdr_rps_key(hdr);
8d6e79d3ce13e3 Jon Maloy          2017-11-08  1226  			key_control->addr_type = FLOW_DISSECTOR_KEY_TIPC;
06635a35d13d42 Jiri Pirko         2015-05-12  1227  		}
3a1214e8b06317 Tom Herbert        2017-09-01  1228  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert        2017-09-01  1229  		break;
08bfc9cb76e26d Erik Hugne         2015-01-22  1230  	}
b3baa0fbd02a1a Tom Herbert        2015-06-04  1231  
b3baa0fbd02a1a Tom Herbert        2015-06-04  1232  	case htons(ETH_P_MPLS_UC):
4a5d6c8b14b81e Jiri Pirko         2017-03-06  1233  	case htons(ETH_P_MPLS_MC):
3a1214e8b06317 Tom Herbert        2017-09-01  1234  		fdret = __skb_flow_dissect_mpls(skb, flow_dissector,
4a5d6c8b14b81e Jiri Pirko         2017-03-06  1235  						target_container, data,
58cff782cc55eb Guillaume Nault    2020-05-26  1236  						nhoff, hlen, mpls_lse,
58cff782cc55eb Guillaume Nault    2020-05-26  1237  						&mpls_el);
58cff782cc55eb Guillaume Nault    2020-05-26  1238  		nhoff += sizeof(struct mpls_label);
58cff782cc55eb Guillaume Nault    2020-05-26  1239  		mpls_lse++;
3a1214e8b06317 Tom Herbert        2017-09-01  1240  		break;
56193d1bce2b27 Alexander Duyck    2014-09-05  1241  	case htons(ETH_P_FCOE):
3a1214e8b06317 Tom Herbert        2017-09-01  1242  		if ((hlen - nhoff) < FCOE_HEADER_LEN) {
3a1214e8b06317 Tom Herbert        2017-09-01  1243  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert        2017-09-01  1244  			break;
3a1214e8b06317 Tom Herbert        2017-09-01  1245  		}
224516b3a798a0 Alexander Duyck    2016-02-24  1246  
224516b3a798a0 Alexander Duyck    2016-02-24  1247  		nhoff += FCOE_HEADER_LEN;
3a1214e8b06317 Tom Herbert        2017-09-01  1248  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert        2017-09-01  1249  		break;
55733350e5e8b7 Simon Horman       2017-01-11  1250  
55733350e5e8b7 Simon Horman       2017-01-11  1251  	case htons(ETH_P_ARP):
9bf881ffc5c0e6 Jiri Pirko         2017-03-06  1252  	case htons(ETH_P_RARP):
3a1214e8b06317 Tom Herbert        2017-09-01  1253  		fdret = __skb_flow_dissect_arp(skb, flow_dissector,
9bf881ffc5c0e6 Jiri Pirko         2017-03-06  1254  					       target_container, data,
3a1214e8b06317 Tom Herbert        2017-09-01  1255  					       nhoff, hlen);
3a1214e8b06317 Tom Herbert        2017-09-01  1256  		break;
3a1214e8b06317 Tom Herbert        2017-09-01  1257  
5b0890a9720462 Sven Eckelmann     2017-12-21  1258  	case htons(ETH_P_BATMAN):
5b0890a9720462 Sven Eckelmann     2017-12-21  1259  		fdret = __skb_flow_dissect_batadv(skb, key_control, data,
5b0890a9720462 Sven Eckelmann     2017-12-21  1260  						  &proto, &nhoff, hlen, flags);
5b0890a9720462 Sven Eckelmann     2017-12-21  1261  		break;
5b0890a9720462 Sven Eckelmann     2017-12-21  1262  
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1263  	case htons(ETH_P_1588): {
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1264  		struct ptp_header *hdr, _hdr;
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1265  
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1266  		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data,
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1267  					   hlen, &_hdr);
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1268  		if (!hdr) {
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1269  			fdret = FLOW_DISSECT_RET_OUT_BAD;
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1270  			break;
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1271  		}
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1272  
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1273  		nhoff += ntohs(hdr->message_length);
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1274  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1275  		break;
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1276  	}
4f1cc51f34886d Eran Ben Elisha    2021-01-12  1277  
3a1214e8b06317 Tom Herbert        2017-09-01  1278  	default:
3a1214e8b06317 Tom Herbert        2017-09-01  1279  		fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert        2017-09-01  1280  		break;
3a1214e8b06317 Tom Herbert        2017-09-01  1281  	}
3a1214e8b06317 Tom Herbert        2017-09-01  1282  
3a1214e8b06317 Tom Herbert        2017-09-01  1283  	/* Process result of proto processing */
3a1214e8b06317 Tom Herbert        2017-09-01  1284  	switch (fdret) {
9bf881ffc5c0e6 Jiri Pirko         2017-03-06  1285  	case FLOW_DISSECT_RET_OUT_GOOD:
55733350e5e8b7 Simon Horman       2017-01-11  1286  		goto out_good;
3a1214e8b06317 Tom Herbert        2017-09-01  1287  	case FLOW_DISSECT_RET_PROTO_AGAIN:
1eed4dfb81b193 Tom Herbert        2017-09-01  1288  		if (skb_flow_dissect_allowed(&num_hdrs))
3a1214e8b06317 Tom Herbert        2017-09-01  1289  			goto proto_again;
1eed4dfb81b193 Tom Herbert        2017-09-01  1290  		goto out_good;
3a1214e8b06317 Tom Herbert        2017-09-01  1291  	case FLOW_DISSECT_RET_CONTINUE:
3a1214e8b06317 Tom Herbert        2017-09-01  1292  	case FLOW_DISSECT_RET_IPPROTO_AGAIN:
3a1214e8b06317 Tom Herbert        2017-09-01  1293  		break;
9bf881ffc5c0e6 Jiri Pirko         2017-03-06  1294  	case FLOW_DISSECT_RET_OUT_BAD:
7c92de8eaabfff Jiri Pirko         2017-03-06  1295  	default:
9bf881ffc5c0e6 Jiri Pirko         2017-03-06  1296  		goto out_bad;
55733350e5e8b7 Simon Horman       2017-01-11  1297  	}
0744dd00c1b1be Eric Dumazet       2011-11-28  1298  
6a74fcf426f51a Tom Herbert        2015-06-12  1299  ip_proto_again:
3a1214e8b06317 Tom Herbert        2017-09-01  1300  	fdret = FLOW_DISSECT_RET_CONTINUE;
3a1214e8b06317 Tom Herbert        2017-09-01  1301  
0744dd00c1b1be Eric Dumazet       2011-11-28  1302  	switch (ip_proto) {
7c92de8eaabfff Jiri Pirko         2017-03-06  1303  	case IPPROTO_GRE:
3a1214e8b06317 Tom Herbert        2017-09-01  1304  		fdret = __skb_flow_dissect_gre(skb, key_control, flow_dissector,
7c92de8eaabfff Jiri Pirko         2017-03-06  1305  					       target_container, data,
3a1214e8b06317 Tom Herbert        2017-09-01  1306  					       &proto, &nhoff, &hlen, flags);
3a1214e8b06317 Tom Herbert        2017-09-01  1307  		break;
3a1214e8b06317 Tom Herbert        2017-09-01  1308  
6a74fcf426f51a Tom Herbert        2015-06-12  1309  	case NEXTHDR_HOP:
6a74fcf426f51a Tom Herbert        2015-06-12  1310  	case NEXTHDR_ROUTING:
6a74fcf426f51a Tom Herbert        2015-06-12  1311  	case NEXTHDR_DEST: {
6a74fcf426f51a Tom Herbert        2015-06-12  1312  		u8 _opthdr[2], *opthdr;
6a74fcf426f51a Tom Herbert        2015-06-12  1313  
6a74fcf426f51a Tom Herbert        2015-06-12  1314  		if (proto != htons(ETH_P_IPV6))
6a74fcf426f51a Tom Herbert        2015-06-12  1315  			break;
6a74fcf426f51a Tom Herbert        2015-06-12  1316  
6a74fcf426f51a Tom Herbert        2015-06-12  1317  		opthdr = __skb_header_pointer(skb, nhoff, sizeof(_opthdr),
6a74fcf426f51a Tom Herbert        2015-06-12  1318  					      data, hlen, &_opthdr);
3a1214e8b06317 Tom Herbert        2017-09-01  1319  		if (!opthdr) {
3a1214e8b06317 Tom Herbert        2017-09-01  1320  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert        2017-09-01  1321  			break;
3a1214e8b06317 Tom Herbert        2017-09-01  1322  		}
6a74fcf426f51a Tom Herbert        2015-06-12  1323  
1e98a0f08abddd Eric Dumazet       2015-06-12  1324  		ip_proto = opthdr[0];
1e98a0f08abddd Eric Dumazet       2015-06-12  1325  		nhoff += (opthdr[1] + 1) << 3;
6a74fcf426f51a Tom Herbert        2015-06-12  1326  
3a1214e8b06317 Tom Herbert        2017-09-01  1327  		fdret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
3a1214e8b06317 Tom Herbert        2017-09-01  1328  		break;
6a74fcf426f51a Tom Herbert        2015-06-12  1329  	}
b840f28b908da0 Tom Herbert        2015-09-01  1330  	case NEXTHDR_FRAGMENT: {
b840f28b908da0 Tom Herbert        2015-09-01  1331  		struct frag_hdr _fh, *fh;
b840f28b908da0 Tom Herbert        2015-09-01  1332  
b840f28b908da0 Tom Herbert        2015-09-01  1333  		if (proto != htons(ETH_P_IPV6))
b840f28b908da0 Tom Herbert        2015-09-01  1334  			break;
b840f28b908da0 Tom Herbert        2015-09-01  1335  
b840f28b908da0 Tom Herbert        2015-09-01  1336  		fh = __skb_header_pointer(skb, nhoff, sizeof(_fh),
b840f28b908da0 Tom Herbert        2015-09-01  1337  					  data, hlen, &_fh);
b840f28b908da0 Tom Herbert        2015-09-01  1338  
3a1214e8b06317 Tom Herbert        2017-09-01  1339  		if (!fh) {
3a1214e8b06317 Tom Herbert        2017-09-01  1340  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert        2017-09-01  1341  			break;
3a1214e8b06317 Tom Herbert        2017-09-01  1342  		}
b840f28b908da0 Tom Herbert        2015-09-01  1343  
4b36993d3df083 David S. Miller    2015-09-01  1344  		key_control->flags |= FLOW_DIS_IS_FRAGMENT;
b840f28b908da0 Tom Herbert        2015-09-01  1345  
b840f28b908da0 Tom Herbert        2015-09-01  1346  		nhoff += sizeof(_fh);
43d2ccb3c122a4 Alexander Duyck    2016-02-24  1347  		ip_proto = fh->nexthdr;
b840f28b908da0 Tom Herbert        2015-09-01  1348  
b840f28b908da0 Tom Herbert        2015-09-01  1349  		if (!(fh->frag_off & htons(IP6_OFFSET))) {
4b36993d3df083 David S. Miller    2015-09-01  1350  			key_control->flags |= FLOW_DIS_FIRST_FRAG;
3a1214e8b06317 Tom Herbert        2017-09-01  1351  			if (flags & FLOW_DISSECTOR_F_PARSE_1ST_FRAG) {
3a1214e8b06317 Tom Herbert        2017-09-01  1352  				fdret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
3a1214e8b06317 Tom Herbert        2017-09-01  1353  				break;
b840f28b908da0 Tom Herbert        2015-09-01  1354  			}
3a1214e8b06317 Tom Herbert        2017-09-01  1355  		}
3a1214e8b06317 Tom Herbert        2017-09-01  1356  
3a1214e8b06317 Tom Herbert        2017-09-01  1357  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert        2017-09-01  1358  		break;
b840f28b908da0 Tom Herbert        2015-09-01  1359  	}
0744dd00c1b1be Eric Dumazet       2011-11-28  1360  	case IPPROTO_IPIP:
fca418955148e4 Tom Herbert        2013-07-29  1361  		proto = htons(ETH_P_IP);
823b96939578ea Tom Herbert        2015-09-01  1362  
4b36993d3df083 David S. Miller    2015-09-01  1363  		key_control->flags |= FLOW_DIS_ENCAPSULATION;
3a1214e8b06317 Tom Herbert        2017-09-01  1364  		if (flags & FLOW_DISSECTOR_F_STOP_AT_ENCAP) {
3a1214e8b06317 Tom Herbert        2017-09-01  1365  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert        2017-09-01  1366  			break;
3a1214e8b06317 Tom Herbert        2017-09-01  1367  		}
3a1214e8b06317 Tom Herbert        2017-09-01  1368  
3a1214e8b06317 Tom Herbert        2017-09-01  1369  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert        2017-09-01  1370  		break;
823b96939578ea Tom Herbert        2015-09-01  1371  
b438f940d3541f Tom Herbert        2013-07-29  1372  	case IPPROTO_IPV6:
b438f940d3541f Tom Herbert        2013-07-29  1373  		proto = htons(ETH_P_IPV6);
823b96939578ea Tom Herbert        2015-09-01  1374  
4b36993d3df083 David S. Miller    2015-09-01  1375  		key_control->flags |= FLOW_DIS_ENCAPSULATION;
3a1214e8b06317 Tom Herbert        2017-09-01  1376  		if (flags & FLOW_DISSECTOR_F_STOP_AT_ENCAP) {
3a1214e8b06317 Tom Herbert        2017-09-01  1377  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert        2017-09-01  1378  			break;
3a1214e8b06317 Tom Herbert        2017-09-01  1379  		}
3a1214e8b06317 Tom Herbert        2017-09-01  1380  
3a1214e8b06317 Tom Herbert        2017-09-01  1381  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert        2017-09-01  1382  		break;
3a1214e8b06317 Tom Herbert        2017-09-01  1383  
823b96939578ea Tom Herbert        2015-09-01  1384  
b3baa0fbd02a1a Tom Herbert        2015-06-04  1385  	case IPPROTO_MPLS:
b3baa0fbd02a1a Tom Herbert        2015-06-04  1386  		proto = htons(ETH_P_MPLS_UC);
3a1214e8b06317 Tom Herbert        2017-09-01  1387  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert        2017-09-01  1388  		break;
3a1214e8b06317 Tom Herbert        2017-09-01  1389  
ac4bb5de27010e Jiri Pirko         2017-05-23  1390  	case IPPROTO_TCP:
ac4bb5de27010e Jiri Pirko         2017-05-23  1391  		__skb_flow_dissect_tcp(skb, flow_dissector, target_container,
ac4bb5de27010e Jiri Pirko         2017-05-23  1392  				       data, nhoff, hlen);
ac4bb5de27010e Jiri Pirko         2017-05-23  1393  		break;
3a1214e8b06317 Tom Herbert        2017-09-01  1394  
3b336d6f4ec690 Matteo Croce       2019-10-29  1395  	case IPPROTO_ICMP:
3b336d6f4ec690 Matteo Croce       2019-10-29  1396  	case IPPROTO_ICMPV6:
3b336d6f4ec690 Matteo Croce       2019-10-29  1397  		__skb_flow_dissect_icmp(skb, flow_dissector, target_container,
3b336d6f4ec690 Matteo Croce       2019-10-29  1398  					data, nhoff, hlen);
3b336d6f4ec690 Matteo Croce       2019-10-29  1399  		break;
3b336d6f4ec690 Matteo Croce       2019-10-29  1400  
0744dd00c1b1be Eric Dumazet       2011-11-28  1401  	default:
0744dd00c1b1be Eric Dumazet       2011-11-28  1402  		break;
0744dd00c1b1be Eric Dumazet       2011-11-28  1403  	}
0744dd00c1b1be Eric Dumazet       2011-11-28  1404  
8ffb055beae585 Yoshiki Komachi    2019-12-03  1405  	if (!(key_control->flags & FLOW_DIS_IS_FRAGMENT))
8ffb055beae585 Yoshiki Komachi    2019-12-03  1406  		__skb_flow_dissect_ports(skb, flow_dissector, target_container,
8ffb055beae585 Yoshiki Komachi    2019-12-03  1407  					 data, nhoff, ip_proto, hlen);
5af7fb6e3e92c2 Alexander Duyck    2014-10-10  1408  
3a1214e8b06317 Tom Herbert        2017-09-01  1409  	/* Process result of IP proto processing */
3a1214e8b06317 Tom Herbert        2017-09-01  1410  	switch (fdret) {
3a1214e8b06317 Tom Herbert        2017-09-01  1411  	case FLOW_DISSECT_RET_PROTO_AGAIN:
1eed4dfb81b193 Tom Herbert        2017-09-01  1412  		if (skb_flow_dissect_allowed(&num_hdrs))
3a1214e8b06317 Tom Herbert        2017-09-01  1413  			goto proto_again;
1eed4dfb81b193 Tom Herbert        2017-09-01  1414  		break;
3a1214e8b06317 Tom Herbert        2017-09-01  1415  	case FLOW_DISSECT_RET_IPPROTO_AGAIN:
1eed4dfb81b193 Tom Herbert        2017-09-01  1416  		if (skb_flow_dissect_allowed(&num_hdrs))
3a1214e8b06317 Tom Herbert        2017-09-01  1417  			goto ip_proto_again;
1eed4dfb81b193 Tom Herbert        2017-09-01  1418  		break;
3a1214e8b06317 Tom Herbert        2017-09-01  1419  	case FLOW_DISSECT_RET_OUT_GOOD:
3a1214e8b06317 Tom Herbert        2017-09-01  1420  	case FLOW_DISSECT_RET_CONTINUE:
3a1214e8b06317 Tom Herbert        2017-09-01  1421  		break;
3a1214e8b06317 Tom Herbert        2017-09-01  1422  	case FLOW_DISSECT_RET_OUT_BAD:
3a1214e8b06317 Tom Herbert        2017-09-01  1423  	default:
3a1214e8b06317 Tom Herbert        2017-09-01  1424  		goto out_bad;
3a1214e8b06317 Tom Herbert        2017-09-01  1425  	}
3a1214e8b06317 Tom Herbert        2017-09-01  1426  
a6e544b0a88b53 Tom Herbert        2015-09-01  1427  out_good:
a6e544b0a88b53 Tom Herbert        2015-09-01  1428  	ret = true;
a6e544b0a88b53 Tom Herbert        2015-09-01  1429  
34fad54c2537f7 Eric Dumazet       2016-11-09  1430  out:
d0c081b49137cd Eric Dumazet       2018-01-17  1431  	key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
a6e544b0a88b53 Tom Herbert        2015-09-01  1432  	key_basic->n_proto = proto;
a6e544b0a88b53 Tom Herbert        2015-09-01  1433  	key_basic->ip_proto = ip_proto;
a6e544b0a88b53 Tom Herbert        2015-09-01  1434  
a6e544b0a88b53 Tom Herbert        2015-09-01  1435  	return ret;
34fad54c2537f7 Eric Dumazet       2016-11-09  1436  
34fad54c2537f7 Eric Dumazet       2016-11-09  1437  out_bad:
34fad54c2537f7 Eric Dumazet       2016-11-09  1438  	ret = false;
34fad54c2537f7 Eric Dumazet       2016-11-09  1439  	goto out;
0744dd00c1b1be Eric Dumazet       2011-11-28  1440  }
690e36e726d00d David S. Miller    2014-08-23  1441  EXPORT_SYMBOL(__skb_flow_dissect);
441d9d327f1e77 Cong Wang          2013-01-21  1442  

:::::: The code at line 835 was first introduced by commit
:::::: d58e468b1112dcd1d5193c0a89ff9f98b5a3e8b9 flow_dissector: implements flow dissector BPF hook

:::::: TO: Petar Penkov <ppenkov@google.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--huq684BweRXVnRxX
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--huq684BweRXVnRxX--

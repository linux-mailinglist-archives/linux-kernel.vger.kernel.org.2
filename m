Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3967C45E1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350720AbhKYVGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:06:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:2943 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237292AbhKYVEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:04:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="222437703"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="222437703"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 13:00:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="554724966"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 25 Nov 2021 13:00:52 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqLrP-0006vF-AD; Thu, 25 Nov 2021 21:00:51 +0000
Date:   Fri, 26 Nov 2021 05:00:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Machata <petrm@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:petrm_soft_counters 8/8] net/core/rtnetlink.c:5033:53:
 error: 'info' undeclared
Message-ID: <202111260416.BVNDGLfL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw petrm_soft_counters
head:   59d158395664dab1c1164364d6ee57aaaad44b96
commit: 59d158395664dab1c1164364d6ee57aaaad44b96 [8/8] wip
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211126/202111260416.BVNDGLfL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/jpirko/linux_mlxsw/commit/59d158395664dab1c1164364d6ee57aaaad44b96
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw petrm_soft_counters
        git checkout 59d158395664dab1c1164364d6ee57aaaad44b96
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/core/rtnetlink.c: In function 'rtnl_offload_xstats_have_ndo':
>> net/core/rtnetlink.c:5033:53: error: 'info' undeclared (first use in this function)
    5033 |         dev->netdev_ops->ndo_has_offload_stats(dev, info->attr_id);
         |                                                     ^~~~
   net/core/rtnetlink.c:5033:53: note: each undeclared identifier is reported only once for each function it appears in
   net/core/rtnetlink.c: At top level:
   net/core/rtnetlink.c:5073:53: warning: 'struct rtnl_offload_xstats_info' declared inside parameter list will not be visible outside of this definition or declaration
    5073 | rtnl_offload_xstats_get_size_hw_s_info(const struct rtnl_offload_xstats_info *info,
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   net/core/rtnetlink.c: In function 'rtnl_offload_xstats_get_size_hw_s_info':
>> net/core/rtnetlink.c:5076:17: error: implicit declaration of function 'netdev_offload_xstats_enabled'; did you mean 'netdev_offload_xstats_report_delta'? [-Werror=implicit-function-declaration]
    5076 |  bool enabled = netdev_offload_xstats_enabled(dev);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 netdev_offload_xstats_report_delta
>> net/core/rtnetlink.c:5082:5: error: expected ';' before '}' token
    5082 |   0)
         |     ^
         |     ;
    5083 | }
         | ~    
   net/core/rtnetlink.c: In function 'rtnl_offload_xstats_fill_hw_s_info':
   net/core/rtnetlink.c:5099:6: warning: unused variable 'err' [-Wunused-variable]
    5099 |  int err;
         |      ^~~
   net/core/rtnetlink.c: At top level:
   net/core/rtnetlink.c:5122:52: warning: 'struct rtnl_offload_xstats_info' declared inside parameter list will not be visible outside of this definition or declaration
    5122 | rtnl_offload_xstats_get_size_sw_stats(const struct rtnl_offload_xstats_info *info,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~
   net/core/rtnetlink.c: In function 'rtnl_offload_xstats_fill_sw_stats':
   net/core/rtnetlink.c:5133:1: error: no return statement in function returning non-void [-Werror=return-type]
    5133 | }
         | ^
   net/core/rtnetlink.c: In function 'rtnl_get_offload_stats_size':
>> net/core/rtnetlink.c:5156:49: error: passing argument 1 of 'rtnl_offload_xstats_get_size_hw_s_info' from incompatible pointer type [-Werror=incompatible-pointer-types]
    5156 |   size = rtnl_offload_xstats_get_size_hw_s_info(dev);
         |                                                 ^~~
         |                                                 |
         |                                                 const struct net_device *
   net/core/rtnetlink.c:5073:79: note: expected 'const struct rtnl_offload_xstats_info *' but argument is of type 'const struct net_device *'
    5073 | rtnl_offload_xstats_get_size_hw_s_info(const struct rtnl_offload_xstats_info *info,
         |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> net/core/rtnetlink.c:5156:10: error: too few arguments to function 'rtnl_offload_xstats_get_size_hw_s_info'
    5156 |   size = rtnl_offload_xstats_get_size_hw_s_info(dev);
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/rtnetlink.c:5073:1: note: declared here
    5073 | rtnl_offload_xstats_get_size_hw_s_info(const struct rtnl_offload_xstats_info *info,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/core/rtnetlink.c:5162:48: error: passing argument 1 of 'rtnl_offload_xstats_get_size_sw_stats' from incompatible pointer type [-Werror=incompatible-pointer-types]
    5162 |   size = rtnl_offload_xstats_get_size_sw_stats(dev);
         |                                                ^~~
         |                                                |
         |                                                const struct net_device *
   net/core/rtnetlink.c:5122:78: note: expected 'const struct rtnl_offload_xstats_info *' but argument is of type 'const struct net_device *'
    5122 | rtnl_offload_xstats_get_size_sw_stats(const struct rtnl_offload_xstats_info *info,
         |                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> net/core/rtnetlink.c:5162:10: error: too few arguments to function 'rtnl_offload_xstats_get_size_sw_stats'
    5162 |   size = rtnl_offload_xstats_get_size_sw_stats(dev);
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/rtnetlink.c:5122:1: note: declared here
    5122 | rtnl_offload_xstats_get_size_sw_stats(const struct rtnl_offload_xstats_info *info,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/rtnetlink.c: In function 'rtnl_fill_offload_stats':
>> net/core/rtnetlink.c:5206:51: error: 'size' undeclared (first use in this function); did you mean 'ksize'?
    5206 |   attr = nla_reserve_64bit(skb, attr_id_hw_stats, size,
         |                                                   ^~~~
         |                                                   ksize
   net/core/rtnetlink.c:5184:6: warning: unused variable 'i' [-Wunused-variable]
    5184 |  int i;
         |      ^
   In file included from include/net/rtnetlink.h:6,
                    from include/net/sch_generic.h:20,
                    from include/linux/filter.h:25,
                    from include/net/sock.h:59,
                    from include/net/inet_sock.h:22,
                    from include/net/ip.h:28,
                    from net/core/rtnetlink.c:45:
   net/core/rtnetlink.c: At top level:
>> net/core/rtnetlink.c:5535:28: error: 'IFLA_HW_STATS_IMMEDIATE' undeclared here (not in a function); did you mean 'TCA_ACT_HW_STATS_IMMEDIATE'?
    5535 | #define IFLA_HW_STATS_ANY (IFLA_HW_STATS_IMMEDIATE)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:365:48: note: in definition of macro 'NLA_POLICY_BITFIELD32'
     365 |  { .type = NLA_BITFIELD32, .bitfield32_valid = valid }
         |                                                ^~~~~
   net/core/rtnetlink.c:5539:25: note: in expansion of macro 'IFLA_HW_STATS_ANY'
    5539 |   NLA_POLICY_BITFIELD32(IFLA_HW_STATS_ANY),
         |                         ^~~~~~~~~~~~~~~~~
   net/core/rtnetlink.c: In function 'rtnl_offload_xstats_have_ndo':
   net/core/rtnetlink.c:5034:1: error: control reaches end of non-void function [-Werror=return-type]
    5034 | }
         | ^
   cc1: some warnings being treated as errors


vim +/info +5033 net/core/rtnetlink.c

e8872a25a05efcf Nikolay Aleksandrov 2016-04-30  5026  
59d158395664dab Petr Machata        2021-11-25  5027  static bool
59d158395664dab Petr Machata        2021-11-25  5028  rtnl_offload_xstats_have_ndo(const struct net_device *dev, int attr_id)
a8a72b09197b260 Petr Machata        2021-10-22  5029  {
59d158395664dab Petr Machata        2021-11-25  5030  	return dev->netdev_ops &&
a8a72b09197b260 Petr Machata        2021-10-22  5031  	       dev->netdev_ops->ndo_has_offload_stats &&
a8a72b09197b260 Petr Machata        2021-10-22  5032  	       dev->netdev_ops->ndo_get_offload_stats &&
7f3ca7ed5c4b775 Petr Machata        2021-11-03 @5033  	       dev->netdev_ops->ndo_has_offload_stats(dev, info->attr_id);
59d158395664dab Petr Machata        2021-11-25  5034  }
d35d00a6d28ff7a Petr Machata        2021-11-12  5035  
59d158395664dab Petr Machata        2021-11-25  5036  static unsigned int
59d158395664dab Petr Machata        2021-11-25  5037  rtnl_offload_xstats_get_size_ndo(const struct net_device *dev, int attr_id)
59d158395664dab Petr Machata        2021-11-25  5038  {
59d158395664dab Petr Machata        2021-11-25  5039  	return rtnl_offload_xstats_have_ndo(dev, attr_id) ?
59d158395664dab Petr Machata        2021-11-25  5040  	       sizeof(struct rtnl_link_stats64) : 0;
a8a72b09197b260 Petr Machata        2021-10-22  5041  }
a8a72b09197b260 Petr Machata        2021-10-22  5042  
a8a72b09197b260 Petr Machata        2021-10-22  5043  static int
59d158395664dab Petr Machata        2021-11-25  5044  rtnl_offload_xstats_fill_ndo(struct net_device *dev, int attr_id,
59d158395664dab Petr Machata        2021-11-25  5045  			     struct sk_buff *skb,
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5046  			     struct netlink_ext_ack *extack)
a8a72b09197b260 Petr Machata        2021-10-22  5047  {
59d158395664dab Petr Machata        2021-11-25  5048  	unsigned int size = rtnl_offload_xstats_get_size_ndo(dev, attr_id);
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5049  	struct nlattr *attr = NULL;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5050  	void *attr_data;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5051  	int err;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5052  
d35d00a6d28ff7a Petr Machata        2021-11-12  5053  	if (!size)
d35d00a6d28ff7a Petr Machata        2021-11-12  5054  		return 0;
d35d00a6d28ff7a Petr Machata        2021-11-12  5055  
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5056  	// xxx does nla_reserve take into account attribute header?
59d158395664dab Petr Machata        2021-11-25  5057  	attr = nla_reserve_64bit(skb, attr_id, size,
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5058  				 IFLA_OFFLOAD_XSTATS_UNSPEC);
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5059  	if (!attr)
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5060  		return -EMSGSIZE;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5061  
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5062  	attr_data = nla_data(attr);
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5063  	memset(attr_data, 0, size);
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5064  
59d158395664dab Petr Machata        2021-11-25  5065  	err = dev->netdev_ops->ndo_get_offload_stats(attr_id, dev, attr_data);
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5066  	if (err)
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5067  		return err;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5068  
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5069  	return 0;
a8a72b09197b260 Petr Machata        2021-10-22  5070  }
a8a72b09197b260 Petr Machata        2021-10-22  5071  
d35d00a6d28ff7a Petr Machata        2021-11-12  5072  static unsigned int
59d158395664dab Petr Machata        2021-11-25  5073  rtnl_offload_xstats_get_size_hw_s_info(const struct rtnl_offload_xstats_info *info,
d35d00a6d28ff7a Petr Machata        2021-11-12  5074  				       const struct net_device *dev)
d35d00a6d28ff7a Petr Machata        2021-11-12  5075  {
59d158395664dab Petr Machata        2021-11-25 @5076  	bool enabled = netdev_offload_xstats_enabled(dev);
d35d00a6d28ff7a Petr Machata        2021-11-12  5077  
59d158395664dab Petr Machata        2021-11-25  5078  	return (/* IFLA_OFFLOAD_XSTATS_HW_S_INFO_ENABLED */
59d158395664dab Petr Machata        2021-11-25  5079  		nla_total_size(sizeof(u8)) +
59d158395664dab Petr Machata        2021-11-25  5080  		/* IFLA_OFFLOAD_XSTATS_HW_S_INFO_IN_HW_COUNT */
59d158395664dab Petr Machata        2021-11-25  5081  		(enabled ? nla_total_size(sizeof(u32)) : 0) +
59d158395664dab Petr Machata        2021-11-25 @5082  		0)
59d158395664dab Petr Machata        2021-11-25  5083  }
59d158395664dab Petr Machata        2021-11-25  5084  
59d158395664dab Petr Machata        2021-11-25  5085  static unsigned int
59d158395664dab Petr Machata        2021-11-25  5086  rtnl_offload_xstats_get_size_hw_stats(const struct net_device *dev)
59d158395664dab Petr Machata        2021-11-25  5087  {
59d158395664dab Petr Machata        2021-11-25  5088  	bool enabled = netdev_offload_xstats_enabled(dev);
59d158395664dab Petr Machata        2021-11-25  5089  
59d158395664dab Petr Machata        2021-11-25  5090  	return enabled ? sizeof(struct rtnl_link_stats64) : 0;
d35d00a6d28ff7a Petr Machata        2021-11-12  5091  }
d35d00a6d28ff7a Petr Machata        2021-11-12  5092  
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5093  static int
59d158395664dab Petr Machata        2021-11-25  5094  rtnl_offload_xstats_fill_hw_s_info(struct net_device *dev, struct sk_buff *skb,
59d158395664dab Petr Machata        2021-11-25  5095  				   int in_hw_count)
a8a72b09197b260 Petr Machata        2021-10-22  5096  {
59d158395664dab Petr Machata        2021-11-25  5097  	bool enabled = netdev_offload_xstats_enabled(dev);
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5098  	struct nlattr *nest;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5099  	int err;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5100  
59d158395664dab Petr Machata        2021-11-25  5101  	nest = nla_nest_start(skb, IFLA_OFFLOAD_XSTATS_HW_S_INFO);
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5102  	if (!nest)
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5103  		return -EMSGSIZE;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5104  
59d158395664dab Petr Machata        2021-11-25  5105  	if (nla_put_u8(skb, IFLA_OFFLOAD_XSTATS_HW_S_INFO_ENABLED, enabled))
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5106  		goto nla_put_failure;
d35d00a6d28ff7a Petr Machata        2021-11-12  5107  
59d158395664dab Petr Machata        2021-11-25  5108  	if (enabled &&
59d158395664dab Petr Machata        2021-11-25  5109  	    nla_put_u32(skb, IFLA_OFFLOAD_XSTATS_HW_S_INFO_IN_HW_COUNT,
59d158395664dab Petr Machata        2021-11-25  5110  			in_hw_count))
d35d00a6d28ff7a Petr Machata        2021-11-12  5111  		goto nla_put_failure;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5112  
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5113  	nla_nest_end(skb, nest);
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5114  	return 0;
a8a72b09197b260 Petr Machata        2021-10-22  5115  
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5116  nla_put_failure:
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5117  	nla_nest_cancel(skb, nest);
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5118  	return -EMSGSIZE;
a8a72b09197b260 Petr Machata        2021-10-22  5119  }
a8a72b09197b260 Petr Machata        2021-10-22  5120  
59d158395664dab Petr Machata        2021-11-25  5121  static unsigned int
59d158395664dab Petr Machata        2021-11-25  5122  rtnl_offload_xstats_get_size_sw_stats(const struct rtnl_offload_xstats_info *info,
59d158395664dab Petr Machata        2021-11-25  5123  				      const struct net_device *dev)
59d158395664dab Petr Machata        2021-11-25  5124  {
59d158395664dab Petr Machata        2021-11-25  5125  	return sizeof(struct rtnl_link_stats64);
59d158395664dab Petr Machata        2021-11-25  5126  }
59d158395664dab Petr Machata        2021-11-25  5127  
59d158395664dab Petr Machata        2021-11-25  5128  static int
59d158395664dab Petr Machata        2021-11-25  5129  rtnl_offload_xstats_fill_sw_stats(struct net_device *dev, struct sk_buff *skb,
59d158395664dab Petr Machata        2021-11-25  5130  				  struct netlink_ext_ack *extack)
a8a72b09197b260 Petr Machata        2021-10-22  5131  {
59d158395664dab Petr Machata        2021-11-25  5132  	// xxx
59d158395664dab Petr Machata        2021-11-25  5133  }
59d158395664dab Petr Machata        2021-11-25  5134  
59d158395664dab Petr Machata        2021-11-25  5135  static int rtnl_get_offload_stats_size(const struct net_device *dev,
59d158395664dab Petr Machata        2021-11-25  5136  				       u32 off_filter_mask)
a8a72b09197b260 Petr Machata        2021-10-22  5137  {
59d158395664dab Petr Machata        2021-11-25  5138  	int attr_id_cpu_hit = IFLA_OFFLOAD_XSTATS_CPU_HIT;
59d158395664dab Petr Machata        2021-11-25  5139  	int nla_size = 0;
59d158395664dab Petr Machata        2021-11-25  5140  	int size;
59d158395664dab Petr Machata        2021-11-25  5141  
59d158395664dab Petr Machata        2021-11-25  5142  	if (off_filter_mask &
59d158395664dab Petr Machata        2021-11-25  5143  	    IFLA_STATS_FILTER_BIT(attr_id_cpu_hit)) {
59d158395664dab Petr Machata        2021-11-25  5144  		size = rtnl_offload_xstats_get_size_ndo(dev, attr_id_cpu_hit);
59d158395664dab Petr Machata        2021-11-25  5145  		nla_size += nla_total_size_64bit(size);
59d158395664dab Petr Machata        2021-11-25  5146  	}
59d158395664dab Petr Machata        2021-11-25  5147  
59d158395664dab Petr Machata        2021-11-25  5148  	if (off_filter_mask &
59d158395664dab Petr Machata        2021-11-25  5149  	    IFLA_STATS_FILTER_BIT(IFLA_OFFLOAD_XSTATS_HW_STATS)) {
59d158395664dab Petr Machata        2021-11-25  5150  		size = rtnl_offload_xstats_get_size_hw_stats(dev);
59d158395664dab Petr Machata        2021-11-25  5151  		nla_size += nla_total_size_64bit(size);
59d158395664dab Petr Machata        2021-11-25  5152  	}
59d158395664dab Petr Machata        2021-11-25  5153  
59d158395664dab Petr Machata        2021-11-25  5154  	if (off_filter_mask &
59d158395664dab Petr Machata        2021-11-25  5155  	    IFLA_STATS_FILTER_BIT(IFLA_OFFLOAD_XSTATS_HW_S_INFO)) {
59d158395664dab Petr Machata        2021-11-25 @5156  		size = rtnl_offload_xstats_get_size_hw_s_info(dev);
59d158395664dab Petr Machata        2021-11-25  5157  		nla_size += nla_total_size(size);
59d158395664dab Petr Machata        2021-11-25  5158  	}
59d158395664dab Petr Machata        2021-11-25  5159  
59d158395664dab Petr Machata        2021-11-25  5160  	if (off_filter_mask &
59d158395664dab Petr Machata        2021-11-25  5161  	    IFLA_STATS_FILTER_BIT(IFLA_OFFLOAD_XSTATS_SW_STATS)) {
59d158395664dab Petr Machata        2021-11-25 @5162  		size = rtnl_offload_xstats_get_size_sw_stats(dev);
59d158395664dab Petr Machata        2021-11-25  5163  		nla_size += nla_total_size_64bit(size);
59d158395664dab Petr Machata        2021-11-25  5164  	}
59d158395664dab Petr Machata        2021-11-25  5165  
59d158395664dab Petr Machata        2021-11-25  5166  	if (nla_size != 0)
59d158395664dab Petr Machata        2021-11-25  5167  		nla_size += nla_total_size(0);
59d158395664dab Petr Machata        2021-11-25  5168  
59d158395664dab Petr Machata        2021-11-25  5169  	return nla_size;
59d158395664dab Petr Machata        2021-11-25  5170  }
a8a72b09197b260 Petr Machata        2021-10-22  5171  
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5172  static int rtnl_fill_offload_stats(struct sk_buff *skb, struct net_device *dev,
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5173  				   int *prividx, u32 off_filter_mask,
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5174  				   struct netlink_ext_ack *extack)
69ae6ad2ff37911 Nogah Frankel       2016-09-16  5175  {
59d158395664dab Petr Machata        2021-11-25  5176  	bool hw_stats_enabled = netdev_offload_xstats_enabled(dev);
59d158395664dab Petr Machata        2021-11-25  5177  	int attr_id_hw_s_info = IFLA_OFFLOAD_XSTATS_HW_S_INFO;
59d158395664dab Petr Machata        2021-11-25  5178  	int attr_id_hw_stats = IFLA_OFFLOAD_XSTATS_HW_STATS;
59d158395664dab Petr Machata        2021-11-25  5179  	int attr_id_sw_stats = IFLA_OFFLOAD_XSTATS_SW_STATS;
59d158395664dab Petr Machata        2021-11-25  5180  	int attr_id_cpu_hit = IFLA_OFFLOAD_XSTATS_CPU_HIT;
59d158395664dab Petr Machata        2021-11-25  5181  	struct rtnl_link_stats64 *hw_stats = NULL;
59d158395664dab Petr Machata        2021-11-25  5182  	u32 in_hw_count = 0;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5183  	int err = -ENODATA;
a8a72b09197b260 Petr Machata        2021-10-22  5184  	int i;
69ae6ad2ff37911 Nogah Frankel       2016-09-16  5185  
59d158395664dab Petr Machata        2021-11-25  5186  	if ((off_filter_mask & IFLA_STATS_FILTER_BIT(attr_id_cpu_hit)) &&
59d158395664dab Petr Machata        2021-11-25  5187  	    *prividx < attr_id_cpu_hit) {
59d158395664dab Petr Machata        2021-11-25  5188  		err = rtnl_offload_xstats_fill_ndo(dev, attr_id_cpu_hit, skb,
59d158395664dab Petr Machata        2021-11-25  5189  						   extack);
59d158395664dab Petr Machata        2021-11-25  5190  		if (err) {
59d158395664dab Petr Machata        2021-11-25  5191  			*prividx = attr_id_cpu_hit;
59d158395664dab Petr Machata        2021-11-25  5192  			return err;
59d158395664dab Petr Machata        2021-11-25  5193  		}
59d158395664dab Petr Machata        2021-11-25  5194  	}
69ae6ad2ff37911 Nogah Frankel       2016-09-16  5195  
59d158395664dab Petr Machata        2021-11-25  5196  	/* Reserve space for IFLA_OFFLOAD_XSTATS_HW_STATS. This allocates the
59d158395664dab Petr Machata        2021-11-25  5197  	 * attribute, but leaves the payload empty.
59d158395664dab Petr Machata        2021-11-25  5198  	 *
59d158395664dab Petr Machata        2021-11-25  5199  	 * xxx can this lead to issues in dumping when hw_stats_get() fails below?
59d158395664dab Petr Machata        2021-11-25  5200  	 */
59d158395664dab Petr Machata        2021-11-25  5201  	if (hw_stats_enabled &&
59d158395664dab Petr Machata        2021-11-25  5202  	    (off_filter_mask & IFLA_STATS_FILTER_BIT(attr_id_hw_stats)) &&
59d158395664dab Petr Machata        2021-11-25  5203  	    *prividx < attr_id_hw_stats) {
59d158395664dab Petr Machata        2021-11-25  5204  		struct nlattr *attr;
69ae6ad2ff37911 Nogah Frankel       2016-09-16  5205  
59d158395664dab Petr Machata        2021-11-25 @5206  		attr = nla_reserve_64bit(skb, attr_id_hw_stats, size,
59d158395664dab Petr Machata        2021-11-25  5207  					 IFLA_OFFLOAD_XSTATS_UNSPEC);
59d158395664dab Petr Machata        2021-11-25  5208  		if (!attr) {
59d158395664dab Petr Machata        2021-11-25  5209  			*prividx = attr_id_hw_stats;
59d158395664dab Petr Machata        2021-11-25  5210  			return -EMSGSIZE;
59d158395664dab Petr Machata        2021-11-25  5211  		}
59d158395664dab Petr Machata        2021-11-25  5212  
59d158395664dab Petr Machata        2021-11-25  5213  		hw_stats = nla_data(attr);
59d158395664dab Petr Machata        2021-11-25  5214  	}
59d158395664dab Petr Machata        2021-11-25  5215  
59d158395664dab Petr Machata        2021-11-25  5216  	/* Fetch the data for IFLA_OFFLOAD_XSTATS_HW_STATS and _HW_S_INFO,
59d158395664dab Petr Machata        2021-11-25  5217  	 * filling the payload allocated above in the process. Note that
59d158395664dab Petr Machata        2021-11-25  5218  	 * _HW_S_INFO needs to be emitted even if HW stats are disabled, so this
59d158395664dab Petr Machata        2021-11-25  5219  	 * is always called to get in_hw_count.
59d158395664dab Petr Machata        2021-11-25  5220  	 */
59d158395664dab Petr Machata        2021-11-25  5221  	if (((off_filter_mask & IFLA_STATS_FILTER_BIT(attr_id_hw_stats)) ||
59d158395664dab Petr Machata        2021-11-25  5222  	     (off_filter_mask & IFLA_STATS_FILTER_BIT(attr_id_hw_s_info))) &&
59d158395664dab Petr Machata        2021-11-25  5223  	    *prividx < attr_id_hw_s_info) {
59d158395664dab Petr Machata        2021-11-25  5224  		err = netdev_offload_xstats_hw_stats_get(dev, hw_stats,
59d158395664dab Petr Machata        2021-11-25  5225  							 &in_hw_count, extack);
59d158395664dab Petr Machata        2021-11-25  5226  		if (err) {
59d158395664dab Petr Machata        2021-11-25  5227  			*prividx = attr_id_hw_stats;
59d158395664dab Petr Machata        2021-11-25  5228  			return err;
59d158395664dab Petr Machata        2021-11-25  5229  		}
59d158395664dab Petr Machata        2021-11-25  5230  	}
59d158395664dab Petr Machata        2021-11-25  5231  
59d158395664dab Petr Machata        2021-11-25  5232  	if (off_filter_mask & IFLA_STATS_FILTER_BIT(attr_id_hw_s_info) &&
59d158395664dab Petr Machata        2021-11-25  5233  	    *prividx < attr_id_hw_s_info) {
59d158395664dab Petr Machata        2021-11-25  5234  		err = rtnl_offload_xstats_fill_hw_s_info(dev, skb, in_hw_count);
59d158395664dab Petr Machata        2021-11-25  5235  		if (err) {
59d158395664dab Petr Machata        2021-11-25  5236  			*prividx = attr_id_hw_s_info;
59d158395664dab Petr Machata        2021-11-25  5237  			return err;
59d158395664dab Petr Machata        2021-11-25  5238  		}
59d158395664dab Petr Machata        2021-11-25  5239  	}
69ae6ad2ff37911 Nogah Frankel       2016-09-16  5240  
59d158395664dab Petr Machata        2021-11-25  5241  	if (hw_stats_enabled &&
59d158395664dab Petr Machata        2021-11-25  5242  	    (off_filter_mask & IFLA_STATS_FILTER_BIT(attr_id_hw_stats)) &&
59d158395664dab Petr Machata        2021-11-25  5243  	    *prividx < attr_id_sw_stats) {
59d158395664dab Petr Machata        2021-11-25  5244  		err = rtnl_offload_xstats_fill_sw_stats(dev, skb, extack);
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5245  		if (err) {
59d158395664dab Petr Machata        2021-11-25  5246  			*prividx = attr_id_sw_stats;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5247  			return err;
7f3ca7ed5c4b775 Petr Machata        2021-11-03  5248  		}
69ae6ad2ff37911 Nogah Frankel       2016-09-16  5249  	}
69ae6ad2ff37911 Nogah Frankel       2016-09-16  5250  
69ae6ad2ff37911 Nogah Frankel       2016-09-16  5251  	*prividx = 0;
69ae6ad2ff37911 Nogah Frankel       2016-09-16  5252  	return err;
69ae6ad2ff37911 Nogah Frankel       2016-09-16  5253  }
69ae6ad2ff37911 Nogah Frankel       2016-09-16  5254  

:::::: The code at line 5033 was first introduced by commit
:::::: 7f3ca7ed5c4b775fb9261fd6dfeccf77ad124147 wip

:::::: TO: Petr Machata <petrm@nvidia.com>
:::::: CC: Petr Machata <petrm@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

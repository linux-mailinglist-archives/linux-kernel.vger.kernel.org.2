Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E6845E1A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357159AbhKYUfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:35:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:40454 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242856AbhKYUdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:33:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235806523"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235806523"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 12:29:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="675349433"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2021 12:29:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqLNO-0006tR-7y; Thu, 25 Nov 2021 20:29:50 +0000
Date:   Fri, 26 Nov 2021 04:29:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Machata <petrm@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:petrm_soft_counters 8/8] net/core/rtnetlink.c:5073:53:
 warning: 'struct rtnl_offload_xstats_info' declared inside parameter list
 will not be visible outside of this definition or declaration
Message-ID: <202111260408.k2mncGpq-lkp@intel.com>
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
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211126/202111260408.k2mncGpq-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/jpirko/linux_mlxsw/commit/59d158395664dab1c1164364d6ee57aaaad44b96
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw petrm_soft_counters
        git checkout 59d158395664dab1c1164364d6ee57aaaad44b96
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/core/rtnetlink.c: In function 'rtnl_offload_xstats_have_ndo':
   net/core/rtnetlink.c:5033:53: error: 'info' undeclared (first use in this function)
    5033 |         dev->netdev_ops->ndo_has_offload_stats(dev, info->attr_id);
         |                                                     ^~~~
   net/core/rtnetlink.c:5033:53: note: each undeclared identifier is reported only once for each function it appears in
   net/core/rtnetlink.c: At top level:
>> net/core/rtnetlink.c:5073:53: warning: 'struct rtnl_offload_xstats_info' declared inside parameter list will not be visible outside of this definition or declaration
    5073 | rtnl_offload_xstats_get_size_hw_s_info(const struct rtnl_offload_xstats_info *info,
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   net/core/rtnetlink.c: In function 'rtnl_offload_xstats_get_size_hw_s_info':
   net/core/rtnetlink.c:5076:17: error: implicit declaration of function 'netdev_offload_xstats_enabled'; did you mean 'netdev_offload_xstats_report_delta'? [-Werror=implicit-function-declaration]
    5076 |  bool enabled = netdev_offload_xstats_enabled(dev);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 netdev_offload_xstats_report_delta
   net/core/rtnetlink.c:5082:5: error: expected ';' before '}' token
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
   net/core/rtnetlink.c:5156:49: error: passing argument 1 of 'rtnl_offload_xstats_get_size_hw_s_info' from incompatible pointer type [-Werror=incompatible-pointer-types]
    5156 |   size = rtnl_offload_xstats_get_size_hw_s_info(dev);
         |                                                 ^~~
         |                                                 |
         |                                                 const struct net_device *
   net/core/rtnetlink.c:5073:79: note: expected 'const struct rtnl_offload_xstats_info *' but argument is of type 'const struct net_device *'
    5073 | rtnl_offload_xstats_get_size_hw_s_info(const struct rtnl_offload_xstats_info *info,
         |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   net/core/rtnetlink.c:5156:10: error: too few arguments to function 'rtnl_offload_xstats_get_size_hw_s_info'
    5156 |   size = rtnl_offload_xstats_get_size_hw_s_info(dev);
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/rtnetlink.c:5073:1: note: declared here
    5073 | rtnl_offload_xstats_get_size_hw_s_info(const struct rtnl_offload_xstats_info *info,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/rtnetlink.c:5162:48: error: passing argument 1 of 'rtnl_offload_xstats_get_size_sw_stats' from incompatible pointer type [-Werror=incompatible-pointer-types]
    5162 |   size = rtnl_offload_xstats_get_size_sw_stats(dev);
         |                                                ^~~
         |                                                |
         |                                                const struct net_device *
   net/core/rtnetlink.c:5122:78: note: expected 'const struct rtnl_offload_xstats_info *' but argument is of type 'const struct net_device *'
    5122 | rtnl_offload_xstats_get_size_sw_stats(const struct rtnl_offload_xstats_info *info,
         |                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   net/core/rtnetlink.c:5162:10: error: too few arguments to function 'rtnl_offload_xstats_get_size_sw_stats'
    5162 |   size = rtnl_offload_xstats_get_size_sw_stats(dev);
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/rtnetlink.c:5122:1: note: declared here
    5122 | rtnl_offload_xstats_get_size_sw_stats(const struct rtnl_offload_xstats_info *info,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/rtnetlink.c: In function 'rtnl_fill_offload_stats':
   net/core/rtnetlink.c:5206:51: error: 'size' undeclared (first use in this function); did you mean 'ksize'?
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
   net/core/rtnetlink.c:5535:28: error: 'IFLA_HW_STATS_IMMEDIATE' undeclared here (not in a function); did you mean 'TCA_ACT_HW_STATS_IMMEDIATE'?
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


vim +5073 net/core/rtnetlink.c

  5071	
  5072	static unsigned int
> 5073	rtnl_offload_xstats_get_size_hw_s_info(const struct rtnl_offload_xstats_info *info,
  5074					       const struct net_device *dev)
  5075	{
  5076		bool enabled = netdev_offload_xstats_enabled(dev);
  5077	
  5078		return (/* IFLA_OFFLOAD_XSTATS_HW_S_INFO_ENABLED */
  5079			nla_total_size(sizeof(u8)) +
  5080			/* IFLA_OFFLOAD_XSTATS_HW_S_INFO_IN_HW_COUNT */
  5081			(enabled ? nla_total_size(sizeof(u32)) : 0) +
  5082			0)
  5083	}
  5084	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

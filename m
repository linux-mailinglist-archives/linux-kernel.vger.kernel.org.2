Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DB13D519A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 05:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhGZDCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 23:02:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:39337 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhGZDCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 23:02:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="275951246"
X-IronPort-AV: E=Sophos;i="5.84,269,1620716400"; 
   d="gz'50?scan'50,208,50";a="275951246"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2021 20:43:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,269,1620716400"; 
   d="gz'50?scan'50,208,50";a="515934832"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.162]) ([10.255.30.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2021 20:43:19 -0700
Subject: drivers/hv/channel_mgmt.c:785:22: warning: Assigned value is garbage
 or undefined [clang-analyzer-core.uninitialized.Assign]
References: <202107251901.GJvlsBLV-lkp@intel.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
From:   kernel test robot <rong.a.chen@intel.com>
X-Forwarded-Message-Id: <202107251901.GJvlsBLV-lkp@intel.com>
Message-ID: <39c4fa80-f65e-50c3-5706-809d4a2a2c9b@intel.com>
Date:   Mon, 26 Jul 2021 11:43:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202107251901.GJvlsBLV-lkp@intel.com>
Content-Type: multipart/mixed;
 boundary="------------BEBA731C18CB3547B677C591"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BEBA731C18CB3547B677C591
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


Hi Haiyang,

First bad commit (maybe != root cause):

tree: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d8079fac168168b25677dc16c00ffaf9fb7df723
commit: 7c9ff3deeee61b253715dcf968a6307af148c9b2 Drivers: hv: vmbus: Fix 
duplicate CPU assignments within a device
date:   6 days ago
:::::: branch date: 11 hours ago
:::::: commit date: 6 days ago
config: x86_64-randconfig-c001-20210725 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 
3f2c1e99e44d028d5e9dd685f3c568f2661f2f68)
reproduce (this is a W=1 build):
         wget 
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
-O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install x86_64 cross compiling tool for clang build
         # apt-get install binutils-x86-64-linux-gnu
         # 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c9ff3deeee61b253715dcf968a6307af148c9b2
         git remote add linus 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout 7c9ff3deeee61b253715dcf968a6307af148c9b2
         # save the attached .config to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 
clang-analyzer ARCH=x86_64
If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/hid/hid-core.c:1601:3: note: Taking false branch
                    if (field->logical_minimum < 0) /* signed values */
                    ^
    drivers/hid/hid-core.c:1605:44: note: Passing value via 4th 
parameter 'n'
                            implement(hid, data, offset + n * size, size,
                                                                    ^~~~
    drivers/hid/hid-core.c:1605:4: note: Calling 'implement'
                            implement(hid, data, offset + n * size, size,
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/hid/hid-core.c:1421:15: note: Assuming 'n' is <= 32
            if (unlikely(n > 32)) {
                         ^
    include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
    # define unlikely(x)    __builtin_expect(!!(x), 0)
                                                ^
    drivers/hid/hid-core.c:1421:2: note: Taking false branch
            if (unlikely(n > 32)) {
            ^
    drivers/hid/hid-core.c:1425:13: note: Assuming 'n' is >= 32
            } else if (n < 32) {
                       ^~~~~~
    drivers/hid/hid-core.c:1425:9: note: Taking false branch
            } else if (n < 32) {
                   ^
    drivers/hid/hid-core.c:1437:30: note: Passing the value 32 via 3rd 
parameter 'n'
            __implement(report, offset, n, value);
                                        ^
    drivers/hid/hid-core.c:1437:2: note: Calling '__implement'
            __implement(report, offset, n, value);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/hid/hid-core.c:1400:9: note: Assuming the condition is false
            while (n - bits_to_set >= 0) {
                   ^~~~~~~~~~~~~~~~~~~~
    drivers/hid/hid-core.c:1400:2: note: Loop condition is false. 
Execution continues on line 1411
            while (n - bits_to_set >= 0) {
            ^
    drivers/hid/hid-core.c:1411:6: note: 'n' is 32
            if (n) {
                ^
    drivers/hid/hid-core.c:1411:2: note: Taking true branch
            if (n) {
            ^
    drivers/hid/hid-core.c:1412:22: note: The result of the left shift 
is undefined due to shifting by '32', which is greater or equal to the 
width of type 'unsigned int'
                    u8 bit_mask = ((1U << n) - 1);
                                       ^  ~
    drivers/hid/hid-core.c:1984:3: warning: Value stored to 'len' is 
never read [clang-analyzer-deadcode.DeadStores]
                    len += sprintf(buf + len, "%shidraw%d", len ? "," : "",
                    ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/hid/hid-core.c:1984:3: note: Value stored to 'len' is never read
                    len += sprintf(buf + len, "%shidraw%d", len ? "," : "",
                    ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Suppressed 5 warnings (5 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    6 warnings generated.
    Suppressed 6 warnings (6 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    6 warnings generated.
    Suppressed 6 warnings (6 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    7 warnings generated.
    Suppressed 7 warnings (7 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    4 warnings generated.
    Suppressed 4 warnings (4 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    4 warnings generated.
    Suppressed 4 warnings (4 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    4 warnings generated.
    Suppressed 4 warnings (4 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    4 warnings generated.
    Suppressed 4 warnings (4 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    4 warnings generated.
    Suppressed 4 warnings (4 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    4 warnings generated.
    Suppressed 4 warnings (4 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    4 warnings generated.
    Suppressed 4 warnings (4 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    5 warnings generated.
    Suppressed 5 warnings (5 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    4 warnings generated.
    Suppressed 4 warnings (4 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    3 warnings generated.
    Suppressed 3 warnings (3 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    9 warnings generated.
    Suppressed 9 warnings (8 in non-user code, 1 with check filters).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    5 warnings generated.
    Suppressed 5 warnings (5 in non-user code).
    Use -header-filter=.* to display errors from all non-system headers. 
Use -system-headers to display errors from system headers as well.
    6 warnings generated.
>> drivers/hv/channel_mgmt.c:785:22: warning: Assigned value is garbage or undefined [clang-analyzer-core.uninitialized.Assign]
            channel->target_cpu = target_cpu;
                                ^
    drivers/hv/channel_mgmt.c:608:2: note: Left side of '&&' is false
            list_for_each_entry(channel, &vmbus_connection.chn_list, 
listentry) {
            ^
    include/linux/list.h:628:13: note: expanded from macro 
'list_for_each_entry'
            for (pos = list_first_entry(head, typeof(*pos), member); 
     \
                       ^
    include/linux/list.h:522:2: note: expanded from macro 'list_first_entry'
            list_entry((ptr)->next, type, member)
            ^
    include/linux/list.h:511:2: note: expanded from macro 'list_entry'
            container_of(ptr, type, member)
            ^
    include/linux/kernel.h:495:61: note: expanded from macro 'container_of'
            BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) 
&&   \
                                                                       ^
    drivers/hv/channel_mgmt.c:608:2: note: Taking false branch
            list_for_each_entry(channel, &vmbus_connection.chn_list, 
listentry) {
            ^
    include/linux/list.h:628:13: note: expanded from macro 
'list_for_each_entry'
            for (pos = list_first_entry(head, typeof(*pos), member); 
     \
                       ^
    include/linux/list.h:522:2: note: expanded from macro 'list_first_entry'
            list_entry((ptr)->next, type, member)
            ^
    include/linux/list.h:511:2: note: expanded from macro 'list_entry'
            container_of(ptr, type, member)
            ^
    note: (skipping 2 expansions in backtrace; use 
-fmacro-backtrace-limit=0 to see all)
    include/linux/compiler_types.h:328:2: note: expanded from macro 
'compiletime_assert'
            _compiletime_assert(condition, msg, __compiletime_assert_, 
__COUNTER__)
            ^
    include/linux/compiler_types.h:316:2: note: expanded from macro 
'_compiletime_assert'
            __compiletime_assert(condition, msg, prefix, suffix)
            ^
    include/linux/compiler_types.h:308:3: note: expanded from macro 
'__compiletime_assert'
                    if (!(condition)) 
     \
                    ^
    drivers/hv/channel_mgmt.c:608:2: note: Loop condition is false. 
Exiting loop
            list_for_each_entry(channel, &vmbus_connection.chn_list, 
listentry) {
            ^
    include/linux/list.h:628:13: note: expanded from macro 
'list_for_each_entry'
            for (pos = list_first_entry(head, typeof(*pos), member); 
     \
                       ^
    include/linux/list.h:522:2: note: expanded from macro 'list_first_entry'
            list_entry((ptr)->next, type, member)
            ^
    include/linux/list.h:511:2: note: expanded from macro 'list_entry'
            container_of(ptr, type, member)
            ^
    note: (skipping 2 expansions in backtrace; use 
-fmacro-backtrace-limit=0 to see all)
    include/linux/compiler_types.h:328:2: note: expanded from macro 
'compiletime_assert'
            _compiletime_assert(condition, msg, __compiletime_assert_, 
__COUNTER__)
            ^
    include/linux/compiler_types.h:316:2: note: expanded from macro 
'_compiletime_assert'
            __compiletime_assert(condition, msg, prefix, suffix)
            ^
    include/linux/compiler_types.h:306:2: note: expanded from macro 
'__compiletime_assert'
            do { 
     \
            ^
    drivers/hv/channel_mgmt.c:608:2: note: Loop condition is false. 
Execution continues on line 619
            list_for_each_entry(channel, &vmbus_connection.chn_list, 
listentry) {
            ^
    include/linux/list.h:628:2: note: expanded from macro 
'list_for_each_entry'
            for (pos = list_first_entry(head, typeof(*pos), member); 
     \
            ^
    drivers/hv/channel_mgmt.c:619:2: note: Calling 'init_vp_index'
            init_vp_index(newchannel);
            ^~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/hv/channel_mgmt.c:732:2: note: 'target_cpu' declared without 
an initial value
            u32 target_cpu;
            ^~~~~~~~~~~~~~
    drivers/hv/channel_mgmt.c:735:7: note: Assuming the condition is false
            if ((vmbus_proto_version == VERSION_WS2008) ||
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/hv/channel_mgmt.c:735:6: note: Left side of '||' is false
            if ((vmbus_proto_version == VERSION_WS2008) ||
                ^
    drivers/hv/channel_mgmt.c:736:7: note: Assuming the condition is false
                (vmbus_proto_version == VERSION_WIN7) || (!perf_chn) ||
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/hv/channel_mgmt.c:735:6: note: Left side of '||' is false
            if ((vmbus_proto_version == VERSION_WS2008) ||
                ^
    drivers/hv/channel_mgmt.c:736:48: note: Assuming 'perf_chn' is true
                (vmbus_proto_version == VERSION_WIN7) || (!perf_chn) ||
                                                          ^~~~~~~~~
    drivers/hv/channel_mgmt.c:735:6: note: Left side of '||' is false
            if ((vmbus_proto_version == VERSION_WS2008) ||
                ^
    drivers/hv/channel_mgmt.c:737:7: note: Calling 'alloc_cpumask_var'
                !alloc_cpumask_var(&available_mask, GFP_KERNEL)) {
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    include/linux/cpumask.h:740:2: note: Returning the value 1, which 
participates in a condition later
            return true;
            ^~~~~~~~~~~
    drivers/hv/channel_mgmt.c:737:7: note: Returning from 
'alloc_cpumask_var'
                !alloc_cpumask_var(&available_mask, GFP_KERNEL)) {
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +785 drivers/hv/channel_mgmt.c

a119845f6e98c8 K. Y. Srinivasan         2012-12-01  714  a119845f6e98c8 
K. Y. Srinivasan         2012-12-01  715  /*
a119845f6e98c8 K. Y. Srinivasan         2012-12-01  716   * Starting 
with Win8, we can statically distribute the incoming
1f656ff3fdddc2 K. Y. Srinivasan         2015-05-30  717   * channel 
interrupt load by binding a channel to VCPU.
1f656ff3fdddc2 K. Y. Srinivasan         2015-05-30  718   *
1f656ff3fdddc2 K. Y. Srinivasan         2015-05-30  719   * For pre-win8 
hosts or non-performance critical channels we assign the
d570aec0f2154e Andrea Parri (Microsoft  2020-04-06  720)  * 
VMBUS_CONNECT_CPU.
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  721)  *
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  722)  * Starting 
with win8, performance critical channels will be distributed
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  723)  * evenly among 
all the available NUMA nodes.  Once the node is assigned,
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  724)  * we will 
assign the CPU based on a simple round robin scheme.
a119845f6e98c8 K. Y. Srinivasan         2012-12-01  725   */
afaa33da08abd1 Andrea Parri (Microsoft  2020-05-22  726) static void 
init_vp_index(struct vmbus_channel *channel)
a119845f6e98c8 K. Y. Srinivasan         2012-12-01  727  {
afaa33da08abd1 Andrea Parri (Microsoft  2020-05-22  728) 	bool perf_chn 
= hv_is_perf_channel(channel);
7c9ff3deeee61b Haiyang Zhang            2021-07-16  729  	u32 i, ncpu = 
num_online_cpus();
25355252607ca2 Dexuan Cui               2018-09-23  730  	cpumask_var_t 
available_mask;
9f01ec53458d9e K. Y. Srinivasan         2015-08-05  731  	struct cpumask 
*alloced_mask;
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  732) 	u32 target_cpu;
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  733) 	int numa_node;
a119845f6e98c8 K. Y. Srinivasan         2012-12-01  734  a119845f6e98c8 
K. Y. Srinivasan         2012-12-01  735  	if ((vmbus_proto_version == 
VERSION_WS2008) ||
25355252607ca2 Dexuan Cui               2018-09-23  736  	 
(vmbus_proto_version == VERSION_WIN7) || (!perf_chn) ||
25355252607ca2 Dexuan Cui               2018-09-23  737  	 
!alloc_cpumask_var(&available_mask, GFP_KERNEL)) {
a119845f6e98c8 K. Y. Srinivasan         2012-12-01  738  		/*
a119845f6e98c8 K. Y. Srinivasan         2012-12-01  739  		 * Prior to 
win8, all channel interrupts are
d570aec0f2154e Andrea Parri (Microsoft  2020-04-06  740) 		 * delivered 
on VMBUS_CONNECT_CPU.
a119845f6e98c8 K. Y. Srinivasan         2012-12-01  741  		 * Also if 
the channel is not a performance critical
d570aec0f2154e Andrea Parri (Microsoft  2020-04-06  742) 		 * channel, 
bind it to VMBUS_CONNECT_CPU.
d570aec0f2154e Andrea Parri (Microsoft  2020-04-06  743) 		 * In case 
alloc_cpumask_var() fails, bind it to
d570aec0f2154e Andrea Parri (Microsoft  2020-04-06  744) 		 * 
VMBUS_CONNECT_CPU.
a119845f6e98c8 K. Y. Srinivasan         2012-12-01  745  		 */
d570aec0f2154e Andrea Parri (Microsoft  2020-04-06  746) 	 
channel->target_cpu = VMBUS_CONNECT_CPU;
afaa33da08abd1 Andrea Parri (Microsoft  2020-05-22  747) 		if (perf_chn)
afaa33da08abd1 Andrea Parri (Microsoft  2020-05-22  748) 		 
hv_set_alloced_cpu(VMBUS_CONNECT_CPU);
d3ba720dd58cdf K. Y. Srinivasan         2014-04-08  749  		return;
a119845f6e98c8 K. Y. Srinivasan         2012-12-01  750  	}
ce59fec836a9b4 Vitaly Kuznetsov         2015-05-06  751  7c9ff3deeee61b 
Haiyang Zhang            2021-07-16  752  	for (i = 1; i <= ncpu + 1; i++) {
1f656ff3fdddc2 K. Y. Srinivasan         2015-05-30  753  		while (true) {
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  754) 			numa_node = 
next_numa_node_id++;
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  755) 			if 
(numa_node == nr_node_ids) {
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  756) 			 
next_numa_node_id = 0;
509879bdb30b8e K. Y. Srinivasan         2016-09-02  757  				continue;
509879bdb30b8e K. Y. Srinivasan         2016-09-02  758  			}
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  759) 			if 
(cpumask_empty(cpumask_of_node(numa_node)))
1f656ff3fdddc2 K. Y. Srinivasan         2015-05-30  760  				continue;
1f656ff3fdddc2 K. Y. Srinivasan         2015-05-30  761  			break;
1f656ff3fdddc2 K. Y. Srinivasan         2015-05-30  762  		}
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  763) 		alloced_mask 
= &hv_context.hv_numa_map[numa_node];
1f656ff3fdddc2 K. Y. Srinivasan         2015-05-30  764  9f01ec53458d9e 
K. Y. Srinivasan         2015-08-05  765  		if 
(cpumask_weight(alloced_mask) ==
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  766) 		 
cpumask_weight(cpumask_of_node(numa_node))) {
ce59fec836a9b4 Vitaly Kuznetsov         2015-05-06  767  			/*
1f656ff3fdddc2 K. Y. Srinivasan         2015-05-30  768  			 * We have 
cycled through all the CPUs in the node;
1f656ff3fdddc2 K. Y. Srinivasan         2015-05-30  769  			 * reset the 
alloced map.
ce59fec836a9b4 Vitaly Kuznetsov         2015-05-06  770  			 */
9f01ec53458d9e K. Y. Srinivasan         2015-08-05  771  		 
cpumask_clear(alloced_mask);
ce59fec836a9b4 Vitaly Kuznetsov         2015-05-06  772  		}
ce59fec836a9b4 Vitaly Kuznetsov         2015-05-06  773  7c9ff3deeee61b 
Haiyang Zhang            2021-07-16  774  		cpumask_xor(available_mask, 
alloced_mask,
7c9ff3deeee61b Haiyang Zhang            2021-07-16  775  			 
cpumask_of_node(numa_node));
79fd8e706637a5 Vitaly Kuznetsov         2016-01-27  776  8ef4c4abbbcdcd 
Andrea Parri (Microsoft  2020-04-06  777) 		target_cpu = 
cpumask_first(available_mask);
8ef4c4abbbcdcd Andrea Parri (Microsoft  2020-04-06  778) 	 
cpumask_set_cpu(target_cpu, alloced_mask);
1f656ff3fdddc2 K. Y. Srinivasan         2015-05-30  779  7c9ff3deeee61b 
Haiyang Zhang            2021-07-16  780  		if 
(channel->offermsg.offer.sub_channel_index >= ncpu ||
7c9ff3deeee61b Haiyang Zhang            2021-07-16  781  		    i > ncpu 
|| !hv_cpuself_used(target_cpu, channel))
7c9ff3deeee61b Haiyang Zhang            2021-07-16  782  			break;
7c9ff3deeee61b Haiyang Zhang            2021-07-16  783  	}
7c9ff3deeee61b Haiyang Zhang            2021-07-16  784  8ef4c4abbbcdcd 
Andrea Parri (Microsoft  2020-04-06 @785) 	channel->target_cpu = target_cpu;
25355252607ca2 Dexuan Cui               2018-09-23  786  25355252607ca2 
Dexuan Cui               2018-09-23  787  	free_cpumask_var(available_mask);
a119845f6e98c8 K. Y. Srinivasan         2012-12-01  788  }
a119845f6e98c8 K. Y. Srinivasan         2012-12-01  789
:::::: The code at line 785 was first introduced by commit
:::::: 8ef4c4abbbcdcd9d4bc0fd9454df03e6dac24b73 Drivers: hv: vmbus: 
Remove the unused HV_LOCALIZED channel affinity logic

:::::: TO: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
:::::: CC: Wei Liu <wei.liu@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


--------------BEBA731C18CB3547B677C591
Content-Type: application/gzip;
 name=".config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=".config.gz"

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
--------------BEBA731C18CB3547B677C591
Content-Type: text/plain; charset=UTF-8;
 name="Attached Message Part"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Attached Message Part"

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org


--------------BEBA731C18CB3547B677C591--

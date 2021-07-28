Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49593D89CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhG1Icp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:32:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:64992 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234311AbhG1Ico (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:32:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="199834456"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="199834456"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 01:32:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="517333914"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.133]) ([10.255.30.133])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 01:32:40 -0700
Subject: Re: drivers/hv/channel_mgmt.c:785:22: warning: Assigned value is
 garbage or undefined [clang-analyzer-core.uninitialized.Assign]
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
References: <202107251901.GJvlsBLV-lkp@intel.com>
 <39c4fa80-f65e-50c3-5706-809d4a2a2c9b@intel.com>
 <MN2PR21MB12955120969469392059D597CAE89@MN2PR21MB1295.namprd21.prod.outlook.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <073e1edc-4f41-f272-83e9-0927c27b3e61@intel.com>
Date:   Wed, 28 Jul 2021 16:32:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <MN2PR21MB12955120969469392059D597CAE89@MN2PR21MB1295.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2021 12:02 AM, Haiyang Zhang wrote:
> 
> 
>> -----Original Message-----
>> From: kernel test robot <rong.a.chen@intel.com>
>> Sent: Sunday, July 25, 2021 11:43 PM
>> To: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: kbuild-all@lists.01.org; LKML <linux-kernel@vger.kernel.org>; Wei
>> Liu <wei.liu@kernel.org>; Michael Kelley <mikelley@microsoft.com>
>> Subject: drivers/hv/channel_mgmt.c:785:22: warning: Assigned value is
>> garbage or undefined [clang-analyzer-core.uninitialized.Assign]
>>
>>
>> Hi Haiyang,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ke
>> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;d
>> ata=04%7C01%7Chaiyangz%40microsoft.com%7Cb1a7f087851b48a29bf308d94fe7849
>> 0%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637628680585035821%7CUnkn
>> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
>> JXVCI6Mn0%3D%7C1000&amp;sdata=6LkKnX%2BXhjmhh4m%2BzJ7y0JeQcwvwHw8NZP%2Bv
>> aXSdZV0%3D&amp;reserved=0 master
>> head:   d8079fac168168b25677dc16c00ffaf9fb7df723
>> commit: 7c9ff3deeee61b253715dcf968a6307af148c9b2 Drivers: hv: vmbus: Fix
>> duplicate CPU assignments within a device
>> date:   6 days ago
>> :::::: branch date: 11 hours ago
>> :::::: commit date: 6 days ago
>> config: x86_64-randconfig-c001-20210725 (attached as .config)
>> compiler: clang version 13.0.0
>> (https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithu
>> b.com%2Fllvm%2Fllvm-
>> project&amp;data=04%7C01%7Chaiyangz%40microsoft.com%7Cb1a7f087851b48a29b
>> f308d94fe78490%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637628680585
>> 035821%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
>> iI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=MKdTDUGKunqVOWEwafejDKuW0mpeN
>> aP1ssqiv4SBvzQ%3D&amp;reserved=0
>> 3f2c1e99e44d028d5e9dd685f3c568f2661f2f68)
>> reproduce (this is a W=1 build):
>>           wget
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fraw.gi
>> thubusercontent.com%2Fintel%2Flkp-
>> tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=04%7C01%7Chaiyangz%40microso
>> ft.com%7Cb1a7f087851b48a29bf308d94fe78490%7C72f988bf86f141af91ab2d7cd011
>> db47%7C1%7C0%7C637628680585035821%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
>> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=gu
>> Hq8MagK88xMw%2F6ZxmhQExnmLoIlYLma4QR1gmUYdM%3D&amp;reserved=0
>> -O ~/bin/make.cross
>>           chmod +x ~/bin/make.cross
>>           # install x86_64 cross compiling tool for clang build
>>           # apt-get install binutils-x86-64-linux-gnu
>>           #
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ke
>> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcom
>> mit%2F%3Fid%3D7c9ff3deeee61b253715dcf968a6307af148c9b2&amp;data=04%7C01%
>> 7Chaiyangz%40microsoft.com%7Cb1a7f087851b48a29bf308d94fe78490%7C72f988bf
>> 86f141af91ab2d7cd011db47%7C1%7C0%7C637628680585035821%7CUnknown%7CTWFpbG
>> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
>> %7C1000&amp;sdata=N24YX%2FPLzONY5gKOu1U93%2B7uK4jm%2BIQYZzfA6z8FPHo%3D&a
>> mp;reserved=0
>>           git remote add linus
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ke
>> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;d
>> ata=04%7C01%7Chaiyangz%40microsoft.com%7Cb1a7f087851b48a29bf308d94fe7849
>> 0%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637628680585035821%7CUnkn
>> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
>> JXVCI6Mn0%3D%7C1000&amp;sdata=6LkKnX%2BXhjmhh4m%2BzJ7y0JeQcwvwHw8NZP%2Bv
>> aXSdZV0%3D&amp;reserved=0
>>           git fetch --no-tags linus master
>>           git checkout 7c9ff3deeee61b253715dcf968a6307af148c9b2
>>           # save the attached .config to linux build tree
>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
>> clang-analyzer ARCH=x86_64 If you fix the issue, kindly add following
>> tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> clang-analyzer warnings: (new ones prefixed by >>)
>>                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>      drivers/hid/hid-core.c:1601:3: note: Taking false branch
>>                      if (field->logical_minimum < 0) /* signed values */
>>                      ^
>>      drivers/hid/hid-core.c:1605:44: note: Passing value via 4th
>> parameter 'n'
>>                              implement(hid, data, offset + n * size, size,
>>                                                                      ^~~~
>>      drivers/hid/hid-core.c:1605:4: note: Calling 'implement'
>>                              implement(hid, data, offset + n * size, size,
>>
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>      drivers/hid/hid-core.c:1421:15: note: Assuming 'n' is <= 32
>>              if (unlikely(n > 32)) {
>>                           ^
>>      include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
>>      # define unlikely(x)    __builtin_expect(!!(x), 0)
>>                                                  ^
>>      drivers/hid/hid-core.c:1421:2: note: Taking false branch
>>              if (unlikely(n > 32)) {
>>              ^
>>      drivers/hid/hid-core.c:1425:13: note: Assuming 'n' is >= 32
>>              } else if (n < 32) {
>>                         ^~~~~~
>>      drivers/hid/hid-core.c:1425:9: note: Taking false branch
>>              } else if (n < 32) {
>>                     ^
>>      drivers/hid/hid-core.c:1437:30: note: Passing the value 32 via 3rd
>> parameter 'n'
>>              __implement(report, offset, n, value);
>>                                          ^
>>      drivers/hid/hid-core.c:1437:2: note: Calling '__implement'
>>              __implement(report, offset, n, value);
>>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>      drivers/hid/hid-core.c:1400:9: note: Assuming the condition is false
>>              while (n - bits_to_set >= 0) {
>>                     ^~~~~~~~~~~~~~~~~~~~
>>      drivers/hid/hid-core.c:1400:2: note: Loop condition is false.
>> Execution continues on line 1411
>>              while (n - bits_to_set >= 0) {
>>              ^
>>      drivers/hid/hid-core.c:1411:6: note: 'n' is 32
>>              if (n) {
>>                  ^
>>      drivers/hid/hid-core.c:1411:2: note: Taking true branch
>>              if (n) {
>>              ^
>>      drivers/hid/hid-core.c:1412:22: note: The result of the left shift
>> is undefined due to shifting by '32', which is greater or equal to the
>> width of type 'unsigned int'
>>                      u8 bit_mask = ((1U << n) - 1);
>>                                         ^  ~
>>      drivers/hid/hid-core.c:1984:3: warning: Value stored to 'len' is
>> never read [clang-analyzer-deadcode.DeadStores]
>>                      len += sprintf(buf + len, "%shidraw%d", len ? "," :
>> "",
>>                      ^
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>      drivers/hid/hid-core.c:1984:3: note: Value stored to 'len' is never
>> read
>>                      len += sprintf(buf + len, "%shidraw%d", len ? "," :
>> "",
>>                      ^
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>      Suppressed 5 warnings (5 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      6 warnings generated.
>>      Suppressed 6 warnings (6 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      6 warnings generated.
>>      Suppressed 6 warnings (6 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      7 warnings generated.
>>      Suppressed 7 warnings (7 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      4 warnings generated.
>>      Suppressed 4 warnings (4 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      4 warnings generated.
>>      Suppressed 4 warnings (4 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      4 warnings generated.
>>      Suppressed 4 warnings (4 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      4 warnings generated.
>>      Suppressed 4 warnings (4 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      4 warnings generated.
>>      Suppressed 4 warnings (4 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      4 warnings generated.
>>      Suppressed 4 warnings (4 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      4 warnings generated.
>>      Suppressed 4 warnings (4 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      5 warnings generated.
>>      Suppressed 5 warnings (5 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      4 warnings generated.
>>      Suppressed 4 warnings (4 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      3 warnings generated.
>>      Suppressed 3 warnings (3 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      9 warnings generated.
>>      Suppressed 9 warnings (8 in non-user code, 1 with check filters).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      5 warnings generated.
>>      Suppressed 5 warnings (5 in non-user code).
>>      Use -header-filter=.* to display errors from all non-system headers.
>> Use -system-headers to display errors from system headers as well.
>>      6 warnings generated.
>>>> drivers/hv/channel_mgmt.c:785:22: warning: Assigned value is garbage
>>>> or undefined [clang-analyzer-core.uninitialized.Assign]
>>              channel->target_cpu = target_cpu;
>>                                  ^
> 
> The for-loop before the assignment is always executed,
> because ncpu = num_online_cpus() > 0:
> 	for (i = 1; i <= ncpu + 1; i++) {
> 
> So the variable is assigned before Line 785:
> 		target_cpu = cpumask_first(available_mask);
> 
> And, the following code ensures the available_mask is not empty:
> 		if (cpumask_weight(alloced_mask) ==
> 		    cpumask_weight(cpumask_of_node(numa_node))) {
> 			/*
> 			 * We have cycled through all the CPUs in the node;
> 			 * reset the alloced map.
> 			 */
> 			cpumask_clear(alloced_mask);
> 		}
> 
> So the robot warning above can be ignored.

Thanks for the detailed explanation, please just ignore it.

Best Regards,
Rong Chen

> 
> Thanks,
> - Haiyang
> 

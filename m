Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A800305538
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhA0IFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:05:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:6127 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233251AbhA0ICN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:02:13 -0500
IronPort-SDR: SYjuaK1J+oGm4xnngNo+LMaojlPGCOHrWCdsmL5ti5qew5PCoJxdcWaY+nquCC+UrDqfwbXAxS
 rz+GaBOVxZGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="176522363"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="176522363"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 23:50:18 -0800
IronPort-SDR: eD2oDV6h3qL71zCkSo2+mFfu9YEIV5Ss8ka2ITgXic1M5rPT43UvxaldKt1AmAtd+yTsbaAVz4
 9koE5GpPY6iA==
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="362322980"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.6.97]) ([10.238.6.97])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 23:50:15 -0800
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: Test report for kernel direct mapping performance
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony <tony.luck@intel.com>, Tim C Chen <tim.c.chen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Du, Julie" <julie.du@intel.com>
References: <213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com>
 <20210126150016.GT827@dhcp22.suse.cz>
Message-ID: <8e844e46-3ee0-9898-0d39-1571302dbc9f@linux.intel.com>
Date:   Wed, 27 Jan 2021 15:50:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126150016.GT827@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2021 11:00 PM, Michal Hocko wrote:
> On Fri 15-01-21 15:23:07, Xing Zhengjun wrote:
>> Hi,
>>
>> There is currently a bit of a debate about the kernel direct map. Does using
>> 2M/1G pages aggressively for the kernel direct map help performance? Or, is
>> it an old optimization which is not as helpful on modern CPUs as it was in
>> the old days? What is the penalty of a kernel feature that heavily demotes
>> this mapping from larger to smaller pages? We did a set of runs with 1G and
>> 2M pages enabled /disabled and saw the changes.
>>
>> [Conclusions]
>>
>> Assuming that this was a good representative set of workloads and that the
>> data are good, for server usage, we conclude that the existing aggressive
>> use of 1G mappings is a good choice since it represents the best in a
>> plurality of the workloads. However, in a *majority* of cases, another
>> mapping size (2M or 4k) potentially offers a performance improvement. This
>> leads us to conclude that although 1G mappings are a good default choice,
>> there is no compelling evidence that it must be the only choice, or that
>> folks deriving benefits (like hardening) from smaller mapping sizes should
>> avoid the smaller mapping sizes.
> 
> Thanks for conducting these tests! This is definitely useful and quite
> honestly I would have expected a much more noticeable differences.
> Please note that I am not really deep into benchmarking but one thing
> that popped in my mind was whethere these (micro)benchmarks are really
> representative workloads. Some of them tend to be rather narrow in
> executed code paths or data structures used AFAIU. Is it possible they
> simply didn't generate sufficient TLB pressure?
> 

The test was done on 4 server platforms with 11 benchmarks which 0day 
run daily. For the 11 different benchmarks that were used, echo 
benchmarks have a lot of subcases, so there was a total of 259 test 
cases. The test memory size for the 4 server platform ranges from 128GB 
to 512GB. Yes, some of the benchmarks tend to be narrow in executed code 
paths or data structures. So we run a total of 259 cases which include 
test cases in memory, CPU scheduling, network, io, and database, try to 
cover most of the code path. For the 11 benchmarks, some of them may not 
generate sufficient TLB pressure, but I think cases in vm-scalability 
and will-it-scale may generate sufficient TLB pressure. I have provided 
the test results for different benchmarks, if you are interested, you 
can see in the details of the test report: 
https://01.org/sites/default/files/documentation/test_report_for_kernel_direct_mapping_performance_0.pdf


> Have you tried to look closer on profiles of respective configurations
> where the overhead comes from?
>

The test cases selected from the 0day daily run cases, just use the 
different kernel settings;
Enable both 2M and 1G huge pages (up to 1G, so named to "1G" in the test 
report):
            no extra kernel command line need
Disable 1G pages (up to 2M, so named to 2M in the test report):
           add kernel command line "nogbpages"
Disable both 2M and 1G huge pages (up to 4k, so named to 4K in the test 
report):
           add kernel command line "nohugepages_mapping" (by debug patch)

User spaces add THP enabled setting for all the three kernels (1G/2M/4K)
           transparent_hugepage:
               thp_enabled: always
               thp_defrag: always

During the test, we enabled some monitors, but the overhead should be 
not too big, most of the overhead should be the test cases themselves.
I will study some test cases to find the hotspot from which overhead 
comes from and provide it later if someone is interested in it.


-- 
Zhengjun Xing

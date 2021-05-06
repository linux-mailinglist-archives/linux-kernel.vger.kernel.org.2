Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D91374EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 06:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhEFFAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 01:00:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:60748 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233007AbhEFFAn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 01:00:43 -0400
IronPort-SDR: 7FhMJVenzKpw8pb1bRjaFrbsBnpn4zpxz1UOLij/rjiJ6qQ0LMbSM+bOxBJD7OoV0BLp/Iruh4
 2s/2J7ZxO6YQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="195258082"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="195258082"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 21:59:14 -0700
IronPort-SDR: 87FNLb4TGmATRx26ipmTDl9KyMkhHNJcNIEC40LvWVDsBC+9BDbV8o7QxbNQe9K2Y19JrBfP5J
 bFGfUKT9fh2g==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="434161883"
Received: from unknown (HELO [10.238.4.82]) ([10.238.4.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 21:59:10 -0700
Subject: Re: [PATCH v1 2/2] perf header: Support hybrid CPU_PMU_CAPS
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
 <20210430074602.3028-2-yao.jin@linux.intel.com> <YJFjTCsk9dCd6QP7@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c0bd3baa-3209-23f3-7058-c6908434de2d@linux.intel.com>
Date:   Thu, 6 May 2021 12:59:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJFjTCsk9dCd6QP7@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/4/2021 11:07 PM, Jiri Olsa wrote:
> On Fri, Apr 30, 2021 at 03:46:02PM +0800, Jin Yao wrote:
>> On hybrid platform, it may have several cpu pmus, such as,
>> "cpu_core" and "cpu_atom". The CPU_PMU_CAPS feature in perf
>> header needs to be improved to support multiple cpu pmus.
>>
>> The new layout in header is defined as:
>>
>> <nr_caps>
>> <caps string>
>> <caps string>
>> <pmu name>
>> <nr of rest pmus>
> 
> not sure why is the 'nr of rest pmus' needed
> 

The 'nr of rest pmus' indicates the remaining pmus which are waiting for process.

For example,

<nr_caps>
<caps string>
"cpu_core"
1
<nr_caps>
<caps string>
"cpu_atom"
0

When we see '0' in data file processing, we know all the pmu have been processed yet.

> the current format is:
> 
>          u32 nr_cpu_pmu_caps;
>          {
>                  char    name[];
>                  char    value[];
>          } [nr_cpu_pmu_caps]
> 
> 
> I guess we could extend it to:
> 
>          u32 nr_cpu_pmu_caps;
>          {
>                  char    name[];
>                  char    value[];
>          } [nr_cpu_pmu_caps]
> 	char pmu_name[]
> 
>          u32 nr_cpu_pmu_caps;
>          {
>                  char    name[];
>                  char    value[];
>          } [nr_cpu_pmu_caps]
> 	char pmu_name[]
> 
> 	...
> 
> and we could detect the old format by checking that there's no
> pmu name.. but maybe I'm missing something, I did not check deeply,
> please let me know
>

Actually we do the same thing, but I just add an extra 'nr of rest pmus' after the pmu_name. The 
purpose of 'nr of rest pmus' is when we see '0' at 'nr of rest pmus', we know that all pmus have 
been processed.

Otherwise, we have to continue reading data file till we find something incorrect and then finally 
drop the last read data.

So is this solution acceptable?

> also would be great to move the format change and storing hybrid
> pmus in separate patches
> 

Maybe we have to put the storing and processing into one patch.

Say patch 1 contains the format change and storing hybrid pmus. And patch 2 contains the processing 
for the new format. If the repo only contains the patch 1, I'm afraid that may introduce the 
compatible issue.

Thanks
Jin Yao

> thanks,
> jirka
> 

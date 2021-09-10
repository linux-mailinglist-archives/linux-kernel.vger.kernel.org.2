Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890CA4064E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhIJBHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:07:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:33459 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240034AbhIJAlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 20:41:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="219093465"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="219093465"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 17:40:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="540053524"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.2.86]) ([10.238.2.86])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 17:40:10 -0700
Subject: Re: [PATCH v2] perf list: Display hybrid pmu events with cpu type
To:     Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210903025239.22754-1-yao.jin@linux.intel.com>
 <CAP-5=fVT6G6Ysdd39O3XROyKUxAs6uQVeO8mnbsy-Oy5VqujrA@mail.gmail.com>
 <0ccb62bf-34be-b986-4794-d8cc2a767a3e@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <59cf3fcb-e6cd-ddbe-84e5-6c3e85d575b4@linux.intel.com>
Date:   Fri, 10 Sep 2021 08:39:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0ccb62bf-34be-b986-4794-d8cc2a767a3e@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/2021 6:56 AM, Andi Kleen wrote:
> 
> On 9/9/2021 3:37 PM, Ian Rogers wrote:
>> On Thu, Sep 2, 2021 at 7:54 PM Jin Yao <yao.jin@linux.intel.com> wrote:
>>> Add a new option '--cputype' to perf-list to display core-only pmu events
>>> or atom-only pmu events.
>>>
>>> Each hybrid pmu event has been assigned with a pmu name, this patch
>>> compares the pmu name before listing the result.
>> Would this work more broadly for any PMU type? If so perhaps pmu
>> rather than cputype is a more appropriate option name?
> 
> It's not just the cpu pmu, because it still lists the uncore events, which makes sense.
> 
> If you want to match the pmu it probably would make sense to match it in the default matching for 
> non option arguments in perf list. But that would be a different patch.
> 
> -Andi
> 
> 

Yes, agree with Andi. Besides for cpu pmu events, it also lists the software events and uncore 
events. So probably cputype is an appropriate option name.

Thanks
Jin Yao


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92227386F74
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbhERBmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:42:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:21419 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238427AbhERBmE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:42:04 -0400
IronPort-SDR: NcMMjWyFBa3WGzXhLn4grdqtVJ8y/SBKqsZRfXUTd4kU9bA0JRDCGFnjCjb8uUFNByHr3ExTQ5
 N3rbpyw2rfDg==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200297754"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="200297754"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 18:40:46 -0700
IronPort-SDR: kjwZxmv0D1N0fy9kwt36P/CB7RZKzYFuBWM/a16aaZc/vkQ3CGOG1LoKM5gQZULMUH+27ki473
 ITz0ObCTJiyg==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="472693382"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.82]) ([10.238.4.82])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 18:40:43 -0700
Subject: Re: [PATCH v4 0/2] perf header: Support HYBRID_TOPOLOGY and
 HYBRID_CPU_PMU_CAPS
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210514122948.9472-1-yao.jin@linux.intel.com>
 <YKA6oqfP0niinZkD@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <228cc228-464d-c4dd-039c-535f050704d5@linux.intel.com>
Date:   Tue, 18 May 2021 09:40:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKA6oqfP0niinZkD@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/16/2021 5:18 AM, Jiri Olsa wrote:
> On Fri, May 14, 2021 at 08:29:46PM +0800, Jin Yao wrote:
>> AlderLake uses a hybrid architecture utilizing Golden Cove cores
>> (core cpu) and Gracemont cores (atom cpu). It would be useful to let user
>> know the hybrid topology, the HYBRID_TOPOLOGY feature in header indicates
>> which cpus are core cpus, and which cpus are atom cpus.
>>
>> On hybrid platform, it may have several cpu pmus, such as, "cpu_core" and
>> "cpu_atom". The HYBRID_CPU_PMU_CAPS feature in perf header is created to
>> support multiple cpu pmus.
>>
>> v4:
>> ---
>> - Only minor update in '[PATCH v4 2/2] perf header: Support HYBRID_CPU_PMU_CAPS feature'.
>>    1. Directly return process_per_cpu_pmu_caps() in process_cpu_pmu_caps.
>>       Remove the variable 'ret'.
>>    2. Set 'ret = -1' if (!n->pmu_name) in process_hybrid_cpu_pmu_caps().
> Acked-by: Jiri Olsa<jolsa@redhat.com>
> 
> thanks,
> jirka
> 

Thanks so much!

I have some followup patches which depend on this patchset. I will post them after this patchset is 
applied.

Thanks
Jin Yao

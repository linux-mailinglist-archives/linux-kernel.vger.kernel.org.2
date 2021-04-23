Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BFD368B54
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 04:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbhDWC6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 22:58:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:65015 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhDWC6m (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 22:58:42 -0400
IronPort-SDR: FchXFjnPG9un4o2j6OVwKwN+rLDeaggGfzzOlR05u0pT/aDGjVdxkKcmlgW+MmED2gJhdh5KPf
 ho2Cb/f8be0w==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="216689937"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="216689937"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 19:58:06 -0700
IronPort-SDR: eyIglBZi6UrJuHyhRPjUggCWVVKw/2VYUgEncaDDfAbphVXbXu7S9JBmWaW/Z1mZ/7a6SvUhGA
 td2c8L8h8zog==
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="428215227"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 19:58:04 -0700
Subject: Re: [PATCH] perf vendor events: Add missing model numbers
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210329070903.8894-1-yao.jin@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <67f05194-0eb4-becd-c8bb-7dc944ac6ca8@linux.intel.com>
Date:   Fri, 23 Apr 2021 10:58:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210329070903.8894-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi, Arnaldo, Jiri,

Can this patch be accepted?

Thanks
Jin Yao

On 3/29/2021 3:09 PM, Jin Yao wrote:
> Kernel has supported COMETLAKE/COMETLAKE_L to use the SKYLAKE
> events and supported TIGERLAKE_L/TIGERLAKE/ROCKETLAKE to use
> the ICELAKE events. But pmu-events mapfile.csv is missing
> these model numbers.
> 
> Now add the missing model numbers to mapfile.csv.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>   tools/perf/pmu-events/arch/x86/mapfile.csv | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index 2f2a209e87e1..6455f06f35d3 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -24,6 +24,7 @@ GenuineIntel-6-1F,v2,nehalemep,core
>   GenuineIntel-6-1A,v2,nehalemep,core
>   GenuineIntel-6-2E,v2,nehalemex,core
>   GenuineIntel-6-[4589]E,v24,skylake,core
> +GenuineIntel-6-A[56],v24,skylake,core
>   GenuineIntel-6-37,v13,silvermont,core
>   GenuineIntel-6-4D,v13,silvermont,core
>   GenuineIntel-6-4C,v13,silvermont,core
> @@ -35,6 +36,8 @@ GenuineIntel-6-55-[01234],v1,skylakex,core
>   GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
>   GenuineIntel-6-7D,v1,icelake,core
>   GenuineIntel-6-7E,v1,icelake,core
> +GenuineIntel-6-8[CD],v1,icelake,core
> +GenuineIntel-6-A7,v1,icelake,core
>   GenuineIntel-6-86,v1,tremontx,core
>   AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
>   AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
> 

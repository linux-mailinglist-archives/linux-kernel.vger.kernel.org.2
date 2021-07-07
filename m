Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079153BE381
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhGGH1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:27:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:59577 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230327AbhGGH1K (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:27:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="294895837"
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="294895837"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 00:24:27 -0700
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="497650274"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 00:24:25 -0700
Subject: Re: [PATCH] perf list: Skip the invalid hybrid pmu
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210610051646.4003-1-yao.jin@linux.intel.com>
 <YOS1119y56eH0Uyv@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ff0c48bb-2cbf-766a-f726-bb7a287375b4@linux.intel.com>
Date:   Wed, 7 Jul 2021 15:24:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOS1119y56eH0Uyv@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 7/7/2021 3:58 AM, Jiri Olsa wrote:
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 88c8ecdc60b0..281670e9c4bd 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1604,6 +1604,9 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>>   	pmu = NULL;
>>   	j = 0;
>>   	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>> +		if (perf_pmu__is_invalid_hybrid(pmu->name))
>> +			continue;
> hum why not detect it in pmu_lookup early on
> and not add that pmu at all?
> 
> thanks,
> jirka
> 

Yes, it's a good idea that detects it in pmu_lookup, thanks!

Thanks
Jin Yao

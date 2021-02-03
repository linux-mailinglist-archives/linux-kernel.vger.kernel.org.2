Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD5830E4DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhBCVW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:22:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:28910 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhBCVW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:22:28 -0500
IronPort-SDR: e1L+8ZNyrn/3X4JXJObti2LP/mSVw2zTWEVqs01eUZEnP8vGvz6ts0gZAlmsIAhDqgRI18ozXX
 ukaVKrWj1vvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160285179"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="160285179"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 13:20:41 -0800
IronPort-SDR: Es4TYvvestyRoRZ2DFsOFaQaIJ7Vykvy1YgTMIINxFAaqDwKUzr29oyWA7rNMNTb6qEFgztag2
 nox2HcofWESg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="480492933"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2021 13:20:40 -0800
Received: from [10.251.9.135] (kliang2-MOBL.ccr.corp.intel.com [10.251.9.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BE0445802A4;
        Wed,  3 Feb 2021 13:20:39 -0800 (PST)
Subject: Re: [PATCH 2/9] perf tools: Support the auxiliary event
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-3-git-send-email-kan.liang@linux.intel.com>
 <20210203200256.GH854763@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b56933e7-0454-c2ac-9bac-c9890dcc60d4@linux.intel.com>
Date:   Wed, 3 Feb 2021 16:20:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203200256.GH854763@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2021 3:02 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Feb 02, 2021 at 12:09:06PM -0800,kan.liang@linux.intel.com  escreveu:
>> From: Kan Liang<kan.liang@linux.intel.com>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index c26ea822..c48f6de 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -2689,6 +2689,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>>   		if (perf_missing_features.aux_output)
>>   			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
>>   		break;
>> +	case ENODATA:
>> +		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
>> +				 "Please add an auxiliary event in front of the load latency event.");
> Are you sure this is the only case where ENODATA comes out from
> perf_event_open()? Well, according to your comment in:
> 
>    61b985e3e775a3a7 ("perf/x86/intel: Add perf core PMU support for Sapphire Rapids")
> 
> It should be at that point in time, so its safe to merge as-is, but then
> I think this is fragile, what if someone else, in the future, not
> knowing that ENODATA is supposed to be used only with that ancient CPU,
> Sapphire Rapids, uses it?:-)
> 
> Please consider adding a check before assuming ENODATA is for this
> specific case.

Sure, I will add a check in V2.

Thanks,
Kan

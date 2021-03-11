Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F534336E37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhCKIuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:50:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2685 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhCKIty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:49:54 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dx2Vf2mzKz67xCl;
        Thu, 11 Mar 2021 16:41:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Mar 2021 09:49:52 +0100
Received: from [10.47.4.196] (10.47.4.196) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 11 Mar
 2021 08:49:50 +0000
Subject: Re: [PATCH 1/5] perf metricgroup: Support printing metrics for arm64
To:     Jiri Olsa <jolsa@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "qiangqing.zhang@nxp.com" <qiangqing.zhang@nxp.com>
References: <1614784938-27080-1-git-send-email-john.garry@huawei.com>
 <1614784938-27080-2-git-send-email-john.garry@huawei.com>
 <YEE9oInI38txHWmo@krava> <95205463-4c80-4e8a-a7c0-c2a4e4553838@huawei.com>
 <YEPZNssS200w3Axy@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9db4f883-378e-303a-4580-044c579c96e0@huawei.com>
Date:   Thu, 11 Mar 2021 08:47:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YEPZNssS200w3Axy@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.4.196]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2021 19:34, Jiri Olsa wrote:
> On Fri, Mar 05, 2021 at 11:06:58AM +0000, John Garry wrote:
>> Hi Jirka,
>>
>>>> -	struct pmu_events_map *map = perf_pmu__find_map(NULL);
>>>> +	struct pmu_events_map *map = find_cpumap();
>>> so this is just for arm at the moment right?
>>>
>> Yes - but to be more accurate, arm64.
>>
>> At the moment, from the archs which use pmu-events, only arm64 and nds32
>> have versions of get_cpuid_str() which require a non-NULL pmu argument.
>>
>> But then apparently nds32 only supports a single CPU, so this issue of
>> heterogeneous CPUs should not be a concern there:)
>>
>>> could we rather make this arch specific code, so we don't need
>>> to do the scanning on archs where this is not needed?
>>>
>>> like marking perf_pmu__find_map as __weak and add arm specific
>>> version?
>> Well I was thinking that this code should not be in metricgroup.c anyway.
>>
>> So there is code which is common in current perf_pmu__find_map() for all
>> archs.
>>
>> I could factor that out into a common function, below. Just a bit worried
>> about perf_pmu__find_map() and perf_pmu__find_pmu_map() being confused.
> right, so perf_pmu__find_map does not take perf_pmu as argument
> anymore, so the prefix does not fit, how about pmu_events_map__find ?

I just noticed this series:
https://lore.kernel.org/lkml/1612797946-18784-1-git-send-email-kan.liang@linux.intel.com/

Seems that this has metricgroup support for heterogeneous system config, 
while this series is metricgroup support for homogeneous system config 
for arch which supports heterogeneous system config. I need to check 
further for any conflicts.

@Kan Liang, it would be great if you could cc me on that series. I don't 
subscribe to the general list.

Thanks,
John

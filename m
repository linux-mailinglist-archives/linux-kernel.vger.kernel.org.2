Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0530355426
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbhDFMp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:45:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2767 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbhDFMps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:45:48 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FF6X04Jycz681X8;
        Tue,  6 Apr 2021 20:38:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 14:45:38 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 13:45:36 +0100
Subject: Re: [PATCH v2 2/6] perf test: Handle metric reuse in pmu-events
 parsing test
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <irogers@google.com>, <linuxarm@huawei.com>, <kjain@linux.ibm.com>,
        <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <pc@us.ibm.com>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <1616668398-144648-3-git-send-email-john.garry@huawei.com>
 <YGXPdEAecos4iPVc@krava> <edfabc52-4b09-be92-7c40-fb2ddfe80596@huawei.com>
 <YGxRbH0XWaj6AWfa@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f5b209b2-1e9e-ebad-b2ed-eda9fe858ec8@huawei.com>
Date:   Tue, 6 Apr 2021 13:43:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YGxRbH0XWaj6AWfa@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.166.136]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2021 13:17, Jiri Olsa wrote:
>>>> +			ref = &metric->metric_ref;
>>>> +			ref->metric_name = pe->metric_name;
>>>> +			ref->metric_expr = pe->metric_expr;
>>>> +			list_add_tail(&metric->list, compound_list);
>>>> +
>>>> +			rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
>> Hi Jirka,
>>
>>> so this might add new items to pctx->ids, I think you need
>>> to restart the iteration as we do it in __resolve_metric
>>> otherwise you could miss some new keys
>> I thought that I was doing this. Indeed, this code is very much like
>> __resolve_metric();)
>>
>> So expr__find_other() may add a new item to pctx->ids, and we always iterate
>> again, and try to lookup any pmu_events, *, above. If none exist, then we
> hm, I don't see that.. so, what you do is:
> 
> 	hashmap__for_each_entry_safe((&pctx->ids) ....) {
> 
> 		rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
> 	}
> 
> and what I think we need to do is:
> 
> 	hashmap__for_each_entry_safe((&pctx->ids) ....) {
> 
> 		rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
> 
> 		break;	
> 	}
> 
> each time you resolve another metric, you need to restart
> the pctx->ids iteration, because there will be new items,
> and we are in the middle of it

Sure, but we will restart anyway.

Regardless of this, I don't think what I am doing is safe, i.e. adding 
new items in the middle of the iter, so I will change in the way you 
suggest.

Thanks,
John

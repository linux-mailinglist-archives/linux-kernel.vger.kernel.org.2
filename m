Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DBC3554F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243741AbhDFNXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:23:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2768 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhDFNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:23:50 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FF7K15VZLz686x7;
        Tue,  6 Apr 2021 21:14:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 15:23:40 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 14:23:39 +0100
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
 <YGxRbH0XWaj6AWfa@krava> <f5b209b2-1e9e-ebad-b2ed-eda9fe858ec8@huawei.com>
 <YGxaOnUZnNmDg/2P@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <49025439-f9e3-0d32-b0a3-ff9f9ff71835@huawei.com>
Date:   Tue, 6 Apr 2021 14:21:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YGxaOnUZnNmDg/2P@krava>
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

On 06/04/2021 13:55, Jiri Olsa wrote:
>>>> So expr__find_other() may add a new item to pctx->ids, and we always iterate
>>>> again, and try to lookup any pmu_events, *, above. If none exist, then we
>>> hm, I don't see that.. so, what you do is:
>>>
>>> 	hashmap__for_each_entry_safe((&pctx->ids) ....) {
>>>
>>> 		rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
>>> 	}
>>>
>>> and what I think we need to do is:
>>>
>>> 	hashmap__for_each_entry_safe((&pctx->ids) ....) {
>>>
>>> 		rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
>>>
>>> 		break;	
>>> 	}
>>>
>>> each time you resolve another metric, you need to restart
>>> the pctx->ids iteration, because there will be new items,
>>> and we are in the middle of it
>> Sure, but we will restart anyway.
> hum, where? you call expr__find_other and continue to next
> pctx->ids item

We have:

resolve_metric_simple()
{
	bool all;

	do {
		all = true;

		hashmap__for_each_entry_safe(&pctx->ids, ...) {

			pe = metricgroup_find_metric(cur->key, map);
			if (!pe)
				continue;

			...
			all = false;

			expr_del_id(pctx, cur->key);

			...
			rc = expr__find_other(pe->metric_expr, pctx);
			if (rc)
				goto out_err;
		}

	} while (!all);

}

So once we evaluate a pmu_event in pctx->ids in @pe, @all is set false, 
and we would loop again in the do-while loop, regardless of what 
expr__find_other() does (apart from erroring), and so call 
hashmap__for_each_entry_safe(&pctx->ids, ) again.

This is really what is done in __resolve_metric() - indeed, I would use 
that function directly, but it looks hard to extract that from 
metricgroup.c .

Thanks,
John

> 
>> Regardless of this, I don't think what I am doing is safe, i.e. adding new
>> items in the middle of the iter, so I will change in the way you suggest.
> it'll always add items in the middle of the iteration


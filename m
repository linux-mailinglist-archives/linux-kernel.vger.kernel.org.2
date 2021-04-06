Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29CC355179
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245321AbhDFLDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:03:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2765 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhDFLDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:03:06 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FF4FW0Dffz686J2;
        Tue,  6 Apr 2021 18:55:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 13:02:56 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 12:02:55 +0100
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
 <YGXPdEAecos4iPVc@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <edfabc52-4b09-be92-7c40-fb2ddfe80596@huawei.com>
Date:   Tue, 6 Apr 2021 12:00:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YGXPdEAecos4iPVc@krava>
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

On 01/04/2021 14:49, Jiri Olsa wrote:
> On Thu, Mar 25, 2021 at 06:33:14PM +0800, John Garry wrote:
> 
> SNIP
> 
>> +struct metric {
>> +	struct list_head list;
>> +	struct metric_ref metric_ref;
>> +};
>> +
>> +static int resolve_metric_simple(struct expr_parse_ctx *pctx,
>> +				 struct list_head *compound_list,
>> +				 struct pmu_events_map *map,
>> +				 const char *metric_name)
>> +{
>> +	struct hashmap_entry *cur, *cur_tmp;
>> +	struct metric *metric, *tmp;
>> +	size_t bkt;
>> +	bool all;
>> +	int rc;
>> +
>> +	do {
>> +		all = true;
>> +		hashmap__for_each_entry_safe((&pctx->ids), cur, cur_tmp, bkt) {
>> +			struct metric_ref *ref;
>> +			struct pmu_event *pe;
>> +
>> +			pe = metrcgroup_find_metric(cur->key, map);

*

>> +			if (!pe)
>> +				continue;
>> +
>> +			if (!strcmp(metric_name, (char *)cur->key)) {
>> +				pr_warning("Recursion detected for metric %s\n", metric_name);
>> +				rc = -1;
>> +				goto out_err;
>> +			}
>> +
>> +			all = false;
>> +
>> +			/* The metric key itself needs to go out.. */
>> +			expr__del_id(pctx, cur->key);
>> +
>> +			metric = malloc(sizeof(*metric));
>> +			if (!metric) {
>> +				rc = -ENOMEM;
>> +				goto out_err;
>> +			}
>> +
>> +			ref = &metric->metric_ref;
>> +			ref->metric_name = pe->metric_name;
>> +			ref->metric_expr = pe->metric_expr;
>> +			list_add_tail(&metric->list, compound_list);
>> +
>> +			rc = expr__find_other(pe->metric_expr, NULL, pctx, 0);
> 

Hi Jirka,

> so this might add new items to pctx->ids, I think you need
> to restart the iteration as we do it in __resolve_metric
> otherwise you could miss some new keys

I thought that I was doing this. Indeed, this code is very much like 
__resolve_metric() ;)

So expr__find_other() may add a new item to pctx->ids, and we always 
iterate again, and try to lookup any pmu_events, *, above. If none 
exist, then we have broken down pctx into primitive events aliases and 
unresolvable metrics, and stop iterating. And then unresolvable metrics 
would be found in check_parse_cpu().

As an example, we can deal with metric test1, below, which references 2x 
other metrics:

     {
         "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( 
CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE 
/ CPU_CLK_UNHALTED.REF_XCLK ) )))",
       "MetricName": "Frontend_Bound",
     },
     {
         "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 
4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricName": "Bad_Speculation",
     },
     {
         "MetricExpr": "Bad_Speculation + Frontend_Bound",
         "MetricName": "test1",
     },

Does that satisfy your concern, or have I missed something?

Thanks,
John

> 
> jirka
> 
>> +			if (rc)
>> +				goto out_err;
>> +		}
>> +	} while (!all);
>> +
>> +	return 0;
>> +
>> +out_err:
>> +	list_for_each_entry_safe(metric, tmp, compound_list, list)
>> +		free(metric);
>> +
>> +	return rc;
>> +
>> +}
> 
> SNIP
> 
> .
> 


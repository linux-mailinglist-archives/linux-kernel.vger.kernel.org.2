Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C14355064
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhDFJ51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:57:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2764 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhDFJ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:57:25 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FF2nk2nrMz686nr;
        Tue,  6 Apr 2021 17:50:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 11:57:15 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:57:14 +0100
Subject: Re: [PATCH v2 1/6] perf metricgroup: Make find_metric() public with
 name change
To:     Ian Rogers <irogers@google.com>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, <linuxarm@huawei.com>,
        kajoljain <kjain@linux.ibm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, "Paul Clarke" <pc@us.ibm.com>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <1616668398-144648-2-git-send-email-john.garry@huawei.com>
 <CAP-5=fVMfK5-rGtx1QjTLz6AQeGr0ruyxuwC3ADt4kriU9wz0A@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4b406e70-9ff6-dd26-d9b7-78b094041651@huawei.com>
Date:   Tue, 6 Apr 2021 10:54:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVMfK5-rGtx1QjTLz6AQeGr0ruyxuwC3ADt4kriU9wz0A@mail.gmail.com>
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

On 02/04/2021 00:16, Ian Rogers wrote:
> On Thu, Mar 25, 2021 at 3:38 AM John Garry <john.garry@huawei.com> wrote:
>>
>> Function find_metric() is required for the metric processing in the
>> pmu-events testcase, so make it public. Also change the name to include
>> "metricgroup".
> 
> Would it make more sense as "pmu_events_map__find_metric" ?
> 

So all functions apart from one in metricgroup.h are named 
metricgroup__XXX, so I was trying to keep this style - apart from the 
double-underscore (which can be remedied).

Personally I don't think pmu_events_map__find_metric name fits with that 
convention.

Thanks,
John

> Thanks,
> Ian
> 
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   tools/perf/util/metricgroup.c | 5 +++--
>>   tools/perf/util/metricgroup.h | 3 ++-
>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 6acb44ad439b..71a13406e0bd 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -900,7 +900,8 @@ static int __add_metric(struct list_head *metric_list,
>>                      (match_metric(__pe->metric_group, __metric) ||      \
>>                       match_metric(__pe->metric_name, __metric)))
>>
>> -static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
>> +struct pmu_event *metrcgroup_find_metric(const char *metric,
>> +                                        struct pmu_events_map *map)
>>   {
>>          struct pmu_event *pe;
>>          int i;
>> @@ -985,7 +986,7 @@ static int __resolve_metric(struct metric *m,
>>                          struct expr_id *parent;
>>                          struct pmu_event *pe;
>>
>> -                       pe = find_metric(cur->key, map);
>> +                       pe = metrcgroup_find_metric(cur->key, map);
>>                          if (!pe)
>>                                  continue;
>>
>> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
>> index ed1b9392e624..1674c6a36d74 100644
>> --- a/tools/perf/util/metricgroup.h
>> +++ b/tools/perf/util/metricgroup.h
>> @@ -44,7 +44,8 @@ int metricgroup__parse_groups(const struct option *opt,
>>                                bool metric_no_group,
>>                                bool metric_no_merge,
>>                                struct rblist *metric_events);
>> -
>> +struct pmu_event *metrcgroup_find_metric(const char *metric,
>> +                                        struct pmu_events_map *map);
>>   int metricgroup__parse_groups_test(struct evlist *evlist,
>>                                     struct pmu_events_map *map,
>>                                     const char *str,
>> --
>> 2.26.2
>>
> .
> 


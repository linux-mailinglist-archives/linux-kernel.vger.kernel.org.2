Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F234356361
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 07:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhDGFjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 01:39:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229558AbhDGFjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 01:39:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1375Zqod041771;
        Wed, 7 Apr 2021 01:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9MuFwDtOXgmfBE/pEmyNTjZ+cQxOsO+/L7Sy9Q2oppE=;
 b=gtFt8E0DKQEUOwdBg6WRCbuVakV4dRQdJXRZbUmWk/puPVdvyxVwWz3gjp6oqciUGIBo
 KUg+wQAHIkF8xMvoSep0NyHp+jDjCv7WbZky0DTFvwInjgXes/YjvV7YThX8rwgCMsxH
 J55FRk3lzuzVNdPW7PGtObPBf2832gtQc6idY485ZHmJ+aBXEJiTe+w52sB3zaSI526/
 j+rSZGbw+4IWz4AS/ftQSCB8bdWpV4UR8T/iXT76CiBr6GDB1UsBnjnEOX2WbsEUEsV8
 CL00sWC2Wc/u7v1vi4f6a+cjimpXGmUgrZ64WM6y+g7twH0k4pqhRqTIhPzTGF/OQQDY 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvumcujf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 01:39:14 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1375a8dq043073;
        Wed, 7 Apr 2021 01:39:14 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvumcuj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 01:39:14 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1375bjmd022078;
        Wed, 7 Apr 2021 05:39:13 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 37rw2p3ura-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 05:39:13 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1375dBvK12059308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 05:39:12 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1FD6136053;
        Wed,  7 Apr 2021 05:39:11 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE4B4136055;
        Wed,  7 Apr 2021 05:39:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.220])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  7 Apr 2021 05:39:05 +0000 (GMT)
Subject: Re: [PATCH v2 1/6] perf metricgroup: Make find_metric() public with
 name change
To:     John Garry <john.garry@huawei.com>, Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, linuxarm@huawei.com,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        zhangshaokun@hisilicon.com, Paul Clarke <pc@us.ibm.com>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <1616668398-144648-2-git-send-email-john.garry@huawei.com>
 <CAP-5=fVMfK5-rGtx1QjTLz6AQeGr0ruyxuwC3ADt4kriU9wz0A@mail.gmail.com>
 <4b406e70-9ff6-dd26-d9b7-78b094041651@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <e5fc65ef-b146-e677-43de-42482c755441@linux.ibm.com>
Date:   Wed, 7 Apr 2021 11:09:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4b406e70-9ff6-dd26-d9b7-78b094041651@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OEr2kucUiMcKm51G3Zyz-o_0UhuYUvtc
X-Proofpoint-ORIG-GUID: LFekYh4eYxizwJrBUftF3ex5m1y0zNT8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_03:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/21 3:24 PM, John Garry wrote:
> On 02/04/2021 00:16, Ian Rogers wrote:
>> On Thu, Mar 25, 2021 at 3:38 AM John Garry <john.garry@huawei.com> wrote:
>>>
>>> Function find_metric() is required for the metric processing in the
>>> pmu-events testcase, so make it public. Also change the name to include
>>> "metricgroup".
>>
>> Would it make more sense as "pmu_events_map__find_metric" ?
>>
> 
> So all functions apart from one in metricgroup.h are named metricgroup__XXX, so I was trying to keep this style - apart from the double-underscore (which can be remedied).
> 
> Personally I don't think pmu_events_map__find_metric name fits with that convention.

I agree, most of the functions in metricgroup.c named as metricgroup__xxx. May be something like metricgroup__find_metric will be better.

Thanks,
Kajol Jain

> 
> Thanks,
> John
> 
>> Thanks,
>> Ian
>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>   tools/perf/util/metricgroup.c | 5 +++--
>>>   tools/perf/util/metricgroup.h | 3 ++-
>>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>>> index 6acb44ad439b..71a13406e0bd 100644
>>> --- a/tools/perf/util/metricgroup.c
>>> +++ b/tools/perf/util/metricgroup.c
>>> @@ -900,7 +900,8 @@ static int __add_metric(struct list_head *metric_list,
>>>                      (match_metric(__pe->metric_group, __metric) ||      \
>>>                       match_metric(__pe->metric_name, __metric)))
>>>
>>> -static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
>>> +struct pmu_event *metrcgroup_find_metric(const char *metric,
>>> +                                        struct pmu_events_map *map)
>>>   {
>>>          struct pmu_event *pe;
>>>          int i;
>>> @@ -985,7 +986,7 @@ static int __resolve_metric(struct metric *m,
>>>                          struct expr_id *parent;
>>>                          struct pmu_event *pe;
>>>
>>> -                       pe = find_metric(cur->key, map);
>>> +                       pe = metrcgroup_find_metric(cur->key, map);
>>>                          if (!pe)
>>>                                  continue;
>>>
>>> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
>>> index ed1b9392e624..1674c6a36d74 100644
>>> --- a/tools/perf/util/metricgroup.h
>>> +++ b/tools/perf/util/metricgroup.h
>>> @@ -44,7 +44,8 @@ int metricgroup__parse_groups(const struct option *opt,
>>>                                bool metric_no_group,
>>>                                bool metric_no_merge,
>>>                                struct rblist *metric_events);
>>> -
>>> +struct pmu_event *metrcgroup_find_metric(const char *metric,
>>> +                                        struct pmu_events_map *map);
>>>   int metricgroup__parse_groups_test(struct evlist *evlist,
>>>                                     struct pmu_events_map *map,
>>>                                     const char *str,
>>> -- 
>>> 2.26.2
>>>
>> .
>>
> 

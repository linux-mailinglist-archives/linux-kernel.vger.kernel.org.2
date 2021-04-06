Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C28355569
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344587AbhDFNlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:41:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2769 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbhDFNlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:41:06 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FF7lp74C9z682sK;
        Tue,  6 Apr 2021 21:33:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 15:40:56 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 14:40:55 +0100
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
 <YGxaOnUZnNmDg/2P@krava> <49025439-f9e3-0d32-b0a3-ff9f9ff71835@huawei.com>
 <YGxjWNdZGqWqL87r@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6bb503e4-8d75-62a6-3c10-8478df9c3e44@huawei.com>
Date:   Tue, 6 Apr 2021 14:38:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YGxjWNdZGqWqL87r@krava>
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

On 06/04/2021 14:34, Jiri Olsa wrote:
>>
>> }
>>
>> So once we evaluate a pmu_event in pctx->ids in @pe, @all is set false, and
>> we would loop again in the do-while loop, regardless of what
>> expr__find_other() does (apart from erroring), and so call
>> hashmap__for_each_entry_safe(&pctx->ids, ) again.
> ah ok, so it finishes the hash iteration first and
> then restarts it.. ok, I missed that, then it's fine
>  >> This is really what is done in __resolve_metric() - indeed, I would 
use that
>> function directly, but it looks hard to extract that from metricgroup.c .
> yea, it's another world;-)  it's better to keep it separated

ok, so I'll still add the break statement, as suggested.

I'll also wait to see if Ian or you have a strong feeling about the 
function naming in patch 1/6.

Thanks,
John


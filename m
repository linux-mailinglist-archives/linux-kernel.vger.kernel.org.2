Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1942D355181
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbhDFLFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:05:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2766 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241641AbhDFLFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:05:14 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FF4L86QQXz682Z9;
        Tue,  6 Apr 2021 19:00:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 13:05:05 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 12:05:03 +0100
Subject: Re: [PATCH v2 0/6] perf arm64 metricgroup support
To:     kajoljain <kjain@linux.ibm.com>, "Paul A. Clarke" <pc@us.ibm.com>
CC:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <irogers@google.com>, <linuxarm@huawei.com>,
        <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <20210325203944.GD8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <dc17013d-2dcb-8ddf-a15a-e98cad3e2ae3@huawei.com>
 <20210329210717.GF8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <247e9484-34c8-544a-e268-b025ecb317fe@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1d800da3-ec94-3a37-eca9-1d3cf8543ba6@huawei.com>
Date:   Tue, 6 Apr 2021 12:02:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <247e9484-34c8-544a-e268-b025ecb317fe@linux.ibm.com>
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

On 30/03/2021 07:41, kajoljain wrote:
> 
> 
> On 3/30/21 2:37 AM, Paul A. Clarke wrote:
>> On Fri, Mar 26, 2021 at 10:57:40AM +0000, John Garry wrote:
>>> On 25/03/2021 20:39, Paul A. Clarke wrote:
>>>> On Thu, Mar 25, 2021 at 06:33:12PM +0800, John Garry wrote:
>>>>> Metric reuse support is added for pmu-events parse metric testcase.
>>>>> This had been broken on power9 recentlty:
>>>>> https://lore.kernel.org/lkml/20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com/
>>>>
>>>> Much better.  Before:
>>>> --
>>>> $ perf test -v 10 2>&1 | grep -i error | wc -l
>>>> 112
>>>> --
>>>> After:
>>>> --
>>>> $ perf test -v 10 2>&1 | grep -i error | wc -l
>>>> 17
>>>> --
>>>>
>>>> And these seem like different types of issues:
>>>> --
>>>> $ perf test -v 10 2>&1 | grep -i error
>>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_powerbus0_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>>> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
>>>> --
>>>>
>>>
>>> This looks suspicious.
>>>
>>> Firstly, does /sys/bus/event_source/devices/nest_mcs01_imc (or others,
>>> above) exist on your system? I guess not.
>>>
>>> Secondly, checking Documentation/powerpc/imc.rst, we have examples of:
>>> nest_mcs01/PM_MCS01_64B_R...
>>>
>>> So is the PMU name correct in the metric file for nest_mcs01_imc? Looking at
>>> the kernel driver file, arch/powerpc/perf/imc-pmu.c, it seems to be correct.
>>> Not sure.
>>
>> I ran with a newer kernel, and the above errors disappeared, replaced with
>> about 10 of:
>> --
>> Error string 'Cannot find PMU `hv_24x7'. Missing kernel support?' help '(null)'
>> --
>>
>> ...but I was running without a hypervisor, so I tried the same kernel on a
>> PowerVM-virtualized system and the "hv_24x7" messages went away, but the
>> "nest" messages returned.  This may all be expected behavior... I confess
>> I haven't followed these new perf capabilities closely.
>>
> 
> Hi Paul/John,
>     This is something expected. For nest-imc we need bare-metal system and for
> hv-24x7 we need VM environment. Since you are checking this test in VM machine,
> there nest events are not supported and hence we are getting this error.
> 
> Thanks,
> Kajol Jain

Cool, so I hope that tested-by or similar can be provided :) [obviously 
pending any changes that come from reviews]

Thanks

> 
>> It's extremely likely that none of these errors has anything to do with your
>> changes. :-
>>
>> PC
>>
> .
> 


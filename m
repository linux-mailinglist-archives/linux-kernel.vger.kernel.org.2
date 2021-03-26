Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D4034A60D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCZLAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:00:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2743 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhCZLAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:00:00 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F6Jfy0T8rz680jb;
        Fri, 26 Mar 2021 18:51:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Mar 2021 11:59:58 +0100
Received: from [10.210.170.125] (10.210.170.125) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Mar 2021 10:59:57 +0000
Subject: Re: [PATCH v2 0/6] perf arm64 metricgroup support
To:     "Paul A. Clarke" <pc@us.ibm.com>
CC:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <irogers@google.com>, <linuxarm@huawei.com>,
        <kjain@linux.ibm.com>, <kan.liang@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com>
 <20210325203944.GD8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <dc17013d-2dcb-8ddf-a15a-e98cad3e2ae3@huawei.com>
Date:   Fri, 26 Mar 2021 10:57:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210325203944.GD8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.125]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2021 20:39, Paul A. Clarke wrote:
> On Thu, Mar 25, 2021 at 06:33:12PM +0800, John Garry wrote:
>> Metric reuse support is added for pmu-events parse metric testcase.
>> This had been broken on power9 recentlty:
>> https://lore.kernel.org/lkml/20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com/
> 
> Much better.  Before:
> --
> $ perf test -v 10 2>&1 | grep -i error | wc -l
> 112
> --
> After:
> --
> $ perf test -v 10 2>&1 | grep -i error | wc -l
> 17
> --
> 
> And these seem like different types of issues:
> --
> $ perf test -v 10 2>&1 | grep -i error
> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_powerbus0_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs01_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> Error string 'Cannot find PMU `nest_mcs23_imc'. Missing kernel support?' help '(null)'
> --
> 

This looks suspicious.

Firstly, does /sys/bus/event_source/devices/nest_mcs01_imc (or others, 
above) exist on your system? I guess not.

Secondly, checking Documentation/powerpc/imc.rst, we have examples of:
nest_mcs01/PM_MCS01_64B_R...

So is the PMU name correct in the metric file for nest_mcs01_imc? 
Looking at the kernel driver file, arch/powerpc/perf/imc-pmu.c, it seems 
to be correct. Not sure.

Thanks,
John



> (Added Kajol Jain to CC)
> 



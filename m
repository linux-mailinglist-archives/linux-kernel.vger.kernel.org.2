Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD24344002
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCVLjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:39:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2723 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhCVLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:38:48 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F3sjd6Btyz681SN;
        Mon, 22 Mar 2021 19:29:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 12:38:38 +0100
Received: from [10.210.167.192] (10.210.167.192) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 11:38:36 +0000
Subject: Re: [PATCHv4 00/19] perf metric: Add support to reuse metric
To:     "Paul A. Clarke" <pc@us.ibm.com>, Jiri Olsa <jolsa@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
References: <20200729091908.1378911-1-jolsa@kernel.org>
 <20200801114050.GB377079@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7682e4c3-5840-bb6d-5e76-6b3fd37b04c0@huawei.com>
Date:   Mon, 22 Mar 2021 11:36:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200801114050.GB377079@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.192]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2020 12:40, Paul A. Clarke wrote:
>> v4 changes:
>>    - removed acks from patch because it changed a bit
>>      with the last fixes:
>>        perf metric: Collect referenced metrics in struct metric_ref_node
>>    - fixed runtime metrics [Kajol Jain]
>>    - increased recursion depth [Paul A. Clarke]
>>    - changed patches due to dependencies:
>>        perf metric: Collect referenced metrics in struct metric_ref_node
>>        perf metric: Add recursion check when processing nested metrics
>>        perf metric: Rename struct egroup to metric
>>        perf metric: Rename group_list to metric_list
>>
>> Also available in here:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>>    perf/metric
> I built and ran from the above git branch, and things seem to work.
> Indeed, I was able to apply my changes to exploit the new capabilities
> via modifications to tools/perf/pmu-events/arch/powerpc/power9/metrics.json,
> as I posted earlier (and will submit once this set gets merged).
> 

Hi Paul,

I was just wondering: Does perf subtest 10.3 work ok for you with the 
metric reuse?

That's "Parsing of PMU event table metrics" subtest.

Hi Jirka,

If I add something like this:
     {
         "BriefDescription": "dummy test1",
         "MetricExpr": "Bad_Speculation + Frontend_Bound",
         "MetricGroup": "TopdownL1",
         "MetricName": "dummytest",
         "PublicDescription": "dummy test2"
     },

I get "Parse event failed metric 'dummytest' id 'bad_speculation' expr 
'bad_speculation + frontend_bound'"

Thanks,
john

> Tested-by: Paul A. Clarke<pc@us.ibm.com>
> 
> One thing I noted, but which also occurs without these patches, is that
> the perf metrics are not computed unless run as root:
> --
> $ perf stat --metrics br_misprediction_percent command
> 
>   Performance counter stats for 'command':
> 
>       1,823,530,051      pm_br_pred:u
>           2,662,705      pm_br_mpred_cmpl:u
> 
> $ /usr/bin/sudo perf stat --metrics br_misprediction_percent command
> 
>   Performance counter stats for 'command':
> 
>       1,824,655,269      pm_br_pred                #     0.09 br_misprediction_percent
>           1,654,466      pm_br_mpred_cmpl
> --


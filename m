Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535383462AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhCWPSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:18:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2733 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhCWPRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:17:35 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F4ZWh2YZ1z682g8;
        Tue, 23 Mar 2021 23:08:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 16:17:32 +0100
Received: from [10.47.11.95] (10.47.11.95) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 23 Mar
 2021 15:17:30 +0000
Subject: Re: [PATCHv4 00/19] perf metric: Add support to reuse metric
To:     "Paul A. Clarke" <pc@us.ibm.com>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
References: <20200729091908.1378911-1-jolsa@kernel.org>
 <20200801114050.GB377079@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <7682e4c3-5840-bb6d-5e76-6b3fd37b04c0@huawei.com>
 <20210323150604.GB8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a233702a-89b7-ae47-d47a-a7b4539c191e@huawei.com>
Date:   Tue, 23 Mar 2021 15:15:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210323150604.GB8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.95]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 15:06, Paul A. Clarke wrote:
> On Mon, Mar 22, 2021 at 11:36:23AM +0000, John Garry wrote:
>> On 01/08/2020 12:40, Paul A. Clarke wrote:
>>>> v4 changes:
>>>>     - removed acks from patch because it changed a bit
>>>>       with the last fixes:
>>>>         perf metric: Collect referenced metrics in struct metric_ref_node
>>>>     - fixed runtime metrics [Kajol Jain]
>>>>     - increased recursion depth [Paul A. Clarke]
>>>>     - changed patches due to dependencies:
>>>>         perf metric: Collect referenced metrics in struct metric_ref_node
>>>>         perf metric: Add recursion check when processing nested metrics
>>>>         perf metric: Rename struct egroup to metric
>>>>         perf metric: Rename group_list to metric_list
>>>>
>>>> Also available in here:
>>>>     git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>>>>     perf/metric
>>> I built and ran from the above git branch, and things seem to work.
>>> Indeed, I was able to apply my changes to exploit the new capabilities
>>> via modifications to tools/perf/pmu-events/arch/powerpc/power9/metrics.json,
>>> as I posted earlier (and will submit once this set gets merged).
>> I was just wondering: Does perf subtest 10.3 work ok for you with the metric
>> reuse?
>>
>> That's "Parsing of PMU event table metrics" subtest.
> I confess I'm not sure what you are asking. Using the latest mainline
> (84196390620ac0e5070ae36af84c137c6216a7dc), perf subtest 10.3 does
> pass for me:
> --
> $ ./perf test 10
> 10: PMU events                                                      :
> 10.1: PMU event table sanity                                        : Ok
> 10.2: PMU event map aliases                                         : Ok
> 10.3: Parsing of PMU event table metrics                            : Ok
> 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> --
Since commit 8989f5f07605 ("perf stat: Update POWER9 metrics to utilize 
other metrics"), power9 has reused metrics.

And I am finding that subtest 10.3 caused problems when I tried to 
introduce metric reuse on arm64, so I was just asking you to check.

Now I am a bit confused...

Thanks for checking,
john

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47646347450
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhCXJPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:15:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2737 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbhCXJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:15:22 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F52Wv2ybjz6801j;
        Wed, 24 Mar 2021 17:10:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 10:15:20 +0100
Received: from [10.47.7.62] (10.47.7.62) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Wed, 24 Mar
 2021 09:15:18 +0000
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
 <a233702a-89b7-ae47-d47a-a7b4539c191e@huawei.com>
 <20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a8782d26-6993-8e41-1d0b-3f1a9ab4497a@huawei.com>
Date:   Wed, 24 Mar 2021 09:13:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.62]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 01:54, Paul A. Clarke wrote:
>>> --
>> Since commit 8989f5f07605 ("perf stat: Update POWER9 metrics to utilize
>> other metrics"), power9 has reused metrics.
>>
>> And I am finding that subtest 10.3 caused problems when I tried to introduce
>> metric reuse on arm64, so I was just asking you to check.
>>
>> Now I am a bit confused...
> I now understand your original request!:-)
> 
> The above test was run on a POWER8 system.
> 
> I do see failures on a POWER9 system:
> --
> $ ./perf test 10
> 10: PMU events                                                      :
> 10.1: PMU event table sanity                                        : Ok
> 10.2: PMU event map aliases                                         : Ok
> 10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
> 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> $ ./perf test --verbose 10 2>&1 | grep -i '^Parse event failed' | wc -l
> 112

ok, thanks for confirming.

I'm looking at fixing it, and the solution doesn't look simple :(

John

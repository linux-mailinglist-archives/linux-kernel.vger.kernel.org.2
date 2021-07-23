Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6603A3D39BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhGWLGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:06:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3463 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbhGWLGQ (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:06:16 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWS3y22wfz6DGRs;
        Fri, 23 Jul 2021 19:37:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 13:46:48 +0200
Received: from [10.47.26.161] (10.47.26.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 12:46:47 +0100
Subject: Re: [PATCH v1] perf pmu: Add PMU alias support
To:     "Jin, Yao" <yao.jin@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>
CC:     <Linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <ak@linux.intel.com>, <kan.liang@intel.com>, <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210722014546.11948-1-yao.jin@linux.intel.com>
 <ef8cc210-1a0a-796c-effa-63af590d17aa@huawei.com>
 <6b9fb1dc-5f53-d378-9119-84e991a0c86e@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bf81673d-4b8f-e68a-bb44-32ad15b106f7@huawei.com>
Date:   Fri, 23 Jul 2021 12:46:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <6b9fb1dc-5f53-d378-9119-84e991a0c86e@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.26.161]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2021 07:56, Jin, Yao wrote:
>>>
>>> Use the real name,
>>>   $ perf stat -e uncore_cha_2/event=1/ -x,
>>>     4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,
>>>
>>> Use the alias,
>>>   $ perf stat -e uncore_type_0_2/event=1/ -x,
>>>     3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,
>>
>> Having a self-test case would be nice. And it's questionable why this 
>> goes in x86 code.
>>
> 
> OK, I will add test cases for uncore PMU alias.
> 

JFYI, I am doing a bit of a rewrite of tests/pmu-events.c to tighten it 
up to catch cases like those fixed and also broke in "perf tools: Fix 
pattern matching for same substring in different pmu type".

> For why it's now only x86 specific code, my understanding is, currently 
> x86 has this usage case, we can further extend it to other ARCHs and 
> make it a generic way in future.

Generally that is not how things are done, but I'm not the maintainer ...

Thanks,
john

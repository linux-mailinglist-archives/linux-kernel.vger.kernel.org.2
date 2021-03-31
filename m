Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D134F689
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhCaCSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:18:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14648 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbhCaCSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:18:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F990V2g8kznV2x;
        Wed, 31 Mar 2021 10:16:10 +0800 (CST)
Received: from [10.67.102.248] (10.67.102.248) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 10:18:34 +0800
Subject: Re: [PATCH v7] perf annotate: Fix sample events lost in stdio mode
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Yao Jin <yao.jin@linux.intel.com>, <gustavoars@kernel.org>,
        <mliska@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
        <zhangjinhao2@huawei.com>
References: <20210319123527.173883-1-yangjihong1@huawei.com>
 <33ba152e-b8ef-3057-744a-51cb8c478ff2@huawei.com>
 <CAM9d7cjT-Q8RBprzG=hwdxrgVpzf3RwECuJ1UvbQYpQ47migbg@mail.gmail.com>
 <YF3OXfzl7FEV50Ir@kernel.org>
 <27703989-e510-c964-2af7-ef0a5611f8cf@huawei.com>
 <CAM9d7chhFnYyUv++RzJRXomHq0vZN2LrbCAOBPg67MDeg6saOw@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <555b7a2d-13c8-e840-e62b-cf0ad7d084a9@huawei.com>
Date:   Wed, 31 Mar 2021 10:18:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7chhFnYyUv++RzJRXomHq0vZN2LrbCAOBPg67MDeg6saOw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Namhyung  and Arnaldo,

On 2021/3/30 15:26, Namhyung Kim wrote:
> Hi Yang and Arnaldo,
> 
> On Sat, Mar 27, 2021 at 11:16 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>> On 2021/3/26 20:06, Arnaldo Carvalho de Melo wrote:
>>> So it seems to be working, what am I missing? Is this strictly non
>>> group related?
>>>
>> Yes, it is non group related.
>> This problem occurs only when different events need to be recorded at
>> the same time, i.e.:
>> perf record -e branch-misses -e branch-instructions -a sleep 1
>>
>> The output results of perf script and perf annotate do not match.
>> Some events are not output in perf annotate.
> 
> Yeah I think it's related to sort keys.  The code works with a single
> hist_entry for each event and symbol.  But the default sort key
> creates multiple entries for different threads and it causes the
> confusion.
> 
Yes, After revome zfree from hists__find_annotations, the output of perf 
annotate is repeated, which is related to sort keys.

The original problem is that notes->src may correspond to multiple 
sample events. Therefore, we cannot simply zfree notes->src to avoid 
repeated output.

Arnaldo, is there any problem with this patch? :)

Thanks,
Yang
> Thanks,
> Namhyung
> .
> 

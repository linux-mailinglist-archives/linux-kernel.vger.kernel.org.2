Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B398360BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhDOOUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:20:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17344 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:20:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FLhJX1CFBzB1Hg;
        Thu, 15 Apr 2021 22:18:04 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.202) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Thu, 15 Apr 2021
 22:20:20 +0800
Subject: Re: [PATCH 1/1] perf map: Fix error return code in maps__clone()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210415092744.3793-1-thunder.leizhen@huawei.com>
 <YHg0wyanA+UxqXWi@kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4bc1ad55-3ad9-be21-4ed1-5f0433ad8a61@huawei.com>
Date:   Thu, 15 Apr 2021 22:20:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YHg0wyanA+UxqXWi@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/15 20:42, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 15, 2021 at 05:27:44PM +0800, Zhen Lei escreveu:
>> Although 'err' has been initialized to -ENOMEM, but it will be reassigned
>> by the "err = unwind__prepare_access(...)" statement in the for loop. So
>> that, the value of 'err' is unknown when map__clone() failed.
> 
> You forgot to research and add this:
> 
> Fixes: 6c502584438bda63 ("perf unwind: Call unwind__prepare_access for forked thread")
> 
> So that the stable@kernel.org guys can pick this up automagically and
> apply this fix to the stable kernels.
> 
> I've added it.

OK, thank you very much.

> 
> Thanks, applied.
> 
> - Arnaldo
>  
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  tools/perf/util/map.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
>> index fbc40a2c17d4dca..8af693d9678cefe 100644
>> --- a/tools/perf/util/map.c
>> +++ b/tools/perf/util/map.c
>> @@ -840,15 +840,18 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>>  int maps__clone(struct thread *thread, struct maps *parent)
>>  {
>>  	struct maps *maps = thread->maps;
>> -	int err = -ENOMEM;
>> +	int err;
>>  	struct map *map;
>>  
>>  	down_read(&parent->lock);
>>  
>>  	maps__for_each_entry(parent, map) {
>>  		struct map *new = map__clone(map);
>> -		if (new == NULL)
>> +
>> +		if (new == NULL) {
>> +			err = -ENOMEM;
>>  			goto out_unlock;
>> +		}
>>  
>>  		err = unwind__prepare_access(maps, new, NULL);
>>  		if (err)
>> -- 
>> 2.26.0.106.g9fadedd
>>
>>
> 


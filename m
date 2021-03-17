Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D6233ED6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCQJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:51:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13975 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhCQJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:50:38 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F0lj55vP1zrXnw;
        Wed, 17 Mar 2021 17:48:41 +0800 (CST)
Received: from [10.67.102.248] (10.67.102.248) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 17:50:25 +0800
Subject: Re: [PATCH v5] perf annotate: Fix sample events lost in stdio mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <yao.jin@linux.intel.com>, <gustavoars@kernel.org>,
        <mliska@suse.cz>, <linux-kernel@vger.kernel.org>,
        <zhangjinhao2@huawei.com>
References: <20210316021759.257503-1-yangjihong1@huawei.com>
 <YFCtmEBqsgKnkaV7@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <8d9cc941-c85e-34c2-e703-a8d52b615eff@huawei.com>
Date:   Wed, 17 Mar 2021 17:50:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YFCtmEBqsgKnkaV7@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2021/3/16 21:07, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 16, 2021 at 10:17:59AM +0800, Yang Jihong escreveu:
>> In hist__find_annotations function, since different hist_entry may point to same
>> symbol, we free notes->src to signal already processed this symbol in stdio mode;
>> when annotate, entry will skipped if notes->src is NULL to avoid repeated output.
>>
>> However, there is a problem, for example, run the following command:
>>
>>   # perf record -e branch-misses -e branch-instructions -a sleep 1
>>
>> perf.data file contains different types of sample event.
>>
>> If the same IP sample event exists in branch-misses and branch-instructions,
>> this event uses the same symbol. When annotate branch-misses events, notes->src
>> corresponding to this event is set to null, as a result, when annotate
>> branch-instructions events, this event is skipped and no annotate is output.
>>
>> Solution of this patch is to remove zfree in hists__find_annotations and
>> change sort order to "dso,symbol" to avoid duplicate output when different
>> processes correspond to the same symbol.
> 
> You forgot to add your Signed-off-by tag, i.e.:
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> 
> Please take a look at Documentation/process/submitting-patches.rst.
> 
> Regards,
> 
> - Arnaldo
> 
Thanks for the patient instructions :)
I've submitted the v6 patch, look forward to your review:
https://lore.kernel.org/patchwork/patch/1397675

>> ---
>>   tools/perf/builtin-annotate.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>> index a23ba6bb99b6..92c55f292c11 100644
>> --- a/tools/perf/builtin-annotate.c
>> +++ b/tools/perf/builtin-annotate.c
>> @@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists *hists,
>>   		} else {
>>   			hist_entry__tty_annotate(he, evsel, ann);
>>   			nd = rb_next(nd);
>> -			/*
>> -			 * Since we have a hist_entry per IP for the same
>> -			 * symbol, free he->ms.sym->src to signal we already
>> -			 * processed this symbol.
>> -			 */
>> -			zfree(&notes->src->cycles_hist);
>> -			zfree(&notes->src);
>>   		}
>>   	}
>>   }
>> @@ -619,6 +612,12 @@ int cmd_annotate(int argc, const char **argv)
>>   
>>   	setup_browser(true);
>>   
>> +	/*
>> +	 * Events of different processes may correspond to the same
>> +	 * symbol, we do not care about the processes in annotate,
>> +	 * set sort order to avoid repeated output.
>> +	 */
>> +	sort_order = "dso,symbol";
>>   	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
>>   		sort__mode = SORT_MODE__BRANCH;
>>   		if (setup_sorting(annotate.session->evlist) < 0)
>> -- 
>> 2.30.GIT
>>
> 

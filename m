Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6C341D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCSMje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:39:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13648 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCSMjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:39:02 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F23Kp26y5zmZdn;
        Fri, 19 Mar 2021 20:36:30 +0800 (CST)
Received: from [10.67.102.248] (10.67.102.248) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 20:38:52 +0800
Subject: Re: [PATCH v6] perf annotate: Fix sample events lost in stdio mode
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Yao Jin <yao.jin@linux.intel.com>, <gustavoars@kernel.org>,
        <mliska@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20210317094409.94293-1-yangjihong1@huawei.com>
 <CAM9d7cjg059U8rn+BDfFrPAQ8xBUaMRJWsdbpm8f2bMcvx7OiQ@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <62845bff-fbca-e1d3-ce41-d7b925c0046b@huawei.com>
Date:   Fri, 19 Mar 2021 20:38:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjg059U8rn+BDfFrPAQ8xBUaMRJWsdbpm8f2bMcvx7OiQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/18 14:13, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Mar 17, 2021 at 6:44 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
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
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>
>> Changes since v5:
>>    - Add Signed-off-by tag.
>>
>> Changes since v4:
>>    - Use the same sort key "dso,symbol" in branch stack mode.
>>
>> Changes since v3:
>>    - Modify the first line of comments.
>>
>> Changes since v2:
>>    - Remove zfree in hists__find_annotations.
>>    - Change sort order to avoid duplicate output.
>>
>> Changes since v1:
>>    - Change processed flag variable from u8 to bool.
>>
>>   tools/perf/builtin-annotate.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>> index a23ba6bb99b6..92c55f292c11 100644
>> --- a/tools/perf/builtin-annotate.c
>> +++ b/tools/perf/builtin-annotate.c
>> @@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists *hists,
>>                  } else {
>>                          hist_entry__tty_annotate(he, evsel, ann);
>>                          nd = rb_next(nd);
>> -                       /*
>> -                        * Since we have a hist_entry per IP for the same
>> -                        * symbol, free he->ms.sym->src to signal we already
>> -                        * processed this symbol.
>> -                        */
>> -                       zfree(&notes->src->cycles_hist);
>> -                       zfree(&notes->src);
>>                  }
>>          }
>>   }
>> @@ -619,6 +612,12 @@ int cmd_annotate(int argc, const char **argv)
>>
>>          setup_browser(true);
>>
>> +       /*
>> +        * Events of different processes may correspond to the same
>> +        * symbol, we do not care about the processes in annotate,
>> +        * set sort order to avoid repeated output.
>> +        */
>> +       sort_order = "dso,symbol";
> 
> At this point, I think there's not much value having separate
> setup_sorting() for branch mode.
> 
Yes, two setup_sorting can be combined into one setup_sorting(NULL),
the v7 patch has been submitted, please check it :)

https://lore.kernel.org/patchwork/patch/1399031/

Thanks,
Yang
> Thanks,
> Namhyung
> 
> 
>>          if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
>>                  sort__mode = SORT_MODE__BRANCH;
>>                  if (setup_sorting(annotate.session->evlist) < 0)
>> --
>> 2.30.GIT
>>
> .
> 

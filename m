Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26933338456
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 04:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhCLDYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 22:24:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13503 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhCLDYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 22:24:10 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DxWMb4PTHzrVGW;
        Fri, 12 Mar 2021 11:22:19 +0800 (CST)
Received: from [10.67.102.248] (10.67.102.248) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 12 Mar 2021 11:24:00 +0800
Subject: Re: [PATCH] perf annotate: Fix sample events lost in stdio mode
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Yao Jin <yao.jin@linux.intel.com>, <gustavoars@kernel.org>,
        <mliska@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
        <zhangjinhao2@huawei.com>
References: <20210306082859.179541-1-yangjihong1@huawei.com>
 <53ff575f-1fcf-6650-76ad-a0304f6bdf15@huawei.com>
 <CAM9d7chRZq743y1Qb24eLZ5ScXeZs0b_0dyffRcOAwuLdVag7g@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <02146240-e532-1c52-0589-bfff3fbe5166@huawei.com>
Date:   Fri, 12 Mar 2021 11:24:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7chRZq743y1Qb24eLZ5ScXeZs0b_0dyffRcOAwuLdVag7g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Namhyung

On 2021/3/11 22:42, Namhyung Kim wrote:
> Hi,
> 
> On Thu, Mar 11, 2021 at 5:48 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Hello,
>>
>> On 2021/3/6 16:28, Yang Jihong wrote:
>>> In hist__find_annotations function, since have a hist_entry per IP for the same
>>> symbol, we free notes->src to signal already processed this symbol in stdio mode;
>>> when annotate, entry will skipped if notes->src is NULL to avoid repeated output.
> 
> I'm not sure it's still true that we have a hist_entry per IP.
> Afaik the default sort key is comm,dso,sym which means it should have a single
> hist_entry for each symbol.  It seems like an old comment..
> 
Emm, yes, we have a hist_entry for per IP.
a member named "sym" in struct "hist_entry" points to symbol,
different IP may point to the same symbol.

The hist_entry struct is as follows:
struct hist_entry {
     ...
     struct map_symbol ms;
     ...
};
struct map_symbol {
     struct maps *maps;
     struct map *map;
     struct symbol *sym;
};

>>>
>>> However, there is a problem, for example, run the following command:
>>>
>>>    # perf record -e branch-misses -e branch-instructions -a sleep 1
>>>
>>> perf.data file contains different types of sample event.
>>>
>>> If the same IP sample event exists in branch-misses and branch-instructions,
>>> this event uses the same symbol. When annotate branch-misses events, notes->src
>>> corresponding to this event is set to null, as a result, when annotate
>>> branch-instructions events, this event is skipped and no annotate is output.
>>>
>>> Solution of this patch is to add a u8 member to struct sym_hist and use a bit to
>>> indicate whether the symbol has been processed.
>>> Because different types of event correspond to different sym_hist, no conflict
>>> occurs.
>>> ---
>>>    tools/perf/builtin-annotate.c | 22 ++++++++++++++--------
>>>    tools/perf/util/annotate.h    |  4 ++++
>>>    2 files changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>>> index a23ba6bb99b6..c8c67892ae82 100644
>>> --- a/tools/perf/builtin-annotate.c
>>> +++ b/tools/perf/builtin-annotate.c
>>> @@ -372,15 +372,21 @@ static void hists__find_annotations(struct hists *hists,
>>>                        if (next != NULL)
>>>                                nd = next;
>>>                } else {
>>> -                     hist_entry__tty_annotate(he, evsel, ann);
>>> +                     struct sym_hist *h = annotated_source__histogram(notes->src,
>>> +                                                                      evsel->idx);
>>> +
>>> +                     if (h->processed == 0) {
>>> +                             hist_entry__tty_annotate(he, evsel, ann);
>>> +
>>> +                             /*
>>> +                              * Since we have a hist_entry per IP for the same
>>> +                              * symbol, set processed flag of evsel in sym_hist
>>> +                              * to signal we already processed this symbol.
>>> +                              */
>>> +                             h->processed = 1;
>>> +                     }
>>> +
>>>                        nd = rb_next(nd);
>>> -                     /*
>>> -                      * Since we have a hist_entry per IP for the same
>>> -                      * symbol, free he->ms.sym->src to signal we already
>>> -                      * processed this symbol.
>>> -                      */
>>> -                     zfree(&notes->src->cycles_hist);
>>> -                     zfree(&notes->src);
>>>                }
>>>        }
>>>    }
>>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>>> index 096cdaf21b01..89872bfdc958 100644
>>> --- a/tools/perf/util/annotate.h
>>> +++ b/tools/perf/util/annotate.h
>>> @@ -228,6 +228,10 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
>>>    struct sym_hist {
>>>        u64                   nr_samples;
>>>        u64                   period;
>>> +
>>> +     u8                    processed  : 1, /* whether symbol has been processed, used for annotate */
>>> +                           __reserved : 7;
> 
> I think just a bool member is fine.
>
OK, I have submitted the v2 patch and changed to bool member, new patch 
is as follows, look forward to your review:
https://lore.kernel.org/patchwork/patch/1393901/

>>> +
>>>        struct sym_hist_entry addr[];
>>>    };
>>>
>>>
>> Please check whether this solution is feasible, look forward to your review.
> 
> What about this?  (not tested)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index a23ba6bb99b6..a91fe45bd69f 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists *hists,
>                  } else {
>                          hist_entry__tty_annotate(he, evsel, ann);
>                          nd = rb_next(nd);
> -                       /*
> -                        * Since we have a hist_entry per IP for the same
> -                        * symbol, free he->ms.sym->src to signal we already
> -                        * processed this symbol.
> -                        */
> -                       zfree(&notes->src->cycles_hist);
> -                       zfree(&notes->src);
>                  }
>          }
>   }
> 
This solution may have the following problem:
For example, if two sample events are in two different processes but in 
the same symbol, repeated output may occur.
Therefore, a flag is required to indicate whether the symbol has been 
processed to avoid repeated output.
> Thanks,
> Namhyung
> .
> 
Thanks,
Yang
.

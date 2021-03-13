Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382F4339AFD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 03:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhCMCA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 21:00:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13509 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCMCAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 21:00:39 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dy5Sj1N1mzrVcq;
        Sat, 13 Mar 2021 09:58:45 +0800 (CST)
Received: from [10.67.102.248] (10.67.102.248) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 13 Mar 2021 10:00:26 +0800
Subject: Re: [PATCH] perf annotate: Fix sample events lost in stdio mode
From:   Yang Jihong <yangjihong1@huawei.com>
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
 <02146240-e532-1c52-0589-bfff3fbe5166@huawei.com>
 <CAM9d7cjHAEhc-g4Fs3muwQrMV=Os5cn6NgOkf4vBeE+QK-Wu=w@mail.gmail.com>
 <cc7811c5-2d24-29ac-5a0c-71261a699a39@huawei.com>
 <CAM9d7ciM6bZmYepRCe_YY7mYZGbvrpwF7A_oCngM9GMoxPXS6A@mail.gmail.com>
 <360667d9-f0cc-866c-b0b9-b37dd85a9c45@huawei.com>
Message-ID: <a48d8b4b-0a58-ea7b-c67f-81bdbc39e3e5@huawei.com>
Date:   Sat, 13 Mar 2021 10:00:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <360667d9-f0cc-866c-b0b9-b37dd85a9c45@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Namhyung
On 2021/3/12 18:20, Yang Jihong wrote:
> Hello,
> 
> On 2021/3/12 16:39, Namhyung Kim wrote:
>> On Fri, Mar 12, 2021 at 4:19 PM Yang Jihong <yangjihong1@huawei.com> 
>> wrote:
>>>
>>>
>>> Hello,
>>> On 2021/3/12 13:49, Namhyung Kim wrote:
>>>> Hi,
>>>>
>>>> On Fri, Mar 12, 2021 at 12:24 PM Yang Jihong 
>>>> <yangjihong1@huawei.com> wrote:
>>>>>
>>>>> Hello, Namhyung
>>>>>
>>>>> On 2021/3/11 22:42, Namhyung Kim wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Thu, Mar 11, 2021 at 5:48 PM Yang Jihong 
>>>>>> <yangjihong1@huawei.com> wrote:
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> On 2021/3/6 16:28, Yang Jihong wrote:
>>>>>>>> In hist__find_annotations function, since have a hist_entry per 
>>>>>>>> IP for the same
>>>>>>>> symbol, we free notes->src to signal already processed this 
>>>>>>>> symbol in stdio mode;
>>>>>>>> when annotate, entry will skipped if notes->src is NULL to avoid 
>>>>>>>> repeated output.
>>>>>>
>>>>>> I'm not sure it's still true that we have a hist_entry per IP.
>>>>>> Afaik the default sort key is comm,dso,sym which means it should 
>>>>>> have a single
>>>>>> hist_entry for each symbol.  It seems like an old comment..
>>>>>>
>>>>> Emm, yes, we have a hist_entry for per IP.
>>>>> a member named "sym" in struct "hist_entry" points to symbol,
>>>>> different IP may point to the same symbol.
>>>>
>>>> Are you sure about this?  It seems like a bug then.
>>>>
>>> Yes, now each IP corresponds to a hist_entry :)
>>>
>>> Last week I found that some sample events were missing when perf
>>> annotate in stdio mode, so I went through the annotate code carefully.
>>>
>>> The event handling process is as follows:
>>> process_sample_event
>>>     evsel_add_sample
>>>       hists__add_entry
>>>         __hists__add_entry
>>>           hists__findnew_entry
>>>             hist_entry__new                  -> here allock new 
>>> hist_entry
>>
>> Yeah, so this is for a symbol.
>>
>>>
>>>       hist_entry__inc_addr_samples
>>>         symbol__inc_addr_samples
>>>           symbol__hists
>>>             annotated_source__new            -> here alloc annotate 
>>> soruce
>>>             annotated_source__alloc_histograms -> here alloc histograms
>>
>> This should be for each IP (ideally it should be per instruction).
>>
>>>
>>> By bugs, do you mean there's something wrong?
>>
>> No. I think we were saying about different things.  :)
>>
> OK, :)
>>
>>>>>> diff --git a/tools/perf/builtin-annotate.c 
>>>>>> b/tools/perf/builtin-annotate.c
>>>>>> index a23ba6bb99b6..a91fe45bd69f 100644
>>>>>> --- a/tools/perf/builtin-annotate.c
>>>>>> +++ b/tools/perf/builtin-annotate.c
>>>>>> @@ -374,13 +374,6 @@ static void hists__find_annotations(struct 
>>>>>> hists *hists,
>>>>>>                    } else {
>>>>>>                            hist_entry__tty_annotate(he, evsel, ann);
>>>>>>                            nd = rb_next(nd);
>>>>>> -                       /*
>>>>>> -                        * Since we have a hist_entry per IP for 
>>>>>> the same
>>>>>> -                        * symbol, free he->ms.sym->src to signal 
>>>>>> we already
>>>>>> -                        * processed this symbol.
>>>>>> -                        */
>>>>>> -                       zfree(&notes->src->cycles_hist);
>>>>>> -                       zfree(&notes->src);
>>>>>>                    }
>>>>>>            }
>>>>>>     }
>>>>>>
>>>>> This solution may have the following problem:
>>>>> For example, if two sample events are in two different processes 
>>>>> but in
>>>>> the same symbol, repeated output may occur.
>>>>> Therefore, a flag is required to indicate whether the symbol has been
>>>>> processed to avoid repeated output.
>>>>
>>>> Hmm.. ok.  Yeah we don't care about the processes here.
>>>> Then we should remove it from the sort key like below:
>>>>
>>>> @@ -624,6 +617,7 @@ int cmd_annotate(int argc, const char **argv)
>>>>                   if (setup_sorting(annotate.session->evlist) < 0)
>>>>                           usage_with_options(annotate_usage, options);
>>>>           } else {
>>>> +               sort_order = "dso,symbol";
>>>>                   if (setup_sorting(NULL) < 0)
>>>>                           usage_with_options(annotate_usage, options);
>>>>           }
>>>>
>>>>
>>> Are you referring to this solution?
>>> --- a/tools/perf/builtin-annotate.c
>>> +++ b/tools/perf/builtin-annotate.c
>>> @@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists
>>> *hists,
>>>                   } else {
>>>                           hist_entry__tty_annotate(he, evsel, ann);
>>>                           nd = rb_next(nd);
>>> -                       /*
>>> -                        * Since we have a hist_entry per IP for the 
>>> same
>>> -                        * symbol, free he->ms.sym->src to signal we 
>>> already
>>> -                        * processed this symbol.
>>> -                        */
>>> -                       zfree(&notes->src->cycles_hist);
>>> -                       zfree(&notes->src);
>>>                   }
>>>           }
>>>    }
>>> @@ -624,6 +617,7 @@ int cmd_annotate(int argc, const char **argv)
>>>                   if (setup_sorting(annotate.session->evlist) < 0)
>>>                           usage_with_options(annotate_usage, options);
>>>           } else {
>>> +               sort_order = "dso,symbol";
>>>                   if (setup_sorting(NULL) < 0)
>>>                           usage_with_options(annotate_usage, options);
>>>           }
>>> It seems to be a better solution without adding new member.
>>> I just tested it and it works.
>>>
>>> If we decide to use this solution, I'll resubmit a v3 patch.
>>
>> I prefer changing the sort order (and removing the zfree and comments).
>>
> OK, I'll submit a v3 patch based on the "changing the sort order" solution.
> 
I have submitted the v3 patch, look forward to your review:
https://lore.kernel.org/patchwork/patch/1394619/

> Thanks,
> Yang
>> Thanks,
>> Namhyung
Thanks,
Yang
>> .
>>

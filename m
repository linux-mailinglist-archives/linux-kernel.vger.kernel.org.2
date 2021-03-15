Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DDF33ADDC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhCOIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:47:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13536 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCOIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:47:24 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DzVNS5jQ9zNn8j;
        Mon, 15 Mar 2021 16:44:56 +0800 (CST)
Received: from [10.67.102.248] (10.67.102.248) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 16:47:12 +0800
Subject: Re: [PATCH v4] perf annotate: Fix sample events lost in stdio mode
To:     Namhyung Kim <namhyung@kernel.org>,
        Yao Jin <yao.jin@linux.intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, <gustavoars@kernel.org>,
        <mliska@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
        <zhangjinhao2@huawei.com>
References: <20210313021540.219748-1-yangjihong1@huawei.com>
 <CAM9d7chGtOjUyD0S-BNtnDbL2A5CW=evhHa4cTg+ApBQOJAQ-w@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <af0db3d1-fd9e-37b5-c86c-b0f628e4fb97@huawei.com>
Date:   Mon, 15 Mar 2021 16:47:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7chGtOjUyD0S-BNtnDbL2A5CW=evhHa4cTg+ApBQOJAQ-w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/3/13 11:06, Namhyung Kim wrote:
> On Sat, Mar 13, 2021 at 11:16 AM Yang Jihong <yangjihong1@huawei.com> wrote:
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
> 
> Looks good.  But I'm not sure about the branch stack mode.
> I suspect we can use the same sort key there.
> 
> Jin Yao, what do you think?
> 
> Thanks,
> Namhyung
> 
Is it changed to the following?
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists 
*hists,
                 } else {
                         hist_entry__tty_annotate(he, evsel, ann);
                         nd = rb_next(nd);
-                       /*
-                        * Since we have a hist_entry per IP for the same
-                        * symbol, free he->ms.sym->src to signal we already
-                        * processed this symbol.
-                        */
-                       zfree(&notes->src->cycles_hist);
-                       zfree(&notes->src);
                 }
         }
  }
@@ -619,6 +612,12 @@ int cmd_annotate(int argc, const char **argv)

         setup_browser(true);

+       /*
+        * Events of different processes may correspond to the same
+        * symbol, we do not care about the processes in annotate,
+        * set sort order to avoid repeated output.
+        */
+       sort_order = "dso,symbol";
         if ((use_browser == 1 || annotate.use_stdio2) && 
annotate.has_br_stack) {
                 sort__mode = SORT_MODE__BRANCH;
                 if (setup_sorting(annotate.session->evlist) < 0)

I think branch stack mode also don't care about the processes.

>> ---
>>   tools/perf/builtin-annotate.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>> index a23ba6bb99b6..ad169e3e2e8f 100644
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
>> @@ -624,6 +617,12 @@ int cmd_annotate(int argc, const char **argv)
>>                  if (setup_sorting(annotate.session->evlist) < 0)
>>                          usage_with_options(annotate_usage, options);
>>          } else {
>> +               /*
>> +                * Events of different processes may correspond to the same
>> +                * symbol, we do not care about the processes in annotate,
>> +                * set sort order to avoid repeated output.
>> +                */
>> +               sort_order = "dso,symbol";
>>                  if (setup_sorting(NULL) < 0)
>>                          usage_with_options(annotate_usage, options);
>>          }
>> --
>> 2.30.GIT
>>
> .
> 

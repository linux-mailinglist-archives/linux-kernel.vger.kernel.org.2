Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B66231E992
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhBRMJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:09:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12977 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhBRKjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:39:55 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dh9cq66QtzjP6f;
        Thu, 18 Feb 2021 18:17:31 +0800 (CST)
Received: from [10.67.102.248] (10.67.102.248) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Feb 2021 18:18:52 +0800
Subject: Re: [PATCH] perf record: Fix continue profiling after draining the
 buffer
From:   Yang Jihong <yangjihong1@huawei.com>
To:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
CC:     <amistry@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <zhangjinhao2@huawei.com>
References: <20210205065001.23252-1-yangjihong1@huawei.com>
 <CAM9d7cgGGWtTkReghATVmMnOd=0dBrghBLgEc9AqT_PF-UP1Rg@mail.gmail.com>
 <YB0h9Gj5lpcuqndo@krava> <f3b56856-6ede-6f48-fd0a-60614070302f@huawei.com>
Message-ID: <bea7d977-3bd6-80f4-ea3c-b8d1c46cbf84@huawei.com>
Date:   Thu, 18 Feb 2021 18:18:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <f3b56856-6ede-6f48-fd0a-60614070302f@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2021/2/7 8:56, Yang Jihong wrote:
> Hello,
> 
> On 2021/2/5 18:46, Jiri Olsa wrote:
>> On Fri, Feb 05, 2021 at 07:35:22PM +0900, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Fri, Feb 5, 2021 at 3:50 PM Yang Jihong <yangjihong1@huawei.com> 
>>> wrote:
>>>>
>>>> commit da231338ec9c098707c8a1e4d8a50e2400e2fe17 uses eventfd to 
>>>> solve rare race
>>>> where the setting and checking of 'done' which add done_fd to pollfd.
>>>> When draining buffer, revents of done_fd is 0 and evlist__filter_pollfd
>>>> function returns a non-zero value.
>>>> As a result, perf record does not stop profiling.
>>>>
>>>> The following simple scenarios can trigger this condition:
>>>>
>>>> sleep 10 &
>>>> perf record -p $!
>>>>
>>>> After the sleep process exits, perf record should stop profiling and 
>>>> exit.
>>>> However, perf record keeps running.
>>>>
>>>> If pollfd revents contains only POLLERR or POLLHUP,
>>>> perf record indicates that buffer is draining and need to stop 
>>>> profiling.
>>>> Use fdarray_flag__nonfilterable to set done eventfd to nonfilterable 
>>>> objects,
>>>> so that evlist__filter_pollfd does not filter and check done eventfd.
>>>>
>>>> Fixes: da231338ec9c (perf record: Use an eventfd to wakeup when done)
>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>>> ---
>>>>   tools/perf/builtin-record.c | 2 +-
>>>>   tools/perf/util/evlist.c    | 8 ++++++++
>>>>   tools/perf/util/evlist.h    | 4 ++++
>>>>   3 files changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>> index fd3911650612..51e593e896ea 100644
>>>> --- a/tools/perf/builtin-record.c
>>>> +++ b/tools/perf/builtin-record.c
>>>> @@ -1663,7 +1663,7 @@ static int __cmd_record(struct record *rec, 
>>>> int argc, const char **argv)
>>>>                  status = -1;
>>>>                  goto out_delete_session;
>>>>          }
>>>> -       err = evlist__add_pollfd(rec->evlist, done_fd);
>>>> +       err = evlist__add_wakeup_eventfd(rec->evlist, done_fd);
>>>>          if (err < 0) {
>>>>                  pr_err("Failed to add wakeup eventfd to poll list\n");
>>>>                  status = err;
>>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>>> index 05363a7247c4..fea4c1e8010d 100644
>>>> --- a/tools/perf/util/evlist.c
>>>> +++ b/tools/perf/util/evlist.c
>>>> @@ -572,6 +572,14 @@ int evlist__filter_pollfd(struct evlist 
>>>> *evlist, short revents_and_mask)
>>>>          return perf_evlist__filter_pollfd(&evlist->core, 
>>>> revents_and_mask);
>>>>   }
>>>>
>>>> +#ifdef HAVE_EVENTFD_SUPPORT
>>>> +int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd)
>>>> +{
>>>> +       return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN,
>>>> +                                      fdarray_flag__nonfilterable);
>>>> +}
>>>> +#endif
>>>
>>> Does it build when HAVE_EVENTFD_SUPPORT is not defined?
>>
>> yea, I was wondering the same.. but it's called only from
>> code within HAVE_EVENTFD_SUPPORT ifdef
>>
>> jirka
>>
>>>
>>> Thanks,
>>> Namhyung
>>>
>>>
> I have tested that if "eventfd" feature is removed from the 
> FEATURE_TESTS_BASIC list in Makefile.feature,
> evlist__add_wakeup_eventfd will not be build.
> 
> Modify as follows:
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 97cbfb31b762..d1603050764a 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -32,7 +32,6 @@ FEATURE_TESTS_BASIC :=                  \
>           backtrace                       \
>           dwarf                           \
>           dwarf_getlocations              \
> -        eventfd                         \
>           fortify-source                  \
>           sync-compare-and-swap           \
>           get_current_dir_name            \
> 
> Thanks,
> Yang
> 
>>>> +
>>>>   int evlist__poll(struct evlist *evlist, int timeout)
>>>>   {
>>>>          return perf_evlist__poll(&evlist->core, timeout);
>>>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>>>> index 1aae75895dea..6d4d62151bc8 100644
>>>> --- a/tools/perf/util/evlist.h
>>>> +++ b/tools/perf/util/evlist.h
>>>> @@ -142,6 +142,10 @@ struct evsel 
>>>> *evlist__find_tracepoint_by_name(struct evlist *evlist, const char
>>>>   int evlist__add_pollfd(struct evlist *evlist, int fd);
>>>>   int evlist__filter_pollfd(struct evlist *evlist, short 
>>>> revents_and_mask);
>>>>
>>>> +#ifdef HAVE_EVENTFD_SUPPORT
>>>> +int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd);
>>>> +#endif
>>>> +
>>>>   int evlist__poll(struct evlist *evlist, int timeout);
>>>>
>>>>   struct evsel *evlist__id2evsel(struct evlist *evlist, u64 id);
>>>> -- 
>>>> 2.17.1
>>>>
>>>
>>
>> .
>>
Do have any other questions about this patch?
Look forward to your review.

Thanks,
Yang

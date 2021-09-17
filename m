Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0598C40F299
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbhIQGuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIQGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:50:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AB7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:48:43 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a15so10952766iot.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PppUlr8h+ZXNlOWBENSEgW/nbP2yttQFw9WG9SOkokQ=;
        b=A2w59X5d0dE6gu5vUFB6tZSqhiuCBadBpx3b7RFL5CVBQRlIYmWvUWqDhnXy4n7UWn
         WebccCzNaaKmxhvZUFNUlG/IYDHtTHh7uNXTh3HcYDuA0IXxJTA4aw+NqKidxnKNoGQi
         BxQNqd0+epDOLM3V8WKnzizinO6TUkxWBfa6xCQNEzljnR9Ca3C8R4c5YNgys8Fz80mR
         zOP08c5tbwoZMe22n9vtsDJ+J4mnxtaKgYbLIic5f4Oa+TFOOJhIffYR90lB2BQni4hh
         tSp5ISPnmEmwM3Bs736LvC2ZAl/1ZyGIETsuN2ehDYAHghLkdaE4mIFzuNXs7Z/DdlHJ
         PFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PppUlr8h+ZXNlOWBENSEgW/nbP2yttQFw9WG9SOkokQ=;
        b=v9a38r2YRyegM2mCuDkzoUrNxOFCohqNQqvGIflfoWuvzLoeMEoe8Yp639sLbKhfhp
         6+bpWJCWoBIgwAhN02EDZrSV7oLtH1hL+NLolQQ64LrapeQHasdVO9zpZa9i776PSVAb
         QnReCJIryKyLoMo82k6RhZM3XGuVqy8Co3jCpOb2880u6JqhkB1sAdD8k5y2qWvA8JKD
         pALgZYP105JcyoaxhoOMFkTaNp2NQYUz7JoSZZ8NQyrq1HdBnP8psRc+09fX9DvsEvak
         YrS/X5bw5u2MvWikAe9zdJxCfuWWuBLbsktuwTqSSTiOBqVJgA7yQlRYk8TuXWJFjxgH
         ALtA==
X-Gm-Message-State: AOAM533w62R/jQUD+r/AbNFIVw0NbheKKP342vZqwjlS7W43HameQok6
        Kd7MQd9KHLx2cqwSQCE9u8CINLQ+l9TQWxWy0F3uww==
X-Google-Smtp-Source: ABdhPJwmiKjCVAi1kY5Po93W/pMoGd6VrjyY0ftPgii59CveLgpUKyTJn6n8mJTDUwycemETvWDZ/hyexgOS8KBz5HQ=
X-Received: by 2002:a05:6638:168a:: with SMTP id f10mr7512862jat.121.1631861322399;
 Thu, 16 Sep 2021 23:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com> <20210909075700.4025355-2-eranian@google.com>
 <20210909190342.GE4323@worktop.programming.kicks-ass.net> <878s04my3b.fsf@mpe.ellerman.id.au>
 <875yv8ms7f.fsf@mpe.ellerman.id.au> <CABPqkBQZ48b51vh1vqafOwVK2tBqYFNFGJT2x-a39Ma0TbS=tA@mail.gmail.com>
 <b21bf42e-377d-36d0-49c3-af1e4edf5496@linux.ibm.com>
In-Reply-To: <b21bf42e-377d-36d0-49c3-af1e4edf5496@linux.ibm.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 16 Sep 2021 23:48:31 -0700
Message-ID: <CABPqkBQvvNQa=hb4OnYqH-f=DJiRWE+bTmv4i+gNvEdoSEHM4w@mail.gmail.com>
Subject: Re: [PATCH v1 01/13] perf/core: add union to struct perf_branch_entry
To:     Madhavan Srinivasan <maddy@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com,
        atrajeev@linux.vnet.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Thanks for fixing this in the perf tool. But what about the struct
branch_entry in the header?


On Thu, Sep 16, 2021 at 11:38 PM Madhavan Srinivasan
<maddy@linux.ibm.com> wrote:
>
>
> On 9/15/21 11:33 AM, Stephane Eranian wrote:
> > Michael,
> >
> >
> > On Fri, Sep 10, 2021 at 7:16 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> Michael Ellerman <mpe@ellerman.id.au> writes:
> >>> Peter Zijlstra <peterz@infradead.org> writes:
> >>>> On Thu, Sep 09, 2021 at 12:56:48AM -0700, Stephane Eranian wrote:
> >>>>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> >>>>> index f92880a15645..eb11f383f4be 100644
> >>>>> --- a/include/uapi/linux/perf_event.h
> >>>>> +++ b/include/uapi/linux/perf_event.h
> >>>>> @@ -1329,13 +1329,18 @@ union perf_mem_data_src {
> >>>>>   struct perf_branch_entry {
> >>>>>      __u64   from;
> >>>>>      __u64   to;
> >>>>> -   __u64   mispred:1,  /* target mispredicted */
> >>>>> -           predicted:1,/* target predicted */
> >>>>> -           in_tx:1,    /* in transaction */
> >>>>> -           abort:1,    /* transaction abort */
> >>>>> -           cycles:16,  /* cycle count to last branch */
> >>>>> -           type:4,     /* branch type */
> >>>>> -           reserved:40;
> >>>>> +   union {
> >>>>> +           __u64   val;        /* to make it easier to clear all fields */
> >>>>> +           struct {
> >>>>> +                   __u64   mispred:1,  /* target mispredicted */
> >>>>> +                           predicted:1,/* target predicted */
> >>>>> +                           in_tx:1,    /* in transaction */
> >>>>> +                           abort:1,    /* transaction abort */
> >>>>> +                           cycles:16,  /* cycle count to last branch */
> >>>>> +                           type:4,     /* branch type */
> >>>>> +                           reserved:40;
> >>>>> +           };
> >>>>> +   };
> >>>>>   };
> >>>>
> >>>> Hurpmh... all other bitfields have ENDIAN_BITFIELD things except this
> >>>> one. Power folks, could you please have a look?
> >>> The bit number of each field changes between big and little endian, but
> >>> as long as kernel and userspace are the same endian, and both only
> >>> access values via the bitfields then it works.
> >> ...
> >>> It does look like we have a bug in perf tool though, if I take a
> >>> perf.data from a big endian system to a little endian one I don't see
> >>> any of the branch flags decoded. eg:
> >>>
> >>> BE:
> >>>
> >>> 2413132652524 0x1db8 [0x2d0]: PERF_RECORD_SAMPLE(IP, 0x1): 5279/5279: 0xc00000000045c028 period: 923003 addr: 0
> >>> ... branch stack: nr:28
> >>> .....  0: c00000000045c028 -> c00000000dce7604 0 cycles  P   0
> >>>
> >>> LE:
> >>>
> >>> 2413132652524 0x1db8 [0x2d0]: PERF_RECORD_SAMPLE(IP, 0x1): 5279/5279: 0xc00000000045c028 period: 923003 addr: 0
> >>> ... branch stack: nr:28
> >>> .....  0: c00000000045c028 -> c00000000dce7604 0 cycles      0
> >>>                                                           ^
> >>>                                                           missing P
> >>>
> >>> I guess we're missing a byte swap somewhere.
> >> Ugh. We _do_ have a byte swap, but we also need a bit swap.
> >>
> >> That works for the single bit fields, not sure if it will for the
> >> multi-bit fields.
> >>
> >> So that's a bit of a mess :/
> >>
> > Based on what I see in perf_event.h for other structures, I think I
> > can make up what you would need for struct branch_entry. But Iit would
> > be easier if you could send me a patch that you would have verified on
> > your systems.
> > Thanks.
> Attached patch fixes the issue. Have tested both in both in BE and LE case.
>
> Maddy
>
>  From f816ba2e6ef8d5975f78442d7ecb50d66c3c4326 Mon Sep 17 00:00:00 2001
> From: Madhavan Srinivasan <maddy@linux.ibm.com>
> Date: Wed, 15 Sep 2021 22:29:09 +0530
> Subject: [RFC PATCH] tools/perf: Add reverse_64b macro
>
> branch_stack struct has bit field definition
> producing different bit ordering for big/little endian.
> Because of this, when branch_stack sample collected
> in a BE system viewed/reported in a LE system,
> bit fields of the branch stack are not presented
> properly. To address this issue, a reverse_64b
> macro is defined and introduced in evsel__parse_sample.
>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>   tools/perf/util/evsel.c | 35 +++++++++++++++++++++++++++++++++--
>   1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbfeceb2546c..3151606e516e 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2221,6 +2221,9 @@ void __weak arch_perf_parse_sample_weight(struct
> perf_sample *data,
>       data->weight = *array;
>   }
>
> +#define reverse_64b(src, pos, size)    \
> +    (((src >> pos) & (( 1ull <<size) - 1)) << (63 - (pos + size - 1)))
> +
>   int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>               struct perf_sample *data)
>   {
> @@ -2408,6 +2411,8 @@ int evsel__parse_sample(struct evsel *evsel, union
> perf_event *event,
>       if (type & PERF_SAMPLE_BRANCH_STACK) {
>           const u64 max_branch_nr = UINT64_MAX /
>                         sizeof(struct branch_entry);
> +        struct branch_entry *e;
> +        unsigned i;
>
>           OVERFLOW_CHECK_u64(array);
>           data->branch_stack = (struct branch_stack *)array++;
> @@ -2416,10 +2421,36 @@ int evsel__parse_sample(struct evsel *evsel,
> union perf_event *event,
>               return -EFAULT;
>
>           sz = data->branch_stack->nr * sizeof(struct branch_entry);
> -        if (evsel__has_branch_hw_idx(evsel))
> +        if (evsel__has_branch_hw_idx(evsel)) {
>               sz += sizeof(u64);
> -        else
> +            e = &data->branch_stack->entries[0];
> +        } else {
>               data->no_hw_idx = true;
> +            e = (struct branch_entry *)&data->branch_stack->hw_idx;
> +        }
> +
> +        if (swapped) {
> +            for (i = 0; i < data->branch_stack->nr; i++, e++) {
> +                u64 new_val = 0;
> +
> +                /* mispred:1  target mispredicted */
> +                new_val = reverse_64b(e->flags.value, 0, 1);
> +                /* predicted:1  target predicted */
> +                new_val |= reverse_64b(e->flags.value, 1, 1);
> +                /* in_tx:1  in transaction */
> +                new_val |= reverse_64b(e->flags.value, 2, 1);
> +                /* abort:1  transaction abort */
> +                new_val |= reverse_64b(e->flags.value, 3, 1);
> +                /* cycles:16  cycle count to last branch */
> +                new_val |= reverse_64b(e->flags.value, 4, 16);
> +                /* type:4  branch type */
> +                new_val |= reverse_64b(e->flags.value, 20, 4);
> +                /* reserved:40 */
> +                new_val |= reverse_64b(e->flags.value, 24, 40);
> +                e->flags.value = new_val;
> +            }
> +        }
> +
>           OVERFLOW_CHECK(array, sz, max_size);
>           array = (void *)array + sz;
>       }
> --
> 2.31.1
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6540C3793F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhEJQfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhEJQey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:34:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF6C061760
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:33:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso11507658wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzsapzwQo1sU7vk4C9wVe0nWjAV2j6bYomVQNz4HZ6o=;
        b=a3Tje2HB5U0LxEiIer9Axrl9nUx26z16do6RZnwmOMPDH1tRxiuF3XF+ooSQNScYl4
         noS7jchno6+selZ+vSze5DkeArY3lI3ZJR/VgUv5yEFUmgfrd6b/qILQcwdCDR5yeGmQ
         oaSdNhEhA94YvjB+SjKpJCNc0s4SEompJ2mjghh7rLnOsF8qAzBR9c4UWIhg/jFoePw6
         VHSQgo0mw/0M1llULFsF9DCvBWwpwdw6pQWQ5JzafR01Ow0k5wqAYC+L25M2EBXshKbK
         5/B8BYAjBjUdG/Ud30REvEsziKdWyyinOskx0qoZG3PAODbdsfMwofPD08aT0VMcG7cO
         O7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzsapzwQo1sU7vk4C9wVe0nWjAV2j6bYomVQNz4HZ6o=;
        b=sJRrsO7JDBQrYS7jAt5iIgJ92Cljaq+1vSDpiDVEexPwWcZ021IbBC4Dw2PgKksX9b
         9NvYhV21eT9XsgG2TNcORsZWS/ti3J553IQnO+eIWYRs/yAd3T6Fnm8EWR75bwV72+F3
         9faav5JxB8ojGj7DwaTAMev/azd1goVA9arYkRr7wq7jeArqx6V1BI76QCRqwQmE+4Kw
         /PICDmBLeNg/b5oKrA4r+6mJLp+ZGFRttBVeyna3dki9BFGi307go42cesgNgJFDuJ13
         +Byq2dnDqa+qHc6ZMU5PpL6wgaLKX+9u+EeOqmNgaTHa2yyeTCLMxRMyk77VTe24C37T
         GCQw==
X-Gm-Message-State: AOAM53313XuBl+z1bbrRMuJr49Da56VQYEmPbcIHwtY9CAk2v8iqrTOi
        1fnt47yVeI41EM1JqYewp/4+E/qh/jXgrZS6s7QhMQ==
X-Google-Smtp-Source: ABdhPJyBqiWlS5Tm5D2XOPtY2dsb1DWHUvY+42X1bfmqrG0F/94UluqLtViC1N78Y8pkK9TE4dlTPaVRq8M13iUqpsM=
X-Received: by 2002:a1c:55ca:: with SMTP id j193mr4438wmb.58.1620664425650;
 Mon, 10 May 2021 09:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210504194329.840964-1-irogers@google.com> <CAL_JsqLUxMOF_AhtDj7KuPmBzax-ZejSC76HNOOTr-Pq5fdj7Q@mail.gmail.com>
In-Reply-To: <CAL_JsqLUxMOF_AhtDj7KuPmBzax-ZejSC76HNOOTr-Pq5fdj7Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 May 2021 09:33:33 -0700
Message-ID: <CAP-5=fWfZXS57aQ2Sf+ycmDnvRpUf_oJfkv1sNzVdpY4PVcOdA@mail.gmail.com>
Subject: Re: [PATCH] libperf test: Silence printf flag warning
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 6:53 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 4, 2021 at 2:43 PM Ian Rogers <irogers@google.com> wrote:
> >
> > __u64 maybe an unsigned long, it may also differ from the format
> > expected by PRIu64. Add a cast to silence the warning:
> >
> > tools/lib/perf/tests/test-evsel.c:176:33: error: format specifies type 'unsigned long long' but the argument has type 'unsigned long' [-Werror,-Wformat]
> >                 __T_VERBOSE("count = %llu\n", end - start);
> >                                      ~~~~     ^~~~~~~~~~~
> >                                      %lu
>
> Which arch/compiler did you hit this? LLVM? Would have been 64-bit
> presumably. I'm wondering how I didn't...
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/tests/test-evsel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> > index 288b5feaefe2..558097bbbfd0 100644
> > --- a/tools/lib/perf/tests/test-evsel.c
> > +++ b/tools/lib/perf/tests/test-evsel.c
> > @@ -173,7 +173,7 @@ static int test_stat_user_read(int event)
> >
> >                 __T("invalid counter data", (end - start) > last);
> >                 last = end - start;
> > -               __T_VERBOSE("count = %llu\n", end - start);
> > +               __T_VERBOSE("count = %llu\n", (unsigned long long)(end - start));
>
> I think I'd either change end/start to uint64_t which matches the
> count struct and use PRIu64, or change them to unsigned long long.

Thanks! I need to dig into this again, I suspect there was a problem
on PowerPC defining s64/u64 to be long int. Perhaps this is happening
by way of a typedef using int64_t but more likely defining
__SANE_USERSPACE_TYPES__ is my fix. The guidance in the kernel on
formatters is pretty clear:
https://www.kernel.org/doc/Documentation/printk-formats.txt
And so I think it is better to fix the type for overall sanity and to drop this.

Thanks,
Ian


> >         }
> >
> >         perf_evsel__munmap(evsel);
> > --
> > 2.31.1.607.g51e8a6a459-goog
> >

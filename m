Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BA1412E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 07:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhIUFHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 01:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIUFHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 01:07:40 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82002C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 22:06:12 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b6so21380389ilv.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 22:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+tfnHMedGZe2TFbLCJcKj8ZBwL3hCr8DyK+pgVSE+4=;
        b=QXWd88y2WJnDIsPwkEYPzcd/JXfLUTRpO318D7yusvGQ4g+wvLNzfnJRIjp42X+5kx
         XgULeZOsCGhbGf9cIoth7WZgA8l/Gsovl3AVZE+shaRppsYL7wOhTjFOPvt47T6mvAYY
         7dkdEzqqqFMaOMAmHIDRy+2ONB2AG+0VMBuGSUKtkTKgTiXU9KlFd/NMXeHM1+UdJe04
         oQYLXfesNaJMFETttGOt2hBodvoBhbqzJRp8Vzblf6t4tN9q9vJOpx20bMavfIFXWm/q
         ETTlnuQvctQIQdSrh5B/3gxFM7I3EKhN2Qs1Mlr0ND95ElQVtA6aPsUKr2kmUiHgL2OV
         IQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+tfnHMedGZe2TFbLCJcKj8ZBwL3hCr8DyK+pgVSE+4=;
        b=bzDF/dXxMbc6Trj038ud/LNWUns9FfVCVTL19rZBa6KVLY1HKFZrjY3rSUKjol1X+x
         12PqbP2aOSFHiUMWpbpcLi7UhTpJI3WBs7yOcMLIL2A9OS2+/HuJTkh8fSHqwblhJlsp
         o631dSndYY+aagAcpODnIjGp46e1PERlxce0njIvphbqm36SE+yX40uCfCY2bMKy6KQ6
         uwrX1Pa9q+4IdvG/zNraZPMNVE2Wfn3WWCSKfz3CLKvnAv0X97EHOXLqyh+BvNSPsRjW
         B4Znup5ZXFYvH1tkQ4ahmFCp01d+SC7GqV/Wk8YC20rKAkog3ulOmibvYxOe9voRGANB
         E0Kw==
X-Gm-Message-State: AOAM533Unzv4AThHIAi0v6AHYZBR+40zVEXXIVn4CXR810pGB90yPNTy
        PlLgGOCU693MHgHBFJQrQ9DUVc03T5YMdPJ1foE9zw==
X-Google-Smtp-Source: ABdhPJzVjEyiyrOobrt+R+WGvly+cwuaGiPLn6fNOPjSS7m+B01J9uyOvXZ6/MYVBQqnlp0AXh1bqUkjqJodsFqW7Ts=
X-Received: by 2002:a92:c605:: with SMTP id p5mr19598295ilm.53.1632200771676;
 Mon, 20 Sep 2021 22:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210916060525.1890638-1-irogers@google.com> <f7bbc59b-794f-2675-a044-1e3a58ad1495@huawei.com>
 <CAP-5=fUAxfHb8fNjpPKthztJhB7Q3yUZucLS-6kKZtq-iNOVoA@mail.gmail.com> <361478a4-98d0-d488-2903-2c859a2c8524@huawei.com>
In-Reply-To: <361478a4-98d0-d488-2903-2c859a2c8524@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Sep 2021 22:05:59 -0700
Message-ID: <CAP-5=fWmGyuqFKc-EMP3rbmTkjZ3MS+YSajGZfeRMc38HS82gw@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Workload test of metric and metricgroups
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, Paul Clarke <pc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 3:00 AM John Garry <john.garry@huawei.com> wrote:
>
> On 17/09/2021 20:16, Ian Rogers wrote:
> > On Thu, Sep 16, 2021 at 12:37 AM John Garry<john.garry@huawei.com>  wrote:
> >> On 16/09/2021 07:05, Ian Rogers wrote:
> >>> Test every metric and metricgroup with 'true' as a workload.
> >>>
> >>> Signed-off-by: Ian Rogers<irogers@google.com>
> >> Reviewed-by: John Garry<john.garry@huawei.com>
> >>
> >> Note that I also had a local test for pmu events:
> >> for e in `$PERF list --raw-dump pmu`; do
> >>     echo "Testing $e"
> >>     result=$($PERF stat -v -e "$e" perf bench internals synthesize)
> >>     if [[ "$result" =~ "$e" ]]; then
> >>       echo "Event not printed: $e"
> >>       exit 1
> >>     fi
> >> done
> >>
> >> Is there any value in upstreaming this? I could not see same already
> >> there. Or else make your new script generic, so that it accepts an
> >> argument whether to test events or metrics or metricgroups
> > It is not easy to make a generic script with the current shell test
> > infrastructure. I made a variant of this test:
> > https://lore.kernel.org/linux-perf-users/20210917184240.2181186-2-irogers@google.com/T/#u
> > For skylake it ran for 1m15s and so it may be too slow. Perhaps we
> > need to add to the test infrastructure with some kind of speed flag.
>
> Hi Ian,
>
> I suggested this before I realized that it would be called from "perf test".
>
> You think that 1m15s could be considered too slow, but I think that it
> could be much slower to now run "perf test" on some other systems. Like
> my arm64 system - see series
> https://lore.kernel.org/linux-perf-users/1631795665-240946-1-git-send-email-john.garry@huawei.com/T/#t
> - where I mention that we have >700 HW PMU events (before applying that
> series to take advantage of the event merging). And each of those events
> would be tested individually - slow...
>
> So firstly maybe a speed or test level flag could be added before we try
> this. Sorry for any inconvenience caused.

Hi John,

I think a flag would be best. I'll look to add a notion of test sizes,
as that mirrors what works well at Google. We can then tag a test as
small, medium, large and default to just say running small and medium
tests.

Thanks,
Ian

> Thanks,
> John

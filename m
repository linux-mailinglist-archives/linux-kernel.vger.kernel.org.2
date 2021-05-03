Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FF037226F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 23:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhECVdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 17:33:39 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:44680 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECVdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 17:33:39 -0400
Received: by mail-lf1-f53.google.com with SMTP id t11so8695860lfl.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 14:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wy+pVY/HMh3ibmFRwFSdZiK5JmS9ohr26f+U0qtuKWM=;
        b=SnJAhoeeeWFZX6ryh6R8Oq6UIpKzyeRaL8krnykod/DHCdpV7VLdgtAxhTZgaTYS4e
         5UPLazLyBnT/TZVYvdt886hmhUygPbE+rabpHWMWGHwkHgUw3DjYBCBpmIk4HiLZkOWE
         mXMKnvDWNXbbTFPcmbtaThzTWNy+LpV11cTH6qwZQ4bN/0WP+a38Vt1E7SNkpnyy35LW
         B+ZsyUrAjfeZnkjftjRDgOaQi7egNMWm3vzOoDYVIrMGhIov6c7nZHxSvDQmcdFWZM07
         EpYYQJ5O4gUCRWc3+G9bQ0u1z8cXmB/ajIhcfyaDERpQ2lu996zWt70QacJwnCAseW2u
         BkEg==
X-Gm-Message-State: AOAM532pLL1MAsvJLUwWOvSU49cjNN0JS6Vm4wb7kkbr1u15o1s7ctTu
        R6YKaf9jHN3gq9OH92mXb4wIM4BykfPsd+HuuzQ=
X-Google-Smtp-Source: ABdhPJymFp8TSv+oe7M85blxmirbskQivRYXN9ePAuq+d2K4BQZaDIZ2DU114DKuH8uWYMrOul4SwH5y2z8MQoGP3uM=
X-Received: by 2002:a05:6512:12c7:: with SMTP id p7mr13486276lfg.494.1620077563265;
 Mon, 03 May 2021 14:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210402094020.28164-1-namhyung@kernel.org> <YGcd/vz3KyOUReOh@kernel.org>
 <CANtFmmo6Wq_u=D89hkfmS8yMtKhk+6pm_4YawpO-6MvS_4noaw@mail.gmail.com>
 <YGiiNDzHIm5oxT9n@kernel.org> <CANtFmmqeBPW7XHAvphw9YpGy74b3T-jfzg1op+9ZyU=YLDLjDg@mail.gmail.com>
In-Reply-To: <CANtFmmqeBPW7XHAvphw9YpGy74b3T-jfzg1op+9ZyU=YLDLjDg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 3 May 2021 14:32:32 -0700
Message-ID: <CAM9d7chSn8E3w21b3ASDt-pzhqBD8_Pm6DH4sgtOJKde7=qXPQ@mail.gmail.com>
Subject: Re: [PATCH] perf record: Disallow -c and -F option at the same time
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

(Adjusting thetop-post)

On Sat, Apr 3, 2021 at 10:35 AM Alexey Alexandrov <aalexand@google.com> wrote:
> On Sat, Apr 3, 2021, 10:13 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>
>> Em Fri, Apr 02, 2021 at 08:25:30PM -0700, Alexey Alexandrov escreveu:
>> > A warning can be missed when the tool is run by some kind of automation.
>> > Backward compatibility aside, I think conflicting flags should result in an
>> > early exit to avoid later surprises.
>>
>> Sure, I agree with you in principle, but having erred out in the past,
>> i.e. in making this be accepted, now making this out of the blue finally
>> be considered what it always should have been considered, an error,
>> feels like an error.
>>
>> I sent this message after merging the change, but before pushing it out
>> publicly I felt some (more) discussion would be in order.
>>
>> Are you sure that potentially breaking existing scripts is ok in this
>> case?
>>
>> Up to you, frankly.
>
> I personally think it's ok to break the existing conflicting usages of these flags because the owners of those invocations need to review and fix them to know what they are doing.
>
> At the same time, this can be a two-step movement: maybe first let's make it an error message that imperatively states the problem and makes it clear that the invocation needs to be fixed, then (after X months) make it an exiting error.

So what do you think?  I can make some changes if you want.
But as it's rare and should be fixed anyway, I think we're good now.

Thanks,
Namhyung

>
>> > wrote:
>> >
>> > > Em Fri, Apr 02, 2021 at 06:40:20PM +0900, Namhyung Kim escreveu:
>> > > > It's confusing which one is effective when the both options are given.
>> > > > The current code happens to use -c in this case but users might not be
>> > > > aware of it.  We can change it to complain about that instead of
>> > > > relying on the implicit priority.
>> > > >
>> > > > Before:
>> > > >   $ perf record -c 111111 -F 99 true
>> > > >   [ perf record: Woken up 1 times to write data ]
>> > > >   [ perf record: Captured and wrote 0.031 MB perf.data (8 samples) ]
>> > > >
>> > > >   $ perf evlist -F
>> > > >   cycles: sample_period=111111
>> > > >
>> > > > After:
>> > > >   $ perf record -c 111111 -F 99 true
>> > > >   cannot set frequency and period at the same time
>> > > >
>> > > > So this change can break existing usages, but I think it's rare to
>> > > > have both options and it'd be better changing them.
>> > >
>> > > Humm, perhaps we can just make that an warning stating that -c is used
>> > > if both are specified?
>> > >
>> > > $ perf record -c 111111 -F 99 true
>> > > Frequency and period can't be used the same time, -c 11111 will be used.
>> > >
>> > > - Arnaldo
>> > >
>> > > > Suggested-by: Alexey Alexandrov <aalexand@google.com>
>> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> > > > ---
>> > > >  tools/perf/util/record.c | 8 +++++++-
>> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
>> > > > index f99852d54b14..43e5b563dee8 100644
>> > > > --- a/tools/perf/util/record.c
>> > > > +++ b/tools/perf/util/record.c
>> > > > @@ -157,9 +157,15 @@ static int get_max_rate(unsigned int *rate)
>> > > >  static int record_opts__config_freq(struct record_opts *opts)
>> > > >  {
>> > > >       bool user_freq = opts->user_freq != UINT_MAX;
>> > > > +     bool user_interval = opts->user_interval != ULLONG_MAX;
>> > > >       unsigned int max_rate;
>> > > >
>> > > > -     if (opts->user_interval != ULLONG_MAX)
>> > > > +     if (user_interval && user_freq) {
>> > > > +             pr_err("cannot set frequency and period at the same
>> > > time\n");
>> > > > +             return -1;
>> > > > +     }
>> > > > +
>> > > > +     if (user_interval)
>> > > >               opts->default_interval = opts->user_interval;
>> > > >       if (user_freq)
>> > > >               opts->freq = opts->user_freq;
>> > > > --
>> > > > 2.31.0.208.g409f899ff0-goog
>> > > >
>> > >
>> > > --
>> > >
>> > > - Arnaldo
>> > >
>>
>> --
>>
>> - Arnaldo

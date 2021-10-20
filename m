Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91145434406
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 06:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhJTEEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 00:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhJTEEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 00:04:34 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503CBC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 21:02:20 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a8so20618786ilj.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 21:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KJFEwUorje8FLlb79ZL0ZwvURLI9xbnmI43eZiaFn0=;
        b=AZ7JocdZbxuhbdylEeL4UeSgGfjXq4HkaE6umxJREGHLJZL15imK/PSGAD0hpfmYnX
         ouCiEAD9wpaQ8Dw55x1J4IF+/C1jUpJroX4jIPH9w4bjr3W1JNb84zsVt56TqLI+G54K
         PPDwA5DMAJKOdAlh1hLouo3g4zGdNjsHQbmBH2ooYTyzH0fdElPY8IOXei2N6B6Tnahh
         OcCWJjnVy+PANTWMJ98O2xM/wA2IWpnGqydb1DIViG04E6gpWCRZdPJen2SaAAy0WAww
         Lw/BFVT3QbaK0lAHs4Xngfi4Pt/kUCxC5fktOHDXcRDJG5PlzzbywX7UKCrcGK+71LlL
         xxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KJFEwUorje8FLlb79ZL0ZwvURLI9xbnmI43eZiaFn0=;
        b=gjUgKynP/7APg7xra8s9cvJ71okWrMu0DrTxZqXFuHXJ2r34DpvJMhkgX5uSw5XqjP
         OzHVz/pbFkAMq/QVboIjm2p6csDVyGakWgIHDrX8cqMN33CYPD+Xwexo4X8fXHI1a1/P
         Xn7G3EQHNBu749Bl0aXVz7yqOBycPvuzbebm3wsj5CTOMGAgDje4gSxkYR+Z/nx7qo2S
         j5S0Z7ux0qYlCmOXcwx+8St3qsjo4IBUXOVv6Onm+cFdWQSW6nAvJJ0lE0xBLN/MvD9s
         8GVVLR05EnfdWW6E2OIj1WxfCF+CaS1P6IdQ7xWpJoEwDDemNfDtpnoChYbclT6IMfEi
         rRKg==
X-Gm-Message-State: AOAM531UwOjMM7TqffqJ2sSBDR32X1iKKZNkLDHfaJunOjPXswE0NGPr
        cKv96NjHx0eRKYjD/8nYbRTOipSFIghCgXuZx31fIGqV
X-Google-Smtp-Source: ABdhPJyHffEazrn0ql2HCZIYoNN3NdARvqkidT1azmDEnyRF2diVNxDN+LPSrMBmMprjzDKHcO7F6CYmK6sE6Cgc/Cs=
X-Received: by 2002:a05:6e02:12e4:: with SMTP id l4mr13804876iln.25.1634702539054;
 Tue, 19 Oct 2021 21:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211010102429.99577-4-laoar.shao@gmail.com> <20211014072707.GA18719@xsang-OptiPlex-9020>
 <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
 <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com> <YW73j66QbG9i0MV+@kernel.org>
In-Reply-To: <YW73j66QbG9i0MV+@kernel.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 20 Oct 2021 12:01:43 +0800
Message-ID: <CALOAHbDxQop8v0yXW+NDxO+7O05Ge1hXi6WVSYh-AqQnRE-hOg@mail.gmail.com>
Subject: Re: [sched.h] 317419b91e: perf-sanity-tests.Parse_sched_tracepoints_fields.fail
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qiang Zhang <qiang.zhang@windriver.com>,
        robdclark <robdclark@chromium.org>,
        christian <christian@brauner.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        bristot <bristot@redhat.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:51 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Oct 14, 2021 at 08:42:05AM -0400, Mathieu Desnoyers escreveu:
> > ----- On Oct 14, 2021, at 5:24 AM, Yafang Shao laoar.shao@gmail.com wrote:
> > > On Thu, Oct 14, 2021 at 3:08 PM kernel test robot <oliver.sang@intel.com> wrote:
> > > That issue is caused by another hardcode 16 ...
>
> > > Seems we should make some change as below,
>
> > > diff --git a/tools/perf/tests/evsel-tp-sched.c
> > > b/tools/perf/tests/evsel-tp-sched.c
> > > index f9e34bd26cf3..401a737b1d85 100644
> > > --- a/tools/perf/tests/evsel-tp-sched.c
> > > +++ b/tools/perf/tests/evsel-tp-sched.c
> > > @@ -42,7 +42,7 @@ int test__perf_evsel__tp_sched_test(struct test
> > > *test __maybe_unused, int subtes
> > >                return -1;
> > >        }
>
> > > -       if (evsel__test_field(evsel, "prev_comm", 16, false))
> > > +       if (evsel__test_field(evsel, "prev_comm", TASK_COMM_LEN, false))
> >
> > tools/perf/tests/* contains userspace test programs. This means it gets the
> > TASK_COMM_LEN from the uapi. The fix you propose won't do any good here.
>
> That specific test is just checking if the parsing is being done as
> expected, i.e. we know beforehand that COMMs have 16 bytes, so the test
> expects that.
>

Right.

> Now that it can have a different size, then the test should accept the
> two sizes as possible and pass if it is 16 or 24.
>
> Like in this patch:
>

Thanks for the suggestion. I will do it as you suggested.

> diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
> index f9e34bd26cf33536..182328f3f7f70e0e 100644
> --- a/tools/perf/tests/evsel-tp-sched.c
> +++ b/tools/perf/tests/evsel-tp-sched.c
> @@ -5,7 +5,7 @@
>  #include "tests.h"
>  #include "debug.h"
>
> -static int evsel__test_field(struct evsel *evsel, const char *name, int size, bool should_be_signed)
> +static int evsel__test_field_alt(struct evsel *evsel, const char *name, int size, int alternate_size, bool should_be_signed)
>  {
>         struct tep_format_field *field = evsel__field(evsel, name);
>         int is_signed;
> @@ -23,15 +23,23 @@ static int evsel__test_field(struct evsel *evsel, const char *name, int size, bo
>                 ret = -1;
>         }
>
> -       if (field->size != size) {
> -               pr_debug("%s: \"%s\" size (%d) should be %d!\n",
> +       if (field->size != size && field->size != alternate_size) {
> +               pr_debug("%s: \"%s\" size (%d) should be %d",
>                          evsel->name, name, field->size, size);
> +               if (alternate_size > 0)
> +                       pr_debug(" or %d", alternate_size);
> +               pr_debug("!\n");
>                 ret = -1;
>         }
>
>         return ret;
>  }
>
> +static int evsel__test_field(struct evsel *evsel, const char *name, int size, bool should_be_signed)
> +{
> +       return evsel__test_field_alt(evsel, name, size, -1, should_be_signed);
> +}
> +
>  int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>         struct evsel *evsel = evsel__newtp("sched", "sched_switch");
> @@ -42,7 +50,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
>                 return -1;
>         }
>
> -       if (evsel__test_field(evsel, "prev_comm", 16, false))
> +       if (evsel__test_field_alt(evsel, "prev_comm", 16, 24, false))
>                 ret = -1;
>
>         if (evsel__test_field(evsel, "prev_pid", 4, true))
> @@ -54,7 +62,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
>         if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
>                 ret = -1;
>
> -       if (evsel__test_field(evsel, "next_comm", 16, false))
> +       if (evsel__test_field_alt(evsel, "next_comm", 16, 24, false))
>                 ret = -1;
>
>         if (evsel__test_field(evsel, "next_pid", 4, true))
> @@ -72,7 +80,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
>                 return -1;
>         }
>
> -       if (evsel__test_field(evsel, "comm", 16, false))
> +       if (evsel__test_field_alt(evsel, "comm", 16, 24, false))
>                 ret = -1;
>
>         if (evsel__test_field(evsel, "pid", 4, true))



-- 
Thanks
Yafang

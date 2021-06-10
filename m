Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10163A3382
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 20:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFJSsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 14:48:45 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34340 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFJSsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:48:43 -0400
Received: by mail-wr1-f49.google.com with SMTP id q5so3418647wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grq5x0Cjb5fTifNMwhlvZcwKbZ6wbhg2QeSMuRahiO4=;
        b=ONBH+mqR9A5FJwmWT2iKn8qnh2Wu4ZvAnlTunGMtohdER4jO4LC5C+ryc85Tn9bdwK
         DVuCHks9wPUkblNJ9Z/Dmr2F1PRVMkIEX4kWrDAc+essGekQYXVAMNr7Ser7m3u6jqPb
         iL9araxfutkLj3yCrvjfEzc3qzLnefi+BvwKkX0lnDkKtVF8hCLRJqv/0uJBwedg+Hxs
         Iqm0WDxw1XqaJglgWwxb8+zhRMJTytiac2GlbNwELGU351yrJM1KGIggMCEU4JHS1P2q
         XLXN+fUh6Vzu1owN7iIQYLMSl9yF9uQYYcBvr5iOw3mFtDMp8MELlxevHl1nld90Ivc1
         AgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grq5x0Cjb5fTifNMwhlvZcwKbZ6wbhg2QeSMuRahiO4=;
        b=nJtokNM7T4dEXCnX1sUsEz4LbL07hLkO4Nv9JH7pozA06C8uTPtXLfL33oDBmO2jV1
         UP422EyMrKPzs+M9pJYxN0xUHz+NB0DnuENfOp9zd1fxsiCayfmKBByPGCAoZBowI/mn
         cnHIPP4Zsg+dTolHMM14txWpzXmioG4yBiQ1lxQmQaxMSrjHD/U8l7XhCRO/XECevGs3
         cFuO+KryaQ7j1RXb8Th+Js0VWfrTY6tbvl1nXyCvOjo+aggFrsXdYklyfeEothhEsKks
         5FfZSK+RcDNc9/++eZ2dV1RTSfhQJhSRf0yELMorz01orX9bwHD0vZ+2h9FnOguzCRDl
         QU9g==
X-Gm-Message-State: AOAM531+LlJNiQnbxJF7plMnw8xu/JdmuO6GjxFHLwU9AT2G4F7Z/dXm
        k+gXNHvZCfsJTKUIx/A35Ta3Fmj+WpsJO9vlT2y5Ezeb5gY31w==
X-Google-Smtp-Source: ABdhPJz1UJiNuR1E46pRJGEcgdtmieLH0ZI/DZwAAcDJD0IJEvDN4P9BQYd+HCG+XODhQgkHKizz9lduOtIbMX9MuZY=
X-Received: by 2002:a5d:4903:: with SMTP id x3mr6693454wrq.376.1623350729533;
 Thu, 10 Jun 2021 11:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <1623335580-187317-1-git-send-email-john.garry@huawei.com> <1623335580-187317-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1623335580-187317-3-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Jun 2021 11:45:17 -0700
Message-ID: <CAP-5=fV3L5HoJrXry5fvjedJG1dksJ7JJfy54YOQcgfPQMn4Og@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf metricgroup: Return error code from metricgroup__add_metric_sys_event_iter()
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 7:37 AM John Garry <john.garry@huawei.com> wrote:
>
> The error code is not set at all in the sys event iter function.
>
> This may lead to an uninitialized value of "ret" in
> metricgroup__add_metric() when no CPU metric is added.
>
> Fix by properly setting the error code.
>
> It is not necessary to init "ret" to 0 in metricgroup__add_metric(), as
> if we have no CPU or sys event metric matching, then "has_match" should
> be 0 and "ret" is set to -EINVAL.
>
> However gcc cannot detect that it may not have been set after the
> map_for_each_metric() loop for CPU metrics, which is strange.
>
> Fixes: be335ec28efa8 ("perf metricgroup: Support adding metrics for system PMUs")
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index c456fdeae06a..d3cf2dee36c8 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1073,16 +1073,18 @@ static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
>
>         ret = add_metric(d->metric_list, pe, d->metric_no_group, &m, NULL, d->ids);
>         if (ret)
> -               return ret;
> +               goto out;
>
>         ret = resolve_metric(d->metric_no_group,
>                                      d->metric_list, NULL, d->ids);
>         if (ret)
> -               return ret;
> +               goto out;
>
>         *(d->has_match) = true;
>
> -       return *d->ret;
> +out:
> +       *(d->ret) = ret;
> +       return ret;
>  }
>
>  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> --
> 2.26.2
>

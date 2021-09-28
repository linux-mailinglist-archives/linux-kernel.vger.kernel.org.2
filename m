Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0CC41B588
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbhI1SBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhI1SBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:01:36 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4626FC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:59:56 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i13so24325911ilm.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BniPafuDoFdlymopELQXkB/zQh7F6LVoUvjWNE/VRg=;
        b=glkMq8CqzAY65V+OfwsRWbZMfrbm5gk2blCTp6HIIduX5J0r1s9yNPz7ULbG20e6TW
         nwe2TsaMYxdv3YxGyKZZT+BqyhO+hIwkGFvXsYrRxwF/bZA8XvYQ95Ax1f3GmffZ2wzw
         QMKk7kYfUteYb7dtrXOW1iFNZ7lxxf/CNN6SayYgUF191WpLw8WXyuWz95lyCm4hNNio
         1O7cVUTfjZtzRriKK6cfo59a/Zwen6v6mHn5tdw8fibVHsu11wOAariYsIKNcXsZs9fj
         CCizVcbfKkS7PteVgyObIKXxeBZHnjKXaQxZsmw2SciE+7EwEHNKrH3LHLXs7SUVmsAo
         PWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BniPafuDoFdlymopELQXkB/zQh7F6LVoUvjWNE/VRg=;
        b=ZbCbz8BhXTureY7F98twpnyT7adsqNdwlhLk3PawYV7rcaFPpcEN7Mxf8dMox1zucW
         6A70DjaZKrPyL5GZN2mbKdN8C0v7fFYzaEHZeXYWlNA0+8981CxnoUoPzMcFCWqh2Xf1
         h7HcLdE1y7Yh6QXuPk44yaXnF9gAQOYWjfc1BrKLNK/6uZLdAycHvlTej4+GR1DqA88C
         wDCB+MwRaccUEdzXHTPUrIBJgomPYORD5P3e8aX5e0EXZYwsJcrNlOt8xIffpYPx9IeW
         rYf7tpC/zK5M/HBqagMrRBrEEXK0tivc5SulYs+UiNbZlzJTeG8ceDf/4+X4+2Hf0DGg
         Ri0w==
X-Gm-Message-State: AOAM5304o/pGxEQrS2aSupO2U6ZM6hKniKL0m9uSEawI86xbCko8pksW
        qpDWLmI7I4Z/XTgrMHeut2Efae18nbw5jQ1QJFTSZw==
X-Google-Smtp-Source: ABdhPJzQriZBhaXa8Nz8rzqkeHFOVtzxDfH7dKuTTCQu8Bb7gYIbKnLCthu8TUtgv0Ac7wqnKtun73U9BkEpVpidxz0=
X-Received: by 2002:a05:6e02:b23:: with SMTP id e3mr5253595ilu.53.1632851995505;
 Tue, 28 Sep 2021 10:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <1631795665-240946-1-git-send-email-john.garry@huawei.com> <1631795665-240946-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1631795665-240946-2-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Sep 2021 10:59:42 -0700
Message-ID: <CAP-5=fVG3_p3Xf3s6FnpSRFwt3+CxitPZwRK0fMbz2t8WZaSEw@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf parse-events: Set numeric term config
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        liuqi115@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 5:39 AM John Garry <john.garry@huawei.com> wrote:
>
> For numeric terms, the config field may be NULL as it is not set from the
> l+y parsing.
>
> Fix by setting the term config from the term type name.
>
> Also fix up the pmu-events test to set the alias strings to set the period
> term properly, and fix up parse-events test to check the term config
> string.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Having this would be very useful with an issue I'm looking into.

Thanks,
Ian

> ---
>  tools/perf/tests/parse-events.c | 8 ++++----
>  tools/perf/tests/pmu-events.c   | 6 +++---
>  tools/perf/util/parse-events.c  | 2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index fd3556cc9ad4..8875e388563e 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -605,7 +605,7 @@ static int test__checkterms_simple(struct list_head *terms)
>         TEST_ASSERT_VAL("wrong type val",
>                         term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>         TEST_ASSERT_VAL("wrong val", term->val.num == 10);
> -       TEST_ASSERT_VAL("wrong config", !term->config);
> +       TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config"));
>
>         /* config1 */
>         term = list_entry(term->list.next, struct parse_events_term, list);
> @@ -614,7 +614,7 @@ static int test__checkterms_simple(struct list_head *terms)
>         TEST_ASSERT_VAL("wrong type val",
>                         term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>         TEST_ASSERT_VAL("wrong val", term->val.num == 1);
> -       TEST_ASSERT_VAL("wrong config", !term->config);
> +       TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config1"));
>
>         /* config2=3 */
>         term = list_entry(term->list.next, struct parse_events_term, list);
> @@ -623,7 +623,7 @@ static int test__checkterms_simple(struct list_head *terms)
>         TEST_ASSERT_VAL("wrong type val",
>                         term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>         TEST_ASSERT_VAL("wrong val", term->val.num == 3);
> -       TEST_ASSERT_VAL("wrong config", !term->config);
> +       TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config2"));
>
>         /* umask=1*/
>         term = list_entry(term->list.next, struct parse_events_term, list);
> @@ -661,7 +661,7 @@ static int test__checkterms_simple(struct list_head *terms)
>         TEST_ASSERT_VAL("wrong type val",
>                         term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
>         TEST_ASSERT_VAL("wrong val", term->val.num == 0xead);
> -       TEST_ASSERT_VAL("wrong config", !term->config);
> +       TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config"));
>         return 0;
>  }
>
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index 43743cf719ef..8c5a6ba1cb14 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -67,7 +67,7 @@ static const struct perf_pmu_test_event segment_reg_loads_any = {
>                 .desc = "Number of segment register loads",
>                 .topic = "other",
>         },
> -       .alias_str = "umask=0x80,(null)=0x30d40,event=0x6",
> +       .alias_str = "umask=0x80,period=0x30d40,event=0x6",
>         .alias_long_desc = "Number of segment register loads",
>  };
>
> @@ -78,7 +78,7 @@ static const struct perf_pmu_test_event dispatch_blocked_any = {
>                 .desc = "Memory cluster signals to block micro-op dispatch for any reason",
>                 .topic = "other",
>         },
> -       .alias_str = "umask=0x20,(null)=0x30d40,event=0x9",
> +       .alias_str = "umask=0x20,period=0x30d40,event=0x9",
>         .alias_long_desc = "Memory cluster signals to block micro-op dispatch for any reason",
>  };
>
> @@ -89,7 +89,7 @@ static const struct perf_pmu_test_event eist_trans = {
>                 .desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
>                 .topic = "other",
>         },
> -       .alias_str = "umask=0,(null)=0x30d40,event=0x3a",
> +       .alias_str = "umask=0,period=0x30d40,event=0x3a",
>         .alias_long_desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
>  };
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 51a2219df601..e10243454e8b 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -3083,7 +3083,7 @@ int parse_events_term__num(struct parse_events_term **term,
>         struct parse_events_term temp = {
>                 .type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
>                 .type_term = type_term,
> -               .config    = config,
> +               .config    = config ? : strdup(config_term_names[type_term]),
>                 .no_value  = no_value,
>                 .err_term  = loc_term ? loc_term->first_column : 0,
>                 .err_val   = loc_val  ? loc_val->first_column  : 0,
> --
> 2.26.2
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC64130D2A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 05:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBCEZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 23:25:43 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:38423 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhBCEZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 23:25:30 -0500
Received: by mail-qk1-f169.google.com with SMTP id d85so22210895qkg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 20:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5QnwwzP+ZxiUM7OSEQXfwAwiVoOC//ciFMpjcbYmjI=;
        b=FX8unhkux/Yn/QMn08fOwCqnQlJcMajtt6B7jss8K7KIVWtmMSVbZ+9QicYpi2JbZL
         Y+GwncZbT/VPfaiUkPvqWfjgGtVGUE/TthcA3dDw+wlrovbJ/sy6D4VrpuuEY9ZfWatz
         whdW5+l3dkkpPigBxw2NQy0GtdS6JDhV/6TN1cOUsG4vhkmr9KP2dD6iRxW7f9QfFcz9
         nWMvsauhN0+MdO2ABvPBVjUh2m1gGCbmyOzOIAynY8aBU1Wex5ptwU5O3M10LiQeV+9N
         4bhjs4auQeHizvfCrjgYJrYI2klwUocGwQLkqfzalEWWlmhD7XgITw9cDr5L3fxuBCkt
         752A==
X-Gm-Message-State: AOAM530z/6N3ixSxy/oDI2+NGbbnr3y5ZZ8c0j3eyd4MwcDNVbf+DtqF
        xv49vJ2xzmfd+H9dO9984qVFv03mU2saaepiXxw=
X-Google-Smtp-Source: ABdhPJy6tPGPYq17HivNNAOrb1cz24k52ABgejXiKYQsglCVgyEkijPizpY6AgncEfmaZVtxPL32lDdazsCpyybNdec=
X-Received: by 2002:a37:aec5:: with SMTP id x188mr995536qke.144.1612326288838;
 Tue, 02 Feb 2021 20:24:48 -0800 (PST)
MIME-Version: 1.0
References: <1611578842-5749-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1611578842-5749-1-git-send-email-john.garry@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 3 Feb 2021 13:24:37 +0900
Message-ID: <CAM9d7ci5f1z0ntfkwj66cUCQDuxy8p1HONtXpYgboNhR9sONuA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add parse-metric memory bandwidth testcase
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxarm@openeuler.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jan 25, 2021 at 9:52 PM John Garry <john.garry@huawei.com> wrote:
>
> Event duration_time in a metric expression requires special handling.
>
> Improve test coverage by including a metric whose expression includes
> duration_time. The actual metric is a copied from the L1D_Cache_Fill_BW
> metric on my broadwell machine.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
> Based on acme perf/core + "perf metricgroup: Fix for metrics containing duration_time"
>
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index ce7be37f0d88..6dc1db1626ad 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -69,6 +69,10 @@ static struct pmu_event pme_test[] = {
>         .metric_expr    = "1/m3",
>         .metric_name    = "M3",
>  },
> +{
> +       .metric_expr    = "64 * l1d.replacement / 1000000000 / duration_time",
> +       .metric_name    = "L1D_Cache_Fill_BW",
> +},
>  {
>         .name   = NULL,
>  }
> @@ -107,6 +111,8 @@ static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
>         evlist__for_each_entry(evlist, evsel) {
>                 count = find_value(evsel->name, vals);
>                 perf_stat__update_shadow_stats(evsel, count, 0, st);
> +               if (!strcmp(evsel->name, "duration_time"))
> +                       update_stats(&walltime_nsecs_stats, count);
>         }
>  }
>
> @@ -321,6 +327,23 @@ static int test_recursion_fail(void)
>         return 0;
>  }
>
> +static int test_memory_bandwidth(void)
> +{
> +       double ratio;
> +       struct value vals[] = {
> +               { .event = "l1d.replacement", .val = 4000000 },
> +               { .event = "duration_time",  .val = 200000000 },
> +               { .event = NULL, },
> +       };
> +
> +       TEST_ASSERT_VAL("failed to compute metric",
> +                       compute_metric("L1D_Cache_Fill_BW", vals, &ratio) == 0);
> +       TEST_ASSERT_VAL("L1D_Cache_Fill_BW, wrong ratio",
> +                       1.28 == ratio);
> +
> +       return 0;
> +}
> +
>  static int test_metric_group(void)
>  {
>         double ratio1, ratio2;
> @@ -353,5 +376,6 @@ int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unu
>         TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
>         TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
>         TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
> +       TEST_ASSERT_VAL("Memory bandwidth", test_memory_bandwidth() == 0);
>         return 0;
>  }
> --
> 2.26.2
>

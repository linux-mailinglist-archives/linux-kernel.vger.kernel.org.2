Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E090352342
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhDAXQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhDAXQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:16:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020E7C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:16:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k8so3286434wrc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMLqjC0gdaV3RVqeeN8XzbIziN7crA38FpXwpss9/J8=;
        b=ZoniSd24oyz2VKvUDlLlv4xHZV6l3/rqBo0mUdfeI5ldQgEWtvIu8dT55UoAoMG0WH
         qkeXWQrT28lVTq5gCq7pVZmrKi7LYqOKNVebO1KYpLW+G9oNeXAqjAEnpI+Fiwszz/QE
         wN0pojOALhNxb8tQA+qgHZs33LmwI0UVgvSOOUq+biS9tyXIPW3MC9dOIfKqD3k9tSu/
         j/M6tOo9g3CJAd6qCPrDK9J8DULRpKmu7wMFh7iT8jnoVZFhA82O/D3uGuyA0BPLPtpz
         cLv/fi0jsgf+Y2WqndEl/tONrQ24Lol4lv7B7imqAvq8BqfZWAr0P5gmLOZZ7Txu5Y/K
         1VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMLqjC0gdaV3RVqeeN8XzbIziN7crA38FpXwpss9/J8=;
        b=AklGFYU8LrPzF5LXtj1pvpNTjUJqaZqXVkUZRjHPWJdszLJJ8/aGdVces/2JFNIqe5
         Q9lMX5sZiRSiD1PeG5ZYjDR/1ASJMmIwrg7An69jBQOO2plKLcu83qNxMWyhK0llh4gr
         FhmuyHQv/7Su8mPB9ojmZxwHaCzEs2HvR2151z+HtDm8T2sQqDzzWCEU0ZwH5aMpSQer
         WZBfgEcs96obtsC0fMRvqySpGiue97+nmlSD8d22Psb/Yf982c344YElBI0bLjqz8OBJ
         7XfQ5Cgs7YouDi+OmiPi+qw5c8xHBcgiGpJSMSV6L0YJ0J+K4jB2TvnMNBdTIUnrUl1l
         PN0A==
X-Gm-Message-State: AOAM530C3v+QpD7Gwrd9I38YcDdIrUKbSa2d+lUecmU2R8o3W9x4oBlU
        uqaicYsaHqi+Er0SRe0UiyqK98DQ+0iJi1KWlP5bfw==
X-Google-Smtp-Source: ABdhPJxNEV7OzDWjincEk/BuSSJWHj+4/cglNS2zKPoAyvqxgP1UxdglRVMEjZIJYRV6jcEaVPs4HfRy2YINa8z/B6o=
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr12161939wry.48.1617319007401;
 Thu, 01 Apr 2021 16:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <1616668398-144648-1-git-send-email-john.garry@huawei.com> <1616668398-144648-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1616668398-144648-2-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 1 Apr 2021 16:16:32 -0700
Message-ID: <CAP-5=fVMfK5-rGtx1QjTLz6AQeGr0ruyxuwC3ADt4kriU9wz0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] perf metricgroup: Make find_metric() public with
 name change
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, linuxarm@huawei.com,
        kajoljain <kjain@linux.ibm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        zhangshaokun@hisilicon.com, Paul Clarke <pc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 3:38 AM John Garry <john.garry@huawei.com> wrote:
>
> Function find_metric() is required for the metric processing in the
> pmu-events testcase, so make it public. Also change the name to include
> "metricgroup".

Would it make more sense as "pmu_events_map__find_metric" ?

Thanks,
Ian

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/util/metricgroup.c | 5 +++--
>  tools/perf/util/metricgroup.h | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 6acb44ad439b..71a13406e0bd 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -900,7 +900,8 @@ static int __add_metric(struct list_head *metric_list,
>                     (match_metric(__pe->metric_group, __metric) ||      \
>                      match_metric(__pe->metric_name, __metric)))
>
> -static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
> +struct pmu_event *metrcgroup_find_metric(const char *metric,
> +                                        struct pmu_events_map *map)
>  {
>         struct pmu_event *pe;
>         int i;
> @@ -985,7 +986,7 @@ static int __resolve_metric(struct metric *m,
>                         struct expr_id *parent;
>                         struct pmu_event *pe;
>
> -                       pe = find_metric(cur->key, map);
> +                       pe = metrcgroup_find_metric(cur->key, map);
>                         if (!pe)
>                                 continue;
>
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index ed1b9392e624..1674c6a36d74 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -44,7 +44,8 @@ int metricgroup__parse_groups(const struct option *opt,
>                               bool metric_no_group,
>                               bool metric_no_merge,
>                               struct rblist *metric_events);
> -
> +struct pmu_event *metrcgroup_find_metric(const char *metric,
> +                                        struct pmu_events_map *map);
>  int metricgroup__parse_groups_test(struct evlist *evlist,
>                                    struct pmu_events_map *map,
>                                    const char *str,
> --
> 2.26.2
>

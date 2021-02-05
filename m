Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620A6310AA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhBELut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhBELr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:47:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC310C0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 03:47:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id t142so3613434wmt.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFNCU2XU32iX8A3ILqgI9PR+yHagckvcg0FtnU2IeQ0=;
        b=heNRMYMQh2iq8hWfyWyI0A9ZNKTpa+VYrgM2Z1v4prdmJfdVsJRzHUTrKH6bXQTUeS
         zG4Rk9iu2jGqlDZ8rWjAlI/n3I72I7X2xVeplLU56srzu6x4tkmwqpppFzRntHNvbf2/
         xMj3Rfj4/5U8rv4kf5PhiMTaK38qu/wKYl7afff6wyqrGluQ+HtrPArKUgPVbTc0pMAv
         GyFW2MzggE8vfo6G2Cube5kDCg5hF3AbL6ux8hgevf4pc+QocTxowSQ6vRXDnYEWgzPv
         54sjPsPvcV1M3xKu9jLdaLGZMMahtDmzlL8Pa09mNiX4jYahgbDhIXPG+WSHrJ8n+kHF
         fsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFNCU2XU32iX8A3ILqgI9PR+yHagckvcg0FtnU2IeQ0=;
        b=JkvwpIVyYtlUUyEOFzs06xG4/bYgoNaVq0q/iktnt0MuWQ2bk7Es6SEOvHmWXFJviu
         o34qgU3zkQBrfoNf8wQ/W3dipnuyG0OfyvbObh0sXpXakMUG5h8bL4bdiVS2tu8TRmN6
         MM0i6nhgOAB+4CRnNjlh9z5dAr9ZlI7fV+JcgiW2qDMEU5I4YDhZ7WUrysev4OOuzDvh
         YIGJ5oFTGsjrljro/euA5iI/c+pz4PIoQ3MVCqW5WmwkGur7ya7KBsdIJn/XbERHYHsV
         98oyJI72f6JM5xh713LmEd+EGC4FGy7fJACufN7KRBII8eDe/vocO/4IIP/jEBcn1S8m
         n8nQ==
X-Gm-Message-State: AOAM533ANc7PEedQe18PKl/xteFzqPIXxuuQpF+cNmL4qDnSNfepnYHm
        VI2jrK2X2nPPRW9zmyc6AGhCUWuBxyWvGwH8mBpqjw==
X-Google-Smtp-Source: ABdhPJzE7brFb8EMlOLAEdcOHH+o66L7EFap41lXV2inN8+KDFQK6IWDq/ciap/uX8en5/uYwZ19hOd4zxRjWF430K8=
X-Received: by 2002:a7b:c856:: with SMTP id c22mr3351417wml.5.1612525634576;
 Fri, 05 Feb 2021 03:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20210202163842.134734-1-leo.yan@linaro.org> <20210202163842.134734-4-leo.yan@linaro.org>
In-Reply-To: <20210202163842.134734-4-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 5 Feb 2021 11:47:04 +0000
Message-ID: <CAJ9a7VjVSZGR8MJQYiKAc_OcV_BmY1YiXqSaGRi=UPkj=iCUew@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] perf cs-etm: Fix bitmap for option
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 at 16:39, Leo Yan <leo.yan@linaro.org> wrote:
>
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> When set option with macros ETM_OPT_CTXTID and ETM_OPT_TS, it wrongly
> takes these two values (14 and 28 prespectively) as bit masks, but
> actually both are the offset for bits.  But this doesn't lead to
> further failure due to the AND logic operation will be always true for
> ETM_OPT_CTXTID / ETM_OPT_TS.
>
> This patch defines new independent macros (rather than using the
> "config" bits) for requesting the "contextid" and "timestamp" for
> cs_etm_set_option().
>
> [leoy: Extract the change as a separate patch for easier review]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index bd446aba64f7..c25c878fd06c 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -156,6 +156,10 @@ static int cs_etm_set_timestamp(struct auxtrace_record *itr,
>         return err;
>  }
>
> +#define ETM_SET_OPT_CTXTID     (1 << 0)
> +#define ETM_SET_OPT_TS         (1 << 1)
> +#define ETM_SET_OPT_MASK       (ETM_SET_OPT_CTXTID | ETM_SET_OPT_TS)
> +
>  static int cs_etm_set_option(struct auxtrace_record *itr,
>                              struct evsel *evsel, u32 option)
>  {
> @@ -169,17 +173,17 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
>                     !cpu_map__has(online_cpus, i))
>                         continue;
>
> -               if (option & ETM_OPT_CTXTID) {
> +               if (option & ETM_SET_OPT_CTXTID) {
>                         err = cs_etm_set_context_id(itr, evsel, i);
>                         if (err)
>                                 goto out;
>                 }
> -               if (option & ETM_OPT_TS) {
> +               if (option & ETM_SET_OPT_TS) {
>                         err = cs_etm_set_timestamp(itr, evsel, i);
>                         if (err)
>                                 goto out;
>                 }
> -               if (option & ~(ETM_OPT_CTXTID | ETM_OPT_TS))
> +               if (option & ~(ETM_SET_OPT_MASK))
>                         /* Nothing else is currently supported */
>                         goto out;
>         }
> @@ -406,7 +410,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>                 evsel__set_sample_bit(cs_etm_evsel, CPU);
>
>                 err = cs_etm_set_option(itr, cs_etm_evsel,
> -                                       ETM_OPT_CTXTID | ETM_OPT_TS);
> +                                       ETM_SET_OPT_CTXTID | ETM_SET_OPT_TS);
>                 if (err)
>                         goto out;
>         }
> --
> 2.25.1
>

Reivewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

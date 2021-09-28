Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0EA41B5A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242175AbhI1SFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242184AbhI1SE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:04:58 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58443C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 11:03:19 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r9so2768230ile.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 11:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rMKGqfvpKADGijyzOO7wsz9YISYB+sEd0g/DKdxxfY=;
        b=rV8huODsmqtc+YwcERseBQLZTTiKFGJS1T3uRfmst8e/cu08T9WDo4yp4LkUHu00Xd
         4FT1ONxxQBjxyaEyGYd1Z1OJz+F9kiXBDHn06ekAn7Ro36twz630tRFyYMXC1+ITLbb+
         +J9SUZOdMvpselY7dL9Yb4/9Imlq4PAMeJ6sLknXGHOMN1S18FdfShaKG39qV58kRSAV
         nZ+em67fr1mVssALhS4EreOHa3JaMsmkIuSutPRigzrPKPkxdkbDKnJUKHbaOkPpnF71
         eiqaPZRKWJlCB+/Xy5/5nx99Vh7XaAJsN5ySvQ+uIr7tOidnK+pTiR43HspPOTevt0SZ
         d10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rMKGqfvpKADGijyzOO7wsz9YISYB+sEd0g/DKdxxfY=;
        b=5lHPJTmIeJEke4SDTUHPJwLYGv/DN57qFOTZJT8uG5FnF0rYy4eIRRUtF9yIY66OJe
         G88evFEXhsNncG/9CuGcKE67k/bGH6K9g/g/jdK8NDU6OL+8wFnxmigzdRixVdkvz4UP
         ALUKRdFKsQHWANTIwPTgPTPQo7jcZvx02LYzGpzisby4331zmOQ5Cn6VoqxsGmtbEG2G
         zbctrLaYeiG42516/m4FVR7v4sBpw/+hKdE3bXRZdrH1S2+ZiUpmK09aAM+ziVoZ4K7N
         FWrRcJVE7EJPXhxXVoQUMOtbaAOIo+E2eyaBXiosLJp6YjPTg5uk/r/EnnBBjfqaGPB0
         C4iQ==
X-Gm-Message-State: AOAM532rXH3mXVimSiawEcPPXnsefDysyP7pBZ5/Zj4OHsNsAbQBETcn
        X2GWOdOCw6ghO76K0uduaBB+mS4EGN6Hw2Txz4Ep0w==
X-Google-Smtp-Source: ABdhPJyGQcrfddYeDyjtTTdGT0OT2E+gKYLkheP4oVW6r3YkFTtPieXnNwPm5IgHSHsN0wYdQ1yzRQjf1MhLmn4lOZA=
X-Received: by 2002:a05:6e02:17ce:: with SMTP id z14mr5295608ilu.89.1632852198617;
 Tue, 28 Sep 2021 11:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <1631795665-240946-1-git-send-email-john.garry@huawei.com> <1631795665-240946-5-git-send-email-john.garry@huawei.com>
In-Reply-To: <1631795665-240946-5-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Sep 2021 11:03:04 -0700
Message-ID: <CAP-5=fVTd5g4=o84Tmo8Y45JDSWOL_RVhwBFCVVzV5HykW=GaQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf test: Add pmu-event test for event described as "config="
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
> Add a new test event for a system event whose event member is in form
> "config=".
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../arch/test/test_soc/sys/uncore.json        |  7 ++++++
>  tools/perf/tests/pmu-events.c                 | 25 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> index 0f681a6e10ea..c7e7528db315 100644
> --- a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> +++ b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
> @@ -6,4 +6,11 @@
>             "Unit": "sys_ddr_pmu",
>             "Compat": "v8"
>     },
> +   {
> +           "BriefDescription": "ccn read-cycles event",
> +           "ConfigCode": "0x2c",
> +           "EventName": "sys_ccn_pmu.read_cycles",
> +           "Unit": "sys_ccn_pmu",
> +           "Compat": "0x01"
> +   }
>  ]
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index adfc17f51c7b..f14266a4c513 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -208,8 +208,23 @@ static const struct perf_pmu_test_event sys_ddr_pmu_write_cycles = {
>         .matching_pmu = "uncore_sys_ddr_pmu",
>  };
>
> +static const struct perf_pmu_test_event sys_ccn_pmu_read_cycles = {
> +       .event = {
> +               .name = "sys_ccn_pmu.read_cycles",
> +               .event = "config=0x2c",
> +               .desc = "ccn read-cycles event. Unit: uncore_sys_ccn_pmu ",
> +               .topic = "uncore",
> +               .pmu = "uncore_sys_ccn_pmu",
> +               .compat = "0x01",
> +       },
> +       .alias_str = "config=0x2c",
> +       .alias_long_desc = "ccn read-cycles event. Unit: uncore_sys_ccn_pmu ",
> +       .matching_pmu = "uncore_sys_ccn_pmu",
> +};
> +
>  static const struct perf_pmu_test_event *sys_events[] = {
>         &sys_ddr_pmu_write_cycles,
> +       &sys_ccn_pmu_read_cycles,
>         NULL
>  };
>
> @@ -677,6 +692,16 @@ static struct perf_pmu_test_pmu test_pmus[] = {
>                         &sys_ddr_pmu_write_cycles,
>                 },
>         },
> +       {
> +               .pmu = {
> +                       .name = (char *)"uncore_sys_ccn_pmu4",
> +                       .is_uncore = 1,
> +                       .id = (char *)"0x01",
> +               },
> +               .aliases = {
> +                       &sys_ccn_pmu_read_cycles,
> +               },
> +       },
>  };
>
>  /* Test that aliases generated are as expected */
> --
> 2.26.2
>

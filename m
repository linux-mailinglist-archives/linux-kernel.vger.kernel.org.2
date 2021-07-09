Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89723C1EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 07:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhGIFeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 01:34:31 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:43999 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhGIFea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 01:34:30 -0400
Received: by mail-lf1-f51.google.com with SMTP id a18so20856425lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 22:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Scm8Di6JePFpAUdXzAcNev5tabtKAMY1kQOx1vWWz7k=;
        b=TGJLFG3fT8dkS+scLq3b8gCu2C0scyCqTC2MehTCJv7gpg0x9GdArgjdDKIeUbDWgn
         vdGcHPL3hgzJhBLIetX8xuZo0bkH0CWKgRJAxD9gCFv8JZX6mIR7mpRNjA6k4HWPafMI
         PLyvQU+ZLuNkvzr0zn61YYzWuoMUDNTdvOlCvIEoEU6XzHtSAutpEznqX5yddGmMmXdb
         kEdgttQr6rBvCGMYVnF7FQLDDkC97eheubdG3oOWAZrs9HRMHPa8jr6usilNFZei9vHy
         /thFDov6zR5/VxLGvhCE9drC53lhuJXQDIm4L60WZNSxwrp2seZfJafkMeOLkvzRLw4G
         DNqg==
X-Gm-Message-State: AOAM533o7TDABjZOzWGpVx+J+6Gvmxay5wMahc24EhyUUkaC7c/+ZC82
        R0916mLW84zaB5YUx8qPhDI7ciViUPGDzoc268Q=
X-Google-Smtp-Source: ABdhPJxrWgZcVXn3LHrD2AOiZvEGMKnPyu1c2TXULFNhtS7gpuoQ0EKgSP3kxlEx84OBvsDjBXOJbXHJ0P7SRMlFb5c=
X-Received: by 2002:ac2:5d4c:: with SMTP id w12mr27746119lfd.494.1625808705449;
 Thu, 08 Jul 2021 22:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <1625760169-18396-1-git-send-email-kan.liang@intel.com>
In-Reply-To: <1625760169-18396-1-git-send-email-kan.liang@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 8 Jul 2021 22:31:34 -0700
Message-ID: <CAM9d7ciuJFpFJC+DSdSg=3VeK_YUgSiWdTE++LZHk4ir6NGLtg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Add Topdown metrics L2 events as default events
To:     "Liang, Kan" <kan.liang@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yao Jin <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

On Thu, Jul 8, 2021 at 9:04 AM <kan.liang@intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The Topdown Microarchitecture Analysis (TMA) Method is a structured
> analysis methodology to identify critical performance bottlenecks in
> out-of-order processors. The Topdown metrics L1 event was added as
> default events in the commit 42641d6f4d15 ("perf stat: Add Topdown
> metrics events as default events"). From the Sapphire Rapids server and
> later platforms, the same dedicated "metrics" register is extended to
> support both L1 and L2 events. Add both L1 and L2 Topdown metrics events
> as default events to enrich the default measuring information, if the
> new measurement register is available. On legacy systems there is no
> change to avoid extra multiplexing.
>
> The topdown_level indicates the max metrics level for the top-down
> statistics. Set it to 2 to display all L1 and L2 Topdown metrics events.
>
> With the patch:
>
>  $ perf stat sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>               0.59 msec task-clock                #    0.001 CPUs utilized
>                  1      context-switches          #    1.687 K/sec
>                  0      cpu-migrations            #    0.000 /sec
>                 76      page-faults               #  128.198 K/sec
>          1,405,318      cycles                    #    2.371 GHz
>          1,471,136      instructions              #    1.05  insn per cycle
>            310,132      branches                  #  523.136 M/sec
>             10,435      branch-misses             #    3.36% of all branches
>          8,431,908      slots                     #   14.223 G/sec
>          1,554,116      topdown-retiring          #     18.4% retiring
>          1,289,585      topdown-bad-spec          #     15.2% bad speculation
>          2,810,636      topdown-fe-bound          #     33.2% frontend bound
>          2,810,636      topdown-be-bound          #     33.2% backend bound
>            231,464      topdown-heavy-ops         #      2.7% heavy operations       #     15.6% light operations
>          1,223,453      topdown-br-mispredict     #     14.5% branch mispredict      #      0.8% machine clears
>          1,884,779      topdown-fetch-lat         #     22.3% fetch latency          #     10.9% fetch bandwidth
>          1,454,917      topdown-mem-bound         #     17.2% memory bound           #     16.0% Core bound
>
>        1.001179699 seconds time elapsed
>
>        0.000000000 seconds user
>        0.001238000 seconds sys
>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/arch/x86/util/evlist.c | 6 +++++-
>  tools/perf/builtin-stat.c         | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 8c6732c..0b09510 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -5,11 +5,15 @@
>  #include "util/parse-events.h"
>
>  #define TOPDOWN_L1_EVENTS      "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
> +#define TOPDOWN_L2_EVENTS      "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
>
>  int arch_evlist__add_default_attrs(struct evlist *evlist)
>  {
>         if (!pmu_have_event("cpu", "slots"))
>                 return 0;
>
> -       return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
> +       if (pmu_have_event("cpu", "topdown-heavy-ops"))
> +               return parse_events(evlist, TOPDOWN_L2_EVENTS, NULL);
> +       else
> +               return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
>  }
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 5a830ae..a5e93d4 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -154,6 +154,8 @@ static const char *topdown_metric_L2_attrs[] = {
>         NULL,
>  };
>
> +#define TOPDOWN_MAX_LEVEL                      2
> +
>  static const char *smi_cost_attrs = {
>         "{"
>         "msr/aperf/,"
> @@ -1924,6 +1926,7 @@ static int add_default_attributes(void)
>                 if (evlist__add_default_attrs(evsel_list, default_attrs1) < 0)
>                         return -1;
>
> +               stat_config.topdown_level = TOPDOWN_MAX_LEVEL;
>                 if (arch_evlist__add_default_attrs(evsel_list) < 0)
>                         return -1;
>         }
> --
> 2.7.4
>

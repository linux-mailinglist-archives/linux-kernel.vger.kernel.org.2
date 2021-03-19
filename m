Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018CD3411DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhCSBBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:01:42 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45590 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhCSBBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:01:17 -0400
Received: by mail-lf1-f53.google.com with SMTP id g8so326790lfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hp5oX9HWBrEWAJ6qY+b7A5Qw9LFyO1zE5W3jPBrWqCo=;
        b=W2LYCGEOtblRlEPFmpwM6+15vfJwhbCqsLJPuYD9wrTausjqKJxTnXKn0zu2q2Gawj
         XHNuV7sMFKoslE3cAz31KfjOmeV8WDYi5AMqgtwPsv06qu0sVPyZjMGjwpdMtOouCDeW
         jjfNefnaOu8wNFhCRhXYEfXBM69rdezqH/4s5Q+EBH9RRVBXRrnECLyzu06bF0H+UGzc
         VKS0ErMKJtht5ITgiW8vlphh8xK7PaDT2zak1uYbfISbWYbcpHd/f581KxucVJi65VOX
         yf5tZZVPx10oF4KfGXtI0AnBkx/3Sr7f6oSFfepFoj7d89pVYP5Fg0YIu2e4t+yqUoNV
         spcg==
X-Gm-Message-State: AOAM532iqABxEk+WOkRXP6cZ434ydiv9yPV86sQ2X66tacCAHgl9fIDO
        rcD6Cb3AigyajlGgM8CPPCBT2O+f9CemvgJYOAg=
X-Google-Smtp-Source: ABdhPJyeHxiqE2OyefUqr+xk1yiMMgQZ1lSnyMxYBW6Z1ViT/4tHVn6sJf+hBTgccddyKvDRokKRUz/k99qbuJCio2E=
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr3632411lfk.509.1616115676137;
 Thu, 18 Mar 2021 18:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210315143047.3867-1-changbin.du@gmail.com>
In-Reply-To: <20210315143047.3867-1-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 19 Mar 2021 10:01:05 +0900
Message-ID: <CAM9d7chiYXb0ZFPuZeRKD4-CV7QYZXR2P29xfWN7SY6B4m53cw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] perf stat: improve readability of shadow stats
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 15, 2021 at 11:31 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This adds function convert_unit_double() and selects appropriate
> unit for shadow stats between K/M/G.
>
> $ sudo ./perf stat -a -- sleep 1
>
> Before: Unit 'M' is selected even the number is very small.
>  Performance counter stats for 'system wide':
>
>           4,003.06 msec cpu-clock                 #    3.998 CPUs utilized
>             16,179      context-switches          #    0.004 M/sec
>                161      cpu-migrations            #    0.040 K/sec
>              4,699      page-faults               #    0.001 M/sec
>      6,135,801,925      cycles                    #    1.533 GHz                      (83.21%)
>      5,783,308,491      stalled-cycles-frontend   #   94.26% frontend cycles idle     (83.21%)
>      4,543,694,050      stalled-cycles-backend    #   74.05% backend cycles idle      (66.49%)
>      4,720,130,587      instructions              #    0.77  insn per cycle
>                                                   #    1.23  stalled cycles per insn  (83.28%)
>        753,848,078      branches                  #  188.318 M/sec                    (83.61%)
>         37,457,747      branch-misses             #    4.97% of all branches          (83.48%)
>
>        1.001283725 seconds time elapsed
>
> After:
> $ sudo ./perf stat -a -- sleep 2
>
>  Performance counter stats for 'system wide':
>
>           8,005.52 msec cpu-clock                 #    3.999 CPUs utilized
>             10,715      context-switches          #    1.338 K/sec
>                785      cpu-migrations            #   98.057 /sec
>                102      page-faults               #   12.741 /sec
>      1,948,202,279      cycles                    #    0.243 GHz
>      2,816,470,932      stalled-cycles-frontend   #  144.57% frontend cycles idle
>      2,661,172,207      stalled-cycles-backend    #  136.60% backend cycles idle
>        464,172,105      instructions              #    0.24  insn per cycle
>                                                   #    6.07  stalled cycles per insn
>         91,567,662      branches                  #   11.438 M/sec
>          7,756,054      branch-misses             #    8.47% of all branches
>
>        2.002040043 seconds time elapsed
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
> v2:
>   o do not change 'sec' to 'cpu-sec'.
>   o use convert_unit_double to implement convert_unit.
> ---
>  tools/perf/util/stat-shadow.c | 16 +++++++---------
>  tools/perf/util/units.c       | 21 ++++++++++++++-------
>  tools/perf/util/units.h       |  1 +
>  3 files changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 6ccf21a72f06..3f800e71126f 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -9,6 +9,7 @@
>  #include "expr.h"
>  #include "metricgroup.h"
>  #include "cgroup.h"
> +#include "units.h"
>  #include <linux/zalloc.h>
>
>  /*
> @@ -1270,18 +1271,15 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>                 generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
>                                 evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
>         } else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
> -               char unit = 'M';
> -               char unit_buf[10];
> +               char unit = ' ';
> +               char unit_buf[10] = "/sec";
>
>                 total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
> -
>                 if (total)
> -                       ratio = 1000.0 * avg / total;
> -               if (ratio < 0.001) {
> -                       ratio *= 1000;
> -                       unit = 'K';
> -               }
> -               snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> +                       ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
> +
> +               if (unit != ' ')
> +                       snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
>                 print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
>         } else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
>                 print_smi_cost(config, cpu, out, st, &rsd);
> diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
> index a46762aec4c9..32c39cfe209b 100644
> --- a/tools/perf/util/units.c
> +++ b/tools/perf/util/units.c
> @@ -33,28 +33,35 @@ unsigned long parse_tag_value(const char *str, struct parse_tag *tags)
>         return (unsigned long) -1;
>  }
>
> -unsigned long convert_unit(unsigned long value, char *unit)
> +double convert_unit_double(double value, char *unit)
>  {
>         *unit = ' ';
>
> -       if (value > 1000) {
> -               value /= 1000;
> +       if (value > 1000.0) {
> +               value /= 1000.0;
>                 *unit = 'K';
>         }
>
> -       if (value > 1000) {
> -               value /= 1000;
> +       if (value > 1000.0) {
> +               value /= 1000.0;
>                 *unit = 'M';
>         }
>
> -       if (value > 1000) {
> -               value /= 1000;
> +       if (value > 1000.0) {
> +               value /= 1000.0;
>                 *unit = 'G';
>         }
>
>         return value;
>  }
>
> +unsigned long convert_unit(unsigned long value, char *unit)
> +{
> +       double v = convert_unit_double((double)value, unit);
> +
> +       return (unsigned long)v;
> +}
> +
>  int unit_number__scnprintf(char *buf, size_t size, u64 n)
>  {
>         char unit[4] = "BKMG";
> diff --git a/tools/perf/util/units.h b/tools/perf/util/units.h
> index 99263b6a23f7..ea43e74e3240 100644
> --- a/tools/perf/util/units.h
> +++ b/tools/perf/util/units.h
> @@ -12,6 +12,7 @@ struct parse_tag {
>
>  unsigned long parse_tag_value(const char *str, struct parse_tag *tags);
>
> +double convert_unit_double(double value, char *unit);
>  unsigned long convert_unit(unsigned long value, char *unit);
>  int unit_number__scnprintf(char *buf, size_t size, u64 n);
>
> --
> 2.25.1
>

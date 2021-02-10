Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601393163AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhBJKWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:22:37 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:43089 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhBJKIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:08:09 -0500
Received: by mail-lj1-f177.google.com with SMTP id a22so1996566ljp.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOXhb5p5qc/pWX9PJYKksGBsyx3asQexyjqEFHuDu7k=;
        b=Amg0o4t/6VSwLvP6zUdJvLvb7LJ5jxW34HH4XFmO77cqCWYEcRUjdCItVQkDujfC9/
         UmyfXLUZrhWEM6xHk15/QT6VqY5t1AmDij1GvnaaW4xIUTyrE54UhI5n44vif/t8LykE
         uMZ8ojblQT8JI8WVyzkVq2B9H3+yuJQOxUdz6n/+5TJQWM0bcXtCKFDRIJh6Lx8zOWo/
         Ui5dYNsLl1NANj5R0fo6dccwEthcfsh2eR9rrmamdT0qbcy+MccR7XTQOKqKcYUc5c0Q
         K/OS3H5zRQUXI4i1plshiMzL6tqfc/TcWEZu5ytuXLP5Jt3YWbz/OyDiNp9ubWE1T3QU
         E6Qg==
X-Gm-Message-State: AOAM531DKjrjCW9LbvK/gAYI0sWIN9NGJUGI/qZlccv1Wgl9XteDvnNL
        a4JMar0ii4uquikiXPCCc4Eu+2owRxpqhiI6xVI=
X-Google-Smtp-Source: ABdhPJycxJS/NhiLucwAA85q0Gh5gWS9F2/aPW+l1ynGyjX77qc5h51icy6TopIi72S4VpK7gdvtCuFwo/b+50hzCV4=
X-Received: by 2002:a2e:b0f3:: with SMTP id h19mr1414141ljl.233.1612951645060;
 Wed, 10 Feb 2021 02:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20210203135830.38568-1-alexander.antonov@linux.intel.com>
 <20210203135830.38568-3-alexander.antonov@linux.intel.com>
 <CAM9d7ci5+Jq6VHvPVSkTCDWRmas4kN483h69kwitn7AEbdSP0w@mail.gmail.com> <6956156b-05ef-4628-52c2-62039946d8ba@linux.intel.com>
In-Reply-To: <6956156b-05ef-4628-52c2-62039946d8ba@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 10 Feb 2021 19:07:13 +0900
Message-ID: <CAM9d7cgqLwcLzr=tGR7pU2PJYNuTkBHCXF+XXaz55Y-LyvQjuQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] perf stat: Basic support for iostat in perf
To:     Alexander Antonov <alexander.antonov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 8:55 PM Alexander Antonov
<alexander.antonov@linux.intel.com> wrote:
>
>
> On 2/4/2021 3:22 PM, Namhyung Kim wrote:
> > On Wed, Feb 3, 2021 at 10:58 PM Alexander Antonov
> > <alexander.antonov@linux.intel.com> wrote:
> >> Add basic flow for a new iostat mode in perf. Mode is intended to
> >> provide four I/O performance metrics per each PCIe root port: Inbound Read,
> >> Inbound Write, Outbound Read, Outbound Write.
> >>
> >> The actual code to compute the metrics and attribute it to
> >> root port is in follow-on patches.
> >>
> >> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
> >> ---
> >>   tools/perf/builtin-stat.c      | 31 ++++++++++++++++++++++++++
> >>   tools/perf/util/iostat.h       | 32 +++++++++++++++++++++++++++
> >>   tools/perf/util/stat-display.c | 40 +++++++++++++++++++++++++++++++++-
> >>   tools/perf/util/stat-shadow.c  | 11 +++++++++-
> >>   tools/perf/util/stat.h         |  1 +
> >>   5 files changed, 113 insertions(+), 2 deletions(-)
> >>   create mode 100644 tools/perf/util/iostat.h
> >>
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index 60fdb6a0805f..66c913692120 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -65,6 +65,7 @@
> >>   #include "util/target.h"
> >>   #include "util/time-utils.h"
> >>   #include "util/top.h"
> >> +#include "util/iostat.h"
> >>   #include "asm/bug.h"
> >>
> >>   #include <linux/time64.h>
> >> @@ -186,6 +187,7 @@ static struct perf_stat_config stat_config = {
> >>          .metric_only_len        = METRIC_ONLY_LEN,
> >>          .walltime_nsecs_stats   = &walltime_nsecs_stats,
> >>          .big_num                = true,
> >> +       .iostat_run             = false,
> >>   };
> >>
> >>   static inline void diff_timespec(struct timespec *r, struct timespec *a,
> >> @@ -723,6 +725,14 @@ static int parse_metric_groups(const struct option *opt,
> >>          return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
> >>   }
> >>
> >> +__weak int iostat_parse(const struct option *opt __maybe_unused,
> >> +                        const char *str __maybe_unused,
> >> +                        int unset __maybe_unused)
> >> +{
> >> +       pr_err("iostat mode is not supported\n");
> >> +       return -1;
> >> +}
> >> +
> >>   static struct option stat_options[] = {
> >>          OPT_BOOLEAN('T', "transaction", &transaction_run,
> >>                      "hardware transaction statistics"),
> >> @@ -803,6 +813,8 @@ static struct option stat_options[] = {
> >>          OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
> >>                       "monitor specified metrics or metric groups (separated by ,)",
> >>                       parse_metric_groups),
> >> +       OPT_CALLBACK_OPTARG(0, "iostat", &evsel_list, &stat_config, "root port",
> >> +                           "measure PCIe metrics per root port", iostat_parse),
> > Can we make the help string and default argument more generic?
> > Something like "measure IO metrics provided by arch/platform"
> > and the default value being "default". :)
> >
> Do you mean using "default" instead of "root port"?
> What about the faceless "I/O unit"? :)

Being a generic command, I cannot expect how it can be used later.
So I'd suggest a more general name.


> >>          OPT_END()
> >>   };
> >>
> >> @@ -1131,6 +1143,12 @@ __weak void arch_topdown_group_warn(void)
> >>   {
> >>   }
> >>
> >> +__weak int iostat_list(struct evlist *evlist __maybe_unused,
> >> +                       struct perf_stat_config *config __maybe_unused)
> >> +{
> >> +       return 0;
> >> +}
> >> +
> >>   /*
> >>    * Add default attributes, if there were no attributes specified or
> >>    * if -d/--detailed, -d -d or -d -d -d is used:
> >> @@ -1682,6 +1700,10 @@ static void setup_system_wide(int forks)
> >>          }
> >>   }
> >>
> >> +__weak void iostat_release(struct evlist *evlist __maybe_unused)
> >> +{
> >> +}
> >> +
> >>   int cmd_stat(int argc, const char **argv)
> >>   {
> >>          const char * const stat_usage[] = {
> >> @@ -1858,6 +1880,12 @@ int cmd_stat(int argc, const char **argv)
> >>                  goto out;
> >>          }
> >>
> >> +       if (stat_config.iostat_run) {
> >> +               status = iostat_list(evsel_list, &stat_config);
> > I think it's unnatural to call iostat_list() unconditionally here.
> > How about this?
> >
> >      status = iostat_prepare(...);
> >      if (status < 0)
> >          goto out;
> >
> >      if (status == IOSTAT_LIST)
> >          iostat_list(...);
> >      else
> >          ...
> I think it's applicable.
> In case of 'list' option we will just print list of root ports and exit.
> Also listing of root ports is available in verbose mode. In this case we
> will
> print list and start the collection.

ok.

> >
> >> +               if (status || !stat_config.iostat_run)
> >> +                       goto out;
> >> +       }
> >> +
> >>          if (add_default_attributes())
> >>                  goto out;
> >>
> >> @@ -2008,6 +2036,9 @@ int cmd_stat(int argc, const char **argv)
> >>          perf_stat__exit_aggr_mode();
> >>          perf_evlist__free_stats(evsel_list);
> >>   out:
> >> +       if (stat_config.iostat_run)
> >> +               iostat_release(evsel_list);
> >> +
> >>          zfree(&stat_config.walltime_run);
> >>
> >>          if (smi_cost && smi_reset)
> >> diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
> >> new file mode 100644
> >> index 000000000000..b34ebedfd5e6
> >> --- /dev/null
> >> +++ b/tools/perf/util/iostat.h
> >> @@ -0,0 +1,32 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * perf iostat
> >> + *
> >> + * Copyright (C) 2020, Intel Corporation
> >> + *
> >> + * Authors: Alexander Antonov <alexander.antonov@linux.intel.com>
> >> + */
> >> +
> >> +#ifndef _IOSTAT_H
> >> +#define _IOSTAT_H
> >> +
> >> +#include <subcmd/parse-options.h>
> >> +#include "util/stat.h"
> >> +#include "util/parse-events.h"
> >> +#include "util/evlist.h"
> >> +
> >> +struct option;
> >> +struct perf_stat_config;
> >> +struct evlist;
> >> +struct timespec;
> >> +
> >> +int iostat_parse(const struct option *opt, const char *str,
> >> +                int unset __maybe_unused);
> >> +void iostat_prefix(struct perf_stat_config *config, struct evlist *evlist,
> >> +                  char *prefix, struct timespec *ts);
> >> +void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
> >> +                        struct perf_stat_output_ctx *out);
> >> +int iostat_list(struct evlist *evlist, struct perf_stat_config *config);
> >> +void iostat_release(struct evlist *evlist);
> >> +
> >> +#endif /* _IOSTAT_H */
> >> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> >> index db1bec115d0b..de78cf6962b9 100644
> >> --- a/tools/perf/util/stat-display.c
> >> +++ b/tools/perf/util/stat-display.c
> >> @@ -16,6 +16,7 @@
> >>   #include <linux/ctype.h>
> >>   #include "cgroup.h"
> >>   #include <api/fs/fs.h>
> >> +#include "iostat.h"
> >>
> >>   #define CNTR_NOT_SUPPORTED     "<not supported>"
> >>   #define CNTR_NOT_COUNTED       "<not counted>"
> >> @@ -302,6 +303,11 @@ static void print_metric_header(struct perf_stat_config *config,
> >>          struct outstate *os = ctx;
> >>          char tbuf[1024];
> >>
> >> +       /* In case of iostat, print metric header for first root port only */
> >> +       if (config->iostat_run &&
> >> +           os->evsel->priv != os->evsel->evlist->selected->priv)
> >> +               return;
> >> +
> >>          if (!valid_only_metric(unit))
> >>                  return;
> >>          unit = fixunit(tbuf, os->evsel, unit);
> >> @@ -936,6 +942,8 @@ static void print_metric_headers(struct perf_stat_config *config,
> >>                          fputs("time,", config->output);
> >>                  fputs(aggr_header_csv[config->aggr_mode], config->output);
> >>          }
> >> +       if (config->iostat_run && !config->interval && !config->csv_output)
> >> +               fprintf(config->output, "   port         ");
> > It's too specific to the current implementation.
> > Let's make it a callback or a weak function.
> Okay,
> This and other similar blocks will be updated.

ok

> >
> >>          /* Print metrics headers only */
> >>          evlist__for_each_entry(evlist, counter) {
> >> @@ -954,6 +962,13 @@ static void print_metric_headers(struct perf_stat_config *config,
> >>          fputc('\n', config->output);
> >>   }
> >>
> >> +__weak void iostat_prefix(struct perf_stat_config *config __maybe_unused,
> >> +                         struct evlist *evlist __maybe_unused,
> >> +                         char *prefix __maybe_unused,
> >> +                         struct timespec *ts __maybe_unused)
> >> +{
> >> +}
> >> +
> >>   static void print_interval(struct perf_stat_config *config,
> >>                             struct evlist *evlist,
> >>                             char *prefix, struct timespec *ts)
> >> @@ -966,7 +981,10 @@ static void print_interval(struct perf_stat_config *config,
> >>          if (config->interval_clear)
> >>                  puts(CONSOLE_CLEAR);
> >>
> >> -       sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
> >> +       if (!config->iostat_run)
> >> +               sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec,
> >> +                                               ts->tv_nsec,
> >> +                                               config->csv_sep);
> >>
> >>          if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
> >>                  switch (config->aggr_mode) {
> >> @@ -996,6 +1014,7 @@ static void print_interval(struct perf_stat_config *config,
> >>                                  fprintf(output, "                  counts %*s events\n", unit_width, "unit");
> >>                          break;
> >>                  case AGGR_PCIE_PORT:
> >> +                       fprintf(output, "#           time    port        ");
> > Ditto.
> >
> >>                          break;
> >>                  case AGGR_GLOBAL:
> >>                  default:
> >> @@ -1174,6 +1193,10 @@ perf_evlist__print_counters(struct evlist *evlist,
> >>          int interval = config->interval;
> >>          struct evsel *counter;
> >>          char buf[64], *prefix = NULL;
> >> +       void *perf_device = NULL;
> >> +
> >> +       if (config->iostat_run)
> >> +               evlist->selected = evlist__first(evlist);
> >>
> >>          if (interval)
> >>                  print_interval(config, evlist, prefix = buf, ts);
> >> @@ -1222,6 +1245,21 @@ perf_evlist__print_counters(struct evlist *evlist,
> >>                  }
> >>                  break;
> >>          case AGGR_PCIE_PORT:
> > Ditto.  Something like iostat_print_counters().
> >
> >> +               counter = evlist__first(evlist);
> >> +               perf_evlist__set_selected(evlist, counter);
> >> +               iostat_prefix(config, evlist, prefix = buf, ts);
> >> +               fprintf(config->output, "%s", prefix);
> >> +               evlist__for_each_entry(evlist, counter) {
> >> +                       perf_device = evlist->selected->priv;
> >> +                       if (perf_device && perf_device != counter->priv) {
> >> +                               perf_evlist__set_selected(evlist, counter);
> >> +                               iostat_prefix(config, evlist, prefix, ts);
> >> +                               fprintf(config->output, "\n%s", prefix);
> >> +                       }
> >> +                       print_counter_aggr(config, counter, prefix);
> > I'm not sure but do you assume each counter has different priv?
> > I don't know if the output is correct (like call iostat_prefix() once
> > and call print_counter_aggr() twice) when they have same one.
> There are 4 counters which are related to single 'priv' field (it's used
> for root
> port object in iostat mode). This means if platform has, for example, 5 root
> ports we will have 20 counters in summary. And print_counter_aggr() will be
> called for each counter.
> I call iostat_prefix() before the loop to print first root port and then
> iostat_prefix() will be called when next counter is related to other
> root port.

Thanks for the explanation.

> >
> >> +                       if ((counter->idx + 1) == evlist->core.nr_entries)
> >> +                               fputc('\n', config->output);
> > Can we just move this out of the loop?
> >
> Yes, you are right, we can. I will update it.

Thanks,
Namhyung


> >
> >
> >> +               }
> >>                  break;
> >>          case AGGR_UNSET:
> >>          default:
> >> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> >> index 2c41d47f6f83..083a450c6dc7 100644
> >> --- a/tools/perf/util/stat-shadow.c
> >> +++ b/tools/perf/util/stat-shadow.c
> >> @@ -9,6 +9,7 @@
> >>   #include "expr.h"
> >>   #include "metricgroup.h"
> >>   #include <linux/zalloc.h>
> >> +#include "iostat.h"
> >>
> >>   /*
> >>    * AGGR_GLOBAL: Use CPU 0
> >> @@ -814,6 +815,12 @@ static void generic_metric(struct perf_stat_config *config,
> >>                  zfree(&pctx.ids[i].name);
> >>   }
> >>
> >> +__weak void iostat_print_metric(struct perf_stat_config *config __maybe_unused,
> >> +                               struct evsel *evsel __maybe_unused,
> >> +                               struct perf_stat_output_ctx *out __maybe_unused)
> >> +{
> >> +}
> >> +
> >>   void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >>                                     struct evsel *evsel,
> >>                                     double avg, int cpu,
> >> @@ -829,7 +836,9 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >>          struct metric_event *me;
> >>          int num = 1;
> >>
> >> -       if (perf_evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
> >> +       if (config->iostat_run) {
> >> +               iostat_print_metric(config, evsel, out);
> >> +       } else if (perf_evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
> >>                  total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
> >>
> >>                  if (total) {
> >> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> >> index c7544c28c02a..c2a2b28effd6 100644
> >> --- a/tools/perf/util/stat.h
> >> +++ b/tools/perf/util/stat.h
> >> @@ -107,6 +107,7 @@ struct perf_stat_config {
> >>          bool                     big_num;
> >>          bool                     no_merge;
> >>          bool                     walltime_run_table;
> >> +       bool                     iostat_run;
> >>          FILE                    *output;
> >>          unsigned int             interval;
> >>          unsigned int             timeout;
> >> --
> >> 2.19.1
> >>

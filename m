Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2931320F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhBHMRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:17:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:48405 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233416AbhBHL56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:57:58 -0500
IronPort-SDR: 9oFXMbFt5hNkDbWVm0BujYb1zk3rCD4HVVEMIfvrOUtLS7nq1Mv6oJhZjQv6rUESUzqNm91kVe
 0vzCfx394yGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="179138967"
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="179138967"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 03:55:53 -0800
IronPort-SDR: bAgLun2K02ZhBhmNEP494v2eYiDrWWPUxXsUoBrmgQkbwTptK0oStP43vahPKx8pKRjhSvU6Co
 OPft3qfoQfBw==
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="395357276"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.226.173]) ([10.249.226.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 03:55:50 -0800
Subject: Re: [PATCH v4 2/5] perf stat: Basic support for iostat in perf
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210203135830.38568-1-alexander.antonov@linux.intel.com>
 <20210203135830.38568-3-alexander.antonov@linux.intel.com>
 <CAM9d7ci5+Jq6VHvPVSkTCDWRmas4kN483h69kwitn7AEbdSP0w@mail.gmail.com>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <6956156b-05ef-4628-52c2-62039946d8ba@linux.intel.com>
Date:   Mon, 8 Feb 2021 14:55:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7ci5+Jq6VHvPVSkTCDWRmas4kN483h69kwitn7AEbdSP0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/4/2021 3:22 PM, Namhyung Kim wrote:
> On Wed, Feb 3, 2021 at 10:58 PM Alexander Antonov
> <alexander.antonov@linux.intel.com> wrote:
>> Add basic flow for a new iostat mode in perf. Mode is intended to
>> provide four I/O performance metrics per each PCIe root port: Inbound Read,
>> Inbound Write, Outbound Read, Outbound Write.
>>
>> The actual code to compute the metrics and attribute it to
>> root port is in follow-on patches.
>>
>> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
>> ---
>>   tools/perf/builtin-stat.c      | 31 ++++++++++++++++++++++++++
>>   tools/perf/util/iostat.h       | 32 +++++++++++++++++++++++++++
>>   tools/perf/util/stat-display.c | 40 +++++++++++++++++++++++++++++++++-
>>   tools/perf/util/stat-shadow.c  | 11 +++++++++-
>>   tools/perf/util/stat.h         |  1 +
>>   5 files changed, 113 insertions(+), 2 deletions(-)
>>   create mode 100644 tools/perf/util/iostat.h
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 60fdb6a0805f..66c913692120 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -65,6 +65,7 @@
>>   #include "util/target.h"
>>   #include "util/time-utils.h"
>>   #include "util/top.h"
>> +#include "util/iostat.h"
>>   #include "asm/bug.h"
>>
>>   #include <linux/time64.h>
>> @@ -186,6 +187,7 @@ static struct perf_stat_config stat_config = {
>>          .metric_only_len        = METRIC_ONLY_LEN,
>>          .walltime_nsecs_stats   = &walltime_nsecs_stats,
>>          .big_num                = true,
>> +       .iostat_run             = false,
>>   };
>>
>>   static inline void diff_timespec(struct timespec *r, struct timespec *a,
>> @@ -723,6 +725,14 @@ static int parse_metric_groups(const struct option *opt,
>>          return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
>>   }
>>
>> +__weak int iostat_parse(const struct option *opt __maybe_unused,
>> +                        const char *str __maybe_unused,
>> +                        int unset __maybe_unused)
>> +{
>> +       pr_err("iostat mode is not supported\n");
>> +       return -1;
>> +}
>> +
>>   static struct option stat_options[] = {
>>          OPT_BOOLEAN('T', "transaction", &transaction_run,
>>                      "hardware transaction statistics"),
>> @@ -803,6 +813,8 @@ static struct option stat_options[] = {
>>          OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
>>                       "monitor specified metrics or metric groups (separated by ,)",
>>                       parse_metric_groups),
>> +       OPT_CALLBACK_OPTARG(0, "iostat", &evsel_list, &stat_config, "root port",
>> +                           "measure PCIe metrics per root port", iostat_parse),
> Can we make the help string and default argument more generic?
> Something like "measure IO metrics provided by arch/platform"
> and the default value being "default". :)
>
Do you mean using "default" instead of "root port"?
What about the faceless "I/O unit"? :)
>>          OPT_END()
>>   };
>>
>> @@ -1131,6 +1143,12 @@ __weak void arch_topdown_group_warn(void)
>>   {
>>   }
>>
>> +__weak int iostat_list(struct evlist *evlist __maybe_unused,
>> +                       struct perf_stat_config *config __maybe_unused)
>> +{
>> +       return 0;
>> +}
>> +
>>   /*
>>    * Add default attributes, if there were no attributes specified or
>>    * if -d/--detailed, -d -d or -d -d -d is used:
>> @@ -1682,6 +1700,10 @@ static void setup_system_wide(int forks)
>>          }
>>   }
>>
>> +__weak void iostat_release(struct evlist *evlist __maybe_unused)
>> +{
>> +}
>> +
>>   int cmd_stat(int argc, const char **argv)
>>   {
>>          const char * const stat_usage[] = {
>> @@ -1858,6 +1880,12 @@ int cmd_stat(int argc, const char **argv)
>>                  goto out;
>>          }
>>
>> +       if (stat_config.iostat_run) {
>> +               status = iostat_list(evsel_list, &stat_config);
> I think it's unnatural to call iostat_list() unconditionally here.
> How about this?
>
>      status = iostat_prepare(...);
>      if (status < 0)
>          goto out;
>
>      if (status == IOSTAT_LIST)
>          iostat_list(...);
>      else
>          ...
I think it's applicable.
In case of 'list' option we will just print list of root ports and exit.
Also listing of root ports is available in verbose mode. In this case we 
will
print list and start the collection.
>
>> +               if (status || !stat_config.iostat_run)
>> +                       goto out;
>> +       }
>> +
>>          if (add_default_attributes())
>>                  goto out;
>>
>> @@ -2008,6 +2036,9 @@ int cmd_stat(int argc, const char **argv)
>>          perf_stat__exit_aggr_mode();
>>          perf_evlist__free_stats(evsel_list);
>>   out:
>> +       if (stat_config.iostat_run)
>> +               iostat_release(evsel_list);
>> +
>>          zfree(&stat_config.walltime_run);
>>
>>          if (smi_cost && smi_reset)
>> diff --git a/tools/perf/util/iostat.h b/tools/perf/util/iostat.h
>> new file mode 100644
>> index 000000000000..b34ebedfd5e6
>> --- /dev/null
>> +++ b/tools/perf/util/iostat.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * perf iostat
>> + *
>> + * Copyright (C) 2020, Intel Corporation
>> + *
>> + * Authors: Alexander Antonov <alexander.antonov@linux.intel.com>
>> + */
>> +
>> +#ifndef _IOSTAT_H
>> +#define _IOSTAT_H
>> +
>> +#include <subcmd/parse-options.h>
>> +#include "util/stat.h"
>> +#include "util/parse-events.h"
>> +#include "util/evlist.h"
>> +
>> +struct option;
>> +struct perf_stat_config;
>> +struct evlist;
>> +struct timespec;
>> +
>> +int iostat_parse(const struct option *opt, const char *str,
>> +                int unset __maybe_unused);
>> +void iostat_prefix(struct perf_stat_config *config, struct evlist *evlist,
>> +                  char *prefix, struct timespec *ts);
>> +void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
>> +                        struct perf_stat_output_ctx *out);
>> +int iostat_list(struct evlist *evlist, struct perf_stat_config *config);
>> +void iostat_release(struct evlist *evlist);
>> +
>> +#endif /* _IOSTAT_H */
>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>> index db1bec115d0b..de78cf6962b9 100644
>> --- a/tools/perf/util/stat-display.c
>> +++ b/tools/perf/util/stat-display.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/ctype.h>
>>   #include "cgroup.h"
>>   #include <api/fs/fs.h>
>> +#include "iostat.h"
>>
>>   #define CNTR_NOT_SUPPORTED     "<not supported>"
>>   #define CNTR_NOT_COUNTED       "<not counted>"
>> @@ -302,6 +303,11 @@ static void print_metric_header(struct perf_stat_config *config,
>>          struct outstate *os = ctx;
>>          char tbuf[1024];
>>
>> +       /* In case of iostat, print metric header for first root port only */
>> +       if (config->iostat_run &&
>> +           os->evsel->priv != os->evsel->evlist->selected->priv)
>> +               return;
>> +
>>          if (!valid_only_metric(unit))
>>                  return;
>>          unit = fixunit(tbuf, os->evsel, unit);
>> @@ -936,6 +942,8 @@ static void print_metric_headers(struct perf_stat_config *config,
>>                          fputs("time,", config->output);
>>                  fputs(aggr_header_csv[config->aggr_mode], config->output);
>>          }
>> +       if (config->iostat_run && !config->interval && !config->csv_output)
>> +               fprintf(config->output, "   port         ");
> It's too specific to the current implementation.
> Let's make it a callback or a weak function.
Okay,
This and other similar blocks will be updated.
>
>>          /* Print metrics headers only */
>>          evlist__for_each_entry(evlist, counter) {
>> @@ -954,6 +962,13 @@ static void print_metric_headers(struct perf_stat_config *config,
>>          fputc('\n', config->output);
>>   }
>>
>> +__weak void iostat_prefix(struct perf_stat_config *config __maybe_unused,
>> +                         struct evlist *evlist __maybe_unused,
>> +                         char *prefix __maybe_unused,
>> +                         struct timespec *ts __maybe_unused)
>> +{
>> +}
>> +
>>   static void print_interval(struct perf_stat_config *config,
>>                             struct evlist *evlist,
>>                             char *prefix, struct timespec *ts)
>> @@ -966,7 +981,10 @@ static void print_interval(struct perf_stat_config *config,
>>          if (config->interval_clear)
>>                  puts(CONSOLE_CLEAR);
>>
>> -       sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
>> +       if (!config->iostat_run)
>> +               sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec,
>> +                                               ts->tv_nsec,
>> +                                               config->csv_sep);
>>
>>          if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
>>                  switch (config->aggr_mode) {
>> @@ -996,6 +1014,7 @@ static void print_interval(struct perf_stat_config *config,
>>                                  fprintf(output, "                  counts %*s events\n", unit_width, "unit");
>>                          break;
>>                  case AGGR_PCIE_PORT:
>> +                       fprintf(output, "#           time    port        ");
> Ditto.
>
>>                          break;
>>                  case AGGR_GLOBAL:
>>                  default:
>> @@ -1174,6 +1193,10 @@ perf_evlist__print_counters(struct evlist *evlist,
>>          int interval = config->interval;
>>          struct evsel *counter;
>>          char buf[64], *prefix = NULL;
>> +       void *perf_device = NULL;
>> +
>> +       if (config->iostat_run)
>> +               evlist->selected = evlist__first(evlist);
>>
>>          if (interval)
>>                  print_interval(config, evlist, prefix = buf, ts);
>> @@ -1222,6 +1245,21 @@ perf_evlist__print_counters(struct evlist *evlist,
>>                  }
>>                  break;
>>          case AGGR_PCIE_PORT:
> Ditto.  Something like iostat_print_counters().
>
>> +               counter = evlist__first(evlist);
>> +               perf_evlist__set_selected(evlist, counter);
>> +               iostat_prefix(config, evlist, prefix = buf, ts);
>> +               fprintf(config->output, "%s", prefix);
>> +               evlist__for_each_entry(evlist, counter) {
>> +                       perf_device = evlist->selected->priv;
>> +                       if (perf_device && perf_device != counter->priv) {
>> +                               perf_evlist__set_selected(evlist, counter);
>> +                               iostat_prefix(config, evlist, prefix, ts);
>> +                               fprintf(config->output, "\n%s", prefix);
>> +                       }
>> +                       print_counter_aggr(config, counter, prefix);
> I'm not sure but do you assume each counter has different priv?
> I don't know if the output is correct (like call iostat_prefix() once
> and call print_counter_aggr() twice) when they have same one.
There are 4 counters which are related to single 'priv' field (it's used 
for root
port object in iostat mode). This means if platform has, for example, 5 root
ports we will have 20 counters in summary. And print_counter_aggr() will be
called for each counter.
I call iostat_prefix() before the loop to print first root port and then
iostat_prefix() will be called when next counter is related to other 
root port.
>
>> +                       if ((counter->idx + 1) == evlist->core.nr_entries)
>> +                               fputc('\n', config->output);
> Can we just move this out of the loop?
>
Yes, you are right, we can. I will update it.

Thank you,
Alexander
>
>
>> +               }
>>                  break;
>>          case AGGR_UNSET:
>>          default:
>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
>> index 2c41d47f6f83..083a450c6dc7 100644
>> --- a/tools/perf/util/stat-shadow.c
>> +++ b/tools/perf/util/stat-shadow.c
>> @@ -9,6 +9,7 @@
>>   #include "expr.h"
>>   #include "metricgroup.h"
>>   #include <linux/zalloc.h>
>> +#include "iostat.h"
>>
>>   /*
>>    * AGGR_GLOBAL: Use CPU 0
>> @@ -814,6 +815,12 @@ static void generic_metric(struct perf_stat_config *config,
>>                  zfree(&pctx.ids[i].name);
>>   }
>>
>> +__weak void iostat_print_metric(struct perf_stat_config *config __maybe_unused,
>> +                               struct evsel *evsel __maybe_unused,
>> +                               struct perf_stat_output_ctx *out __maybe_unused)
>> +{
>> +}
>> +
>>   void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>>                                     struct evsel *evsel,
>>                                     double avg, int cpu,
>> @@ -829,7 +836,9 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>>          struct metric_event *me;
>>          int num = 1;
>>
>> -       if (perf_evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
>> +       if (config->iostat_run) {
>> +               iostat_print_metric(config, evsel, out);
>> +       } else if (perf_evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
>>                  total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
>>
>>                  if (total) {
>> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
>> index c7544c28c02a..c2a2b28effd6 100644
>> --- a/tools/perf/util/stat.h
>> +++ b/tools/perf/util/stat.h
>> @@ -107,6 +107,7 @@ struct perf_stat_config {
>>          bool                     big_num;
>>          bool                     no_merge;
>>          bool                     walltime_run_table;
>> +       bool                     iostat_run;
>>          FILE                    *output;
>>          unsigned int             interval;
>>          unsigned int             timeout;
>> --
>> 2.19.1
>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014F33054DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhA0Hmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:42:42 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:32864 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbhA0Hiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:38:51 -0500
Received: by mail-lf1-f44.google.com with SMTP id b2so1336129lfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 23:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezWwTV1FnM+L0u7wKXSfslLFz/62TL+jV5C7HliRjgE=;
        b=L+6ygur2VdGrB77/UJhX/PSEFKFLF67EFDLLPGzZt+z4Ld7EvIovn/d7pFIeqzCx6S
         XbiKxMJX8gPbqF76rFW04blTKrH4taXqwpl6t+dgJ8dLKyNgy7HB4HQh4EUbDFJC7zL7
         I0651lpfOpWvpRgSN0D10S1ow0ZC0/DZhRxPwYbNYjT/n+9hyfyWnLkk56IfSt6BWl1v
         qcPFr3prfy+MoSu4R1yPiJWYXJEpk1E/JNzq3/QUAYoN7Kii+l7nl9kHmsqG8ToN4QQs
         hvG5En6rQHHsDwO+Vx8vmG4kDvXYVT/15ASgVeNsfRPr+cfjPF6p0jL0DF+ArXYlQY7J
         nNpg==
X-Gm-Message-State: AOAM533Rgk2FUEywGUHOaK0ITJEDELINFE/9OzhrWnFmXktlWVKoCTzj
        SUh8QYlS0Kj8anh7/6jZhj4iXwz3dXAqBi6/D3w=
X-Google-Smtp-Source: ABdhPJyIflbtmzjnJI1eAiWARoCJMq/wR69iPUNLzcv+u4lsZWyvISTS9qXp94cZkHxEUS3WNyMYEUUy5etfod3Xrzo=
X-Received: by 2002:a05:6512:a8b:: with SMTP id m11mr4429110lfu.112.1611733082856;
 Tue, 26 Jan 2021 23:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20210116011920.34487-1-cuibixuan@huawei.com> <20210116011920.34487-2-cuibixuan@huawei.com>
In-Reply-To: <20210116011920.34487-2-cuibixuan@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Jan 2021 16:37:51 +0900
Message-ID: <CAM9d7cgPpeCyjd2Z3Ld6yya7BCE3KxVg0P4xeF2gDZ0Y5mw2HQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf tools: add 'perf irq' to measure the hardware interrupts
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        john.wanghui@huawei.com, Alexei Budankov <abudankov@huawei.com>,
        yz.yuzhou@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Jan 16, 2021 at 10:20 AM Bixuan Cui <cuibixuan@huawei.com> wrote:
>
> Add 'perf irq' to trace/measure the hardware interrupts.
>
> Now three functions are provided:
>   1. 'perf irq record <command>' to record the irq handler events.
>   2. 'perf irq script' to see a detailed trace of the workload that
>    was recorded.
>   3. 'perf irq report' to calculate the time consumed by each
>    hardware interrupt processing function.
>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  tools/perf/Build         |   1 +
>  tools/perf/builtin-irq.c | 283 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/builtin.h     |   1 +
>  tools/perf/perf.c        |   1 +
>  4 files changed, 286 insertions(+)
>  create mode 100644 tools/perf/builtin-irq.c
>
> diff --git a/tools/perf/Build b/tools/perf/Build
> index 5f392dbb88fc..d52a1e1d6d8a 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -24,6 +24,7 @@ perf-y += builtin-mem.o
>  perf-y += builtin-data.o
>  perf-y += builtin-version.o
>  perf-y += builtin-c2c.o
> +perf-y += builtin-irq.o
>
>  perf-$(CONFIG_TRACE) += builtin-trace.o
>  perf-$(CONFIG_LIBELF) += builtin-probe.o
> diff --git a/tools/perf/builtin-irq.c b/tools/perf/builtin-irq.c
> new file mode 100644
> index 000000000000..25ba0669a875
> --- /dev/null
> +++ b/tools/perf/builtin-irq.c
[SNIP]
> +
> +#define IRQ_NAME_LEN           20
> +#define MAX_CPUS               4096
> +
> +static const char *cpu_list;
> +static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> +
> +struct perf_irq;

Seems unnecessary.

> +
> +struct perf_irq {
> +       struct perf_tool tool;
> +       bool force;
> +
> +       u32 irq_entry_irq;
> +       char irq_name[IRQ_NAME_LEN];
> +       u32 cpu;
> +       u64 irq_entry_time;
> +       u32 irq_entry_pid;
> +       u32 irq_exit_irq;
> +       u64 irq_exit_time;
> +       u32 irq_exit_pid;
> +};
> +
> +typedef int (*irq_handler)(struct perf_tool *tool,
> +                         union perf_event *event,
> +                         struct evsel *evsel,
> +                         struct perf_sample *sample,
> +                         struct machine *machine);

You don't need to pass all the arguments if unused.

> +
> +static int perf_report_process_sample(struct perf_tool *tool,
> +                                        union perf_event *event,
> +                                        struct perf_sample *sample,
> +                                        struct evsel *evsel,
> +                                        struct machine *machine)
> +{
> +       int err = 0;
> +
> +       if (evsel->handler != NULL) {
> +               irq_handler f = evsel->handler;
> +               err = f(tool, event, evsel, sample, machine);
> +       }
> +
> +       return err;
> +}
> +
> +static void output_report(struct perf_irq *irq)
> +{
> +       int ret, i;
> +       char irq_entry_time[30], irq_exit_time[30], irq_diff[30];
> +
> +       /* The entry and exit of the hardware irq function
> +        * exist at the same time. Check it by irq and pid.
> +        */
> +       if (irq->irq_entry_pid != irq->irq_exit_pid ||
> +           irq->irq_entry_irq != irq->irq_exit_irq)
> +               return;

Is there only a single instance of the perf_irq here?
Then I don't think this is correct and you should keep
pairs of irq entry/exit per cpu.  Otherwise overlapped
irqs from different cpus will be discarded (wrongly).

> +
> +       timestamp__scnprintf_usec(irq->irq_entry_time,
> +                                 irq_entry_time, sizeof(irq_entry_time));
> +       timestamp__scnprintf_usec(irq->irq_exit_time,
> +                                 irq_exit_time, sizeof(irq_exit_time));
> +       timestamp__scnprintf_usec(irq->irq_exit_time - irq->irq_entry_time,
> +                                 irq_diff, sizeof(irq_diff));
> +
> +       ret = printf("   %s ", irq->irq_name);
> +       for (i = 0; i < IRQ_NAME_LEN - ret; i++)
> +               printf(" ");
> +
> +       printf("| [%04d] | %13s s | %16s s | %16s s\n",
> +               irq->cpu, irq_diff, irq_entry_time, irq_exit_time);
> +}
> +
> +static int report_irq_handler_entry_event(struct perf_tool *tool,
> +                                     union perf_event *event __maybe_unused,
> +                                     struct evsel *evsel,
> +                                     struct perf_sample *sample,
> +                                     struct machine *machine __maybe_unused)
> +{
> +       int err = 0;
> +       struct perf_irq *irq = container_of(tool, struct perf_irq, tool);
> +
> +       const char *name = evsel__strval(evsel, sample, "name");
> +
> +       irq->irq_entry_pid = evsel__intval(evsel, sample, "pid");
> +       irq->irq_entry_irq = evsel__intval(evsel, sample, "irq");
> +       irq->irq_entry_time = sample->time;
> +       strncpy(irq->irq_name, name, IRQ_NAME_LEN);

Note that strncpy doesn't guarantee the NUL-termination.
You'd better do it by yourself just in case.

Thanks,
Namhyung

> +
> +       return err;
> +}
> +
> +static int report_irq_handler_exit_event(struct perf_tool *tool,
> +                                     union perf_event *event __maybe_unused,
> +                                     struct evsel *evsel,
> +                                     struct perf_sample *sample,
> +                                     struct machine *machine __maybe_unused)
> +{
> +       int err = 0;
> +       struct perf_irq *irq = container_of(tool, struct perf_irq, tool);
> +
> +       irq->irq_exit_pid = evsel__intval(evsel, sample, "pid");
> +       irq->irq_exit_irq = evsel__intval(evsel, sample, "irq");
> +       irq->irq_exit_time = sample->time;
> +       irq->cpu = sample->cpu;
> +
> +       if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +               return err;
> +
> +       output_report(irq);
> +
> +       return err;
> +}
> +

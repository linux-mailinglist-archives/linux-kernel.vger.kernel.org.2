Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B00C36313F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 18:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhDQQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 12:45:58 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:45629 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhDQQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 12:45:56 -0400
Received: by mail-lf1-f54.google.com with SMTP id g8so49540707lfv.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhJSGZmpNx5jBu9CMjAiuU9xFj9Z6kR4mCfZ11bsQVU=;
        b=BtJBbbwrfyn5FEDvi2JmqIQSKdKzoV7G+b0yiuzwmLlAAZqP2A7r5o6BdEwQ8h4t31
         LrmdsXKHEYk5JH8/Lsxi+Zo8MZoNTKsdQn/xpW+0Mjks3lrriRt3gprxPK1T46FmH4Gz
         CeypQRrhOu5b+U2ILoN/95Ie0jAvikVcqgn0K/0y9zbPrr2H59wtCsbi9fJVBnXQHhhw
         Og5x/l/ktzrBxfGv/4lsOloKJw9kpOCP4+Ib/4+XM3M2OYtbhSK1NV4WIZY/WH0waNcJ
         tJjyKUdpdGXEcotpXnD6o78+IL+f0suCrdRNkV4BhFp33Ac++3OrnP0t0CnH/LS1j44C
         S3Jg==
X-Gm-Message-State: AOAM530xtDsY0wgLTSGOVaKhHdSKhogfXnxq31RE/NlApqLsFWkQRQUC
        LUROvW4wbfZ8BjvJrx/Owq0+yO0UVusGXhk1uJY=
X-Google-Smtp-Source: ABdhPJyPW2R6w8xAUypp06rfrvNohQLjj2/Rft9/OaubFZEPsLEECoWkamNNlObYO2FxEEFtRSHGQ/H1ffXi6ys2wNM=
X-Received: by 2002:a05:6512:3d8d:: with SMTP id k13mr6827933lfv.494.1618677929311;
 Sat, 17 Apr 2021 09:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210416221325.2373497-1-song@kernel.org> <20210416221325.2373497-4-song@kernel.org>
In-Reply-To: <20210416221325.2373497-4-song@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 18 Apr 2021 01:45:18 +0900
Message-ID: <CAM9d7ciVj+d=Bgqmwu+v9mA1CGTbtr8pfXzgNKJs0Nh3BJtt8A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] perf-stat: introduce config stat.bpf-counter-events
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Sat, Apr 17, 2021 at 7:13 AM Song Liu <song@kernel.org> wrote:
>
> Currently, to use BPF to aggregate perf event counters, the user uses
> --bpf-counters option. Enable "use bpf by default" events with a config
> option, stat.bpf-counter-events. Events with name in the option will use
> BPF.
>
> This also enables mixed BPF event and regular event in the same sesssion.
> For example:
>
>    perf config stat.bpf-counter-events=instructions
>    perf stat -e instructions,cs
>
> The second command will use BPF for "instructions" but not "cs".
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
> @@ -535,12 +549,13 @@ static int enable_counters(void)
>         struct evsel *evsel;
>         int err;
>
> -       if (target__has_bpf(&target)) {
> -               evlist__for_each_entry(evsel_list, evsel) {
> -                       err = bpf_counter__enable(evsel);
> -                       if (err)
> -                               return err;
> -               }
> +       evlist__for_each_entry(evsel_list, evsel) {
> +               if (!evsel__is_bpf(evsel))
> +                       continue;
> +
> +               err = bpf_counter__enable(evsel);
> +               if (err)
> +                       return err;

I just realized it doesn't have a disable counterpart.

>         }
>
>         if (stat_config.initial_delay < 0) {
> @@ -784,11 +799,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>         if (affinity__setup(&affinity) < 0)
>                 return -1;
>
> -       if (target__has_bpf(&target)) {
> -               evlist__for_each_entry(evsel_list, counter) {
> -                       if (bpf_counter__load(counter, &target))
> -                               return -1;
> -               }
> +       evlist__for_each_entry(evsel_list, counter) {
> +               if (bpf_counter__load(counter, &target))
> +                       return -1;
>         }
>
>         evlist__for_each_cpu (evsel_list, i, cpu) {

[SNIP]
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2d2614eeaa20e..080ddcfefbcd2 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -492,6 +492,28 @@ const char *evsel__hw_names[PERF_COUNT_HW_MAX] = {
>         "ref-cycles",
>  };
>
> +char *evsel__bpf_counter_events;
> +
> +bool evsel__match_bpf_counter_events(const char *name)
> +{
> +       int name_len;
> +       bool match;
> +       char *ptr;
> +
> +       if (!evsel__bpf_counter_events)
> +               return false;
> +
> +       ptr = strstr(evsel__bpf_counter_events, name);
> +       name_len = strlen(name);
> +
> +       /* check name matches a full token in evsel__bpf_counter_events */
> +       match = (ptr != NULL) &&
> +               ((ptr == evsel__bpf_counter_events) || (*(ptr - 1) == ',')) &&
> +               ((*(ptr + name_len) == ',') || (*(ptr + name_len) == '\0'));

I'm not sure we have an event name which is a substring of another.
Maybe it can retry if it fails to match.

Thanks,
Namhyung

> +
> +       return match;
> +}
> +
>  static const char *__evsel__hw_name(u64 config)
>  {
>         if (config < PERF_COUNT_HW_MAX && evsel__hw_names[config])

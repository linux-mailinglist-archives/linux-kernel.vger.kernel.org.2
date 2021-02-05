Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51A31094B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhBEKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:39:23 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:39325 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhBEKgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:36:16 -0500
Received: by mail-lf1-f54.google.com with SMTP id h7so9180135lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6k/aNvuF++mqp+wzBrO3d6/1JtXcTUsmGTcoFLzD7s=;
        b=MmcCptwWE2QnnWElP9+5z5HBWVFq3yWSHy+QEq0FjYtobxjfIOzbzxd4ueLdmRjPV+
         21IaiCt+xszMQb71k/WA6RsNMNUMu9IK2oUDt0sREgVVv4ZZmhzv4+DBQm94jNlnt9YK
         JO994Audgwha9NK43A+kOyWSR3UwCAXdd9CgJs7cyLlxdxaRH+fwgifEcZLp701n8oi0
         kUHVgWUvhsx8yZPpfM2bDORblnXMgJ/czyqFBL3E0fcnslPBc5XIiaaZKdC8jO5AyXWB
         V1rsQuWn8GLflfL5YNk7Ma46KNMJgkxGYiItYQlUkFhZ4yo9CCgg990cJK0EJ/TGekPj
         9Itw==
X-Gm-Message-State: AOAM5303YHCDtCc7rG/LVsx+v//sS9tz2/59v3VThcSAC0dF/ntgdTMj
        HznKJD+Tw1QeiFamiC8gXGEFiYksUJuQ3dvkgqY=
X-Google-Smtp-Source: ABdhPJwmZ4xla/TZQJhXnZFnA2IUpTxnWCjmcQGQbl2Ec8RoS5Ch6+j3XGGVolwHY1I5HPB+rSIior/+Qnij3E/BlOo=
X-Received: by 2002:a19:d611:: with SMTP id n17mr2304130lfg.494.1612521333936;
 Fri, 05 Feb 2021 02:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20210205065001.23252-1-yangjihong1@huawei.com>
In-Reply-To: <20210205065001.23252-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 Feb 2021 19:35:22 +0900
Message-ID: <CAM9d7cgGGWtTkReghATVmMnOd=0dBrghBLgEc9AqT_PF-UP1Rg@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix continue profiling after draining the buffer
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     amistry@google.com,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhangjinhao2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Feb 5, 2021 at 3:50 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> commit da231338ec9c098707c8a1e4d8a50e2400e2fe17 uses eventfd to solve rare race
> where the setting and checking of 'done' which add done_fd to pollfd.
> When draining buffer, revents of done_fd is 0 and evlist__filter_pollfd
> function returns a non-zero value.
> As a result, perf record does not stop profiling.
>
> The following simple scenarios can trigger this condition:
>
> sleep 10 &
> perf record -p $!
>
> After the sleep process exits, perf record should stop profiling and exit.
> However, perf record keeps running.
>
> If pollfd revents contains only POLLERR or POLLHUP,
> perf record indicates that buffer is draining and need to stop profiling.
> Use fdarray_flag__nonfilterable to set done eventfd to nonfilterable objects,
> so that evlist__filter_pollfd does not filter and check done eventfd.
>
> Fixes: da231338ec9c (perf record: Use an eventfd to wakeup when done)
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-record.c | 2 +-
>  tools/perf/util/evlist.c    | 8 ++++++++
>  tools/perf/util/evlist.h    | 4 ++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index fd3911650612..51e593e896ea 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1663,7 +1663,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>                 status = -1;
>                 goto out_delete_session;
>         }
> -       err = evlist__add_pollfd(rec->evlist, done_fd);
> +       err = evlist__add_wakeup_eventfd(rec->evlist, done_fd);
>         if (err < 0) {
>                 pr_err("Failed to add wakeup eventfd to poll list\n");
>                 status = err;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 05363a7247c4..fea4c1e8010d 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -572,6 +572,14 @@ int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
>         return perf_evlist__filter_pollfd(&evlist->core, revents_and_mask);
>  }
>
> +#ifdef HAVE_EVENTFD_SUPPORT
> +int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd)
> +{
> +       return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN,
> +                                      fdarray_flag__nonfilterable);
> +}
> +#endif

Does it build when HAVE_EVENTFD_SUPPORT is not defined?

Thanks,
Namhyung


> +
>  int evlist__poll(struct evlist *evlist, int timeout)
>  {
>         return perf_evlist__poll(&evlist->core, timeout);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 1aae75895dea..6d4d62151bc8 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -142,6 +142,10 @@ struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char
>  int evlist__add_pollfd(struct evlist *evlist, int fd);
>  int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
>
> +#ifdef HAVE_EVENTFD_SUPPORT
> +int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd);
> +#endif
> +
>  int evlist__poll(struct evlist *evlist, int timeout);
>
>  struct evsel *evlist__id2evsel(struct evlist *evlist, u64 id);
> --
> 2.17.1
>

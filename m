Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199FC327898
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 08:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhCAHuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 02:50:23 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:41857 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhCAHuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 02:50:17 -0500
Received: by mail-lf1-f48.google.com with SMTP id q25so3693639lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 23:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCqi65u6jCFunOm12Oog107Pq4F7SYFu8w898Uy17Bs=;
        b=Xt0ObsLcBKOEOldG8JOl0eFrt+FRR9A9Ej9d3e7pvAktt2XCF+iRfDvB0wND60GNnx
         Ys8/oaOXuS47kc2c32mECNXLtlBF/kfpcrUi6ku38LvDkMSUPk5WZCdDDm4Y5afwySXO
         RU2xfMPIX6TlLxBAHh+1TD5kusdQnkOSL4cUY7I/XW1R+b5c/GtVijjYldfev/p+m/5R
         e+k68FBLV/sxKhAFWQq+r4/p9H90pqHG703P7rJoohM/k637sUT5tMSpZk29BBDZa3nS
         1wmaQt2UwqwtJ7wOhgiNbrj48tp9uojh3EitAQx3AaQg4iBngQwd35wparNkdzca///Y
         hSsw==
X-Gm-Message-State: AOAM532NWq7/Bj5zfRgginvVgYU2eExT7deidJUlPtTQlK8ipxVzIrEE
        Eln9Ej8GaGqKdFUZ+GNsFF61hFpx5av8UW854dWqz2ZK
X-Google-Smtp-Source: ABdhPJzb7ZVFZOMfXn8Q98RXqNMjpp9NBUL669scf8ECsKSsAl0vwqi9C0PU2ZTyfvFhjoio1X5xcfMI1ws6QANUI4c=
X-Received: by 2002:a05:6512:12c1:: with SMTP id p1mr9300470lfg.374.1614585061697;
 Sun, 28 Feb 2021 23:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20210226221431.1985458-1-irogers@google.com>
In-Reply-To: <20210226221431.1985458-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 1 Mar 2021 16:50:50 +0900
Message-ID: <CAM9d7ci2GpSuj88qAphQxBSEvaOoQg=9r8ah5GjrdFojSQ-28w@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Ensure read cmdlines are null terminated.
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Sat, Feb 27, 2021 at 7:14 AM Ian Rogers <irogers@google.com> wrote:
>
> Issue detected by address sanitizer.
>
> Fixes: cd4ceb63438e (perf util: Save pid-cmdline mapping into tracing header)
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/trace-event-read.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
> index f507dff713c9..8a01af783310 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
> @@ -361,6 +361,7 @@ static int read_saved_cmdline(struct tep_handle *pevent)
>                 pr_debug("error reading saved cmdlines\n");
>                 goto out;
>         }
> +       buf[ret] = '\0';
>
>         parse_saved_cmdline(pevent, buf, size);
>         ret = 0;
> --
> 2.30.1.766.gb4fecdf3b7-goog
>

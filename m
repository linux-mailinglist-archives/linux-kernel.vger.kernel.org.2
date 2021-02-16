Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE3631C6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 08:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBPHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 02:35:21 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:36706 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhBPHfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 02:35:19 -0500
Received: by mail-lj1-f178.google.com with SMTP id k22so9973273ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 23:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpG6UAzqPxkA/Vi7szyWL/ZxJDo3MaeVBNCIuBYso9U=;
        b=Szjhlrno5cHjGbwJp67/MLUaq2zk+4SKCht19NhS57qUoYFZC1v/+xjdNSz7jjGxl4
         0OawqCzjbf0dQm/J1e+mUwqBNebaGUgyGwG20iJdT3ZYcvZgidAMKncSWMVRpt/BCuKn
         WuORrBZKdIF780/WEUywCmy6uREYssyjV53/ZczAXQmFIx41Vv3UjxprJMr3R9X6gFUZ
         OD73SFRPJLe0U+9PWpSfwiFjxnj9niLHcj8IkbI3wD4Mdk2lb+/gprGW2gy8u2qNsXmG
         20JIy1y8k4GMcMVNx2YihwzNNOTU7TkufaHkKyijDHvEc1ZahWvcvSumft9l/4OJYuhA
         0VVg==
X-Gm-Message-State: AOAM532ngnseeL6eXTnVkAwHlnlCCf/Y4onm3NaT/ijExtUBuNzxGzoe
        Qw//qw+a2XwDM7jrtVWRQhPX0128tqdau3hHNMM=
X-Google-Smtp-Source: ABdhPJwcVhwbCeeblJPEbDrPghdMmtUrUxJAJ48BMu1dU5E63w8VtvWNIoDPyouqtm6XVQFe3WI3VmnfLHX86F+6sf0=
X-Received: by 2002:a2e:505d:: with SMTP id v29mr10829818ljd.393.1613460876671;
 Mon, 15 Feb 2021 23:34:36 -0800 (PST)
MIME-Version: 1.0
References: <1612165277-95878-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1612165277-95878-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 16 Feb 2021 16:34:25 +0900
Message-ID: <CAM9d7ci4X9kbHN1voPvT6HR+b8g16LsQKzfbOG5Cq+H2XBt0QA@mail.gmail.com>
Subject: Re: [PATCH] perf metricgroup: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Feb 1, 2021 at 4:41 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the following coccicheck warning:
> ./tools/perf/util/metricgroup.c:382:3-4: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index e6d3452..26c990e 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -379,7 +379,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>                                 metric_refs[i].metric_expr = ref->metric_expr;
>                                 i++;
>                         }
> -               };
> +               }
>
>                 expr->metric_refs = metric_refs;
>                 expr->metric_expr = m->metric_expr;
> --
> 1.8.3.1
>

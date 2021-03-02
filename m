Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E657032A18D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbhCBGf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 01:35:58 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:44883 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbhCBEsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 23:48:51 -0500
Received: by mail-lj1-f176.google.com with SMTP id r25so21313181ljk.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 20:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iriI9ZVXqJdXLHJJiIHkxnECyWltfb1rJyMmw/tpUbk=;
        b=H8Sui7OUtwD+8ZOhej9asbcneY/ATgzwWa527v1L/SOpk8pvdKTBFYikVDj5YSqwqC
         Sb1IABvlXXwwdP+F0p5t1YkPatzg7TdQlsg4zTbsgE7IaKrgJbikUejHQOWZ9YDoP6py
         j27diDF39dVWHoywh65G/op4jvedX5yp8gvuvoL+Spe6a/1vwR9mHhqMGBFiHZBjTxeg
         RQCVw5QoRqCTpuf4a++puUbMTvmCqcxCUOmhN7U2RZ1PstkjAW9rSssKjQK5zkrmjWVR
         mBaFcrIs9GO6Gz1v/qbowxN3ZKr4QZTP/NbYqkbdYRY2MaWzJC47sGwjrqM/gviS0bp7
         EHMQ==
X-Gm-Message-State: AOAM533cxBlDXKgWlx6HAaN4ngJY+YyaXBV07iNLT0FSi5iZbKH6R9XI
        YMlNh7oCqlhX6qJpqDPMUo9urUhE/MQeS9v2V+h1MTY9CaI=
X-Google-Smtp-Source: ABdhPJznwwj5xR8FEAAPzGWP8nTXXYNOcT6itMXBuMmytBipMZdRyFaDPQgX9/8nAocYRfv6y9ZfvsjnEbn2zu+GIac=
X-Received: by 2002:a2e:9855:: with SMTP id e21mr6365550ljj.26.1614660487162;
 Mon, 01 Mar 2021 20:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20210302023533.1572231-1-dima@arista.com>
In-Reply-To: <20210302023533.1572231-1-dima@arista.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 2 Mar 2021 13:47:55 +0900
Message-ID: <CAM9d7cibt7MdaZq2mX73N0gYViE7EGg_TcwkU6uq3NS7rgVSkw@mail.gmail.com>
Subject: Re: [PATCH] perf diff: Don't crash on freeing errno-session
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 2, 2021 at 11:35 AM Dmitry Safonov <dima@arista.com> wrote:
>
> __cmd_diff() sets result of perf_session__new() to d->session.
> In case of failure, it's errno and perf-diff may crash with:
> failed to open perf.data: Permission denied
> Failed to open perf.data
> Segmentation fault (core dumped)
>
> From the coredump:
> 0  0x00005569a62b5955 in auxtrace__free (session=0xffffffffffffffff)
>     at util/auxtrace.c:2681
> 1  0x00005569a626b37d in perf_session__delete (session=0xffffffffffffffff)
>     at util/session.c:295
> 2  perf_session__delete (session=0xffffffffffffffff) at util/session.c:291
> 3  0x00005569a618008a in __cmd_diff () at builtin-diff.c:1239
> 4  cmd_diff (argc=<optimized out>, argv=<optimized out>) at builtin-diff.c:2011
> [..]
>
> Funny enough, it won't always crash. For me it crashes only if failed
> file is second in cmd-line: the reason is that cmd_diff() check files for
> branch-stacks [in check_file_brstack()] and if the first file doesn't
> have brstacks, it doesn't proceed to try open other files from cmd-line.
>
> Check d->session before calling perf_session__delete().
>
> Another solution would be assigning to temporary variable, checking it,
> but I find it easier to follow with IS_ERR() check in the same function.
> After some time it's still obvious why the check is needed, and with
> temp variable it's possible to make the same mistake.
>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-diff.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index cefc71506409..b0c57e55052d 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1236,7 +1236,8 @@ static int __cmd_diff(void)
>
>   out_delete:
>         data__for_each_file(i, d) {
> -               perf_session__delete(d->session);
> +               if (!IS_ERR(d->session))
> +                       perf_session__delete(d->session);
>                 data__free(d);
>         }
>
> --
> 2.30.1
>

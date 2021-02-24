Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAA83238F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhBXIrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:47:51 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:34971 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbhBXIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:46:26 -0500
Received: by mail-lj1-f182.google.com with SMTP id a17so1504114ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivBtGNSqKzBWYXQ2zss/z1AeTdvODaLIhS0a7MYcAjM=;
        b=KgVurYK9cKHvs+g2tQ9eT9zKvODbrCnu47y8XgR5ZchZ9Zo0zqM/MVgG8t29bhUnPf
         TbqziVAA06+a5+Fq+JjV525TWr0MM7O4NpIR83J9UxsenOtj2oxhEFJSukRX9BOx8GI5
         VTucCC2sLRsHwN6YCJneLHwOIh6DOILbx+xkdYgYV9SLFwHF/19HGkEGCMlD5S7z/gel
         iPLBTp2ZJHh+wqw2wLyHNQ1btiu4yd/TtI9+zHSrIyIObwTretbAmqLfAvYG4WMX7r7j
         j6VQJv73ls+srGCibBvUgbbK8a1ACKMFvPgFazewpP0JHH5o/2kOhxnSMJHLmYcvOdHq
         hdzg==
X-Gm-Message-State: AOAM5338f+i13Tn5MTBo/EJ8flpuQg6Voo/VeYFQndv1tGjG6zQgoDWT
        qpMKDY8K076Zyimysqx0f8I36sU+96y5amWGcNs=
X-Google-Smtp-Source: ABdhPJz029nCqOGKoT2fwl0WgVip7jkQySej2ZRsVIqBFAfAF+lt4hm2PHxfvPySk8cdwTxe3rqPEgeeRPC5NveYnVg=
X-Received: by 2002:a2e:9252:: with SMTP id v18mr12910677ljg.26.1614156344351;
 Wed, 24 Feb 2021 00:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20210224081103.715233-1-namhyung@kernel.org> <20210224081103.715233-2-namhyung@kernel.org>
In-Reply-To: <20210224081103.715233-2-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 24 Feb 2021 17:45:32 +0900
Message-ID: <CAM9d7cjA7aNJoGxi8PjpF3G0zD89V39Eg=JBAOoPOxW3KtWx3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf stat: Fix segfault when -r option is used
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 5:11 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> I got a segfault when using -r option with event groups.  The option
> makes it run the workload multiple times and it will reuse the evlist
> and evsel for each run.

Well, it might not see a segfault because the freed memory region is
likely to be reused.  But you can see the bug clearly with asan.

Thanks,
Namhyung

>
> While most of resources are allocated and freed properly, the id hash
> in the evlist was not and it resulted in a crash.  You can see it with
> the address sanitizer like below:
>
>   $ perf stat -r 100 -e '{cycles,instructions}' true
>   =================================================================
>   ==693052==ERROR: AddressSanitizer: heap-use-after-free on
>       address 0x6080000003d0 at pc 0x558c57732835 bp 0x7fff1526adb0 sp 0x7fff1526ada8
>   WRITE of size 8 at 0x6080000003d0 thread T0
>     #0 0x558c57732834 in hlist_add_head /home/namhyung/project/linux/tools/include/linux/list.h:644
>     #1 0x558c57732834 in perf_evlist__id_hash /home/namhyung/project/linux/tools/lib/perf/evlist.c:237
>     #2 0x558c57732834 in perf_evlist__id_add /home/namhyung/project/linux/tools/lib/perf/evlist.c:244
>     #3 0x558c57732834 in perf_evlist__id_add_fd /home/namhyung/project/linux/tools/lib/perf/evlist.c:285
>     #4 0x558c5747733e in store_evsel_ids util/evsel.c:2765
>     #5 0x558c5747733e in evsel__store_ids util/evsel.c:2782
>     #6 0x558c5730b717 in __run_perf_stat /home/namhyung/project/linux/tools/perf/builtin-stat.c:895
>     #7 0x558c5730b717 in run_perf_stat /home/namhyung/project/linux/tools/perf/builtin-stat.c:1014
>     #8 0x558c5730b717 in cmd_stat /home/namhyung/project/linux/tools/perf/builtin-stat.c:2446
>     #9 0x558c57427c24 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
>     #10 0x558c572b1a48 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
>     #11 0x558c572b1a48 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
>     #12 0x558c572b1a48 in main /home/namhyung/project/linux/tools/perf/perf.c:539
>     #13 0x7fcadb9f7d09 in __libc_start_main ../csu/libc-start.c:308
>     #14 0x558c572b60f9 in _start (/home/namhyung/project/linux/tools/perf/perf+0x45d0f9)
>
> Actually the nodes in the hash table are struct perf_stream_id and
> they were freed in the previous run.  Fix it by resetting the hash.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evlist.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 5121b4db66fe..882cd1f721d9 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1306,6 +1306,7 @@ void evlist__close(struct evlist *evlist)
>                 perf_evsel__free_fd(&evsel->core);
>                 perf_evsel__free_id(&evsel->core);
>         }
> +       perf_evlist__reset_id_hash(&evlist->core);
>  }
>
>  static int evlist__create_syswide_maps(struct evlist *evlist)
> --
> 2.30.0.617.g56c4b15f3c-goog
>

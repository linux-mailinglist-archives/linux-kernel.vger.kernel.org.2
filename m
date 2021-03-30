Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1221934E28A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhC3HtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:49:06 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:41629 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhC3Hs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:48:59 -0400
Received: by mail-lj1-f171.google.com with SMTP id f26so18823155ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 00:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fx8gB6H5NSO0c2xdPkuDb5fO/Irp632VNdlBEjeOn68=;
        b=J5DR5Wh/Xhihnnz78UanF8Cd9fqBenXAw3xa6rulTMsU1BzSQTufDa8vMLvhGaoAzA
         dLNI8rK9qPXzSRkOLtoF8XJE6fYeqcHRmyg1kPGcYi940rnadv9PxaL6JjlLaLs7eyL5
         1wLB9Tk2QG4HJWLjK6uPDvb9U/JMOyJd2UNwAQxBXnOlG4tmlJq+Rw/6JSIQFIll4Nc+
         YG61XrwRfkHClDD5vCjgnYE6us3dWlHDEO4/XD963ESsmhxL6rfkTtbSuXWYbpWy5YhQ
         DIqPOT/45H0Zxs0G3lKB1cK+fvYEn9QSWWlekgeUnMPFwEMrKwqCHb7b22kcUZTdnLDg
         I/tg==
X-Gm-Message-State: AOAM530k8nelONhH/ctyo4iKx1MCXvd2TegJdDobG+xNh/jtT0kFdcra
        RasrBoofcb1aW1wQFqVErfi0RdmshYMmM7YmMh8=
X-Google-Smtp-Source: ABdhPJy86uJsliCv/B5T77vD2o0mtWMW7YIHaw+NUjOm8yeANev6gRqOIEg9PUbU18gJZtVumFNkka6yKQqpJhWK9Fw=
X-Received: by 2002:a2e:b0cd:: with SMTP id g13mr20151112ljl.166.1617090538454;
 Tue, 30 Mar 2021 00:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210324143037.3810-1-alexander.antonov@linux.intel.com>
In-Reply-To: <20210324143037.3810-1-alexander.antonov@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 30 Mar 2021 16:48:47 +0900
Message-ID: <CAM9d7ch_rZxtMdnQWtCQZvaUL8UPA=F55Q1Om1JNHptJPahKAA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] perf stat: Introduce iostat mode to provide I/O
 performance metrics
To:     Alexander Antonov <alexander.antonov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Mar 24, 2021 at 11:30 PM Alexander Antonov
<alexander.antonov@linux.intel.com> wrote:
>
> The previous version can be found at:
> v4: https://lkml.kernel.org/r/20210203135830.38568-1-alexander.antonov@linux.intel.com/
> Changes in this revision are:
> v4 -> v5:
> - Addressed comments from Namhyung Kim:
>   1. Removed AGGR_PCIE_PORT aggregation mode
>   2. Added iostat_prepare() function
>   3. Moved implementation specific fprintf() calls to separate x86-related function
>   4. Fixed code-related issues
> - Moved __weak iostat's functions to separate util/iostat.c file
>
> The previous version can be found at:
> v3: https://lkml.kernel.org/r/20210126080619.30275-1-alexander.antonov@linux.intel.com/
> Changes in this revision are:
> v3 -> v4:
> - Addressed comment from Namhyung Kim:
>   1. Removed NULL-termination of root ports list
>
> The previous version can be found at:
> v2: https://lkml.kernel.org/r/20201223130320.3930-1-alexander.antonov@linux.intel.com
>
> Changes in this revision are:
> v2 -> v3:
> - Addressed comments from Namhyung Kim:
>   1. Removed perf_device pointer from evsel structure. Use priv field instead
>   2. Renamed 'iiostat' to 'iostat'
>   3. Renamed 'show' mode to 'list' mode
>   4. Renamed iiostat_delete_root_ports() to iiostat_release() and
>      iostat_show_root_ports() to iostat_list()
>
> The previous version can be found at:
> v1: https://lkml.kernel.org/r/20201210090340.14358-1-alexander.antonov@linux.intel.com
>
> Changes in this revision are:
> v1 -> v2:
> - Addressed comment from Arnaldo Carvalho de Melo:
>   1. Using 'perf iiostat' subcommand instead of 'perf stat --iiostat':
>     - Added perf-iiostat.sh script to use short command
>     - Updated manual pages to get help for 'perf iiostat'
>     - Added 'perf-iiostat' to perf's gitignore file
>
> Mode is intended to provide four I/O performance metrics in MB per each
> root port:
>  - Inbound Read:   I/O devices below root port read from the host memory
>  - Inbound Write:  I/O devices below root port write to the host memory
>  - Outbound Read:  CPU reads from I/O devices below root port
>  - Outbound Write: CPU writes to I/O devices below root port
>
> Each metric requiries only one uncore event which increments at every 4B
> transfer in corresponding direction. The formulas to compute metrics
> are generic:
>     #EventCount * 4B / (1024 * 1024)
>
> Note: iostat introduces new perf data aggregation mode - per PCIe root port
> hence -e and -M options are not supported.
>
> Usage examples:
>
> 1. List all PCIe root ports (example for 2-S platform):
>    $ perf iostat list
>    S0-uncore_iio_0<0000:00>
>    S1-uncore_iio_0<0000:80>
>    S0-uncore_iio_1<0000:17>
>    S1-uncore_iio_1<0000:85>
>    S0-uncore_iio_2<0000:3a>
>    S1-uncore_iio_2<0000:ae>
>    S0-uncore_iio_3<0000:5d>
>    S1-uncore_iio_3<0000:d7>
>
> 2. Collect metrics for all PCIe root ports:
>    $ perf iostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
>    357708+0 records in
>    357707+0 records out
>    375083606016 bytes (375 GB, 349 GiB) copied, 215.974 s, 1.7 GB/s
>
>     Performance counter stats for 'system wide':
>
>       port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
>    0000:00                    1                    0                    2                    3
>    0000:80                    0                    0                    0                    0
>    0000:17               352552                   43                    0                   21
>    0000:85                    0                    0                    0                    0
>    0000:3a                    3                    0                    0                    0
>    0000:ae                    0                    0                    0                    0
>    0000:5d                    0                    0                    0                    0
>    0000:d7                    0                    0                    0                    0
>
> 3. Collect metrics for comma separated list of PCIe root ports:
>    $ perf iostat 0000:17,0:3a -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
>    357708+0 records in
>    357707+0 records out
>    375083606016 bytes (375 GB, 349 GiB) copied, 197.08 s, 1.9 GB/s
>
>     Performance counter stats for 'system wide':
>
>       port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
>    0000:17               358559                   44                    0                   22
>    0000:3a                    3                    2                    0                    0
>
>         197.081983474 seconds time elapsed
>
> Alexander Antonov (4):
>   perf stat: Basic support for iostat in perf
>   perf stat: Helper functions for PCIe root ports list in iostat mode
>   perf stat: Enable iostat mode for x86 platforms
>   perf: Update .gitignore file

Thanks for your work!

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/perf/.gitignore                    |   1 +
>  tools/perf/Documentation/perf-iostat.txt |  88 +++++
>  tools/perf/Makefile.perf                 |   5 +-
>  tools/perf/arch/x86/util/Build           |   1 +
>  tools/perf/arch/x86/util/iostat.c        | 470 +++++++++++++++++++++++
>  tools/perf/builtin-stat.c                |  21 +-
>  tools/perf/command-list.txt              |   1 +
>  tools/perf/perf-iostat.sh                |  12 +
>  tools/perf/util/Build                    |   1 +
>  tools/perf/util/iostat.c                 |  53 +++
>  tools/perf/util/iostat.h                 |  47 +++
>  tools/perf/util/stat-display.c           |  40 +-
>  tools/perf/util/stat-shadow.c            |   5 +-
>  tools/perf/util/stat.h                   |   1 +
>  14 files changed, 733 insertions(+), 13 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf-iostat.txt
>  create mode 100644 tools/perf/arch/x86/util/iostat.c
>  create mode 100644 tools/perf/perf-iostat.sh
>  create mode 100644 tools/perf/util/iostat.c
>  create mode 100644 tools/perf/util/iostat.h
>
>
> base-commit: 6859bc0e78c6a699599cbb21404fdb6c8125da74
> --
> 2.19.1
>

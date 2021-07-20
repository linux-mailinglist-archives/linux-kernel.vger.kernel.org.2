Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEED3CF69C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 11:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhGTI0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235205AbhGTIVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626771708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7R2usiUzQiJENd2iMckw4Ax7g0Vc0lClCVihnaEn6DY=;
        b=PiaTz4lNHoF27DfA9KnnrfmoVp2Ikx97SlTRZqgC1n+nDW/COVA/BqJkjDbSrVDqy3Wcjq
        emMpbTqYCuSYY2ES9cNnWAfWkpoiE+UkdK/m36SmGQ6ab1dyKxKkBfck+tPuI+/LvI6IHD
        05n20KTeZNjr1mlx5rpndUXqLIDPvDw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-l5aoCdYiMzCAwUfvKNqEUg-1; Tue, 20 Jul 2021 05:01:47 -0400
X-MC-Unique: l5aoCdYiMzCAwUfvKNqEUg-1
Received: by mail-ed1-f72.google.com with SMTP id n10-20020aa7c78a0000b02903b874f26036so367606eds.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 02:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7R2usiUzQiJENd2iMckw4Ax7g0Vc0lClCVihnaEn6DY=;
        b=ro5yHDa8MdJMu5N/8dPQGnjFF2A/XzT7RIt3ut1MZ/fLAlIAAA7iohAs8984nulbM5
         uq4uhfUBOIzC+SIQ1u4TnfETLvv8bvoOvURmuPWIq81BuPcPW8coIzHxUXnQd0wvvpiA
         EcGGWefECV9OFO2kfquVKQ02noACeYz5/wYUo4XV+MScKsh3tESnf2VSl9/bFeI3F4oP
         awGU9Ej4mhqk/x1AYGMy56Z9r0PEfrW5BQKSh3AIp/ruF680YszBRZDHVHnI0VqPZVt4
         rqZNUmj3zrryoOGX7tLPytV1+A2CYEHKy87kw/R3wJn70djFFYpcKo/83Ey3hAbgbslx
         sSkw==
X-Gm-Message-State: AOAM531U5mgebahzFUGKzeZKOGuvW3QEpD7tt9OXCbAdUH09xXCzswSv
        /syLDV0gzLZjHuVTOn6CeD8imhz+Jx2kSdz+YIau/M64R6V6jTjodfq9HfC/GFKmwvP2zZzy06p
        QTvy3tD4byK+l3KjlHQwpGiuG
X-Received: by 2002:a17:906:7a56:: with SMTP id i22mr31005393ejo.94.1626771706354;
        Tue, 20 Jul 2021 02:01:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzztOrdUoGhBGmV353kblZXZx4DE2SpHtqOsIMbsIEf44ni4kNGTH+p10PiWteAZMz08+NiSg==
X-Received: by 2002:a17:906:7a56:: with SMTP id i22mr31005383ejo.94.1626771706183;
        Tue, 20 Jul 2021 02:01:46 -0700 (PDT)
Received: from krava ([83.240.63.206])
        by smtp.gmail.com with ESMTPSA id k8sm8968653edr.92.2021.07.20.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 02:01:45 -0700 (PDT)
Date:   Tue, 20 Jul 2021 11:01:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHSET v3 0/5] perf inject: Fix broken data with mixed
 input/output
Message-ID: <YPaQ94VCtYWSXYnh@krava>
References: <20210719223153.1618812-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719223153.1618812-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 03:31:48PM -0700, Namhyung Kim wrote:
> Hello,
> 
> The perf inject processes the input data and produces an output with
> injected data according to the given options.  During the work, it
> assumes the input and output files have the same format - either a
> regular file or a pipe.  This works for the obvious cases, but
> sometimes makes a trouble when input and output have different
> formats (like for debugging).
> 
>  * changes in v3
>   - use task-clock:u in the pipe-test.sh

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  * changes in v2
>   - factor out perf_event__synthesize_for_pipe
>   - add a shell test for pipe operations
> 
> 
> For example, this patchset fixed the following cases
> 
>  1. input: pipe, output: file
> 
>   # perf record -a -o - sleep 1 | perf inject -b -o perf-pipe.data
>   # perf report -i perf-pipe.data
> 
>  2. input: file, output: pipe
> 
>   # perf record -a -B sleep 1
>   # perf inject -b -i perf.data | perf report -i -
> 
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (5):
>   perf tools: Remove repipe argument from perf_session__new()
>   perf tools: Pass a fd to perf_file_header__read_pipe()
>   perf inject: Fix output from a pipe to a file
>   perf inject: Fix output from a file to a pipe
>   perf tools: Add pipe_test.sh to verify pipe operations
> 
>  tools/perf/bench/synthesize.c       |  4 +-
>  tools/perf/builtin-annotate.c       |  2 +-
>  tools/perf/builtin-buildid-cache.c  |  2 +-
>  tools/perf/builtin-buildid-list.c   |  2 +-
>  tools/perf/builtin-c2c.c            |  2 +-
>  tools/perf/builtin-diff.c           |  4 +-
>  tools/perf/builtin-evlist.c         |  2 +-
>  tools/perf/builtin-inject.c         | 38 ++++++++++++++--
>  tools/perf/builtin-kmem.c           |  2 +-
>  tools/perf/builtin-kvm.c            |  4 +-
>  tools/perf/builtin-lock.c           |  2 +-
>  tools/perf/builtin-mem.c            |  3 +-
>  tools/perf/builtin-record.c         | 40 +++--------------
>  tools/perf/builtin-report.c         |  2 +-
>  tools/perf/builtin-sched.c          |  4 +-
>  tools/perf/builtin-script.c         |  4 +-
>  tools/perf/builtin-stat.c           |  4 +-
>  tools/perf/builtin-timechart.c      |  3 +-
>  tools/perf/builtin-top.c            |  2 +-
>  tools/perf/builtin-trace.c          |  2 +-
>  tools/perf/tests/shell/pipe_test.sh | 69 +++++++++++++++++++++++++++++
>  tools/perf/tests/topology.c         |  4 +-
>  tools/perf/util/data-convert-bt.c   |  2 +-
>  tools/perf/util/data-convert-json.c |  2 +-
>  tools/perf/util/header.c            | 12 ++---
>  tools/perf/util/header.h            |  2 +-
>  tools/perf/util/session.c           | 11 ++---
>  tools/perf/util/session.h           | 12 ++++-
>  tools/perf/util/synthetic-events.c  | 53 +++++++++++++++++++++-
>  tools/perf/util/synthetic-events.h  |  6 +++
>  30 files changed, 217 insertions(+), 84 deletions(-)
>  create mode 100755 tools/perf/tests/shell/pipe_test.sh
> 
> -- 
> 2.32.0.402.g57bb445576-goog
> 


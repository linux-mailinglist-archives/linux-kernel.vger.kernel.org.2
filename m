Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62A04081BA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 23:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhILVDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 17:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229930AbhILVDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 17:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631480525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S0iYLo77hJk72w6pfp2mY/JIQveupjfC8WzUeJ2OWHk=;
        b=OplcP2GnL6+XV8eoB8EfookCBKjTDcAFxPE2JTVIAiLoZAWiXXncZzfoipxAFgSMcYdwHf
        2o+3YfDyPp896TBq4eLquCEn6APMrTzY6nvY1GkxDG3YrjJpVDe89qldvgDz2oOPT5ubUw
        cHSdhtjlfDNmfo30fmVPhC/8fpK753k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-8SxSmV6LPOuGaLf_dOwqAw-1; Sun, 12 Sep 2021 17:02:04 -0400
X-MC-Unique: 8SxSmV6LPOuGaLf_dOwqAw-1
Received: by mail-ed1-f69.google.com with SMTP id y17-20020a50e611000000b003d051004603so3195049edm.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 14:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S0iYLo77hJk72w6pfp2mY/JIQveupjfC8WzUeJ2OWHk=;
        b=wk7D/11fpgUgY/aTdoWU+JEe9gvAS4Gg4w6nLOBirA0tmTJwfNVcN20UAZC5cnwGaW
         JtAceo+Qvp4r4RXl+isBQHHjwtOyr/ClD3m9NjDU01VgY1o85nGARiCThe488wD/lVxB
         qvElihCnqXiwECtJbYhY4Yf979iOieD1LOhLRnJQOjPrD7kzWSnLmF4sI9SQtalW59vS
         N8QuUzg0iMoVN56kifShzwrgbdnH6UDHfE/hMdSf1CInOuzX2h+4XmgFu3EPw4YDo56c
         1o4hJZNsMN9m2zQFLn8tsS+rwQUSxWVmOpfQw5UN5C4ORXFbiUe0lPyavCyayryFT7VI
         tECg==
X-Gm-Message-State: AOAM530LzmE9YZvcx0Hppz0gn6LqoxgWjmbbLw2d8KRDkkt4E9goVtKh
        3SY1zfoYI9n7lmtOj6ZdHUeIa+7lFQV6bJZAu0AoajTfhf1cbxTV1FcrOu0Zpl6EI/OxN1El+7j
        ca+z/om+xxgwf/WP99Pa2uR0W
X-Received: by 2002:a17:906:7c52:: with SMTP id g18mr9231035ejp.246.1631480522412;
        Sun, 12 Sep 2021 14:02:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyveh81rk1R0bBpb4YlJUVeL5lyzP9bNjqc4nRTnddRSSpfTsS3ZiUeTpEfq4EM5OGAaU5tqw==
X-Received: by 2002:a17:906:7c52:: with SMTP id g18mr9231019ejp.246.1631480522255;
        Sun, 12 Sep 2021 14:02:02 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id l16sm2477236eje.67.2021.09.12.14.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 14:02:01 -0700 (PDT)
Date:   Sun, 12 Sep 2021 23:01:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v11 13/24] perf record: Extend --threads command line
 option
Message-ID: <YT5qx4mhqOob1sMh@krava>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
 <fc0c61075698b5e9c9fb9b1b2ef6716b6f5d6930.1629186429.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc0c61075698b5e9c9fb9b1b2ef6716b6f5d6930.1629186429.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:23:16AM +0300, Alexey Bayduraev wrote:
> Extend --threads option in perf record command line interface.
> The option can have a value in the form of masks that specify
> cpus to be monitored with data streaming threads and its layout
> in system topology. The masks can be filtered using cpu mask
> provided via -C option.
> 
> The specification value can be user defined list of masks. Masks
> separated by colon define cpus to be monitored by one thread and
> affinity mask of that thread is separated by slash. For example:
> <cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2>
> specifies parallel threads layout that consists of two threads
> with corresponding assigned cpus to be monitored.
> 
> The specification value can be a string e.g. "cpu", "core" or
> "socket" meaning creation of data streaming thread for every
> cpu or core or socket to monitor distinct cpus or cpus grouped
> by core or socket.
> 
> The option provided with no or empty value defaults to per-cpu
> parallel threads layout creating data streaming thread for every
> cpu being monitored.
> 
> Document --threads option syntax and parallel data streaming modes
> in Documentation/perf-record.txt.
> 
> Feature design and implementation are based on prototypes [1], [2].
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt |  30 ++-
>  tools/perf/builtin-record.c              | 314 ++++++++++++++++++++++-
>  tools/perf/util/record.h                 |   1 +
>  3 files changed, 340 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 0408e677c117..4bbdc813e2e9 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -695,9 +695,35 @@ measurements:
>   wait -n ${perf_pid}
>   exit $?
>  
> ---threads::
> +--threads=<spec>::
>  Write collected trace data into several data files using parallel threads.
> -The option creates a data streaming thread for each cpu in the system.
> +<spec> value can be user defined list of masks. Masks separated by colon
> +define cpus to be monitored by a thread and affinity mask of that thread
> +is separated by slash:
> +
> +    <cpus mask 1>/<affinity mask 1>:<cpus mask 2>/<affinity mask 2>:...
> +
> +For example user specification like the following:
> +
> +    0,2-4/2-4:1,5-7/5-7

is this special case?

[root@krava perf]# ./perf record --threads=1/1

[root@krava perf]# ps -ef | grep perf
root      132071  130979  9 22:59 pts/6    00:00:00 ./perf record --threads=1/1

[root@krava perf]# cat /proc/131798/task/*/status | grep Cpus_allowed
cat: '/proc/131798/task/*/status': No such file or directory
[root@krava perf]# cat /proc/132071/task/*/status | grep Cpus_allowed
Cpus_allowed:   ff
Cpus_allowed_list:      0-7
Cpus_allowed:   ff
Cpus_allowed_list:      0-7

looks like the affinity was not set

thanks,
jirka


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDD93E96FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 19:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhHKRp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhHKRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 13:45:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9274CC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:45:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id go31so5892665ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3eRVIW9IlSqCCV9yJgkmgUV0ug4RbSf/hHrSmxtkjEw=;
        b=uTUw4vymnt8oCDrvhS85ey3Z+7is7qoXgtyFRrDvjNqJS2dgV2Xm6Sv17a6E9k5AKJ
         VIEls0ApPtTEXGQrT40BkiqL0BYVYa9ZaWvzmiNy7WpjLXem988MhvGfEmd5HjXxsMDr
         LzDzzxOC/hkeuGHf98Xii9h254KrHSkWc5DBWmCfMkEnaQvKHvMp6h2uB5nF7O3Oo4ce
         leMNuPN6z+GX5Q9LZLLh5JAut0/iinrpJnwZ+r02mGYckHs1MMrxcW8q/59mCY0Ze9fX
         lv+obz3GddjrqptMtXsLpxh5wkxeV5sHvYie23Djgwig5aH1h9IAKB8E4+30oucXxdq1
         02Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3eRVIW9IlSqCCV9yJgkmgUV0ug4RbSf/hHrSmxtkjEw=;
        b=lDhj2/f9AdrhgOJ2IHPlQH4kUp36GQlBapMgut2QQfSbCIHHGByxH/vQ1ArPvvikTb
         zfR13pIFdQjbecjUf6uDK54URSkZeEBORp39ANCDDW3x5HwUebnSusVtLyijFu9mlLrP
         FGOQsixRLmGyn7ZSZhiLNBR8i28dHMxtnoMIdjuPhvTHV8qeSJWjxyudN7C99R8l6Qa7
         ZODXsYu/p4HH1Jb06hb3UoXWMFMC/lwaibcxKUGz/yH26vRu2UeOFT4AyXRXihxvPOdA
         x3NNrEfGdZJiYgoQas7++FXsP1a96Ud++50dK2W867oNKu0fuZhbGjxNVZWvyOPhiDo4
         kZOQ==
X-Gm-Message-State: AOAM532AhbKlvvVkDwSyOUYRLZPe8oxIlalrbGYi8Mmb3fxVclKYKRaJ
        qUMgBuQBSagznH19WEvDF8Y=
X-Google-Smtp-Source: ABdhPJwY/w2W6kpY7FEcOkMd64tCsNJFxZ116PlnmqvgLyhAQ1ym5LGavGmVa0Z8Z37e5/3+bs4EEQ==
X-Received: by 2002:a17:906:1919:: with SMTP id a25mr4730500eje.161.1628703931041;
        Wed, 11 Aug 2021 10:45:31 -0700 (PDT)
Received: from [172.16.0.82] (nat-allievi.sssup.it. [193.205.81.9])
        by smtp.gmail.com with ESMTPSA id s20sm25546eji.116.2021.08.11.10.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:45:30 -0700 (PDT)
Message-ID: <9a0bd56bfa19f4bb58044dfdf15cfce47ffdf50c.camel@gmail.com>
Subject: Re: [PATCH v10 00/24] Introduce threaded trace streaming for basic
 perf record operation
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Date:   Wed, 11 Aug 2021 19:45:25 +0200
In-Reply-To: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering whether you should use perf_set_multithreaded() and
perf_set_singlethreaded() functions in your patchset, as it's done with
synthetic events.
Afaict, they enable/disable certain locks and semaphores.

Apart from this doubt, I ran some experiments on my laptop and on a VM, running
stress-ng as workload and using perf-stat to gather information about the
threaded perf-record.
Here are some results:
 - the number of missed chunks decreases (running a high frequency ~1kHz with
dwarf causes some misses on the single thread but none in multithread);
 - the overall utilization of perf-record does not significantly change;
 - the total size of the perf.data does not significantly change.

I also noticed that the --threads=socket option does not work as expected on my
VM, creating 16 threads. Anyways, it looks like a problem (or feature) in the
/sys fs and not a bug of this patchset, since all cpus are like the following:
$ grep "" /sys/devices/system/cpu/cpu0/topology/*_list  
/sys/devices/system/cpu/cpu0/topology/core_siblings_list:0 
/sys/devices/system/cpu/cpu0/topology/thread_siblings_list:0 

A part from the mentioned small issues:
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>

Thanks,
Riccardo

On Mon, 2021-07-12 at 09:46 +0300, Alexey Bayduraev wrote:
> Changes in v10:
> - renamed fdarray__clone to fdarray__dup_entry_from
> - captured Acked-by: tags by Namhyung Kim for 09/24
> 
> v9:
> https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
> 
> Changes in v9:
> - fixes in [v9 01/24]:
>   - move 'nr_threads' to before 'thread_masks'
>   - combined decl+assign into one line in record__thread_mask_alloc
>   - releasing masks inplace in record__alloc_thread_masks
> - split patch [v8 02/22] to [v9 02/24] and [v9 03/24]
> - fixes in [v9 03/24]:
>   - renamed 'struct thread_data' to 'struct record_thread'
>   - moved nr_mmaps after ctlfd_pos
>   - releasing resources inplace in record__thread_data_init_maps
>   - initializing pipes by -1 value
>   - added temporary gettid() wrapper
> - split patch [v8 03/22] to [v9 04/24] and [v9 05/24] 
> - removed upstreamed [v8 09/22]
> - split [v8 10/22] to [v9 12/24] and [v9 13/24]
> - moved --threads documentation to the related patches
> - fixed output of written/compressed stats in [v9 10/24]
> - split patch [v8 12/22] to [v9 15/24] and [v9 16/24]
> - fixed order of error checking for decompressed events in [v9 16/24]
> - merged patch [v8 21/22] with [v9 23/24] and [v9 24/24]
> - moved patch [v8 22/22] to [v9 09/24]
> - added max reader size constant in [v9 24/24]
> 
> v8:
> https://lore.kernel.org/lkml/cover.1625065643.git.alexey.v.bayduraev@linux.intel.com/
> 
> Changes in v8:
> - captured Acked-by: tags by Namhyung Kim
> - merged with origin/perf/core
> - added patch 21/22 introducing READER_NODATA state
> - added patch 22/22 fixing --max-size option
> 
> v7:
> https://lore.kernel.org/lkml/cover.1624350588.git.alexey.v.bayduraev@linux.intel.com/
> 
> Changes in v7:
> - fixed possible crash after out_free_threads label
> - added missing pthread_attr_destroy() call
> - added check of correctness of user masks 
> - fixed zsts_data finalization
> 
> v6:
> https://lore.kernel.org/lkml/cover.1622025774.git.alexey.v.bayduraev@linux.intel.com/
> 
> Changes in v6:
> - fixed leaks and possible double free in record__thread_mask_alloc()
> - fixed leaks in record__init_thread_user_masks()
> - fixed final mmaps flushing for threads id > 0
> - merged with origin/perf/core
> 
> v5:
> https://lore.kernel.org/lkml/cover.1619781188.git.alexey.v.bayduraev@linux.intel.com/
> 
> Changes in v5:
> - fixed leaks in record__init_thread_masks_spec()
> - fixed leaks after failed realloc
> - replaced "%m" to strerror()
> - added masks examples to the documentation
> - captured Acked-by: tags by Andi Kleen
> - do not allow --thread option for full_auxtrace mode 
> - split patch 06/12 to 06/20 and 07/20
> - split patch 08/12 to 09/20 and 10/20
> - split patches 11/12 and 11/12 to 13/20-20/20
> 
> v4:
> https://lore.kernel.org/lkml/6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com/
> 
> Changes in v4:
> - renamed 'comm' structure to 'pipes'
> - moved thread fd/maps messages to verbose=2
> - fixed leaks during allocation of thread_data structures
> - fixed leaks during allocation of thread masks
> - fixed possible fails when releasing thread masks
> 
> v3:
> https://lore.kernel.org/lkml/7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com/
> 
> Changes in v3:
> - avoided skipped redundant patch 3/15
> - applied "data file" and "data directory" terms allover the patch set
> - captured Acked-by: tags by Namhyung Kim
> - avoided braces where don't needed
> - employed thread local variable for serial trace streaming 
> - added specs for --thread option - core, socket, numa and user defined
> - added parallel loading of data directory files similar to the prototype [1]
> 
> v2:
> https://lore.kernel.org/lkml/1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com/
> 
> Changes in v2:
> - explicitly added credit tags to patches 6/15 and 15/15,
>   additionally to cites [1], [2]
> - updated description of 3/15 to explicitly mention the reason
>   to open data directories in read access mode (e.g. for perf report)
> - implemented fix for compilation error of 2/15
> - explicitly elaborated on found issues to be resolved for
>   threaded AUX trace capture
> 
> v1:
> https://lore.kernel.org/lkml/810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com/
> 
> Patch set provides parallel threaded trace streaming mode for basic
> perf record operation. Provided mode mitigates profiling data losses
> and resolves scalability issues of serial and asynchronous (--aio)
> trace streaming modes on multicore server systems. The design and
> implementation are based on the prototype [1], [2].
> 
> Parallel threaded mode executes trace streaming threads that read kernel
> data buffers and write captured data into several data files located at
> data directory. Layout of trace streaming threads and their mapping to data
> buffers to read can be configured using a value of --thread command line
> option. Specification value provides masks separated by colon so the masks
> define cpus to be monitored by one thread and thread affinity mask is
> separated by slash. <cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask
> 2>
> specifies parallel threads layout that consists of two threads with
> corresponding assigned cpus to be monitored. Specification value can be
> a string e.g. "cpu", "core" or "socket" meaning creation of data streaming
> thread for monitoring every cpu, whole core or socket. The option provided
> with no or empty value defaults to "cpu" layout creating data streaming
> thread for every cpu being monitored. Specification masks are filtered
> by the mask provided via -C option.
> 
> Parallel streaming mode is compatible with Zstd compression/decompression
> (--compression-level) and external control commands (--control). The mode
> is not enabled for pipe mode. The mode is not enabled for AUX area tracing,
> related and derived modes like --snapshot or --aux-sample. --switch-output-*
> and --timestamp-filename options are not enabled for parallel streaming.
> Initial intent to enable AUX area tracing faced the need to define some
> optimal way to store index data in data directory. --switch-output-* and
> --timestamp-filename use cases are not clear for data directories.
> Asynchronous(--aio) trace streaming and affinity (--affinity) modes are
> mutually exclusive to parallel streaming mode.
> 
> Basic analysis of data directories is provided in perf report mode.
> Raw dump and aggregated reports are available for data directories,
> still with no memory consumption optimizations.
> 
> Tested:
> 
> tools/perf/perf record -o prof.data --threads -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads= -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=cpu -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=core -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=socket -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=numa -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 2,5 --threads=0-3/3:4-7/4 --
> matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 3,4 --threads=0-3/3:4-7/4 --
> matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=core -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=numa -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 --
> matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 --
> compression-level=3 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads -a
> tools/perf/perf record -D -1 -e cpu-cycles -a --control fd:10,11 -- sleep 30
> tools/perf/perf record --threads -D -1 -e cpu-cycles -a --control fd:10,11 --
> sleep 30
> 
> tools/perf/perf report -i prof.data
> tools/perf/perf report -i prof.data --call-graph=callee
> tools/perf/perf report -i prof.data --stdio --header
> tools/perf/perf report -i prof.data -D --header
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b
> perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
> Alexey Bayduraev (24):
>   perf record: Introduce thread affinity and mmap masks
>   tools lib: Introduce fdarray duplicate function
>   perf record: Introduce thread specific data array
>   perf record: Introduce function to propagate control commands
>   perf record: Introduce thread local variable
>   perf record: Stop threads in the end of trace streaming
>   perf record: Start threads in the beginning of trace streaming
>   perf record: Introduce data file at mmap buffer object
>   perf record: Introduce bytes written stats to support --max-size
>     option
>   perf record: Introduce data transferred and compressed stats
>   perf record: Init data file at mmap buffer object
>   perf record: Introduce --threads command line option
>   perf record: Extend --threads command line option
>   perf record: Implement compatibility checks
>   perf report: Output non-zero offset for decompressed records
>   perf report: Output data file name in raw trace dump
>   perf session: Move reader structure to the top
>   perf session: Introduce reader_state in reader object
>   perf session: Introduce reader objects in session object
>   perf session: Introduce decompressor into trace reader object
>   perf session: Move init into reader__init function
>   perf session: Move map/unmap into reader__mmap function
>   perf session: Load single file for analysis
>   perf session: Load data directory files for analysis
> 
>  tools/lib/api/fd/array.c                 |   17 +
>  tools/lib/api/fd/array.h                 |    1 +
>  tools/perf/Documentation/perf-record.txt |   30 +
>  tools/perf/builtin-inject.c              |    3 +-
>  tools/perf/builtin-kvm.c                 |    2 +-
>  tools/perf/builtin-record.c              | 1197 ++++++++++++++++++++--
>  tools/perf/builtin-top.c                 |    2 +-
>  tools/perf/builtin-trace.c               |    2 +-
>  tools/perf/util/evlist.c                 |   16 +
>  tools/perf/util/evlist.h                 |    1 +
>  tools/perf/util/mmap.c                   |    6 +
>  tools/perf/util/mmap.h                   |    6 +
>  tools/perf/util/ordered-events.c         |    3 +-
>  tools/perf/util/ordered-events.h         |    3 +-
>  tools/perf/util/record.h                 |    2 +
>  tools/perf/util/session.c                |  506 ++++++---
>  tools/perf/util/session.h                |    7 +-
>  tools/perf/util/tool.h                   |    3 +-
>  18 files changed, 1593 insertions(+), 214 deletions(-)
> 



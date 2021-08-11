Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3380B3E96C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 19:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhHKRZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhHKRZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 13:25:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D870C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:24:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e19so5770219ejs.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DWvqc34M0ZK2EGSXjdGxz7cbJSBM1coi0S6xSk7PUWs=;
        b=BK9QzVTRpGyzDkoBFfdJJkKd90zIOGHtmLD9BA3YYgN3PCg5d76bwIyeGlRJxeb8gp
         FXb7ULf9R+RyPA4/UtYT3dlDeB7q7FTQsgm48gX0gR03Lv46niVG1xV05iQAWQrhj9EO
         xoJlSt9js7AswkJOjVbAAKUhxWOqEkKr+WUJOgNY+Y2RMLvUKG6DgXXNgjUlWTP5ml+w
         q2lali5/xGa1iinUbYkHppl4b8LTWSposqgeuKy+A0s+Rgofj6PsfQ24R6aU52pSm9s7
         LvHdkOUbve5lAE3r83irFFPInmsLWa+3WLfOV4EaB2IfqFtpeYcrD3birjbv8a7usSt9
         JXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DWvqc34M0ZK2EGSXjdGxz7cbJSBM1coi0S6xSk7PUWs=;
        b=E4Bh53+I/qgY1HZ/n9uuHMe0SGAUfenwbtLXvoGACk9IgWoUUfzbyeu7bZIi6ZNUCr
         5PJBIP/UdYL9ZGAb9oFlkRK4MDPE1QwF3T5JrghuRHnM3Qv7ZrwpxCHLqquxwXm80yhB
         V0TzlF65W1Lv4f+RHTFsBeeuRU8Qw5kOm6OPJN8b3qcdyJohgELlZ2bIbmUtZ6ozihJw
         4Dt7eFSPwkJcN01zCDjumdkoeVz/LP8Y20oeLdSwrFbf45BEwJQqdLFGuv9WSZFmmJUh
         UBnnzf39/1hcq7ZxEk7S59UJQL0rCDM/OB8ZgVi883qRkRXKmJPuSJofq8V5Bk9TF7pK
         rT2A==
X-Gm-Message-State: AOAM530BXdJ4oq+ON1X/7qM4f7vBDIZZ3VC7XoXYiTG4/TeM/BfzGXfO
        0P7wLX+dQin0W2XfeTNCMLo=
X-Google-Smtp-Source: ABdhPJwyZG/lpcm51dVxd3mZR0+m5pWb6e9cxagQte2oX7rh9ibDDzHMmBHHq5cFZIXzVb5n2QUQYg==
X-Received: by 2002:a17:907:7e89:: with SMTP id qb9mr4620756ejc.333.1628702685767;
        Wed, 11 Aug 2021 10:24:45 -0700 (PDT)
Received: from [172.16.0.82] (nat-allievi.sssup.it. [193.205.81.9])
        by smtp.gmail.com with ESMTPSA id fi23sm12984ejc.83.2021.08.11.10.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:24:45 -0700 (PDT)
Message-ID: <2039de9b117b11131b7ecc054cca800a3a71831f.camel@gmail.com>
Subject: Re: [PATCH v10 08/24] perf record: Introduce data file at mmap
 buffer object
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
Date:   Wed, 11 Aug 2021 19:24:42 +0200
In-Reply-To: <9f112977fb46418f6275fef45612c662d03db66d.1626072009.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
         <9f112977fb46418f6275fef45612c662d03db66d.1626072009.git.alexey.v.bayduraev@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2021-07-12 at 09:46 +0300, Alexey Bayduraev wrote:
> Introduce data file and compressor objects into mmap object so
> they could be used to process and store data stream from the
> corresponding kernel data buffer. Make use of the introduced
> per mmap file and compressor when they are initialized and
> available.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 3 +++
>  tools/perf/util/mmap.c      | 6 ++++++
>  tools/perf/util/mmap.h      | 3 +++
>  3 files changed, 12 insertions(+)

Testing this patch I encounter an issue with the perf test 19 ("import python"):
$ ./perf test 19 -vvv
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps,
etc
19: 'import perf' in python                                         :
--- start ---
test child forked, pid 147201
python usage test: "echo "import sys ; sys.path.append('python'); import perf" |
'/usr/bin/python2' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: python/perf.so: undefined symbol: zstd_fini
test child finished with -1
---- end ----
'import perf' in python: FAILED!

The problem is caused by the fact that the perf.so library for Python is not
compiled with -lzstd, but it includes mmap.c.
Since I don't think zstd_* functionality is used by Python, we can provide stub
functions instead of adding the zstd dependency to the Python library.

Thanks,
Riccardo

> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index cb8d320d20a9..d67a09e26792 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -197,6 +197,9 @@ static int record__write(struct record *rec, struct mmap
> *map __maybe_unused,
>  {
>         struct perf_data_file *file = &rec->session->data->file;
>  
> +       if (map && map->file)
> +               file = map->file;
> +
>         if (perf_data_file__write(file, bf, size) < 0) {
>                 pr_err("failed to write perf data, error: %m\n");
>                 return -1;
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index ab7108d22428..a2c5e4237592 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -230,6 +230,8 @@ void mmap__munmap(struct mmap *map)
>  {
>         bitmap_free(map->affinity_mask.bits);
>  
> +       zstd_fini(&map->zstd_data);
> +
>         perf_mmap__aio_munmap(map);
>         if (map->data != NULL) {
>                 munmap(map->data, mmap__mmap_len(map));
> @@ -291,6 +293,10 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp,
> int fd, int cpu)
>         map->core.flush = mp->flush;
>  
>         map->comp_level = mp->comp_level;
> +       if (zstd_init(&map->zstd_data, map->comp_level)) {
> +               pr_debug2("failed to init mmap commpressor, error %d\n", errno);
> +               return -1;
> +       }
>  
>         if (map->comp_level && !perf_mmap__aio_enabled(map)) {
>                 map->data = mmap(NULL, mmap__mmap_len(map),
> PROT_READ|PROT_WRITE,
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index 9d5f589f02ae..c4aed6e89549 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -13,6 +13,7 @@
>  #endif
>  #include "auxtrace.h"
>  #include "event.h"
> +#include "util/compress.h"
>  
>  struct aiocb;
>  
> @@ -43,6 +44,8 @@ struct mmap {
>         struct mmap_cpu_mask    affinity_mask;
>         void            *data;
>         int             comp_level;
> +       struct perf_data_file *file;
> +       struct zstd_data      zstd_data;
>  };
>  
>  struct mmap_params {



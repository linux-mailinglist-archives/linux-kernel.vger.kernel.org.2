Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DC03B7D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhF3GRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:17:25 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37646 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhF3GRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:17:23 -0400
Received: by mail-lf1-f44.google.com with SMTP id q16so2982491lfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 23:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DT1VEhZeNr6s/86X+UE2qNX8jcV0kx4gFWwnom6ABS4=;
        b=oDhg8dUYtTp60DJhcTrO5q8/7NBZk3yxXHda8IGFHrea1LdUqvKiwwaw1sTV097Bnh
         RJs9GPJTY3Pr75pu1AhW4OZ3kupqTCKVRW0EXvkDpcfLc9u6x+/XwnMccbO2+KzQPgEi
         hIQPZyFq/gbcmeVk9dqO9JD7nENlq3mgfwdZ0JJxay0yUuIpAJFNtGnjtMTg9fpUtwLv
         7x7AX2zCucqAaPTIcQqcqCuuNxhSK2Li3KdsJwzXcP6my0yZLJfP2FuCaq94UdAKQ9fj
         3f7D/zBGN5GtF4GLSktPCpfkhS88nnpMBVKdTbu5T2Cmwd1m9HxWoQTnYwDcN4Y9t7Ry
         QEHg==
X-Gm-Message-State: AOAM533aOhrx25eVQ0pIRK9FNeQuqbZdtWaatdcNAjDigIDP/2t9Zjy/
        LSBcmV89rsfxOlBg+V1ZX3mZuxsQKs6PWhrNU9Q=
X-Google-Smtp-Source: ABdhPJzVUm8mEQGDb5ltm4TiRDwvnTCYuBf2ChgxkI6CLtBVBm8rIKSrJ/zRybAaMLQQpnprnpeKFnFGu0adOwAPEqQ=
X-Received: by 2002:a19:4916:: with SMTP id w22mr27067838lfa.374.1625033694646;
 Tue, 29 Jun 2021 23:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com> <036fbbd11ffd0d0c9338ef61a0076685ac502000.1624350588.git.alexey.v.bayduraev@linux.intel.com>
In-Reply-To: <036fbbd11ffd0d0c9338ef61a0076685ac502000.1624350588.git.alexey.v.bayduraev@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Jun 2021 23:14:43 -0700
Message-ID: <CAM9d7cgL3zDc6F_i=95PHgVPaahuuShdBsudUaA9JnymyE2g6Q@mail.gmail.com>
Subject: Re: [PATCH v7 20/20] perf session: Load data directory files for analysis
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 1:43 AM Alexey Bayduraev
<alexey.v.bayduraev@linux.intel.com> wrote:
>
> Load data directory files and provide basic raw dump and aggregated
> analysis support of data directories in report mode, still with no
> memory consumption optimizations.
>
> Design and implementation are based on the prototype [1], [2].
>
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
>
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 129 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index fe25abf83b80..2c0eb126cdbb 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -65,6 +65,7 @@ struct reader_state {
>         u64      data_size;
>         u64      head;
>         bool     eof;
> +       u64      size;
>  };
>
>  enum {
> @@ -2322,6 +2323,7 @@ reader__read_event(struct reader *rd, struct perf_session *session,
>         if (skip)
>                 size += skip;
>
> +       st->size += size;
>         st->head += size;
>         st->file_pos += size;
>
> @@ -2421,6 +2423,130 @@ static int __perf_session__process_events(struct perf_session *session)
>         return err;
>  }
>
> +/*
> + * This function reads, merge and process directory data.
> + * It assumens the version 1 of directory data, where each
> + * data file holds per-cpu data, already sorted by kernel.
> + */
> +static int __perf_session__process_dir_events(struct perf_session *session)
> +{
> +       struct perf_data *data = session->data;
> +       struct perf_tool *tool = session->tool;
> +       int i, ret = 0, readers = 1;
> +       struct ui_progress prog;
> +       u64 total_size = perf_data__size(session->data);
> +       struct reader *rd;
> +
> +       perf_tool__fill_defaults(tool);
> +
> +       ui_progress__init_size(&prog, total_size, "Sorting events...");
> +
> +       for (i = 0; i < data->dir.nr; i++) {
> +               if (data->dir.files[i].size)
> +                       readers++;
> +       }
> +
> +       rd = session->readers = zalloc(readers * sizeof(struct reader));
> +       if (!rd)
> +               return -ENOMEM;
> +       session->nr_readers = readers;
> +       readers = 0;
> +
> +       rd[readers] = (struct reader) {
> +               .fd              = perf_data__fd(session->data),
> +               .path            = session->data->file.path,
> +               .data_size       = session->header.data_size,
> +               .data_offset     = session->header.data_offset,
> +               .in_place_update = session->data->in_place_update,
> +       };
> +       ret = reader__init(&rd[readers], NULL);
> +       if (ret)
> +               goto out_err;
> +       ret = reader__mmap(&rd[readers], session);
> +       if (ret != READER_OK) {
> +               if (ret == READER_EOF)
> +                       ret = -EINVAL;
> +               goto out_err;
> +       }
> +       readers++;
> +
> +       for (i = 0; i < data->dir.nr; i++) {
> +               if (data->dir.files[i].size) {

Just one more nitpicking. :)

You can save an indent depth by having

        if (!data->dir.files[i].size)
            continue;

Thanks,
Namhyung


> +                       rd[readers] = (struct reader) {
> +                               .fd              = data->dir.files[i].fd,
> +                               .path            = data->dir.files[i].path,
> +                               .data_size       = data->dir.files[i].size,
> +                               .data_offset     = 0,
> +                               .in_place_update = session->data->in_place_update,
> +                       };
> +                       ret = reader__init(&rd[readers], NULL);
> +                       if (ret)
> +                               goto out_err;
> +                       ret = reader__mmap(&rd[readers], session);
> +                       if (ret != READER_OK) {
> +                               if (ret == READER_EOF)
> +                                       ret = -EINVAL;
> +                               goto out_err;
> +                       }
> +                       readers++;
> +               }
> +       }

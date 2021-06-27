Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017643B50AF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 02:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhF0Avu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 20:51:50 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:41930 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhF0Avt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 20:51:49 -0400
Received: by mail-lf1-f44.google.com with SMTP id j4so23989652lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 17:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQccB20CQF5Dr5LsObv3HRFh/UxoVEFfeObD4BLsXKY=;
        b=gWbxf83r3lrfcCgW4h/laqRJGtNeLMvDuNsYAzTssoJE4yQHG8KMxKfi0tVUlbwWBm
         9+AgINwoVl5rslJj0AEdubdl1RuG/L3kFlf1wdrUT6tUyD1SIoOHS+Fh5308Y0qkaTHI
         8XYcCMVhdyoztC6W4uQf9O9zPAoaBVJyt5XKgyzY1KVUtuTiaLL5dwBFRZ5axkxQ2go8
         uHm1tVeLUloC429waMhL99G9QfP/UVctAR9KfKAGlqThKOFHdtxSlJEb/+TBtBSfRaCa
         iI52Ngn9kHEq4183YmseN9cEnblv+e4rbz/B0aY6tdSlKSLJA/DNvNYJ2qY7R6ytwszt
         a8HA==
X-Gm-Message-State: AOAM531zJte8bnRszyyXIC4Exqi1TU5hyfBdmZ9ItztSmOOCxedliBFz
        q2fM5/aJfEPe6C/eRpTeloEqPFyOSph/gYanzg4=
X-Google-Smtp-Source: ABdhPJyUNBTc/qh3LL075sZxc2OLFebC8zgHnNtcQQB4r7HMeJtizgRB3aJnw48cxIBU6sUlVPdv4vFs+WWvl9tIKrA=
X-Received: by 2002:a05:6512:1291:: with SMTP id u17mr7613772lfs.300.1624754964035;
 Sat, 26 Jun 2021 17:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com> <32d8135b4d3b5df28c234bab774b65e7f0b85727.1624350588.git.alexey.v.bayduraev@linux.intel.com>
In-Reply-To: <32d8135b4d3b5df28c234bab774b65e7f0b85727.1624350588.git.alexey.v.bayduraev@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 26 Jun 2021 17:49:13 -0700
Message-ID: <CAM9d7ci0OF3MLRoH3sZ=kYgfw0C7PBeYqgmun0mmas2U84NwkA@mail.gmail.com>
Subject: Re: [PATCH v7 19/20] perf session: Load single file for analysis
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
> Adding eof flag to reader state and moving the check to reader__mmap.
> Separating reading code of single event into reader__read_event function.
> Adding basic reader return codes to simplify the code and introducing
> reader remmap/read_event loop based on them.
>
> Design and implementation are based on the prototype [1], [2].
>
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
>
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 71 ++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 27 deletions(-)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7d91205a6a47..fe25abf83b80 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -64,6 +64,12 @@ struct reader_state {
>         u64      file_offset;
>         u64      data_size;
>         u64      head;
> +       bool     eof;
> +};
> +
> +enum {
> +       READER_EOF      =  0,
> +       READER_OK       =  1,

Just a nitpick, it might be better to add READER_NODATA state
to differentiate it from the real end-of-file state.

Thanks,
Namhyung


>  };
>
>  struct reader {
> @@ -2245,6 +2251,11 @@ reader__mmap(struct reader *rd, struct perf_session *session)
>         char *buf, **mmaps = st->mmaps;
>         u64 page_offset;
>
> +       if (st->file_pos >= st->data_size) {
> +               st->eof = true;
> +               return READER_EOF;
> +       }
> +
>         mmap_prot  = PROT_READ;
>         mmap_flags = MAP_SHARED;
>
> @@ -2273,36 +2284,26 @@ reader__mmap(struct reader *rd, struct perf_session *session)
>         mmaps[st->mmap_idx] = st->mmap_cur = buf;
>         st->mmap_idx = (st->mmap_idx + 1) & (ARRAY_SIZE(st->mmaps) - 1);
>         st->file_pos = st->file_offset + st->head;
> -       return 0;
> +       return READER_OK;
>  }
>
>  static int
> -reader__process_events(struct reader *rd, struct perf_session *session,
> -                      struct ui_progress *prog)
> +reader__read_event(struct reader *rd, struct perf_session *session,
> +                  struct ui_progress *prog)
>  {
>         struct reader_state *st = &rd->state;
> -       u64 size;
> -       int err = 0;
> +       int err = READER_OK;
>         union perf_event *event;
> +       u64 size;
>         s64 skip;
>
> -remap:
> -       err = reader__mmap(rd, session);
> -       if (err)
> -               goto out;
> -       if (session->one_mmap) {
> -               session->one_mmap_addr   = rd->state.mmap_cur;
> -               session->one_mmap_offset = rd->state.file_offset;
> -       }
> -
> -more:
>         event = fetch_mmaped_event(st->head, st->mmap_size, st->mmap_cur,
>                                    session->header.needs_swap);
>         if (IS_ERR(event))
>                 return PTR_ERR(event);
>
>         if (!event)
> -               goto remap;
> +               return READER_EOF;
>
>         session->active_reader = rd;
>         size = event->header.size;
> @@ -2324,18 +2325,12 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>         st->head += size;
>         st->file_pos += size;
>
> -       err = __perf_session__process_decomp_events(session);
> -       if (err)
> -               goto out;
> +       skip = __perf_session__process_decomp_events(session);
> +       if (skip)
> +               err = skip;
>
>         ui_progress__update(prog, size);
>
> -       if (session_done())
> -               goto out;
> -
> -       if (st->file_pos < st->data_size)
> -               goto more;
> -
>  out:
>         session->active_reader = NULL;
>         return err;
> @@ -2379,9 +2374,31 @@ static int __perf_session__process_events(struct perf_session *session)
>         err = reader__init(rd, &session->one_mmap);
>         if (err)
>                 goto out_err;
> -       err = reader__process_events(rd, session, &prog);
> -       if (err)
> +       err = reader__mmap(rd, session);
> +       if (err != READER_OK) {
> +               if (err == READER_EOF)
> +                       err = -EINVAL;
>                 goto out_err;
> +       }
> +       if (session->one_mmap) {
> +               session->one_mmap_addr   = rd->state.mmap_cur;
> +               session->one_mmap_offset = rd->state.file_offset;
> +       }
> +
> +       while (true) {
> +               if (session_done())
> +                       break;
> +
> +               err = reader__read_event(rd, session, &prog);
> +               if (err < 0)
> +                       break;
> +               if (err == READER_EOF) {
> +                       err = reader__mmap(rd, session);
> +                       if (err <= 0)
> +                               break;
> +               }
> +       }
> +
>         /* do the final flush for ordered samples */
>         err = ordered_events__flush(oe, OE_FLUSH__FINAL);
>         if (err)
> --
> 2.19.0
>

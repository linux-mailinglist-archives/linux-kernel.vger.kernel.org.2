Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D640819D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 22:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhILUqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 16:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236221AbhILUqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 16:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631479516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUTEI9jivCvX2npWU76MJWD92Hw5eMDEWvqh5k+r+f4=;
        b=CD+JuR1MJh/dPExfsBVibF1iQHtysqvzzAv3/io+f9VrMd/FMfnG+JDphWOcbLMe3QkfVK
        YTlsJHpLtz7YsKJViNkNt4TW/6migkV88pl5zO6IQ2mU0wsJD+IwzjWZSPmfHh284bsAS+
        YjinF8g6D3IatakHudiKbW4sMVLr3SA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-USmUxEBlObS3ZbNl2gdKkw-1; Sun, 12 Sep 2021 16:45:15 -0400
X-MC-Unique: USmUxEBlObS3ZbNl2gdKkw-1
Received: by mail-ed1-f71.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so3856728edy.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 13:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZUTEI9jivCvX2npWU76MJWD92Hw5eMDEWvqh5k+r+f4=;
        b=zwTlIDFBlInTRgX1+E/x39TdOz49v/Em5aIgfYqaC+Apygy6Rs/wbAI8N59FZHvQH2
         pDZ1l6doxm7JlL8t37Bc8D2ioyQ/K3Hrelsc3hqrGWUsgkgqVGkZgve/hGUGQei4LoHK
         MkIjBcYNXh1P+WjWP27biRGc7Dkn/DhhI/8OyP5+SLiVX1uDpt8XTK1NBnInYJitwJNU
         /uohDfMT7vKnLgrzTek2eLOV8AEpgqm0wJub+q5bKsNY6UYkf8FmPQyAGY1OZIR5brA9
         AQHKJKonuDZY2r9gKFkkaftXCSN7naJnWhxoVWZpmDqU9np7g6j8xDeSNVpYCb4MB5et
         so0A==
X-Gm-Message-State: AOAM533x0BdQXRd3xfvAqggJm0+FuMW9U58yljdf9RJmPBopMrLm4h5H
        aK2A0Fgiyrlljmosgrq4qx0ia9hjOysE6SlW6GMKhyZhBuc785rn8kOHpNz4rbMpKM1bF+pl/nP
        tYG+vP1+pNrmw5VwbZFfB0ifA
X-Received: by 2002:a17:907:1de0:: with SMTP id og32mr9101820ejc.348.1631479513769;
        Sun, 12 Sep 2021 13:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvewel1s/+4FR6FLGRlHqvu0HBx35I8s0LJilUv/GU30+CDzLvg2XhOO2mbB3vVFbj00iEfg==
X-Received: by 2002:a17:907:1de0:: with SMTP id og32mr9101799ejc.348.1631479513579;
        Sun, 12 Sep 2021 13:45:13 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id o22sm2844711edi.89.2021.09.12.13.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:45:13 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:45:11 +0200
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
Subject: Re: [PATCH v11 24/24] perf session: Load data directory files for
 analysis
Message-ID: <YT5m18X9Mve2xgE3@krava>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
 <03e17b23b46647db7a71b9255ed2e3cd0cfd76e2.1629186429.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e17b23b46647db7a71b9255ed2e3cd0cfd76e2.1629186429.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:23:27AM +0300, Alexey Bayduraev wrote:
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
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 131 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index b49b52768681..f5a82f66e36b 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -48,6 +48,13 @@
>  #define NUM_MMAPS 128
>  #endif
>  
> +/*
> + * Processing 10MBs of data from each reader in sequence,
> + * because that's the way the ordered events sorting works
> + * most efficiently.
> + */
> +#define READER_MAX_SIZE (10 * 1024 * 1024)

why 10? ;-) I think we discussed this in your earlier iteration,
I put the 10M there to speedup the processing, because it worked
on my current data file for the test at that time

I think this needs some better justification and some setup based
on the env setup and data size perhaps?

jirka

> +
>  struct reader;
>  
>  typedef s64 (*reader_cb_t)(struct perf_session *session,
> @@ -65,6 +72,7 @@ struct reader_state {
>  	u64	 data_size;
>  	u64	 head;
>  	bool	 eof;
> +	u64	 size;
>  };
>  
>  enum {
> @@ -2328,6 +2336,7 @@ reader__read_event(struct reader *rd, struct perf_session *session,
>  	if (skip)
>  		size += skip;
>  
> +	st->size += size;
>  	st->head += size;
>  	st->file_pos += size;
>  
> @@ -2427,6 +2436,125 @@ static int __perf_session__process_events(struct perf_session *session)
>  	return err;
>  }
>  
> +/*
> + * This function reads, merge and process directory data.
> + * It assumens the version 1 of directory data, where each
> + * data file holds per-cpu data, already sorted by kernel.
> + */
> +static int __perf_session__process_dir_events(struct perf_session *session)
> +{
> +	struct perf_data *data = session->data;
> +	struct perf_tool *tool = session->tool;
> +	int i, ret = 0, readers = 1;
> +	struct ui_progress prog;
> +	u64 total_size = perf_data__size(session->data);
> +	struct reader *rd;
> +
> +	perf_tool__fill_defaults(tool);
> +
> +	ui_progress__init_size(&prog, total_size, "Sorting events...");
> +
> +	for (i = 0; i < data->dir.nr; i++) {
> +		if (data->dir.files[i].size)
> +			readers++;
> +	}
> +
> +	rd = session->readers = zalloc(readers * sizeof(struct reader));
> +	if (!rd)
> +		return -ENOMEM;
> +	session->nr_readers = readers;
> +	readers = 0;
> +
> +	rd[readers] = (struct reader) {
> +		.fd		 = perf_data__fd(session->data),
> +		.path		 = session->data->file.path,
> +		.data_size	 = session->header.data_size,
> +		.data_offset	 = session->header.data_offset,
> +		.in_place_update = session->data->in_place_update,
> +	};
> +	ret = reader__init(&rd[readers], NULL);
> +	if (ret)
> +		goto out_err;
> +	ret = reader__mmap(&rd[readers], session);
> +	if (ret != READER_OK) {
> +		if (ret == READER_EOF)
> +			ret = -EINVAL;
> +		goto out_err;
> +	}
> +	readers++;
> +
> +	for (i = 0; i < data->dir.nr; i++) {
> +		if (!data->dir.files[i].size)
> +			continue;
> +		rd[readers] = (struct reader) {
> +			.fd		 = data->dir.files[i].fd,
> +			.path		 = data->dir.files[i].path,
> +			.data_size	 = data->dir.files[i].size,
> +			.data_offset	 = 0,
> +			.in_place_update = session->data->in_place_update,
> +		};
> +		ret = reader__init(&rd[readers], NULL);
> +		if (ret)
> +			goto out_err;
> +		ret = reader__mmap(&rd[readers], session);
> +		if (ret != READER_OK) {
> +			if (ret == READER_EOF)
> +				ret = -EINVAL;
> +			goto out_err;
> +		}
> +		readers++;
> +	}
> +
> +	i = 0;
> +
> +	while ((ret >= 0) && readers) {
> +		if (session_done())
> +			return 0;
> +
> +		if (rd[i].state.eof) {
> +			i = (i + 1) % session->nr_readers;
> +			continue;
> +		}
> +
> +		ret = reader__read_event(&rd[i], session, &prog);
> +		if (ret < 0)
> +			break;
> +		if (ret == READER_NODATA) {
> +			ret = reader__mmap(&rd[i], session);
> +			if (ret < 0)
> +				goto out_err;
> +			if (ret == READER_EOF)
> +				readers--;
> +		}
> +
> +		if (rd[i].state.size >= READER_MAX_SIZE) {
> +			rd[i].state.size = 0;
> +			i = (i + 1) % session->nr_readers;
> +		}
> +	}
> +
> +	ret = ordered_events__flush(&session->ordered_events, OE_FLUSH__FINAL);
> +	if (ret)
> +		goto out_err;
> +
> +	ret = perf_session__flush_thread_stacks(session);
> +out_err:
> +	ui_progress__finish();
> +
> +	if (!tool->no_warn)
> +		perf_session__warn_about_errors(session);
> +
> +	/*
> +	 * We may switching perf.data output, make ordered_events
> +	 * reusable.
> +	 */
> +	ordered_events__reinit(&session->ordered_events);
> +
> +	session->one_mmap = false;
> +
> +	return ret;
> +}
> +
>  int perf_session__process_events(struct perf_session *session)
>  {
>  	if (perf_session__register_idle_thread(session) < 0)
> @@ -2435,6 +2563,9 @@ int perf_session__process_events(struct perf_session *session)
>  	if (perf_data__is_pipe(session->data))
>  		return __perf_session__process_pipe_events(session);
>  
> +	if (perf_data__is_dir(session->data))
> +		return __perf_session__process_dir_events(session);
> +
>  	return __perf_session__process_events(session);
>  }
>  
> -- 
> 2.19.0
> 


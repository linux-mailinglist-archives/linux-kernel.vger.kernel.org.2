Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4694210C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbhJDNzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238848AbhJDNze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633355625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SjiqCe1WXquiLhVIPByl+3ted+KJ0U1joYjc6FrtzUo=;
        b=e7ldN1U9A/RBV57GVJvB1t1seYEEIuzSghanNYfdCmDeVsvvwkd7TZwkjZFbPbJ/wOYrDy
        uk2BNMnipDwVRPQG1u6qPTuEo9oB9P+5QjstQcDyw0c63LRVjA63/z85q2nTMMPs2sGgN+
        2AOgEsfZLko/kHMLSm+mE5PySqxxTjw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Lo5VqxOEOz-mRqF36Y99GA-1; Mon, 04 Oct 2021 09:53:44 -0400
X-MC-Unique: Lo5VqxOEOz-mRqF36Y99GA-1
Received: by mail-wm1-f70.google.com with SMTP id u3-20020a7bcb03000000b0030d5228cbbdso4220752wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SjiqCe1WXquiLhVIPByl+3ted+KJ0U1joYjc6FrtzUo=;
        b=CBYQ9cJ46Shqq1EAYouUhGlSRQCY4yhT7tiCEW+wg0sVhZaScRSlJaXXf5s7+NG3/e
         Cnn7kwkTAnU263YAjJT36H3SM4S80Usg6RRxI70MR0hOaDEYpehjQWvCUFtMqc/dym3h
         RJNYuKVrjHHs46I5WFJTXhJ/ZWdaBiisgj9Va3qpKsKbVPvNz2uXlr7ZBQNW5VhauYCt
         a9VyNEeiOoj/QnGwPH4LdlXNQcDMZj61X6NiC6xfnvC70rws54pU0V4+FRTOjb/MOib9
         Qa7NZH9fzSEjHMWTbRvczV8jIvbWHiW3V1epYJk7z+Mj+z9v0X4o4iadZI9cuH7PYOv1
         fiZQ==
X-Gm-Message-State: AOAM530z2zgi1rzTMARrg4vd4pmR+X4ARU4/u7yA7lP/wjaN6fR+VLVS
        VwmoCymISZ8YFWnLLb8wfa31ZWuKUGmJSOD9WADt7m9a5L2dGswmdbnhvPZUQnE+Fr8gibXkRSW
        ZnBsY0LhU3puH+9IOT7F48U85
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr14800275wrr.187.1633355622974;
        Mon, 04 Oct 2021 06:53:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdNcMFE7O/RgORwomC8NrpVi0wva8fQZqrL2StVNFKKcI/YaP2oUjHldUqOFCg9wMgRidE3Q==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr14800246wrr.187.1633355622769;
        Mon, 04 Oct 2021 06:53:42 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id g1sm17440877wmk.2.2021.10.04.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:53:42 -0700 (PDT)
Date:   Mon, 4 Oct 2021 15:53:40 +0200
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
Subject: Re: [PATCH 3/6] perf session: Introduce decompressor into reader
 object
Message-ID: <YVsHZCv6mGdO7jGv@krava>
References: <cover.1632900802.git.alexey.v.bayduraev@linux.intel.com>
 <92dd8a7b9cf92f856cdd38114fc33eda4c5aba1a.1632900802.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92dd8a7b9cf92f856cdd38114fc33eda4c5aba1a.1632900802.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:41:51AM +0300, Alexey Bayduraev wrote:
> Introduce decompressor into reader object so that decompression
> could be executed separately for each data file. Adding active_reader
> into perf_session object to select current decompressor.
> 
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 48 +++++++++++++++++++++++++++++----------
>  tools/perf/util/session.h |  2 ++
>  2 files changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 262efc18caac..3bea0830b3b8 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -71,6 +71,9 @@ struct reader {
>  	u64		 data_offset;
>  	reader_cb_t	 process;
>  	bool		 in_place_update;
> +	struct zstd_data zstd_data;
> +	struct decomp	 *decomp;
> +	struct decomp	 *decomp_last;

so reader and session share the same fields, I think it'd be better
if we put them to the new struct.. perhaps have something like:

  struct compress {
    struct zstd_data zstd_data;
    struct decomp    *decomp;
    struct decomp    *decomp_last;
  }

  struct session {
    ...
    struct compress *compress;   /* initialized to &compress_lcl */
    struct compress compress_lcl;
  }

  struct reader {
    ...
    struct compress compress;
  }


reader__process_events will set session->compress to &reader->compress

perf_session__process_compressed_event would always work with
compress pointer.. this would ease up following code as well

also I don't like the idea sharing the whole reader with session,
it'll be abused.. let's give up gradually ;-)

thanks,
jirka

>  	struct reader_state state;
>  };
>  
> @@ -82,7 +85,10 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  	size_t decomp_size, src_size;
>  	u64 decomp_last_rem = 0;
>  	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
> -	struct decomp *decomp, *decomp_last = session->decomp_last;
> +	struct decomp *decomp, *decomp_last = session->active_reader ?
> +		session->active_reader->decomp_last : session->decomp_last;
> +	struct zstd_data *zstd_data = session->active_reader ?
> +		&session->active_reader->zstd_data : &session->zstd_data;
>  
>  	if (decomp_last) {
>  		decomp_last_rem = decomp_last->size - decomp_last->head;
> @@ -109,7 +115,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  	src = (void *)event + sizeof(struct perf_record_compressed);
>  	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
>  
> -	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
> +	decomp_size = zstd_decompress_stream(zstd_data, src, src_size,
>  				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
>  	if (!decomp_size) {
>  		munmap(decomp, mmap_len);
> @@ -119,12 +125,22 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  
>  	decomp->size += decomp_size;
>  
> -	if (session->decomp == NULL) {
> -		session->decomp = decomp;
> -		session->decomp_last = decomp;
> +	if (session->active_reader) {
> +		if (session->active_reader->decomp == NULL) {
> +			session->active_reader->decomp = decomp;
> +			session->active_reader->decomp_last = decomp;
> +		} else {
> +			session->active_reader->decomp_last->next = decomp;
> +			session->active_reader->decomp_last = decomp;
> +		}
>  	} else {
> -		session->decomp_last->next = decomp;
> -		session->decomp_last = decomp;
> +		if (session->decomp == NULL) {
> +			session->decomp = decomp;
> +			session->decomp_last = decomp;
> +		} else {
> +			session->decomp_last->next = decomp;
> +			session->decomp_last = decomp;
> +		}
>  	}
>  
>  	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
> @@ -314,11 +330,11 @@ static void perf_session__delete_threads(struct perf_session *session)
>  	machine__delete_threads(&session->machines.host);
>  }
>  
> -static void perf_session__release_decomp_events(struct perf_session *session)
> +static void perf_decomp__release_events(struct decomp *next)
>  {
> -	struct decomp *next, *decomp;
> +	struct decomp *decomp;
>  	size_t mmap_len;
> -	next = session->decomp;
> +
>  	do {
>  		decomp = next;
>  		if (decomp == NULL)
> @@ -337,7 +353,7 @@ void perf_session__delete(struct perf_session *session)
>  	auxtrace_index__free(&session->auxtrace_index);
>  	perf_session__destroy_kernel_maps(session);
>  	perf_session__delete_threads(session);
> -	perf_session__release_decomp_events(session);
> +	perf_decomp__release_events(session->decomp);
>  	perf_env__exit(&session->header.env);
>  	machines__exit(&session->machines);
>  	if (session->data) {
> @@ -2155,7 +2171,8 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>  {
>  	s64 skip;
>  	u64 size, file_pos = 0;
> -	struct decomp *decomp = session->decomp_last;
> +	struct decomp *decomp = session->active_reader ?
> +		session->active_reader->decomp_last : session->decomp_last;
>  
>  	if (!decomp)
>  		return 0;
> @@ -2212,6 +2229,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  
>  	memset(mmaps, 0, sizeof(st->mmaps));
>  
> +	if (zstd_init(&rd->zstd_data, 0))
> +		return -1;
> +
>  	mmap_prot  = PROT_READ;
>  	mmap_flags = MAP_SHARED;
>  
> @@ -2255,6 +2275,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		goto remap;
>  	}
>  
> +	session->active_reader = rd;
>  	size = event->header.size;
>  
>  	skip = -EINVAL;
> @@ -2287,6 +2308,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		goto more;
>  
>  out:
> +	session->active_reader = NULL;
> +	perf_decomp__release_events(rd->decomp);
> +	zstd_fini(&rd->zstd_data);
>  	return err;
>  }
>  
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index 5d8bd14a0a39..45f9f652a12a 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -19,6 +19,7 @@ struct thread;
>  
>  struct auxtrace;
>  struct itrace_synth_opts;
> +struct reader;
>  
>  struct perf_session {
>  	struct perf_header	header;
> @@ -41,6 +42,7 @@ struct perf_session {
>  	struct zstd_data	zstd_data;
>  	struct decomp		*decomp;
>  	struct decomp		*decomp_last;
> +	struct reader           *active_reader;
>  };
>  
>  struct decomp {
> -- 
> 2.19.0
> 


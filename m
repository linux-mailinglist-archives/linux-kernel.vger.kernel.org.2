Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E35420EBD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhJDN1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237002AbhJDNZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633353832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=omyaL7V/zGuToF3d7+rNPUvMsXZfCywlgRbnN604H4Y=;
        b=LCB0k6BPErJz2BlCP9K9uIAtwwLbr2wSUcEzTAPTfHz8vwUj8A0Tk4fU/Ko4E6n7y+iLw7
        2iVYqC1PZ5WPF6EhO1dkifHUwBtz3SUTtmtivbY8GZChBsBriaV8QHN7QlbdicmgToHPVn
        Hp30jVS+HdWLVacmc0HEKKNbQYh+klA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-jQ6Evz3AME-80VAJRPjqSA-1; Mon, 04 Oct 2021 09:22:52 -0400
X-MC-Unique: jQ6Evz3AME-80VAJRPjqSA-1
Received: by mail-wm1-f69.google.com with SMTP id 129-20020a1c1987000000b0030cd1616fbfso9960050wmz.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=omyaL7V/zGuToF3d7+rNPUvMsXZfCywlgRbnN604H4Y=;
        b=YhkmuhCA3EWw/OJVSZQ4015963OXhlzBAC0cDiSP/a0g5+ABrtE/70kPcm+iB+FrBI
         MPZpq5TghtFMhKqnCuNz+1tLZnpY3D1HI+ihMJgboYCRQ5khBvvyViDrqoPM2LdCQ5ka
         gqd73FqUo5druFJOV8nRdNd0NIaILZQhJ+dWTghRk/1X0621EPKuFKDEYmvKYO6ci2a/
         DFmf/ZVXD6R1+jCNYAcnyny6Phdhx8xcuBItr76tgQas9E2jRvvzhtCbeqlE0Qne1xOE
         qipF0EpOgTZs7DyKOYbccoomaykTMjlm4yxz1lpkJ16SKWaMoD9TA8oOucwaFFf934eB
         9X6g==
X-Gm-Message-State: AOAM5312xdTa7NPev2WBWGviwpCZxcZ36juBiRmCi9zybxzES9Z2jY8k
        5CRUQ7tVke/040NEGY9NmcYNGcaPY5XOORb644YSQirBjRlRALsbHAXNAiv3a7EQe7K6UmQ/Iui
        PLEbYlEsCrxLFkg55D3iDwWok
X-Received: by 2002:a05:600c:190b:: with SMTP id j11mr18512386wmq.138.1633353771624;
        Mon, 04 Oct 2021 06:22:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY48hpm0ZVWshCalC956BzRGOIjoO9NyzRz5QVpczhfvSjQSkOixVDFuC6r6hS5n3DQhQsyg==
X-Received: by 2002:a05:600c:190b:: with SMTP id j11mr18512365wmq.138.1633353771416;
        Mon, 04 Oct 2021 06:22:51 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id k9sm14165530wrz.22.2021.10.04.06.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:22:51 -0700 (PDT)
Date:   Mon, 4 Oct 2021 15:22:49 +0200
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
Subject: Re: [PATCH 6/6] perf session: Load single file for analysis
Message-ID: <YVsAKZCvddSBsDcM@krava>
References: <cover.1632900802.git.alexey.v.bayduraev@linux.intel.com>
 <8b3596e5b07af8d90ae76438e6d052058fd76d4f.1632900802.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b3596e5b07af8d90ae76438e6d052058fd76d4f.1632900802.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:41:54AM +0300, Alexey Bayduraev wrote:
> Adding EOF flag to reader state and moving the check to reader__mmap.
> Separating reading code of single event into reader__read_event function.
> Adding basic reader return codes to simplify the code and introducing
> remap/read_event loop in __perf_session__process_events.
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 72 ++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5e08def72b41..9a4fe78a7a54 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -63,6 +63,13 @@ struct reader_state {
>  	u64	 file_offset;
>  	u64	 data_size;
>  	u64	 head;
> +	bool	 eof;

what's this flag for? I can't see it being used

jirka

> +};
> +
> +enum {
> +	READER_EOF,
> +	READER_NODATA,
> +	READER_OK,
>  };
>  
>  struct reader {
> @@ -2242,6 +2249,11 @@ reader__mmap(struct reader *rd, struct perf_session *session)
>  	char *buf, **mmaps = st->mmaps;
>  	u64 page_offset;
>  
> +	if (st->file_pos >= st->data_size) {
> +		st->eof = true;
> +		return READER_EOF;
> +	}
> +
>  	mmap_prot  = PROT_READ;
>  	mmap_flags = MAP_SHARED;
>  
> @@ -2270,36 +2282,26 @@ reader__mmap(struct reader *rd, struct perf_session *session)
>  	mmaps[st->mmap_idx] = st->mmap_cur = buf;
>  	st->mmap_idx = (st->mmap_idx + 1) & (ARRAY_SIZE(st->mmaps) - 1);
>  	st->file_pos = st->file_offset + st->head;
> -	return 0;
> +	return READER_OK;
>  }
>  
>  static int
> -reader__process_events(struct reader *rd, struct perf_session *session,
> -		       struct ui_progress *prog)
> +reader__read_event(struct reader *rd, struct perf_session *session,
> +		   struct ui_progress *prog)
>  {
>  	struct reader_state *st = &rd->state;
> -	u64 size;
> -	int err = 0;
> +	int err = READER_OK;
>  	union perf_event *event;
> +	u64 size;
>  	s64 skip;
>  
> -remap:
> -	err = reader__mmap(rd, session);
> -	if (err)
> -		goto out;
> -	if (session->one_mmap) {
> -		session->one_mmap_addr   = rd->state.mmap_cur;
> -		session->one_mmap_offset = rd->state.file_offset;
> -	}
> -
> -more:
>  	event = fetch_mmaped_event(st->head, st->mmap_size, st->mmap_cur,
>  				   session->header.needs_swap);
>  	if (IS_ERR(event))
>  		return PTR_ERR(event);
>  
>  	if (!event)
> -		goto remap;
> +		return READER_NODATA;
>  
>  	session->active_reader = rd;
>  	size = event->header.size;
> @@ -2321,18 +2323,12 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  	st->head += size;
>  	st->file_pos += size;
>  
> -	err = __perf_session__process_decomp_events(session);
> -	if (err)
> -		goto out;
> +	skip = __perf_session__process_decomp_events(session);
> +	if (skip)
> +		err = skip;
>  
>  	ui_progress__update(prog, size);
>  
> -	if (session_done())
> -		goto out;
> -
> -	if (st->file_pos < st->data_size)
> -		goto more;
> -
>  out:
>  	session->active_reader = NULL;
>  	return err;
> @@ -2369,9 +2365,31 @@ static int __perf_session__process_events(struct perf_session *session)
>  	err = reader__init(&rd, &session->one_mmap);
>  	if (err)
>  		goto out_err;
> -	err = reader__process_events(&rd, session, &prog);
> -	if (err)
> +	err = reader__mmap(&rd, session);
> +	if (err != READER_OK) {
> +		if (err == READER_EOF)
> +			err = -EINVAL;
>  		goto out_err;
> +	}
> +	if (session->one_mmap) {
> +		session->one_mmap_addr   = rd.state.mmap_cur;
> +		session->one_mmap_offset = rd.state.file_offset;
> +	}
> +
> +	while (true) {
> +		if (session_done())
> +			break;
> +
> +		err = reader__read_event(&rd, session, &prog);
> +		if (err < 0)
> +			break;
> +		if (err == READER_NODATA) {
> +			err = reader__mmap(&rd, session);
> +			if (err <= 0)
> +				break;
> +		}
> +	}
> +
>  	/* do the final flush for ordered samples */
>  	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
>  	if (err)
> -- 
> 2.19.0
> 


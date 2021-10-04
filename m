Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1503420EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbhJDN2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234692AbhJDN0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633353855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKmcry6fVTlDz66U0TCFhihO0+fUZfhzODGbILt2OaM=;
        b=XTIOqP41yCehLTuD8N8dpGnxSF6fP/6DMImccOGXAFhjQP60zqCYklZSYHfZLiZkgSPHhz
        /mAdY9HOftfbZ+ztJPPlmN9S6MrtWweubfMqz58dxIl0YyPLgLK4HkhwBTJ2zEpdCE/7Fi
        yfq7S0i1EZuuGF3SJI3zuqOoRd5jn7g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-xr-Emo3cOHqX02yMFSw9hA-1; Mon, 04 Oct 2021 09:24:14 -0400
X-MC-Unique: xr-Emo3cOHqX02yMFSw9hA-1
Received: by mail-wm1-f72.google.com with SMTP id m9-20020a05600c4f4900b003057c761567so9982748wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JKmcry6fVTlDz66U0TCFhihO0+fUZfhzODGbILt2OaM=;
        b=cedvphQNtMrlNrM0rdrePzVOB9oHItwQoEypj93wi9c3LTAkAGBCjeLD+WuqlRlPtV
         JLBzSsSO83P0Wx+NKbHCKPzn8ze54fzEhDMoQquRJXtpAzkODEYW+7/Ns9YD4uPPqAzM
         sk2KCNMaoHi7UFeIlfjEMztQbNHDURJoKMEv+Aa5CEivLEmwqMzmRuLGjZTFgGm5p7rP
         G/pUMMpv8hD5SdIFo6KiUPfDqRzbjcZynDW8WZXLkn3ErVq9jnWYZjGwsDY+zzAUUOUa
         Maw420chJG0EF/kReOjZI8o/W/PkVvg7pfMQOIN7nr7Pe02A4b1262hRwrtmVHQnbO32
         bK0w==
X-Gm-Message-State: AOAM530me0HfbJyupzLssCXhj3GDiVUFzRK4/3Q65jfuipGERfs9k/rm
        r4PKDO37VfGcRQKKU9CbR4czHp8GwWZ0lhJzjXxk5W+kUpEC9/q51FEE3qONCOSafSVVbsj3TIg
        9glconEUwZ5OooEO9BQrxc0GJ
X-Received: by 2002:a05:600c:21d6:: with SMTP id x22mr19031692wmj.121.1633353852890;
        Mon, 04 Oct 2021 06:24:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzEuPqUum6oIiowRPZ0M+/txMByjMSdIdHUILY03hsMcIztwLCk9tRRdS+BSkVhkcNhn6bKg==
X-Received: by 2002:a05:600c:21d6:: with SMTP id x22mr19031671wmj.121.1633353852733;
        Mon, 04 Oct 2021 06:24:12 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id a2sm798475wru.82.2021.10.04.06.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:24:12 -0700 (PDT)
Date:   Mon, 4 Oct 2021 15:24:10 +0200
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
Subject: Re: [PATCH 5/6] perf session: Move map/unmap into reader__mmap
 function
Message-ID: <YVsAejiXaMAfUHM+@krava>
References: <cover.1632900802.git.alexey.v.bayduraev@linux.intel.com>
 <212fc917cbc0c26da042c3571c67bf0f4696aba8.1632900802.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <212fc917cbc0c26da042c3571c67bf0f4696aba8.1632900802.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:41:53AM +0300, Alexey Bayduraev wrote:
> Moving mapping and unmapping code into reader__mmap, so the mmap
> code is located together. Moving head/file_offset computation into
> reader__mmap function, so all the offset computation is located
> together and in one place only.
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 60 +++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 85142d2a9a5a..5e08def72b41 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2206,12 +2206,9 @@ static int
>  reader__init(struct reader *rd, bool *one_mmap)
>  {
>  	struct reader_state *st = &rd->state;
> -	u64 page_offset;
>  	char **mmaps = st->mmaps;
>  
> -	page_offset = page_size * (rd->data_offset / page_size);
> -	st->file_offset = page_offset;
> -	st->head = rd->data_offset - page_offset;
> +	st->head = rd->data_offset;
>  

extra line, please remove

jirka

>  	st->data_size = rd->data_size + rd->data_offset;
>  
> @@ -2238,15 +2235,12 @@ reader__exit(struct reader *rd)
>  }
>  
>  static int
> -reader__process_events(struct reader *rd, struct perf_session *session,
> -		       struct ui_progress *prog)
> +reader__mmap(struct reader *rd, struct perf_session *session)
>  {
>  	struct reader_state *st = &rd->state;
> -	u64 page_offset, size;
> -	int err = 0, mmap_prot, mmap_flags;
> +	int mmap_prot, mmap_flags;
>  	char *buf, **mmaps = st->mmaps;
> -	union perf_event *event;
> -	s64 skip;
> +	u64 page_offset;
>  
>  	mmap_prot  = PROT_READ;
>  	mmap_flags = MAP_SHARED;
> @@ -2257,20 +2251,45 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		mmap_prot  |= PROT_WRITE;
>  		mmap_flags = MAP_PRIVATE;
>  	}
> -remap:
> +
> +	if (mmaps[st->mmap_idx]) {
> +		munmap(mmaps[st->mmap_idx], st->mmap_size);
> +		mmaps[st->mmap_idx] = NULL;
> +	}
> +
> +	page_offset = page_size * (st->head / page_size);
> +	st->file_offset += page_offset;
> +	st->head -= page_offset;
> +
>  	buf = mmap(NULL, st->mmap_size, mmap_prot, mmap_flags, rd->fd,
>  		   st->file_offset);
>  	if (buf == MAP_FAILED) {
>  		pr_err("failed to mmap file\n");
> -		err = -errno;
> -		goto out;
> +		return -errno;
>  	}
>  	mmaps[st->mmap_idx] = st->mmap_cur = buf;
>  	st->mmap_idx = (st->mmap_idx + 1) & (ARRAY_SIZE(st->mmaps) - 1);
>  	st->file_pos = st->file_offset + st->head;
> +	return 0;
> +}
> +
> +static int
> +reader__process_events(struct reader *rd, struct perf_session *session,
> +		       struct ui_progress *prog)
> +{
> +	struct reader_state *st = &rd->state;
> +	u64 size;
> +	int err = 0;
> +	union perf_event *event;
> +	s64 skip;
> +
> +remap:
> +	err = reader__mmap(rd, session);
> +	if (err)
> +		goto out;
>  	if (session->one_mmap) {
> -		session->one_mmap_addr = buf;
> -		session->one_mmap_offset = st->file_offset;
> +		session->one_mmap_addr   = rd->state.mmap_cur;
> +		session->one_mmap_offset = rd->state.file_offset;
>  	}
>  
>  more:
> @@ -2279,17 +2298,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  	if (IS_ERR(event))
>  		return PTR_ERR(event);
>  
> -	if (!event) {
> -		if (mmaps[st->mmap_idx]) {
> -			munmap(mmaps[st->mmap_idx], st->mmap_size);
> -			mmaps[st->mmap_idx] = NULL;
> -		}
> -
> -		page_offset = page_size * (st->head / page_size);
> -		st->file_offset += page_offset;
> -		st->head -= page_offset;
> +	if (!event)
>  		goto remap;
> -	}
>  
>  	session->active_reader = rd;
>  	size = event->header.size;
> -- 
> 2.19.0
> 


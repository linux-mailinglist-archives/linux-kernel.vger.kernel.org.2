Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9977C422F9E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhJESIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhJESIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:08:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3E3C6115B;
        Tue,  5 Oct 2021 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457180;
        bh=Pz76ergRuVcfx3d15yRyCC5GgFC+GHDHV1ULWhGqm9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1S4MwIbQ4QJ/j9rbL+Kb9nDIWqhlnHFgloJxVCU1ANbJwT+2dXo5qU3Vy8Y37moU
         xoyHLeDnuvm4WqjPrv4QQC7hKAVXQv9fvOsVfmOcZoBxJ2tpK4KdSeARiRpbT1HU9K
         mi2oPLsDCztcXGjKpWZwrN5lnE5/qFY8uVaYbN61IKQqugrRkVa8ZGpPacuLxO/rK4
         3olhPVk6C6ZlvckY7EehWdNumhgi6SOJnOoPaAxyjzFfKNRJO3o/ogbqA8Xwq3RAHH
         l1nJ0S5JM8yn3rrFRotoN0/qrlvNJhaboou/u2dbIC14Lwfvcd9zHfr9Vem88ClJdn
         Xf5JHlihZm5oQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4695E410A1; Tue,  5 Oct 2021 15:06:17 -0300 (-03)
Date:   Tue, 5 Oct 2021 15:06:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v2 1/5] perf session: Introduce reader_state in reader
 object
Message-ID: <YVyUGWZ5XkU1bvMQ@kernel.org>
References: <cover.1633424934.git.alexey.v.bayduraev@linux.intel.com>
 <866e75329c0b6d72110740b588df964d1b01b00a.1633424934.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <866e75329c0b6d72110740b588df964d1b01b00a.1633424934.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 05, 2021 at 01:26:58PM +0300, Alexey Bayduraev escreveu:
> We need all the state info about reader in separate object to load data
> from multiple files, so we can keep multiple readers at the same time.
> Adding struct reader_state and adding all items that need to be kept.

Why not pass 'struct reader' instead? "reader_state" looks too vague,
isn't the existing state the reader state? i.e. things like 'fd',
'data_size', etc in 'struct reader'.

Can we find better names to avoid this confusion?

- Arnaldo
 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 74 +++++++++++++++++++++++----------------
>  1 file changed, 43 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 069c2cfdd3be..f29b106b1b17 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2165,41 +2165,52 @@ typedef s64 (*reader_cb_t)(struct perf_session *session,
>  			   union perf_event *event,
>  			   u64 file_offset);
>  
> +struct reader_state {
> +	char	*mmaps[NUM_MMAPS];
> +	size_t	 mmap_size;
> +	int	 mmap_idx;
> +	char	*mmap_cur;
> +	u64	 file_pos;
> +	u64	 file_offset;
> +	u64	 data_size;
> +	u64	 head;
> +};
> +
>  struct reader {
>  	int		 fd;
>  	u64		 data_size;
>  	u64		 data_offset;
>  	reader_cb_t	 process;
>  	bool		 in_place_update;
> +	struct reader_state state;
>  };
>  
>  static int
>  reader__process_events(struct reader *rd, struct perf_session *session,
>  		       struct ui_progress *prog)
>  {
> -	u64 data_size = rd->data_size;
> -	u64 head, page_offset, file_offset, file_pos, size;
> -	int err = 0, mmap_prot, mmap_flags, map_idx = 0;
> -	size_t	mmap_size;
> -	char *buf, *mmaps[NUM_MMAPS];
> +	struct reader_state *st = &rd->state;
> +	u64 page_offset, size;
> +	int err = 0, mmap_prot, mmap_flags;
> +	char *buf, **mmaps = st->mmaps;
>  	union perf_event *event;
>  	s64 skip;
>  
>  	page_offset = page_size * (rd->data_offset / page_size);
> -	file_offset = page_offset;
> -	head = rd->data_offset - page_offset;
> +	st->file_offset = page_offset;
> +	st->head = rd->data_offset - page_offset;
>  
> -	ui_progress__init_size(prog, data_size, "Processing events...");
> +	ui_progress__init_size(prog, rd->data_size, "Processing events...");
>  
> -	data_size += rd->data_offset;
> +	st->data_size = rd->data_size + rd->data_offset;
>  
> -	mmap_size = MMAP_SIZE;
> -	if (mmap_size > data_size) {
> -		mmap_size = data_size;
> +	st->mmap_size = MMAP_SIZE;
> +	if (st->mmap_size > st->data_size) {
> +		st->mmap_size = st->data_size;
>  		session->one_mmap = true;
>  	}
>  
> -	memset(mmaps, 0, sizeof(mmaps));
> +	memset(mmaps, 0, sizeof(st->mmaps));
>  
>  	mmap_prot  = PROT_READ;
>  	mmap_flags = MAP_SHARED;
> @@ -2211,35 +2222,36 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		mmap_flags = MAP_PRIVATE;
>  	}
>  remap:
> -	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd->fd,
> -		   file_offset);
> +	buf = mmap(NULL, st->mmap_size, mmap_prot, mmap_flags, rd->fd,
> +		   st->file_offset);
>  	if (buf == MAP_FAILED) {
>  		pr_err("failed to mmap file\n");
>  		err = -errno;
>  		goto out;
>  	}
> -	mmaps[map_idx] = buf;
> -	map_idx = (map_idx + 1) & (ARRAY_SIZE(mmaps) - 1);
> -	file_pos = file_offset + head;
> +	mmaps[st->mmap_idx] = st->mmap_cur = buf;
> +	st->mmap_idx = (st->mmap_idx + 1) & (ARRAY_SIZE(st->mmaps) - 1);
> +	st->file_pos = st->file_offset + st->head;
>  	if (session->one_mmap) {
>  		session->one_mmap_addr = buf;
> -		session->one_mmap_offset = file_offset;
> +		session->one_mmap_offset = st->file_offset;
>  	}
>  
>  more:
> -	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
> +	event = fetch_mmaped_event(st->head, st->mmap_size, st->mmap_cur,
> +				   session->header.needs_swap);
>  	if (IS_ERR(event))
>  		return PTR_ERR(event);
>  
>  	if (!event) {
> -		if (mmaps[map_idx]) {
> -			munmap(mmaps[map_idx], mmap_size);
> -			mmaps[map_idx] = NULL;
> +		if (mmaps[st->mmap_idx]) {
> +			munmap(mmaps[st->mmap_idx], st->mmap_size);
> +			mmaps[st->mmap_idx] = NULL;
>  		}
>  
> -		page_offset = page_size * (head / page_size);
> -		file_offset += page_offset;
> -		head -= page_offset;
> +		page_offset = page_size * (st->head / page_size);
> +		st->file_offset += page_offset;
> +		st->head -= page_offset;
>  		goto remap;
>  	}
>  
> @@ -2248,9 +2260,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  	skip = -EINVAL;
>  
>  	if (size < sizeof(struct perf_event_header) ||
> -	    (skip = rd->process(session, event, file_pos)) < 0) {
> +	    (skip = rd->process(session, event, st->file_pos)) < 0) {
>  		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
> -		       file_offset + head, event->header.size,
> +		       st->file_offset + st->head, event->header.size,
>  		       event->header.type, strerror(-skip));
>  		err = skip;
>  		goto out;
> @@ -2259,8 +2271,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  	if (skip)
>  		size += skip;
>  
> -	head += size;
> -	file_pos += size;
> +	st->head += size;
> +	st->file_pos += size;
>  
>  	err = __perf_session__process_decomp_events(session);
>  	if (err)
> @@ -2271,7 +2283,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  	if (session_done())
>  		goto out;
>  
> -	if (file_pos < data_size)
> +	if (st->file_pos < st->data_size)
>  		goto more;
>  
>  out:
> -- 
> 2.19.0

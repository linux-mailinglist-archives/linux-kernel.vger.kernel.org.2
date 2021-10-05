Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23435422FC5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhJESOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232861AbhJESOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:14:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F7FA611C1;
        Tue,  5 Oct 2021 18:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457529;
        bh=UjZ2Xm5broc1piKEKhkcL/ZQQTcKo08ncq98rmOJHbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sioChlqZZvOkxgRbUkZ4p1QVY68QRX5j1Dgwq50eCKv990BPbSWPbF/inoNPoCNiB
         su/vRTMhhhhIC5fvtdifVy7O5SxYeicZJE/qv+A01G9vS3Ao6YNpZ76ZkRwh3ukS5a
         eIlo27yfnfnGp4e+TyP77UR13odyDZrRIppuqwo2gGxn1eZyvxHlROogPV7cZY/wKu
         n7JwWWEsIysWtRsOrtZUcuXuPRJwJsXKqhTjEtM0fzxxI/Dyqf+MHYshjgnYw/HzQL
         gXrsDPD6jIKmvtmk1gguw5eNn9+PsNmXbsT1uIUEt1o5jCUQzn1pZy33lOO9wRAlVZ
         Kb05dQp0uJ3Lw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BEE0410A1; Tue,  5 Oct 2021 15:12:06 -0300 (-03)
Date:   Tue, 5 Oct 2021 15:12:06 -0300
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
Subject: Re: [PATCH v2 2/5] perf session: Introduce decompressor in reader
 object
Message-ID: <YVyVdmFj4GBZHbRK@kernel.org>
References: <cover.1633424934.git.alexey.v.bayduraev@linux.intel.com>
 <f549ee7d25f10a8bacef6fa337566b8028c4433f.1633424934.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f549ee7d25f10a8bacef6fa337566b8028c4433f.1633424934.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 05, 2021 at 01:26:59PM +0300, Alexey Bayduraev escreveu:
> Introducing decompressor data structure with pointers to decomp
> objects and to zstd object. We cannot just move session->zstd_data to
> decomp_data as session->zstd_data is used not only for decompression.
> Adding decompressor data object to reader object and introducing
> active_decomp into perf_session object to select current decompressor.
> Thus decompression could be executed separately for each data file.
> 
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 36 ++++++++++++++++++++++++------------
>  tools/perf/util/session.h | 10 ++++++++--
>  2 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index f29b106b1b17..50f2ec523ae0 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -44,7 +44,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  	size_t decomp_size, src_size;
>  	u64 decomp_last_rem = 0;
>  	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
> -	struct decomp *decomp, *decomp_last = session->decomp_last;
> +	struct decomp *decomp, *decomp_last = session->active_decomp->decomp_last;
>  
>  	if (decomp_last) {
>  		decomp_last_rem = decomp_last->size - decomp_last->head;
> @@ -71,7 +71,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  	src = (void *)event + sizeof(struct perf_record_compressed);
>  	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
>  
> -	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
> +	decomp_size = zstd_decompress_stream(session->active_decomp->zstd_decomp, src, src_size,
>  				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
>  	if (!decomp_size) {
>  		munmap(decomp, mmap_len);
> @@ -81,12 +81,12 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  
>  	decomp->size += decomp_size;
>  
> -	if (session->decomp == NULL) {
> -		session->decomp = decomp;
> -		session->decomp_last = decomp;
> +	if (session->active_decomp->decomp == NULL) {
> +		session->active_decomp->decomp = decomp;
> +		session->active_decomp->decomp_last = decomp;
>  	} else {
> -		session->decomp_last->next = decomp;
> -		session->decomp_last = decomp;
> +		session->active_decomp->decomp_last->next = decomp;
> +		session->active_decomp->decomp_last = decomp;
>  	}

This one is invariant, can it be put after the if/else block, please?

	session->active_decomp->decomp_last = decomp;
>  
>  	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
> @@ -197,6 +197,8 @@ struct perf_session *__perf_session__new(struct perf_data *data,
>  
>  	session->repipe = repipe;
>  	session->tool   = tool;
> +	session->decomp_data.zstd_decomp = &session->zstd_data;
> +	session->active_decomp = &session->decomp_data;
>  	INIT_LIST_HEAD(&session->auxtrace_index);
>  	machines__init(&session->machines);
>  	ordered_events__init(&session->ordered_events,
> @@ -276,11 +278,11 @@ static void perf_session__delete_threads(struct perf_session *session)
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
> @@ -299,7 +301,7 @@ void perf_session__delete(struct perf_session *session)
>  	auxtrace_index__free(&session->auxtrace_index);
>  	perf_session__destroy_kernel_maps(session);
>  	perf_session__delete_threads(session);
> -	perf_session__release_decomp_events(session);
> +	perf_decomp__release_events(session->decomp_data.decomp);
>  	perf_env__exit(&session->header.env);
>  	machines__exit(&session->machines);
>  	if (session->data) {
> @@ -2117,7 +2119,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>  {
>  	s64 skip;
>  	u64 size, file_pos = 0;
> -	struct decomp *decomp = session->decomp_last;
> +	struct decomp *decomp = session->active_decomp->decomp_last;
>  
>  	if (!decomp)
>  		return 0;
> @@ -2183,6 +2185,8 @@ struct reader {
>  	reader_cb_t	 process;
>  	bool		 in_place_update;
>  	struct reader_state state;
> +	struct zstd_data    zstd_data;
> +	struct decomp_data  decomp_data;
>  };
>  
>  static int
> @@ -2212,6 +2216,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  
>  	memset(mmaps, 0, sizeof(st->mmaps));
>  
> +	if (zstd_init(&rd->zstd_data, 0))
> +		return -1;
> +	rd->decomp_data.zstd_decomp = &rd->zstd_data;
> +
>  	mmap_prot  = PROT_READ;
>  	mmap_flags = MAP_SHARED;
>  
> @@ -2255,6 +2263,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		goto remap;
>  	}
>  
> +	session->active_decomp = &rd->decomp_data;
>  	size = event->header.size;
>  
>  	skip = -EINVAL;
> @@ -2287,6 +2296,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		goto more;
>  
>  out:
> +	session->active_decomp = &session->decomp_data;
> +	perf_decomp__release_events(rd->decomp_data.decomp);
> +	zstd_fini(&rd->zstd_data);
>  	return err;
>  }
>  
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index 5d8bd14a0a39..46c854292ad6 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -20,6 +20,12 @@ struct thread;
>  struct auxtrace;
>  struct itrace_synth_opts;
>  
> +struct decomp_data {
> +	struct decomp	 *decomp;
> +	struct decomp	 *decomp_last;
> +	struct zstd_data *zstd_decomp;
> +};

using _data like above is too vague, and I saw that in some places you
used "perf_decomp_", wouldn't the above be better described as "struct
perf_decomp"?

> +
>  struct perf_session {
>  	struct perf_header	header;
>  	struct machines		machines;
> @@ -39,8 +45,8 @@ struct perf_session {
>  	u64			bytes_transferred;
>  	u64			bytes_compressed;
>  	struct zstd_data	zstd_data;
> -	struct decomp		*decomp;
> -	struct decomp		*decomp_last;
> +	struct decomp_data	decomp_data;
> +	struct decomp_data	*active_decomp;
>  };
>  
>  struct decomp {
> -- 
> 2.19.0

-- 

- Arnaldo

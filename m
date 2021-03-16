Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F1133D4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhCPNQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232606AbhCPNP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:15:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2338765036;
        Tue, 16 Mar 2021 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615900557;
        bh=PA9e6syMxf/1A2hfcqNarCNuKvtDZHa0EkOw7JoA6ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qjfrlw8/oYWvvNSPLHwFAT+AGtCvvMp6Kzp/Xf02bF2f1BsVY1N9z5vsEWCZs91nn
         L4ZHbvANt7KfEMbxy7F9FSE6UHJioVKDk29IZ2rbPeJczkA+n3e4lvtReLRo05tefe
         OZ5I5lqOm2hk0GXp+GZ7isz66mHsff0c/4UBJs4isPk1oTm360vuXvzy6jbd1nGsn3
         o2D/YPJoBsYMlRtiFNouJ8zVBuhBBFvJQHflXkiz0BHqbgaPKTLSQ1Eehly368LgMJ
         bGUjgcm0/2bZEs0hRVlUYtp3YZ3xWlV/3eNWlAJ1VXAceW0GBQ/0ESook0YtjcxKmv
         Q4y/ueA+kqrHQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E697340647; Tue, 16 Mar 2021 10:15:54 -0300 (-03)
Date:   Tue, 16 Mar 2021 10:15:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jackie Liu <jackieliu2113@gmail.com>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        Jackie Liu <liuyun01@kylinos.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v4] perf tools: perf_event_paranoid and kptr_restrict may
 crash on 'perf top'
Message-ID: <YFCvimCNsJ4NeRA1@kernel.org>
References: <20210316012453.1156-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316012453.1156-1-liuyun01@kylinos.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 16, 2021 at 09:24:53AM +0800, Jackie Liu escreveu:
> After install the libelf-dev package and compiling perf, kptr_restrict=2
> and perf_event_paranoid=3 will cause perf top to crash, because the
> value of /proc/kallsyms cannot be obtained, which leads to
> info->jited_ksyms == NULL. In order to solve this problem, Add a
> judgment before use.
> 
> v3->v4:
> Fix memory leaks in more places
> 
> v2->v3:
> free info_linear memory and move code above, don't do those extra btf
> checks.

Applied, edited the commit message to:

----
    perf top: Fix BPF support related crash with perf_event_paranoid=3 + kptr_restrict

    After installing the libelf-dev package and compiling perf, if we have
    kptr_restrict=2 and perf_event_paranoid=3 'perf top' will crash because
    the value of /proc/kallsyms cannot be obtained, which leads to
    info->jited_ksyms == NULL. In order to solve this problem, Add a
    check before use.

    Also plug some leaks on the error path.
----
 
> Suggested-by: Jiri Olsa <jolsa@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  tools/perf/util/bpf-event.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 57d58c81a5f8..cdecda1ddd36 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -196,25 +196,32 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  	}
>  
>  	if (info_linear->info_len < offsetof(struct bpf_prog_info, prog_tags)) {
> +		free(info_linear);
>  		pr_debug("%s: the kernel is too old, aborting\n", __func__);
>  		return -2;
>  	}
>  
>  	info = &info_linear->info;
> +	if (!info->jited_ksyms) {
> +		free(info_linear);
> +		return -1;
> +	}
>  
>  	/* number of ksyms, func_lengths, and tags should match */
>  	sub_prog_cnt = info->nr_jited_ksyms;
>  	if (sub_prog_cnt != info->nr_prog_tags ||
> -	    sub_prog_cnt != info->nr_jited_func_lens)
> +	    sub_prog_cnt != info->nr_jited_func_lens) {
> +		free(info_linear);
>  		return -1;
> +	}
>  
>  	/* check BTF func info support */
>  	if (info->btf_id && info->nr_func_info && info->func_info_rec_size) {
>  		/* btf func info number should be same as sub_prog_cnt */
>  		if (sub_prog_cnt != info->nr_func_info) {
>  			pr_debug("%s: mismatch in BPF sub program count and BTF function info count, aborting\n", __func__);
> -			err = -1;
> -			goto out;
> +			free(info_linear);
> +			return -1;
>  		}
>  		if (btf__get_from_id(info->btf_id, &btf)) {
>  			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info->btf_id);
> -- 
> 2.25.1
> 

-- 

- Arnaldo

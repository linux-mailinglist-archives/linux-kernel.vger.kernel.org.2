Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0579333D481
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhCPNBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234451AbhCPNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615899652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJuyiijJa+f0O+UIDwcydLxD2CGkRu/MADpV+IhycDo=;
        b=A8oP+Cw+P0a5//LcclLqtpLWtRwuAX6iw5+g48TPccxGmHTsD6FqZNuEQ7zsmPql6hjRjI
        gKBOv+slx4pkBjeW6KXzwqlXNv+xR24CeA7qcm+LbR5SSAlhr0VvyiLsW4PwIAbyH+dtnX
        v7rNIZwMbvTrfW5kUzq5PJXhvzBDGBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-CzINVc3aO42P6NEXexJnHA-1; Tue, 16 Mar 2021 09:00:50 -0400
X-MC-Unique: CzINVc3aO42P6NEXexJnHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81032100C676;
        Tue, 16 Mar 2021 13:00:48 +0000 (UTC)
Received: from krava (unknown [10.40.193.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3F31210023B5;
        Tue, 16 Mar 2021 13:00:46 +0000 (UTC)
Date:   Tue, 16 Mar 2021 14:00:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jackie Liu <jackieliu2113@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v4] perf tools: perf_event_paranoid and kptr_restrict may
 crash on 'perf top'
Message-ID: <YFCr/frDQoHtkfPQ@krava>
References: <20210316012453.1156-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316012453.1156-1-liuyun01@kylinos.cn>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:24:53AM +0800, Jackie Liu wrote:
> After install the libelf-dev package and compiling perf, kptr_restrict=2
> and perf_event_paranoid=3 will cause perf top to crash, because the
> value of /proc/kallsyms cannot be obtained, which leads to
> info->jited_ksyms == NULL. In order to solve this problem, Add a
> judgment before use.
> 
> v3->v4:
> Fix memory leaks in more places

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> v2->v3:
> free info_linear memory and move code above, don't do those extra btf
> checks.
> 
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


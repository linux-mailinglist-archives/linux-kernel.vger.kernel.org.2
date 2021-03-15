Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C525733B30F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCOMsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhCOMr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615812478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBSD9TbkBF+MmfQB/up8Gu8cM8NveQ/rUjDfd4kB8sY=;
        b=PZNxN62t2946/VmnklD1TCYMnDHBrsDEElAgWB7HHtzc0RdyHeLg2aUgI6gq379/Msemft
        P4QHUiswy19nYwxDmEKE7+/cYcikP0RYnjB8ckvLDvdqZiXqvZWtNP/bTozHgwGVRja+aO
        r7XhVX4prjXCt+qo/b8nhfxmwmx8FgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-BM__YvbpPjKTDR6CA6GVgw-1; Mon, 15 Mar 2021 08:47:54 -0400
X-MC-Unique: BM__YvbpPjKTDR6CA6GVgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC4B81054F91;
        Mon, 15 Mar 2021 12:47:52 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id A59E05D9C0;
        Mon, 15 Mar 2021 12:47:49 +0000 (UTC)
Date:   Mon, 15 Mar 2021 13:47:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jackie Liu <jackieliu2113@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3] perf tools: perf_event_paranoid and kptr_restrict may
 crash on 'perf top'
Message-ID: <YE9XdG1INdboLsbd@krava>
References: <20210313060246.37116-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313060246.37116-1-liuyun01@kylinos.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 02:02:46PM +0800, Jackie Liu wrote:
> After install the libelf-dev package and compiling perf, kptr_restrict=2
> and perf_event_paranoid=3 will cause perf top to crash, because the
> value of /proc/kallsyms cannot be obtained, which leads to
> info->jited_ksyms == NULL. In order to solve this problem, Add a
> judgment before use.
> 
> V2->V3:
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
>  tools/perf/util/bpf-event.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 57d58c81a5f8..3c03c782bac6 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -201,12 +201,18 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  	}

seems like the previous check miss free(info_linear) as well?
  
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
> -- 
> 2.25.1
> 


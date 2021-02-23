Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FF1322C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhBWOjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:39:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232258AbhBWOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614091094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UE1un9vgSiZpLq1CGzipH6IHKnzn7Id+eCpqFzzS2ow=;
        b=fM/vWssZ9Uq21CdCR0SRlO5rTbckqXtadBBVQFw5BvhDdczY2kzwL3QC+X5hTnXn1GoShT
        pPliGhv6hbDZie3DIR9N/wK04OJTbDAU17FQBP4BLbhy+RkdJlNkr/FnYknXcVGXg1Iljq
        A7wpK/rSyH6YkTn8nIOeOI3+Z3925rM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-H_qy2Yc1NYyAMZj6wyyCGw-1; Tue, 23 Feb 2021 09:38:10 -0500
X-MC-Unique: H_qy2Yc1NYyAMZj6wyyCGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21D5618BA298;
        Tue, 23 Feb 2021 14:38:08 +0000 (UTC)
Received: from krava (unknown [10.40.192.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id B40F519C79;
        Tue, 23 Feb 2021 14:38:05 +0000 (UTC)
Date:   Tue, 23 Feb 2021 15:38:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jackie Liu <jackieliu2113@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: check perf_event_paranoid and kptr_restrict
 on 'perf top'
Message-ID: <YDUTTKCScLhRZfYF@krava>
References: <20210223062440.15848-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223062440.15848-1-liuyun01@kylinos.cn>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 02:24:40PM +0800, Jackie Liu wrote:
> Perf top will segfault, we should give prompt information like perf
> record instead of crashing directly.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  tools/perf/builtin-top.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 3673c04d16b6..b257fadba3bd 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1239,6 +1239,14 @@ static int __cmd_top(struct perf_top *top)
>  			return ret;
>  	}
>  
> +	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(top->evlist)) {
> +		pr_warning(
> +"Kernel address maps (/proc/{kallsyms,modules}) are restricted.\n\n"
> +"Check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
> +"Kernel samples will not be resolved.\n");
> +		return -1;
> +	}
> +

hm, why not fix that crash by checking prog_addrs != NULL before using it

  perf_event__synthesize_one_bpf_prog:
  ...
     __u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);

it looks like we're already checking on kptr_restrict in
perf_event__process_sample and allow it on some level

jirka

>  	ret = callchain_param__setup_sample_type(&callchain_param);
>  	if (ret)
>  		return ret;
> -- 
> 2.25.1
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D64325355
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhBYQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233708AbhBYQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614269480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LWH/nKmKAiq/DDZ2zqRqKiboiDgBZmOLPESyCRR49rw=;
        b=ZDji6WtUrBBNMDK2Az0gBf97ca8kDb6FYHGxe/SMdmRXteA4O47ryIr061sX2gljs0Narw
        SKpkWoB2HIP+ekVwzWsf+qvN8ze9GukBdqqYgBKhiqngORoY44DZdqQsrz/sVcJBEHv0xr
        aoHGYZ4pjYi8Wrb/PHrJQs05IUXbQY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-XpA5H09ZMVmtjLXN8mu1tw-1; Thu, 25 Feb 2021 11:11:16 -0500
X-MC-Unique: XpA5H09ZMVmtjLXN8mu1tw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF81E107ACF6;
        Thu, 25 Feb 2021 16:11:13 +0000 (UTC)
Received: from krava (unknown [10.40.194.234])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8327519C79;
        Thu, 25 Feb 2021 16:11:11 +0000 (UTC)
Date:   Thu, 25 Feb 2021 17:11:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jackie Liu <jackieliu2113@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf tools: perf_event_paranoid and kptr_restrict may
 crash on 'perf top'
Message-ID: <YDfMHgxExyVCtm4c@krava>
References: <20210225062530.25334-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225062530.25334-1-liuyun01@kylinos.cn>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:25:30PM +0800, Jackie Liu wrote:
> After install the libelf-dev package and compiling perf, kptr_restrict=2
> and perf_event_paranoid=3 will cause perf top to crash, because the
> value of /proc/kallsyms cannot be obtained, which leads to
> info->jited_ksyms == NULL. In order to solve this problem, Add a
> judgment before use.
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
>  tools/perf/util/bpf-event.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 57d58c81a5f8..b1ce2d189d37 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -225,6 +225,11 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
>  		perf_env__fetch_btf(env, info->btf_id, btf);
>  	}
>  
> +	if (!info->jited_ksyms) {
> +		err = -1;
> +		goto out;
> +	}
> +

I think this check should be moved above, right after line:

        info = &info_linear->info;

so we don't do those extra btf checks

thanks,
jirka

>  	/* Synthesize PERF_RECORD_KSYMBOL */
>  	for (i = 0; i < sub_prog_cnt; i++) {
>  		__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
> -- 
> 2.25.1
> 


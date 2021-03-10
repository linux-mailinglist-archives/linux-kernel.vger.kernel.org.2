Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98006333BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhCJLsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230122AbhCJLsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615376924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9fcdiVCiM93P7D++FuDQH+93JEGucMnidvVl0b4SoDU=;
        b=e5hNmH2gndRa/s2Lp2pY2Hn0YIA2LCn0cFMj66Kk/e0bVHZUnszhRD5Cr2ltz4XLXOg7gT
        aNnJ0tRvof4NJJsBhI8ep/1EFo1wzP+qM8WXPWF9nC7sLUwZWfZQxg81wNrogZr06qp3Da
        9wRUiXY8slVnLmg46NcRxSRkoPcodqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-s1NJXtVkMhiITtG5uWJgyQ-1; Wed, 10 Mar 2021 06:48:40 -0500
X-MC-Unique: s1NJXtVkMhiITtG5uWJgyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 226B81019634;
        Wed, 10 Mar 2021 11:48:39 +0000 (UTC)
Received: from krava (unknown [10.40.195.168])
        by smtp.corp.redhat.com (Postfix) with SMTP id 18F431346F;
        Wed, 10 Mar 2021 11:48:36 +0000 (UTC)
Date:   Wed, 10 Mar 2021 12:48:36 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf synthetic events: Avoid write of uninitialized
 memory.
Message-ID: <YEiyFNEhMuZhXA30@krava>
References: <20210309234945.419254-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309234945.419254-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 03:49:45PM -0800, Ian Rogers wrote:
> Account for alignment bytes in the zero-ing memset.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/synthetic-events.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index b698046ec2db..31bf3dd6a1e0 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -424,7 +424,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  
>  	while (!io.eof) {
>  		static const char anonstr[] = "//anon";
> -		size_t size;
> +		size_t size, aligned_size;
>  
>  		/* ensure null termination since stack will be reused. */
>  		event->mmap2.filename[0] = '\0';
> @@ -484,11 +484,12 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  		}
>  
>  		size = strlen(event->mmap2.filename) + 1;
> -		size = PERF_ALIGN(size, sizeof(u64));
> +		aligned_size = PERF_ALIGN(size, sizeof(u64));
>  		event->mmap2.len -= event->mmap.start;
>  		event->mmap2.header.size = (sizeof(event->mmap2) -
> -					(sizeof(event->mmap2.filename) - size));
> -		memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
> +					(sizeof(event->mmap2.filename) - aligned_size));
> +		memset(event->mmap2.filename + size, 0, machine->id_hdr_size +
> +			(aligned_size - size));

so we did not zero the extra alignment bytes, nice ;-) looks good

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>  		event->mmap2.header.size += machine->id_hdr_size;
>  		event->mmap2.pid = tgid;
>  		event->mmap2.tid = pid;
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 


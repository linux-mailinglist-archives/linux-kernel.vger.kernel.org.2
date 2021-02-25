Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E645325358
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhBYQRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:17:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233621AbhBYQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614269565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YQUuqnXaxQymHBp2wVK97ZxQTzXCyQ/Nab1lju1xW0s=;
        b=NIW+lW75nqchRhmRgr4G0CSNoa7E5LypijktuyZi2OwCkGR9tNXuBkREt657Jnh3Bew236
        sWOzEKgHggiz0L0e6m5j0pYHJiyYOp+MnxEQqxjAiTsyNExLGwbMHMu6srPXREj3Zwa/I5
        n8fcUyMxySguoMHG5eJyrpxyO8PwxBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-hFwMmutlPyWNBZXh_OKhkg-1; Thu, 25 Feb 2021 11:12:42 -0500
X-MC-Unique: hFwMmutlPyWNBZXh_OKhkg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8296A18B6141;
        Thu, 25 Feb 2021 16:12:40 +0000 (UTC)
Received: from krava (unknown [10.40.194.234])
        by smtp.corp.redhat.com (Postfix) with SMTP id 815AF61F38;
        Thu, 25 Feb 2021 16:12:38 +0000 (UTC)
Date:   Thu, 25 Feb 2021 17:12:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 1/2] libperf: Add perf_evlist__reset_id_hash()
Message-ID: <YDfMdQCfO6ivN71v@krava>
References: <20210225035148.778569-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225035148.778569-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:51:47PM +0900, Namhyung Kim wrote:
> Add the perf_evlist__reset_id_hash() function as an internal function
> so that it can be called by perf to reset the hash table.  This is
> necessary for perf stat to run the workload multiple times.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

for the patchset

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka


> ---
>  tools/lib/perf/evlist.c                  | 13 +++++++++----
>  tools/lib/perf/include/internal/evlist.h |  2 ++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 17465d454a0e..a0aaf385cbb5 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -26,13 +26,10 @@
>  
>  void perf_evlist__init(struct perf_evlist *evlist)
>  {
> -	int i;
> -
> -	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
> -		INIT_HLIST_HEAD(&evlist->heads[i]);
>  	INIT_LIST_HEAD(&evlist->entries);
>  	evlist->nr_entries = 0;
>  	fdarray__init(&evlist->pollfd, 64);
> +	perf_evlist__reset_id_hash(evlist);
>  }
>  
>  static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> @@ -237,6 +234,14 @@ static void perf_evlist__id_hash(struct perf_evlist *evlist,
>  	hlist_add_head(&sid->node, &evlist->heads[hash]);
>  }
>  
> +void perf_evlist__reset_id_hash(struct perf_evlist *evlist)
> +{
> +	int i;
> +
> +	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
> +		INIT_HLIST_HEAD(&evlist->heads[i]);
> +}
> +
>  void perf_evlist__id_add(struct perf_evlist *evlist,
>  			 struct perf_evsel *evsel,
>  			 int cpu, int thread, u64 id)
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index 2d0fa02b036f..212c29063ad4 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -124,4 +124,6 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>  			   struct perf_evsel *evsel,
>  			   int cpu, int thread, int fd);
>  
> +void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
> +
>  #endif /* __LIBPERF_INTERNAL_EVLIST_H */
> -- 
> 2.30.0.617.g56c4b15f3c-goog
> 


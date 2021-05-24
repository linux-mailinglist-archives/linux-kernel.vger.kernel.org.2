Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FCC38F22B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhEXRUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232645AbhEXRUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621876763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MKyZ+r4xx3NGB0ZMwG+apvgfMJ3wCsbm2qlvnkLD0RM=;
        b=PtttQINeaF0IdXUxE5qhvia+Gf37RjZiDxE19hVL4j/sJVUZPTdpPhKYcgx2zKqdcurJrM
        4gr7dG9+2ya4GHba0k7zIyU0acel6+Tkl6Y8vg++xJFOycrZxt9NT9gvcyXXWlPLeC1vlB
        Vj8RjwR72D3V6emQ1walZ1cBCtZD/tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-ebA8j8xROFSWvDkWOQc_5g-1; Mon, 24 May 2021 13:19:21 -0400
X-MC-Unique: ebA8j8xROFSWvDkWOQc_5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C716D800FF0;
        Mon, 24 May 2021 17:19:19 +0000 (UTC)
Received: from krava (unknown [10.40.195.130])
        by smtp.corp.redhat.com (Postfix) with SMTP id C60455D9D3;
        Mon, 24 May 2021 17:19:17 +0000 (UTC)
Date:   Mon, 24 May 2021 19:19:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 4/5] perf mem: Support record for hybrid platform
Message-ID: <YKvgFVVywalr+Owr@krava>
References: <20210520070040.710-1-yao.jin@linux.intel.com>
 <20210520070040.710-5-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520070040.710-5-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 03:00:39PM +0800, Jin Yao wrote:
> Support 'perf mem record' for hybrid platform. On hybrid platform,
> such as Alderlake, when executing 'perf mem record', it actually calls:
> 
> record -e {cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}:P
>        -e cpu_atom/mem-loads,ldlat=30/P
>        -e cpu_core/mem-stores/P
>        -e cpu_atom/mem-stores/P
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-mem.c     | 39 ++++++++++++----------
>  tools/perf/util/mem-events.c | 65 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/mem-events.h |  2 ++
>  3 files changed, 89 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 03795bf49d51..a50abcb45f0f 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -62,8 +62,9 @@ static const char * const *record_mem_usage = __usage;
>  
>  static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  {
> -	int rec_argc, i = 0, j;
> +	int rec_argc, i = 0, j,  tmp_nr = 0;
>  	const char **rec_argv;
> +	char **rec_tmp;
>  	int ret;
>  	bool all_user = false, all_kernel = false;
>  	struct perf_mem_event *e;
> @@ -87,11 +88,20 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  	argc = parse_options(argc, argv, options, record_mem_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN);
>  
> -	rec_argc = argc + 9; /* max number of arguments */
> +	rec_argc = argc + 64; /* max number of arguments */

please add comment on how you got the number 64


>  	rec_argv = calloc(rec_argc + 1, sizeof(char *));
>  	if (!rec_argv)
>  		return -1;
>  
> +	/*
> +	 * Save the allocated event name strings.
> +	 */
> +	rec_tmp = calloc(rec_argc + 1, sizeof(char *));
> +	if (!rec_tmp) {
> +		free(rec_argv);
> +		return -1;
> +	}

why not do strdup on all of them and always call free instead?
that would get rid of the rec_tmp and tmp_nr

> +
>  	rec_argv[i++] = "record";
>  
>  	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
> @@ -128,21 +138,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  	if (mem->data_page_size)
>  		rec_argv[i++] = "--data-page-size";
>  
> -	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -		e = perf_mem_events__ptr(j);
> -		if (!e->record)
> -			continue;
> -
> -		if (!e->supported) {
> -			pr_err("failed: event '%s' not supported\n",
> -			       perf_mem_events__name(j, NULL));
> -			free(rec_argv);
> -			return -1;
> -		}
> -
> -		rec_argv[i++] = "-e";
> -		rec_argv[i++] = perf_mem_events__name(j, NULL);
> -	}
> +	ret = perf_mem_events__record_args(rec_argv, &i, rec_tmp, &tmp_nr);
> +	if (ret)
> +		goto out;
>  
>  	if (all_user)
>  		rec_argv[i++] = "--all-user";
> @@ -164,6 +162,13 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  	}
>  
>  	ret = cmd_record(i, rec_argv);
> +out:
> +	for (i = 0; i < tmp_nr; i++) {
> +		if (rec_tmp[i])
> +			free(rec_tmp[i]);

no need to check rec_tmp[i] != NULL, free will do that

> +	}
> +
> +	free(rec_tmp);
>  	free(rec_argv);
>  	return ret;
>  }
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index e8f6e745eaf0..909ee91b75f0 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -173,6 +173,71 @@ void perf_mem_events__list(void)
>  	}
>  }
>  
> +static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
> +						    int idx)
> +{
> +	const char *mnt = sysfs__mount();
> +	char sysfs_name[100];
> +	struct perf_pmu *pmu;
> +
> +	perf_pmu__for_each_hybrid_pmu(pmu) {
> +		scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
> +			  pmu->name);
> +		if (!perf_mem_events__supported(mnt, sysfs_name)) {
> +			pr_err("failed: event '%s' not supported\n",
> +			       perf_mem_events__name(idx, pmu->name));
> +		}
> +	}
> +}
> +
> +int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
> +				 char **rec_tmp, int *tmp_nr)
> +{
> +	int i = *argv_nr, k = 0;
> +	struct perf_mem_event *e;
> +	struct perf_pmu *pmu;
> +	char *s;
> +
> +	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> +		e = perf_mem_events__ptr(j);
> +		if (!e->record)
> +			continue;
> +
> +		if (!perf_pmu__has_hybrid()) {
> +			if (!e->supported) {
> +				pr_err("failed: event '%s' not supported\n",
> +				       perf_mem_events__name(j, NULL));
> +				return -1;
> +			}
> +
> +			rec_argv[i++] = "-e";
> +			rec_argv[i++] = perf_mem_events__name(j, NULL);
> +		} else {
> +			if (!e->supported) {
> +				perf_mem_events__print_unsupport_hybrid(e, j);
> +				return -1;
> +			}
> +
> +			perf_pmu__for_each_hybrid_pmu(pmu) {
> +				rec_argv[i++] = "-e";
> +				s = perf_mem_events__name(j, pmu->name);
> +				if (s) {
> +					s = strdup(s);
> +					if (!s)
> +						return -1;
> +
> +					rec_argv[i++] = s;
> +					rec_tmp[k++] = s;
> +				}
> +			}
> +		}
> +	}
> +
> +	*argv_nr = i;
> +	*tmp_nr = k;
> +	return 0;
> +}
> +
>  static const char * const tlb_access[] = {
>  	"N/A",
>  	"HIT",
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index a3fa19093fd2..916242f8020a 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -43,6 +43,8 @@ struct perf_mem_event *perf_mem_events__ptr(int i);
>  bool is_mem_loads_aux_event(struct evsel *leader);
>  
>  void perf_mem_events__list(void);
> +int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
> +				 char **rec_tmp, int *tmp_nr);
>  
>  int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
>  int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
> -- 
> 2.17.1
> 


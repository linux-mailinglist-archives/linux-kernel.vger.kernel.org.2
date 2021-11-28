Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38446071D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358037AbhK1PeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 10:34:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358051AbhK1PcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 10:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638113330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jS1GKaqtBc1hwwY9M09LSlQCCCVnKythJ8Tx3lCys6Q=;
        b=EPayxP0yLaqB6B6nLR0vT7/mp39bpyaoIj6+or98NcPyEaiSfmiCYe4mdJSvTDNSlxmXUX
        ke/6f9hIkDFQ1rpwZn9zgGFbkGXxuyhkzSN57LcQPGt/SEAXAWb0KomU9DEvYNkal9CmJy
        MbdzWYdVCCraXRcaz4qcfGjWxZ2IML4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-g0uSK3ZaPWCzndIfnBE1dA-1; Sun, 28 Nov 2021 10:28:49 -0500
X-MC-Unique: g0uSK3ZaPWCzndIfnBE1dA-1
Received: by mail-wm1-f72.google.com with SMTP id 138-20020a1c0090000000b00338bb803204so7680452wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 07:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jS1GKaqtBc1hwwY9M09LSlQCCCVnKythJ8Tx3lCys6Q=;
        b=CAe/+TfIImrwYxe0Vp1RdN/IpDNfkmVMHsqkGohRaRcvP1RA2gUrCakUBdhu43+Thy
         c+W5eXBOSNq4/om/rpDRDyMk0ddXSr0ms0k3WlLkozZLN8XBq3SdofVddVIozENl7uPV
         z2LQoErWBEFhmSGJYllzQlreIGSjJEJlAJacfVzBqlZOnDeJqshtyKbygXzNp1n09qRK
         flijVsxVKFBFdozTx93eAdm65BjglvmU8+q8HZ+CvZDiK/4d24f7q1vT0YBK8/kVJPmx
         8erIReAMlLBjrpJ47iywRBr0xWXSOZEKUei/DxbBGz1+X0q7UzfIvhPdw5I7FjvcC/kg
         wSRg==
X-Gm-Message-State: AOAM532TJSGO45PLv1ghmgMWLrn+yJtG7yH/kkEPKAaU0gzgr0/LeAOs
        UOsh02t4j+CQJ7gQfLOzMX8Cd7ZbpdVgyJVCxrBeI57G0/e0YLn7Bm49S6dM4UGY9EoTnDjLUQY
        A3CGajFpvzqzYTmiJQzdLh18V
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr29513280wms.81.1638113327965;
        Sun, 28 Nov 2021 07:28:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0NMAlM4N7f6386+Iiw5OiDlGOwPV9wnSXFtaTypLOXRUz+t5njxuCSKdoPbRji8TrdAsaeA==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr29513244wms.81.1638113327747;
        Sun, 28 Nov 2021 07:28:47 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f18sm10942751wre.7.2021.11.28.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 07:28:47 -0800 (PST)
Date:   Sun, 28 Nov 2021 16:28:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>, eranian@google.com
Subject: Re: [PATCH v2 1/2] perf evlist: Allow setting arbitrary leader
Message-ID: <YaOgLdMPoGRfMgBX@krava>
References: <20211118220647.2355999-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118220647.2355999-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 02:06:46PM -0800, Ian Rogers wrote:
> The leader of a group is the first, but allow it to be an arbitrary
> list member so that for Intel topdown events slots may always be the
> group leader.
> 
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

hi,
for both patches:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/lib/perf/evlist.c                  | 15 +++++++++------
>  tools/lib/perf/include/internal/evlist.h |  2 +-
>  tools/perf/util/parse-events.c           |  2 +-
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index e37dfad31383..974da341b8b0 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -643,14 +643,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
>  	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
>  }
>  
> -void __perf_evlist__set_leader(struct list_head *list)
> +void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
>  {
> -	struct perf_evsel *evsel, *leader;
> +	struct perf_evsel *first, *last, *evsel;
>  
> -	leader = list_entry(list->next, struct perf_evsel, node);
> -	evsel = list_entry(list->prev, struct perf_evsel, node);
> +	first = list_entry(list->next, struct perf_evsel, node);
> +	last = list_entry(list->prev, struct perf_evsel, node);
>  
> -	leader->nr_members = evsel->idx - leader->idx + 1;
> +	leader->nr_members = last->idx - first->idx + 1;
>  
>  	__perf_evlist__for_each_entry(list, evsel)
>  		evsel->leader = leader;
> @@ -659,7 +659,10 @@ void __perf_evlist__set_leader(struct list_head *list)
>  void perf_evlist__set_leader(struct perf_evlist *evlist)
>  {
>  	if (evlist->nr_entries) {
> +		struct perf_evsel *first = list_entry(evlist->entries.next,
> +						struct perf_evsel, node);
> +
>  		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
> -		__perf_evlist__set_leader(&evlist->entries);
> +		__perf_evlist__set_leader(&evlist->entries, first);
>  	}
>  }
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index f366dbad6a88..6f74269a3ad4 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -127,5 +127,5 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>  
>  void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
>  
> -void __perf_evlist__set_leader(struct list_head *list);
> +void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader);
>  #endif /* __LIBPERF_INTERNAL_EVLIST_H */
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 5bfb6f892489..6308ba739d19 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1834,8 +1834,8 @@ void parse_events__set_leader(char *name, struct list_head *list,
>  	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
>  		return;
>  
> -	__perf_evlist__set_leader(list);
>  	leader = list_entry(list->next, struct evsel, core.node);
> +	__perf_evlist__set_leader(list, &leader->core);
>  	leader->group_name = name ? strdup(name) : NULL;
>  }
>  
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 


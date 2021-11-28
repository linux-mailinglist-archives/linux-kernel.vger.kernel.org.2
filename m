Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE50460788
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358291AbhK1Qev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:34:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245669AbhK1Qcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638116974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZW4/JuATNmbqT39WM6Wldifr5uJSWbgQDWe+YfFz5w=;
        b=DIjZUd96utj8x9pzVj226jPF0ADSfPhuL7GjZFWtBXZvJbU2SpI6tvHILDwIDYQL5SqWtf
        qLRp2JqsgGs87SFJknMiVeL75WiPNiJMOBP8yHq1cMm7UqtrZaKCvjbamOV3aj85L5bwvn
        Gb2Tg+S7l8Pxb/6oQzLSNf1UyurcUlM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-6fLXKNqSPuCbWwNGLFs4eg-1; Sun, 28 Nov 2021 11:29:33 -0500
X-MC-Unique: 6fLXKNqSPuCbWwNGLFs4eg-1
Received: by mail-wm1-f72.google.com with SMTP id c8-20020a7bc848000000b0033bf856f0easo10496969wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 08:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vZW4/JuATNmbqT39WM6Wldifr5uJSWbgQDWe+YfFz5w=;
        b=XBu1Upr6xr6Pn0PK2hf9xZQAaDhl2OP9d2RgJp1pSDvt0Z9ru0STA1s5lEdILY9udj
         s2mSDUT21HxHL04O/dLtO2gMtsqqslEmqDfvmDkmoAnadXX/7IXWlLFbHDJD91VN6XSQ
         WhePH2hp3uXc2CkOx+X7MNRFwGUqKKf3Fyczvw2SISs5iGe9D5i7T8lKqmHTiPKTkE38
         7FKmAvagxfV4Vyy+iRQNoifnToUHjN6IpN4EuwX85JCN6fPhmFFuCBKy/oWxA25+s3Wu
         sBi4GQKRq3Qfki8YfFy1xwYTRB47Y5EYsjCZDcyoUpYT+yfZCfNpMoHvw2Jli2hAC+KG
         Md/g==
X-Gm-Message-State: AOAM531RK6MsI3fcad27RDRroFIO/n3Wws/5eYdltuHks2sASINDz9H2
        Xu+coolHRvc3nEvqWN7cRNhFSNGbZWHZLnhiNR40untUM3sZGjsYpm86V4vepryecfsH8DJLGAE
        m2y4W4C8svn6KMxw3ixJwhfv9
X-Received: by 2002:a05:600c:34c2:: with SMTP id d2mr31197753wmq.102.1638116971746;
        Sun, 28 Nov 2021 08:29:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRc/Z3kDamUWfpAby3d8t9ZRNczcVQJkH5WO/uB63rEhSVcY5GG5mAxuBcGDc1Sdf0fdN8Zg==
X-Received: by 2002:a05:600c:34c2:: with SMTP id d2mr31197734wmq.102.1638116971552;
        Sun, 28 Nov 2021 08:29:31 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l8sm18321556wmc.40.2021.11.28.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 08:29:31 -0800 (PST)
Date:   Sun, 28 Nov 2021 17:29:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH] perf test: Reset shadow counts before loading
Message-ID: <YaOuadwZWje6HeTg@krava>
References: <20211128085810.4027314-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128085810.4027314-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 12:58:10AM -0800, Ian Rogers wrote:
> Otherwise load counting is an average. Without this change
> duration_time in test_memory_bandwidth will alter its value if an
> earlier test contains duration_time.
> 
> This patch fixes an issue that's introduced in the proposed patch:
> https://lore.kernel.org/lkml/20211124015226.3317994-1-irogers@google.com/
> in perf test "Parse and process metrics".
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

jirka

> ---
>  tools/perf/tests/parse-metric.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 574b7e4efd3a..07b6f4ec024f 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -109,6 +109,7 @@ static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
>  	struct evsel *evsel;
>  	u64 count;
>  
> +	perf_stat__reset_shadow_stats();
>  	evlist__for_each_entry(evlist, evsel) {
>  		count = find_value(evsel->name, vals);
>  		perf_stat__update_shadow_stats(evsel, count, 0, st);
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 


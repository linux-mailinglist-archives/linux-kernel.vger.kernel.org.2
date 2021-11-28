Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56011460747
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 16:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358235AbhK1PwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 10:52:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358191AbhK1PuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 10:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638114419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jzhBUSLHkvu2uQWnXVXCSs3RwPUOQ2M7ZMGyRnC3QHo=;
        b=SdEhF37q0tJrHeuIjgjjgDitsIFjHqvH4F149BWzFbTCHS1ghf9Yq40FMXDKAMDkXMkEzR
        ij4d/EooU63ikk4D2dJiPqiRSJ7hP87j+mNh9Ju7p6ZLVZho47W1VwN/2WmDPU4r2JgSTL
        x/W4M2uWT31d6kX7/Y/kLoR3uNd3Q/s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-K77R48nQNA-o7wbBSdQ6-g-1; Sun, 28 Nov 2021 10:46:58 -0500
X-MC-Unique: K77R48nQNA-o7wbBSdQ6-g-1
Received: by mail-wm1-f71.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so8977870wms.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 07:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jzhBUSLHkvu2uQWnXVXCSs3RwPUOQ2M7ZMGyRnC3QHo=;
        b=KXGvM/dNcQNrkUPZ6YiTWknUMWNcHRiAxHiFdjjn+SrA6siYA+UVErldy/9sgQJ08R
         hzG7fGyCvhxNqDJvSvRyWl/EQu+appRRQkfaIC+kOZ4We35nAnM7SAFj1DUz6SnCk6jI
         jCj3ZxqMSSXKBhE72B6o9PJ858dBHZVcmamolsslKIgLPDjUWfcRk9g7/id+WebcVO1V
         q5Q7DULutLQtGWPc7IcGfz5E9QkA71e3KGdy1dsMOaVJTUe0dXb9K2TENRdhGbmXiUZy
         T5NN7XeOp80oxCJBL2nf/t5sdavBdlN33jgNditX2cdGBJZ4CcBWJW24vaHKe/xlEnmV
         9BlQ==
X-Gm-Message-State: AOAM530v/Rfs7mSS6vRraYR+/a46zh+Js66J6xubrcH8xQAK/zrzQAM4
        cZ95GccEs8KGYn5FsC4SFQKfR9ji00LUSHG5S5/uCpytKIpV8vVM/YKsfLWmeyuN6oORX+gVeBy
        y/J6BCjR3s/wm2Csyj8JZMoh1
X-Received: by 2002:adf:a319:: with SMTP id c25mr27991824wrb.629.1638114416913;
        Sun, 28 Nov 2021 07:46:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7xAb4udvo/ymkXj/pu7DzjgJCDLhQtNvKrcA+r2EkjcEbwJ8W/lrVqwFUy5ntiie0VMX6wQ==
X-Received: by 2002:adf:a319:: with SMTP id c25mr27991812wrb.629.1638114416779;
        Sun, 28 Nov 2021 07:46:56 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id j40sm19133082wms.19.2021.11.28.07.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 07:46:56 -0800 (PST)
Date:   Sun, 28 Nov 2021 16:46:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf header: Fix memory leaks
Message-ID: <YaOkbojVb2gZtfCk@krava>
References: <20211118201730.2302927-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118201730.2302927-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 12:17:30PM -0800, Ian Rogers wrote:
> These leaks were found with leak sanitizer running "perf pipe recording
> and injection test". In pipe mode feat_fd may hold onto an events struct
> that needs freeing. When string features are processed they may
> overwrite an already created string, so free this before the overwrite.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/header.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 79cce216727e..e3c1a532d059 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2321,6 +2321,7 @@ static int perf_header__read_build_ids(struct perf_header *header,
>  #define FEAT_PROCESS_STR_FUN(__feat, __feat_env) \
>  static int process_##__feat(struct feat_fd *ff, void *data __maybe_unused) \
>  {\
> +	free(ff->ph->env.__feat_env);		     \

hm, how is this set before this callback is triggered?

jirka

>  	ff->ph->env.__feat_env = do_read_string(ff); \
>  	return ff->ph->env.__feat_env ? 0 : -ENOMEM; \
>  }
> @@ -4124,6 +4125,7 @@ int perf_event__process_feature(struct perf_session *session,
>  	struct perf_record_header_feature *fe = (struct perf_record_header_feature *)event;
>  	int type = fe->header.type;
>  	u64 feat = fe->feat_id;
> +	int ret = 0;
>  
>  	if (type < 0 || type >= PERF_RECORD_HEADER_MAX) {
>  		pr_warning("invalid record type %d in pipe-mode\n", type);
> @@ -4141,11 +4143,13 @@ int perf_event__process_feature(struct perf_session *session,
>  	ff.size = event->header.size - sizeof(*fe);
>  	ff.ph = &session->header;
>  
> -	if (feat_ops[feat].process(&ff, NULL))
> -		return -1;
> +	if (feat_ops[feat].process(&ff, NULL)) {
> +		ret = -1;
> +		goto out;
> +	}
>  
>  	if (!feat_ops[feat].print || !tool->show_feat_hdr)
> -		return 0;
> +		goto out;
>  
>  	if (!feat_ops[feat].full_only ||
>  	    tool->show_feat_hdr >= SHOW_FEAT_HEADER_FULL_INFO) {
> @@ -4154,8 +4158,9 @@ int perf_event__process_feature(struct perf_session *session,
>  		fprintf(stdout, "# %s info available, use -I to display\n",
>  			feat_ops[feat].name);
>  	}
> -
> -	return 0;
> +out:
> +	free_event_desc(ff.events);
> +	return ret;
>  }
>  
>  size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 


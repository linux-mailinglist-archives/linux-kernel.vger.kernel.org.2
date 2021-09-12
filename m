Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1681340819A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 22:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhILUqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 16:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231560AbhILUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 16:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631479493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K8xc7zduLKmlrMQQg+zxngqMno8vR1/2aeZWRFBHo+0=;
        b=O6ir3TKipR6lGI0OeDPnMuO3kuAvyS9UwWTHXKMI4RBY+x/RCNIfz/6Lv0TjfWM4VF4k5p
        fiN1+CnFbS467vL0rrgfnEEmvvrZK4dOmqh5mUVNsWk7exiM2jxN3sV0A1nt/OFaC5t68S
        ppFNjAa2iE24HVydP236DzmStstYG6Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-Ud5rF-hdN8qeMmaNcd3WUw-1; Sun, 12 Sep 2021 16:44:52 -0400
X-MC-Unique: Ud5rF-hdN8qeMmaNcd3WUw-1
Received: by mail-ej1-f72.google.com with SMTP id s11-20020a170906060b00b005be824f15daso2809233ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 13:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K8xc7zduLKmlrMQQg+zxngqMno8vR1/2aeZWRFBHo+0=;
        b=cz0K8VbacYraK+fB9WwGOM4AYtLfr7hkQ0Bg9BFCFh6j/3KV8AsDhnXE18RyMdofpS
         xKknpnG6Uiti2t6DL5bhI9cv2/2Oq3Xfd4r2dCFwL18VHp+VOGoUPZYFmD+ir+APi9fI
         cQtn0ftltQh+qqIgVLHe7zEpxzBOY0fGneElu9myEsxHKAKLjAkpwXpPvuJ+zJBTtQ6w
         lHIMwA2RPlfyUeGe0/Qdid6t8TDqWZum6NeN7Kwg9u+F8DF+oDeW82NUiqViRJHxoz1A
         kpcujce88Wef9kB2uaG4+hZwpY9pS7rk726R6MkoSR1C3SLZdBRVPKo57NDSZe2TW4yf
         kPFA==
X-Gm-Message-State: AOAM530DoZT7XOPk6OaUUXSnVowUm7ujmiPpkoMQ0YU5OxtX8vWoHnCe
        BnpIECeXgmuHMW9CZqYJcLFpWldn6fum9X8WcgQfGBaglONlvZ2gwyFFFIJ1qLtsv1PWveuwoy+
        AjjKXIet/HcwpfnuFPBVeIGLc
X-Received: by 2002:aa7:dcd0:: with SMTP id w16mr9588554edu.288.1631479491111;
        Sun, 12 Sep 2021 13:44:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZ0fIuFL2rFne4OSxU+FW7Wm3wW4XY6Q4SJC0NmcxprwJ2sbpO8ttJsIFQNQQGmn189fKBAA==
X-Received: by 2002:aa7:dcd0:: with SMTP id w16mr9588547edu.288.1631479490962;
        Sun, 12 Sep 2021 13:44:50 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id z6sm2406735ejj.13.2021.09.12.13.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:44:50 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:44:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v11 19/24] perf session: Introduce reader objects in
 session object
Message-ID: <YT5mwObzZ20BN5oz@krava>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
 <117061f9be283a79d38068818b8a0038fbe578e1.1629186429.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117061f9be283a79d38068818b8a0038fbe578e1.1629186429.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:23:22AM +0300, Alexey Bayduraev wrote:
> Allow to allocate multiple reader objects, so we could load multiple
> data files located in data directory at the same time.
> 
> Design and implementation are based on the prototype [1], [2].
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/util/session.c | 33 +++++++++++++++++++++------------
>  tools/perf/util/session.h |  3 +++
>  2 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index a82204d4c4d6..1f92d3cfcb1d 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -343,6 +343,10 @@ void perf_session__delete(struct perf_session *session)
>  	auxtrace_index__free(&session->auxtrace_index);
>  	perf_session__destroy_kernel_maps(session);
>  	perf_session__delete_threads(session);
> +	if (session->readers) {
> +		zfree(&session->readers);
> +		session->nr_readers = 0;
> +	}
>  	perf_session__release_decomp_events(session);
>  	perf_env__exit(&session->header.env);
>  	machines__exit(&session->machines);
> @@ -2303,14 +2307,7 @@ static s64 process_simple(struct perf_session *session,
>  
>  static int __perf_session__process_events(struct perf_session *session)
>  {
> -	struct reader rd = {
> -		.fd		= perf_data__fd(session->data),
> -		.data_size	= session->header.data_size,
> -		.data_offset	= session->header.data_offset,
> -		.process	= process_simple,
> -		.path		= session->data->file.path,
> -		.in_place_update = session->data->in_place_update,
> -	};
> +	struct reader *rd;
>  	struct ordered_events *oe = &session->ordered_events;
>  	struct perf_tool *tool = session->tool;
>  	struct ui_progress prog;
> @@ -2318,12 +2315,24 @@ static int __perf_session__process_events(struct perf_session *session)
>  
>  	perf_tool__fill_defaults(tool);
>  
> -	if (rd.data_size == 0)
> -		return -1;
> +	rd = session->readers = zalloc(sizeof(struct reader));
> +	if (!rd)
> +		return -ENOMEM;
> +
> +	session->nr_readers = 1;
> +
> +	*rd = (struct reader) {
> +		.fd		 = perf_data__fd(session->data),
> +		.data_size	 = session->header.data_size,
> +		.data_offset	 = session->header.data_offset,
> +		.process	 = process_simple,
> +		.path		 = session->data->file.path,
> +		.in_place_update = session->data->in_place_update,
> +	};
>  
> -	ui_progress__init_size(&prog, rd.data_size, "Processing events...");
> +	ui_progress__init_size(&prog, rd->data_size, "Processing events...");
>  
> -	err = reader__process_events(&rd, session, &prog);
> +	err = reader__process_events(rd, session, &prog);
>  	if (err)
>  		goto out_err;

hm, leaking rd in here?

jirka

>  	/* do the final flush for ordered samples */
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index 308cf48e0945..b9b9468d8f17 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -19,6 +19,7 @@ struct thread;
>  
>  struct auxtrace;
>  struct itrace_synth_opts;
> +struct reader;
>  
>  struct perf_session {
>  	struct perf_header	header;
> @@ -41,6 +42,8 @@ struct perf_session {
>  	struct zstd_data	zstd_data;
>  	struct decomp		*decomp;
>  	struct decomp		*decomp_last;
> +	struct reader		*readers;
> +	int			nr_readers;
>  };
>  
>  struct decomp {
> -- 
> 2.19.0
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE441528A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhIVVSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237840AbhIVVSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632345420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h9XciI8CgY0oAFbvgg75jCc0JCEwmQ6YfL9zOXhGyA0=;
        b=KbrErJ8OPAC0JV0vt/8bZchdrC1AlcnlYCmv4auyHOmz0zvCZRnq5SHhSRWiwWnUWlgaoe
        OsVz3hMmFO0jUzOBoKqEJTqHp0SFgXrzLem3WkMU6/znpYzMbwcmxV3+FLQtEuN5Je7rZz
        Xv8TzHccwyZJUea1D4sliiX3w6BdJ6I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-U33B9DTxMCCAZXv9ff20Wg-1; Wed, 22 Sep 2021 17:16:58 -0400
X-MC-Unique: U33B9DTxMCCAZXv9ff20Wg-1
Received: by mail-wr1-f69.google.com with SMTP id s14-20020adff80e000000b001601b124f50so3346948wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h9XciI8CgY0oAFbvgg75jCc0JCEwmQ6YfL9zOXhGyA0=;
        b=BlRhRIu4SAvIhgtOOTfopoJ/pqdF4DRSoqkK4jT8gzvPTMtUvKWcc3xY4eM76TWYRh
         9XV8Bf6FIeut7j85aJ+w/T7luGXpr1mjEVO+K0iL1hOWlCLiCXZmvdCbaJTfdif/7CnO
         dSUZuoEMFSweWTrXviGfhrUYgbK/H8kWNwkDzIeseo8x8/rUv71x9BpRU42KQr1O/DXw
         kzDVh/uW4j4ErxUEFResUXu9JnSSC4LQeaZmc+vh0qJHZohrER10JY//eddaKm7VNhkk
         f5ZfmgZri3raScBSJM+M2m4IKTtHpWBW6gTRveZWgEf+HmV81+8RLHDW18zTILaE/lo6
         sjDA==
X-Gm-Message-State: AOAM530NYvGGW0bHtz0YfUQPz11q6VHfRbnSuhELJIs4tV2747vDsYhA
        +7iyq7u2nVdSSqHoLOfYc2auyF4WasOlFkozJTJJ8WPeBw6gvhzITkMNBqEAvY6yy9YbGUZ8cJW
        yfR3vavkMhvGbMTiUTYA9NKhV
X-Received: by 2002:a5d:4f02:: with SMTP id c2mr1265778wru.10.1632345417662;
        Wed, 22 Sep 2021 14:16:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUGJW0fMuTnzblv8vg/e92wQMuWOfHeTBFuXBDxELdzgGMsmb5dwknTE/UAX4PyXCYg4r6tw==
X-Received: by 2002:a5d:4f02:: with SMTP id c2mr1265760wru.10.1632345417466;
        Wed, 22 Sep 2021 14:16:57 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id m29sm3370410wrb.89.2021.09.22.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:16:57 -0700 (PDT)
Date:   Wed, 22 Sep 2021 23:16:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2] perf evlist: Remove group option.
Message-ID: <YUudR8ST7qGYdFQE@krava>
References: <20210921181349.199780-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921181349.199780-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:13:49AM -0700, Ian Rogers wrote:

SNIP

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 8feef3a05af7..9cd79513eebb 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1109,14 +1109,6 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
>  				   PyObject *args, PyObject *kwargs)
>  {
>  	struct evlist *evlist = &pevlist->evlist;
> -	int group = 0;
> -	static char *kwlist[] = { "group", NULL };
> -
> -	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOii", kwlist, &group))
> -		return NULL;
> -
> -	if (group)
> -		evlist__set_leader(evlist);
>  
>  	if (evlist__open(evlist) < 0) {
>  		PyErr_SetFromErrno(PyExc_OSError);
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index bff669b615ee..9e694db7c7ee 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -99,13 +99,6 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
>  	bool use_comm_exec;
>  	bool sample_id = opts->sample_id;
>  
> -	/*
> -	 * Set the evsel leader links before we configure attributes,
> -	 * since some might depend on this info.
> -	 */
> -	if (opts->group)
> -		evlist__set_leader(evlist);
> -

I don't mind erasing that, but just curious if you're going
to add something which would clash with this? it does not
look too complex for the code.. but still, let's remove it
if it's in 'legacy mode' for this long ;-)

thanks,
jirka


>  	if (evlist->core.cpus->map[0] < 0)
>  		opts->no_inherit = true;
>  
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index 68f471d9a88b..d71dee9ce41c 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -13,7 +13,6 @@ struct option;
>  
>  struct record_opts {
>  	struct target target;
> -	bool	      group;
>  	bool	      inherit_stat;
>  	bool	      no_buffering;
>  	bool	      no_inherit;
> -- 
> 2.33.0.464.g1972c5931b-goog
> 


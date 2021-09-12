Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657924081A3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 22:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhILUqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 16:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236436AbhILUqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 16:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631479534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nz/SHfiZKSjrdeek/3NP4iE5Fo2U6gkjdfLRfVYygDY=;
        b=ZEUEyj8WWOvNAbQl1chDZgP0KW3ghutXlyE/0287kElwodUcm8872Yb49dSb1zqelO6Gv/
        aSJtr/6xwzOpUQIxLyI8AygZ7nkmrGcA7TNlRq4I9nUEEVZPpKmF+TEoH2E5mfD6TfdsFO
        aW8EU3SXPUNg1ocEbIrd2GsC25AXWSU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-dWTQJAXQOEWYFqTFUtxn2Q-1; Sun, 12 Sep 2021 16:45:33 -0400
X-MC-Unique: dWTQJAXQOEWYFqTFUtxn2Q-1
Received: by mail-ed1-f71.google.com with SMTP id u2-20020aa7d982000000b003cda80fa659so3856255eds.14
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 13:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nz/SHfiZKSjrdeek/3NP4iE5Fo2U6gkjdfLRfVYygDY=;
        b=G2z+WS7AQdsNvqsS4D1Dqy1dtACllrRdMkZmDtza9fY0zbnF0Vj4zqoRxSmYvqQK+I
         wEzKxA4UgAA+CJuTydrXbE2o6fae3/O+QOKF49RqlVZAekwO9CBtqXj3pz6tJhOkMu8c
         cxCygkzxDSBAZNfp7lAooDAaErFftVdhvws3tHAsJHWEOgbKVdVxY2sIxd2mhVefY2fC
         v32wThIr+4rSjWK+sHFqCSX4YsJiGqqLcOw38XGrig5/IcStHrrVTK+wZaC6JsOpGqvY
         xxi/bJlxqbq7DVIBMNcO0oGeelEmgP7xw6BojVL/ebEH/MXT5gNcASs5bw+GvZikfEpf
         BkoQ==
X-Gm-Message-State: AOAM533EB0Gt5nP6EopAtpNss4a95lYFdH4aW2h/qtB6VZdJgsigZjbc
        yOYXbmEIPPR0XdtsFANzy5z7DOIn5cZ3UBxwGs4VPPSFEZOZjLzO+19dHyMOSTb04F0af7AoSLO
        qaAyJ5KpL3DOz29JU7ltGG1zm
X-Received: by 2002:a50:bb09:: with SMTP id y9mr5421978ede.89.1631479532538;
        Sun, 12 Sep 2021 13:45:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz7HXlj/YLaNlOrkxIThk8THVTerdJSPKGOjPKDVZdaT0YNU75rpTMq3G7NXBYw2r5fOpnyg==
X-Received: by 2002:a50:bb09:: with SMTP id y9mr5421957ede.89.1631479532399;
        Sun, 12 Sep 2021 13:45:32 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id e28sm2795337edc.93.2021.09.12.13.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:45:32 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:45:30 +0200
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
Subject: Re: [PATCH v11 01/24] perf record: Introduce thread affinity and
 mmap masks
Message-ID: <YT5m6rXn1Lvvx4OT@krava>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
 <328c6ae8904139d1fba882a2daa75405a086e5cf.1629186429.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <328c6ae8904139d1fba882a2daa75405a086e5cf.1629186429.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:23:04AM +0300, Alexey Bayduraev wrote:

SNIP

> +static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
> +{
> +	int ret;
> +
> +	ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu());
> +	if (ret)
> +		return ret;
> +
> +	record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
> +
> +	rec->nr_threads = 1;
> +
> +	return 0;
> +}
> +
> +static int record__init_thread_masks(struct record *rec)
> +{
> +	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
> +
> +	return record__init_thread_default_masks(rec, cpus);
> +}
> +
> +static void record__fini_thread_masks(struct record *rec)
> +{
> +	record__free_thread_masks(rec, rec->nr_threads);
> +
> +	rec->nr_threads = 0;

hum, is this needed?

jirka

> +}
> +
>  int cmd_record(int argc, const char **argv)
>  {
>  	int err;
> @@ -2883,6 +3011,12 @@ int cmd_record(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	err = record__init_thread_masks(rec);
> +	if (err) {
> +		pr_err("record__init_thread_masks failed, error %d\n", err);
> +		goto out;
> +	}
> +
>  	if (rec->opts.nr_cblocks > nr_cblocks_max)
>  		rec->opts.nr_cblocks = nr_cblocks_max;
>  	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
> @@ -2901,6 +3035,7 @@ int cmd_record(int argc, const char **argv)
>  	symbol__exit();
>  	auxtrace_record__free(rec->itr);
>  out_opts:
> +	record__fini_thread_masks(rec);
>  	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
>  	return err;
>  }
> -- 
> 2.19.0
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D163FB1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhH3HXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233963AbhH3HXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630308172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Of3siqEPDqPdwmkid/X1JM35PbSnr5CA8rhlc97cSLk=;
        b=evJ8pU0ERiGsg8Fi3xasxlfn9ogseMoVm2bLNW7RGeoWWKALQkaVY50Ss08lJ82K/Vu3MV
        7kj93m7V5qwJxs2uQbSwi8DnrdqANzsLZc+Cqc2fD0aPMS9pAWgNay5+4WDbAvKP30uK/U
        uFkRpvQVPh2CcWSglM9rw1cvt/G7IXk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-tDFVD-RkMn6YwipRhUceCA-1; Mon, 30 Aug 2021 03:22:50 -0400
X-MC-Unique: tDFVD-RkMn6YwipRhUceCA-1
Received: by mail-ej1-f70.google.com with SMTP id o14-20020a1709062e8e00b005d37183e041so3768434eji.21
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Of3siqEPDqPdwmkid/X1JM35PbSnr5CA8rhlc97cSLk=;
        b=QDmPQkzhIwwfafxpEwyc/TJsnWew+p/sZSOwoKbpkgZBlR/GoF1a76f6Qy7GU3BoWT
         YzaiN0oDrx5lINtUqr9lj6udBlt2Iqanh1Wbmdz7RK1eR6pfipE72qeI/z3fAGLTzINT
         qSOGKdbrUEeWaj7tAplil8W+jCfdBUXfbnQ9mDtKVhBGaHz+ZTDj+H3COYgjvaj1CqqM
         +Z5uzELixLY2zafSuO9QtnAdyAAcgSqc5yHhlsTDc4dfi0F7DTVjkhCwZLDfv2Lg6PlH
         r5UtaDAwZKJeMGSs1dY85gODpZ8dPeNX8AqoPnPKLPgGeUqXYBxK1gGgBm+jxbF0m4Ml
         vkDg==
X-Gm-Message-State: AOAM533ZNuTMc/CInO8hMiGny9FvEPIlZe4cRx90eOMqS1dB3dNx4BYs
        QP343Fq2hY5i49nGw1qujgtD5FPe1Ioth5K6nfzWNpSrydRGIp+S0iZ0WsoEa+ztUM+2oiMl+Z0
        eL0lJW1rKGamiXFAMpW4sVW67
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr24095530ejw.92.1630308169315;
        Mon, 30 Aug 2021 00:22:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUYRScVil9lF+0xDC2Uh3hvYc5ZqsR6nrogP5MwN1JFGIsdPqqzlItxfvtDafIOaReCwvRyg==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr24095517ejw.92.1630308169151;
        Mon, 30 Aug 2021 00:22:49 -0700 (PDT)
Received: from krava ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id p16sm7057110eds.63.2021.08.30.00.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:22:48 -0700 (PDT)
Date:   Mon, 30 Aug 2021 09:22:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Subject: Re: [RFC PATCH v3 07/15] perf workqueue: implement worker thread and
 management
Message-ID: <YSyHR7aP0OieedgE@krava>
References: <cover.1629454773.git.rickyman7@gmail.com>
 <e88e4e61309845043d1f0939b5c33cd60e9d3ed5.1629454773.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e88e4e61309845043d1f0939b5c33cd60e9d3ed5.1629454773.git.rickyman7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 12:53:53PM +0200, Riccardo Mancini wrote:

SNIP

>  /**
>   * create_workqueue - create a workqueue associated to @pool
>   *
> @@ -41,7 +361,8 @@ static const char * const workqueue_errno_str[] = {
>   */
>  struct workqueue_struct *create_workqueue(int nr_threads)
>  {
> -	int ret, err = 0;
> +	int ret, err = 0, t;
> +	struct worker *worker;
>  	struct workqueue_struct *wq = zalloc(sizeof(struct workqueue_struct));
>  
>  	if (!wq) {
> @@ -56,10 +377,16 @@ struct workqueue_struct *create_workqueue(int nr_threads)
>  		goto out_free_wq;
>  	}
>  
> +	wq->workers = calloc(nr_threads, sizeof(*wq->workers));
> +	if (!wq->workers) {
> +		err = -ENOMEM;
> +		goto out_delete_pool;
> +	}
> +
>  	ret = pthread_mutex_init(&wq->lock, NULL);
>  	if (ret) {
>  		err = -ret;
> -		goto out_delete_pool;
> +		goto out_free_workers;
>  	}
>  
>  	ret = pthread_cond_init(&wq->idle_cond, NULL);
> @@ -77,12 +404,41 @@ struct workqueue_struct *create_workqueue(int nr_threads)
>  		goto out_destroy_cond;
>  	}
>  
> +	wq->task.fn = worker_thread;
> +
> +	wq->pool_errno = threadpool__execute(wq->pool, &wq->task);
> +	if (wq->pool_errno) {
> +		err = -WORKQUEUE_ERROR__POOLEXE;
> +		goto out_close_pipe;
> +	}

hum, why the threadpool__execute in here? threads are not runnig at this
point, so nothing will happen right?

jirka

> +
> +	for (t = 0; t < nr_threads; t++) {
> +		err = spinup_worker(wq, t);
> +		if (err)
> +			goto out_stop_pool;
> +	}
> +
>  	return wq;
>  
> +out_stop_pool:
> +	lock_workqueue(wq);
> +	for_each_idle_worker(wq, worker) {
> +		ret = stop_worker(worker);
> +		if (ret)
> +			err = ret;
> +	}
> +	unlock_workqueue(wq);
> +out_close_pipe:
> +	close(wq->msg_pipe[0]);
> +	wq->msg_pipe[0] = -1;
> +	close(wq->msg_pipe[1]);
> +	wq->msg_pipe[1] = -1;
>  out_destroy_cond:
>  	pthread_cond_destroy(&wq->idle_cond);
>  out_destroy_mutex:
>  	pthread_mutex_destroy(&wq->lock);
> +out_free_workers:
> +	free(wq->workers);
>  out_delete_pool:
>  	threadpool__delete(wq->pool);
>  out_free_wq:
> @@ -96,12 +452,27 @@ struct workqueue_struct *create_workqueue(int nr_threads)
>   */

SNIP


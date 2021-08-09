Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EE83E452F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhHIMFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234617AbhHIMFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628510703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+z9CSxqzwcgihY+rR169k8okLByYqfQprIHpqjQt5hA=;
        b=Rw36Sb8MfdS2CJ9pmBoBM1jO9DpK/4Hf9yYj6WxsPoycZLebUTUV3Omz5FOhMR3f2YMgAE
        k8XG27KTZ0gmFCTdy7EpvxQEOdO8Z0q7brn6dzUBFX28d4ErBl90Z9BXq9DuxGguFP+ro5
        obMlkUTAmn7WnYif6pg6HoTrV5BUzcc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551--UoDoX3VMY6eI3vAG19IJQ-1; Mon, 09 Aug 2021 08:05:02 -0400
X-MC-Unique: -UoDoX3VMY6eI3vAG19IJQ-1
Received: by mail-ed1-f71.google.com with SMTP id k14-20020a05640212ceb02903bc50d32c17so8842479edx.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 05:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+z9CSxqzwcgihY+rR169k8okLByYqfQprIHpqjQt5hA=;
        b=Q3k29RJhpru+MRKcVW7n7XapDdmUQ3LbXVgKX7Io1Lv5kfgb+stUp1/cq5/+YcSzXY
         UOg67LpcvgXhrn4wcese5/AewEu4XqjxqnSAw8ZxefFn1Tl1Jc7dTS4sbjljrZjNWARp
         w7Ue2DenBUtuj18e9kNLh1GqmD7MjxKn7MxyDnCdt7W2HCkqIkA/7BMpqmu+e52vnrRi
         bJmgumxv+2Mf3QAPc5U/vx8ctypI4eLKwpucBy1LEfiiW11KkAlld7og8GQr0iS+jl26
         mgLBk8O7gu+8ZosZHnbHRPWht96muyWauy1jzbn0YF6h4JxRclXMhFOcoQIz0SJ96sTq
         cMmA==
X-Gm-Message-State: AOAM532vmPZp10iCOP99D01JXV4yeZDGbhSG7lwSY+VpHgKfoA74eWVm
        Mczr+cy3/uAN389Uxc+5Ovpx9o1d2s/9C+ki+P+h8o7aecSbD724TLE8Hh8bACPWG6axr7xac8K
        ikKYFArKLdGzNtYCIWjrS6g5E
X-Received: by 2002:a17:907:2b09:: with SMTP id gc9mr8203848ejc.49.1628510701332;
        Mon, 09 Aug 2021 05:05:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnR/WopfgC7031GUaVJc9iF0eg3jJjWLQrhMBUBYQNg2Q8EedFbZgObWIB3eAqyltqsFMA4Q==
X-Received: by 2002:a17:907:2b09:: with SMTP id gc9mr8203827ejc.49.1628510701150;
        Mon, 09 Aug 2021 05:05:01 -0700 (PDT)
Received: from krava ([83.240.61.5])
        by smtp.gmail.com with ESMTPSA id r27sm8039187edb.66.2021.08.09.05.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:05:00 -0700 (PDT)
Date:   Mon, 9 Aug 2021 14:04:59 +0200
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
Subject: Re: [RFC PATCH v2 06/10] perf workqueue: introduce workqueue struct
Message-ID: <YREZ65Jw9J5bB68u@krava>
References: <cover.1627657061.git.rickyman7@gmail.com>
 <c946622ece7d1d1b99912563f6a7c56402955156.1627657061.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c946622ece7d1d1b99912563f6a7c56402955156.1627657061.git.rickyman7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 05:34:13PM +0200, Riccardo Mancini wrote:

SNIP

> +static void worker_thread(int tidx, struct task_struct *task)
> +{
> +
> +	pr_info("Hi from worker %d, executing task %p\n", tidx, task);
> +}
> +
> +/**
> + * attach_threadpool_to_workqueue - start @wq workers on @pool
> + */
> +static int attach_threadpool_to_workqueue(struct workqueue_struct *wq,
> +					struct threadpool *pool)
> +{
> +	if (!threadpool__is_ready(pool)) {
> +		pr_debug2("workqueue: cannot attach to pool: pool is not ready\n");
> +		return -WORKQUEUE_ERROR__NOTALLOWED;
> +	}
> +
> +	wq->pool = pool;
> +
> +	wq->pool_errno = threadpool__execute(pool, &wq->task);
> +	if (wq->pool_errno)
> +		return -WORKQUEUE_ERROR__POOLEXE;

SNIP

> +
> +/**
> + * create_workqueue - create a workqueue associated to @pool
> + *
> + * Only one workqueue can execute on a pool at a time.
> + */
> +struct workqueue_struct *create_workqueue(struct threadpool *pool)
> +{
> +	int ret, err = 0;
> +	struct workqueue_struct *wq = malloc(sizeof(struct workqueue_struct));
> +
> +	if (!wq) {
> +		err = -ENOMEM;
> +		goto out_return;
> +	}
> +
> +	ret = pthread_mutex_init(&wq->lock, NULL);
> +	if (ret) {
> +		err = -ret;
> +		goto out_free_wq;
> +	}
> +
> +	ret = pthread_cond_init(&wq->idle_cond, NULL);
> +	if (ret) {
> +		err = -ret;
> +		goto out_destroy_mutex;
> +	}
> +
> +	wq->pool = NULL;
> +	INIT_LIST_HEAD(&wq->busy_list);
> +	INIT_LIST_HEAD(&wq->idle_list);
> +
> +	INIT_LIST_HEAD(&wq->pending);
> +
> +	ret = pipe(wq->msg_pipe);
> +	if (ret) {
> +		err = -ENOMEM;
> +		goto out_destroy_cond;
> +	}
> +
> +	wq->task.fn = worker_thread;
> +
> +	ret = attach_threadpool_to_workqueue(wq, pool);
> +	if (ret) {
> +		err = ret;
> +		goto out_destroy_cond;
> +	}
> +
> +	wq->status = WORKQUEUE_STATUS__READY;
> +
> +	return wq;
> +
> +out_destroy_cond:
> +	pthread_cond_destroy(&wq->idle_cond);

leaking wq->msg_pipe?

thanks,
jirka

> +out_destroy_mutex:
> +	pthread_mutex_destroy(&wq->lock);
> +out_free_wq:
> +	free(wq);
> +out_return:
> +	return ERR_PTR(err);
> +}
> +


SNIP


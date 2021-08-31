Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25FD3FCD10
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbhHaSrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239498AbhHaSri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630435602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/RxQVYmK+yNYBTCuOat/QUyeOlO0WxA8hvVfGxmPpM=;
        b=e8Xkqc5MJDUQ9715df7vDrq4IVOnjA5tyVighsXDvJ7FcFwplEZw9ujAFVAuMaDGShUHbT
        2PPZTpvwcL0plYnq8wz4jKJqj0CsSCX/DWqUzMUEriftsqUQjlz0PNmo0QYiQ+LhE3Vf3J
        CrWmsVDMbF/1PaTkHAofRPYEkuYlOc0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-NZltg8OSOR2xJE6Qp2ljEw-1; Tue, 31 Aug 2021 14:46:41 -0400
X-MC-Unique: NZltg8OSOR2xJE6Qp2ljEw-1
Received: by mail-ej1-f70.google.com with SMTP id x21-20020a170906135500b005d8d4900c5eso191150ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w/RxQVYmK+yNYBTCuOat/QUyeOlO0WxA8hvVfGxmPpM=;
        b=Wjk0B3gA280KkMnvcnpiHPxWnOa76vpdFA4krQGfSfqT4cYnfZqMtwwrkQFiB0QNy8
         OWeGoA8EGXpUQrccc48iO5NljgaxJxXqz+TDFrKLL8cxaHRxN91bYtLOwHzA7cuRjiMV
         KfiuN9FVE4pVojlUz9LvhIcLec8gKkP6sRmQDC6BOocYuy4W4y/hD7atvLooZvtAYhhp
         lBmYExgf7mCy4DITAkLEDwjFq+EMhx45fjDBw6n31fWHGTKed783Y7TShFuj9hNT7rpV
         i646dqTbNFNoVZAl+Z+dcrfPIKKZZCcOO8Qd+9u2L5ye8HTXJ3K9S5F8XOMo+lwzaqfy
         vJXw==
X-Gm-Message-State: AOAM532+M68ph4ls1HfHgW777Xnjj7iI/erB05THbrgfxyeJGTHOH2Rb
        orD7E3iMW7FwEuhHUyFVX5WsrOFCRrYjC5Ib4b5rDMcbcc3H8yr8KHwGR6qoOV5gkbk9jqZOxeE
        qEUXR1qElITHVTLZvaxOCVZu/
X-Received: by 2002:a50:fd02:: with SMTP id i2mr27374860eds.22.1630435600256;
        Tue, 31 Aug 2021 11:46:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAnAraI2EzWz6HoM1/oanveLpg3orBWapWG1Qzl7HEp7+G+nSYqOJAVduj6mVRAPtIDnQdrQ==
X-Received: by 2002:a50:fd02:: with SMTP id i2mr27374846eds.22.1630435600051;
        Tue, 31 Aug 2021 11:46:40 -0700 (PDT)
Received: from krava ([2a00:102a:4005:bb4:e4bf:9f13:dbe6:2d14])
        by smtp.gmail.com with ESMTPSA id i6sm8600992ejr.68.2021.08.31.11.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:46:39 -0700 (PDT)
Date:   Tue, 31 Aug 2021 20:46:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     =?utf-8?B?5Y+25r6E6ZSL?= <dg573847474@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, CAI Yuandao <ycaibb@cse.ust.hk>
Subject: Re: Possible deadlock errors in tools/perf/builtin-sched.c
Message-ID: <YS5uAwp8dGn4CK1V@krava>
References: <CAAo+4rXNLdgvAiT2-B8cWtLNPnWoGo9RWMW=8SPchzRgxJ4BhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAo+4rXNLdgvAiT2-B8cWtLNPnWoGo9RWMW=8SPchzRgxJ4BhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 03:57:17PM +0800, 叶澄锋 wrote:
> Dear developers:
> 
> Thank you for your checking.
> 
> It seems there are two deadlock errors on the lock
> *sched->work_done_wait_mutex*and*sched->start_work_mutex.*
> 
> They are triggered due to one thread(A) runs function *run_one_test* locating
> in a loop and unreleasing the two locks in the*wait_for_tasks*function, and
> another thread(B) runs function *thread_func *acquiring the two locks.
> 
> Because the two locks are not properly released in thread A, there will be
> a  deadlock problem if thread B acquires the two locks.

hi,
do you have a way to reproduce this?

thanks,
jirka

> 
> The related codes are below:
> 
> Thread A:
> 
> static void create_tasks(struct perf_sched *sched)
> {
>      ...;
>   err = pthread_mutex_lock(&sched->start_work_mutex);
>     ...;
>  err = pthread_mutex_lock(&sched->work_done_wait_mutex);
>        ...;
> }
> static int perf_sched__replay(struct perf_sched *sched)
> {
>    ...;
> 
>         create_tasks(sched);
>      printf("------------------------------------------------------------\n");
>      for (i = 0; i < sched->replay_repeat; i++)
>           run_one_test(sched);   // multiple reacquisition on the lock
> sched->work_done_wait_mutex and sched->start_work_mutex
> 
>    return 0;
> }
> 
> static void run_one_test(struct perf_sched *sched)
> {
>  ...;
>       wait_for_tasks(sched);
>         ...;
> }
> static void wait_for_tasks(struct perf_sched *sched)
> {
>        ...;
>     pthread_mutex_unlock(&sched->work_done_wait_mutex);
> 
>   ...;
>        ret = pthread_mutex_lock(&sched->work_done_wait_mutex);
>      ...;
>   pthread_mutex_unlock(&sched->start_work_mutex);
> 
>     ...;
> 
>  ret = pthread_mutex_lock(&sched->start_work_mutex);
>    ....;
> }
> 
> Thread B:
> 
> static void *thread_func(void *ctx)
> {
> 
> ...;
> ret = pthread_mutex_lock(&sched->start_work_mutex);
> ...;
> ret = pthread_mutex_unlock(&sched->start_work_mutex);
> 
> ...;
> 
> ret = pthread_mutex_lock(&sched->work_done_wait_mutex);
> ...;
> ret = pthread_mutex_unlock(&sched->work_done_wait_mutex);
> ..;
> 
> }
> 
> 
> Thanks,


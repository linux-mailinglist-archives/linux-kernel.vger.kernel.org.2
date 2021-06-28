Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3C83B5DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhF1MO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhF1MOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:14:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA150C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:12:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b1so2317527pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2xcGOgP/yg1u7n803j0UADdqFly0YaxV+TsFk8YNqGg=;
        b=q0XtAxQCldYUjMpu+SY9e/g2ItjBE0+iCawDmqpGlnW9tg1QZoxU1EerpByITcNWpo
         dYYERIGvOrhKWkz68obNn4RVU/T6Vn7ARfiLc9xK8sI+djcHH8LTkBtwf1IuK3ZX9q7m
         TfVz9UOi881d1rqWEIxZpFFpPdzqknoSGGszEtdO9IDm8V2EjYmJ4EZlHK8WK5EfIbKi
         HTtzL7Md3RkabxkmtU+Hd5AG+oheb+jkOs+1F+sEO/uncvw8yS53OsiNeDoXMguaZMcB
         yBGuqzS5L70IluQiN3qJ8EUc75jnbvDeTnDufd3tJ1hKp4lnAXQAxofN2vkO8GRPJwUi
         gEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xcGOgP/yg1u7n803j0UADdqFly0YaxV+TsFk8YNqGg=;
        b=YhU2Qdm+CAqqMDaL3JEPcqqZmElq6Ej0FeH8d0tuA4kLvUFoSZ+WlLIJxdOTjtzB1A
         e5F5nVStZRyHTlKSDR5a8Kb8VBHye181G++3OmNpXf0cwopJD+3RH7mTHfFvx/1VozzH
         HiOpTWw2srDP7A1hqbovLEMAIO2ADXagKfwdCMsegg7X6Z75dEnEDBxzmnhfhqQbAHJW
         0lVYufI+GZz/9rb0snFYZnZYv5hmtKCH9TvU94C+LL8YTTzfaA49YrIp2ls0OB/hqHvf
         GYe/g65rm4SnkgU5N8c80XJPbKVhblyxZxav2J4N8EIrCF3wtycSeAY8QJ3hFeKeitKE
         1cRA==
X-Gm-Message-State: AOAM532cQPTyew5Drg4y+nl+6gKHG1aW+PErrwjx2iCMO10GeWUwNSor
        VHAueyk3g8drFdbqS/qjP8t0Fw==
X-Google-Smtp-Source: ABdhPJy3t88iPCr1uRgXPIlJRE1hWIf9EVjMlvHN4QcQ52KFGeWoAA5vxIvilcuwAN6yuVxJVewSOw==
X-Received: by 2002:a17:902:e04f:b029:eb:66b0:6d08 with SMTP id x15-20020a170902e04fb02900eb66b06d08mr22425677plx.50.1624882343334;
        Mon, 28 Jun 2021 05:12:23 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id b22sm6140182pfp.20.2021.06.28.05.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:12:22 -0700 (PDT)
Date:   Mon, 28 Jun 2021 20:12:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] perf arm-spe: Don't wait for PERF_RECORD_EXIT
 event
Message-ID: <20210628121217.GD200044@leoy-ThinkPad-X240s>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
 <20210519071939.1598923-6-leo.yan@linaro.org>
 <369fd454-d94d-daa1-ead4-b42645ec4282@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <369fd454-d94d-daa1-ead4-b42645ec4282@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 02:25:15PM +0100, James Clark wrote:
> 
> 
> On 19/05/2021 08:19, Leo Yan wrote:
> > When decode Arm SPE trace, it waits for PERF_RECORD_EXIT event (the last
> > perf event) for processing trace data, which is needless and even might
> > cause logic error, e.g. it might fail to correlate perf events with Arm
> > SPE events correctly.
> > 
> > So this patch removes the condition checking for PERF_RECORD_EXIT event.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/arm-spe.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index 5c5b438584c4..58b7069c5a5f 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -717,11 +717,7 @@ static int arm_spe_process_event(struct perf_session *session,
> >  					sample->time);
> >  		}
> >  	} else if (timestamp) {
> > -		if (event->header.type == PERF_RECORD_EXIT) {
> > -			err = arm_spe_process_queues(spe, timestamp);
> > -			if (err)
> > -				return err;
> > -		}
> > +		err = arm_spe_process_queues(spe, timestamp);
> >  	}
> >  
> >  	return err;
> > 
> 
> For the whole set:
> Reviewed-by: James Clark <james.clark@arm.com>
> Tested-by: James Clark <james.clark@arm.com>

> I see a big improvement in decoding involving multiple processes because the timestamps are now
> correlated with the comm and mmap events.
> 
> For example perf-exec samples are visible right before the exec is done, and on an
> application that forks, samples are visible from all processes. For example:
> 
>    perf record -e arm_spe// -- bash -c "stress -c 1"
>    perf script
> 
>    perf-exec  4502 [003] 259755.050409:          1    l1d-access:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
>    perf-exec  4502 [003] 259755.050409:          1    tlb-access:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
>    perf-exec  4502 [003] 259755.050409:          1        memory:  ffff80001014b840 sched_clock+0x40 ([kernel.kallsyms])
>    perf-exec  4502 [003] 259755.050411:          1    tlb-access:  ffff800010120fb8 __rcu_read_lock+0x0 ([kernel.kallsyms])
>    bash  4502 [003] 259755.050411:          1   branch-miss:  ffff8000105b2a40 memcpy+0x80 ([kernel.kallsyms])
>    bash  4502 [003] 259755.050411:          1    tlb-access:                 0 [unknown] ([unknown])
>    ...
>    stress  4502 [003] 259755.051468:          1    l1d-access:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])
>    stress  4502 [003] 259755.051468:          1    tlb-access:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])
>    stress  4502 [003] 259755.051468:          1        memory:  ffff800010259a24 __vma_adjust+0x1f4 ([kernel.kallsyms])
> 
> Previously samples were only attributed to 'stress', which was obviously wrong.

Thanks a lot for the review and testing, James!

Hi Arnaldo, I confirmed this patch set can be cleanly applied on
the latest acme/perf/core branch, so could you pick up this patch
set?

Thanks,
Leo

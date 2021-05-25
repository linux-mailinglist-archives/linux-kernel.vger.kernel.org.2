Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D35390B63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhEYV1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 17:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhEYV1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 17:27:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157BAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 14:25:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t193so23788682pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fefthy5JQqZHYTq7v2oUt3hji9z3zt+V5ofBzQOWrw4=;
        b=n3vs82zyECucBBHyKuNMlzNdoXpxXquPqWgJp1qWSjQ/CqahdL6vw0Ek8FUIi83UfO
         N4hrJwf+ktr8qCwwo3gPllkGCVYRMbsM7yIHeJdWcAYgo8f+7jfEITEqfHvDxaIjHVfb
         OzhFO4Y2xZFlylmQ6D7mENhM5/dU3mzb4kwe0Q+rSsc4c93pd5ocvVV0gVWS3sLZCtLi
         EVbHQ6F+YH5K02BP3bGGtr7Erv/xSBCD3W/FfmZXj1IB20nZ9oIPuz/4VYZRONMba1+Z
         Pix7o3MGUtj1IUEoixfFHIZyX51psb4f5mLWFUXkKkc06j9UzMM0vjV5877/Yeov7TQF
         LtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Fefthy5JQqZHYTq7v2oUt3hji9z3zt+V5ofBzQOWrw4=;
        b=fjMSJux9OuY1pgAhpJ44bFl1sK8Tj9RIg23Hfyct8vQpaK1YzfLSP3GzSMMRpa0ZhW
         q3eK4P6+8lB+z+8UvaJFqHDG778JgZ8s2PZlsc1M5J21ts1fbhh9Pc7Qa5v/w91r5dt9
         ZidL9dcqSRNipl1Ag/027GYTHkXBTNcdpOQNjWrhp/R2vI42PyPuem7b/ohIvhJ4XfpO
         ZCnmojfthb0Jk46NwXSLrmmNw9+h2dAPOnZwriu/SuB5dAPoXGhrYEXmYdjTbMAag9bI
         HJNC1JQCn/MgpSLBuGwivo4oPIMPRsaCxBsunx+PilNTK2sdqN8PphCeVTUnbdDD1V6D
         18GA==
X-Gm-Message-State: AOAM532L1eXQOZM4YHodrVC/HfPyrGEi1z6Xi20f28uGMF1aE4tFapyJ
        k4dy0+SbC7mFFGVHmOfNqaR/tw==
X-Google-Smtp-Source: ABdhPJzlckM4rlSuGkP+0z1qVGbIRH87k/2O1Ri4PVXeACqZmcr3GD8Fpq2C72qT31FMxd9XeIcfPQ==
X-Received: by 2002:aa7:8a08:0:b029:2e0:299a:dfb3 with SMTP id m8-20020aa78a080000b02902e0299adfb3mr32509721pfa.28.1621977945349;
        Tue, 25 May 2021 14:25:45 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id f80sm13989754pfa.160.2021.05.25.14.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 14:25:43 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     changhuaixin <changhuaixin@linux.alibaba.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Odin Ugedal <odin@uged.al>, Odin Ugedal <odin@ugedal.com>,
        pauld@redhead.com, Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS controller
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
        <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
        <YKe89Uda+uJdx4X0@hirez.programming.kicks-ass.net>
        <C759D4F2-FA5F-4EB2-8441-C9ECD79AFD55@linux.alibaba.com>
        <YKzVu2cOYRN9TZD3@hirez.programming.kicks-ass.net>
Date:   Tue, 25 May 2021 14:25:33 -0700
In-Reply-To: <YKzVu2cOYRN9TZD3@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 25 May 2021 12:47:23 +0200")
Message-ID: <xm26pmxe4ib6.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, May 24, 2021 at 08:42:03PM +0800, changhuaixin wrote:
>
>> >> static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
>> >> @@ -4651,6 +4666,9 @@ static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
>> >> 	if (cfs_b->quota == RUNTIME_INF)
>> >> 		amount = min_amount;
>> >> 	else {
>> >> +		if (!cfs_b->period_active)
>> >> +			__refill_cfs_bandwidth_runtime(cfs_b);
>> > 
>> > Why this call?
>> 
>> As the cfs bandwidth timer stops on idle with runtime unfilled, refill runtime when it restarts to make
>> use of the underrun when period timer stops. Another way to do this might be:
>> 
>>         throttled = !list_empty(&cfs_b->throttled_cfs_rq);
>>         cfs_b->nr_periods += overrun;
>> 
>> +       __refill_cfs_bandwidth_runtime(cfs_b);
>> +
>>         /*
>>          * idle depends on !throttled (for the case of a large deficit), and if
>>          * we're going inactive then everything else can be deferred
>>          */
>>         if (cfs_b->idle && !throttled)
>>                 goto out_deactivate;
>> 
>> -       __refill_cfs_bandwidth_runtime(cfs_b);
>> -
>>         if (!throttled) {
>> 
>
> Ben, do you have a preference?


I think I prefer the latter, possibly with a
/* Refill extra burst quota even if cfs_b->idle */

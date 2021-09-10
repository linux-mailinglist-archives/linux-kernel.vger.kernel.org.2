Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82381406E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhIJQE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234634AbhIJQE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631289795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UtzAchFt0Lhk/coSSurUDkWQxyxTsyejteYjq47a0/U=;
        b=REy6i6QbuJrVtXQe/ibKx93T9VGJe5VXgUcYRgQpDdF0Y2cDNoJWrvi3qf1WJquQSO3ALP
        W82T3vI6MVZPyARX5O76nrZmDXF5TGSFeETo+gbJKrwdz3mxD5msieuJM9msFPT0R85iZ8
        Du3gFKaYFRB61J/dHiehN8j8H7T9wVQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-7aInikrdNqq2oOUo2WeJ-A-1; Fri, 10 Sep 2021 12:03:14 -0400
X-MC-Unique: 7aInikrdNqq2oOUo2WeJ-A-1
Received: by mail-qk1-f197.google.com with SMTP id o4-20020ae9f504000000b003d39d97b227so13459483qkg.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UtzAchFt0Lhk/coSSurUDkWQxyxTsyejteYjq47a0/U=;
        b=NEee9eAVs/pP3HRWmt0jWb7yj0q8GIX9aeS7iCwvpPCnGEUkMNpiL/bIxDym8Qf4EY
         ac0TKexs5QFdioG7hVvm1+gP98IUJ42CPI+Dl0u5/jD+SP0bg6KvdbnR3I6BcBw2fXP0
         Q/skZ3u59tV6fzdWqKRwUECgn1+9BRZ0Yf/Np2ioyJS0yMSDo4abG1hX6Ujuo7btuUaW
         fW1wskeiWvbVPtNiYZ+MT719BJDrjpdHxQx7g/RmGgX/5Nn3XrLcMS6fJ2MKvzIaEy28
         pXTl0nEM6rPnOGjAmMZ60024PYJ3jowM609gZFwVCMbKwQftbN8lFkUNl70DvkYXDx/6
         YWAg==
X-Gm-Message-State: AOAM530cuZNY4m9q54Ivr/nStE22NiSLk8dvgfVnroRu4lNyvFyRFljS
        fnxuDRaBJyAVECcUmjZ6r448b2xDtisE1vmEr2RgwPTO6ckqtEjgCrnjiiznyzzUKxecR88gQI3
        MYy08Uvphp+Ro3L9x9CljisPd
X-Received: by 2002:ad4:54e4:: with SMTP id k4mr9320537qvx.54.1631289792972;
        Fri, 10 Sep 2021 09:03:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6SZlgo7LHBrrx9oMOb7QAMtI6UI2XIgb6J+qceJloTj2GEpX7MffeBJ9UcNo1Vzg3eAAEUg==
X-Received: by 2002:ad4:54e4:: with SMTP id k4mr9320506qvx.54.1631289792746;
        Fri, 10 Sep 2021 09:03:12 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id x27sm3573915qtm.23.2021.09.10.09.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:03:12 -0700 (PDT)
Date:   Fri, 10 Sep 2021 09:03:03 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Fix idle cpu's tasks transition
Message-ID: <20210910160303.alfgjy25y5wfskwz@treble>
References: <patch.git-a4aad6b1540d.your-ad-here.call-01631177886-ext-3083@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <patch.git-a4aad6b1540d.your-ad-here.call-01631177886-ext-3083@work.hours>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 11:16:01AM +0200, Vasily Gorbik wrote:
> On an idle system with large amount of cpus it might happen that
> klp_update_patch_state() is not reached in do_idle() for a long periods
> of time. With debug messages enabled log is filled with:
> [  499.442643] livepatch: klp_try_switch_task: swapper/63:0 is running
> 
> without any signs of progress. Ending up with "failed to complete
> transition".
> 
> On s390 LPAR with 128 cpus not a single transition is able to complete
> and livepatch kselftests fail. Tests on idling x86 kvm instance with 128
> cpus demonstrate similar symptoms with and without CONFIG_NO_HZ.
> 
> To deal with that, since runqueue is already locked in
> klp_try_switch_task() identify idling cpus and trigger rescheduling
> potentially waking them up and making sure idle tasks break out of
> do_idle() inner loop and reach klp_update_patch_state(). This helps to
> speed up transition time while avoiding unnecessary extra system load.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Looks ok to me, but we should get an ack from Ingo or Peter since
livepatch would be calling another private scheduler interface.

> ---
> Previous discussion and RFC PATCH:
> lkml.kernel.org/r/patch.git-b76842ceb035.your-ad-here.call-01625661932-ext-1304@work.hours
> 
>  kernel/livepatch/transition.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 3a4beb9395c4..c5832b2dd081 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -308,6 +308,8 @@ static bool klp_try_switch_task(struct task_struct *task)
>  	rq = task_rq_lock(task, &flags);
>  
>  	if (task_running(rq, task) && task != current) {
> +		if (is_idle_task(task))
> +			resched_curr(rq);
>  		snprintf(err_buf, STACK_ERR_BUF_SIZE,
>  			 "%s: %s:%d is running\n", __func__, task->comm,
>  			 task->pid);
> -- 
> 2.25.4
> 

-- 
Josh


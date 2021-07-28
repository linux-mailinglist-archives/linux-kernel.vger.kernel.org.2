Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8183D8A55
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhG1JML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231392AbhG1JMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627463529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0UzH6ZtjqmvVUuUbDJrNe1a0MEljpB5/Wj9MuReAgFQ=;
        b=SQ3JPvoPLWWWBnZxb4ZkwQl/h29378XklNCuOdh1RMa32lAOIzputNde4rESae4VcnH0xX
        bTQi/gyvCCdGuGCDB386VZTPYB4j6FmC0RNf3Nc7kTh2rXBXLOIsfNQMJmoeSGXp4qzPwZ
        wMIRlTMKSDcSuPGJ7SpBmXuSNiAW1WA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-O70NxKX7MU2nGnqBTAWj4w-1; Wed, 28 Jul 2021 05:12:07 -0400
X-MC-Unique: O70NxKX7MU2nGnqBTAWj4w-1
Received: by mail-wm1-f71.google.com with SMTP id r2-20020a05600c35c2b029023a3f081487so690379wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0UzH6ZtjqmvVUuUbDJrNe1a0MEljpB5/Wj9MuReAgFQ=;
        b=Sn8U9+3jB5kqSOz4c2ax5o9yxCQSF64x768ORMtA2H82re72eoOigkmhqJyjh0Flgl
         74YkGz+y3d/ro9pWTdb+6axc0vW5e57PQi0bo7gW6jpibZBQQm2GcZCBjBJY1JeDwTvh
         TyZFUEtol5Ic0SFkmxaTYu/5Uylcx0q45XgfVkEU5Ts0NDsEI04mv+wYebYiv2lg+own
         9Lt6cWgHjREl55/EsOtLQtg0aRj78l9ym/X/pI08aAS+8EworVB3HYEEi9pIUmc96vRy
         pi4ZCbnIM8mvRAQz6sJApZGlY3WPhq4NCZLZdPPwIe+j5vHzTMpZcGdPGFWFKnNeLGW1
         fJeg==
X-Gm-Message-State: AOAM531ZON3+cMbAaebL7IIW0tZlsvJPFKiYlPyJH4B8lrOwfdamZ4HN
        Jp3ZrKaMYbnKv7DcAak5dxKJYDcP6jyZET166vYWk1jRakPFA8l903aeIVz4ykGYFXrloDpSmP2
        zQoPYofPCqLuAZiCtD2MZCDeW
X-Received: by 2002:adf:c549:: with SMTP id s9mr21973038wrf.344.1627463526301;
        Wed, 28 Jul 2021 02:12:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyumsHnT1GKl2elOyAhhf314GbGfQralP7R/j8jmkmIxn/sH3udBNPAxF2OBzas20rWrb9kEQ==
X-Received: by 2002:adf:c549:: with SMTP id s9mr21973015wrf.344.1627463526061;
        Wed, 28 Jul 2021 02:12:06 -0700 (PDT)
Received: from localhost.localdomain ([151.29.58.124])
        by smtp.gmail.com with ESMTPSA id f11sm5109982wmb.14.2021.07.28.02.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:12:05 -0700 (PDT)
Date:   Wed, 28 Jul 2021 11:12:03 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched: Don't report SCHED_FLAG_SUGOV in
 sched_getattr()
Message-ID: <YQEfY730Sjkr3w+Y@localhost.localdomain>
References: <20210727101103.2729607-1-qperret@google.com>
 <20210727101103.2729607-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727101103.2729607-3-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 27/07/21 11:11, Quentin Perret wrote:
> SCHED_FLAG_SUGOV is supposed to be a kernel-only flag that userspace
> cannot interact with. However, sched_getattr() currently reports it
> in sched_flags if called on a sugov worker even though it is not
> actually defined in a UAPI header. To avoid this, make sure to
> clean-up the sched_flags field in sched_getattr() before returning to
> userspace.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  kernel/sched/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d9ff40f4661..d8f489dcc383 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7535,6 +7535,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  		kattr.sched_priority = p->rt_priority;
>  	else
>  		kattr.sched_nice = task_nice(p);
> +	kattr.sched_flags &= SCHED_FLAG_ALL;

Maybe we can do this in the previous patch so that it's kept confined to
deadline bits?

Thanks,
Juri


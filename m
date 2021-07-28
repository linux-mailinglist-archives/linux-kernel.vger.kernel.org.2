Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A023D8DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhG1MiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234869AbhG1Mg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627475815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cjdy9NgWTqy6bx2gUVJeHE+WNLvpxTQaYwDjhcGu1m8=;
        b=frTN8cvjnOsAjnnRFvoJrEaMpphz9jEswp9DrvCFjOQSVLM/s5B9Z/gTwaiMIf5Ijq+Man
        DO0Kc36lskX3U4hSaZ22pkEd+sH5IJXOP95rKwc9/RU6Dm+JigBLplOUzppbn17reQIW/c
        NlnEM3b7DaRIJ0PDNUu/JEO4yR+iq4A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-LKSTyXzYP3O3vDe-ovgEFg-1; Wed, 28 Jul 2021 08:36:53 -0400
X-MC-Unique: LKSTyXzYP3O3vDe-ovgEFg-1
Received: by mail-wm1-f69.google.com with SMTP id f10-20020a7bcc0a0000b0290229a389ceb2so1383732wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 05:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cjdy9NgWTqy6bx2gUVJeHE+WNLvpxTQaYwDjhcGu1m8=;
        b=LM8qGPfl9E5orP7vlvVE9ISnl/ZDZArEUyLsU3bdyApLxo1I8xiLSoU1QksFM6ybEf
         yQ1xJG6n9YkVYLziKWhrz8kFfbBqzsSukGx6PEN79OIg67+TkMa5SXjmUhn+/nzNYdHZ
         PFE0A2wCABnEHUTsCfnqiYe5s4fH3hV1tvINKIxmNy5MwJYWXUUUY/7CIeezEFSdXL7P
         ydpNTIjZDLb2Nq9gdS4gAuFMH5T2hOsxsQDtpLy1WXjPVKSOL1X7koWwjdUFdznV/7Wn
         /5K/9ZfSf4wAPVZbpgpFD+lkAYTaXF//Z6PmqETIR9wk7dGKen6UZahv7Y9Mmx4G5IUl
         Uqtw==
X-Gm-Message-State: AOAM5312g1t8+hr0crwfsU4f5XJusyZspwpnvLEeJeoFxuvtiD9/CUSW
        bmvmLmpSCmmjcvADerMwPBduAo7BNtBoVGbGJ0WX5RM+3ieOQMXvzNn38o5k8RKR6lkgbTnL9E5
        Wa+YIebtMIyoE+NtfXKaIfFzJ
X-Received: by 2002:a7b:c144:: with SMTP id z4mr9159243wmi.54.1627475812800;
        Wed, 28 Jul 2021 05:36:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi4XsjjRCos0yNUBXbWfmJih8EIJgzL1MiA99CCht6Edln94PnYc3tD7mwOQZBZ69dphlOzQ==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr9159215wmi.54.1627475812581;
        Wed, 28 Jul 2021 05:36:52 -0700 (PDT)
Received: from localhost.localdomain ([151.29.58.124])
        by smtp.gmail.com with ESMTPSA id g7sm5517380wmq.22.2021.07.28.05.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:36:51 -0700 (PDT)
Date:   Wed, 28 Jul 2021 14:36:48 +0200
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
Message-ID: <YQFPYIqJG5PSPH1S@localhost.localdomain>
References: <20210727101103.2729607-1-qperret@google.com>
 <20210727101103.2729607-3-qperret@google.com>
 <YQEfY730Sjkr3w+Y@localhost.localdomain>
 <YQEl2t2RgaB9eEOZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQEl2t2RgaB9eEOZ@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/21 10:39, Quentin Perret wrote:
> On Wednesday 28 Jul 2021 at 11:12:03 (+0200), Juri Lelli wrote:
> > Hi Quentin,
> > 
> > On 27/07/21 11:11, Quentin Perret wrote:
> > > SCHED_FLAG_SUGOV is supposed to be a kernel-only flag that userspace
> > > cannot interact with. However, sched_getattr() currently reports it
> > > in sched_flags if called on a sugov worker even though it is not
> > > actually defined in a UAPI header. To avoid this, make sure to
> > > clean-up the sched_flags field in sched_getattr() before returning to
> > > userspace.
> > > 
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  kernel/sched/core.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 2d9ff40f4661..d8f489dcc383 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -7535,6 +7535,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
> > >  		kattr.sched_priority = p->rt_priority;
> > >  	else
> > >  		kattr.sched_nice = task_nice(p);
> > > +	kattr.sched_flags &= SCHED_FLAG_ALL;
> > 
> > Maybe we can do this in the previous patch so that it's kept confined to
> > deadline bits?
> 
> That works too, it just felt like this could happen again if we start
> using non-standard flags outside of deadline for any reason at some
> point in the future. But no strong opinion really.

Yeah, I also see this point. :)

So no prob with me to keep it in core.c as you do here.

Best,
Juri


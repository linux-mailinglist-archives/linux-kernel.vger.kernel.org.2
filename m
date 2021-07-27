Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76993D72EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbhG0KQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbhG0KQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:16:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797FAC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:16:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so10986759wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jxVZdhoxbvSsV206ccLjKsTWGSBDOYziicVCZk6f/Zg=;
        b=J6SAFBQqceWOnqou0mQyA9KqgX8ra7DMV2yS0MZwAuuTcNXA63GXwZP9jORE48Y7eC
         OvvKSeenQXflqirvrKOyzRtbBypuJjBQhzfCdHgdJ99xPXyeIFP7VWEaERaw+5f8GuRi
         FDcq57XQR1ElO1CKKDEzs1lZ0UXqNb3LMlqkuhRylZzU0t7XMqUbseN5GCKtts+nqug9
         hazoNQLez8KJZbMgBEgAM6++Y1ZSRnm2/d4P8vYJB9EYgZKh8t3YsOjgAKqEdiVx/805
         Cm8OTHtkU5kRDeTK/jYSt4ds5G3xo2CzoPzEwP50OQy7FH0ZcRrqf46KTsW9ksuXF0zM
         puxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jxVZdhoxbvSsV206ccLjKsTWGSBDOYziicVCZk6f/Zg=;
        b=OXV4mRyBH6s/RHZFLsz6LKFR1/8COiBvUZ/J85SklaDkuHjfSD/OWcOR5OfuKF1pSf
         j3FIyi10R20zfNHuRnDj4ZskoQ2eZUmhExwnAD2/bmw151Ow5squtdZ/P72iZDWkY3Bc
         hJJDe//66a65r5zAFsm8VCNhIBWvHxzYaaILQaZqkjvHEAyEGExjs6xyZRIzPREOm/I7
         lUyhsKyzQzbYOSNwaH+4psf4oBIS9u9df6240tOZhNIqD2NhJaVOdmJ3JRlLvzI47jQM
         BCK7fEUmO52v0zXCyF9BDkS2xL8z8Df2fRo1YqzHj8CAsVaHCWCUX26IbEWcRZGI1zL/
         SbAA==
X-Gm-Message-State: AOAM533jAEAvSRc84TXqvlGmM+/gzxQHWzMeVHlmfsFDdyqN7oYDCNDs
        LzNoyPbDc2EAzBroHTyEV223Lw==
X-Google-Smtp-Source: ABdhPJwAytDduvjTkauUqN98nXdqn1V0QAwi+LYa7rTS7HAz4WaQjW3fMuz+Am3mkd3UPjCjhXasvA==
X-Received: by 2002:adf:f112:: with SMTP id r18mr1269176wro.160.1627381011908;
        Tue, 27 Jul 2021 03:16:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:c468:e033:fa2b:3a6])
        by smtp.gmail.com with ESMTPSA id l22sm2184983wmp.41.2021.07.27.03.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 03:16:51 -0700 (PDT)
Date:   Tue, 27 Jul 2021 11:16:48 +0100
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        qais.yousef@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 2/2] sched: Skip priority checks with
 SCHED_FLAG_KEEP_PARAMS
Message-ID: <YP/dEMeULqozIqZd@google.com>
References: <20210719161656.3833943-1-qperret@google.com>
 <20210719161656.3833943-3-qperret@google.com>
 <ad30be79-8fb2-023d-9936-01f7173164e4@arm.com>
 <YP6++lClPCQvTLcK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP6++lClPCQvTLcK@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 Jul 2021 at 14:56:10 (+0100), Quentin Perret wrote:
> On Thursday 22 Jul 2021 at 10:47:33 (+0200), Dietmar Eggemann wrote:
> > (*) This changes the behaviour when setting uclamp values on a DL task.
> > 
> > Before uclamp values could be set but now, because of
> > 
> >   void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
> >     ..
> >     attr->sched_flags = dl_se->flags
> > 
> > SCHED_FLAG_UTIL_CLAMP gets overwritten and  __sched_setscheduler() bails in:
> > 
> >     if (unlikely(policy == p->policy)) {
> >       ...
> >       retval = 0;
> >       goto unlock;
> >     }
> >   change:
> > 
> > I.e. the:
> > 
> >       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> >         goto change;
> > 
> > can't trigger anymore.
> 
> Bah, as you said it doesn't seem to be a big deal, but clearly that was
> unintentional. Let me try and fix this.

While looking at this I found existing bugs in the area. Fixes are here:

https://lore.kernel.org/lkml/20210727101103.2729607-1-qperret@google.com/

And with the above series applied this patch should behave correctly
now.

Thanks,
Quentin

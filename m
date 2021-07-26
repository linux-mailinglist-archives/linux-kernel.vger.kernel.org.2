Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA853D5AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhGZNPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhGZNPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:15:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B915C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:56:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so39208wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LfwG04TViXLo81i2Z2iVU96m8B2zmfVEYWXebQatuCE=;
        b=aAvnxg9red7g/6+lzsKb1C1MUf5Iqj3Wmhj+3W/Q7RHG/H3cIC3/F+VnR0utj/fR+P
         Q8ZhBo72pLrXpyr9z3p1n786gbcCYySB0mNB9uN+xQQtESFkWrSKLMwMQPE6Io7vsTUA
         FY1XhRnQwnZomY8wSCpoRP8JsMaJcxeFPhZmSa468INdyyVNd1Vll/xZhA0r1D6V2d5j
         T/h+5GdctfAzZPB78c2RyYMO/krVB3Rrgxiazlrn0oiN2cp+yK/8zXAMkU/14OgenweA
         Em3YwHkrsHxYRnFqHY+f5hFLB12AoHIb/mcLLdoRSXT+qYwRelBmzUQ7Yv1XSK6rT7SI
         tP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LfwG04TViXLo81i2Z2iVU96m8B2zmfVEYWXebQatuCE=;
        b=Q7sr626Nioqg2sgU/UZOwjYm9KeXVUaTlyaqJpzUzZA55rzS36z/Hijljhur8YOLKT
         2pDe8JdjYlolA9niIuht+hGmpz8JcpYRqXHUCpWAtzoCds0Q9MbD7Dii0yU+MnZFOKQW
         Wrs1d7TNT8ssZnEk3TscOQ0dQYgiBKNAb+soINyWeC2H3rdWPrvAwDs+g57OfP+qxYuT
         B1RNO1RwtTqtNbTwKp9Ew/NTpw0WKTE71FLLfXahurVmZndDhpBMwNbpi/j2mLABsDnm
         szK83ZGsncspCizdLJd69TAFnvYE7NXhWrPo4q381yCC81btraewkgTrsjCEPcN4uLMD
         Zfpg==
X-Gm-Message-State: AOAM533QhpBc/v3XOplPNLmDpTvOvIAD9hBEzKY4mRTmXvb+7kd4pY6v
        MqHcSd43rqkNSVUwaE5up6+XuQ==
X-Google-Smtp-Source: ABdhPJwl5W0zdeOWh5Y4pa2kHPA7Sz3sh5uwr9h7ZyEbA/wZGa2zC05F4mHnY7jf8Ixppf1FvB0U3g==
X-Received: by 2002:a7b:cc8d:: with SMTP id p13mr26337599wma.145.1627307773606;
        Mon, 26 Jul 2021 06:56:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:c468:e033:fa2b:3a6])
        by smtp.gmail.com with ESMTPSA id n18sm41064384wrt.89.2021.07.26.06.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 06:56:13 -0700 (PDT)
Date:   Mon, 26 Jul 2021 14:56:10 +0100
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        qais.yousef@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 2/2] sched: Skip priority checks with
 SCHED_FLAG_KEEP_PARAMS
Message-ID: <YP6++lClPCQvTLcK@google.com>
References: <20210719161656.3833943-1-qperret@google.com>
 <20210719161656.3833943-3-qperret@google.com>
 <ad30be79-8fb2-023d-9936-01f7173164e4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad30be79-8fb2-023d-9936-01f7173164e4@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 Jul 2021 at 10:47:33 (+0200), Dietmar Eggemann wrote:
> (*) This changes the behaviour when setting uclamp values on a DL task.
> 
> Before uclamp values could be set but now, because of
> 
>   void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
>     ..
>     attr->sched_flags = dl_se->flags
> 
> SCHED_FLAG_UTIL_CLAMP gets overwritten and  __sched_setscheduler() bails in:
> 
>     if (unlikely(policy == p->policy)) {
>       ...
>       retval = 0;
>       goto unlock;
>     }
>   change:
> 
> I.e. the:
> 
>       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
>         goto change;
> 
> can't trigger anymore.

Bah, as you said it doesn't seem to be a big deal, but clearly that was
unintentional. Let me try and fix this.

> > +	else if (task_has_rt_policy(p))
> > +		attr->sched_priority = p->rt_priority;
> > +	else
> > +		attr->sched_nice = task_nice(p);
> > +}
> > +
> >  /**
> >   * sys_sched_setscheduler - set/change the scheduler policy and RT priority
> >   * @pid: the pid in question.
> > @@ -7393,6 +7403,8 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
> >  	rcu_read_unlock();
> >  
> >  	if (likely(p)) {
> > +		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
> > +			get_params(p, &attr);
> 
> SCHED_FLAG_KEEP_PARAMS is handled here but SCHED_FLAG_KEEP_POLICY
> outside (before) the `if (likely(p))`?

Because I need to dereference p while SCHED_FLAG_KEEP_POLICY doesn't :)

> >  		retval = sched_setattr(p, &attr);
> >  		put_task_struct(p);
> >  	}
> 
> [...]

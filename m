Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89994201F1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 16:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhJCOQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 10:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhJCOQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 10:16:53 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF2EC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 07:15:06 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h20so15581281ilj.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zzavvES2yPz9stLpAwaWMrrnzDSrvvF07onXnbPpyU=;
        b=Ullh3THFiz5cLTM9pb415qVAQu+ocxz46ZtxlYhgJz31gahkF0cF17OLtt30h3q/xk
         3mHFzQ8AuoYO3Ut44/lsxxVQZJYKYbhUukbBGRc7tiNlEAnQpo2zJowPaoYtS3+IwKVo
         nV78hDuiIXlZg0LekCi8XDfLuk/zfvwVbeSDEN8x0WxMMxMT+OdkMhiewN+l2jDCNrER
         /Guge7Hck7KxVyPs8N3GVVx0RLkjg1J1P+ifa7rJjLtJcHYGJkyg06z782j1LchfXECl
         woYhsiqgg14EmnOz7XiAsAJ5TdB5wHX7ulLjrs0eGmgmu8axm/v3kvlaXliMNv6gPCmG
         j5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zzavvES2yPz9stLpAwaWMrrnzDSrvvF07onXnbPpyU=;
        b=vtfdrVHr/hvV8ZTka9WPwHuc7gjxOxSBfQJ7JuHOFM7T3P652zoR+2M5pblsPvqD3b
         RxOairlxtNn44eQ2H0oddJYSELhetxV5lj2c+HgADUGoqsgblKKmxd7rn/Or04jvg3O9
         26WIb9/88c+k8Xy//nDQAcO2gp7/I5P1hGo4Qbkg5kmMhupUsyABTZMQ+yX/BfusuRyO
         KlzWNN2egArDRSs6R6BvHQPgsDlbB7RUyZOmR5SqvvrQ2DrKj3pHihiYSYwu2JTPQQw2
         BSiKAAbN81c52HsLi5Iza3ti8/E1iIdM34SqJZW4EbACbAxutf4b4W+1ACKtJN17WyKn
         EJrw==
X-Gm-Message-State: AOAM530NLTRsmpnd1JO/eL5pKXbA/ZgoqbNlg67NoaKGuXlDKX+Cdo4s
        zeloXnulRyZ+gGB+YWrP2xKEhm4RbLJZ9SMMShk=
X-Google-Smtp-Source: ABdhPJy+kbRkevhCPkZKU93NoNlXrg8xdSQSRKTLmXdIUtMPb/24wEH/W8tUo94M/hVA1CTFYqZCosSb/hByS3sP3IA=
X-Received: by 2002:a92:ca4f:: with SMTP id q15mr6337938ilo.131.1633270505868;
 Sun, 03 Oct 2021 07:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210929115036.4851-1-laoar.shao@gmail.com> <20210929115036.4851-2-laoar.shao@gmail.com>
 <YVkkG+KOV6GQBAUf@zeniv-ca.linux.org.uk>
In-Reply-To: <YVkkG+KOV6GQBAUf@zeniv-ca.linux.org.uk>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 3 Oct 2021 22:14:29 +0800
Message-ID: <CALOAHbB6Ko0szbA0znsxcyfMFdScVUqOA1_dokzJRAvQ41n5zg@mail.gmail.com>
Subject: Re: [PATCH 1/5] kernel: replace sizeof(task->comm) with TASK_COMM_LEN
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 11:31 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Sep 29, 2021 at 11:50:32AM +0000, Yafang Shao wrote:
>
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -2265,7 +2265,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> >               unsigned long, arg4, unsigned long, arg5)
> >  {
> >       struct task_struct *me = current;
> > -     unsigned char comm[sizeof(me->comm)];
> > +     unsigned char comm[TASK_COMM_LEN];
> >       long error;
> >
> >       error = security_task_prctl(option, arg2, arg3, arg4, arg5);
>
> Slightly below you have this:
>         case PR_SET_NAME:
>                 comm[sizeof(me->comm) - 1] = 0;
>                 if (strncpy_from_user(comm, (char __user *)arg2,
>                                       sizeof(me->comm) - 1) < 0)
>                         return -EFAULT;
>                 set_task_comm(me, comm);
>                 proc_comm_connector(me);
>                 break;
>
> How had that been tested?

Thanks for pointing out this. Honestly speaking I didn't test  PR_SET_NAME.
It is strange that I missed these two me->comm.
I have grepped all "->comm"  in the kernel and checked one by one, so
these two should be found...

-- 
Thanks
Yafang

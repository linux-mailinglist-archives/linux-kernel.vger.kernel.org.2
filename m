Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AC141DA4F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351174AbhI3M4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351127AbhI3M43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:56:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DAAC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:54:47 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q205so7356273iod.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fH13Xgrw2lKv2ATD+0Vi8DFH5bvKRlk6OCHTv30PLdo=;
        b=IoCT97nkjFhhN0OOhlCi5bM3V2hzYAoVVrQIBAHU+s/X8Om9nSY2RbrjeRmS6/eSe/
         89Tg0r0/CuS9x0V++RvU8ZPcYvs13fYcZAJTe0lkD2SHsmLt2Ytvytom2B18NNR9Fy0z
         hltXcoWYagJvzTbYnLLQmAy8fydopJW1EGyFoiUhr9AdB8/+7TXRZ9fj5q59+TMLzG2P
         b8FooZA+WvG/6VOpiQXMscx1ZJGwhZ98HLNVLLYKRCyZDCESlBnzNd9ZPQx/eAi7wvxA
         gKpXZvwYZut7CWOHKwzmI4Jho22HsFe58eaJEjmAjAQ6/+/M7F4q/TzBRhWxduGpAshF
         ipSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fH13Xgrw2lKv2ATD+0Vi8DFH5bvKRlk6OCHTv30PLdo=;
        b=zWXHj6BA2sEqY8b4fKYOD12ZCiPLttpdVjFPb9TLHi3hYIlM8U7aKvowJOZh1GG4XE
         HyRYdZBx+2TakV6itlnJp2kH27nN5ik+Z+zV9qIZXTMndeVa57z/FbnbPN7KjsGWzp7/
         7eDu0fiuwfw7eVzJNvbGtZVj0MRrp/bmvtRjP+o9IibZCslgEBQ0/2xO1BkECW+oNECg
         oGO8etlPfL50a3A026MZumx29usUA6dHq/hyGI3N2841T7zhiWPwzIMGmymVBHtHwuHJ
         cjqPIIQI0IVZpADycquP39NYvnXo+qOXYplowJkCZ5blKSvM0toknPMJ/T1Q2COUSkGp
         mXGQ==
X-Gm-Message-State: AOAM533X7CU/4t06Yx8Hng2U2y8ocvnAg0Xb8ccCBGksOrSo+1s+UgcA
        Mmm4xwpJvXgoshdY3hPPiflX4kbZ6Y9nGbG6T2I=
X-Google-Smtp-Source: ABdhPJyfgOPxTOyNIpjzalpQcNvMLKIfHdZhacjmG4CqwowmB8Xbd6yxc7iTtzE1oeGLnjEgFZ5VEmwq9eS/KCpfDEc=
X-Received: by 2002:a05:6602:240d:: with SMTP id s13mr3756457ioa.94.1633006486680;
 Thu, 30 Sep 2021 05:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210929115036.4851-1-laoar.shao@gmail.com> <20210929115036.4851-6-laoar.shao@gmail.com>
 <202109291120.C37E6C9E6@keescook>
In-Reply-To: <202109291120.C37E6C9E6@keescook>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 30 Sep 2021 20:54:10 +0800
Message-ID: <CALOAHbAki4sRrSZ6RY6Kp+nYSJ8-Ximray+wLP+e3N4GvUDWnw@mail.gmail.com>
Subject: Re: [PATCH 5/5] kernel/kthread: show a warning if kthread's comm is
 still trucated
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        Al Viro <viro@zeniv.linux.org.uk>, christian@brauner.io,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 2:20 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 29, 2021 at 11:50:36AM +0000, Yafang Shao wrote:
> > Show a warning if the ktrhead's comm is still trucated. Below is the
> > result of my test case -
> >
> > __kthread_create_on_node:410: comm of pid 14 is truncated from "I-am-a-kthread-with-long-name" to "I-am-a-kthread-with-lon"
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> I like this check as a reasonable way to make kthread authors aware of
> the TASK_COMM_LEN limitation.
>

Thanks for the review.

> > ---
> >  kernel/kthread.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 6def951c605a..aa093f1f423a 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -404,7 +404,11 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
> >                * task is already visible to other tasks, so updating
> >                * COMM must be protected.
> >                */
> > -             vsnprintf(name, sizeof(name), namefmt, args);
> > +             if (vsnprintf(name, KTHREAD_COMM_LEN, namefmt, args) >=
> > +                 KTHREAD_COMM_LEN)
> > +                     pr_warn("%s:%d: comm of pid %d is truncated from \"%s\" to \"%s\"\n",
> > +                             __func__, __LINE__, task->pid, namefmt, name);
> > +
> >               set_task_comm(task, name);
> >               /*
> >                * root may have changed our (kthreadd's) priority or CPU mask.
> > --
> > 2.17.1
> >
>
> --
> Kees Cook



-- 
Thanks
Yafang

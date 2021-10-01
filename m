Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA741ECC5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354215AbhJAMCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhJAMCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:02:16 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06040C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 05:00:32 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r75so11300672iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 05:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8XkSaJHdb8NkUGJQ7GfACLIJY8P2VgxyTTtaVxl+CI=;
        b=W9rMTIBowgmopFjQNGZCGX5uCOXrBstudVcFkadj8QkSIqZoMRO9D6JNts7TRo2WH1
         YScg0myMY+w2++hrC91xtTUWD0+hpEkQbHMUB6RzduBdoHrBXsswN+ZaMSlMbHLEQ4hE
         cF5591sFCRYt1RcwF+U7AWyB6sTea5INSZWkoXEDqCdzHfPVIbwxGFI1I1Nc39nrkr3c
         OKMco5sOVcI3FXlAm4K12Y+QAO9GJCvPytZWKf5kcIRmyeNnq7ScqHo7Zq6vJ8SlsPu1
         nvSpzWb5qaKfk/YLm5G6pXJrf9+QIiZECQc9XYTuDI1IqSvCa4gXo4SWMemiWI1AOGHB
         UkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8XkSaJHdb8NkUGJQ7GfACLIJY8P2VgxyTTtaVxl+CI=;
        b=BWpyOk2XG/kD6up/Q6T1MPoYPJizjH6ZqHw5LqV316XkYxk67UdQb4FQOsWwhxJW+9
         ohg92MEWJAn1Dd8pLAdAjkbuwEnL1/i6a7JVeon8tH1QEuuAcvsqP0MNfJWl/G81Ww0Q
         1jQwV5/OC676AhcCm7qNPHIz5Tkde1vsMjZ9sjAYrLb+XDgNEEMCyezQulOFHH90ri5Y
         1YFHml/5EKx/1vgMuZ44IPptBAFpJ4PxI13nPtH5mURh/8pj//xeftu+pKXtFuhOv97C
         JOUw1F0cqRV1JM/APyp5kCm5XXdnFoVfFheSrrIVxmNLU16qJDK8D/t+DjyshdxbfUiV
         QRZQ==
X-Gm-Message-State: AOAM530HLrL+Scn3Ma7cBNDqmdb4SMdYQyfGaMuNfuG23CDQkDHBFIlu
        aylqpwqjVUT5HbIrWqyNiszPI5smW9BN6+GEopM=
X-Google-Smtp-Source: ABdhPJwr5bZxQ4VzOlGDrvJF6ibM0n8GK+uqPgfHwxwzsGbyO9e5d3Anit2uoO4wvX4rR3SnZluA2nrsI1f/TIC01ZQ=
X-Received: by 2002:a6b:b714:: with SMTP id h20mr8000055iof.9.1633089631442;
 Fri, 01 Oct 2021 05:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210929115036.4851-1-laoar.shao@gmail.com> <20210929115036.4851-6-laoar.shao@gmail.com>
 <YVXVBXSZ1m4ScvbX@alley>
In-Reply-To: <YVXVBXSZ1m4ScvbX@alley>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 1 Oct 2021 19:59:54 +0800
Message-ID: <CALOAHbCQk0ksUmsL3ygaGJR9vfT8PsZDWGfBW8G8LYmZQhYcCA@mail.gmail.com>
Subject: Re: [PATCH 5/5] kernel/kthread: show a warning if kthread's comm is
 still trucated
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        Al Viro <viro@zeniv.linux.org.uk>, christian@brauner.io,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:17 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2021-09-29 11:50:36, Yafang Shao wrote:
> > Show a warning if the ktrhead's comm is still trucated. Below is the
> > result of my test case -
> >
> > __kthread_create_on_node:410: comm of pid 14 is truncated from "I-am-a-kthread-with-long-name" to "I-am-a-kthread-with-lon"
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
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
>
> The warning makes sense. But the use of "namefmt" looks wrong. It is
> format and not the name. Also __func__ and __LINE__ is overkill. It will
> be always the same.
>
> I would do something like:
>
>                 len = vsnprintf(name, sizeof(name), namefmt, args);
>                 if (len >= KTHREAD_COMM_LEN) {
>                         pr_warn("truncated kthread comm:%s, pid:%d by %d characters\n",
>                                 name, task->pid, len - KTHREAD_COMM_LEN + 1);
>                 }
>

Thanks for the suggestion. I will change it.

-- 
Thanks
Yafang

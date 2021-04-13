Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E541B35E51A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347239AbhDMRfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:35:23 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:42624 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347213AbhDMRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:35:22 -0400
Received: by mail-yb1-f171.google.com with SMTP id c195so19008280ybf.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PtG5VoeaLOX1ZANv6L1Q3kXBlb+Ic1K3aPZyyu1giOs=;
        b=lNdb+9h9wBRhXgvsq+m+1fdSVdCo/cY+DCTsMg3D/TsqtfvktRA/Cw2sPsl9cPuN4b
         FMi3217Z5gSLs4YJNxzrMxHC2sJPjheUKNx3ylhJETzE9qCiC+G72K9eUmjukGFk2kdU
         nf9gRUoE1QEkkofYBFAHAqFG/FpYj7pZn0Drv8RDvQIZz6qOdWr2biKB+rqPXcG+q78w
         S//ENdBk8+r14MzToC0x4wk7UtE7ia91nJwUJvRES8OV+oBKuopd4a5PcaTTzDCd0bYX
         QwYcN8TAkvvOj6c+iPF/Gb+8n4X8xxCuTi0FcLf9saesua+1YhUR2cec9e9uFLGSCAPI
         kujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PtG5VoeaLOX1ZANv6L1Q3kXBlb+Ic1K3aPZyyu1giOs=;
        b=E4xZpZBr4QQJOsxiW+R3BStsLG/3yap6MpVeCSHHdKsALCDw7J/kAWUt+Vgmr34qj4
         i5ExvIcki4T4um/dzNsvali6PM3LrYpAjdh+NLQ5ewD0zfJJWgyucKMo4/CTr/Xa5KTt
         OKWcM8/QvdS+en8Bz5EKLgimx8zhn5E7mRDMoBhbhDn0HRTR3gLj9AWNzPBw2oxTysoI
         8oPEQOKwU13qnUR+NkRVhhXlQV6g+eS/EHL2FuD7NAVaghLmRt3nnKKJtw3lSxcZvM/v
         Eo3DpmzHc/6SgnFZSa6isFxbeyoAhoI6FIPjJfBGnZ0um/Wae9qbNAEWbqgkbmKkecoI
         DB+g==
X-Gm-Message-State: AOAM5329AOXnKniMQQlAVLUpJAXEcM6BOu/QbNclujkFUFLf+4rBhFFL
        0EPMXK/geTZH1YoB4tWctG+sVVsCAKfpykI5LpFODg==
X-Google-Smtp-Source: ABdhPJzXV+rPIBDdBWiNRw+RZhWY2jegBLwxRq5qLWY9Rm/x71E73Tqiw1Vq5trTIu9gausYeFHC7ecDbz9080Kytpg=
X-Received: by 2002:a25:4244:: with SMTP id p65mr17917166yba.452.1618335241752;
 Tue, 13 Apr 2021 10:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
 <20210413162240.3131033-4-eric.dumazet@gmail.com> <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
 <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
 <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com>
 <CANn89iKnQ7KeCo0os0c67GMgEkmrRqhmGhug-xL-Mx5BhR+BkQ@mail.gmail.com> <989543379.72506.1618334454075.JavaMail.zimbra@efficios.com>
In-Reply-To: <989543379.72506.1618334454075.JavaMail.zimbra@efficios.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 13 Apr 2021 19:33:50 +0200
Message-ID: <CANn89iLXE6V2gpbJeE6KVU+YiNkmYZKjpRxKv8b69k1ECsyE9g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 7:20 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Apr 13, 2021, at 1:07 PM, Eric Dumazet edumazet@google.com wrote:
>
> > On Tue, Apr 13, 2021 at 7:01 PM Eric Dumazet <edumazet@google.com> wrote:
> >>
> >> On Tue, Apr 13, 2021 at 6:57 PM Eric Dumazet <edumazet@google.com> wrote:
> >> >
> >> > On Tue, Apr 13, 2021 at 6:54 PM Mathieu Desnoyers
> >> > <mathieu.desnoyers@efficios.com> wrote:
> >> > >
> >> > > ----- On Apr 13, 2021, at 12:22 PM, Eric Dumazet eric.dumazet@gmail.com wrote:
> >> > >
> >> > > > From: Eric Dumazet <edumazet@google.com>
> >> > > >
> >> > > > Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
> >> > > > update includes") added regressions for our servers.
> >> > > >
> >> > > > Using copy_from_user() and clear_user() for 64bit values
> >> > > > is suboptimal.
> >> > > >
> >> > > > We can use faster put_user() and get_user().
> >> > > >
> >> > > > 32bit arches can be changed to use the ptr32 field,
> >> > > > since the padding field must always be zero.
> >> > > >
> >> > > > v2: added ideas from Peter and Mathieu about making this
> >> > > >    generic, since my initial patch was only dealing with
> >> > > >    64bit arches.
> >> > >
> >> > > Ah, now I remember the reason why reading and clearing the entire 64-bit
> >> > > is important: it's because we don't want to allow user-space processes to
> >> > > use this change in behavior to figure out whether they are running on a
> >> > > 32-bit or in a 32-bit compat mode on a 64-bit kernel.
> >> > >
> >> > > So although I'm fine with making 64-bit kernels faster, we'll want to keep
> >> > > updating the entire 64-bit ptr field on 32-bit kernels as well.
> >> > >
> >> > > Thanks,
> >> > >
> >> >
> >> > So... back to V1 then ?
> >>
> >> Or add more stuff as in :
> >
> > diff against v2, WDYT ?
>
> I like this approach slightly better, because it moves the preprocessor ifdefs into
> rseq_get_rseq_cs and clear_rseq_cs, while keeping the same behavior for a 32-bit
> process running on native 32-bit kernel and as compat task on a 64-bit kernel.
>
> That being said, I don't expect anyone to care much about performance of 32-bit
> kernels, so we could use copy_from_user() on 32-bit kernels to remove special-cases
> in 32-bit specific code. This would eliminate the 32-bit specific "padding" read, and
> let the TASK_SIZE comparison handle the check for both 32-bit and 64-bit kernels.
>
> As for clear_user(), I wonder whether we could simply keep using it, but change the
> clear_user() macro to figure out that it can use a faster 8-byte put_user ? I find it
> odd that performance optimizations which would be relevant elsewhere creep into the
> rseq code.


clear_user() is a maze of arch-dependent macros/functions/assembly

I guess the same could be said from  copy_in_user(), but apparently we removed
special-casing, like in commit a41e0d754240fe8ca9c4f2070bf67e3b0228aa22

Definitely it seems odd having to carefully choose between multiple methods.


>
> Thanks,
>
> Mathieu
>
> >
> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > index
> > f2eee3f7f5d330688c81cb2e57d47ca6b843873e..537b1f684efa11069990018ffa3642c209993011
> > 100644
> > --- a/kernel/rseq.c
> > +++ b/kernel/rseq.c
> > @@ -136,6 +136,10 @@ static int rseq_get_cs_ptr(struct rseq_cs __user **uptrp,
> > {
> >        u32 ptr;
> >
> > +       if (get_user(ptr, &rseq->rseq_cs.ptr.padding))
> > +               return -EFAULT;
> > +       if (ptr)
> > +               return -EINVAL;
> >        if (get_user(ptr, &rseq->rseq_cs.ptr.ptr32))
> >                return -EFAULT;
> >        *uptrp = (struct rseq_cs __user *)ptr;
> > @@ -150,8 +154,9 @@ static int rseq_get_rseq_cs(struct task_struct *t,
> > struct rseq_cs *rseq_cs)
> >        u32 sig;
> >        int ret;
> >
> > -       if (rseq_get_cs_ptr(&urseq_cs, t->rseq))
> > -               return -EFAULT;
> > +       ret = rseq_get_cs_ptr(&urseq_cs, t->rseq);
> > +       if (ret)
> > +               return ret;
> >        if (!urseq_cs) {
> >                memset(rseq_cs, 0, sizeof(*rseq_cs));
> >                return 0;
> > @@ -237,7 +242,8 @@ static int clear_rseq_cs(struct task_struct *t)
> > #ifdef CONFIG_64BIT
> >        return put_user(0UL, &t->rseq->rseq_cs.ptr64);
> > #else
> > -       return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32);
> > +       return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32) |
> > +              put_user(0UL, &t->rseq->rseq_cs.ptr.padding);
> > #endif
> >  }
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

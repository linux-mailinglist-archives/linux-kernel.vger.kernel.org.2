Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833BE35E688
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347946AbhDMSgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346394AbhDMSgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:36:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D626EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:35:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a85so11556156pfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIWT5pGdCZbXcHyqIZFDN+I3SuhZD5QOY8bAlyFltU0=;
        b=WyznYGzTMDGBFv9P3hJnuDb/HLUFrd5pJP/2eM1U/lyuzgAVORJ0g7ZYSSr8qE7isW
         B/EI1UgOzqKhuUTBuoE2w3pUagJupb9yjcbz/cG+BxLL7lZQ67xAOHVFeRqqhzw8MrkK
         i8jEl8nMISTq6TfQ0IikbQLKFHQnK/W4QEgK5szOzyDBTn82IxL2iaJedL/Os20+4M2e
         dkcIhZ7JiK8MM+bf5Zr+Bjm6rMIJjwTtt5he97jP4Ju3sFNVfgbRNVwxApogET8zVDfN
         iTcdJRmJ/Tg9kOyr4mK7XP6yFLp0VX9DttqegSJ/m7/HZI/9gNGMoKBG4NjTmy44GA9M
         02mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIWT5pGdCZbXcHyqIZFDN+I3SuhZD5QOY8bAlyFltU0=;
        b=OhwGMrcFBq2wam2eM8XB55ncsogsOGQrLI5itMPKiz6I7FfnkeRmzjuNU5qV2C/iZ8
         sPjU5fWD3DZYkAmJWBVkrX+eRVQ83RjMiuEbcArdp9NOwuWus1UBZOOca4e9is/xVvUm
         eaulmq8lKaPwQK1Ch/j+wxI7V0Soc98BEtlyGf4GEUFXh2PDVgVIhM+RtBRnOycHWv5G
         HrzI/lNM7CQOOIxr9pIlcRIgWa832T8DADGyHEXp6UE9QS7iUCGgQY6/bwXEjGafZO3h
         oIjfj3Bn1FVVEohkkphO4Ss1riZ1UNfEwgAx5PPfmNflmGHKMr2zCN26caK2rDCKDbRW
         +WeQ==
X-Gm-Message-State: AOAM533w6xq0s0B7hOKaOqw9GsIo93hibPn5kOLdymLFAmn8x8bmcnKY
        +z7wkG3wQamI905/5lUNbZ2i4WmhJgqJycqgewrBkQ==
X-Google-Smtp-Source: ABdhPJwiXCQGkYgOoQgKEibG7pIjO63sWMtY7Iqnt5GYFUE/lIjeo9jcpNg3B6hVlvuE1ULH8NzZG8+SAobZI0+TQdM=
X-Received: by 2002:a63:703:: with SMTP id 3mr33948225pgh.253.1618338948211;
 Tue, 13 Apr 2021 11:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
 <20210413162240.3131033-4-eric.dumazet@gmail.com> <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
 <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
 <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com>
 <CANn89iKnQ7KeCo0os0c67GMgEkmrRqhmGhug-xL-Mx5BhR+BkQ@mail.gmail.com>
 <989543379.72506.1618334454075.JavaMail.zimbra@efficios.com>
 <CANn89iLXE6V2gpbJeE6KVU+YiNkmYZKjpRxKv8b69k1ECsyE9g@mail.gmail.com>
 <1347243835.72576.1618336812739.JavaMail.zimbra@efficios.com> <CANn89iKhKrHgTduwUtZ6QhxE6xFcK=ijadwACg9aSEJ7QQx4Mg@mail.gmail.com>
In-Reply-To: <CANn89iKhKrHgTduwUtZ6QhxE6xFcK=ijadwACg9aSEJ7QQx4Mg@mail.gmail.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Tue, 13 Apr 2021 11:35:37 -0700
Message-ID: <CAOFY-A1=2MzHvmqBEo=WBT6gWc=KnmtCWogjLdwZVDTp-zDjBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
To:     Eric Dumazet <edumazet@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:22 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Apr 13, 2021 at 8:00 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
>
> > As long as the ifdefs are localized within clearly identified wrappers in the
> > rseq code I don't mind doing the special-casing there.
> >
> > The point which remains is that I don't think we want to optimize for speed
> > on 32-bit architectures when it adds special-casing and complexity to the 32-bit
> > build. I suspect there is less and less testing performed on 32-bit architectures
> > nowadays, and it's good that as much code as possible is shared between 32-bit and
> > 64-bit builds to share the test coverage.
> >
>
> Quite frankly V1 was fine, I can't really make it looking better.
>
> > Thanks,
> >
> > Mathieu
> >
> > >
> > >
> > >>
> > >> Thanks,
> > >>
> > >> Mathieu
> > >>

If we're special-casing 64-bit architectures anyways - unrolling the
32B copy_from_user() for struct rseq_cs appears to be roughly 5-10%
savings on x86-64 when I measured it (well, in a microbenchmark, not
in rseq_get_rseq_cs() directly). Perhaps that could be an additional
avenue for improvement here.

-Arjun

> > >> >
> > >> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > >> > index
> > >> > f2eee3f7f5d330688c81cb2e57d47ca6b843873e..537b1f684efa11069990018ffa3642c209993011
> > >> > 100644
> > >> > --- a/kernel/rseq.c
> > >> > +++ b/kernel/rseq.c
> > >> > @@ -136,6 +136,10 @@ static int rseq_get_cs_ptr(struct rseq_cs __user **uptrp,
> > >> > {
> > >> >        u32 ptr;
> > >> >
> > >> > +       if (get_user(ptr, &rseq->rseq_cs.ptr.padding))
> > >> > +               return -EFAULT;
> > >> > +       if (ptr)
> > >> > +               return -EINVAL;
> > >> >        if (get_user(ptr, &rseq->rseq_cs.ptr.ptr32))
> > >> >                return -EFAULT;
> > >> >        *uptrp = (struct rseq_cs __user *)ptr;
> > >> > @@ -150,8 +154,9 @@ static int rseq_get_rseq_cs(struct task_struct *t,
> > >> > struct rseq_cs *rseq_cs)
> > >> >        u32 sig;
> > >> >        int ret;
> > >> >
> > >> > -       if (rseq_get_cs_ptr(&urseq_cs, t->rseq))
> > >> > -               return -EFAULT;
> > >> > +       ret = rseq_get_cs_ptr(&urseq_cs, t->rseq);
> > >> > +       if (ret)
> > >> > +               return ret;
> > >> >        if (!urseq_cs) {
> > >> >                memset(rseq_cs, 0, sizeof(*rseq_cs));
> > >> >                return 0;
> > >> > @@ -237,7 +242,8 @@ static int clear_rseq_cs(struct task_struct *t)
> > >> > #ifdef CONFIG_64BIT
> > >> >        return put_user(0UL, &t->rseq->rseq_cs.ptr64);
> > >> > #else
> > >> > -       return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32);
> > >> > +       return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32) |
> > >> > +              put_user(0UL, &t->rseq->rseq_cs.ptr.padding);
> > >> > #endif
> > >> >  }
> > >>
> > >> --
> > >> Mathieu Desnoyers
> > >> EfficiOS Inc.
> > > > http://www.efficios.com
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com

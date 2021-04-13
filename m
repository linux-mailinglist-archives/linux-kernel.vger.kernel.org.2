Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CF035E635
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347615AbhDMSWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbhDMSWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:22:40 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855B2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:22:20 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id l14so12929650ybf.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERFw0utuuehNFClqfoBAzxZARE8u8aLh9Pi0EYsnt8I=;
        b=a1Z5h/6rJ1YxfVLfRrF8+HebhBVApzVEnK0UOMqH/KlNnocPXK9w0Rv3VWjm6dzhG7
         sZExpXKXyyOmPKB/U5ULNYzOpdRtU6/TgwGtIWz9okiTtC7Ju2VxurW0jpFJQE+e+7pY
         iP0zsX4dCViLMZZxDNvd9bjrWVne6kTl5tQjV9ku8tXHrz4+Q2InDkj7JidB/gVOIu53
         5MMNdg1P1oLHkiy8fBO1IBserBSpJKC0f0h0oqjk4ghJD+mztq4uLg3b72N5mvoLDY2/
         e/qhbR589jg2Zsslwtr/YgMREFe6IFzkv8Pt6/y74FEXB2J7ORTHC6VWHeTGm/rWTvkL
         bEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERFw0utuuehNFClqfoBAzxZARE8u8aLh9Pi0EYsnt8I=;
        b=NlUMqVQvGXm0Gk/34ZiBkUjC5W4talKk32ZIEHHtBT7RaeGbUadR4PnIjWnkGfZe81
         uNcXhjWGkCuTKOcE0vTPTbOVZ0dPmddDuLsx2ZE1gib1qzLsLbZqa15KnENM5tM+lhAi
         V/dStjfeuhg46Ct1xHSO8wU4l3XzCC51BAriljeyr8ficaRgvXo/VbzuPQj8TgnPUuHP
         Wd8O0G56yFynEK/CWaFX31BggLbwj5/IZciciRpJ7wnxKak0z9dFfkVnNUrTj44hvC+C
         IPAONnhZGL40ZL5lFhNzJB3CzvfhvXxPGiDSFoUThkDLVlcwcGqL1dYcFC5qvZuqXtXe
         Bysg==
X-Gm-Message-State: AOAM532r+lYVsxLFuU62xgWUIhIFCty+chLqJ7Se4170GQhidDNli5cA
        K3GBD/Y2mrPRbgJ552FI148k2G5Dku56r0XQJRDSIQ==
X-Google-Smtp-Source: ABdhPJwDBVtxIjsY5ZjljxtyWe2q1/1E7G+/XTkrozTo3vXOlinDCQBsIMP9r5axsWNxgac2KW1wKZzi40z0JEpduBk=
X-Received: by 2002:a25:4244:: with SMTP id p65mr18202220yba.452.1618338139467;
 Tue, 13 Apr 2021 11:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
 <20210413162240.3131033-4-eric.dumazet@gmail.com> <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
 <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
 <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com>
 <CANn89iKnQ7KeCo0os0c67GMgEkmrRqhmGhug-xL-Mx5BhR+BkQ@mail.gmail.com>
 <989543379.72506.1618334454075.JavaMail.zimbra@efficios.com>
 <CANn89iLXE6V2gpbJeE6KVU+YiNkmYZKjpRxKv8b69k1ECsyE9g@mail.gmail.com> <1347243835.72576.1618336812739.JavaMail.zimbra@efficios.com>
In-Reply-To: <1347243835.72576.1618336812739.JavaMail.zimbra@efficios.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 13 Apr 2021 20:22:08 +0200
Message-ID: <CANn89iKhKrHgTduwUtZ6QhxE6xFcK=ijadwACg9aSEJ7QQx4Mg@mail.gmail.com>
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

On Tue, Apr 13, 2021 at 8:00 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>

> As long as the ifdefs are localized within clearly identified wrappers in the
> rseq code I don't mind doing the special-casing there.
>
> The point which remains is that I don't think we want to optimize for speed
> on 32-bit architectures when it adds special-casing and complexity to the 32-bit
> build. I suspect there is less and less testing performed on 32-bit architectures
> nowadays, and it's good that as much code as possible is shared between 32-bit and
> 64-bit builds to share the test coverage.
>

Quite frankly V1 was fine, I can't really make it looking better.

> Thanks,
>
> Mathieu
>
> >
> >
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >> >
> >> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> >> > index
> >> > f2eee3f7f5d330688c81cb2e57d47ca6b843873e..537b1f684efa11069990018ffa3642c209993011
> >> > 100644
> >> > --- a/kernel/rseq.c
> >> > +++ b/kernel/rseq.c
> >> > @@ -136,6 +136,10 @@ static int rseq_get_cs_ptr(struct rseq_cs __user **uptrp,
> >> > {
> >> >        u32 ptr;
> >> >
> >> > +       if (get_user(ptr, &rseq->rseq_cs.ptr.padding))
> >> > +               return -EFAULT;
> >> > +       if (ptr)
> >> > +               return -EINVAL;
> >> >        if (get_user(ptr, &rseq->rseq_cs.ptr.ptr32))
> >> >                return -EFAULT;
> >> >        *uptrp = (struct rseq_cs __user *)ptr;
> >> > @@ -150,8 +154,9 @@ static int rseq_get_rseq_cs(struct task_struct *t,
> >> > struct rseq_cs *rseq_cs)
> >> >        u32 sig;
> >> >        int ret;
> >> >
> >> > -       if (rseq_get_cs_ptr(&urseq_cs, t->rseq))
> >> > -               return -EFAULT;
> >> > +       ret = rseq_get_cs_ptr(&urseq_cs, t->rseq);
> >> > +       if (ret)
> >> > +               return ret;
> >> >        if (!urseq_cs) {
> >> >                memset(rseq_cs, 0, sizeof(*rseq_cs));
> >> >                return 0;
> >> > @@ -237,7 +242,8 @@ static int clear_rseq_cs(struct task_struct *t)
> >> > #ifdef CONFIG_64BIT
> >> >        return put_user(0UL, &t->rseq->rseq_cs.ptr64);
> >> > #else
> >> > -       return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32);
> >> > +       return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32) |
> >> > +              put_user(0UL, &t->rseq->rseq_cs.ptr.padding);
> >> > #endif
> >> >  }
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> > > http://www.efficios.com
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

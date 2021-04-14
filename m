Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA1435F99F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348526AbhDNRPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbhDNRPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:15:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5610FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:15:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q14-20020a17090a430eb02901503aaee02bso123560pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CzQ5mUD4wfNdi0P00ZxPERafYFyidD1VSYPt3GhsJFE=;
        b=vS30pULZ0aW9HQrz30/psCHrhq6d4pv+guhxV1KgmozRQ2b5Uy9kUJkgfxYBef6+JR
         xepA8HKCdrBVd2FHcD8hmZYgmDOJR/VCAJShnPuHObfowzZO5M9ZxiU0lgjC2i5c+xAu
         RnDmrwmuaZpaq/i92Zrrq7bZHQsFMv1PgYjF8PJvFJNVPrcwAe/Z3UxX0SgW0kdxdY5h
         FqPOtbolLRilnuNwZJ2HCAPU89Z29uY73cULXygu08wqRT9FVxaI4KR4GkYyM588vNsq
         dsUEpl4BCOFwSayDE2HylBdHvA03fQ4tU4v2HfZOkiv96RbEUSS9g1DWJNbF3f29PaDk
         s8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzQ5mUD4wfNdi0P00ZxPERafYFyidD1VSYPt3GhsJFE=;
        b=eolgKZSkAo0Vu8ffSOpGs5NB4/1l7igtDFFVHPv9s41UWJN9djT/JBQPi8EoKMPu63
         HRi2piqF4baaBw6clifELGj/UPI59h+9P5M7ookOVqM6KlfQU1yq9QzpdqsQ7Y+HULl6
         w/66cs0zkPmgIA1jOZugzt0b/aDvqwNBIzBU4MVhA6hSXtZj474MGhHxRd9UCP1Sfo1T
         PbLhhxYzE1Nl2i6YoLX2XbxcuAejgaTGa03LAYP4Kz7t/FhJzno35VRd81YvppQRnclG
         wrtB0RZyE2vErhYKkr7ktmeGWJ/78EN94PMJhSKU73PcKRBHLrhMk1idEFP6h4U/RMxm
         jvaw==
X-Gm-Message-State: AOAM531Mt1r56SGdk9RBrtP8x2c/c3n2yfj38FyE4vmOizRVkUVrjDCF
        QfN4+HawRlzGrsmFCTLR3NWpXv3mpiJnP50sGEIEuQ==
X-Google-Smtp-Source: ABdhPJygku8upzUd52ITREUJqbfQqigq4LnuPTxPHKTXSxM64PVtOoBzSgBx+DZoeHaqDVoo6AXQHjY78UH9qAzdwKY=
X-Received: by 2002:a17:90a:ce8d:: with SMTP id g13mr4631071pju.85.1618420518655;
 Wed, 14 Apr 2021 10:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
 <20210413162240.3131033-4-eric.dumazet@gmail.com> <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
 <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
 <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com>
 <CANn89iKnQ7KeCo0os0c67GMgEkmrRqhmGhug-xL-Mx5BhR+BkQ@mail.gmail.com>
 <989543379.72506.1618334454075.JavaMail.zimbra@efficios.com>
 <CANn89iLXE6V2gpbJeE6KVU+YiNkmYZKjpRxKv8b69k1ECsyE9g@mail.gmail.com>
 <1347243835.72576.1618336812739.JavaMail.zimbra@efficios.com>
 <CANn89iKhKrHgTduwUtZ6QhxE6xFcK=ijadwACg9aSEJ7QQx4Mg@mail.gmail.com>
 <CAOFY-A1=2MzHvmqBEo=WBT6gWc=KnmtCWogjLdwZVDTp-zDjBQ@mail.gmail.com>
 <feed2c13dbe34279a03929a588c46c67@AcuMS.aculab.com> <CAOFY-A21tjC5dWwM0W0aXHij40kKj2JNo5Nq4X8mBZZdKwr+AA@mail.gmail.com>
 <2c6885b0241d4127b8cb7e38abbbe1e5@AcuMS.aculab.com> <CANn89iJj9254GORTsabwv6ZBPWzebR4iYAj9VYxuOZSrF99fNg@mail.gmail.com>
 <1e5576a1a5b24cb0b1d53b9bb22d528e@AcuMS.aculab.com> <CANn89iKmUJRf3FNuk6BhC06Qt-C_RuYfxPUm-1Ho0ztL0KJsLg@mail.gmail.com>
In-Reply-To: <CANn89iKmUJRf3FNuk6BhC06Qt-C_RuYfxPUm-1Ho0ztL0KJsLg@mail.gmail.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Wed, 14 Apr 2021 10:15:07 -0700
Message-ID: <CAOFY-A1Nff_99-V+W-xyhq3g4kvqXPzM3eWAQV2WpzrxPfjeFw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 9:10 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Apr 14, 2021 at 6:08 PM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Eric Dumazet
> > > Sent: 14 April 2021 17:00
> > ...
> > > > Repeated unsafe_get_user() calls are crying out for an optimisation.
> > > > You get something like:
> > > >         failed = 0;
> > > >         copy();
> > > >         if (failed) goto error;
> > > >         copy();
> > > >         if (failed) goto error;
> > > > Where 'failed' is set by the fault handler.
> > > >
> > > > This could be optimised to:
> > > >         failed = 0;
> > > >         copy();
> > > >         copy();
> > > >         if (failed) goto error;
> > > > Even if it faults on every invalid address it probably
> > > > doesn't matter - no one cares about that path.
> > >
> > >
> > > On which arch are you looking at ?
> > >
> > > On x86_64 at least, code generation is just perfect.
> > > Not even a conditional jmp, it is all handled by exceptions (if any)
> > >
> > > stac
> > > copy();
> > > copy();
> > > clac
> > >
> > >
> > > <out_of_line>
> > > efault_end: do error recovery.
> >
> > It will be x86_64.
> > I'm definitely seeing repeated tests of (IIRC) %rdx.
> >
> > It may well be because the compiler isn't very new.
> > Will be an Ubuntu build of 9.3.0.
> > Does that support 'asm goto with outputs' - which
> > may be the difference.
> >
>
> Yep, probably. I am using some recent clang version.
>

On x86-64 I can confirm, for me it (4 x unsafe_get_user()) compiles
down to stac + lfence + 8 x mov + clac as straight line code. And
results in roughly a 5%-10% speedup over copy_from_user().

-Arjun


> >         David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD835F9F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350423AbhDNRft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhDNRfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:35:48 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AC0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:35:26 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id v72so2305715ybe.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5oTNX1UW2iJQdYcROOOcZNjI/fXWbVj+c5HC1onlBc=;
        b=QpKoexFmzPklTyxAMaYaPU5L75FKBqSSi5CKQktpWyDTTpRNBuD+vCvJsbwlg46J63
         iYQLO9RxSm/QmnE2DfirQnuvk9f7suzgNZN1ElOUy6J++ctSXRVjPYxuck1hFiT8ptLB
         hEemUpoFPSDF7dfglyI+7VrBYQOc097N2wl+YgRLq2eY4yPPLyZCbu6mxEOWPFzeRcRQ
         wpUNZ046CUmLT6fnCGBlpqEhXr5QMUjoOeNJdGb3uTDQmlKNQN3T0esh4z7NMru/K2Ix
         jhXAwF+85KxbOjhhjcgU2skzxi1O6THS3upeU3RbtunJKTw7njSmU9wMLJbXm1znbiSP
         qPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5oTNX1UW2iJQdYcROOOcZNjI/fXWbVj+c5HC1onlBc=;
        b=ZznKJ2/JK0TFJhUK5RT2FigQm3IsGA1aEVCDS7Y5WNHwk4WAVkgOwtKcs6OYzKBZ3A
         gy+F0KH2ZILMQqG7c+lCNI65s47xth46Kygn0TaD5hy37HXVRcxQhvUd6EnVPdwbSVdO
         56O/94knRS2+CxwRXCDuXXyVGmcghmY/rhbv3Uxu+IIvATuLVjbsr1Co/2r4rf3dCMji
         lW8O3jN2lsuUNOoWXu5z7SNmNh9tnYT3wDvg1/4pTbGx76Y1fkb7NEQ1BtlAvgn4kbba
         5WSRLlIaD3LDiNYES9cVCu05G09JgrNNweOjXV9P965HEmhbIXI+k9bK7ZsDO3JBGpyQ
         6cjA==
X-Gm-Message-State: AOAM531XK714o2xW/aQBA6yVj7b+8Dik0Nas0ERveU1aKJ+nUPSP6P9w
        MLT08JfTyZhtmp8DkyDox1DwhHdGJU+s5BeFhR+2Tw==
X-Google-Smtp-Source: ABdhPJzr9gmGgEqSEs/nbYwpsh72AJN7ci9vJ+8aR/Zcp9/73jhjV+ceybUjuwM5GEvG+NpbPVgBCDSqKBfNvB2vk2E=
X-Received: by 2002:a25:7650:: with SMTP id r77mr27382882ybc.446.1618421725696;
 Wed, 14 Apr 2021 10:35:25 -0700 (PDT)
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
 <CAOFY-A1Nff_99-V+W-xyhq3g4kvqXPzM3eWAQV2WpzrxPfjeFw@mail.gmail.com>
In-Reply-To: <CAOFY-A1Nff_99-V+W-xyhq3g4kvqXPzM3eWAQV2WpzrxPfjeFw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 14 Apr 2021 19:35:12 +0200
Message-ID: <CANn89iK_mRog=vN4krT_86_CfWBWAz1w8c3Tr51xbdS5V45ATg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
To:     Arjun Roy <arjunroy@google.com>
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

On Wed, Apr 14, 2021 at 7:15 PM Arjun Roy <arjunroy@google.com> wrote:
>
> On Wed, Apr 14, 2021 at 9:10 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Apr 14, 2021 at 6:08 PM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: Eric Dumazet
> > > > Sent: 14 April 2021 17:00
> > > ...
> > > > > Repeated unsafe_get_user() calls are crying out for an optimisation.
> > > > > You get something like:
> > > > >         failed = 0;
> > > > >         copy();
> > > > >         if (failed) goto error;
> > > > >         copy();
> > > > >         if (failed) goto error;
> > > > > Where 'failed' is set by the fault handler.
> > > > >
> > > > > This could be optimised to:
> > > > >         failed = 0;
> > > > >         copy();
> > > > >         copy();
> > > > >         if (failed) goto error;
> > > > > Even if it faults on every invalid address it probably
> > > > > doesn't matter - no one cares about that path.
> > > >
> > > >
> > > > On which arch are you looking at ?
> > > >
> > > > On x86_64 at least, code generation is just perfect.
> > > > Not even a conditional jmp, it is all handled by exceptions (if any)
> > > >
> > > > stac
> > > > copy();
> > > > copy();
> > > > clac
> > > >
> > > >
> > > > <out_of_line>
> > > > efault_end: do error recovery.
> > >
> > > It will be x86_64.
> > > I'm definitely seeing repeated tests of (IIRC) %rdx.
> > >
> > > It may well be because the compiler isn't very new.
> > > Will be an Ubuntu build of 9.3.0.
> > > Does that support 'asm goto with outputs' - which
> > > may be the difference.
> > >
> >
> > Yep, probably. I am using some recent clang version.
> >
>
> On x86-64 I can confirm, for me it (4 x unsafe_get_user()) compiles
> down to stac + lfence + 8 x mov + clac as straight line code. And
> results in roughly a 5%-10% speedup over copy_from_user().
>

But rseq_get_rseq_cs() would still need three different copies,
with 3 stac+lfence+clac sequences.

Maybe we need to enclose all __rseq_handle_notify_resume() operations
in a single section.







> -Arjun
>
>
> > >         David
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > Registration No: 1397386 (Wales)

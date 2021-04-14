Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91B35FC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbhDNUPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbhDNUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:15:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEABC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:15:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m18so8568069plc.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMn4fRwscQ/SJvwZ2LjbT42lX4Wost4d9Na2ULpirlU=;
        b=TqH0puN1wxvV9PRIQzZzH+0TMRpojPhI54y5C12M9KuJRQVjtTXxetefGc2E0238zC
         t6QRQN57CMW9wqEdxIKdLLLFZUQRYGNaUlZMbgAcueEikTnS+nQirDXZXrSbb/8Ye/Zv
         Yr+vhKv3RUfE7PYz0A3THFwX+EDGV2hMWP+QFEYQYwlmv5l2kOcn3DAGB0xzEf75EhIH
         glhYz87YtCc2ShAz5u17L7LUizjhAsfutRjj+7YHnrkZJ8mCiEAhpC7prFZafU8ALfQl
         qGYy252nuL8bPV4QAweOnpasQvQQ7+qDXiXRBJirZdRIUIlaBYpxxejIZhZD98LYdzGg
         CfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMn4fRwscQ/SJvwZ2LjbT42lX4Wost4d9Na2ULpirlU=;
        b=A94Xr3tUO888FyF49fgU0JVJ1x4oxS7eNJ8l57GlQS0Bk9F6AddniH9MfsGc3BBNgr
         qqZ9AetxH37W+f87IdydDtNMt5KYCEsL2cIS2aALJR2OppOY97EY7G58uXXR5rq8ulU/
         +M4jfVEPBjqlL1dcP3TcmmUp615Z866xDkSV/8pkzcwHB8E7HQMEuFX0GCb+SBEaQV3/
         ZC5H+TaDwCyPVnHrueQIizzm5eLBCo/A1CXqj2KyuA5wcwSPVoU1dxk6UwbAf43LYuzA
         MeY3FfGEDPStB0rnRtUFtp1GKFp5Fx9sYAU3/LgiZ+lBjg0IOQAIvNos6Gx5VdMkPnGS
         hF8g==
X-Gm-Message-State: AOAM531f/5MG90G+9Yf+vkJHBoCQ45tgLByVnnSa/cr/YszfID0EQfVt
        6S8RmyJMH6una/W95vzJWdZxu4Erm6ZaGvrHUyzD0w==
X-Google-Smtp-Source: ABdhPJzy6Rpb327sBb0x/Zl1tf0U0NLDoXiUdSLgNSDIUf2B23x8sSBULWUzuP9Efwy9sM7R6gaRoivG8E7X1Pm+bgE=
X-Received: by 2002:a17:90a:ce8d:: with SMTP id g13mr5311217pju.85.1618431319245;
 Wed, 14 Apr 2021 13:15:19 -0700 (PDT)
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
 <CAOFY-A1Nff_99-V+W-xyhq3g4kvqXPzM3eWAQV2WpzrxPfjeFw@mail.gmail.com> <CANn89iK_mRog=vN4krT_86_CfWBWAz1w8c3Tr51xbdS5V45ATg@mail.gmail.com>
In-Reply-To: <CANn89iK_mRog=vN4krT_86_CfWBWAz1w8c3Tr51xbdS5V45ATg@mail.gmail.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Wed, 14 Apr 2021 13:15:08 -0700
Message-ID: <CAOFY-A2JZTuthaOMs5Edrkjz2YjnsQTt_YF=RA8F4x1MXb3mjQ@mail.gmail.com>
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

On Wed, Apr 14, 2021 at 10:35 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Apr 14, 2021 at 7:15 PM Arjun Roy <arjunroy@google.com> wrote:
> >
> > On Wed, Apr 14, 2021 at 9:10 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Wed, Apr 14, 2021 at 6:08 PM David Laight <David.Laight@aculab.com> wrote:
> > > >
> > > > From: Eric Dumazet
> > > > > Sent: 14 April 2021 17:00
> > > > ...
> > > > > > Repeated unsafe_get_user() calls are crying out for an optimisation.
> > > > > > You get something like:
> > > > > >         failed = 0;
> > > > > >         copy();
> > > > > >         if (failed) goto error;
> > > > > >         copy();
> > > > > >         if (failed) goto error;
> > > > > > Where 'failed' is set by the fault handler.
> > > > > >
> > > > > > This could be optimised to:
> > > > > >         failed = 0;
> > > > > >         copy();
> > > > > >         copy();
> > > > > >         if (failed) goto error;
> > > > > > Even if it faults on every invalid address it probably
> > > > > > doesn't matter - no one cares about that path.
> > > > >
> > > > >
> > > > > On which arch are you looking at ?
> > > > >
> > > > > On x86_64 at least, code generation is just perfect.
> > > > > Not even a conditional jmp, it is all handled by exceptions (if any)
> > > > >
> > > > > stac
> > > > > copy();
> > > > > copy();
> > > > > clac
> > > > >
> > > > >
> > > > > <out_of_line>
> > > > > efault_end: do error recovery.
> > > >
> > > > It will be x86_64.
> > > > I'm definitely seeing repeated tests of (IIRC) %rdx.
> > > >
> > > > It may well be because the compiler isn't very new.
> > > > Will be an Ubuntu build of 9.3.0.
> > > > Does that support 'asm goto with outputs' - which
> > > > may be the difference.
> > > >
> > >
> > > Yep, probably. I am using some recent clang version.
> > >
> >
> > On x86-64 I can confirm, for me it (4 x unsafe_get_user()) compiles
> > down to stac + lfence + 8 x mov + clac as straight line code. And
> > results in roughly a 5%-10% speedup over copy_from_user().
> >
>
> But rseq_get_rseq_cs() would still need three different copies,
> with 3 stac+lfence+clac sequences.
>
> Maybe we need to enclose all __rseq_handle_notify_resume() operations
> in a single section.
>
>

To provide a bit of further exposition on this point, if you do 4x
unsafe_get_user() recall I mentioned a 5-10% improvement. On the other
hand, 4x normal get_user() I saw something like a 100% (ie. doubling
of sys time measured) regression.

I assume that's the fault of multiple stac+clac.

-Arjun

>
>
>
>
>
> > -Arjun
> >
> >
> > > >         David
> > > >
> > > > -
> > > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > > Registration No: 1397386 (Wales)

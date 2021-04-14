Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B948535F8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhDNQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhDNQLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:11:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F28FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:10:45 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p3so2078972ybk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLg5f7S3I9/ScV9tydmSM3EZ9y2PKqgD/P8OUiTxukw=;
        b=cDq8iandb0+BvV6/Uik4VUi2ehDGaU9lxj1pU9RbUHKfYY6SI3IjclfEepua40o4FM
         AFUeqhO76VB4UpRJsoEKuspYmzSooKOKbXsQfyT/LugPHZNdDWotl0hn8eXsYH5p7qXK
         NjDhstFNaPELKcI+mzMDOU3OidSBZLHNFNeALVl629gUGNeRTBBxQudpXeCFsl5OI1Da
         boUOsaej52d5sFRURQyZsxbA6gXg/PKXn/Cy/g7CbK01JgNvgTsZ4JMBix8+IDh4KxxI
         F55SY8mSEtPA7Ic1FnyM01l8CbXUQX5Tn4xoojuG6IuUbmzo4Zno568WJZdDoqfe6RMD
         a8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLg5f7S3I9/ScV9tydmSM3EZ9y2PKqgD/P8OUiTxukw=;
        b=nSHwjZHNWMBgJozccggvveBE7ja04A+E2+BCYR5kjf8ik2XHS1azqsyI41Vq2mY00f
         0mbVPe2gwHvPctLLgnP754Hislj8+BVjk5axlQ8CXSRmUf4Z6SHz7GaA0sv5dyJ5Jj38
         +xGjsDH+ma3Eut1LsRt76iGKo4LRlTjofdgtjLvso3BfMHmywo6W7Bg6U2oCkGnLkoTm
         bG4j2Cal4jO0Cxjk4MtDt7RsE7dhFiIZveY/m3viIkLOTF++HmJ7FSDwGz14kd2dUG3I
         XCH64HC6KAnEe6/A7Jgu7HwGx1IjzB6LXTZVnc9kEUT0DUhMEa34+luOTMEeFmgBd0L9
         5evQ==
X-Gm-Message-State: AOAM530IyV6B7GgYf4WkQcfjwV2WUmDe2Vi7z+2656VImKeb+QvPPNUk
        ScOq4sSVz5+fRIQAgNuGzVJDep+J2cYJn6Df/a7vBQ==
X-Google-Smtp-Source: ABdhPJz8A8SOyw2SXNWLTmThLlCxt8JZkre/cVZBTVty4GwrCXsM6ySQr6fgveoWm/RvieILjICt910ip7nVKR042po=
X-Received: by 2002:a25:cf08:: with SMTP id f8mr18301165ybg.132.1618416644553;
 Wed, 14 Apr 2021 09:10:44 -0700 (PDT)
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
 <1e5576a1a5b24cb0b1d53b9bb22d528e@AcuMS.aculab.com>
In-Reply-To: <1e5576a1a5b24cb0b1d53b9bb22d528e@AcuMS.aculab.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 14 Apr 2021 18:10:33 +0200
Message-ID: <CANn89iKmUJRf3FNuk6BhC06Qt-C_RuYfxPUm-1Ho0ztL0KJsLg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
To:     David Laight <David.Laight@aculab.com>
Cc:     Arjun Roy <arjunroy@google.com>,
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

On Wed, Apr 14, 2021 at 6:08 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Eric Dumazet
> > Sent: 14 April 2021 17:00
> ...
> > > Repeated unsafe_get_user() calls are crying out for an optimisation.
> > > You get something like:
> > >         failed = 0;
> > >         copy();
> > >         if (failed) goto error;
> > >         copy();
> > >         if (failed) goto error;
> > > Where 'failed' is set by the fault handler.
> > >
> > > This could be optimised to:
> > >         failed = 0;
> > >         copy();
> > >         copy();
> > >         if (failed) goto error;
> > > Even if it faults on every invalid address it probably
> > > doesn't matter - no one cares about that path.
> >
> >
> > On which arch are you looking at ?
> >
> > On x86_64 at least, code generation is just perfect.
> > Not even a conditional jmp, it is all handled by exceptions (if any)
> >
> > stac
> > copy();
> > copy();
> > clac
> >
> >
> > <out_of_line>
> > efault_end: do error recovery.
>
> It will be x86_64.
> I'm definitely seeing repeated tests of (IIRC) %rdx.
>
> It may well be because the compiler isn't very new.
> Will be an Ubuntu build of 9.3.0.
> Does that support 'asm goto with outputs' - which
> may be the difference.
>

Yep, probably. I am using some recent clang version.

>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

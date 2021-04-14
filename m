Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23235FCBD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245167AbhDNUfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244702AbhDNUfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:35:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D78FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:35:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z22so5677692plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wiaZwHGTdCRj5+b/FatO3lAkw7tSqDQttkSKoeHjA7s=;
        b=lrlW0qZV+YVC2aLuyTTCzdEh/STkvFuGresOjdRh4pVuImIj4ZKS/pMqdt/Vps1g+I
         jvkqVg67lsiTt2P5KQYNlt5Oft4TafNrKS/86QVFmrPJdnHqVKjY3Z6SxZ+ir/hBJsYT
         XenCklvDU78qUlXpHVIEQHmdkhxWR9nghPavEdPw5YUJmn+mlrDgk778ir7lUCXyDNzr
         skV+HvM2/hrY1tYUEjD8LtqO+EJIiGKA4NnwO/ALqhN7uEmAaihGYxEl8Bt57JXD+8ZJ
         ezEX9+s3kac+CexiWaxM6fdSUF2WKHxTUIAtIfzrbRygspDbrj5j2Nt2+0m+QdzLFliD
         hf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wiaZwHGTdCRj5+b/FatO3lAkw7tSqDQttkSKoeHjA7s=;
        b=Jd1U8a2eSdk/+XYkyMUFHeIijTm+mNtYFOPNushwzSCEMnH/QQHSFfIvJ51u3zJJi3
         vQIsMqWDkjmj81pGlw41YwvC3yfVcQedzPkyXDj5wgJKd62FFrgJbnHfJ4dnWBm0mL3e
         l6IirSReT7Yt138bLlrkMh7QdFoRVP2Ai1VlMGU3jfsX6xtw4Bs0gVpnocT4N0Zank5I
         pPgwhoLi7An9ZzEYPMjMadD5x3gI0CbuIjZ+sBOm0JA5fIsp2q4sG/TYgl3cExlAGUjn
         ab04bhIq3d0sti0omUpb5GZZ/PyNFLzlB+eeL2X5wIoH4kqAmhHWPmHuwNAng/J8Rdud
         9UZQ==
X-Gm-Message-State: AOAM533cScWCB/+Dk4ZEmyGe10VdaXxd2DK0unvPNIVTDA7rIVYG6MSi
        7KUM8BJZsLd+bYOuTUZMc1WHOPWgqTawqGHPthcyAw==
X-Google-Smtp-Source: ABdhPJyrGR1ILmJJHGsxuS9At2CwFEQk/mztw0Kol72/gRR52T4v+nahM0YrroGAhUUDDQH83gCKRz7w1yNG7lW7XtM=
X-Received: by 2002:a17:902:7e8b:b029:e9:2ba0:20a2 with SMTP id
 z11-20020a1709027e8bb02900e92ba020a2mr40838pla.69.1618432511767; Wed, 14 Apr
 2021 13:35:11 -0700 (PDT)
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
 <CANn89iK_mRog=vN4krT_86_CfWBWAz1w8c3Tr51xbdS5V45ATg@mail.gmail.com>
 <CAOFY-A2JZTuthaOMs5Edrkjz2YjnsQTt_YF=RA8F4x1MXb3mjQ@mail.gmail.com> <CANn89i+m7Df_pb6CUMVjnBAcHqayg=4wKQ1VEGFvg3DYTDpetA@mail.gmail.com>
In-Reply-To: <CANn89i+m7Df_pb6CUMVjnBAcHqayg=4wKQ1VEGFvg3DYTDpetA@mail.gmail.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Wed, 14 Apr 2021 13:35:00 -0700
Message-ID: <CAOFY-A0Wp9yXkzQQrw_3CefZYMwjQixaKsb51uHjO_NnZ=fOdA@mail.gmail.com>
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

On Wed, Apr 14, 2021 at 1:25 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Apr 14, 2021 at 10:15 PM Arjun Roy <arjunroy@google.com> wrote:
> >
> > On Wed, Apr 14, 2021 at 10:35 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Wed, Apr 14, 2021 at 7:15 PM Arjun Roy <arjunroy@google.com> wrote:
> > > >
> > > > On Wed, Apr 14, 2021 at 9:10 AM Eric Dumazet <edumazet@google.com> wrote:
> > > > >
> > > > > On Wed, Apr 14, 2021 at 6:08 PM David Laight <David.Laight@aculab.com> wrote:
> > > > > >
> > > > > > From: Eric Dumazet
> > > > > > > Sent: 14 April 2021 17:00
> > > > > > ...
> > > > > > > > Repeated unsafe_get_user() calls are crying out for an optimisation.
> > > > > > > > You get something like:
> > > > > > > >         failed = 0;
> > > > > > > >         copy();
> > > > > > > >         if (failed) goto error;
> > > > > > > >         copy();
> > > > > > > >         if (failed) goto error;
> > > > > > > > Where 'failed' is set by the fault handler.
> > > > > > > >
> > > > > > > > This could be optimised to:
> > > > > > > >         failed = 0;
> > > > > > > >         copy();
> > > > > > > >         copy();
> > > > > > > >         if (failed) goto error;
> > > > > > > > Even if it faults on every invalid address it probably
> > > > > > > > doesn't matter - no one cares about that path.
> > > > > > >
> > > > > > >
> > > > > > > On which arch are you looking at ?
> > > > > > >
> > > > > > > On x86_64 at least, code generation is just perfect.
> > > > > > > Not even a conditional jmp, it is all handled by exceptions (if any)
> > > > > > >
> > > > > > > stac
> > > > > > > copy();
> > > > > > > copy();
> > > > > > > clac
> > > > > > >
> > > > > > >
> > > > > > > <out_of_line>
> > > > > > > efault_end: do error recovery.
> > > > > >
> > > > > > It will be x86_64.
> > > > > > I'm definitely seeing repeated tests of (IIRC) %rdx.
> > > > > >
> > > > > > It may well be because the compiler isn't very new.
> > > > > > Will be an Ubuntu build of 9.3.0.
> > > > > > Does that support 'asm goto with outputs' - which
> > > > > > may be the difference.
> > > > > >
> > > > >
> > > > > Yep, probably. I am using some recent clang version.
> > > > >
> > > >
> > > > On x86-64 I can confirm, for me it (4 x unsafe_get_user()) compiles
> > > > down to stac + lfence + 8 x mov + clac as straight line code. And
> > > > results in roughly a 5%-10% speedup over copy_from_user().
> > > >
> > >
> > > But rseq_get_rseq_cs() would still need three different copies,
> > > with 3 stac+lfence+clac sequences.
> > >
> > > Maybe we need to enclose all __rseq_handle_notify_resume() operations
> > > in a single section.
> > >
> > >
> >
> > To provide a bit of further exposition on this point, if you do 4x
> > unsafe_get_user() recall I mentioned a 5-10% improvement. On the other
> > hand, 4x normal get_user() I saw something like a 100% (ie. doubling
> > of sys time measured) regression.
> >
> > I assume that's the fault of multiple stac+clac.
>
>
> I was suggesting only using unsafe_get_user() and unsafe_put_user(),
> and one surrounding stac/clac
>
> Basically what we had (partially) in our old Google kernels, before
> commit 8f2817701492 ("rseq: Use get_user/put_user rather than
> __get_user/__put_user")
> but with all the needed modern stuff.

Yep - in agreement with that approach.

-Arjun

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF7B3E0245
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbhHDNrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbhHDNrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:47:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015B7C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 06:47:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id x11so3797802ejj.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZdWCbKQ0FeBPqzrHYkEiTGQcOJDgW/YM6BhLZvlGVa0=;
        b=bd+MQUXjLGYM2BWsZBVdwUXcKoZhBZTarzqqinr42+H8hC5UYktDAos8vj5w/BGSSE
         qC6SZUHfBD7DT8eRSRCtJ1uPaaFrYM11X912eALlWJk20icqfiKUIXCfm4mMELRTMQn3
         B28Y/CXzoXfQ96g/11w1Va8Eui3Gf9FjMs5ms9UmXWpZS2ZSDsC4XIRetjyiFEOluc9x
         esXBVBPh5+pg1c0RYipG0UqUOwPM3d7315zzIzRXZvj1BH+CIq5o2dunC6DTYLXPk3zE
         MOtYRR8zKiHNCnwuEXZoxUudpHQsdPOCTCO7SBw3Nk6s911eTF2JwPx7UkkcPHSddfUV
         HKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdWCbKQ0FeBPqzrHYkEiTGQcOJDgW/YM6BhLZvlGVa0=;
        b=pX/vYHFFgTCJMl/qzWnaGiITtJhTaSiTTaZ5p2NZMnTB6fYnep+jawZigFYIIJ7D0c
         h3KKkZcT8Hu8S7Q9G4zMWdm8In6///lPthIplqxv+5Z99E0Ieyo0K9eWcPmJ6vjy/k+Z
         4nBWFGSGz+33GJPrZhfWJHhoLAOlQ38kflBpBjaRsv+/joWz9gcWfUUhIalbnQZor2Fn
         F34VM8KQzwu6mgQs0Hmy7e9C5BOk6aIZIMk3qEPOuIeKxdyNw/B4QstIY41VxwRUqD2u
         m9fsXg1LRFon2fQU5DO4+1RsjzNOgzcSDgjEaACLA3thpslP6fQ0iQf6vFjFZAVtZFwZ
         UgeQ==
X-Gm-Message-State: AOAM530BOK12q7J07NhhkoFHfw7F7EjaRGKrmcLUIiHrdIc49QTTqTqZ
        ovnCOT60iIZ0wylXwOXay6VCnYk6kEtooQdSbN0qtiOpW0fIaXQW6uwlCw==
X-Google-Smtp-Source: ABdhPJyhVGHT+EfmUvgX2/jIbnFHTnjhaZPNSXW2mejIDCZ+TVSLsD62L2XpG1vvE6+F4OiCSchYQS0noBgHWewXzus=
X-Received: by 2002:a17:906:f20a:: with SMTP id gt10mr26145158ejb.267.1628084821505;
 Wed, 04 Aug 2021 06:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210729082549.144559-1-wangrui@loongson.cn> <20210729095342.GB8286@alpha.franken.de>
 <CAHirt9hLATcnSw9HXSo-TZ+buNHJXJvFtJEy56_Bi+mOfckNjw@mail.gmail.com> <20210729143307.GA13231@alpha.franken.de>
In-Reply-To: <20210729143307.GA13231@alpha.franken.de>
From:   hev <r@hev.cc>
Date:   Wed, 4 Aug 2021 21:46:50 +0800
Message-ID: <CAHirt9igj7wzrNKWUaoEnofWEwF1VtjuBpvgRGZpMiGphJmPCQ@mail.gmail.com>
Subject: Re: [RFC PATCH] locking/atomic: arch/mips: Fix atomic{_64,}_sub_if_positive
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Rui Wang <wangrui@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 10:33 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Thu, Jul 29, 2021 at 08:31:11PM +0800, hev wrote:
> > Hi, Thomas,
> >
> > On Thu, Jul 29, 2021 at 5:53 PM Thomas Bogendoerfer
> > <tsbogend@alpha.franken.de> wrote:
> > >
> > > On Thu, Jul 29, 2021 at 04:25:49PM +0800, Rui Wang wrote:
> > > > This looks like a typo and that caused atomic64 test failed.
> > > >
> > > > Signed-off-by: Rui Wang <wangrui@loongson.cn>
> > > > Signed-off-by: hev <r@hev.cc>
> > > > ---
> > > >  arch/mips/include/asm/atomic.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
> > > > index 95e1f7f3597f..a0b9e7c1e4fc 100644
> > > > --- a/arch/mips/include/asm/atomic.h
> > > > +++ b/arch/mips/include/asm/atomic.h
> > > > @@ -206,7 +206,7 @@ ATOMIC_OPS(atomic64, xor, s64, ^=, xor, lld, scd)
> > > >   * The function returns the old value of @v minus @i.
> > > >   */
> > > >  #define ATOMIC_SIP_OP(pfx, type, op, ll, sc)                         \
> > > > -static __inline__ int arch_##pfx##_sub_if_positive(type i, pfx##_t * v)      \
> > > > +static __inline__ type arch_##pfx##_sub_if_positive(type i, pfx##_t * v)     \
> > > >  {                                                                    \
> > > >       type temp, result;                                              \
> > > >                                                                       \
> > >
> > > sub_if_postive looks unused to me. Could you send a patch removing it
> > > instead ? riscv also has a sub_if_positive implementation, which looks
> > > unused.
> > I found atomic{_64,}_dec_if_postive is based on sub_if_postive, and
> > used in many places:
> >
> > kernel/kmod.c:    if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
> > kernel/kmod.c:
> > atomic_dec_if_positive(&kmod_concurrent_max) >= 0,
> > kernel/module.c:        ret = atomic_dec_if_positive(&module->refcnt);
> > ...
> > drivers/net/ethernet/mellanox/mlx5/core/eswitch.c:
> > atomic64_dec_if_positive(&esw->user_count);
> > drivers/net/netdevsim/fib.c:        atomic64_dec_if_positive(&entry->num);
> > drivers/net/netdevsim/fib.c:        atomic64_dec_if_positive(&entry->num);
> >
> > Are you sure to remove it?
>
> in that case, let's keep it. There is a fallback for atomic_dec_if_positive,
> that's why I didn't notice where it is used.

yep, do you think this patch is okay?

Regards,

Rui

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B349D3F8D83
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243265AbhHZSDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhHZSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:03:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1779C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:02:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so8697876lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGw9uJmJ2z6MXuXBnDtwUutt+68P65RWStdJO514qas=;
        b=B2FAnkUl2+kM4yRf/QS/R1JReIq24Hnbr19zmuEDgqYUdNh1gTIoRUaunZdoEJqFfW
         Kh33FdiQdzQWAEG8HKNsdxl5PlvDhJ45LLemem+X5wV7ImqCiEIgGx6pelPUdAFXC4qG
         vVXa/+XI9iYDsbC2aGnmUo4TC/sA+SjLHpyqv4luHppAgRdJ3sDbPcIbUjgpkFVekL+y
         D9MqeMghtWNrlr1j69RCiNGV5dImaH7D1KdGTCLWxwOnJZO2T3sFuIORZeowUqYhzrc5
         foEcu6k2bhymF/OMxZ6UKrGHQi2BnzMsD/uoLW6nt4WkHGJ7C2Ekp9kAy4bpf44YTagP
         koQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGw9uJmJ2z6MXuXBnDtwUutt+68P65RWStdJO514qas=;
        b=jB2N7dSELGJpYj49BT8Kf04in7ns+up+CN7AhcwAq0RGxG8K8A9FPmgnrVoqT1N1JO
         Wryg+DFSkBKAU8jZijLuD0Ij5PfmunDN/PldBAk8yXSOzAk8MXYkN6jHpUk5wZLdxdCl
         P2D9VvE1Ed+7Avma471ERCGLzAKgu1NgnIKppPiKzG2UCH99OR+0uk7BnFN8I611JKZ3
         2wroMMzpGeo8tphSxbsWqoR9NUEkkpTu/+EseouXSZdn12Iw6zk2bx51REZQToVglXPB
         GMx2MKElPEGa1mNq2a60zDKFmLEyUgMeyykw9hrsCm6SEr5BvUFWN4RUEt+rL5BHax+C
         hZ/w==
X-Gm-Message-State: AOAM53026A4X8lHZtizh7k9eRe8ArViGJrGp0nT9LGBMcYdAegOONyCu
        h2SZRUv1kBydqgHXlaRR2Rh4JzhSKSOqKX9XJVXODd0qULiIBw==
X-Google-Smtp-Source: ABdhPJxWg7MSHSATPwn7TQr1ROw5bTHFIBgE43q2LvF7FWK+dICjFNZW3iN5NwAu/aeOV0mxcLV4RtFONxyUnFKH1Ns=
X-Received: by 2002:a05:6512:3a84:: with SMTP id q4mr3670002lfu.543.1630000970649;
 Thu, 26 Aug 2021 11:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org>
 <20210822075122.864511-20-keescook@chromium.org> <CAKwvOdnrO+oagJEiBMmoHrhTJKSRwzb0DK=R_QdVjhiNzb34dg@mail.gmail.com>
 <202108251950.61F7A4CD@keescook>
In-Reply-To: <202108251950.61F7A4CD@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Aug 2021 11:02:39 -0700
Message-ID: <CAKwvOdndEYeQ1MFPPEvn=UWv00o6of1OT3UQ-woqyO-viDkqVw@mail.gmail.com>
Subject: Re: [PATCH for-next 19/25] fortify: Allow strlen() and strnlen() to
 pass compile-time known lengths
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 7:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Aug 25, 2021 at 03:05:56PM -0700, Nick Desaulniers wrote:
> > On Sun, Aug 22, 2021 at 12:57 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > > index a3cb1d9aacce..e232a63fd826 100644
> > > --- a/include/linux/fortify-string.h
> > > +++ b/include/linux/fortify-string.h
> > > @@ -10,6 +10,18 @@ void __read_overflow(void) __compiletime_error("detected read beyond size of obj
> > >  void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
> > >  void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
> > >
> > > +#define __compiletime_strlen(p)        ({              \
> > > +       size_t ret = (size_t)-1;                        \
> > > +       size_t p_size = __builtin_object_size(p, 1);    \
> > > +       if (p_size != (size_t)-1) {                     \
> > > +               size_t p_len = p_size - 1;              \
> > > +               if (__builtin_constant_p(p[p_len]) &&   \
> > > +                   p[p_len] == '\0')                   \
> > > +                       ret = __builtin_strlen(p);      \
> > > +       }                                               \
> > > +       ret;                                            \
> > > +})
> >
> > Can this be a `static inline` function that accepts a `const char *`
> > and returns a `size_t` rather than a statement expression?
>
> No because both __builtin_object_size() and __builtin_strlen() may not
> work. See:
> https://lore.kernel.org/lkml/20210818060533.3569517-64-keescook@chromium.org/

Ah right, then consider adding a comment to encourage others not to
rewrite it as such.

>
> Regardless, it will always collapse to a const value of either -1 or
> the length of the string.

-- 
Thanks,
~Nick Desaulniers

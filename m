Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3B932D917
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhCDRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhCDRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:55:37 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D964CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:54:56 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 18so36116704lff.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYzGpTewhxHxL7CpcepbC9L9ykWvrUtL+K0xz4SbvmU=;
        b=U51rv4zpBK86lIfGRkTUAlvQqBCWAyLeojeIdsRGl2dxMbLRu1PBgHvwQy2RAlDHGS
         qS95kFnaphLP7itFtdaZV7DD1nsen8f+JhImMQpAhLZG8qUpDZULwh9eDoCKAArsemLI
         9UnBzTRoUe0UVj57BSVi22s7dx6bM1/vbMcIR/FUonD1VZlUC16b1aFbgm8U+XpXciOY
         7n1p/D7SALszYOuW+BmXU3FKIHhJJLXOSAflaMzSFM8wNGBfP6mXixU6n1IktuHAHFH/
         eSSyz8RFBx7y5FWRMYtxK+X00wKN/qDTaSkmYqBWEA1gg8vbtwLkOJxNmU4SWeaKq9p8
         7Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYzGpTewhxHxL7CpcepbC9L9ykWvrUtL+K0xz4SbvmU=;
        b=W+nJ50LTJ+s/k/DIhSAtt0tQ/aCDDByK9QrbpB3tVLln/rOapIE52l+yUgckslkdNK
         TUXuqMYyMFHvFDyFi/YwDS9lud1Cs8YQuu0Y4mBnmySJbJRvczVSBXseX0Sj7uip9HBs
         A8vYHHVhL8wVShHNkO1J6tv5/p4RCqOo8pRrokMtWYOKwiHSpJ38B54pfjb/NKQ8hu+d
         IhH7pIeD9uHXCGMV7lM59Vjq4oTnsc5PDYo5FNIFXWDrNZAkH6+YksElaep8yud+sQUx
         xPB7lJMNlzdprEvaARRNui7VRJquckPQ8IgTLX/NYik4ckExhSEpNEFygatMQQ4lnjYf
         cyzQ==
X-Gm-Message-State: AOAM530zjirCtj5X2Xw/RnsK10OzIr7y/Cp+WK6Vx/KhgN8tWbd1DjrX
        s7znLyxN+pu1PR9mnAVPxK00mUrCAiRM+mIt+EJOmA==
X-Google-Smtp-Source: ABdhPJw6y3taoMD+qAv4h6sTee2Uebo0oTqIZqHuTrRDhVFPJbpn8vlXeZVwpQ4xCPi5BFtzV+p3/G8B2K76LrtsUzk=
X-Received: by 2002:ac2:532c:: with SMTP id f12mr3178752lfh.73.1614880495105;
 Thu, 04 Mar 2021 09:54:55 -0800 (PST)
MIME-Version: 1.0
References: <e2e8728c4c4553bbac75a64b148e402183699c0c.1614780567.git.christophe.leroy@csgroup.eu>
 <CANpmjNOvgbUCf0QBs1J-mO0yEPuzcTMm7aS1JpPB-17_LabNHw@mail.gmail.com>
 <1802be3e-dc1a-52e0-1754-a40f0ea39658@csgroup.eu> <YD+o5QkCZN97mH8/@elver.google.com>
 <20210304145730.GC54534@C02TD0UTHF1T.local> <CANpmjNOSpFbbDaH9hNucXrpzG=HpsoQpk5w-24x8sU_G-6cz0Q@mail.gmail.com>
 <20210304165923.GA60457@C02TD0UTHF1T.local> <YEEYDSJeLPvqRAHZ@elver.google.com>
In-Reply-To: <YEEYDSJeLPvqRAHZ@elver.google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Mar 2021 09:54:44 -0800
Message-ID: <CAKwvOd=wBArMwvtDC8zV-QjQa5UuwWoxksQ8j+hUCZzbEAn+Fw@mail.gmail.com>
Subject: Re: [PATCH v1] powerpc: Include running function as first entry in
 save_stack_trace() and friends
To:     Marco Elver <elver@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 9:42 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, Mar 04, 2021 at 04:59PM +0000, Mark Rutland wrote:
> > On Thu, Mar 04, 2021 at 04:30:34PM +0100, Marco Elver wrote:
> > > On Thu, 4 Mar 2021 at 15:57, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > [adding Mark Brown]
> > > >
> > > > The bigger problem here is that skipping is dodgy to begin with, and
> > > > this is still liable to break in some cases. One big concern is that
> > > > (especially with LTO) we cannot guarantee the compiler will not inline
> > > > or outline functions, causing the skipp value to be too large or too
> > > > small. That's liable to happen to callers, and in theory (though
> > > > unlikely in practice), portions of arch_stack_walk() or
> > > > stack_trace_save() could get outlined too.
> > > >
> > > > Unless we can get some strong guarantees from compiler folk such that we
> > > > can guarantee a specific function acts boundary for unwinding (and
> > > > doesn't itself get split, etc), the only reliable way I can think to
> > > > solve this requires an assembly trampoline. Whatever we do is liable to
> > > > need some invasive rework.
> > >
> > > Will LTO and friends respect 'noinline'?
> >
> > I hope so (and suspect we'd have more problems otherwise), but I don't
> > know whether they actually so.
> >
> > I suspect even with 'noinline' the compiler is permitted to outline
> > portions of a function if it wanted to (and IIUC it could still make
> > specialized copies in the absence of 'noclone').
> >
> > > One thing I also noticed is that tail calls would also cause the stack
> > > trace to appear somewhat incomplete (for some of my tests I've
> > > disabled tail call optimizations).
> >
> > I assume you mean for a chain A->B->C where B tail-calls C, you get a
> > trace A->C? ... or is A going missing too?
>
> Correct, it's just the A->C outcome.
>
> > > Is there a way to also mark a function non-tail-callable?
> >
> > I think this can be bodged using __attribute__((optimize("$OPTIONS")))
> > on a caller to inhibit TCO (though IIRC GCC doesn't reliably support
> > function-local optimization options), but I don't expect there's any way
> > to mark a callee as not being tail-callable.
>
> I don't think this is reliable. It'd be
> __attribute__((optimize("-fno-optimize-sibling-calls"))), but doesn't
> work if applied to the function we do not want to tail-call-optimize,
> but would have to be applied to the function that does the tail-calling.
> So it's a bit backwards, even if it worked.
>
> > Accoding to the GCC documentation, GCC won't TCO noreturn functions, but
> > obviously that's not something we can use generally.
> >
> > https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes

include/linux/compiler.h:246:
prevent_tail_call_optimization

commit a9a3ed1eff36 ("x86: Fix early boot crash on gcc-10, third try")

>
> Perhaps we can ask the toolchain folks to help add such an attribute. Or
> maybe the feature already exists somewhere, but hidden.
>
> +Cc linux-toolchains@vger.kernel.org
>
> > > But I'm also not sure if with all that we'd be guaranteed the code we
> > > want, even though in practice it might.
> >
> > True! I'd just like to be on the least dodgy ground we can be.
>
> It's been dodgy for a while, and I'd welcome any low-cost fixes to make
> it less dodgy in the short-term at least. :-)
>
> Thanks,
> -- Marco



-- 
Thanks,
~Nick Desaulniers

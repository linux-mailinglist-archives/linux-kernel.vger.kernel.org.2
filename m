Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C424D32D898
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbhCDR0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbhCDR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:26:21 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB03C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:25:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u125so10432401wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rF5Y4qiLYG77iew1mU5Rkg3muHLgwxb+EueWczzk7UQ=;
        b=mZ9ESMDypfYC8jF7LeueBhm2UiIAIN/v6i6QXG6sJvo6vTlym2d/pOVora2yQsMHYx
         2eApf3R5G7JrLv4USsVgoEl2yFrP083oeblz/IsBWcPVqzFDaHC2Ix+SoE4MTxgCCw0G
         gUM+DMdlIqdBM1t5801TPfJMrwTEUXqAgp/A42//Mymhi5Tnuz4Fr5HpWN52HVtRMALP
         EV5ywj6fcy7GSYJAOqNO2rUKimjOewgB/U9ahmQz7ewEOBkxzO0mYeFiq1MJn9MSElaF
         wUF9qR+lAvKtsJ6G8C5AiRbNU5A9M5XHYwVuuJ75yXsKiKvPmU2uAhPbn1fGHsYAe4wi
         sVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rF5Y4qiLYG77iew1mU5Rkg3muHLgwxb+EueWczzk7UQ=;
        b=EgB2vc1u7QgO9ap+1VRDhRfKNK0n/RFX3AapJ3gNYpzaDvfTk/28MS5ATtVxOFHQt1
         TfNZTvHInoU+1UQ0cfKvG3O2YtrbbAlqIF/3SirQNp6rnF8rDEFtTkE4Y3wlAFAXDcu/
         E5E6cfovdSj+5JB4LR22Qcb44DNnCFYE+Wmfx6v85G2+esaWaCiTkCZ9PaVDKm3HGqcS
         +QQscOxJaH7+dlAI3wSnMDNU6cgKDAnXyemgMdvDLP9Fd32UFE45BW79KmyKyixd8SQC
         O0Ly5SgrgPxuidiJSNKg6MgHjqhqX1pFwt6mw3LwviKKnDDLXY3602tJ0uKi0YzI0eIx
         ileA==
X-Gm-Message-State: AOAM531R6HTQAf8vhNbyKJyyef3R5avAIzOpmNF15c7x6aAUBjqiHKne
        sLNCLqKHd3DR96VI+AY0+l/6cg==
X-Google-Smtp-Source: ABdhPJyX2yKDzjHRQw3J2Mhvj3s3SocK42iygrNVPhkkAuthUyR6ukmqTE9xK7Mc5FUtVlYXSIWG2g==
X-Received: by 2002:a1c:c244:: with SMTP id s65mr5000395wmf.96.1614878739431;
        Thu, 04 Mar 2021 09:25:39 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:adef:40fb:49ed:5ab6])
        by smtp.gmail.com with ESMTPSA id f17sm36439007wru.31.2021.03.04.09.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 09:25:38 -0800 (PST)
Date:   Thu, 4 Mar 2021 18:25:33 +0100
From:   Marco Elver <elver@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        broonie@kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v1] powerpc: Include running function as first entry in
 save_stack_trace() and friends
Message-ID: <YEEYDSJeLPvqRAHZ@elver.google.com>
References: <e2e8728c4c4553bbac75a64b148e402183699c0c.1614780567.git.christophe.leroy@csgroup.eu>
 <CANpmjNOvgbUCf0QBs1J-mO0yEPuzcTMm7aS1JpPB-17_LabNHw@mail.gmail.com>
 <1802be3e-dc1a-52e0-1754-a40f0ea39658@csgroup.eu>
 <YD+o5QkCZN97mH8/@elver.google.com>
 <20210304145730.GC54534@C02TD0UTHF1T.local>
 <CANpmjNOSpFbbDaH9hNucXrpzG=HpsoQpk5w-24x8sU_G-6cz0Q@mail.gmail.com>
 <20210304165923.GA60457@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304165923.GA60457@C02TD0UTHF1T.local>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 04:59PM +0000, Mark Rutland wrote:
> On Thu, Mar 04, 2021 at 04:30:34PM +0100, Marco Elver wrote:
> > On Thu, 4 Mar 2021 at 15:57, Mark Rutland <mark.rutland@arm.com> wrote:
> > > [adding Mark Brown]
> > >
> > > The bigger problem here is that skipping is dodgy to begin with, and
> > > this is still liable to break in some cases. One big concern is that
> > > (especially with LTO) we cannot guarantee the compiler will not inline
> > > or outline functions, causing the skipp value to be too large or too
> > > small. That's liable to happen to callers, and in theory (though
> > > unlikely in practice), portions of arch_stack_walk() or
> > > stack_trace_save() could get outlined too.
> > >
> > > Unless we can get some strong guarantees from compiler folk such that we
> > > can guarantee a specific function acts boundary for unwinding (and
> > > doesn't itself get split, etc), the only reliable way I can think to
> > > solve this requires an assembly trampoline. Whatever we do is liable to
> > > need some invasive rework.
> > 
> > Will LTO and friends respect 'noinline'?
> 
> I hope so (and suspect we'd have more problems otherwise), but I don't
> know whether they actually so.
> 
> I suspect even with 'noinline' the compiler is permitted to outline
> portions of a function if it wanted to (and IIUC it could still make
> specialized copies in the absence of 'noclone').
> 
> > One thing I also noticed is that tail calls would also cause the stack
> > trace to appear somewhat incomplete (for some of my tests I've
> > disabled tail call optimizations).
> 
> I assume you mean for a chain A->B->C where B tail-calls C, you get a
> trace A->C? ... or is A going missing too?

Correct, it's just the A->C outcome.

> > Is there a way to also mark a function non-tail-callable?
> 
> I think this can be bodged using __attribute__((optimize("$OPTIONS")))
> on a caller to inhibit TCO (though IIRC GCC doesn't reliably support
> function-local optimization options), but I don't expect there's any way
> to mark a callee as not being tail-callable.

I don't think this is reliable. It'd be
__attribute__((optimize("-fno-optimize-sibling-calls"))), but doesn't
work if applied to the function we do not want to tail-call-optimize,
but would have to be applied to the function that does the tail-calling.
So it's a bit backwards, even if it worked.

> Accoding to the GCC documentation, GCC won't TCO noreturn functions, but
> obviously that's not something we can use generally.
> 
> https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes

Perhaps we can ask the toolchain folks to help add such an attribute. Or
maybe the feature already exists somewhere, but hidden.

+Cc linux-toolchains@vger.kernel.org

> > But I'm also not sure if with all that we'd be guaranteed the code we
> > want, even though in practice it might.
> 
> True! I'd just like to be on the least dodgy ground we can be.

It's been dodgy for a while, and I'd welcome any low-cost fixes to make
it less dodgy in the short-term at least. :-)

Thanks,
-- Marco

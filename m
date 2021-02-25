Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D9E325929
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhBYV7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhBYV7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:59:41 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35091C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:59:01 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id h4so8092090ljl.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ai4anVaZwnvvwxvM54ViG62F8i0W2TcS/vYJjvyqdFI=;
        b=ZsrRRtpdLmCleLUgNIRmi+ch+M0UcgASYL8in1dTZ6nYUuI63usH/PHbF4sjQ2Ar08
         O9/kKB72NvKDp2AVtl0lMKzDWnsPb9k4q+0gZXDB0woogsIZwhAKOrM/nNPmTm1HAf6T
         /71s9VYqxYDqCNubvhSUgIQFlnF1L+nTw0uIYrvh1YIxVS6ETa3sYRUK6d39i5XBYu9i
         kOEruQdkWNn1PHmeMzCgy4dWEf2eLjnE0kY3JhBKa1AXtVREfnMb0oYEIsBM4SAqArqh
         slhNFk1SVE63nET8ojC0X6mBJOp2r241L68AS1jWyNNbpZSpgtddSPKwVEU1w7SZysjC
         IWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ai4anVaZwnvvwxvM54ViG62F8i0W2TcS/vYJjvyqdFI=;
        b=pxVaNeaaxY7rCDeakhgj2Z575sASpqeTOSwthUj0Vkan54JKYg0zuLfESqkjcojdSV
         PjZxAL6DgrGEAE5wxlunTJE6yhMFoV54ZRehUAfOZ4MI90PDEyXWGV0La448qCF9rsom
         rgV0pZtfz1ubEDi2bK7dOBxR/L726qKTz4RBO9UOyoCntJlrYZZbVQJRFJVXWTrSZMis
         6GbsR/RiJgw2TvWOnXPd+ZiJT+aIsliF3ctOSYWRqOiheg9IVqUuuwp4hlm97tS+mNlq
         7b31RaI+vsrVBmclnzX+cojJlrQaRreyBYfuowHLcwLE0qBulNIuARUTkWtxNNHYl5z1
         1/Bw==
X-Gm-Message-State: AOAM531AfppBQHwJIW096IfUS7i6d9GAxdCR3FnDNiiM9e0U1LUKI2BT
        sou0hcez32Wl7nbCDpQamXW+SEEyO1bga2Ju01tIiA==
X-Google-Smtp-Source: ABdhPJyR7MhBoh2+caNP+ZtCI7Vd4OyigFu3v3rSe5iNXYWuXapr8+x2TnhMeWFy5dAq3cExow8RgeeiLBGS3qaoBVs=
X-Received: by 2002:a2e:2a83:: with SMTP id q125mr2652653ljq.244.1614290339541;
 Thu, 25 Feb 2021 13:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20210225112247.2240389-1-arnd@kernel.org> <20210225114533.GA380@zn.tnic>
 <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
 <20210225124218.GC380@zn.tnic> <CAK8P3a1ZiUHRxKr=SFgEFETLcSQeViPnR+XB2gBvbVk24vGvqQ@mail.gmail.com>
 <CAKwvOd=B=cHpp_XfPTtyVpQyrwQrFZX9SXKw=SJC1VC-VbEwFA@mail.gmail.com> <20210225213300.GF380@zn.tnic>
In-Reply-To: <20210225213300.GF380@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Feb 2021 13:58:48 -0800
Message-ID: <CAKwvOdkKjOb8fS7NgFxvAwEQTp3fPjenhvehnjh5xRw=HevQ=Q@mail.gmail.com>
Subject: Re: [PATCH] x86: mark some mpspec inline functions as __init
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 1:33 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Feb 25, 2021 at 12:31:33PM -0800, Nick Desaulniers wrote:
> > (full thread: https://lore.kernel.org/lkml/20210225112247.2240389-1-arnd@kernel.org/)
> > I suspect in this specific case, "Interprocedural Sparse Conditional
> > Constant Propagation" sees the calls to the same fn with different
> > constants, propagates those down creating two specialized versions of
> > the callee (so they are distinct functions now), inlines those into
> > get_smp_config()/early_get_smp_config(), then there's too many callers
> > of those in a single TU where inlining would cause excessive code
> > bloat.
>
> Well, there's exactly one caller of get_smp_config - that's setup_arch().
> early_get_smp_config() gets called also exactly once in amd_numa_init().
>
> Now, with my simplistic approach, I can replace the lines at those call
> sites by hand with the
>
>         x86_init.mpparse.get_smp_config(<arg>);
>
> call. So those become exactly one function call. I still don't see how
> that can be done any differently, frankly.
>
> But apparently the cost model has decided that this is not inlineable.
> Maybe because that function ptr is assigned at boot time and that
> somehow gets the cost model to give it a very high (or low) value. Or
> maybe because the wrappers are calling through a variable - the x86_init
> thing - which is in a different section and that confuses the inliner.
> Or whatever - totally speculating here.

The config that reproduces it wasn't shared here; I wouldn't be
surprised if this was found via randconfig that enabled some config
that led to excessive code bloat somewhere somehow.

>
> And this brings me to my point - you can't expect people to do all that
> crazy dance of compiler introspection and understand cost models and
> compiler optimization just to fix stuff like that.

Oh, I don't expect everyone to; just leaving breadcrumbs showing other
people on thread how to fish. ;)

>
> Now, imagine we "fix" this to clang-13's inliner's satisfaction. Now
> imagine too that gcc Version Next changes their inliner and that inliner
> says that that "fix" is wrong, for whatever reason, bottom up, top down,
> whatever. Do you feel the annoyance all around?

Yes, mutually unsatisfiable cases are painful, but I don't think
that's what's going on here.

>
> And since, as you say, there are no silver bullets here, I think for
> cases like that we'll need a "I know what I'm doing Mr. Compiler, TYVM,
> even if your cost model says otherwise" facility. And in this case I
> still think __always_inline is correct.

Sure, it doesn't really matter to me which way this is fixed.  I
personally prefer placing functions in the correct sections and
letting the compiler be flexible, since if all of this is to satisfy
some randconfig then __always_inline is making a decision for all
configs, but perhaps it doesn't matter.
-- 
Thanks,
~Nick Desaulniers

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764CC3258B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhBYVdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhBYVdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:33:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:33:07 -0800 (PST)
Received: from zn.tnic (p200300ec2f03dc0050646025c69cd84e.dip0.t-ipconnect.de [IPv6:2003:ec:2f03:dc00:5064:6025:c69c:d84e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC5611EC05BB;
        Thu, 25 Feb 2021 22:33:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614288785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eDmRKFZ4fbRtPN7JebMoB9LbU72F1jrH4quqxZDE/y0=;
        b=OIobfCmiFfyF5uVl0F3uCHX2g/nWeiQ4C6gtBATLU9Ey3j6P0ZzBtuOOaml973FqbYrap3
        noV5gJCNo5xfH9/Ofuzs7ZjFne32TE5vied+oy5t91g889vpbCKmejojFcAXPUpeFXXeqk
        +n//lmcNr/Dn3/yB+S3bUM5jpr3z5q8=
Date:   Thu, 25 Feb 2021 22:33:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Arthur Eubanks <aeubanks@google.com>,
        Chandler Carruth <chandlerc@google.com>
Subject: Re: [PATCH] x86: mark some mpspec inline functions as __init
Message-ID: <20210225213300.GF380@zn.tnic>
References: <20210225112247.2240389-1-arnd@kernel.org>
 <20210225114533.GA380@zn.tnic>
 <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
 <20210225124218.GC380@zn.tnic>
 <CAK8P3a1ZiUHRxKr=SFgEFETLcSQeViPnR+XB2gBvbVk24vGvqQ@mail.gmail.com>
 <CAKwvOd=B=cHpp_XfPTtyVpQyrwQrFZX9SXKw=SJC1VC-VbEwFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=B=cHpp_XfPTtyVpQyrwQrFZX9SXKw=SJC1VC-VbEwFA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thu, Feb 25, 2021 at 12:31:33PM -0800, Nick Desaulniers wrote:
> So LLVM is telling us bar() was inlined into foo(); (baz() can't be
> because it wasn't defined in this TU).  You can use this to "watch"
> the compiler make decisions about inlining.

thanks for taking the time to write all this - it is very interesting
and reminds me that I simply won't have time in this life of mine to
learn about compiler inlining - that's a whole another universe. :-)

I hope you can use that text in a blog post too - it is an interesting
read.

> (full thread: https://lore.kernel.org/lkml/20210225112247.2240389-1-arnd@kernel.org/)
> I suspect in this specific case, "Interprocedural Sparse Conditional
> Constant Propagation" sees the calls to the same fn with different
> constants, propagates those down creating two specialized versions of
> the callee (so they are distinct functions now), inlines those into
> get_smp_config()/early_get_smp_config(), then there's too many callers
> of those in a single TU where inlining would cause excessive code
> bloat.

Well, there's exactly one caller of get_smp_config - that's setup_arch().
early_get_smp_config() gets called also exactly once in amd_numa_init().

Now, with my simplistic approach, I can replace the lines at those call
sites by hand with the

	x86_init.mpparse.get_smp_config(<arg>);

call. So those become exactly one function call. I still don't see how
that can be done any differently, frankly.

But apparently the cost model has decided that this is not inlineable.
Maybe because that function ptr is assigned at boot time and that
somehow gets the cost model to give it a very high (or low) value. Or
maybe because the wrappers are calling through a variable - the x86_init
thing - which is in a different section and that confuses the inliner.
Or whatever - totally speculating here.

And this brings me to my point - you can't expect people to do all that
crazy dance of compiler introspection and understand cost models and
compiler optimization just to fix stuff like that.

Now, imagine we "fix" this to clang-13's inliner's satisfaction. Now
imagine too that gcc Version Next changes their inliner and that inliner
says that that "fix" is wrong, for whatever reason, bottom up, top down,
whatever. Do you feel the annoyance all around?

And since, as you say, there are no silver bullets here, I think for
cases like that we'll need a "I know what I'm doing Mr. Compiler, TYVM,
even if your cost model says otherwise" facility. And in this case I
still think __always_inline is correct.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

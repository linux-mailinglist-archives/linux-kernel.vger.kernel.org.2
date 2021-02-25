Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C34324FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhBYMnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhBYMnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:43:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3600CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 04:42:29 -0800 (PST)
Received: from zn.tnic (p200300ec2f03dc0076eb88cbea77f6b1.dip0.t-ipconnect.de [IPv6:2003:ec:2f03:dc00:76eb:88cb:ea77:f6b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECDBD1EC05A0;
        Thu, 25 Feb 2021 13:42:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614256941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uQk8xhtzVFS07eeQjgYRuM2udUqMvNN0jpzN2VvT1To=;
        b=KtI5TcoOVVvInFzBTsRTjmN+1g56Wu94xRvGINZrn1ls87BEEA++89OCdDuBbK1kN99xlg
        uLO/syvyIpSqvmCdqvxY8m/cq5OeB+Ee8+6upFfgVUNKCTzaGhQB/odGkuGQUdo4sNkh6J
        dbwqmr0tmJIE2qOoFx7jr3B8/OGTf10=
Date:   Thu, 25 Feb 2021 13:42:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] x86: mark some mpspec inline functions as __init
Message-ID: <20210225124218.GC380@zn.tnic>
References: <20210225112247.2240389-1-arnd@kernel.org>
 <20210225114533.GA380@zn.tnic>
 <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 01:18:21PM +0100, Arnd Bergmann wrote:
> Either way works correctly, I don't care much, but picked the __init
> annotation as it seemed more intuitive. If the compiler decides to
> make it out-of-line for whatever reason,

Well, frankly, I see no good reason for not inlining a function body
which is a single call. And gcc does it just fine. And previous clangs
did too, so why does clang-13 do it differently?

IOW, could it be that you're fixing something that ain't broke?

> I see no point in telling it otherwise, even though I agree it is a
> bit silly.
>
> Should I send the patch with __always_inline?

I guess.

Although from where I'm standing, it looks like clang-13 needs fixing.
But I surely don't know the whole story and "inline" is not forcing
the inlining so I guess a compiler is free to do what it wants here.
Apparently.

And I guess telling it that those should be always inlined makes it
perfectly clear then.

But WTH do I know...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

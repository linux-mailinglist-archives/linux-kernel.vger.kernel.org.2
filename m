Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E100325EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBZIOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZIOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:14:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AE8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 00:13:34 -0800 (PST)
Received: from zn.tnic (p200300ec2f08690046fe8a0234e2694f.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6900:46fe:8a02:34e2:694f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDAA71EC03A0;
        Fri, 26 Feb 2021 09:13:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614327212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l1+9HfOoW+GEk2Nht8GoIcMQYtZGuUP8lH6O60vFDzA=;
        b=TbRfkcyfwJcHUqNdxSXuwXY/4l2B7wRXelMi/7bGJio3EK2H08u9mx0qqezzN8La3DL4f9
        VUO+6KFDSiU0m71IOyvncUIM6tK06fuaMhi4EcFhwCnPxAj+cP19TJjEsvzhFgoQDjQxyL
        dkhZEISYSOsDqn8L6Rykk/kWYSR22OA=
Date:   Fri, 26 Feb 2021 09:13:27 +0100
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
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] x86: mark some mpspec inline functions as __init
Message-ID: <20210226081327.GB19284@zn.tnic>
References: <20210225112247.2240389-1-arnd@kernel.org>
 <20210225114533.GA380@zn.tnic>
 <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
 <20210225124218.GC380@zn.tnic>
 <CAK8P3a1ZiUHRxKr=SFgEFETLcSQeViPnR+XB2gBvbVk24vGvqQ@mail.gmail.com>
 <CAKwvOd=B=cHpp_XfPTtyVpQyrwQrFZX9SXKw=SJC1VC-VbEwFA@mail.gmail.com>
 <20210225213300.GF380@zn.tnic>
 <CAKwvOdkKjOb8fS7NgFxvAwEQTp3fPjenhvehnjh5xRw=HevQ=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkKjOb8fS7NgFxvAwEQTp3fPjenhvehnjh5xRw=HevQ=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 01:58:48PM -0800, Nick Desaulniers wrote:
> The config that reproduces it wasn't shared here; I wouldn't be
> surprised if this was found via randconfig that enabled some config
> that led to excessive code bloat somewhere somehow.

I'm sceptical it is the .config. As I said, those single function calls
which I could replace by hand - the wrappers simply make the code
cleaner. They could just as well be macros FWIW and then the inlining
will be practically forced at preprocess time.

> Oh, I don't expect everyone to; just leaving breadcrumbs showing other
> people on thread how to fish. ;)

Yap, that's appreciated.

> Sure, it doesn't really matter to me which way this is fixed.  I
> personally prefer placing functions in the correct sections and
> letting the compiler be flexible, since if all of this is to satisfy
> some randconfig then __always_inline is making a decision for all
> configs, but perhaps it doesn't matter.

I hope.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

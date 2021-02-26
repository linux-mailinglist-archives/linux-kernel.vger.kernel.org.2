Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD79232633E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhBZNZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:25:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhBZNZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:25:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 479C164F0D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614345878;
        bh=ZggQuYDis+WExXH0WPvGd1f/LuR071utwl06CJBWi4U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PhSqY1xBid9UAYR/0IDUFmcoZHTcvWoX+E2YUIQiD7ejvUwTVMy9xVwL+06oI8XEM
         hpOfisMLouTm5RFNMvIaeZ7Izx6p2bS34TvU7a0OOrhhZu7cCAs78sxTDjkWchhw69
         zdGh8Zi1xL0C+CgkYXAxmmw+5We7IVIBA022x2nCntzQAcu89+jqJPo+FWNi9nP5ra
         thR0BIfoOyLmbdRMek4T2xzkYEAOjk2AVsMABrNrC/MATjrs2suZR3Vk4W6VcFIVQs
         S1DGeAgd0QnCO669gb7StSXkIoRpQA5KwftKfPzBTOV9rlYvi7bCNPcF1YIFWvSf+/
         Rswij8afBu/bw==
Received: by mail-oo1-f45.google.com with SMTP id n19so2162811ooj.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 05:24:38 -0800 (PST)
X-Gm-Message-State: AOAM533Mg9CgohjbbKvIjwA5jIU9vCA7G1d22/TwHI58g0r+waLt/rXf
        sNx1vNX2hxtbA7kEOiJLOp+ugAQMdLNt0QfPHUk=
X-Google-Smtp-Source: ABdhPJxn1dpvF15ONJ7XQi92ih/LAhYMcjLIfp7aGaQJfT5cw8mu7io7mXTutw1XvhYLnCE91bmoSn+3UAdsJZ/Sbfs=
X-Received: by 2002:a4a:8ed2:: with SMTP id c18mr2274361ool.66.1614345877422;
 Fri, 26 Feb 2021 05:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20210225112247.2240389-1-arnd@kernel.org> <20210225114533.GA380@zn.tnic>
 <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
 <20210225124218.GC380@zn.tnic> <CAK8P3a1ZiUHRxKr=SFgEFETLcSQeViPnR+XB2gBvbVk24vGvqQ@mail.gmail.com>
 <CAKwvOd=B=cHpp_XfPTtyVpQyrwQrFZX9SXKw=SJC1VC-VbEwFA@mail.gmail.com>
 <20210225213300.GF380@zn.tnic> <CAKwvOdkKjOb8fS7NgFxvAwEQTp3fPjenhvehnjh5xRw=HevQ=Q@mail.gmail.com>
 <20210226081327.GB19284@zn.tnic>
In-Reply-To: <20210226081327.GB19284@zn.tnic>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Feb 2021 14:24:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a21A4nAraeUeabNjHe3QNc+sX6XFYTHA=K0wX1nV-Qetg@mail.gmail.com>
Message-ID: <CAK8P3a21A4nAraeUeabNjHe3QNc+sX6XFYTHA=K0wX1nV-Qetg@mail.gmail.com>
Subject: Re: [PATCH] x86: mark some mpspec inline functions as __init
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 9:13 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Feb 25, 2021 at 01:58:48PM -0800, Nick Desaulniers wrote:
> > The config that reproduces it wasn't shared here; I wouldn't be
> > surprised if this was found via randconfig that enabled some config
> > that led to excessive code bloat somewhere somehow.
>
> I'm sceptical it is the .config. As I said, those single function calls
> which I could replace by hand - the wrappers simply make the code
> cleaner. They could just as well be macros FWIW and then the inlining
> will be practically forced at preprocess time.

I managed to track down the configurations: This particular function is
not inlined whenever CONFIG_UBSAN_OBJECT_SIZE is enabled
and CONFIG_UBSAN_TRAP is disabled, plus obviously any
configuration option that is needed to build the file.

     Arnd

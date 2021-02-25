Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FDF324FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBYMTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:19:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhBYMTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:19:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DE3164F19
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614255518;
        bh=ye7gY2SoV8buO1J6kbzjZyFZ7oX5EX1wscCeEz3vz5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XRVTGE5IopMR+I4hFFusN9YVlRMlpwUNdeeih2pOj0rbHsF4KY3ElLD6OQbArEpDj
         6bhj97v/kEh/hJlxJbOGtsakI8Ska9UL+uGlZjGZ1tA/sRKQ4GS4/Xud9HbRmedhBI
         SIyHxa7qKLV9mWa67Ltnr8d3Ils+gNnCKVN7trbcUtcINWcSmi2AOAJiXqR+ZTdztO
         Xkv6Je5VntgMs7Vexb4/XqcjOgP4ES7q/aKkzrsF2QqLqVN6uA73tzmVfh/Bubn4zK
         frrZMyacgPghMoEOdVv3QjlUEWOUZBrSy2U7mjUHWDbVP7zm0VwzMEyFSROwXKHR8Q
         DIQYZ9x2JCTgA==
Received: by mail-oi1-f178.google.com with SMTP id h17so5871593oih.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 04:18:38 -0800 (PST)
X-Gm-Message-State: AOAM533qerTjpslSZjMqmHhmy/dHeY2lPeG/puh6exT8vgog+i/LN11e
        pfNmnMzzOACr+qDzUqovesxp78G9bZT4gkX6zjI=
X-Google-Smtp-Source: ABdhPJwr1Q0cBDNGVta5trclkTx0pQGHYyPn8k7aHyBkDrUgJWMnXPUmUNEQOGDgam4vepnIlefwfd8bxDNfJ1GQeLQ=
X-Received: by 2002:aca:4a47:: with SMTP id x68mr1574795oia.67.1614255517403;
 Thu, 25 Feb 2021 04:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20210225112247.2240389-1-arnd@kernel.org> <20210225114533.GA380@zn.tnic>
In-Reply-To: <20210225114533.GA380@zn.tnic>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Feb 2021 13:18:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
Message-ID: <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
Subject: Re: [PATCH] x86: mark some mpspec inline functions as __init
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:45 PM Borislav Petkov <bp@alien8.de> wrote:
> On Thu, Feb 25, 2021 at 12:22:41PM +0100, Arnd Bergmann wrote:

> > -static inline void get_smp_config(void)
> > +static inline __init void get_smp_config(void)
>
> __always_inline then I guess.
>
> Not inlining those is just silly.

Either way works correctly, I don't care much, but picked the __init
annotation as it seemed more intuitive. If the compiler decides to
make it out-of-line for whatever reason, I see no point in telling it
otherwise, even though I agree it is a bit silly.

Should I send the patch with __always_inline?

      Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7260E325993
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhBYWW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233136AbhBYWRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:17:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F41EF64E83
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614291397;
        bh=OZb11bbSfRwWZtKcyANdwJ8p4BGWaqUwc4r6noV1dY0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Foyvf7WVY0FKdUh2vU0PLzk9NmexSE/EiqVxFO8YvIUJ2LwL24Iu4tejwTSzkU9Nc
         ZlVYlYh5lX8Ty5Hn6p1gxJ+SxW6KKMyWR2BWNN2YhEjoPWw9XOBfVoET50PpdwDIhy
         lzC8zFJikJgZ/9hPjRdnYStjdmAQ5G0bednFRDEW2kYVw4I6rJ8jlIjb3eR5HwZvks
         F8aErweXdEPl0Qs9oLkOYZ5zCk1FbFPzxBSNogppVeOHhb0W1aJVEqduhUkFUoSgU2
         2WHHNI5B3VigLOmxyD4FF+eLKIoQY52d0MY4NLHOEGq0ONtaN6c/AuCzHb/IrZ7fCd
         esT2KZny5uNHw==
Received: by mail-oo1-f43.google.com with SMTP id n19so1747531ooj.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:16:36 -0800 (PST)
X-Gm-Message-State: AOAM530zhzTAewja+ukM8v1ngRqSmWwQZEmGfJek6Rhu4EAl3htQpfUB
        v/77A84K1ZqMZ9+Oqw0VsaHAtcBbcGQxOt7tolU=
X-Google-Smtp-Source: ABdhPJyf2ogScImTozyMY9LjxjFKwBqZp9deZMcbmGuxPR05W4S2XW5uzdLDASzNJKVvN4gMrcSLuYk9csKu4PgoNxM=
X-Received: by 2002:a4a:304a:: with SMTP id z10mr101534ooz.26.1614291396149;
 Thu, 25 Feb 2021 14:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20210225112247.2240389-1-arnd@kernel.org> <20210225114533.GA380@zn.tnic>
 <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
 <20210225124218.GC380@zn.tnic> <CAK8P3a1ZiUHRxKr=SFgEFETLcSQeViPnR+XB2gBvbVk24vGvqQ@mail.gmail.com>
 <CAKwvOd=B=cHpp_XfPTtyVpQyrwQrFZX9SXKw=SJC1VC-VbEwFA@mail.gmail.com>
 <20210225213300.GF380@zn.tnic> <CAKwvOdkKjOb8fS7NgFxvAwEQTp3fPjenhvehnjh5xRw=HevQ=Q@mail.gmail.com>
In-Reply-To: <CAKwvOdkKjOb8fS7NgFxvAwEQTp3fPjenhvehnjh5xRw=HevQ=Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Feb 2021 23:16:20 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3EiHxE7KVNnduJAYYwJWrMq2h+CpsoxTC1mEqOGnV2rg@mail.gmail.com>
Message-ID: <CAK8P3a3EiHxE7KVNnduJAYYwJWrMq2h+CpsoxTC1mEqOGnV2rg@mail.gmail.com>
Subject: Re: [PATCH] x86: mark some mpspec inline functions as __init
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
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

On Thu, Feb 25, 2021 at 10:59 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> On Thu, Feb 25, 2021 at 1:33 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > But apparently the cost model has decided that this is not inlineable.
> > Maybe because that function ptr is assigned at boot time and that
> > somehow gets the cost model to give it a very high (or low) value. Or
> > maybe because the wrappers are calling through a variable - the x86_init
> > thing - which is in a different section and that confuses the inliner.
> > Or whatever - totally speculating here.
>
> The config that reproduces it wasn't shared here; I wouldn't be
> surprised if this was found via randconfig that enabled some config
> that led to excessive code bloat somewhere somehow.

It was the case in some similar bugfixes I sent, but in this one, the
out-of-line function was fairly trivial -- there is one call to a sanitizer
but that's it:

        .section        .init.text,"ax",@progbits
        .type   early_get_smp_config,@function  # -- Begin function
early_get_smp_config
early_get_smp_config:                   # @early_get_smp_config
# %bb.0:
        callq   __sanitizer_cov_trace_pc@PLT
        movl    $1, %edi
        jmpq    *x86_init+40(%rip)              # TAILCALL
.Lfunc_end4:
        .size   early_get_smp_config, .Lfunc_end4-early_get_smp_config

I've uploaded the .config to https://pastebin.com/CvvEScnQ

This is with today's linux-next-20210225 plus a number of patches
to address other build failures.

          Arnd

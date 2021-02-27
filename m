Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BDA326D7F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 16:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhB0PMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 10:12:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhB0PMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 10:12:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF2E964EF0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 15:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614438698;
        bh=39xvGhqYCYfKAhPPgyBtKVjORFqxpO1/Y9IikQxSD6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jK7xODuw3jnQgwDNGWmBUxqW9RXsL8wnYAzMOfH2fdlBwJc/69VrKNMR1oYHSkq3o
         oCqVsBsAFy2k/B1KBOj8DGh7f3vAjZEs9XfJoZri0jcpPu5c8IIn1QI+CyUh92KReP
         r4MBxSYWn3uEsTN9Ev8h8/uvAvkHyT0u4fnikGlKnFVgJePvzUF5Fl650eNhAo4qxi
         AYDgKXc2hMB+xVbNiItIaHzmeKpcr4DPvh2BbBlKLfzaSwoNQfM2216eGCyYD1BxgN
         AMr19Q7bVwOH4dOsUfZVv8ti5YoDdHU/4Q0xDPbABr1MzNucSvvaz/e7ouo5FupP2+
         DX/32WuvL2Zcg==
Received: by mail-ot1-f42.google.com with SMTP id 40so3661137otu.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 07:11:37 -0800 (PST)
X-Gm-Message-State: AOAM531ssYVEmQufNgsgMVnElIS4Xa3OmovE07eDoXB84fzLcYJJVX5p
        YGeyOrI68kJomeaeIuJn2wBCEx8E/XWnBeq9Mhw=
X-Google-Smtp-Source: ABdhPJwBLwXjdMMuLYHRW77d9y0SUcCRAnn5SkDghlBCT6AGuG09VU+/4yvQshgXQWybv7VmGVGdGJqXcIY1mP1V/I0=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr6847492otq.251.1614438697150;
 Sat, 27 Feb 2021 07:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20210225112247.2240389-1-arnd@kernel.org> <20210225114533.GA380@zn.tnic>
 <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
 <20210225124218.GC380@zn.tnic> <CAK8P3a1ZiUHRxKr=SFgEFETLcSQeViPnR+XB2gBvbVk24vGvqQ@mail.gmail.com>
 <CAKwvOd=B=cHpp_XfPTtyVpQyrwQrFZX9SXKw=SJC1VC-VbEwFA@mail.gmail.com>
 <20210225213300.GF380@zn.tnic> <CAKwvOdkKjOb8fS7NgFxvAwEQTp3fPjenhvehnjh5xRw=HevQ=Q@mail.gmail.com>
 <20210226081327.GB19284@zn.tnic> <CAK8P3a21A4nAraeUeabNjHe3QNc+sX6XFYTHA=K0wX1nV-Qetg@mail.gmail.com>
In-Reply-To: <CAK8P3a21A4nAraeUeabNjHe3QNc+sX6XFYTHA=K0wX1nV-Qetg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 27 Feb 2021 16:11:20 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2niRdnVMMtBrudLAq7s=2c1sH=YC2REwujm5piHmnH6g@mail.gmail.com>
Message-ID: <CAK8P3a2niRdnVMMtBrudLAq7s=2c1sH=YC2REwujm5piHmnH6g@mail.gmail.com>
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

On Fri, Feb 26, 2021 at 2:24 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Feb 26, 2021 at 9:13 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Thu, Feb 25, 2021 at 01:58:48PM -0800, Nick Desaulniers wrote:
> > > The config that reproduces it wasn't shared here; I wouldn't be
> > > surprised if this was found via randconfig that enabled some config
> > > that led to excessive code bloat somewhere somehow.
> >
> > I'm sceptical it is the .config. As I said, those single function calls
> > which I could replace by hand - the wrappers simply make the code
> > cleaner. They could just as well be macros FWIW and then the inlining
> > will be practically forced at preprocess time.
>
> I managed to track down the configurations: This particular function is
> not inlined whenever CONFIG_UBSAN_OBJECT_SIZE is enabled
> and CONFIG_UBSAN_TRAP is disabled, plus obviously any
> configuration option that is needed to build the file.

And I now had another look at the output after reducing the test case
with cvise to:

struct b {
  void *c;
};
struct {
  struct b d;
} extern e;
int f;

__attribute__((__cold__)) int a();
static inline void early_get_smp_config() {(void) e.d.c; }

int g()
{
  if (a())
    return 2;
  a();
  if (f)
    return f;
  a();
  early_get_smp_config();
  return 0;
}

See https://godbolt.org/z/8qbY65

Some observations:

- The early_get_smp_config function literally does nothing in the
   reduced test case, but is still not inlined.

- This happens regardless of target architecture

- It happens in a code path of the calling function that is 'cold'
   at this point, which presumably is an indication to clang that
   any functions called from here are also cold, and not worth
   inlining.

- I have found no indication why -fsanitize=object-size should
  make a difference.

         Arnd

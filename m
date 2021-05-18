Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF123882D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352802AbhERWnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhERWnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:43:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE8C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:41:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l70so8060545pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fex-emu.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2Cd9m3HAXD4prG1F8AREQq6eZbmY8vxuoKsL7ZDrzQ=;
        b=lSvV8sTJaZH2x6iOJSR92xMpFIbq6D4PWZYs/201uhvARUhw8w37oXAjgs+TW6u876
         RFW9SeBCuMdlqdCipkbD2mhk0fCKgvb8kddr8nuikkVj+maUO0hW1ti19pQ+tPD0P8uE
         Roxsz3gkT7v36M5Bc+Bz/ilm1I5ni7Iq6DnTD/nyOsAIWLlo0enFyIoYBrP5IuMFX+LL
         wklJYbEYZSzQ8KhGc8ZFtpuE81Z/Sn8/QF9xuI84qZctQnEClH7Wk5lHeyUIhtpyRA/F
         MPO/qzZykVhN46Qk7M5AoXvSW20YxcsD7tA7fXOw5EertA4HxEZbbq6JwGCESgDRN5oN
         Eg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2Cd9m3HAXD4prG1F8AREQq6eZbmY8vxuoKsL7ZDrzQ=;
        b=FJeay0NJu0RrysENleioSz9k0oCjyHzztB+5JtFGocW46UQ6y1MiAyboXl9JarE8br
         OtA0hjjnztan+IFzm3NJvsJ3o5gQojiAQWZmHCzXqlFDlfa2mEHtjHCTX+2xFM/yvERQ
         2uPqJ4RMYZiZoDBWvgdigCA0qjAFECSskuoEHStmyXIcr2uZjttGzHBY5cKf7ftDc5L/
         eJ3hweJfJfqZwu9/uJYUIMp57z3rRPnkUr53ZGrt6ABEcHCrtcCwRuTwhA+jPUx1FxsT
         fTS9vvjr9OAxyqiI4SpSa5YnOjuIqzoTe7AefDV3nErrvwajMZp0otap/7nls5QQEfju
         J7wQ==
X-Gm-Message-State: AOAM530wrQDGHiGijR+2afu+zT7oCDYEaojo86vW0/3KZ31+4qd+x+IR
        kWhjExlVtNfdtUMnpIHD2NtgEi6S1ffntOFjv2CPrOnxergXJw==
X-Google-Smtp-Source: ABdhPJymr0dVfOGB6otFby+f7jaFDsq9G0xea2z0kCF4Oh90SYmcOez74I4GRA7vUL2MHhdh1+Or6EC0I+KNkkJ5S98=
X-Received: by 2002:a63:571d:: with SMTP id l29mr7472503pgb.179.1621377717611;
 Tue, 18 May 2021 15:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210518090658.9519-1-amanieu@gmail.com> <20210518090658.9519-9-amanieu@gmail.com>
 <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com> <3cb1d369e5e8431284e527e3e74fa6f2@AcuMS.aculab.com>
In-Reply-To: <3cb1d369e5e8431284e527e3e74fa6f2@AcuMS.aculab.com>
From:   Ryan Houdek <houdek.ryan@fex-emu.org>
Date:   Tue, 18 May 2021 15:41:47 -0700
Message-ID: <CAPpY1unphfjA_dEi+aGWmRGGeCwGs8M-P=hf-zf63RxP5dfWJw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat syscalls
To:     David Laight <David.Laight@aculab.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Amanieu d'Antras" <amanieu@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:26 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Arnd Bergmann
> > Sent: 18 May 2021 14:02
> ...
> >
> > I'm still undecided about this approach. It is an easy way to expose the 32-bit
> > ABIs, it mostly copies what x86-64 already does with 32-bit syscalls and
> > it doesn't expose a lot of attack surface that isn't already exposed to normal
> > 32-bit tasks running compat mode.
> >
> > On the other hand, exposing the entire aarch32 syscall set seems both
> > too broad and not broad enough: Half of the system calls behave the
> > exact same way in native and compat mode, so they wouldn't need to
> > be exposed like this, a lot of others are trivially emulated in user space
> > by calling the native versions. The syscalls that are actually hard to do
> > such as ioctl() or the signal handling will work for aarch32 emulation, but
> > they are still insufficient to correctly emulate other 32-bit architectures
> > that have a slightly different ABI. This means the interface is a fairly good
> > fit for Tango, but much less so for FEX.
>
> To my mind because the kernel already contains the emulation code
> there isn't much point trying to replicate it in userspace.
>
> OTOH I think they are trying to emulate x86 system calls not arm ones.
> So the structure layouts don't always match.
> However it is probably a lot nearer than the 64bit arm.

Take care not to conflate the Tango and FEX project needs here.
Tango is doing aarch32->aarch64 translation. So they are translating
aarch32 syscalls.
FEX is doing {x86, x86-64}->aarch64 translation.
The simplicity of the interface helps Tango more than FEX in this regard.
Since FEX likely still needs userspace fixups to *some* structures.

>
> Whether including some of the 'x32' code in an arm kernel will
> help is another matter - it might be a useful source of differences.
>
> Am I also right in thinking that this isn't actually needed as part
> of a 'generic' ARM kernel? Just ones for some specific platforms?

This isn't correct from FEX's viewpoint.
FEX isn't a product that will be shipping on any specific platform; The user
is expected to just install FEX on their ARMv8.0+ device of choice.
After they install FEX then they will freely be able to install *any* x86/x86-64
software and run it.
The primary target is running full fledged games from the user's Steam library,
but it can be anything the user desires.

For context we have users running FEX on Lenovo c630, Apple M1, HardKernel SBCs,
and recently some randomly picked Android devices.

I can't speak on Tango's behalf here since I don't know their user ecosystem.
>
>         David
>
> (Oh - I'm not involved in the project and will probably never use it.)
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

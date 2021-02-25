Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797FF325051
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhBYNVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:21:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhBYNVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:21:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6737E64EFA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614259234;
        bh=V6lFrFiCc18myRG20FZ7T7/+3VLjdKohk8Na6s17aYM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ww48+dEbxU+SpI2u1H5eqBKCG03oyswoiYxf+WhW5f18doygXnMI55medgCPNRJlD
         77C503OmWmQ4ZKNIJFGjFfFZRODAL6jWD9Jt3H1GVZreziBlW5Zmbl66iXP7Rv5JC5
         xFCXB9lnz/VC4R74Us309+VZ+f0+JSS33M4PojGaRHpstOVH+Rgmj1eF5M+GnzRD+c
         sq+rFrh8aiMgM9gQT88C2zOwgs5vF66DZ3OWZdn9WZCctg9SjPCc0JurNmdP9UuI2T
         1d3Lq/fW6U9gCQvc4NLyHlU3BOysgRu2mecDXqbZ+MluQG0ciUWFRGsyTFCEz++daE
         +i8ApiaqnE7yw==
Received: by mail-ot1-f47.google.com with SMTP id x9so1252054otp.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 05:20:34 -0800 (PST)
X-Gm-Message-State: AOAM53109bQSfUnzasaQpP4RBs7JfgAZUlO1vFpWxPGDsAs9dlPEo4/e
        KnMTseeabzALY/F6Wfln1yPURUXhx0Svdi+o4zY=
X-Google-Smtp-Source: ABdhPJxFPulztTsefOYdJiD4+N7ryGVKDldP0YRsoNy3gWo0wH7aaps73HzUz/vtbsVjmL9Lk5GObHnAI+hig8okb20=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr2299490otq.251.1614259233578;
 Thu, 25 Feb 2021 05:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20210225112247.2240389-1-arnd@kernel.org> <20210225114533.GA380@zn.tnic>
 <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com> <20210225124218.GC380@zn.tnic>
In-Reply-To: <20210225124218.GC380@zn.tnic>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Feb 2021 14:20:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ZiUHRxKr=SFgEFETLcSQeViPnR+XB2gBvbVk24vGvqQ@mail.gmail.com>
Message-ID: <CAK8P3a1ZiUHRxKr=SFgEFETLcSQeViPnR+XB2gBvbVk24vGvqQ@mail.gmail.com>
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

On Thu, Feb 25, 2021 at 1:42 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Feb 25, 2021 at 01:18:21PM +0100, Arnd Bergmann wrote:
> > Either way works correctly, I don't care much, but picked the __init
> > annotation as it seemed more intuitive. If the compiler decides to
> > make it out-of-line for whatever reason,
>
> Well, frankly, I see no good reason for not inlining a function body
> which is a single call. And gcc does it just fine. And previous clangs
> did too, so why does clang-13 do it differently?
>
> IOW, could it be that you're fixing something that ain't broke?

Maybe Nick can give some more background here. He mentioned
elsewhere that inlining in clang-13 was completely rewritten and is generally
better than it was before. I'm not sure whether this particular instance
is a case where clang could in fact show an advantage in not inlining
a function, or if this is one case where it got worse and needs to be
tuned better.

In the end, inlining is a bunch of heuristics that are intended help
most of the time, but both (old) clang and gcc get it wrong in cases that
should have been decided the other way. Here we get a new method
that may go wrong in other ways.

        Arnd

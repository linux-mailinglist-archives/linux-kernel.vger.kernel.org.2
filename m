Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20C0344A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhCVQGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231815AbhCVQFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:05:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E91C0619BB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616429114;
        bh=0X15fQV9vc0B/0R7ULURwosyLcIJe2RbM4pBQ8WWBWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GOMbFrMXfyaP1z2BaMy+m0q9vJEavOTMc7B6qIYl3ERRn7S57Bf68NP6IG62PqA0A
         VcU0W7wnz59qw5U0PBmn7uNM0yAqWql/JDETe2kWS3PhQAw2BRUDt9r8I1OzmQl1/h
         K9TPtwG2SZD0dFz/Wid8CG9+pekky0kjNaDjA+NhBhX/fBKNyCRGPAPnT1codJmYdO
         QrlWuOZKcHHTTKrkviNhbCoIM9XHdXPzFhSZbqAPEin2ScXI3r2lxNzvCFye7aA+yA
         tHI8BZTmZnA2EGYyqCSx66gbthHlBW7K/SuPifXvhLAQupl1LQcXzBtoeNHj8eI5Wz
         Frpf9HbqlvciA==
Received: by mail-oi1-f181.google.com with SMTP id z15so13570254oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:05:13 -0700 (PDT)
X-Gm-Message-State: AOAM533PCNQYf/X8yVjs+MbtMg1QZkdwD/aWPDGD1gg/XfTFD3SBEcf5
        bBS67pSY4Zap3GgXfVBbzNdrI9mR+ck5rslKm9g=
X-Google-Smtp-Source: ABdhPJyLWcy/1IYdd/v0j3lGsQiqlyepAkGHWpiAo0UaZQSfKhvC9jlpR9f++3+5ZDTu8T5EZEF3cj2Oec+iQvsc0EU=
X-Received: by 2002:aca:478d:: with SMTP id u135mr277878oia.174.1616429113232;
 Mon, 22 Mar 2021 09:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210319184106.5688-1-mark.rutland@arm.com> <161641697038.3900410.16800195752008718733.b4-ty@kernel.org>
 <CAMj1kXGpFW73sO0viR7_kwuVDgKSUzbn-FeZZi14tYj2DpDjpA@mail.gmail.com>
In-Reply-To: <CAMj1kXGpFW73sO0viR7_kwuVDgKSUzbn-FeZZi14tYj2DpDjpA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 Mar 2021 17:05:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHwuLHDx7yrtRMPjvc+N1YnuUA_H1hOEpnVewK-iNekpg@mail.gmail.com>
Message-ID: <CAMj1kXHwuLHDx7yrtRMPjvc+N1YnuUA_H1hOEpnVewK-iNekpg@mail.gmail.com>
Subject: Re: [PATCH] arm64: stacktrace: don't trace arch_stack_walk()
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Elver <elver@google.com>,
        Chen Jun <chenjun102@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 at 16:57, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 22 Mar 2021 at 14:26, Will Deacon <will@kernel.org> wrote:
> >
> > On Fri, 19 Mar 2021 18:41:06 +0000, Mark Rutland wrote:
> > > We recently converted arm64 to use arch_stack_walk() in commit:
> > >
> > >   5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
> > >
> > > The core stacktrace code expects that (when tracing the current task)
> > > arch_stack_walk() starts a trace at its caller, and does not include
> > > itself in the trace. However, arm64's arch_stack_walk() includes itself,
> > > and so traces include one more entry than callers expect. The core
> > > stacktrace code which calls arch_stack_walk() tries to skip a number of
> > > entries to prevent itself appearing in a trace, and the additional entry
> > > prevents skipping one of the core stacktrace functions, leaving this in
> > > the trace unexpectedly.
> > >
> > > [...]
> >
> > Applied to arm64 (for-next/fixes), thanks!
> >
> > [1/1] arm64: stacktrace: don't trace arch_stack_walk()
> >       https://git.kernel.org/arm64/c/c607ab4f916d
> >
>
> Ehm, did anyone check if the following caveat regarding
> __builtin_frame_address() applies on arm64? (from the GCC man page
> [0])
>
> """
> Calling this function with a nonzero argument can have unpredictable
> effects, including crashing the calling program. As a result, calls
> that are considered unsafe are diagnosed when the -Wframe-address
> option is in effect. Such calls should only be made in debugging
> situations.
> """
>
> [0] https://gcc.gnu.org/onlinedocs/gcc/Return-Address.html

Never mind, failed to read the entire thread. Apologies ...

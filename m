Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190993449F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCVP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhCVP5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:57:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EADA61984
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616428654;
        bh=u7b51sWpqwqXH6Sx4lS4+Eif2845vJ3XWNkOU+9HLE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oIXe3ujSKp5P1n+8kWaGvvXqjUtimKDaep58QAbz1hIbhhZopIGsFVpOdaI2SUS7L
         e3PFv2YHXgBnd0XI1eDQvPLVbuJ0Qs1AgMi6Cj5EGHoRQnNfTY/KTVAqsuR3dfUXI4
         NLWHKi4aB5DnVZ4N2z5oQSTyEns2HbkwGyj04duxIyXhVg4oSu4CkyMYb0e3sXLTk3
         LEgLEr8WYLMVZjbkRl6aev7J7El53VtADntY31odyDOebSOM8nvSxbhQPr15LfyW7M
         P89Z9xq2speZN/hH/fJMWepTo5U55wN6WycG/1tQ9K3JzTOcR3ekGoEjXdtvTy9FYc
         pjdKmDrnguJiw==
Received: by mail-ot1-f48.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so16434416oto.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:57:34 -0700 (PDT)
X-Gm-Message-State: AOAM530k7BV56pkHu7ca7hHlQkD5yGN3FWK+8PVRIabU+8swodH6AZBx
        WObFHWoaW0sxkDOKoWMCz34mYr+jwFP0bq7AKp8=
X-Google-Smtp-Source: ABdhPJwhE/TmTD0iW859cZJEyAC/Zx3v8rCzYxFdTEWDhzwrWl/K+kXRqdgBX3YhFGNzUlPOigLOxQIrAxeWprPxyA0=
X-Received: by 2002:a9d:6e15:: with SMTP id e21mr477241otr.77.1616428653940;
 Mon, 22 Mar 2021 08:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210319184106.5688-1-mark.rutland@arm.com> <161641697038.3900410.16800195752008718733.b4-ty@kernel.org>
In-Reply-To: <161641697038.3900410.16800195752008718733.b4-ty@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 Mar 2021 16:57:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGpFW73sO0viR7_kwuVDgKSUzbn-FeZZi14tYj2DpDjpA@mail.gmail.com>
Message-ID: <CAMj1kXGpFW73sO0viR7_kwuVDgKSUzbn-FeZZi14tYj2DpDjpA@mail.gmail.com>
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

On Mon, 22 Mar 2021 at 14:26, Will Deacon <will@kernel.org> wrote:
>
> On Fri, 19 Mar 2021 18:41:06 +0000, Mark Rutland wrote:
> > We recently converted arm64 to use arch_stack_walk() in commit:
> >
> >   5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
> >
> > The core stacktrace code expects that (when tracing the current task)
> > arch_stack_walk() starts a trace at its caller, and does not include
> > itself in the trace. However, arm64's arch_stack_walk() includes itself,
> > and so traces include one more entry than callers expect. The core
> > stacktrace code which calls arch_stack_walk() tries to skip a number of
> > entries to prevent itself appearing in a trace, and the additional entry
> > prevents skipping one of the core stacktrace functions, leaving this in
> > the trace unexpectedly.
> >
> > [...]
>
> Applied to arm64 (for-next/fixes), thanks!
>
> [1/1] arm64: stacktrace: don't trace arch_stack_walk()
>       https://git.kernel.org/arm64/c/c607ab4f916d
>

Ehm, did anyone check if the following caveat regarding
__builtin_frame_address() applies on arm64? (from the GCC man page
[0])

"""
Calling this function with a nonzero argument can have unpredictable
effects, including crashing the calling program. As a result, calls
that are considered unsafe are diagnosed when the -Wframe-address
option is in effect. Such calls should only be made in debugging
situations.
"""

[0] https://gcc.gnu.org/onlinedocs/gcc/Return-Address.html

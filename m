Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA9A39733C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhFAMdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhFAMdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:33:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7460FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 05:31:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q5so14122296wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdARdu/ZqO0Y93t0urtvX6K3L+hEeAtONtECWBFyOmE=;
        b=osTi6c2IFJqk0oxMcaoJ1ja6osN4/ZeXC+AgkL+6+aPD1dRsPXLa2JI03RYsYB/CFJ
         j24KYhXl4h78NVY6p9Vm6bsWBeQBfmOM1SRRFmnQGr0X7qLID/pLJAh7nJ2C6oDTEvh1
         dxYUX5+XkenW10DViiz8oLiFoiOkcFzbD4pBgeQjkQ57sAFzwcV32lHd1b1rpwItzdve
         fcdP61CgH0xAub0lV23F7EdyOjkZ8ftBX34pIzAC0MTvH3KIaNEnfip+swxuwS2GFm85
         ia+ExVdLHUan9ZZxJJ+pf94FU4HjGlOx5AyDHLdaU0NaG9CBA1x2wIXafK3iTmoiFSwG
         9iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdARdu/ZqO0Y93t0urtvX6K3L+hEeAtONtECWBFyOmE=;
        b=Akcvdjsg/2Z4y8NVJvWCosM4GvJt9N3AjmLlEywCC3dtzMICAdR2i3dVyh3WDK4dPh
         qafNzOgb6RZ1g2b9QS/1mEuc4j6JdD74UUFC3KDN9+dz7ELYi3AcAlGhyg0AxIPxumZK
         nRNoFnhbiZowvbllBVPUY06ji8DTgh9/DAeYw1fK+57pc7nFkIDTbUgnhK6ZBLx+4bKj
         eApl0To3F9DZ/5jQcNPnCIL0DiPfn8H4Njv+bFPQrlJEjgjPJX/9vUUxaZVS4RFLLUxs
         alqBFbRT5AG8Cp9bwg+t8qT5uS1B+p/p/+GkWW2zitXtVOq+T3FPhqcQKnvzi2ST42fc
         yUNg==
X-Gm-Message-State: AOAM531NGYzHzw76M9fcBSN92/G/XeCJjknK+o1jgB6pUstklBqnuCwf
        P1RAPPYlnPsBPuAKpCY7kDy5UEnQX2bPq7QLySc=
X-Google-Smtp-Source: ABdhPJweJPqcAaFv5mQ0FQ6SxILSCalhgWKoO4ne2HLxr+kU9v8j//Jdjwp38Dk4Fdsb5iMpYH2j7ds9A0uRZa8v/Bs=
X-Received: by 2002:adf:82ee:: with SMTP id 101mr21175463wrc.137.1622550691126;
 Tue, 01 Jun 2021 05:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200914150958.2200-1-oli.swede@arm.com> <20200914150958.2200-9-oli.swede@arm.com>
 <CA+sq2CfGu+JPJ9h3Q-nCdmM2erqWbe=p-v_eip-J-R6F2EoXbw@mail.gmail.com> <5156db7f-09a7-b0fa-d246-b024e40775fc@arm.com>
In-Reply-To: <5156db7f-09a7-b0fa-d246-b024e40775fc@arm.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 1 Jun 2021 18:01:20 +0530
Message-ID: <CA+sq2Cdh7xwNh0E9RD0G3GM0fn6Eds0ZdQhGLRqF4AwEw2qdHg@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] arm64: Import latest optimization of memcpy
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Oliver Swede <oli.swede@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        linux-arm-kernel@lists.indradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sunil Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 5:36 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-01 11:03, Sunil Kovvuri wrote:
> > On Mon, Sep 14, 2020 at 8:44 PM Oliver Swede <oli.swede@arm.com> wrote:
> >>
> >> From: Sam Tebbs <sam.tebbs@arm.com>
> >>
> >> Import the latest memcpy implementation into memcpy,
> >> copy_{from, to and in}_user.
> >> The implementation of the user routines is separated into two forms:
> >> one for when UAO is enabled and one for when UAO is disabled, with
> >> the two being chosen between with a runtime patch.
> >> This avoids executing the many NOPs emitted when UAO is disabled.
> >>
> >> The project containing optimized implementations for various library
> >> functions has now been renamed from 'cortex-strings' to
> >> 'optimized-routines', and the new upstream source is
> >> string/aarch64/memcpy.S as of commit 4c175c8be12 in
> >> https://github.com/ARM-software/optimized-routines.
> >>
> >> Signed-off-by: Sam Tebbs <sam.tebbs@arm.com>
> >> [ rm: add UAO fixups, streamline copy_exit paths, expand commit message ]
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> [ os: import newer memcpy algorithm, update commit message ]
> >> Signed-off-by: Oliver Swede <oli.swede@arm.com>
> >> ---
> >>   arch/arm64/include/asm/alternative.h |  36 ---
> >>   arch/arm64/lib/copy_from_user.S      | 113 ++++++--
> >>   arch/arm64/lib/copy_in_user.S        | 129 +++++++--
> >>   arch/arm64/lib/copy_template.S       | 375 +++++++++++++++------------
> >>   arch/arm64/lib/copy_template_user.S  |  24 ++
> >>   arch/arm64/lib/copy_to_user.S        | 112 ++++++--
> >>   arch/arm64/lib/copy_user_fixup.S     |  14 +
> >>   arch/arm64/lib/memcpy.S              |  47 ++--
> >>   8 files changed, 557 insertions(+), 293 deletions(-)
> >>   create mode 100644 arch/arm64/lib/copy_template_user.S
> >>   create mode 100644 arch/arm64/lib/copy_user_fixup.S
> >
> > Do you have any performance data with this patch ?
> > I see these patches are still not pushed to mainline, any reasons ?
>
> Funny you should pick up on the 6-month-old thread days after I've been
> posting new versions of the relevant parts[1] :)

Hmm.. I searched with the subject and didn't find any newer version of patches.
It seems you changed patch subject which I didn't anticipate.

>
> I think this series mostly stalled on the complexity of the usercopy
> parts, which then turned into even more of a moving target anyway, hence
> why I decided to split it up.
>
> > Also curious to know why 128bit registers are not considered, similar to
> > https://android.googlesource.com/platform/bionic.git/+/a71b4c3f144a516826e8ac5b262099b920c49ce0/libc/arch-arm64/generic-neon/bionic/memcpy.S
>
> The overhead of kernel_neon_begin() etc. is significant, and usually
> only worth it in places like the crypto routines where there's enough
> benefit from actual ASIMD computation to outweigh the save/restore cost.
> On smaller cores where the L1 interface is only 128 bits wide anyway
> there is no possible gain in memcpy() throughput to ever offset that
> cost, and even for wider microarchitectures it's only likely to start
> breaking even at relatively large copy sizes. Plus we can't necessarily
> assume the ASIMD registers are even present (apparently the lack of a
> soft-float ABI hasn't stopped people from wanting to run Linux on such
> systems...)
>
> Robin.

Thanks for the info.

>
> [1]
> https://lore.kernel.org/linux-arm-kernel/cover.1622128527.git.robin.murphy@arm.com/
